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
using System.Text.RegularExpressions;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
public partial class user_DownLineTurnOver : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
          Response.Redirect("~/login.aspx");
            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.Date.AddDays(-1).ToString("dd/MM/yyyy");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                BindData();
            }
        }
      
    }
    private void BindData()
    {
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        DateTime fromDate = new DateTime();
        DateTime toDate = new DateTime();
        try
        {
            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
        }
        catch
        {
            utility.MessageBox(this,"Invalid date entry.");
            return;
        }
        double diff = (toDate - fromDate).TotalDays;
        if (diff > 31)
        {
            utility.MessageBox(this, "Maximum 31 days allowed!");
            GridView1.DataSource = null;
            GridView1.DataBind();
            LblTotalRecord.Text = string.Empty;
            return;
        }
        con = new SqlConnection(method.str);
        com = new SqlCommand("withdrawReportUser", con);
        com.CommandType = CommandType.StoredProcedure;
        com.CommandTimeout = 9999999;
        com.Parameters.AddWithValue("@fromdate", fromDate);
        com.Parameters.AddWithValue("@Todate", toDate);
        com.Parameters.AddWithValue("@regno", Session["userId"].ToString());
        try
        {
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataTable dt = new DataTable();
            adapter.SelectCommand = com;
            adapter.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                LblTotalRecord.Text = "Total Records :" + dt.Rows.Count.ToString();
                object objSum;
                //objSum = dt.Compute("Sum(dispatch)", "1 = 1");
                objSum = dt.Compute("Sum(wamount)", "1 = 1");
                LblAmount.Text = "Total Amount :" + objSum.ToString();
                //objSum = dt.Compute("sum(tds)", "1=1");
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                LblTotalRecord.Text = LblAmount.Text = string.Empty;
            }

        }
        catch
        {
        }

    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindData();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        BindData();
    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindData();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + " WithdrawlList.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
     else
        {
           utility.MessageBox(this,"Can't Export , No Data Found !");
        }

    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindData();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + " WithdrawlList.doc");
            Response.ContentType = "application/vnd.ms-word";
            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
        {
            utility.MessageBox(this,"Can't Export , No Data Found !");
        }
    }
    protected void ibtnPDFExport_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindData();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + " WithdrawlList.pdf");
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
            utility.MessageBox(this,"Can't Export , No Data Found !");

    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }
}
