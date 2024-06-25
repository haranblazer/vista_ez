using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;

//By <S>
public partial class user_OrderList : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    //By <S>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");

            if (Request.QueryString["Key"] != null)
            {
                ddlStatus.SelectedValue = "0";
                if (Request.QueryString["From"].ToString().Length > 0)
                    txtFromDate.Text = Request.QueryString["From"].ToString();
                if (Request.QueryString["To"].ToString().Length > 0)
                    txtToDate.Text = Request.QueryString["To"].ToString();
            }
            BindGrid();

        }
    }

    /// <summary>
    /// //By <S>
    /// </summary>

    private void BindGrid()
    {
        try
        {
            String fromDate = "", toDate = "";
            if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()))
            {
                try
                {
                    if (txtFromDate.Text.Trim().Length > 0)
                    {
                        String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                        fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                    }
                    if (txtToDate.Text.Trim().Length > 0)
                    {
                        String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                        toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                    }
                }
                catch
                {
                    utility.MessageBox(this, "Invalid date entry2.");
                    return;
                }
            }

            con = new SqlConnection(method.str);
            SqlDataAdapter ad = new SqlDataAdapter("PurchaseOrderList", con);
            ad.SelectCommand.CommandType = CommandType.StoredProcedure;
            ad.SelectCommand.Parameters.AddWithValue("@search", txtSearch.Text.Trim());
            ad.SelectCommand.Parameters.AddWithValue("@min", fromDate);
            ad.SelectCommand.Parameters.AddWithValue("@max", toDate);
            ad.SelectCommand.Parameters.AddWithValue("@userid", "");
            ad.SelectCommand.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            dt = new DataTable();
            ad.Fill(dt);
            DataColumn dcDtl = new DataColumn("tbl", typeof(string));
            dt.Columns.Add(dcDtl);
            foreach (DataRow row in dt.Rows)
            {
                XElement objXml = XElement.Parse(row["dtl"].ToString());
                string strDtl = "<table rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
                strDtl += "<tr><th>Name</th><th>Quantity</th><th>MRP</th><th>BV</th><th>Total</th></tr>";
                foreach (XElement p in objXml.Elements("P"))
                {
                    strDtl += "<tr>";
                    strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("MRP").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("BV").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
                    strDtl += "</tr>";
                }
                strDtl += "</table>";
                row["tbl"] = strDtl;
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();
            if (dt.Rows.Count > 0)
            {
                lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();

                lblTotal.Text += ", Amount: " + (string.IsNullOrEmpty(dt.Compute("sum(amt)", "true").ToString()) ? "0.00" : dt.Compute("sum(amt)", "true").ToString());

            }
        }
        catch (Exception ex)
        {
        }
    }
    /// <summary>
    /// //By <S>
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    /// <summary>
    /// //By <S>
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindGrid();
            GridView1.Columns[10].Visible = GridView1.Columns[14].Visible=GridView1.Columns[15].Visible = GridView1.Columns[16].Visible = false;
            //GridView1.Columns[11].Visible = GridView1.Columns[16].Visible = GridView1.Columns[17].Visible = GridView1.Columns[18].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ViewPO.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");

    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindGrid();
            GridView1.Columns[11].Visible = GridView1.Columns[16].Visible = GridView1.Columns[17].Visible = GridView1.Columns[18].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ViewPO.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "A")
        {

            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            string id = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
            //TextBox txtcomment = (TextBox)row.FindControl("txtcomment");
            Label soldto = (Label)row.FindControl("lblsoldto");
            Label soldby = (Label)row.FindControl("lblsoldby");

            //if (txtcomment.Text == "")
            //{
            //    utility.MessageBox(this, "Please Enter Remarks");
            //    return;
            //}
            con = new SqlConnection(method.str);
            //com = new SqlCommand("addorderremark", con);
            com = new SqlCommand("ApproveFranStockByAdmin", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@srno", id);
            com.Parameters.AddWithValue("@remarks", "");// txtcomment.Text);
            com.Parameters.AddWithValue("@soldto", soldto.Text);
            com.Parameters.AddWithValue("@soldby", "-111");
            com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            string ab = com.Parameters["@flag"].Value.ToString();
            if (ab == "1")
            {
                utility.MessageBox(this, "Remarks Added Successfully");
                con.Close();
                BindGrid();
            }
            else
            {
                utility.MessageBox(this, ab.ToString());
                con.Close();
            }
        }


        if (e.CommandName == "B")
        {

            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            string id = GridView1.DataKeys[row.RowIndex].Values[0].ToString();

            con = new SqlConnection(method.str);
            com = new SqlCommand("ordercancel", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@srno", id);

            com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            string ab = com.Parameters["@flag"].Value.ToString();
            if (ab == "1")
            {
                utility.MessageBox(this, "Order cancel Successfully");
                con.Close();
                BindGrid();
            }
            else
            {
                utility.MessageBox(this, ab.ToString());
                con.Close();
            }
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Label st = e.Row.FindControl("lblSt") as Label;
            Label sb = e.Row.FindControl("lblsoldby") as Label;
            TextBox cmt = e.Row.FindControl("txtcomment") as TextBox;
            Button bt1 = e.Row.FindControl("button1") as Button;
            Button bt2 = e.Row.FindControl("button2") as Button;

            if (st.Text == "2" && sb.Text == "Admin")
            {
                bt1.Enabled = false;
                bt2.Enabled = false;
                cmt.Enabled = false;
            }
            else if (st.Text == "0" && sb.Text == "Admin")
            {
                bt1.Enabled = false;
                cmt.Enabled = false;
                bt2.Enabled = false;
            }
            else if (st.Text == "1" && sb.Text == "Admin")
            {
                bt1.Enabled = true;
                cmt.Enabled = true;
                bt2.Enabled = true;
            }

        }
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
}
