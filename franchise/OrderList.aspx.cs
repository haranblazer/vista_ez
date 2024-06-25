using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Default.aspx");
        }
        if (!IsPostBack)
        {
            //InsertFunction.CheckAdminlogin();
            txtFromDate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy");
            BindGrid();
            
        }
    }

    //private void BindUserID()
    //{
    //    con = new SqlConnection(method.str);
    //    SqlDataAdapter da = new SqlDataAdapter();
    //    //ViewState["Count"] = null;
    //    try
    //    {
    //        DataTable dtt = new DataTable();
    //        da = new SqlDataAdapter("select appmstregno,appmstfname from appmst", con);
    //        da.SelectCommand.Parameters.AddWithValue("@uname", Session["UserName"].ToString());
    //        da.Fill(dtt);

    //        List<string> objProductList = new List<string>(); ;
    //        String strPrdPrice = string.Empty;
    //        divUserID.InnerText = string.Empty;
    //        foreach (DataRow drw in dtt.Rows)
    //        {
    //            divUserID.InnerText += drw["appmstregno"].ToString() + ",";
    //        }
    //    }
    //    catch
    //    {
    //    }
    //    finally
    //    {
    //    }
    //}


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
                utility.MessageBox(this,"Invalid date entry.");
                return;
            }

            double datedays = (Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo) - Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo)).TotalDays;
            if (datedays > 31)
            {
                utility.MessageBox(this, "Maximum 31 days allowed");
                GridView1.DataSource = null;
                GridView1.DataBind();
                return;
            }

            //string str = "%" + txtSearch.Text + "%";
            con = new SqlConnection(method.str);

            SqlDataAdapter ad = new SqlDataAdapter("PurchaseOrderList", con);
            ad.SelectCommand.CommandType = CommandType.StoredProcedure;
            ad.SelectCommand.Parameters.AddWithValue("@search", "");
            ad.SelectCommand.Parameters.AddWithValue("@min", strmin);
            ad.SelectCommand.Parameters.AddWithValue("@max", strmax);
            ad.SelectCommand.Parameters.AddWithValue("@userid", Session["franchiseid"].ToString());
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

            else
            {
                lblTotal.Text = "No Data";
            }
        }
        catch(Exception ex)
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
            GridView1.Columns[9].Visible = GridView1.Columns[11].Visible=false;
            BindGrid();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ViewPoList.xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            this.GridView1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            GridView1.Columns[9].Visible= GridView1.Columns[11].Visible=false;
            BindGrid();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ViewPoList.doc");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            this.GridView1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }


    public string base64Encode(string sData)
    {
        try
        {
            byte[] encData_byte = new byte[sData.Length];
            encData_byte = System.Text.Encoding.UTF8.GetBytes(sData);
            string encodedData = Convert.ToBase64String(encData_byte);
            return encodedData;
        }
        catch
        {
            return "";

        }
    }
}
