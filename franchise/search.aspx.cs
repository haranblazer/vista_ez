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
public partial class admin_search : System.Web.UI.Page
{
    utility u = new utility();
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
  
    protected void Page_Load(object sender, EventArgs e)
    {
        lname.Visible = false;
        export.Visible = false;

        if (Session["UserName"] == null)
        {
            Response.Redirect("../Default.aspx");
        }
        
        if (!IsPostBack)
        {                
                BindAutocomplete();
               
        }
    }

    private void BindAutocomplete()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {
            DataTable tbl = new DataTable();
            da = new SqlDataAdapter("select AppMstregno,AppMstLogin,AppmstFName,AppMstLName,AppMstMobile,AppMstCity,AppmstState,panno from appmst where fid=(select franchiseid from franchisemst where username=@atype) order by appmstid", con);
            da.Fill(tbl);
            divUserID.InnerText=divUserName.InnerText =divName.InnerText=divLName.InnerText=divCity.InnerText=divState.InnerText=divMobile.InnerText=divPAN.InnerText=string.Empty;
            foreach (DataRow row in tbl.Rows)
            {
                divUserID.InnerText += row["appmstregno"].ToString().Trim() + ",";
                divUserName.InnerText += row["AppMstLogin"].ToString().Trim() + ",";
                divName.InnerText += row["AppmstFName"].ToString().Trim() + ",";
                divLName.InnerText += row["AppMstLName"].ToString().Trim() + ",";
                divMobile.InnerText += row["AppMstMobile"].ToString().Trim() + ",";
                divCity.InnerText += row["AppMstCity"].ToString().Trim() + ",";
                divState.InnerText += row["AppmstState"].ToString().Trim() + ",";
                divPAN.InnerText += row["panno"].ToString().Trim() + ",";
            }
        }
        catch
        {
        }
        finally
        {
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        go1();
    }
    public void go1()
    {
        da = new SqlDataAdapter("SearchList", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@atype", Session["UserName"].ToString());
        da.SelectCommand.Parameters.AddWithValue("@regno", txtid.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@AppMstLogin", txtuname.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@AppMstFName", txtfname.Text);
        da.SelectCommand.Parameters.AddWithValue("@AppMstLName", txtlname.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@AppMstCity", txtcity.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@AppMstState", txtstate.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@AppMstMobile", txtMobileNo.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@panno", txtPan.Text.Trim());
        
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {

            dgr.DataSource = dt;
            dgr.DataBind();
            export.Visible = true;
        }
        else
        {

            dgr.DataSource = null;
            dgr.DataBind();
        }
    }
    protected void dgr_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditProfile")
        {
            GridViewRow row = dgr.Rows[Convert.ToInt32(e.CommandArgument)];
            LinkButton lnkbtnId = (LinkButton)row.FindControl("lnkbtnId");
            Response.Redirect("edit.aspx?n=" + u.base64Encode(lnkbtnId.Text.Trim()), false);
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        txtuname.Text = txtid.Text = txtstate.Text = txtfname.Text = txtcity.Text =  txtlname.Text = txtPan.Text = string.Empty;
        
    }
   
    public override void VerifyRenderingInServerForm(Control control)
    {



    }

    protected void dgr_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dgr.PageIndex = e.NewPageIndex;
        go1();
    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dgr.Rows.Count > 0)
        {
            dgr.AllowPaging = false;
            dgr.Columns[0].Visible = false;
            go1();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_SearchedMembers.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dgr.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
            utility.MessageBox(this,"Sorry can't export,no record found.");
    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dgr.Rows.Count > 0)
        {
            dgr.AllowPaging = false;
            dgr.Columns[0].Visible = false;
            go1();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_SearchedMembers.doc");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dgr.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
            utility.MessageBox(this,"Sorry can't export,no record found.");
    }
    protected void ibtnPDFExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dgr.Rows.Count > 0)
        {
            dgr.AllowPaging = false;
            dgr.Columns[0].Visible = false;
            go1();

            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_SearchedMembers.pdf");
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
            utility.MessageBox(this,"Sorry can't export,no record found.");
    }
}