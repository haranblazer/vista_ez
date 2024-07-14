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
using System.Drawing;

public partial class user_downstatus : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    DataTable dt = new DataTable();

    string strsessionid;
    utility objUtil;
    protected string cv;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            strsessionid = Convert.ToString(Session["userId"]);
            // appid = Convert.ToString(Session["appmstid"]);
            if (strsessionid == "")
            {
                Response.Redirect("loginagain.aspx");
            }



            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.Date.AddDays(-1).ToString("dd/MM/yyyy");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                go();
            }



        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    public void go()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com;
            SqlDataReader sdr;
            con.Open();
            com = new SqlCommand("BV", con);
            com.CommandType = CommandType.StoredProcedure;
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {
                cv = sdr["PBV"].ToString();
            }
            con.Close();


            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();

            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
            //double diff = (toDate - fromDate).TotalDays;
            //if (diff > 31)
            //{
            //    utility.MessageBox(this, "Maximum 31 days allowed!");
            //    GridView1.DataSource = null;
            //    GridView1.DataBind();
            //    Label2.Text = string.Empty;
            //    return;
            //}

            //if (Session["downline"] != null)
            //{
            //}
            //else
            //{

            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {
                //string qstr = "Select AppMst.AppMstRegNo,appmstleftright= " +"case appmst.appmstleftright when 0 then 'Left' when 1 then 'Right' end,AppMst.AppMstTitle+space(1)+AppMst.AppMstFName as name ,AppMst.Joinfor as joinfor,Appmst.ProductName As ProductName,convert(char(20),appmst.appmstdoj,103) as AppmstDOJ,AppMstSponsor.AppMstRegNo As SponsorRegNo from AppMst,AppTran, AppMst As AppMstSponsor WHere AppMst.SponsorId = AppMstSponsor.AppmstRegNo And AppMst.AppMstId = AppTran.AppMstId And AppTran.ParentId =(SELECT appmstid FROM appmst WHERE appmstregno='" + strsessionid + "') and AppMst.AppMstPaid=1  AND CAST(FLOOR(CAST(AppMst.AppMstDOJ as float)) as datetime) between '" + strmin + "' and '" + strmax + "'  Order by AppMst.AppMstId";
                da = new SqlDataAdapter("SELECT Appmstid,AppMstFName,AppMstRegNo,CONVERT(VARCHAR(20), AppMstDOJ, 103) as AppMstDOJ,AppMstState, AppMstCity, LR=(case when appmstleftright=0 then 'Left' else 'Right' end)  FROM appmst WHERE sponsorid in (select AppMstID from AppMst where AppMstRegNo in ('" + strsessionid + "')) and AppMstPaid=0 and CAST(FLOOR(CAST(AppMstDOJ as float)) as datetime) between '" + fromDate + "' and '" + toDate + "' order by AppMstID desc", con);
                da.SelectCommand.CommandType = CommandType.Text;
                con.Open();
                da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
                da.SelectCommand.Parameters.AddWithValue("@mindate", fromDate);
                da.SelectCommand.Parameters.AddWithValue("@maxdate", toDate);
                //da.SelectCommand.Parameters.AddWithValue("@paid", ddlMemberType.SelectedItem.Value);
                da.Fill(dt);
                con.Close();

                Session["downline"] = dt;

                //if (dt.Rows.Count > 0)
                //{
                //    GridView1.PageSize = ddPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddPageSize.SelectedValue.ToString());
                //    GridView1.DataSource = dt;
                //    GridView1.DataBind();

                //    GridView1.HeaderRow.Cells[7].Text = "Total " + cv + " Left";
                //    GridView1.HeaderRow.Cells[8].Text = "Total " + cv + " Right";
                //    GridView1.HeaderRow.Cells[9].Text = "New " + cv + " Left";
                //    GridView1.HeaderRow.Cells[10].Text = "New " + cv + " Right";

                //    Label2.Text = " No of Records: " + dt.Rows.Count.ToString();
                //}
                //else
                //{
                //    GridView1.DataSource = null;
                //    GridView1.DataBind();
                //    Label2.Text = string.Empty;
                //}

            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                utility.MessageBox(this, "Invalid Date");
            }
            // }

            DataTable dtdl = new DataTable();
            dtdl = (DataTable)Session["downline"];
            if (dtdl.Rows.Count > 0)
            {
                GridView1.PageSize = ddPageSize.SelectedValue.ToString() == "All" ? dtdl.Rows.Count : Convert.ToInt32(ddPageSize.SelectedValue.ToString());
                GridView1.DataSource = dtdl;
                GridView1.DataBind();

                GridView1.HeaderRow.Cells[7].Text = "Total " + cv + " Left";
                GridView1.HeaderRow.Cells[8].Text = "Total " + cv + " Right";
                GridView1.HeaderRow.Cells[9].Text = "New " + cv + " Left";
                GridView1.HeaderRow.Cells[10].Text = "New " + cv + " Right";

                Label2.Text = " No of Records: " + dt.Rows.Count.ToString();
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                Label2.Text = string.Empty;
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
    protected void Button1_Click(object sender, EventArgs e)
    {
        go();

    }

    protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {

        go();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            go();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Downstatus.xls");
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
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Downstatus.doc");
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
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Downstatus.pdf");
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
    protected void ddlMemberType_SelectedIndexChanged(object sender, EventArgs e)
    {
        go();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((Convert.ToString(DataBinder.Eval(e.Row.DataItem, "appmstpaid")) == "Paid") && (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "reappmstpaid1")) == "Blue"))
                {
                    e.Row.BackColor = Color.FromName("#d5fbff");
                }
                if ((Convert.ToString(DataBinder.Eval(e.Row.DataItem, "appmstpaid")) == "Unpaid") && (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "reappmstpaid1")) == "LightBlue"))
                {
                    e.Row.BackColor = Color.FromName("#ffffff");
                }
                if ((Convert.ToString(DataBinder.Eval(e.Row.DataItem, "reappmstpaid1")) == "Blue" && Convert.ToString(DataBinder.Eval(e.Row.DataItem, "appmstpaid")) == "Unpaid"))
                {
                    e.Row.BackColor = Color.FromName("#dcffda");
                }
                if ((Convert.ToString(DataBinder.Eval(e.Row.DataItem, "reappmstpaid1")) == "LightBlue" && Convert.ToString(DataBinder.Eval(e.Row.DataItem, "appmstpaid")) == "Paid"))
                {
                    e.Row.BackColor = Color.FromName("#dcffda");
                }
            }
        }
        catch
        {

        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        objUtil = new utility();

        //GridViewRow row = GridView1.Rows[GridView1.c];

        if (e.CommandName == "In")
        {
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            string reg = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
            Response.Redirect("downstatusinv.aspx?reg=" + objUtil.base64Encode(reg));
        }

    }
}
