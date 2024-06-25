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
using System.Linq;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
public partial class admin_search : System.Web.UI.Page
{
    utility u = new utility();
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminlogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    public void BindGrid()
    {
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        string  strmin="";
        string strmax="";
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
        string str = "%" + txtSearch.Text + "%";
        DataTable t = u.searchPin(str, strmin, strmax);
        if (t.Rows.Count > 0)
        {

            lblCount.Text = "Total: " + t.Rows.Count.ToString();
            dgr.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? t.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
            dgr.DataSource = t;
            dgr.DataBind();
        }
        else
        {
            dgr.DataSource =null;
            dgr.DataBind();
        }
    } 
    
    public override void VerifyRenderingInServerForm(Control control)
    {
        
    }
    protected void dgr_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dgr.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    { 
        if (dgr.Rows.Count > 0)
        {         
        dgr.AllowPaging = false;
        //dgr.Columns[10].Visible = false;
        BindGrid();
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_PinList.xls");
        Response.Charset = "";       
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        dgr.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
        }
        else
        utility.MessageBox(this,"can not export as no data found !");
    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dgr.Rows.Count > 0)
        {
            dgr.AllowPaging = false;
            //dgr.Columns[10].Visible = false;
            BindGrid();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_PinList.doc");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dgr.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
            utility.MessageBox(this,"can not export as no data found !");
    }
    protected void ibtnPDFExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dgr.Rows.Count > 0)
        {
            dgr.AllowPaging = false;
            //dgr.Columns[10].Visible = false;
            BindGrid();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_PinList.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            dgr.RenderControl(hw);
            StringReader sr = new StringReader(sw.ToString());
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
            utility.MessageBox(this,"can not export as no data found !");

    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
}