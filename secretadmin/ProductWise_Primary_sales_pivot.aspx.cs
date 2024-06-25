using System;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;


public partial class secretadmin_ProductWise_Primary_sales_pivot : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    int[] grandtotal = new int[18] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
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
            BindUserProduct();
            dataReports();
        }
    }
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

        String Product = "";
        String[] strProduct = txt_product.Text.Split(new String[] { "=" }, StringSplitOptions.RemoveEmptyEntries);
        try
        {
            if (strProduct[0] != null)
                Product = strProduct[0];
        }
        catch { } 

        try
        {
            SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@fromDate", fromDate), 
                new SqlParameter("@toDate",toDate),
                new SqlParameter("@Product",Product)
            };
            DataUtility objDUT = new DataUtility();
            DataTable dt = objDUT.GetDataTableSP(sqlparam, "GetPrimarySaleProductWise_PIVOT");
            int i;
            for (i = 0; i <= 17; i++)
            {
                grandtotal[i] = 0;
            }

            dt.Columns.Add("Total", typeof(decimal));
            foreach (DataRow row in dt.Rows)
            {
                decimal rowSum = 0;
                foreach (DataColumn col in dt.Columns)
                {
                    if (col.ToString() != "ProductCode" && col.ToString() != "ProductName" && col.ToString() != "Category") 
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
             
            grdProductprimary.DataSource = dtNew.ToTable();
            grdProductprimary.DataBind(); 
        }
        catch (Exception ex) { }

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
            for (int i = 4; i < colCount; i++)
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
            //e.Row.Cells[3].Text = total.ToString();

            //salesvalue = (total * Convert.ToDecimal(e.Row.Cells[4].Text));
           // e.Row.Cells[5].Text = salesvalue.ToString();

            finaltotal += total;

            Label lblSerial = (Label)e.Row.FindControl("lblSerial");
            lblSerial.Text = ((grdProductprimary.PageIndex * grdProductprimary.PageSize) + e.Row.RowIndex + 1).ToString();
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
                if (i >= 4)
                {
                    Math.Round(Convert.ToDouble(grandtotal[i].ToString()), 2).ToString();
                }
            }
        }
    }


    public void BindUserProduct()
    { 
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReader("select p.ProductCode, ProductName=p.ProductName+'='+SPACE(1)+ p.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)) from shopproductmst p inner join PackSizemst ps on p.PackSizeUnitId = ps.srno and p.isDeleted = 0");
        while (dr.Read())
        {
            divProductcode.InnerText += dr["ProductCode"].ToString() + "," + dr["ProductName"].ToString() + ",";
        } 
    }



    protected void btnSearchByDate_Click(object sender, EventArgs e)
    {
        dataReports();
    }


    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void imgbtnExcel_Click(object sender, EventArgs e)
    {
        if (grdProductprimary.Rows.Count > 0)
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

        string fileName = "ProductWisePrimarySales_" + DateTime.Now.ToShortDateString() + ".xls",
        contentType = "application/vnd.ms-excel";

        grdProductprimary.AllowPaging = false;
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", fileName));
        Response.Write("<Table><tr><td></td><td></td><td></td><td></td><td style=font-size:20px><b>Product Wise Primary Sales</b></td><td></td></tr></Table>");
        Response.ContentType = contentType;
        Response.Write("<style> TABLE { border:dotted 1px #999; } " + "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
        StringWriter objSW = new StringWriter();
        HtmlTextWriter objTW = new HtmlTextWriter(objSW);
        grdProductprimary.RenderControl(objTW);
        Response.Write(objSW);
        Response.End();
    }
    protected void imgbtnCsv_Click(object sender, EventArgs e)
    {
        if (grdProductprimary.Rows.Count > 0)
        {

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=ProductWisePrimarySales_" + DateTime.Now.ToShortDateString() + ".csv");
            Response.Charset = "";
            Response.ContentType = "text/csv";

            //To Export all pages.
            grdProductprimary.AllowPaging = false;
            //this.bindgrid();

            StringBuilder sb = new StringBuilder();
            foreach (TableCell cell in grdProductprimary.HeaderRow.Cells)
            {
                //Append data with separator.
                sb.Append(cell.Text + ',');
            }
            //Append new line character.
            sb.Append("\r\n");

            foreach (GridViewRow row in grdProductprimary.Rows)
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
