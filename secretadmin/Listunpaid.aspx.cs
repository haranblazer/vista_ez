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
public partial class admin_Listunpaid : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    static DataTable t = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        
        if (!IsPostBack)
        {

            bind();

        }
    }
    public void bind()
    {
        string qstr = "select AppMstRegNo,AppMstFName,appmstTitle+space(1)+AppMstFName as name,SponsorID,ParentId,Joinfor,appmstpaid=case appmstpaid when 0 then 'UnPaid' when 1 then 'Paid' end from appmst where  appmstpaid='0' order by appmstid";
        da = new SqlDataAdapter(qstr, con);
        t = new DataTable();
        da.Fill(t);
        if (t.Rows.Count > 0)
        {
            Label1.Text = "No of Records :" + t.Rows.Count.ToString();
            GridView1.DataSource = t;
            GridView1.DataBind();

        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();            

        }
    }
   
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (txtSearch.Text.Trim() == "")
             utility.MessageBox(this,"Blank User Id !");
        else
        {
            int index=0;
            int i = 0;
            for ( i = 0; i < t.Rows.Count; i++)
            {
                if (txtSearch.Text.Trim().ToLower() == t.Rows[i][0].ToString().Trim().ToLower())
                {
                    int newpageindex=(i / GridView1.PageSize);
                    GridViewPageEventArgs a = new GridViewPageEventArgs(newpageindex);
                    object s=new object();
                    GridView1_PageIndexChanging(s,a);
                    index=i%GridView1.PageSize;
                    GridView1.Rows[index].BackColor = System.Drawing.Color.Thistle;
                     utility.MessageBox(this,"Found");
                    break;
                }
            }
            if (i == t.Rows.Count)
            {
               utility.MessageBox(this,"No Match Found !");
               
            }
            
        }
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            bind();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_unpaidlist.xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView1.RenderControl(htmlWrite);
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
            bind();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_unpaidlist.doc");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView1.RenderControl(htmlWrite);
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
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            bind();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_unpaidlist.pdf");
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
            utility.MessageBox(this, "Can't export as no data found.");
    }
}
