using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient; 
using System.Web.UI.WebControls;

public partial class secretadmin_FranchisePayoutDetails : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
            {
                utility.CheckSuperAdminlogin();
            }
            else if (Convert.ToString(Session["admintype"]) == "a")
            {
                utility.CheckAdminloginInside();
            }
            else
            {
                Response.Redirect("adminLog.aspx", false);
            }
            if (!IsPostBack)
            {
                Bind_FranchiseType();
                getList();
            }
        }
        catch
        {

        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string payoutno, string Franchiseid, string FranType)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@maxpayoutno", payoutno),
                new SqlParameter("@FranchiseId", Franchiseid),
                new SqlParameter("@FranType", FranType)
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetFtranDetails");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                data.Franchise_ID = dr["Franchise ID"].ToString();
                data.Franchise_Name = dr["Franchise Name"].ToString();
                data.Franchise_Type = dr["Franchise Type"].ToString();
                data.PAN = dr["PAN"].ToString();
                data.Bank = dr["Bank"].ToString();
                data.Branch = dr["Branch"].ToString();
                data.Account_No = dr["Account No"].ToString();
                data.IFSC_Code = dr["IFSC Code"].ToString();
                data.FPV = dr["FPV"].ToString();
                data.APV = dr["APV"].ToString();

                data.Commission_on_FPV = dr["Commission on FPV"].ToString();
                data.Commission_on_APV = dr["Commission on APV"].ToString();
                data.Stock_Value_as_on_5th_Day = dr["Stock Value as on 5th Day"].ToString();
                data.Opening_Amount = dr["Opening Amount"].ToString();
                data.Maintainance_Expenses = dr["Maintainance Expenses"].ToString();
                data.Offer_Income = dr["Offer Income"].ToString();
                data.Total_Commission = dr["Total Commission"].ToString();
                data.TDS = dr["TDS"].ToString();
                data.Dispatch_Amount = dr["Dispatch Amount"].ToString();
                data.FromDate = dr["FromDate"].ToString();
                data.ToDate = dr["ToDate"].ToString();
                data.PayoutNo = dr["PayoutNo"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Franchise_ID { get; set; }
        public string Franchise_Name { get; set; }
        public string Franchise_Type { get; set; }
        public string PAN { get; set; }
        public string Bank { get; set; }
        public string Branch { get; set; }
        public string Account_No { get; set; }
        public string IFSC_Code { get; set; }
        public string FPV { get; set; }
        public string APV { get; set; }
        public string Commission_on_FPV { get; set; }
        public string Commission_on_APV { get; set; }
        public string Stock_Value_as_on_5th_Day { get; set; }
        public string Opening_Amount { get; set; }
        public string Maintainance_Expenses { get; set; }
        public string Offer_Income { get; set; }
        public string Total_Commission { get; set; }
        public string TDS { get; set; }
        public string Dispatch_Amount { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string PayoutNo { get; set; }
    }


    public void getList()
    {
        DataUtility Dutil = new DataUtility();
        DataTable dt = Dutil.GetDataTableSP("FpayoutList");
        if (dt.Rows.Count > 0)
        {
            ddlDateRange.Items.Clear();
            ddlDateRange.DataSource = dt;
            ddlDateRange.DataTextField = "payoutdate";
            ddlDateRange.DataValueField = "PayoutNo";
            ddlDateRange.DataBind();
        }
        else
        {
            ddlDateRange.Items.Insert(0, new System.Web.UI.WebControls.ListItem("No Payout", "0"));
        }
    }

    private void Bind_FranchiseType()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4 and UserVal in (2,3,4,5,6)");
        if (dt.Rows.Count > 0)
        {
            ddl_FranType.DataSource = dt;
            ddl_FranType.DataTextField = "Item_Desc";
            ddl_FranType.DataValueField = "Frantype";
            ddl_FranType.DataBind();
            ddl_FranType.Items.Insert(0, new ListItem("Select", "0"));
        }
        else
        {
            ddl_FranType.Items.Clear();
            ddl_FranType.Items.Insert(0, new ListItem("Select", "0"));
        }
    }

    #endregion
 
}