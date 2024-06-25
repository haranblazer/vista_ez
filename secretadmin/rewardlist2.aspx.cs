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
using System.Text.RegularExpressions;

public partial class Admin_rewardlist2 : System.Web.UI.Page
{
    SqlDataAdapter da;
    SqlConnection con = new SqlConnection(method.str);
    utility u = new utility();
   static int rowIndex = 0;

   
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
            getreward();
            txtFromDate.Text = DateTime.Now.Date.AddDays(-6).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            shwhid.Visible = false;
        }
       
    }

    
    private void bindGrid()
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
        da = new SqlDataAdapter("reward", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@mindate", fromDate);
        da.SelectCommand.Parameters.AddWithValue("@maxdate", toDate);
        da.SelectCommand.Parameters.AddWithValue("@regno", ""); //txtleader.Text.Trim().ToString());
        da.SelectCommand.Parameters.AddWithValue("@awardid", ddreward.SelectedValue);
        da.SelectCommand.Parameters.AddWithValue("@timelimit",rdolimit.SelectedValue);
        da.SelectCommand.Parameters.AddWithValue("@Status", RadioButtonList1.SelectedValue);
        da.SelectCommand.Parameters.AddWithValue("@ParentId", txtleader.Text.Trim().ToString());
        DataTable table = new DataTable();
        da.Fill(table);
        if (table.Rows.Count > 0)
        {
            ViewState["dt"] = table;
            if (RadioButtonList1.SelectedValue == "0")
            {
                dglst.Columns[11].Visible = false;
                dglst.DataSource = table;
                dglst.DataBind();
            }
            else
            {
                dglst.Columns[11].Visible = true;
                dglst.DataSource = table;
                dglst.DataBind();
            }
            
            shwhid.Visible = true;
        }
        else
        {
            
            shwhid.Visible = false;
            dglst.DataSource = null;
            dglst.DataBind();
        }
       
    }

    public void getreward()
    {
        DataTable dt = new DataTable();
        utility objutl = new utility();
        dt = objutl.Getreward();
        ddreward.DataSource = dt;

        ddreward.DataTextField = dt.Columns["Name"].ToString();
        ddreward.DataValueField = dt.Columns["rewardrank"].ToString();
        ddreward.DataBind();
    }
    
    
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        dglst.PageIndex = e.NewPageIndex;
        bindGrid();

    }
    protected void btnlist_Click(object sender, EventArgs e)
    {
        bindGrid();
      
    }
    protected void ddreward_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindGrid();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            bindGrid();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_paidlist.xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dglst.RenderControl(htmlWrite);
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
        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            bindGrid();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_paidlist.doc");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dglst.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }


    protected void imgbtnpdf_Click(object sender, ImageClickEventArgs e)
    {
        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            bindGrid();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_SponsorList.pdf");
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
            utility.MessageBox(this, "can not export as no data found !");
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in dglst.Rows)
        {
            string a = row.Cells[1].Text;
            
             TextBox box1 = (TextBox)dglst.Rows[rowIndex].Cells[1].FindControl("txtRemarks");
             rowIndex++;
            
           string b= box1.Text;
           SqlCommand cmd = new SqlCommand("update tblreward set comment='"+box1.Text+"',isGiven=1  where appmstregno='"+a+"' "  , con);
           con.Open();
           cmd.ExecuteNonQuery();
          
           con.Close();
           
        }
        utility.MessageBox(this, "Remarks Inserted Successfully");
        rowIndex = 0;
    }
   
    
}