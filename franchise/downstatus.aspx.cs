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
using System.Text;

public partial class user_downstatus : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);

    SqlDataAdapter da;
    DataTable dt = new DataTable();
    string strsessionid;
    StringBuilder sb;
    protected void Page_Load(object sender, EventArgs e)
    {
        ViewState["ab"] = null;

        if (Session["users"] != null)
        {
            lbluserid.Text = Session["users"].ToString();

        }
        try
      {
        strsessionid = Convert.ToString(Session["franchiseid"]);
       
        // appid = Convert.ToString(Session["appmstid"]);
        if (strsessionid == "")
        {
                Response.Redirect("Logout.aspx");
            }

        
        if (!IsPostBack)
        {

            Session["users"] = null;
            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            go();

        }
}
catch(Exception ex)
{
Response .Write(ex.Message);
}
    }
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
      
            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {
                //string qstr = "Select AppMst.AppMstRegNo,appmstleftright= " +"case appmst.appmstleftright when 0 then 'Left' when 1 then 'Right' end,AppMst.AppMstTitle+space(1)+AppMst.AppMstFName as name ,AppMst.Joinfor as joinfor,Appmst.ProductName As ProductName,convert(char(20),appmst.appmstdoj,103) as AppmstDOJ,AppMstSponsor.AppMstRegNo As SponsorRegNo from AppMst,AppTran, AppMst As AppMstSponsor WHere AppMst.SponsorId = AppMstSponsor.AppmstRegNo And AppMst.AppMstId = AppTran.AppMstId And AppTran.ParentId =(SELECT appmstid FROM appmst WHERE appmstregno='" + strsessionid + "') and AppMst.AppMstPaid=1  AND CAST(FLOOR(CAST(AppMst.AppMstDOJ as float)) as datetime) between '" + strmin + "' and '" + strmax + "'  Order by AppMst.AppMstId";
                da = new SqlDataAdapter("DownlineReport", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.SelectCommand.Parameters.AddWithValue("@regno", ViewState["Regno"] == null ? strsessionid : ViewState["Regno"].ToString());
                da.SelectCommand.Parameters.AddWithValue("@mindate", fromDate);
                da.SelectCommand.Parameters.AddWithValue("@maxdate", toDate);
                da.SelectCommand.Parameters.AddWithValue("@paid", ddlMemberType.SelectedItem.Value);
                con.Open();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    Label2.Text = " No of Records: " + dt.Rows.Count.ToString();
                }
                else
                {
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                    Label2.Text = string.Empty;
                   
                }
                con.Close();
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                utility.MessageBox(this,"Invalid Date");

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
            utility.MessageBox(this,"Can't export as no data found.");
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
    protected void imgbtnpdf_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            go();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Downstatus.pdf");
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
    protected void ddlMemberType_SelectedIndexChanged(object sender, EventArgs e)
    {
        go();
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView HeaderGrid = (GridView)sender;
            GridViewRow HeaderGridRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell HeaderCell = new TableCell();
            HeaderCell.Text = "SrNo";
            HeaderCell.ColumnSpan = 1;
            HeaderCell.RowSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "UserID";
            HeaderCell.ColumnSpan = 1;
            HeaderCell.RowSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "Associate Name";
            HeaderCell.ColumnSpan = 2;
            HeaderCell.RowSpan = 1;
        
            HeaderGridRow.Cells.Add(HeaderCell);
            HeaderCell = new TableCell();
            HeaderCell.Text = "%Level";
            HeaderCell.ColumnSpan = 1;
            HeaderCell.RowSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "Current Month BV";
            HeaderCell.ColumnSpan = 3;
            HeaderCell.RowSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);


            HeaderCell = new TableCell();
            HeaderCell.Text = "Total Cummulative BV";
            HeaderCell.ColumnSpan = 3;
            HeaderCell.RowSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);


            GridView1.Controls[0].Controls.AddAt(0, HeaderGridRow);

        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (ViewState["ab"] == null )
            {
                Button btnstatus = ((Button)e.Row.FindControl("Button2"));
                btnstatus.Visible = false;
                ViewState["ab"] = "1";

            }

            else
            {
                Label lblstatus = ((Label)e.Row.FindControl("Label1"));
                lblstatus.Visible = false;             
                
            }


          
        }

     
      
       
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "PAID")
        {
            ViewState["Regno"] = e.CommandArgument.ToString();
            sb = new StringBuilder();

            if (Session["users"] != null)
            {
                    sb.Append(Session["users"].ToString());
                    sb.Append("/");
                    sb.Append(ViewState["Regno"]);
                    Session["users"] = sb.ToString();
                   
                    lbluserid.Text = Session["users"].ToString();
                
            }

            else
            {
                Session["users"] = ViewState["Regno"];

                lbluserid.Text = Session["users"].ToString();
            }
            go();
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {

        if (Session["users"] != null)
        {

            if (Session["users"].ToString().Length > 8)
            {
                string s = Session["users"].ToString();
                ViewState["Regno"] = s.Split('/')[0];

                ////int index = s.IndexOf('/');
                //int index = s.Length;
                string result = s.Substring(9);
                Session["users"] = result;
                lbluserid.Text = Session["users"].ToString();
                go();
            }

            if (Session["users"].ToString().Length ==8)
            {
                lbluserid.Text = Session["users"].ToString();
                ViewState["regno"] = Session["users"].ToString();
                Session["users"] = null;
                go();
            }

            if (Session["users"] == null)
            {
                lbluserid.Text = "";
            }



        }




     
    }
}
