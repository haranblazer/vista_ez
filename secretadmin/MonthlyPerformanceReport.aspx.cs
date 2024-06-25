using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_MonthlyPerformanceReport : System.Web.UI.Page
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
            Bind_FranchiseTypeEdit();
            Bind_Month();
        }
    }
    // + '", : "' + FranType + '", Active: "' + Active + '", 


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string Month, string FranType, string Active, string Franchiseid)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Month", Month),
                new SqlParameter("@FranType", FranType),
                new SqlParameter("@appmstActivate", Active),
                new SqlParameter("@FranchiseID", Franchiseid)
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetFranchisePerformanceByAdmin");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Month = dr["Month"].ToString();
                data.FranchiseId = dr["FranchiseId"].ToString();
                data.FranchiseName = dr["FranchiseName"].ToString();
                data.District = dr["District"].ToString();
                data.State = dr["State"].ToString();
                data.Mobile = dr["Mobile"].ToString();
                data.PurchaseValue = dr["PurchaseValue"].ToString();
                data.AssociateSalesValue = dr["AssociateSalesValue"].ToString();
                data.FranchiseSalesValue = dr["FranchiseSalesValue"].ToString();
                data.ClosingStock = dr["ClosingStock"].ToString();
                data.CommissionGenerated = dr["CommissionGenerated"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {

        public string Month { get; set; }
        public string FranchiseId { get; set; }
        public string FranchiseName { get; set; }
        public string District { get; set; }
        public string State { get; set; }
        public string Mobile { get; set; }
        public string PurchaseValue { get; set; }
        public string AssociateSalesValue { get; set; }
        public string FranchiseSalesValue { get; set; }
        public string ClosingStock { get; set; }
        public string CommissionGenerated { get; set; }

    }


    private void Bind_Month()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select PayToDate=convert(varchar, PayToDate, 23), [Month]=Cast(DateName(Month, PayToDate) as nvarchar(3)) + '-' + RIGHT(DateName(Year, PayToDate),2)  from Fpayoutdate order by Payoutno desc");
        if (dt.Rows.Count > 0)
        {
            ddl_Month.DataSource = dt;
            ddl_Month.DataTextField = "Month";
            ddl_Month.DataValueField = "PayToDate";
            ddl_Month.DataBind();
        }
        else
        {
            ddl_Month.Items.Clear();
        }
    }


    private void Bind_FranchiseTypeEdit()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4 and UserVal not in (1, 7, 8, 9, 10)");
        if (dt.Rows.Count > 0)
        {
            ddl_FranType.DataSource = dt;
            ddl_FranType.DataTextField = "Item_Desc";
            ddl_FranType.DataValueField = "Frantype";
            ddl_FranType.DataBind();
            ddl_FranType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "-1"));
            ddl_FranType.SelectedValue = "2";
        }
        else
        {
            ddl_FranType.Items.Clear();
            ddl_FranType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "-1"));
        }
    }


    #endregion


    //private string SortDirection
    //{
    //    get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
    //    set { ViewState["SortDirection"] = value; }
    //}

    //protected void OnSorting(object sender, GridViewSortEventArgs e)
    //{

    //    string SortDir = string.Empty;
    //    this.BindGrid(e.SortExpression);
    //    if (ViewState["SortDirection"].ToString() == "ASC")
    //    {
    //        SortDir = "Sorting in ascending order.";
    //    }
    //    else
    //    {
    //        SortDir = "Sorting in descending order.";
    //    }
    //}

    //private void BindGrid(string sortExpression)
    //{

    //    try
    //    {

    //        SqlParameter[] param = new SqlParameter[]
    //       {
    //            new SqlParameter("@Month", ddl_Month.SelectedValue),
    //            new SqlParameter("@FranchiseID", txt_Franchiseid.Text.Trim()),
    //            new SqlParameter("@FranType", ddl_FranType.SelectedValue),
    //            new SqlParameter("@appmstActivate", ddl_Active.SelectedValue)
    //       };
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTableSP(param, "GetFranchisePerformanceByAdmin");

    //        if (dt.Rows.Count > 0)
    //        {
    //            GridView1.PageSize = ddPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddPageSize.SelectedValue.ToString());

    //            GridView1.Columns[3].FooterText = "Total: ";
    //            GridView1.Columns[7].FooterText = dt.Compute("sum(PurchaseValue)", "true").ToString();
    //            GridView1.Columns[8].FooterText = dt.Compute("sum(AssociateSalesValue)", "true").ToString();
    //            GridView1.Columns[9].FooterText = dt.Compute("sum(FranchiseSalesValue)", "true").ToString();
    //            GridView1.Columns[10].FooterText = dt.Compute("sum(ClosingStock)", "true").ToString();
    //            GridView1.Columns[11].FooterText = dt.Compute("sum(CommissionGenerated)", "true").ToString();


    //            if (sortExpression != null)
    //            {
    //                DataView dv = dt.AsDataView();
    //                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
    //                dv.Sort = sortExpression + " " + this.SortDirection;
    //                GridView1.DataSource = dv;
    //                GridView1.DataBind();

    //            }
    //            else
    //            {
    //                GridView1.DataSource = dt;
    //                GridView1.DataBind();
    //            }
    //        }
    //        else
    //        {
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //    }

    //}

    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindGrid(null);
    //}
    //protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    BindGrid(null);
    //}



    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}

    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{

    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        BindGrid(null);
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "MonthlyPerformanceReport.xls");
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        GridView1.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");

    //}


    //protected void btn_search_Click(object sender, EventArgs e)
    //{
    //    BindGrid(null);
    //}


}