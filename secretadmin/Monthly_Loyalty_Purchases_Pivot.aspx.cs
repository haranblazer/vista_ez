using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

public partial class secretadmin_Monthly_Loyalty_Purchases_Pivot : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    double[] grandtotal = new double[19] { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

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
        if (!IsPostBack)
        {
            var now = DateTime.Now;
            var first = new DateTime(now.Year, now.Month, 1);
            txtToDate.Text = first.AddMinutes(330).AddMonths(1).AddDays(-1).ToString("dd-MM-yyyy").Replace("-", "/");

            var last = new DateTime(now.Year, now.Month - 3, 1);
            txtFromDate.Text = last.ToString("dd-MM-yyyy").Replace("-", "/");

            //txtFromDate.Text = DateTime.Now.AddMonths(-4).ToString("dd-MM-yyyy").Replace("-", "/");
            //txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");
        }
    }

    protected void btnSearchByDate_Click(object sender, EventArgs e)
    {
        dataReports();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    //private void ExportFile(string fileName, string contentType)
    //{
    //    grdviewdata.AllowPaging = false;
    //    Response.ClearContent();
    //    Response.Buffer = true;
    //    Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", fileName));
    //    //string headerTable = @"<Table><tr><td style=color:#bb8f38;font-size:25px>Pivot-Reports</td><td></td><td></td><td></td></tr></Table>";
    //    //Response.Write(headerTable);
    //    //Response.Write("<Table><tr><td>Phone: (0330) 6351635</td><td>Email:info@sentinel-vaults.com</td></tr></Table>");
    //    Response.Write("<Table><tr><td></td><td></td><td></td><td></td><td style=font-size:20px><b>Productwise Secondary Sales</b></td><td></td></tr></Table>");
    //    Response.ContentType = contentType;
    //    Response.Write("<style> TABLE { border:dotted 1px #999; } " +
    //        "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
    //    StringWriter objSW = new StringWriter();
    //    HtmlTextWriter objTW = new HtmlTextWriter(objSW);
    //    grdviewdata.RenderControl(objTW);
    //    Response.Write(objSW);
    //    Response.End();
    //}


    //protected void btnexcel_Click(object sender, EventArgs e)
    //{
    //    string fileName = "Productwise_Secondary_Sales_" + DateTime.Now.ToShortDateString() + ".xls",
    //        contentType = "application/vnd.ms-excel";
    //    ExportFile(fileName, contentType);
    //}
    public void dataReports()
    {

        string fromDate = "", toDate = "";
        try
        {
            if (txtFromDate.Text.Trim().Length > 0)
            {
                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
            if (txtToDate.Text.Trim().Length > 0)
            {
                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
        }
        catch
        {
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }
        
        try
        {
            SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@fromDate", fromDate),
                new SqlParameter("@toDate",toDate),
                new SqlParameter("@AppmstRegno",txt_BuyerID.Text.Trim())
            };
            DataUtility objDUT = new DataUtility();
            DataTable dt = objDUT.GetDataTableSP(sqlparam, "GetLoyalityDetails_PIVOT");
            int i;
            for (i = 0; i <= 18; i++)
            {
                grandtotal[i] = 0;
            }
            //grdviewdata.DataSource = dt;
            //grdviewdata.DataBind();

            dt.Columns.Add("Total", typeof(decimal));
            foreach (DataRow row in dt.Rows)
            {
                decimal rowSum = 0;
                foreach (DataColumn col in dt.Columns)
                {
                    if (col.ToString() != "Buyer UserId" && col.ToString() != "Buyer UserName" && col.ToString() != "Buyer State" && col.ToString() != "Buyer District" && col.ToString() != "Buyer MobileNo")
                    {
                        if (!row.IsNull(col))
                        {
                            string stringValue = row[col].ToString();
                            decimal d;
                            if (decimal.TryParse(stringValue, out d))
                                rowSum += d;
                        }
                    }
                }
                row.SetField("Total", rowSum);
            }

            DataView dtNew = new DataView(dt);
            dtNew.RowFilter = "Total>0";

            grdviewdata.DataSource = dtNew.ToTable();
            grdviewdata.DataBind();

        }
        catch (Exception ex) { }


        //con.Open();
        //SqlCommand cmd = new SqlCommand("GetLoyalityDetails_PIVOT", con);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.AddWithValue("@Monthinterval", ddlmonth.SelectedValue);
        //SqlDataAdapter da = new SqlDataAdapter(cmd);
        //DataTable dt = new DataTable();
        //da.Fill(dt);

        //int i;
        //for (i = 0; i <= 18; i++)
        //{
        //    grandtotal[i] = 0;
        //}
        //grdviewdata.DataSource = dt;
        //grdviewdata.DataBind();

    }
    double total;
    double finaltotal = 0;
    double rowdata;
    protected void grdviewdata_RowDataBound(object sender, GridViewRowEventArgs e)
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
                    rowdata = Convert.ToDouble(e.Row.Cells[i].Text);
                    total += Math.Round(Convert.ToDouble(e.Row.Cells[i].Text), 2);
                    grandtotal[i] += Math.Round(Convert.ToDouble(e.Row.Cells[i].Text), 2);
                }
            }

            //Label lblTotalAmt = (Label)e.Row.FindControl("lblTotalAmt");
            //lblTotalAmt.Text = total.ToString();
            finaltotal += total;

            Label lblSerial = (Label)e.Row.FindControl("lblSerial");
            lblSerial.Text = ((grdviewdata.PageIndex * grdviewdata.PageSize) + e.Row.RowIndex + 1).ToString();
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
                //else if (i == 1)
                //{
                //    e.Row.Cells[i].Text = finaltotal.ToString();
                //}
                //else 
                if (i >= 6)
                {
                    e.Row.Cells[i].Text = Math.Round(Convert.ToDouble(grandtotal[i].ToString()), 2).ToString(); 
                }
            }

        }
    }



    protected void imgbtnExcel_Click(object sender, EventArgs e)
    {
        if (grdviewdata.Rows.Count > 0)
        {
            ExportFile();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }
    private void ExportFile()
    {

        string fileName = "MonthlyLoyaltyPurchases_" + DateTime.Now.ToShortDateString() + ".xls",
        contentType = "application/vnd.ms-excel";

        grdviewdata.AllowPaging = false;
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", fileName));
        Response.Write("<Table><tr><td></td><td></td><td></td><td></td><td style=font-size:20px><b>Monthly Loyalty Purchases</b></td><td></td></tr></Table>");
        Response.ContentType = contentType;
        Response.Write("<style> TABLE { border:dotted 1px #999; } " + "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
        StringWriter objSW = new StringWriter();
        HtmlTextWriter objTW = new HtmlTextWriter(objSW);
        grdviewdata.RenderControl(objTW);
        Response.Write(objSW);
        Response.End();
    }
    protected void imgbtnCsv_Click(object sender, EventArgs e)
    {

        if (grdviewdata.Rows.Count > 0)
        {

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=MonthlyLoyaltyPurchases_" + DateTime.Now.ToShortDateString() + ".csv");
            Response.Charset = "";
            Response.ContentType = "text/csv";

            //To Export all pages.
            grdviewdata.AllowPaging = false;
            //this.bindgrid();

            StringBuilder sb = new StringBuilder();
            foreach (TableCell cell in grdviewdata.HeaderRow.Cells)
            {
                //Append data with separator.
                sb.Append(cell.Text + ',');
            }
            //Append new line character.
            sb.Append("\r\n");

            foreach (GridViewRow row in grdviewdata.Rows)
            {
                foreach (TableCell cell in row.Cells)
                {
                    //Append data with separator.
                    sb.Append(cell.Text + ',');
                }
                //Append new line character.
                sb.Append("\r\n");
            }

            Response.Output.Write(sb.ToString());
            Response.Flush();
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }


    }




}