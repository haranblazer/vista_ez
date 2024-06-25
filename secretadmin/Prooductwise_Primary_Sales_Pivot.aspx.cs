using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class secretadmin_Prooductwise_Primary_Sales_Pivot : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    int[] grandtotal = new int[18] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }


    private void ExportFile(string fileName, string contentType)
    {
        grdProductprimary.AllowPaging = false;
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", fileName));
        //string headerTable = @"<Table><tr><td style=color:#bb8f38;font-size:25px>Pivot-Reports</td><td></td><td></td><td></td></tr></Table>";
        //Response.Write(headerTable);
        //Response.Write("<Table><tr><td>Phone: (0330) 6351635</td><td>Email:info@sentinel-vaults.com</td></tr></Table>");
        Response.Write("<Table><tr><td></td><td></td><td></td><td></td><td style=font-size:20px><b>Productwise Secondary Sales</b></td><td></td></tr></Table>");
        Response.ContentType = contentType;
        Response.Write("<style> TABLE { border:dotted 1px #999; } " +
            "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
        StringWriter objSW = new StringWriter();
        HtmlTextWriter objTW = new HtmlTextWriter(objSW);
        grdProductprimary.RenderControl(objTW);
        Response.Write(objSW);
        Response.End();
    }


    protected void ViewRepor_Click(object sender, EventArgs e)
    {
        dataReports();
    }

    protected void btnexcel_Click(object sender, EventArgs e)
    {
        string fileName = "Productwise_Secondary_Sales_" + DateTime.Now.ToShortDateString() + ".xls",
                   contentType = "application/vnd.ms-excel";
        ExportFile(fileName, contentType);
    }
    string SALESQTY;
    string TOTALQTY;
    string Total;
    public void dataReports()
    {


        con.Open();
        SqlCommand cmd = new SqlCommand("GetPrimarySaleProductWise_PIVOT", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Monthinterval", ddlmonth.SelectedItem.Text);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);


        int i;
        for (i = 0; i <= 17; i++)
        {
            grandtotal[i] = 0;
        }
        grdProductprimary.DataSource = dt;
        grdProductprimary.DataBind();


    }
    decimal salesvalue = 0;
    int total;

    int finaltotal = 0;
    int rowdata;

    protected void grdProductprimary_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        var colCount = e.Row.Cells.Count;


        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            total = 0;
            for (int i = 6; i < colCount; i++)
            {

                if (string.IsNullOrEmpty(e.Row.Cells[i].Text) || e.Row.Cells[i].Text == "&nbsp;")
                {
                    e.Row.Cells[i].Text = "0";
                }
                else
                {
                    rowdata = Convert.ToInt32(e.Row.Cells[i].Text);
                    total += Convert.ToInt32(e.Row.Cells[i].Text);
                    grandtotal[i] += Convert.ToInt32(e.Row.Cells[i].Text);


                }
            }
            e.Row.Cells[3].Text = total.ToString();

            salesvalue = (total * Convert.ToDecimal(e.Row.Cells[4].Text));
            e.Row.Cells[5].Text = salesvalue.ToString();

            //Label lblTotalAmt = (Label)e.Row.FindControl("lblTotalAmt");
            //lblTotalAmt.Text = total.ToString();
            finaltotal += total;

            Label lblSerial = (Label)e.Row.FindControl("lblSerial");
            lblSerial.Text = ((grdProductprimary.PageIndex * grdProductprimary.PageSize) + e.Row.RowIndex + 1).ToString();

            //Label lblsalesvalue = (Label)e.Row.FindControl("lblsalesvalue");
            //lblsalesvalue.Text = salesvalue.ToString();


        }



        if (e.Row.RowType == DataControlRowType.Footer)
        {
            for (int i = 0; i < colCount; i++)
            {
                // for writing text GrandTotal
                if (i == 0)
                {
                    e.Row.Cells[i].Text = "Grand Total";
                }

                else if (i == 1)
                {
                    e.Row.Cells[i].Text = finaltotal.ToString();

                }
                else if (i >= 6)
                {

                    e.Row.Cells[i].Text = grandtotal[i].ToString();
                }
            }

        }
    }
}