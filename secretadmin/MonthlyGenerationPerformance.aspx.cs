using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_MonthlyPerformance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
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

            Bind_Month();
            BindGrid(null);
        }
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {
        BindGrid(null);
    }


    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }


    protected void OnSorting(object sender, GridViewSortEventArgs e)
    {

        string SortDir = string.Empty;
        this.BindGrid(e.SortExpression);
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

    private void BindGrid(string sortExpression)
    {

        try
        {

            SqlParameter[] param = new SqlParameter[]
           {
                new SqlParameter("@Master_Key","GENERATION"),
                 new SqlParameter("@Month_Year", ddl_Month.SelectedValue),
                 new SqlParameter("@UserId", txt_user.Text.Trim())
           };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "getMonthlyPerformance");

            if (dt.Rows.Count > 0)
            {
                GridView1.PageSize = ddPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddPageSize.SelectedValue.ToString());

                GridView1.Columns[7].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(RPV)", "true").ToString()) ? "0.00" : dt.Compute("sum(RPV)", "true").ToString());
                GridView1.Columns[8].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(GPV)", "true").ToString()) ? "0.00" : dt.Compute("sum(GPV)", "true").ToString());
               // GridView1.Columns[5].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(TPV)", "true").ToString()) ? "0.00" : dt.Compute("sum(TPV)", "true").ToString());
                GridView1.Columns[9].FooterText = (string.IsNullOrEmpty(dt.Compute("sum([Gross Payout])", "true").ToString()) ? "0.00" : dt.Compute("sum([Gross Payout])", "true").ToString());

                if (sortExpression != null)
                {
                    DataView dv = dt.AsDataView();
                    this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                    dv.Sort = sortExpression + " " + this.SortDirection;
                    GridView1.DataSource = dv;
                    GridView1.DataBind();

                }
                else
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        catch (Exception ex)
        {
        }

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid(null);
    }
    protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid(null);
    }
   
    private void Bind_Month()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(@"Select [Month], Dates From (Select Distinct [Month]=Cast(DateName(Month, PayToDate) as nvarchar(3)) + '-' + RIGHT(DateName(Year, PayToDate),2),
        Dates=Cast('01' + Cast(DateName(Month, PayToDate) as nvarchar(3)) + ' ' + RIGHT(DateName(Year, PayToDate),2) as date)
        from rePayoutDate) t order by t.Dates desc");
        if (dt.Rows.Count > 0)
        {
            ddl_Month.DataSource = dt;
            ddl_Month.DataTextField = "Month";
            ddl_Month.DataValueField = "Month";
            ddl_Month.DataBind();
        }
        else
        {
            ddl_Month.Items.Clear();
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {

        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindGrid(null);
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "MonthlyGenerationPerformance.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");

    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {


        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindGrid(null);
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "MonthlyGenerationPerformance.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");

    }

}