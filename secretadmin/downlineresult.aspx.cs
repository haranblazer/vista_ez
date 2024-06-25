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
public partial class admin_downlineresult : System.Web.UI.Page
{
    string regno;
    string payoutno;
    SqlConnection con = new SqlConnection(method.str);
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
        regno = Session["regno"].ToString();
        payoutno = Session["pno"].ToString();
        ftechdata();
        LblRegNo.Text = regno;
        lblPayOutNo.Text = payoutno;
    }
    private void ftechdata()
    {


        SqlDataAdapter adp = new SqlDataAdapter("select  UPPER(a.appmstregno) AS appmstregno,UPPER(p.TotalEarning) AS TotalEarning,UPPER(a.appmsttitle)+space(2)+UPPER(a.appmstfname) as name,round(p.Tds,2)as Tds  ,p.DispachedAmt,p.HandlingCharges,p.PaymentTranDraftid from PaymentTranDraft p , appmst a where p.appmstid1=a.appmstid and  a.appmstregno not in (select regno from downlineprintedcheque where payoutno=@payoutno and parentid=@regno)and p.payoutno=@payoutno and p.appmstid1  in (select a.appmstid from apptransponsor apt ,appmst a  where a.appmstid=apt.appmstid and apt.ParentId in (SELECT appmstid FROM appmst WHERE appmstregno=@regno)) order by a.appmstid", con);
        adp.SelectCommand.Parameters.AddWithValue("@payoutno",payoutno);
        adp.SelectCommand.Parameters.AddWithValue("@regno",regno);
        con.Open();

        DataSet ds = new DataSet();
        adp.Fill(ds);

        if (ds.Tables[0].Rows.Count > 0)
        {
            dgr.DataSource = ds;
            dgr.DataBind();
            lblMsg.Visible = false;
            Label2.Text = ds.Tables[0].Rows.Count.ToString();
            //lblTotal.Text = "Sum Of Total Earning: " + Convert.ToString(ds.Tables[0].Compute("sum(TotalEarning)", "1=1")) + " Total TDS: " + Convert.ToString(ds.Tables[0].Compute("sum(tds)", "1=1")) + " Total Handling Charges: " + Convert.ToString(ds.Tables[0].Compute("sum(HandlingCharges)", "1=1")) + " Total Dispatched Amount: " + Convert.ToString(ds.Tables[0].Compute("sum(DispachedAmt)", "1=1"));
        }
        else
        {
            dgr.Visible = false;
            lblMsg.Visible = true;
            Label2.Text = "0";
            lblTotal.Text = string.Empty;

        }
        con.Close();
    }

    protected void dgr_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dgr.PageIndex = e.NewPageIndex;
        ftechdata();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       
        if (rbtnICICI.Checked == true)
        {
            Page.Response.Redirect("downlinechq.aspx?startid=" + TxtPaymentTrandraftid.Text + "&NoChq=" + TxtNoChq.Text + "&pno=" + payoutno);
        }
        else if (rbtnPNB.Checked == true)
        {
            Page.Response.Redirect("downlinepnb.aspx?startid=" + TxtPaymentTrandraftid.Text + "&NoChq=" + TxtNoChq.Text + "&pno=" + payoutno);
        }
        else if (rbtnAxis.Checked == true)
        {
            Page.Response.Redirect("DownlineAxisCheque.aspx?startid=" + TxtPaymentTrandraftid.Text + "&NoChq=" + TxtNoChq.Text + "&pno=" + payoutno);
        }
        else if (rbtnBOB.Checked == true)
        {
            Page.Response.Redirect("DownlineBOB.aspx?startid=" + TxtPaymentTrandraftid.Text + "&NoChq=" + TxtNoChq.Text + "&pno=" + payoutno);
        }
        else if (rbtnHDFC.Checked == true)
        {
            Page.Response.Redirect("DownlineHDFC.aspx?startid=" + TxtPaymentTrandraftid.Text + "&NoChq=" + TxtNoChq.Text + "&pno=" + payoutno);
        }
        else if (rbtnSBI.Checked == true)
        {
            Page.Response.Redirect("DownlineSBI.aspx?startid=" + TxtPaymentTrandraftid.Text + "&NoChq=" + TxtNoChq.Text + "&pno=" + payoutno);
        }
    }
    
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dgr.Rows.Count > 0)
        {
            dgr.AllowPaging = false;
            ftechdata();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_DownlineList.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dgr.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else           
            lblMsg.Text = "can not export as no data found !";

    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dgr.Rows.Count > 0)
        {
            dgr.AllowPaging = false;
            ftechdata();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_DownlineList.doc");
            Response.ContentType = "application/vnd.ms-word";
            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            dgr.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }
        else
            lblMsg.Text = "can not export as no data found !";
    }
    protected void ibtnPDFExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dgr.Rows.Count > 0)
        {
            dgr.AllowPaging = false;
            ftechdata();            
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_DownlineList.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            dgr.RenderControl(hw);
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
