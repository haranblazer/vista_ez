using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
public partial class admin_PayoutList : System.Web.UI.Page
{

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
            go();

        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string payoutno, string BankWallet, string iselegible)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@payoutno", payoutno),
                new SqlParameter("@orderby",  "1"),
                new SqlParameter("@BankWallet", BankWallet),
                new SqlParameter("@iselegible", iselegible)
            };
            DataUtility objDu = new DataUtility();
            utility obju = new utility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "PayoutList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Encode_Userid = obju.base64Encode(dr["appmstregno"].ToString());
                data.Encode_Payout = obju.base64Encode(dr["payoutno"].ToString());


                data.Payout_Date = dr["Payout Date"].ToString();
                data.iselegible = dr["iselegible"].ToString();
                data.appmstregno = dr["appmstregno"].ToString();
                data.User_Name = dr["User Name"].ToString();
                data.Status = dr["Status"].ToString();
                data.Release_Amt = dr["Release Amt"].ToString();
                data.Release_Paouyt = dr["Release Paouyt"].ToString();
                data.Mobile = dr["Mobile"].ToString();
                data.PAN = dr["PAN"].ToString();
                data.Bank = dr["Bank"].ToString();

                data.Branch = dr["Branch"].ToString();
                data.Account_No = dr["Account No"].ToString();
                data.IFSC_Code = dr["IFSC Code"].ToString();
                data.binaryamt = dr["binaryamt"].ToString();
                data.Closing_Counts = dr["Closing Counts"].ToString();
                data.Match_Count = dr["Match Count"].ToString();
                data.Self_Help_Qualified = dr["Self_Help_Qualified"].ToString();
                data.PBV = dr["PBV"].ToString();
                data.RoyaltyAmt = dr["RoyaltyAmt"].ToString();
                data.Payout_after_Capping = dr["Payout after Capping"].ToString();

                data.Total_Payout = dr["Total Payout"].ToString();
                data.TDS = dr["TDS"].ToString();
                data.PC_Charges = dr["PC Charges"].ToString();
                data.Dispatch_Amount = dr["Dispatch Amount"].ToString();
                data.Payout_Status = dr["Payout Status"].ToString();
                data.ID_Status = dr["ID Status"].ToString();
                data.Bank_Details = dr["Bank Details"].ToString();
                data._500_PPV = dr["500 PPV"].ToString();
                data.Left_Topper = dr["Left Topper"].ToString();
                data.Right_Topper = dr["Right Topper"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Encode_Userid { get; set; }
        public string Encode_Payout { get; set; }

        public string Payout_Date { get; set; }
        public string iselegible { get; set; }
        public string appmstregno { get; set; }
        public string User_Name { get; set; }
        public string Status { get; set; }
        public string Release_Amt { get; set; }
        public string Release_Paouyt { get; set; }
        public string Mobile { get; set; }
        public string PAN { get; set; }
        public string Bank { get; set; }
        public string Branch { get; set; }
        public string Account_No { get; set; }
        public string IFSC_Code { get; set; }

        public string binaryamt { get; set; }
        public string Closing_Counts { get; set; }
        public string Match_Count { get; set; }
        public string Self_Help_Qualified { get; set; }
        public string PBV { get; set; }
        public string RoyaltyAmt { get; set; }
        public string Payout_after_Capping { get; set; }
        public string Total_Payout { get; set; }

        public string TDS { get; set; }
        public string PC_Charges { get; set; }
        public string Dispatch_Amount { get; set; }
        public string Payout_Status { get; set; }
        public string ID_Status { get; set; }
        public string Bank_Details { get; set; }
        public string _500_PPV { get; set; }
        public string Left_Topper { get; set; }
        public string Right_Topper { get; set; }
    }


    public void go()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP("allbpayout");
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

    #endregion


}