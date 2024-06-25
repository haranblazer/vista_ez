using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class franchise_ClosingStock : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
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
            if (!Page.IsPostBack)
            {
                
                    GetUserlist();

            }
        }
        catch
        {

        }
         
    }
    private void GetUserlist()
    {
        DataUtility objDu = new DataUtility();

        DataTable dt = objDu.GetDataTable("Select FranchiseId From Franchisemst Where appmstActivate=1");
        divProductcode.InnerText = string.Empty;
        foreach (DataRow row in dt.Rows)
        {
            divProductcode.InnerText += row["FranchiseId"].ToString() + ",";
        }
    }

    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }

    protected void OnSorting(object sender, GridViewSortEventArgs e)
    {

        string SortDir = string.Empty;
        this.show(e.SortExpression);
        if (ViewState["SortDirection"].ToString() == "ASC")
        {
            SortDir = "Sorting in ascending order.";
        }
        else
        {
            SortDir = "Sorting in descending order.";
            //GridView1.HeaderRow.Cells[1].Text = "User Id <img src='../images/sort_dec.png' />";

            // GridView1.SortExpression = "AppMstRegNo";
            //GridView1.CssClass = "headerSortDown";

        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        show(null);
    }


    public void show(string sortExpression)
    {
        try
        {
            if (string.IsNullOrEmpty(txt_FranchiseId.Text))
            {
                dglst.DataSource = null;
                dglst.DataBind();
                utility.MessageBox(this, "Please Enter Franchise Id.!!");
                return;
            }

            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {
                new SqlParameter("@FranchiseId", txt_FranchiseId.Text.Trim())
            };
            DataTable dtNew = objDu.GetDataTable(param1, "Select Top 1 FranchiseId From Franchisemst Where FranchiseId=@FranchiseId");
            if (dtNew.Rows.Count > 0)
            {

                SqlParameter[] param = new SqlParameter[]
                 {
                new SqlParameter("@MasterType","Admin"),
                 new SqlParameter("@regno", txt_FranchiseId.Text.Trim())
                  };
                DataUtility obj_du = new DataUtility();
                DataTable dt = obj_du.GetDataTableSP(param, "ClosingStock");
                Session["dt"] = dt;
                if (dt.Rows.Count > 0)
                {
                    dglst.Columns[2].FooterText = "Total :";
                    dglst.Columns[6].FooterText = dt.AsEnumerable().Select(x => x.Field<int>("Qty")).Sum().ToString();
                    dglst.Columns[7].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("Total_DP")).Sum().ToString();
                    dglst.Columns[8].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("Total_DPWithTax")).Sum().ToString();
                    dglst.Columns[9].FooterText = "0";
                    dglst.Columns[10].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("TPV")).Sum().ToString();
                    dglst.Columns[11].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("RPV")).Sum().ToString();

                    if (sortExpression != null)
                    {
                        DataView dv = dt.AsDataView();
                        this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                        dv.Sort = sortExpression + " " + this.SortDirection;
                        dglst.DataSource = dv;
                        dglst.DataBind();

                    }
                    else
                    {
                        dglst.DataSource = dt;
                        dglst.DataBind();
                    }
                }
                else
                {
                    dglst.DataSource = null;
                    dglst.DataBind();
                }
            }
            else
            {
                dglst.DataSource = null;
                dglst.DataBind();
                utility.MessageBox(this, "Franchise Id Not valid.!!");
                return;
            }


        }
        catch (Exception er) { }
    }


    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        show(null);
    }


    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Session["dt"];

            if (dt.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "ClosingStockReport.xls"));
                Response.ContentType = "application/ms-excel";
                string str = string.Empty;
                foreach (DataColumn dtcol in dt.Columns)
                {
                    Response.Write(str + dtcol.ColumnName);
                    str = "\t";
                }
                Response.Write("\n");
                foreach (DataRow dr in dt.Rows)
                {
                    str = "";
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Response.Write(str + Convert.ToString(dr[j]));
                        str = "\t";
                    }
                    Response.Write("\n");
                }
                Response.End();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found.');", true);
            }
        }
        catch (Exception er) { }

    }

    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {


        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            show(null);

            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_FranchiseList.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            dglst.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");

    }
}