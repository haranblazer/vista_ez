using System;
using System.Data; 
using System.Data.SqlClient; 
using System.Collections.Generic;

public partial class secretadmin_WeeklyPayoutList : System.Web.UI.Page
{
    int index;
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da = null;
    DataTable dt = null;
    utility objUtil = new utility();
    int joinTotal1 = 0;
    int joinTotal2 = 0; int joinTotal3 = 0; int joinTotal4 = 0; int joinTotal5 = 0;
    string value = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
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
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetTopperWeeklyList");
            while (dr.Read())
            {
                
                UserDetails data = new UserDetails();
                data.Encode_Userid = obju.base64Encode(dr["appmstregno"].ToString()); 
                data.Encode_Payout = obju.base64Encode(dr["payoutno"].ToString());


                data.Payout_Period = dr["Payout Period"].ToString();
                data.appmstregno = dr["appmstregno"].ToString();
                data.iselegible = dr["iselegible"].ToString();
                data.User_Name = dr["User Name"].ToString();
                data.Mobile = dr["Mobile"].ToString();
                data.PAN = dr["PAN"].ToString();
                data.Bank = dr["Bank"].ToString();
                data.Branch = dr["Branch"].ToString();
                data.Account_No = dr["Account No"].ToString();
                data.IFSC_Code = dr["IFSC Code"].ToString();
                data.Matching_Counts = dr["Matching Counts"].ToString();
                data.Total_Payout = dr["Total Payout"].ToString();
                data.TDS = dr["TDS"].ToString();
                data.PC_Charges = dr["PC Charges"].ToString(); 
                data.Net_Payout = dr["Net Payout"].ToString();
                data.Payout_Status = dr["Payout Status"].ToString();
                data.ID_Status = dr["ID Status"].ToString();
                data.Bank_Details = dr["Bank Details"].ToString();
                data.Self_PPV = dr["Self PPV"].ToString();
                data.Transfer_to_T_Wallet = dr["Transfer to T Wallet"].ToString();
                data.Transfer_to_C_Wallet = dr["Transfer to C Wallet"].ToString();
                data.Status = dr["Status"].ToString();
                data.Release_Amt = dr["Release Amt"].ToString();
                data.Release_Paouyt = dr["Release Paouyt"].ToString();

                data.cfl = dr["cfl"].ToString();
                data.cfr = dr["cfr"].ToString();
                data.PBVAmt = dr["PBVAmt"].ToString();
                data.GBVAmt = dr["GBVAmt"].ToString();
                data.GRP_TPV = dr["GRP_TPV"].ToString();
                data.CPL = dr["CPL"].ToString();
                data.CPR = dr["CPR"].ToString();
                data.bfl = dr["bfl"].ToString();
                data.bfr = dr["bfr"].ToString();
                data.TotalBV = dr["TotalBV"].ToString();
                data.First_PV = dr["First_PV"].ToString();
                data.Highest_Leg_1 = dr["Highest_Leg_1"].ToString();
                data.Highest_Leg_2 = dr["Highest_Leg_2"].ToString();
                data.Rest_Legs = dr["Rest_Legs"].ToString();
                data.RankName = dr["RankName"].ToString();



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

        public string Payout_Period { get; set; }
        public string appmstregno { get; set; }
        public string iselegible { get; set; }
        public string User_Name { get; set; }
        public string Mobile { get; set; }
        public string PAN { get; set; }
        public string Bank { get; set; }
        public string Branch { get; set; }
        public string Account_No { get; set; }
        public string IFSC_Code { get; set; }
        public string Matching_Counts { get; set; }
        public string Total_Payout { get; set; }
        public string TDS { get; set; }
        public string PC_Charges { get; set; }
        public string Net_Payout { get; set; }
        public string Payout_Status { get; set; }
        public string ID_Status { get; set; }
        public string Bank_Details { get; set; }
        public string Self_PPV { get; set; }
        public string Transfer_to_T_Wallet { get; set; }
        public string Transfer_to_C_Wallet { get; set; }
        public string Status { get; set; }
        public string Release_Amt { get; set; }
        public string Release_Paouyt { get; set; }

        public string cfl { get; set; }
        public string cfr { get; set; }
        public string PBVAmt { get; set; }
        public string GBVAmt { get; set; }
        public string GRP_TPV { get; set; }



        public string CPL { get; set; }
        public string CPR { get; set; }
        public string bfl { get; set; }
        public string bfr { get; set; }
        public string TotalBV { get; set; }
        public string First_PV { get; set; }
           
        public string Highest_Leg_1 { get; set; }
        public string Highest_Leg_2 { get; set; }
        public string Rest_Legs { get; set; }
        public string RankName { get; set; }


    }

    public void go()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP("Weeklypayout");
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