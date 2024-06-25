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
using System.Text.RegularExpressions;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Collections.Generic;
public partial class admin_CourierEntries : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable t = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Logout.aspx");
        }
        if (!IsPostBack)
        {
            DateTime now = DateTime.Now;
            var startDate = new DateTime(now.Year, now.Month, 1);

            txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            go();
            //BindUserID();
        }
       
    }
    //private void BindUserID()
    //{
    //    con = new SqlConnection(method.str);
    //    SqlDataAdapter da = new SqlDataAdapter();
    //    //ViewState["Count"] = null;
    //    try
    //    {
    //        DataTable dtt = new DataTable();
    //        da = new SqlDataAdapter("select appmstregno,appmstfname from appmst", con);
    //        da.Fill(dtt);

    //        List<string> objProductList = new List<string>(); ;
    //        String strPrdPrice = string.Empty;
    //        divUserID.InnerText = string.Empty;
    //        foreach (DataRow drw in dtt.Rows)
    //        {
    //            divUserID.InnerText += drw["appmstregno"].ToString() + ",";
    //        }
    //    }
    //    catch
    //    {
    //    }
    //    finally
    //    {
    //    }
    //}
    public void go()
    {
        try
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();

            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);

            double datedays = (toDate - fromDate).TotalDays;
            if (datedays > 31)
            {
                utility.MessageBox(this, "Maximum 31 days allowed");
                GridView1.DataSource = null;
                GridView1.DataBind();
                return;
            }


            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {

               
                //cmd = new SqlCommand("select userid,description,couriercompany,docketid,convert(varchar(20),dispatcheddate,103) as dispatcheddate ,receivedstatus=" + "case receivedstatus when 0 then 'Not Received' when 1 then 'Received' end,convert(varchar(20),receiveddate,103) as receiveddate from courierdetails where userid like @userid or docketid like @docketid or couriercompany like @couriercompany and CAST(FLOOR(CAST(dispatcheddate as float)) as datetime) between CAST(FLOOR(CAST(@mindate as float)) as datetime)  and CAST(FLOOR(CAST(@maxdate as float)) as datetime) ", con);

                cmd = new SqlCommand("getcourier", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@mindate", fromDate);
                cmd.Parameters.AddWithValue("@maxdate", toDate);
                cmd.Parameters.AddWithValue("@userid", txtUserId.Text.Trim());
                //cmd.Parameters.AddWithValue("@docketid",txtDocketId.Text.Trim());
                //cmd.Parameters.AddWithValue("@couriercompany",txtCompany.Text.Trim());
                cmd.Parameters.AddWithValue("@from", Session["franchiseid"].ToString());



                da = new SqlDataAdapter(cmd);
                da.Fill(t);
                if (t.Rows.Count > 0)
                {
                    Label2.Text = "No Of Records :" + t.Rows.Count.ToString();
                    GridView1.DataSource = t;
                    GridView1.DataBind();

                }
                else
                {
                    Label2.Text = "No Record";
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                }

            }
            else
            {
                utility.MessageBox(this, "Invalid date entry");
            }
        }
        catch
        {
        }

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        go();
    }

    protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;

        go();

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        go();

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            go();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Courierlist.xls");
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
            go();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Courierlist.doc");
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
    //protected void imgbtnpdf_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        go();
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Courierlist.pdf");
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
    //        utility.MessageBox(this, "Can't export as no data found.");
    //}
}
