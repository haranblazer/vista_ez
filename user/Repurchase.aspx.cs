using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Drawing;
using System.Xml;


public partial class user_Repurchase : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    utility objutil;
    XmlDocument xmldoc = new XmlDocument();
    int srno = 0;
    string status = "";
    string monthname = "";
    string strsessionid = "";
    protected string cv;
    protected void Page_Load(object sender, EventArgs e)
    {

        strsessionid = Convert.ToString(Session["userId"]);

        // appid = Convert.ToString(Session["appmstid"]);
        if (strsessionid == "")
        {
            Response.Redirect("~/login.aspx");
        }
        //  checkpage();
        if (!IsPostBack)
        {
            //InsertFunction.CheckAdminlogin();
            txtFromDate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy");
            //  BindUserID();
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
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            string strmin = "";
            string strmax = "";
            try
            {
                if (txtFromDate.Text.Trim().Length > 0)
                    strmin = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo).ToString();
                if (txtToDate.Text.Trim().Length > 0)
                    strmax = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo).ToString();
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }


            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com;
            SqlDataReader sdr;
            con.Open();
            com = new SqlCommand("BV", con);
            com.CommandType = CommandType.StoredProcedure;
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {
                cv = sdr["RPBV"].ToString();
            }
            sdr.Close();
            con.Close();

            double diff = (Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo) - Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo)).TotalDays;
            if (diff > 31)
            {
                utility.MessageBox(this, "Maximum 31 days allowed!");
                GridView1.DataSource = null;
                GridView1.DataBind();
                return;
            }

            con = new SqlConnection(method.str);
            SqlDataAdapter ad = new SqlDataAdapter("userbill", con);
            ad.SelectCommand.CommandType = CommandType.StoredProcedure;
            ad.SelectCommand.Parameters.AddWithValue("@search", strsessionid);
            ad.SelectCommand.Parameters.AddWithValue("@status", 1);
            ad.SelectCommand.Parameters.AddWithValue("@min", strmin);
            ad.SelectCommand.Parameters.AddWithValue("@max", strmax);
            ad.SelectCommand.Parameters.AddWithValue("@billtype", 3);

            //ad.SelectCommand.Parameters.AddWithValue("@billtype", DropDownList2.SelectedValue.ToString() == "1" ? "1" : DropDownList2.SelectedValue.ToString());
            dt = new DataTable();
            ad.Fill(dt);
            DataColumn dcDtl = new DataColumn("tbl", typeof(string));
            DataColumn sr1 = new DataColumn("srno1", typeof(string));
            dt.Columns.Add(dcDtl);
            dt.Columns.Add(sr1);
            int c = 0;
            foreach (DataRow row in dt.Rows)
            {

                DataRow dr = row;
                objutil = new utility();
                row.SetField("srno1", objutil.base64Encode(row["srno"].ToString()));
                string rrrrrrrrrr = row["srno1"].ToString();
                XElement objXml = XElement.Parse(row["dtl"].ToString());
                string strDtl = "<table rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
                strDtl += "<tr><th>Name</th><th>Quantity</th><th>MRP</th><th>"+cv+"</th><th>Total</th></tr>";
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
                lblTotal.Text += ", Gross: " + (string.IsNullOrEmpty(dt.Compute("sum(grossamt)", "true").ToString()) ? "0.00" : dt.Compute("sum(grossamt)", "true").ToString());
                lblTotal.Text += ", Tax: " + (string.IsNullOrEmpty(dt.Compute("sum(taxrs)", "true").ToString()) ? "0.00" : dt.Compute("sum(tax)", "true").ToString());
                lblTotal.Text += ", Net: " + (string.IsNullOrEmpty(dt.Compute("sum(netAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(netAmt)", "true").ToString());
            }

            else
            {
                lblTotal.Text = "";
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

    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //    if (e.CommandName.Equals("cancel"))
    //    {

    //        monthname = GridView1.DataKeys[row.RowIndex].Values[1].ToString();

    //        try
    //        {

    //            //if (DateTime.Now.ToString("MMMM") == monthname)
    //            //{


    //            srno = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Values[0].ToString());

    //            con = new SqlConnection(method.str);

    //            SqlCommand cmd = new SqlCommand("UserBillcancel", con);
    //            cmd.CommandType = CommandType.StoredProcedure;

    //            cmd.Parameters.AddWithValue("@srno", srno);

    //            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;

    //            con.Open();
    //            cmd.ExecuteNonQuery();
    //            status = cmd.Parameters["@flag"].Value.ToString();
    //            if (status == "1")
    //            {

    //                // ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Bill cancel Successfully.');window.location='billinglist.aspx';", true);

    //                utility.MessageBox(this, "Bill Cancel Successfully");
    //                BindGrid();
    //            }

    //            else
    //            {

    //                utility.MessageBox(this, "Bill not Cancel Successfully");
    //                // ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Bill not cancel Successfully.');window.location='billinglist.aspx';", true);
    //                BindGrid();
    //            }


    //            //}

    //            //else
    //            //{
    //            //    utility.MessageBox(this, "Last month Bill can not be cancelled this month");
    //            //}

    //        }

    //        catch
    //        {
    //        }


    //        finally
    //        {
    //            con.Close();
    //        }

    //    }

    //}

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {



        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{

        //    LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkbtnEdit1");
        //    Label ll = (Label)e.Row.FindControl("Label1");
        //    if (int.Parse(ll.Text) == 1)
        //    {
        //        lnkbtn.Enabled = true;

        //    }





        //}

    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {



        // BindGrid1();


    }


    private void BindUserID()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            DataTable dtt = new DataTable();
            da = new SqlDataAdapter("select   franchiseid from franchisemst", con);
            da.Fill(dtt);

            List<string> objProductList = new List<string>(); ;
            String strPrdPrice = string.Empty;
            divUserID.InnerText = string.Empty;
            foreach (DataRow drw in dtt.Rows)
            {
                divUserID.InnerText += drw["franchiseid"].ToString() + ",";
            }
        }
        catch
        {
        }
        finally
        {
        }
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
            GridView1.Columns[10].Visible =  false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductBillingList.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.GridView1.RenderControl(htextw);
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
            GridView1.Columns[10].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductBillingList.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
    }


    public void checkpage()
    {
        SqlDataReader dr;
        con = new SqlConnection(method.str);
        com = new SqlCommand("pageprocess", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@action", "1");
        con.Open();
        dr = com.ExecuteReader();
        while (dr.Read())
        {
            if (dr["billing"].ToString() == "OFF")
            {

                Response.Redirect("~/error.aspx");
            }
        }

        con.Close();
        dr.Close();
    }

    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }

}

