using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_TopEarner : System.Web.UI.Page
{
    public override void VerifyRenderingInServerForm(Control control) { }
    Dictionary<int, decimal> grandTotals = new Dictionary<int, decimal>();
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
            //InsertFunction.CheckAdminlogin();
            txtFromDate.Text = DateTime.Now.AddDays(-7).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");
            BindState();
            dataReports();
        }

    }

    protected void grdviewdata_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        var colCount = e.Row.Cells.Count;

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            decimal total = 0;
            for (int i = 9; i < colCount; i++)
            {
                decimal value;
                if (decimal.TryParse(e.Row.Cells[i].Text.Trim(), out value))
                {
                    total += value;

                    if (!grandTotals.ContainsKey(i))
                    {
                        grandTotals[i] = value;
                    }
                    else
                    {
                        grandTotals[i] += value;
                    }
                }
            }
            finaltotal += total;
        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            for (int i = 0; i < colCount; i++)
            {
                if (i == 1)
                {
                    e.Row.Cells[i].Text = "Grand Total";
                }
                else if (i >= 9)
                {
                    decimal grandTotal;
                    if (grandTotals.TryGetValue(i, out grandTotal))
                    {
                        e.Row.Cells[i].Text = grandTotal.ToString();
                    }
                    else
                    {
                        e.Row.Cells[i].Text = "0";
                    }
                }
            }
        }
    }

    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        //if (txtFromDate.Text == "All" || txtToDate.Text == "Active" || ddlState.SelectedItem.Text == "InActive")
        //{
        if (grdviewdata.Rows.Count > 0)
        {
            grdviewdata.AllowPaging = false;
            dataReports();
           // grdviewdata.Columns[6].Visible = grdviewdata.Columns[7].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_TopEarner.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            grdviewdata.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
        //}
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        //if (ddSearch.SelectedItem.Text == "All" || ddSearch.SelectedItem.Text == "Active" || ddSearch.SelectedItem.Text == "InActive")
        //{
        if (grdviewdata.Rows.Count > 0)
        {
            grdviewdata.AllowPaging = false;
            dataReports();
         //  grdviewdata.Columns[6].Visible = grdviewdata.Columns[7].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_TopEarner.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            grdviewdata.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
        //}
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
            new SqlParameter("@StartDate", fromDate),
            new SqlParameter("@EndDate", toDate),
            new SqlParameter("@State", ddlState.SelectedItem.Text),
            new SqlParameter("@TOPN", ddl_NOE.SelectedValue)
        };
            DataUtility objDUT = new DataUtility();
            DataTable dt = objDUT.GetDataTableSP(sqlparam, "TopEarnerPivotStateWise");

            // Remove the total column addition logic
            // dt.Columns.Add("Total", typeof(decimal));
            // ... code for calculating and adding total column removed ...

            DataView dtNew = new DataView(dt);
            // No need for row filtering if total column is not added
            // dtNew.RowFilter = "Total>0";

            grdviewdata.DataSource = dtNew.ToTable();
            grdviewdata.DataBind();
        }
        catch (Exception ex) { }
    }
    decimal total;
decimal finaltotal = 0;
decimal rowdata;
public void BindState()
{

    DataUtility objDu = new DataUtility();
    SqlParameter[] sqlparam = new SqlParameter[] {
            };
    DataTable dt = objDu.GetDataTableSP(sqlparam, "GetState");

    if (dt.Rows.Count > 0)
    {
        ddlState.DataSource = dt;
        ddlState.DataTextField = "StateName";
        ddlState.DataValueField = "srno";
        ddlState.DataBind();
        ddlState.Items.Insert(0, new ListItem("All", "0"));
    }
}

protected void btn_Search_Click(object sender, EventArgs e)
{
    dataReports();
}
}