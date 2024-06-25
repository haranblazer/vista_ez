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
    utility u = new utility();
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
            txtFromDate.Text = DateTime.Now.Date.AddDays(-1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            go1();

        }
    }
    private void BindProductList()
    {
        //DataTable dt = new DataTable();
        //dt = u.GetProductList();
        //chkListProduct.DataSource = dt;
        //chkListProduct.DataTextField = "Name";
        //chkListProduct.DataValueField = "srno";
        //chkListProduct.DataBind();
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
            double datedays=(toDate-fromDate).TotalDays;
            //if (datedays > 31)
            //{    utility.MessageBox(this, "Maximum 31 days allowed");
            //    dglst.DataSource = null;
            //    dglst.DataBind();
            //    return;
            //}
            string ProductId = "";
            //foreach (System.Web.UI.WebControls.ListItem item in chkListProduct.Items)
            //{
            //    if (item.Selected)
            //    {
            //        ProductId = ProductId + "," + item.Value;
            //    }
            //}

            //if (!String.IsNullOrEmpty(ProductId))
            //{
            //    ProductId = ProductId.Remove(0, 1);
            //}
          
            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {
                da = new SqlDataAdapter("select * from enquirymst where status=1 and doe between @mindate and @maxdate", con);
                da.SelectCommand.CommandType = CommandType.Text;
                da.SelectCommand.Parameters.AddWithValue("@mindate", fromDate.ToString());
                da.SelectCommand.Parameters.AddWithValue("@maxdate", toDate.ToString());
                //da.SelectCommand.Parameters.AddWithValue("@regno", txtid.Text.Trim());
                //da.SelectCommand.Parameters.AddWithValue("@AppMstLogin","");
                //da.SelectCommand.Parameters.AddWithValue("@AppMstFName", txtfname.Text);
                //da.SelectCommand.Parameters.AddWithValue("@AppMstLName", "");
                //da.SelectCommand.Parameters.AddWithValue("@AppMstCity", txtcity.Text.Trim());
                //da.SelectCommand.Parameters.AddWithValue("@AppMstState", txtstate.Text.Trim());
                //da.SelectCommand.Parameters.AddWithValue("@AppMstMobile", txtMobileNo.Text.Trim());
                //da.SelectCommand.Parameters.AddWithValue("@panno", txtPan.Text.Trim());
                //da.SelectCommand.Parameters.AddWithValue("@ProductId", ProductId.Trim());
                DataTable t = new DataTable();
                da.Fill(t);
                if (t.Rows.Count > 0)
                {
                    //Label2.Text = "Total Paid Id : " + t.Rows.Count.ToString();
                    dglst.DataSource = t;
                    dglst.DataBind();
                }
                else
                {
                    Label2.Text = "";
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
            //dglst.Columns[10].Visible = false;
            go1();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_enquiry.xls");
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
            //dglst.Columns[10].Visible = false;
            go1();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_enquiry.doc");
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
    protected void dglst_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    GridViewRow grv = (GridViewRow)e.Row;

        //    Label lbl1 = (Label)grv.FindControl("lblColor");
        //    if (lbl1.Text == "1")
        //    {
        //        e.Row.BackColor = System.Drawing.Color.LightPink; 
        //        //TableCell rowCell = (TableCell)lbl1.Parent;
        //        //rowCell.Style["background"] = "red";
        //    }
        //}
        //Label Color = (Label)e.Row.FindControl("lblColor");
        //if (Color.Text == "1")
        //{
        //    e.Row.BackColor = System.Drawing.Color.Green;  
        //}
    }
    protected void dglst_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //if (e.CommandName.Equals("PRINT"))
        //{
        //    utility obj = new utility();
        //    Response.Redirect("invoice.aspx?id=" + obj.base64Encode(e.CommandArgument.ToString()));
        //}


        //if (e.CommandName.Equals("Login"))
        //{
        //    Session["userId"] = e.CommandArgument.ToString();
        //    Response.Redirect("~/user/direct.aspx", false);

        //}
    }
}
