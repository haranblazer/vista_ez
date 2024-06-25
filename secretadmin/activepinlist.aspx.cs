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
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
public partial class admin_activepinlist : System.Web.UI.Page
{
    SqlDataAdapter da;
    SqlConnection con = new SqlConnection(method.str);
    utility objUtiliy = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetAllowResponseInBrowserHistory(true);
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
        if (!Page.IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            bindGrid();
        } 
    }
    private void bindGrid()
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
            lblMsg.Text = "Invalid date entry.";
            return;
        }
        da = new SqlDataAdapter("getPinAllotedUsers", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@mindate", fromDate);
        da.SelectCommand.Parameters.AddWithValue("@maxdate", toDate);
        da.SelectCommand.Parameters.AddWithValue("@type", "cl");
        da.SelectCommand.Parameters.AddWithValue("@ptype", ddlPinType.SelectedItem.Value);
        DataTable table = new DataTable();
        da.Fill(table);
        if (table.Rows.Count > 0)
        {
            ViewState["dt"] = table;
            gvActivePinList.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? table.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
            gvActivePinList.DataSource = table;
            gvActivePinList.DataBind();
        }
        else
        {
            gvActivePinList.DataSource = null;
            gvActivePinList.DataBind();
        }
    }

    private void search()
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
        da = new SqlDataAdapter("getPinAllotedUsers", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@mindate", fromDate);
        da.SelectCommand.Parameters.AddWithValue("@maxdate", toDate);
        da.SelectCommand.Parameters.AddWithValue("@UserId", txtSearch.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@type", "s");
        da.SelectCommand.Parameters.AddWithValue("@ptype", ddlPinType.SelectedItem.Value);
        DataTable table = new DataTable();
        da.Fill(table);
        if (table.Rows.Count > 0)
        {
            ViewState["dt"] = table;
            gvActivePinList.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? table.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
            gvActivePinList.DataSource = table;
            gvActivePinList.DataBind();
        }
        else
        {
            gvActivePinList.DataSource = null;
            gvActivePinList.DataBind();
        }
    }

    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindGrid();
    }
    protected void gvActivePinList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvActivePinList.PageIndex = e.NewPageIndex;
        bindGrid();
    }
   
    protected void btSearch_Click(object sender, EventArgs e)
    {
        search();
    }   
    protected void Button1_Click(object sender, EventArgs e)
    {
        bindGrid();
    }
    protected void gvActivePinList_RowEditing(object sender, GridViewEditEventArgs e)
    {
        Response.Redirect("PinDetails.aspx?n=" + objUtiliy.base64Encode(gvActivePinList.DataKeys[e.NewEditIndex].Values[0].ToString()) + "&id=" + objUtiliy.base64Encode(gvActivePinList.DataKeys[e.NewEditIndex].Values[1].ToString()), false);
    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (((DataTable)ViewState["dt"]).Rows.Count > 0)
        {
            gvActivePinList.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                search();
            else
                bindGrid();
            gvActivePinList.Columns[7].Visible = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ActivePinList.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            gvActivePinList.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
            lblMsg.Text = "Sorry can't export,no record found.";

    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (((DataTable)ViewState["dt"]).Rows.Count > 0)
        {
            gvActivePinList.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                search();
            else
                bindGrid();
            gvActivePinList.Columns[6].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ActivePinList.doc");
            Response.ContentType = "application/vnd.ms-word";
            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            gvActivePinList.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }
        else
        {
            lblMsg.Text = "Can't Export,No Data Found!";
        }
    }
    protected void ibtnPDFExport_Click(object sender, ImageClickEventArgs e)
    {
        if (((DataTable)ViewState["dt"]).Rows.Count > 0)
        {
            gvActivePinList.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                search();
            else
                bindGrid();
            gvActivePinList.Columns[6].Visible = false;
            gvActivePinList.AllowPaging = false;
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ActivePinList.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            gvActivePinList.RenderControl(hw);
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
            lblMsg.Text = "can not export as no data found !";
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void ddlPinType_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindGrid();
    }
}
