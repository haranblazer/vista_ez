using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;

public partial class admin_franshisePinlist : System.Web.UI.Page
{
    string tranid, id;
    utility objUtiliy = new utility();
    SqlDataAdapter da;
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetAllowResponseInBrowserHistory(true);

        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminloginInside();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }

        id = objUtiliy.base64Decode(Request.QueryString["n"].ToString());

        //tranid = objUtiliy.base64Decode(Request.QueryString["n"].ToString());
        ////id = objUtiliy.base64Decode(Request.QueryString["id"].ToString());
        if (!Page.IsPostBack)
            bindGrid();
    }

    public void bindGrid()
    {
       // da = new SqlDataAdapter("select Pinsrno,PinNo,Pintype,allotmentdate,amount,mode,transactionNo,bank,depositedamount,remark from PINMst", con);

        da = new SqlDataAdapter("getfranchisePins", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@id", id);
        DataTable table = new DataTable();
        da.Fill(table);
        if (table.Rows.Count > 0)
        {
            //lblUser.Text = table.Rows[0]["allotedto"].ToString();
            ViewState["Count"] = table.Rows.Count;
            gv.DataSource = table;
            gv.DataBind();

        }
        else
        {
            ViewState["Count"] = "0";
            gv.DataSource = null;
            gv.DataBind();
        }
    }
    protected void gv_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv.PageIndex = e.NewPageIndex;
        bindGrid();
    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToInt32(Convert.ToString(ViewState["Count"])) > 0)
        {
            gv.PageSize = Convert.ToInt32(Convert.ToString(ViewState["Count"]));
            bindGrid();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + " " + lblUser.Text + "AllotedPinList.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            gv.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            lblMsg.Text = "Can't Export,No Data Found!";
        }

    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToInt32(Convert.ToString(ViewState["Count"])) > 0)
        {
            gv.PageSize = Convert.ToInt32(Convert.ToString(ViewState["Count"]));
            bindGrid();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + " " + lblUser.Text + "AllotedPinList.doc");
            Response.ContentType = "application/vnd.ms-word";
            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            gv.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
        {
            lblMsg.Text = "Can't Export,No Data Found!";
        }


    }
    public override void VerifyRenderingInServerForm(Control control)
    {



    }
    protected void ibtnPDFExport_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToInt32(Convert.ToString(ViewState["Count"])) > 0)
        {
            gv.PageSize = Convert.ToInt32(Convert.ToString(ViewState["Count"]));
            bindGrid();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + " " + lblUser.Text + "AllotedPinList.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            gv.RenderControl(hw);
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
            lblMsg.Text = "Can't Export , No Data Found !";

    }
}