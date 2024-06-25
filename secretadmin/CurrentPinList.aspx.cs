using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;

public partial class yesadmin_CurrentPinList : System.Web.UI.Page
{
    string tranid, id;
    utility objUtiliy = new utility();
    SqlDataAdapter da;
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


      
        if (!Page.IsPostBack)
        {

          
                txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                bindGrid();
          
           
        }

    }
    public void bindGrid()
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
            lblMsg.Text = "Invalid date entry.";
            return;
        }
        da = new SqlDataAdapter("CurrentPinDetails", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    
        da.SelectCommand.Parameters.AddWithValue("@mindate", fromDate);
        da.SelectCommand.Parameters.AddWithValue("@maxdate", toDate);
        da.SelectCommand.Parameters.AddWithValue("@pinno", txtpinno.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@regno",txtsearch.Text.Trim());
       
        DataTable table = new DataTable();
        da.Fill(table);
        if (table.Rows.Count > 0)
        {
            //lblUser.Text = table.Rows[0]["allotedto"].ToString();
            ViewState["Count"] = table.Rows.Count;

            //ViewState["dt"] = table;
            gv.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? table.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
        
            gv.DataSource = table;
            gv.DataBind();

        }
        else
        {
            ViewState["Count"] = "0";
            gv.DataSource = null;
            gv.DataBind();
        }
    }
    protected void gv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv.PageIndex = e.NewPageIndex;
        bindGrid();
    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToInt32(Convert.ToString(ViewState["Count"])) > 0)
        {
            gv.PageSize = Convert.ToInt32(Convert.ToString(ViewState["Count"]));
            bindGrid();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "AllotedPinList.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            gv.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            lblMsg.Text = "Can't Export,No Data Found!";
        }

    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToInt32(Convert.ToString(ViewState["Count"])) > 0)
        {
            gv.PageSize = Convert.ToInt32(Convert.ToString(ViewState["Count"]));
            bindGrid();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") +  "AllotedPinList.doc");
            Response.ContentType = "application/vnd.ms-word";
            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            gv.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
        {
            lblMsg.Text = "Can't Export,No Data Found!";
        }


    }
    public override void VerifyRenderingInServerForm(Control control)
    {



    }
    protected void ibtnPDFExport_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToInt32(Convert.ToString(ViewState["Count"])) > 0)
        {
            gv.PageSize = Convert.ToInt32(Convert.ToString(ViewState["Count"]));
            bindGrid();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") +  "AllotedPinList.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            gv.RenderControl(hw);
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
            lblMsg.Text = "Can't Export , No Data Found !";

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        txtpinno.Text = txtsearch.Text = string.Empty;
        
        bindGrid();


       
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindGrid();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

        txtsearch.Text = string.Empty;
        bindGrid();
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        txtpinno.Text = string.Empty;
        bindGrid();
    }
}