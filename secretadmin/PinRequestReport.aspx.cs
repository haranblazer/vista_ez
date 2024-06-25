using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Text;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.Text.RegularExpressions;

public partial class user_PinRequestReport : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    utility obj = new utility();
    DataUtility DataUtil = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminloginInside();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
            if (!IsPostBack)
            {
                txtFromdate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
                txtTodate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                ServiceBindData();
            }
        
    }

    private void ServiceBindData()
    {
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";

        DateTime from;
        DateTime to;
        try
        {
            from = Convert.ToDateTime(txtFromdate.Text.Trim(), dateInfo);
            to = Convert.ToDateTime(txtTodate.Text.Trim(), dateInfo);
        }
        catch
        {
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }

        con = new SqlConnection(method.str);
        //com = new SqlCommand("PinRequestApproved", con);
        //com.CommandType = CommandType.StoredProcedure;
        //com.CommandTimeout = 9999999;
        //com.Parameters.AddWithValue("@fromdate", "11/02/2012 12:00:00.000");
        //com.Parameters.AddWithValue("@Todate", "11/02/2014 12:00:00.000");
        //com.Parameters.AddWithValue("@regno", Session["userId"].ToString());

        try
        {
            con = new SqlConnection(method.str);
            SqlDataAdapter adapter = new SqlDataAdapter("PinRequestApproved",con);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@fromdate",from );
            adapter.SelectCommand.Parameters.AddWithValue("@Todate",to);
            adapter.SelectCommand.Parameters.AddWithValue("@regno", null);
            DataTable dt = new DataTable();
            //adapter.SelectCommand = com;
            adapter.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                LblTotalRecord.Text = "Total record :" + dt.Rows.Count.ToString();
                object objSum;
                objSum = dt.Compute("Sum(amt)", "1 = 1");
                //LblAmount.Text = "Total Amount :" + (string.IsNullOrEmpty(objSum.ToString()) ? "0" : objSum.ToString());
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        catch
        {
        }

    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
       
        
            ServiceBindData();
        
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        ServiceBindData();
     }

    protected void imgbtnExcel_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            ServiceBindData();
            GridView1.AllowPaging = false;
            //GridView1.Columns[7].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else

            utility.MessageBox(this, "record not found,can not export.");
    }
    protected void imgbtnWord_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
           // GridView1.Columns[7].Visible = false;
            ServiceBindData();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else

            utility.MessageBox(this, "record not found,can not export.");
    }

    protected void imgbtnPdf_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            ServiceBindData();
            //GridView1.Columns[7].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.pdf");
            Response.ContentType = "application/pdf";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            GridView1.RenderControl(hw);
            StringReader sr = new StringReader(Regex.Replace(sw.ToString(), "</?(a|A).*?>", ""));
            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();
            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }
        else
            utility.MessageBox(this, "record not found,can not export.");
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Aprove")
        {
          DataTable dt=  DataUtil.GetDataTable("select AppMstRegno,noofpin,productid,pintype from PinRequestMst where srno="+e.CommandArgument.ToString());
          Response.Redirect("UpgradePin.aspx?r=" + obj.base64Encode(e.CommandArgument.ToString()) + "&s=" + obj.base64Encode(dt.Rows[0]["AppMstRegno"].ToString().Trim()) + "&n=" + obj.base64Encode(dt.Rows[0]["noofpin"].ToString().Trim()) + "&p=" + obj.base64Encode(dt.Rows[0]["productid"].ToString().Trim())+"&PT=" + obj.base64Encode(dt.Rows[0]["pintype"].ToString().Trim()));
        }
        else if (e.CommandName == "Reject")
        {
            try
            {
                con = new SqlConnection(method.str);
                com = new SqlCommand("update PinRequestMst set status=2 where srno=@srno", con);
                con.Open();
                com.Parameters.AddWithValue("@srno", Convert.ToInt32(e.CommandArgument));
                int r = com.ExecuteNonQuery();
                if (r > 0)
                {
                    utility.MessageBox(this, "Request Rejected");
                }
                con.Close();
            }
            catch { }
        }
    }
}
