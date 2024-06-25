using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
public partial class tohadmin_NotAllotedPinList : System.Web.UI.Page
{
    int StartIndex;
    SqlCommand cmd = new SqlCommand();    
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
        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            go();
        }
    }
  
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        StartIndex = e.NewPageIndex * dglst.PageSize;
        dglst.PageIndex = e.NewPageIndex;      
        go();        
      
    }    

    protected void btnShow_Click(object sender, EventArgs e)
    {
        go();
    }
    private void go()
    {
        txtSearch.Text = string.Empty;
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

        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter adp = new SqlDataAdapter("select pinsrno,PinNo,PinPassword,convert(varchar(20),activedate,103) as activedate from pinmst where allotedto=0 and CAST(FLOOR(CAST(allotmentdate as float)) as datetime) between @fromDate and @toDate order by pinsrno", con);
        adp.SelectCommand.Parameters.AddWithValue("@fromDate",fromDate);
        adp.SelectCommand.Parameters.AddWithValue("@toDate", toDate);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            dglst.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? ds.Tables[0].Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
            dglst.DataSource = ds;
            dglst.DataBind();         
            ViewState["ds"] = ds;
            lblcount.Text = "No of Records:" + ds.Tables[0].Rows.Count;           
            con.Close();
        }
        else
            ViewState["ds"] = "0";

    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        search1();
    }
    private void search()
    {
        if (ViewState["ds"] != null)
        {
            if (((DataSet)ViewState["ds"]).Tables[0].Rows.Count > 0)
            {
                DataView dView = new DataView(((DataSet)ViewState["ds"]).Tables[0]);
                dView.RowFilter = "pinsrno='" + txtSearch.Text.Trim() + "' ";
                dglst.DataSource = dView;
                dglst.DataBind();
                lblcount.Text = "No of Records:" + ((DataSet)ViewState["ds"]).Tables[0].Rows.Count;
            }
            else
                utility.MessageBox(this,"No data found!");
        }
    }

    private void search1()
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
       
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter adp = new SqlDataAdapter("select pinsrno,PinNo,PinPassword,convert(varchar(20),activedate,103) as activedate from pinmst where pinsrno = @search and allotedto=0 and CAST(FLOOR(CAST(allotmentdate as float)) as datetime) between @fromDate and @toDate order by pinsrno", con);
        adp.SelectCommand.Parameters.AddWithValue("@fromDate", fromDate);
        adp.SelectCommand.Parameters.AddWithValue("@toDate", toDate);
        adp.SelectCommand.Parameters.AddWithValue("@search",txtSearch.Text);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            dglst.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? ds.Tables[0].Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
            dglst.DataSource = ds;
            dglst.DataBind();
            ViewState["ds"] = ds;
            lblcount.Text = "No of Records:" + ds.Tables[0].Rows.Count;            
            txtSearch.Text = string.Empty;
            con.Close();
        }
        else
            ViewState["ds"] = "0";
       

    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (((DataSet)ViewState["ds"]).Tables[0].Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                search1();
            else
                go();

            dglst.PageSize = ((DataSet)ViewState["ds"]).Tables[0].Rows.Count;

            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_NotAllotedPinList.xls");
            Response.Charset = "";
            // If you want the option to open the Excel file without saving than
            // comment out the line below
            // Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dglst.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
            utility.MessageBox(this,"can not export as no data found !");
    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (((DataSet)ViewState["ds"]).Tables[0].Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                search1();
            else
                go();

           
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_NotAllotedPinList.doc");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dglst.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
            utility.MessageBox(this,"can not export as no data found !");
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void ibtnPDFExport_Click(object sender, ImageClickEventArgs e)
    {        
        if (((DataSet)ViewState["ds"]).Tables[0].Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                search1();
            else
                go();

         
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_NotAllotedPinList.pdf");
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        dglst.RenderControl(hw);
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
        if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            search1();
        else
            go();
    }
}
