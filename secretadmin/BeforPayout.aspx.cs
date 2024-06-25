using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
public partial class winneradmin_BeforPayout : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    DataTable t = new DataTable();
    double total = 0;
    decimal grdTotal = 0;
    double totalbinaryamount=0;
    double totalDirectAmount=0;
    double totalCAmount = 0;
    double totalRAmount = 0;
    double totalAmount = 0;
    double pagetotal = 0;

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
            txtFromDate.Text = DateTime.Now.Date.AddDays(-6).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            go(); 
            BindUserID();

        }
    }
    private void BindUserID()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {
            DataTable tbl = new DataTable();
            da = new SqlDataAdapter("select appmstregno from appmst where appmstactivate=1 order by appmstid", con);
            da.Fill(tbl);
            divUserID.InnerText = string.Empty;
            foreach (DataRow row in tbl.Rows)
            {
                divUserID.InnerText += row["appmstregno"].ToString().Trim() + ",";
            }
        }
        catch
        {
        }
        finally
        {
        }
    }
    public void go()
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

        if (fromDate <= toDate)
        {
            com = new SqlCommand("PaymentReport", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@FromDate", fromDate);
            com.Parameters.AddWithValue("@ToDate", toDate);
            com.Parameters.AddWithValue("@searchtext", txtSearch.Text.Trim());
            da = new SqlDataAdapter(com);
            da.Fill(t);
            if (t.Rows.Count > 0)
            {
                ViewState["dt"] = t;
                GridView1.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? t.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
                lblBinary.Text = Convert.ToString(Math.Round(Convert.ToDouble(t.Compute("sum(BinaryIncome)", "1=1").ToString()), 2));
                lblDirect.Text = Convert.ToString(Math.Round(Convert.ToDouble(t.Compute("sum(DirectIncome)", "1=1").ToString()), 2));
                lblC.Text = Convert.ToString(Math.Round(Convert.ToDouble(t.Compute("sum(cincome)", "1=1").ToString()), 2));
                //lblR.Text = Convert.ToString(Math.Round(Convert.ToDouble(t.Compute("sum(rincome)", "1=1").ToString()), 2));
                lblAmt.Text = Convert.ToString(Math.Round(Convert.ToDouble(t.Compute("sum(total)", "1=1").ToString()), 2)); 
                GridView1.DataSource = t;
                GridView1.DataBind();
                lblcount.Text = "No of records:" + " " + t.Rows.Count;
            }
            else
            {
                
                ViewState["dt"] = null;
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        else
        {
            utility.MessageBox(this,"Sorry,wrong date!");
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        txtSearch.Text = string.Empty;
        go();
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        go();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        go();
    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            go();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_TentativePayout.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
            utility.MessageBox(this,"Sorry can't export,no record found.");

    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            go();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_TentativePayout.doc");
            Response.ContentType = "application/vnd.ms-word";
            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);

            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }
        else
            utility.MessageBox(this,"Sorry can't export,no record found.");

    }
    protected void ibtnPDFExport_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            go();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_TentativePayout.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            GridView1.RenderControl(hw);
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        go();
    }

    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        double sNum = 0;
        double sNumDirectAmount = 0;       
        double sNumCAmount = 0;
        double sNumRAmount = 0;
      
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           
            Label lblbinaryamount = (Label)e.Row.FindControl("lblBinaryAmount");
            sNum = double.Parse(lblbinaryamount.Text);
            totalbinaryamount = totalbinaryamount + sNum;            
            //Label lblDirectAmount = (Label)e.Row.FindControl("lblDirectAmount");
            //sNumDirectAmount = double.Parse(lblDirectAmount.Text);
            //totalDirectAmount = totalDirectAmount + sNumDirectAmount;
            //Label lblCAmounttotal = (Label)e.Row.FindControl("lblCAmount");
            //sNumCAmount = double.Parse(lblCAmounttotal.Text);
            //totalCAmount = totalCAmount + sNumCAmount;

            //Label lblRAmounttotal = (Label)e.Row.FindControl("lblRAmount");
           // sNumRAmount = double.Parse(lblRAmounttotal.Text);
           // totalRAmount = totalRAmount + sNumRAmount;
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblbinaryamount = (Label)e.Row.FindControl("lblBinarytotal");
            lblbinaryamount.Text = totalbinaryamount.ToString();
            //Label lblDirectAmount = (Label)e.Row.FindControl("lblDirectAmounttotal");
            //lblDirectAmount.Text = totalDirectAmount.ToString();
            //Label lblCAmounttotal = (Label)e.Row.FindControl("lblCAmounttotal");
            //lblCAmounttotal.Text = totalCAmount.ToString();
            //Label lblRAmounttotal = (Label)e.Row.FindControl("lblRAmounttotal");
           // lblRAmounttotal.Text = totalRAmount.ToString();
        }

        
    }
}

