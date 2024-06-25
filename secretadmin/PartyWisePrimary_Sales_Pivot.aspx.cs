﻿using System; 
using System.Web.UI.WebControls; 
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Text;
//using System.Configuration; 
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.IO;
//using System.Web.UI;
public partial class secretadmin_PartyWisePrimary_Sales_Pivot : System.Web.UI.Page
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
 
            var last = new DateTime(now.Year, now.Month-3, 1);
            txtFromDate.Text = last.ToString("dd-MM-yyyy").Replace("-", "/");


            Bind_FranchiseTypeEdit();
        }
    }

    protected void btnSearchByDate_Click(object sender, EventArgs e)
    {
        dataReports();
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
        try
        {
            SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@fromDate", fromDate),
                new SqlParameter("@toDate",toDate),
                new SqlParameter("@Frantype",ddl_Type.SelectedValue),
                new SqlParameter("@AppmstRegno",txt_BuyerID.Text.Trim())
            };
            DataUtility objDUT = new DataUtility();
            DataTable dt = objDUT.GetDataTableSP(sqlparam, "GetDashboardDetails_BUYERWISE_PIVOT");
            int i;
            for (i = 0; i <= 18; i++)
            {
                grandtotal[i] = 0;
            }
           
            dt.Columns.Add("Total", typeof(decimal));
            foreach (DataRow row in dt.Rows)
            {
                
                decimal rowSum = 0;
                foreach (DataColumn col in dt.Columns)
                {
                    if (col.ToString() != "Buyer UserId" && col.ToString() != "Buyer Name" && col.ToString() != "Type" && col.ToString() != "Buyer State" && col.ToString() != "Buyer District" && col.ToString() != "Buyer Mobile No" && col.ToString() != "LeaderId" && col.ToString() != "LeaderName")
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
            for (int i = 9; i < colCount; i++)
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
                if (i >= 9)
                {
                    e.Row.Cells[i].Text = Math.Round(Convert.ToDouble(grandtotal[i].ToString()), 2).ToString();
                }
            }
        }
    }

    private void Bind_FranchiseTypeEdit()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4 and UserVal not in (1, 7, 8, 9, 10)");
        if (dt.Rows.Count > 0)
        {
            ddl_Type.DataSource = dt;
            ddl_Type.DataTextField = "Item_Desc";
            ddl_Type.DataValueField = "Frantype";
            ddl_Type.DataBind();
            ddl_Type.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Associate", "0"));
            ddl_Type.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select All", "-1"));
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


    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    private void ExportFile()
    {

        string fileName = "PartyWisePrimarySales_" + DateTime.Now.ToShortDateString() + ".xls",
        contentType = "application/vnd.ms-excel";

        grdviewdata.AllowPaging = false;
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", fileName));
        Response.Write("<Table><tr><td></td><td></td><td></td><td></td><td style=font-size:20px><b>Party Wise Primary Sales</b></td><td></td></tr></Table>");
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
            Response.AddHeader("content-disposition", "attachment;filename=PartyWisePrimarySales_" + DateTime.Now.ToShortDateString() + ".csv");
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