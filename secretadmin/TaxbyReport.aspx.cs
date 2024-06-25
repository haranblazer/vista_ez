using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml;
using System.IO;
using System.Drawing;

public partial class secretadmin_TaxbyReport : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = null;
    SqlDataAdapter da = null;
    utility u = new utility();
    string regno, name = "";
    XmlDocument xmldoc = new XmlDocument();
    string xmlfile = "";
    double tax;
    double taxamount, sum2 = 0, sum4 = 0, sum5 = 0, sum10 = 0, sum12 = 0;
    int invoiceno;
    double amount;
    DateTime date;

    double tax2 = 0, tax4 = 0, tax5 = 0, tax10 = 0, tax12 = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            show();
        }
    }

    public void show()
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
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }
        double datedays = (toDate - fromDate).TotalDays;
        if (datedays > 31)
        {
            utility.MessageBox(this, "Maximum 31 days allowed");
            dglst.DataSource = null;
            dglst.DataBind();
            return;
        }
        dt = new DataTable();
        //da = new SqlDataAdapter("productreport1", con);
        da = new SqlDataAdapter("userreport1", con);

        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@min", fromDate);
        da.SelectCommand.Parameters.AddWithValue("@max", toDate);
        da.SelectCommand.Parameters.AddWithValue("@orderBy", ddltype.SelectedValue.ToString());
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {

            dglst.Columns[5].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("dp")).Sum().ToString();
            dglst.Columns[6].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("dpwt")).Sum().ToString();
            dglst.Columns[7].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("sgst")).Sum().ToString();
            dglst.Columns[8].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("cgst")).Sum().ToString();
            dglst.Columns[9].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("igst")).Sum().ToString();
            dglst.DataSource = dt;
            dglst.DataBind();
        }

        else
        {
            dglst.DataSource = null;
            dglst.DataBind();
        }

    }

    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        dglst.PageIndex = e.NewPageIndex;
        show();

    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        show();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    //protected void dglst_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    //e.Row.Attributes.Add("onmouseover", "this.style.cursor='hand';this.style.backgroundColor='#bcee68'");
    //    ////e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='white'");

    //    //e.Row.Attributes.Add("onmouseover", "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='#bcee68'");
    //    //e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=this.originalstyle");
    //    //e.Row.Attributes.Add("style", "cursor:pointer;");
    //}

    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (dglst.Rows.Count > 0)
        {


            dglst.AllowPaging = false;
            show();

            dglst.HeaderRow.BackColor = Color.White;
            foreach (GridViewRow row in dglst.Rows)
            {
                row.BackColor = Color.White;

            }

            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductReport.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.dglst.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            show();
            dglst.HeaderRow.BackColor = Color.White;
            foreach (GridViewRow row in dglst.Rows)
            {
                row.BackColor = Color.White;

            }
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Report.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.dglst.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
    }
    protected void dglst_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Status")) == "0"))
                {
                    e.Row.BackColor = Color.FromName("#FBDCDB");

                }

            }
        }
        catch
        {

        }
    }
}