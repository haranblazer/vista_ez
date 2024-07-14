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
using System.Collections.Generic;

public partial class user_ApproveWalletList : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] != null)
        {
            if (!IsPostBack)
            {
                txtFromdate.Text = DateTime.Now.Date.AddYears(-2).ToString("dd/MM/yyyy").Replace("-","/");
                txtTodate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
                //WalletBindData();
            }
        }
        else
        {
            Response.Redirect("~/login.aspx", false);
        }
    }




    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string fromdate, string Todate)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString()),
                   new SqlParameter("@fromdate", fromdate),
                   new SqlParameter("@Todate", Todate)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "userWalletRequestApproved");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.userid = dr["userid"].ToString();
                data.fname = dr["fname"].ToString();
                data.amt = dr["amt"].ToString();
                data.redate = dr["redate"].ToString();
                data.status = dr["status"].ToString();
                data.apdate = dr["apdate"].ToString();
                data.Remarks = dr["Remarks"].ToString();
                data.payDetail = dr["payDetail"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string userid { get; set; }
        public string fname { get; set; }
        public string amt { get; set; }
        public string redate { get; set; }
        public string status { get; set; }
        public string apdate { get; set; }
        public string Remarks { get; set; }
        public string payDetail { get; set; }
    }

    #endregion




    //private void WalletBindData()
    //{
    //    System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //    dateInfo.ShortDatePattern = "dd/MM/yyyy";

    //    DateTime from;
    //    DateTime to;
    //    try
    //    {
    //        from = Convert.ToDateTime(txtFromdate.Text.Trim(), dateInfo);
    //        to = Convert.ToDateTime(txtTodate.Text.Trim(), dateInfo);
    //    }
    //    catch
    //    {
    //        utility.MessageBox(this, "Invalid date entry.");
    //        return;
    //    }

    //    con = new SqlConnection(method.str);
    //    com = new SqlCommand("userWalletRequestApproved", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.CommandTimeout = 9999999;
    //    com.Parameters.AddWithValue("@fromdate", from);
    //    com.Parameters.AddWithValue("@Todate", to);
    //    com.Parameters.AddWithValue("@regno", Session["userId"].ToString());

    //    try
    //    {
    //        SqlDataAdapter adapter = new SqlDataAdapter();
    //        DataTable dt = new DataTable();
    //        adapter.SelectCommand = com;
    //        adapter.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {
    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();
    //            LblTotalRecord.Text = "Total record :" + dt.Rows.Count.ToString();
    //            object objSum;
    //            objSum = dt.Compute("Sum(amt)", "1 = 1");
    //            LblAmount.Text = "Total Amount :" + (string.IsNullOrEmpty(objSum.ToString()) ? "0" : objSum.ToString());
    //        }
    //        else
    //        {
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //        }
    //    }
    //    catch
    //    {
    //    }
    //}
    //protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    if (rdbtn1.SelectedValue == "0")
    //    {
    //        WalletBindData();
    //    }
    //}

    //protected void Button1_Click(object sender, EventArgs e)
    //{

    //    if (rdbtn1.SelectedValue == "0")
    //    {
    //        WalletBindData();
    //    }

    //}

    //protected void imgbtnExcel_Click(object sender, EventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        GridView1.Columns[7].Visible = false;
    //        if (rdbtn1.SelectedValue == "0")
    //        {
    //            WalletBindData();
    //        }

    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.xls");
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        GridView1.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else

    //        utility.MessageBox(this, "record not found,can not export.");
    //}
    //protected void imgbtnWord_Click(object sender, EventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        GridView1.Columns[7].Visible = false;
    //        if (rdbtn1.SelectedValue == "0")
    //        {
    //            WalletBindData();
    //        }


    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.doc");
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        GridView1.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else

    //        utility.MessageBox(this, "record not found,can not export.");
    //}

    //protected void imgbtnPdf_Click(object sender, EventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        if (rdbtn1.SelectedValue == "0")
    //        {
    //            WalletBindData();
    //        }

    //        GridView1.Columns[7].Visible = false;
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.pdf");
    //        Response.ContentType = "application/pdf";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        StringWriter sw = new StringWriter();
    //        HtmlTextWriter hw = new HtmlTextWriter(sw);
    //        GridView1.RenderControl(hw);
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
    //        utility.MessageBox(this, "record not found,can not export.");
    //}
    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}
    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    //if (e.CommandName != "Page")
    //    //{

    //    //    GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //    //    int pid = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
    //    //    if (e.CommandName == "EditPayment")
    //    //    {
    //    //        Response.Redirect("GetRechargeLoad.aspx?pid=" + obj.base64Encode(Convert.ToString(pid)));
    //    //    }
    //    //}
    //}
}
