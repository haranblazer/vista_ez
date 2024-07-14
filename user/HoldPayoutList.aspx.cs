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
        if (Session["userId"] == null)
            Response.Redirect("~/Default.aspx", true);
       
         if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            go1();

        }
    }
    //private void BindProductList()
    //{
    //    DataTable dt = new DataTable();
    //    dt = u.GetProductList();
    //    chkListProduct.DataSource = dt;
    //    chkListProduct.DataTextField = "Name";
    //    chkListProduct.DataValueField = "srno";
    //    chkListProduct.DataBind();
    //}
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
            if (datedays > 31)
            {    utility.MessageBox(this, "Maximum 31 days allowed");
                dglst.DataSource = null;
                dglst.DataBind();
                return;
            }
           
           
          
            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {
                da = new SqlDataAdapter("GetPayoutlistNonElegible", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.SelectCommand.Parameters.AddWithValue("@From", fromDate.ToString());
                da.SelectCommand.Parameters.AddWithValue("@To", toDate.ToString());
                da.SelectCommand.Parameters.AddWithValue("@Userid", Session["userId"].ToString().Trim());
              
                DataTable t = new DataTable();
                da.Fill(t);
                if (t.Rows.Count > 0)
                {
                    Label2.Text = "Total Hold Id : " + t.Rows.Count.ToString()+",     Total Amount : " + t.Compute("sum(amount)",string.Empty).ToString();
                    dglst.DataSource = t;
                    dglst.DataBind();
                    ViewState["r"] = t.Rows.Count.ToString();

                    decimal totalam = Convert.ToDecimal(t.Compute("sum(amount)", string.Empty));
                    decimal tDirect = Convert.ToDecimal(t.Compute("sum(Direct)", string.Empty));
                    decimal tBinary = Convert.ToDecimal(t.Compute("sum(Binary)", string.Empty));
                    decimal tLDLGold = Convert.ToDecimal(t.Compute("sum(LDLGold)", string.Empty));
                    decimal tLDLDiamond = Convert.ToDecimal(t.Compute("sum(LDLDiamond)", string.Empty));
                    decimal tLDLEmperor = Convert.ToDecimal(t.Compute("sum(LDLEmperor)", string.Empty));
                    decimal tLDLCrown = Convert.ToDecimal(t.Compute("sum(LDLCrown)", string.Empty));
                    decimal tLtheLDLGold = Convert.ToDecimal(t.Compute("sum(LtheLDLGold)", string.Empty));
                    decimal tLtheLDLDiamond = Convert.ToDecimal(t.Compute("sum(LtheLDLDiamond)", string.Empty));
                    decimal tLtheLDLEmperor = Convert.ToDecimal(t.Compute("sum(LtheLDLEmperor)", string.Empty));
                    decimal tLtheLDLCrown = Convert.ToDecimal(t.Compute("sum(LtheLDLCrown)", string.Empty));

                    dglst.FooterRow.Cells[1].Text = "Total";
                    dglst.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Right;
                    dglst.FooterRow.Cells[3].Text = totalam.ToString("N2");
                    dglst.FooterRow.Cells[3].HorizontalAlign = HorizontalAlign.Right;
                    dglst.FooterRow.Cells[4].Text = tDirect.ToString("N2");
                    dglst.FooterRow.Cells[4].HorizontalAlign = HorizontalAlign.Right;
                    dglst.FooterRow.Cells[5].Text = tBinary.ToString("N2");
                    dglst.FooterRow.Cells[5].HorizontalAlign = HorizontalAlign.Right;
                    dglst.FooterRow.Cells[6].Text = tLDLGold.ToString("N2");
                    dglst.FooterRow.Cells[6].HorizontalAlign = HorizontalAlign.Right;
                    dglst.FooterRow.Cells[7].Text = tLDLDiamond.ToString("N2");
                    dglst.FooterRow.Cells[7].HorizontalAlign = HorizontalAlign.Right;
                    dglst.FooterRow.Cells[8].Text = tLDLEmperor.ToString("N2");
                    dglst.FooterRow.Cells[8].HorizontalAlign = HorizontalAlign.Right;
                    dglst.FooterRow.Cells[9].Text = tLDLCrown.ToString("N2");
                    dglst.FooterRow.Cells[9].HorizontalAlign = HorizontalAlign.Right;
                    dglst.FooterRow.Cells[10].Text = tLtheLDLGold.ToString("N2");
                    dglst.FooterRow.Cells[10].HorizontalAlign = HorizontalAlign.Right;
                    dglst.FooterRow.Cells[11].Text = tLtheLDLDiamond.ToString("N2");
                    dglst.FooterRow.Cells[11].HorizontalAlign = HorizontalAlign.Right;
                    dglst.FooterRow.Cells[12].Text = tLtheLDLEmperor.ToString("N2");
                    dglst.FooterRow.Cells[12].HorizontalAlign = HorizontalAlign.Right;
                    dglst.FooterRow.Cells[13].Text = tLtheLDLCrown.ToString("N2");
                    dglst.FooterRow.Cells[13].HorizontalAlign = HorizontalAlign.Right;

                }
                else
                {
                    Label2.Text = "";
                    dglst.DataSource = null;
                    dglst.DataBind();
                    ViewState["r"] = t.Rows.Count.ToString();

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
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_holdpayoutlist.xls");
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
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_holdpayoutlist.doc");
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
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        u = new utility();
        string value = ddlPageSize.SelectedItem.Text;
        value = value.ToString() == "All" ? ViewState["r"].ToString() : value;
        dglst.PageSize = Int32.Parse(value);
        go1();

    }
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
       
    }
    protected void dglst_RowCreated(object sender, GridViewRowEventArgs e)
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
            HeaderCell.Text = "Name";
            HeaderCell.ColumnSpan = 1;
            HeaderCell.RowSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "Amount";
            HeaderCell.ColumnSpan = 1;
            HeaderCell.RowSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "Direct Income";
            HeaderCell.ColumnSpan = 1;
            HeaderCell.RowSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);


            HeaderCell = new TableCell();
            HeaderCell.Text = "Binary Income";
            HeaderCell.ColumnSpan = 1;
            HeaderCell.RowSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "Leader Ship Bonus";
            HeaderCell.ColumnSpan = 4;
            HeaderCell.RowSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "Lead the Leadership Bonus";
            HeaderCell.ColumnSpan = 4;
            HeaderCell.RowSpan = 1;
            HeaderGridRow.Cells.Add(HeaderCell);

            dglst.Controls[0].Controls.AddAt(0, HeaderGridRow);
        }
    }
}
