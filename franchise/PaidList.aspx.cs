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
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Text.RegularExpressions;

public partial class admin_PaidList : System.Web.UI.Page
{
    DataTable t1 = new DataTable();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserName"] == null)
        {
            Response.Redirect("Default.aspx");
        }
       
         if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            go1();

        }

        

    }
    public void go1()
    {
        try
        {

            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();

            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {
                string qstr = "select appmstid,AppMstregno,appmstaddress1,appmstprimaryphone,SponsorID,parentid,Appmsttitle+AppmstFName+AppmstLName as name,AppMstCity,AppMstState,AppMstDOJ=CONVERT(char(20),AppMstDOJ,103),Joinfor as jp,Joinfor, AppMstMobile,appmstpaid=case appmstpaid when 0 then 'UnPaid' when 1 then 'Paid' end from AppMst where CAST(FLOOR(CAST(AppMstDOJ as float)) as datetime) between CAST(FLOOR(CAST(@mindate as float)) as datetime)  and CAST(FLOOR(CAST(@maxdate as float)) as datetime)  and appmstpaid=1 and fid=(select franchiseid from franchisemst where username=@atype) order by AppMstid";
                com = new SqlCommand(qstr, con);
                com.Parameters.AddWithValue("@mindate", fromDate);
                com.Parameters.AddWithValue("@maxdate", toDate);
                com.Parameters.AddWithValue("@atype", Session["UserName"].ToString());
                da = new SqlDataAdapter(com);
                DataTable t = new DataTable();
                da.Fill(t);

                if (t.Rows.Count > 0)
                {
                    Label2.Text = "No of Records :" + t.Rows.Count.ToString();
                    dglst.DataSource = t;
                    dglst.DataBind();

                }
                else
                {
                    dglst.DataSource = null;
                    dglst.DataBind();
                }

            }
            else
            {
                dglst.DataSource = null;
                dglst.DataBind();
                utility.MessageBox(this, "Invalid date");

            }
        }
        catch
        {
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        go1();

    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        dglst.PageIndex = e.NewPageIndex;
        go1();

    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    } 

    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            go1();
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
            go1();
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
    //protected void imgbtnpdf_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dglst.Rows.Count > 0)
    //    {
    //        dglst.AllowPaging = false;
    //        go1();
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_paidlist.pdf");
    //        Response.ContentType = "application/pdf";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        StringWriter sw = new StringWriter();
    //        HtmlTextWriter hw = new HtmlTextWriter(sw);
    //        dglst.RenderControl(hw);
    //        StringReader sr = new StringReader(Regex.Replace(sw.ToString(), "</?(a|A).*?>", ""));
    //        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
    //        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
    //        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
    //        pdfDoc.Open();
    //        htmlparser.Parse(sr);
    //        pdfDoc.Close();
    //        Response.Write(pdfDoc);
    //        Response.End();
    //    }
    //    else
    //        utility.MessageBox(this, "Can't export as no data found.");
    //}
}
