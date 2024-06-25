using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;

public partial class admin_franchiseReport : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = new DataTable();
    SqlCommand cmd;
    SqlDataAdapter da;
    utility u = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetAllowResponseInBrowserHistory(true);
        //lblMessage.Text = String.Empty;
        if (!Page.IsPostBack)
        {
            //   // btnInsert.CommandName = "Insert";
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
            txtFromDate.Text = DateTime.Now.Date.AddDays(-6).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            BindGrid();
        } 
    }
    public void BindGrid()
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
            lblMsg.Text = "Invalid date entry.";
            return;
        }
        if (ddlUser.SelectedValue.ToString() == "All")
        {
            if (fromDate <= toDate)
            {
                // da = new SqlDataAdapter("select UPPER(AppmstLname) AS AppmstLname,appmstmobile,appmstid,UPPER(distt) AS distt,UPPER(email) AS email,convert(varchar(20),appPaiddatetime ,103) as appmstpaiddate, UPPER(AppMstregno) AS AppMstregno,UPPER(SponsorID) AS SponsorID,parentid,UPPER(AppmstTitle) +space(1)+UPPER(AppmstFName) as name,UPPER(AppMstCity) AS AppMstCity,UPPER(AppMstState) AS AppMstState,AppMstDOJ=CONVERT(char(20),AppMstDOJ,103),Joinfor=JAmount,case when appmstPaid=1 or ypin=1 then 'PAID' when appmstPaid=0 or ypin=0 then 'UNPAID' end as appmstPaid from AppMst where CAST(FLOOR(CAST(AppMstDOJ as float)) as datetime) between @fromDate and @toDate and appmstpaid<>1 and ypin<>1 order by AppMstid", con);
                da = new SqlDataAdapter("select f.appmstid,f.fname,count(*) as  totalpin,sum(p.amount) as amount from FranchiseMst f inner join PINMst p on f.appmstid=p.alloted where  p.paidstatus=1 and  p.allotmentdate>= @fromDate and p.allotmentdate<=@toDate  group by appmstid,FName ", con);
                da.SelectCommand.Parameters.AddWithValue("@fromDate", fromDate);
                da.SelectCommand.Parameters.AddWithValue("@toDate", toDate);

                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    ViewState["dt"] = dt;
                    lblMsg.Text = string.Empty;
                    dglst.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
                    dglst.DataSource = dt;
                    dglst.DataBind();
                    lblcount.Text = "No of records :" + dt.Rows.Count;
                }
                else
                {
                    lblcount.Text = string.Empty;
                    dglst.DataSource = null;
                    dglst.DataBind();
                }
            }
            else
            {
                lblMsg.Text = "SORRY...! Wrong date!";
                dglst.Visible = false;
            }
        }

        else if (fromDate <= toDate)
        {
            // da = new SqlDataAdapter("select UPPER(a.appmstaddress1) AS appmstaddress1,UPPER(AppmstLname) AS AppmstLname,appmstmobile,appmstid,UPPER(distt) AS distt,UPPER(email) AS email,convert(varchar(20),appPaiddatetime ,103) as appmstpaiddate, UPPER(AppMstregno) AS AppMstregno,UPPER(SponsorID) AS SponsorID,parentid,UPPER(AppmstTitle) +space(1)+UPPER(AppmstFName) as name,UPPER(AppMstCity) AS AppMstCity,UPPER(AppMstState) AS AppMstState,AppMstDOJ=CONVERT(char(20),AppMstDOJ,103),Joinfor=JAmount,case when appmstPaid=1 or ypin=1 then 'PAID' when appmstPaid=0 or ypin=0 then 'UNPAID' end as appmstPaid from AppMst where CAST(FLOOR(CAST(AppMstDOJ as float)) as datetime) between @fromDate and @toDate and (appmstpaid=@paid or ypin=@paid )order by AppMstid", con);
            da = new SqlDataAdapter("select f.appmstid,f.fname,count(*) as  totalpin,sum(p.amount) as amount from FranchiseMst f inner join PINMst p on f.appmstid=p.alloted where  p.paidstatus=1 and  p.allotmentdate>= @fromDate and p.allotmentdate<=@toDate  group by appmstid,FName ", con);
            da.SelectCommand.Parameters.AddWithValue("@fromDate", fromDate);
            da.SelectCommand.Parameters.AddWithValue("@toDate", toDate);
           
            //da.SelectCommand.Parameters.AddWithValue("@paid", ddlUser.SelectedValue.ToString());

            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ViewState["dt"] = dt;
                lblMsg.Text = string.Empty;
                dglst.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
                //lblJoinFor.Text = Convert.ToString(Math.Round(Convert.ToDouble(dt.Compute("sum(joinfor)", "1=1").ToString()), 2)); 
                dglst.DataSource = dt;
                dglst.DataBind();
                lblcount.Text = "No of records: " + dt.Rows.Count;
            }
            else
            {
                lblcount.Text = string.Empty;
                lblMsg.Text = string.Empty;
                dglst.DataSource = null;
                dglst.DataBind();
            }
        }
        else
        {
            lblMsg.Text = "SORRY...! Wrong date!";
            dglst.Visible = false;
        }
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        //if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
        //    search();
        //else
        BindGrid();
    }

    protected void dglst_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "getpins")
        {
            GridViewRow row = dglst.Rows[Convert.ToInt32(e.CommandArgument)];
          //  LinkButton lnkbtnId = (LinkButton)row.FindControl("lnkbtnId");
            Label lbl1 = (Label)row.FindControl("Label1");

            
            Response.Redirect("franshisePinlist.aspx?n=" + u.base64Encode(lbl1.Text.Trim()), false);
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            //if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            //{ search(); }
            //else
            //{ go(); }
            BindGrid();
            dglst.ShowFooter = false;
            dglst.Columns[9].Visible = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_List.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dglst.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
            lblMsg.Text = "Sorry can't export,no record found.";
    }
   
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            //if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            //{ search(); }
            //else
            //{ go(); }
            BindGrid();
            dglst.ShowFooter = false;
            dglst.Columns[9].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_List.doc");

            Response.ContentType = "application/vnd.ms-word";
            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);

            dglst.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }
        else
        {
            lblMsg.Text = "Can't Export,No Data Found!";
        }
    }
    protected void ibtnPDFExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            //if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            //{ search(); }
            //else
            //{ go(); }
            BindGrid();
            dglst.ShowFooter = false;
            dglst.Columns[9].Visible = false;
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_List.pdf");
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
            lblMsg.Text = "can not export as no data found !";
    }
}