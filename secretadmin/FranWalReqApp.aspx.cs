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
using System.Text;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.Text.RegularExpressions;

public partial class secretadmin_userWalletRequestApproved : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFromdate.Text = DateTime.Now.Date.AddMonths(-1).ToString("dd/MM/yyyy");
            txtTodate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            BindData();

        }
    }

    private void BindData()
    {
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        //DateTime validDate = Convert.ToDateTime(toDate, dateInfo); 

        DateTime from;
        DateTime to;
        if (!string.IsNullOrEmpty(txtFromdate.Text.Trim()) && !string.IsNullOrEmpty(txtTodate.Text.Trim()))
        {
            try
            {
                from = Convert.ToDateTime(txtFromdate.Text.Trim(), dateInfo);
                to = Convert.ToDateTime(txtTodate.Text.Trim(), dateInfo);
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }
        }
        else
        {
            from = DateTime.Now.Date;
            to = DateTime.Now.Date;
        }

        double datedays = (to - from).TotalDays;
        if (datedays > 31)
        {
            utility.MessageBox(this, "Maximum 31 days allowed");
            GridView1.DataSource = null;
            GridView1.DataBind();
            return;
        }

        con = new SqlConnection(method.str);
        com = new SqlCommand("userWalletRequestApproved", con);
        com.CommandType = CommandType.StoredProcedure;
        com.CommandTimeout = 9999999;
        if (!string.IsNullOrEmpty(txtFromdate.Text.Trim()))
            com.Parameters.AddWithValue("@fromdate", from);
        if (!string.IsNullOrEmpty(txtTodate.Text.Trim()))
            com.Parameters.AddWithValue("@Todate", to);

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
                LblTotalRecord.Text = "Total Records:" + dt.Rows.Count.ToString();
                object objSum;
                objSum = dt.Compute("Sum(amt)", "1 = 1");
                LblAmount.Text = "Total Amount :" + (string.IsNullOrEmpty(objSum.ToString()) ? "0" : objSum.ToString());
            }

            else
            {
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
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindData();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_RequestApprovedList.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else

            utility.MessageBox(this, "record not found,can not export.");
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindData();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_RequestApprovedList.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else

            utility.MessageBox(this, "record not found,can not export.");
    }
    protected void imgbtnPdf_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindData();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_RequestApprovedList.pdf");
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
            utility.MessageBox(this, "record not found,can not export.");
    }

    /// <summary>
    /// This method is used for export the data
    /// </summary>
    /// <param name="control"></param>

    public override void VerifyRenderingInServerForm(Control control)
    {
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        BindData();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        txtFromdate.Text = txtTodate.Text = string.Empty;
        BindData();
    }
}
