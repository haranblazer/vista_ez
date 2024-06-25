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
using System.Data;
using System;
using System.Xml;
using System.Web;
using System.Collections.Generic;
using System.Linq;
public partial class admin_ProductStock : System.Web.UI.Page
{
    SqlConnection con;
    SqlDataAdapter da;
    DataTable dt;
    SqlCommand cmd;
    int qnt;
    string commonbook;
    XmlDocument xmldoc;
    utility objUtil;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["franchiseid"] == null)
        {
            Response.Redirect("../Default.aspx");
        }
        if (!Page.IsPostBack)
        {

            bindgrid();

        }
    }
    protected void Grdreport_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        objUtil = new utility();

        GridViewRow row = Grdreport.Rows[Convert.ToInt32(e.CommandArgument)];
        string pid = Grdreport.DataKeys[row.RowIndex].Values[0].ToString();

        if (e.CommandName == "TI")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("11"));

        if (e.CommandName == "GRN")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("15"));

        if (e.CommandName == "Sales")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("12"));

        if (e.CommandName == "Packed")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("17"));

        if (e.CommandName == "PackedUsing")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("18"));

        if (e.CommandName == "UnPacked")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("19"));

        if (e.CommandName == "UnPackedItems")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("20"));

        if (e.CommandName == "ItemOut")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("14"));

        if (e.CommandName == "Issued")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("16"));

        if (e.CommandName == "FromItemAdj")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("21"));

        if (e.CommandName == "ToItemAdj")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("22"));

        if (e.CommandName == "SalesReturn")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("13"));

        if (e.CommandName == "RTV")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("23"));

        if (e.CommandName == "Balance")
            Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("0"));
        

        /*if (e.CommandName == "In")
        {
            Response.Redirect("TotalIn.aspx?bid=" + objUtil.base64Encode(bid) + "&pid=" + objUtil.base64Encode(pid));
        }
        if (e.CommandName == "out")
        {
            Response.Redirect("TotalOut.aspx?bid=" + objUtil.base64Encode(bid) + "&pid=" + objUtil.base64Encode(pid));
        }
        if (e.CommandName == "Cancel")
        {
            Response.Redirect("TotalCancel.aspx?bid=" + objUtil.base64Encode(bid) + "&pid=" + objUtil.base64Encode(pid));
        }*/
    }
    public void bindgrid()
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("StockInhand", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@regno", Session["franchiseid"].ToString());
        da.SelectCommand.Parameters.AddWithValue("@type", "1");
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {

            //Grdreport.Columns[9].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("amount")).Sum().ToString();
            Grdreport.DataSource = dt;
            Grdreport.DataBind();
        }

        else
        {
            Grdreport.DataSource = null;
            Grdreport.DataBind();
        }
    }
    protected void BtnClear_Click(object sender, EventArgs e)
    {

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {

    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (Grdreport.Rows.Count > 0)
        {
            Grdreport.AllowPaging = false;
            bindgrid();
            //Grdreport.Columns[16].Visible = Grdreport.Columns[17].Visible = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stockinhand.xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            Grdreport.RenderControl(htmlWrite);
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
        if (Grdreport.Rows.Count > 0)
        {
            Grdreport.AllowPaging = false;
            bindgrid();
            // Grdreport.Columns[16].Visible = Grdreport.Columns[17].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stockinhand.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.Grdreport.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
    }
}