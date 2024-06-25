using System; 
using System.Data.SqlClient;
using System.Data; 
using System.Collections.Generic;

public partial class admin_payoutlist1 : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
     
    protected void Page_Load(object sender, EventArgs e)
    {

        //Response.Cache.SetAllowResponseInBrowserHistory(true);

        //Response.Cache.SetNoStore();
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
            BindPayout();
            RankBind();

        }
    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string payoutno, string Payout_Fillter, string UserId, string IsKYC, string RankId, string ReqTypeSponsor, string Condition)  
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@payoutno", payoutno),
                new SqlParameter("@iselegible", Payout_Fillter),
                new SqlParameter("@UserId", UserId), 
                new SqlParameter("@IsKYC", IsKYC),
                new SqlParameter("@RankId", RankId),
                new SqlParameter("@ReqTypeSponsor", ReqTypeSponsor),
                new SqlParameter("@Condition", Condition),
            };
            DataUtility objDu = new DataUtility();
            utility obju=new utility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "PayoutList1");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.BackGroundImg = dr["BackGroundImg"].ToString();
                data.Encode_Userid = obju.base64Encode( dr["appmstregno"].ToString());
                data.Encode_Appmstid = obju.base64Encode(dr["appmstid1"].ToString());
                data.Encode_Payout = obju.base64Encode(dr["payoutno"].ToString());
                 
                data.iselegible = dr["iselegible"].ToString();
                data.Payout_Date = dr["Payout Date"].ToString();
                data.appmstregno = dr["appmstregno"].ToString();
                data.User_Name = dr["User Name"].ToString();
                data.Status = dr["Status"].ToString();

                data.Mobile = dr["Mobile"].ToString();
                data.Profit_Level = dr["Profit Level"].ToString();
                data.PIN = dr["PIN"].ToString();
                data.PAN = dr["PAN"].ToString();
                data.Bank = dr["Bank"].ToString();

                data.Branch = dr["Branch"].ToString();
                data.Account_No = dr["Account No"].ToString();
                data.IFSC_Code = dr["IFSC Code"].ToString();
                data.PPV = dr["PPV"].ToString();
                data.GPV = dr["GPV"].ToString();

                data.TPV = dr["TPV"].ToString();
                data.FSI = dr["FSI"].ToString();
                data.leadershipamt = dr["leadershipamt"].ToString();
                data.ZM = dr["ZM"].ToString();
                data.GM = dr["GM"].ToString();

                data.CM = dr["CM"].ToString();
                data.TI = dr["TI"].ToString();
                data.DepthAmt = dr["DepthAmt"].ToString();
                data.TF = dr["TF"].ToString();
                data.HF = dr["HF"].ToString();

                data.CF = dr["CF"].ToString();
                data.PR = dr["PR"].ToString();
                data.PB = dr["PB"].ToString();
                data.RB = dr["RB"].ToString();
                data.BF = dr["BF"].ToString();

                data.GrowthAmt = dr["GrowthAmt"].ToString();
                data.MG1 = dr["MG1"].ToString();
                data.MG2 = dr["MG2"].ToString();
                data.MG3 = dr["MG3"].ToString();
                data.MG4 = dr["MG4"].ToString();

                data.Offer_Income = dr["Offer Income"].ToString();
                data.PF = dr["PF"].ToString();
                data.OI3 = dr["OI3"].ToString();
                data.OI4 = dr["OI4"].ToString();
                data.Referral_Incentive = dr["Referral Incentive"].ToString();

                data.MG = dr["MG"].ToString();
                data.Total_Income = dr["Total Income"].ToString();
                data.TDS = dr["TDS"].ToString();
                data.PC = dr["PC"].ToString();
                data.Dispatch_Amount = dr["Dispatch Amount"].ToString();
                data.Remark = dr["Remark"].ToString();

                data.State = dr["State"].ToString();
                data.District = dr["District"].ToString();
                data.Month = dr["Month"].ToString();
                data.imagename = dr["imagename"].ToString();
                 data.Tlper = dr["Tlper"].ToString();
                data.Inc1 = dr["Inc1"].ToString();
                data.Inc2 = dr["Inc2"].ToString();
                data.Inc3 = dr["Inc3"].ToString();
                data.Inc4 = dr["Inc4"].ToString();
                data.Inc5 = dr["Inc5"].ToString();
                data.Inc6 = dr["Inc6"].ToString();
                data.Inc7 = dr["Inc7"].ToString();
                data.PP = dr["PP"].ToString();
                data.Matched = dr["tp"].ToString();
                //data.PanApiName = dr["PanApiName"].ToString();
                //data.OnlinePanVerify = dr["OnlinePanVerify"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string BackGroundImg { get; set; }
        public string Encode_Userid { get; set; }
        public string Encode_Appmstid { get; set; }
        public string Encode_Payout { get; set; }

        public string iselegible { get; set; }
        public string Payout_Date { get; set; }
        public string appmstregno { get; set; }
        public string User_Name { get; set; }
        public string Status { get; set; }
        public string Mobile { get; set; }
        public string Profit_Level { get; set; }
        public string PIN { get; set; }
        public string PAN { get; set; }
        public string Bank { get; set; }
        public string Branch { get; set; }
        public string Account_No { get; set; }
        public string IFSC_Code { get; set; }
        public string PPV { get; set; }
        public string GPV { get; set; }
        public string TPV { get; set; }
        public string FSI { get; set; }
        public string leadershipamt { get; set; }
        public string ZM { get; set; }
        public string GM { get; set; }
        public string CM { get; set; }

        public string TI { get; set; }
        public string DepthAmt { get; set; }
        public string TF { get; set; }
        public string HF { get; set; }
        public string CF { get; set; }
        public string PR { get; set; }
        public string PB { get; set; }

        public string RB { get; set; }
        public string BF { get; set; }
        public string GrowthAmt { get; set; }

        public string MG1 { get; set; }
        public string MG2 { get; set; }
        public string MG3 { get; set; }
        public string MG4 { get; set; }
        public string Offer_Income { get; set; }
        public string PF { get; set; }
        public string OI3 { get; set; }
        public string OI4 { get; set; }
        public string Referral_Incentive { get; set; }
        public string MG { get; set; }
        public string Total_Income { get; set; }
        public string TDS { get; set; }
        public string PC { get; set; }
        public string Dispatch_Amount { get; set; }
        public string Remark { get; set; }

        public string State { get; set; }
        public string District { get; set; }
        public string Month { get; set; }
        public string imagename { get; set; }

        public string Tlper { get; set; }
        public string PanApiName { get; set; }
        public string OnlinePanVerify { get; set; }
        public string Inc1 { get; set; }
        public string Inc2 { get; set; }
        public string Inc3 { get; set; }
        public string Inc4 { get; set; }
        public string Inc5 { get; set; }
        public string Inc6 { get; set; }
        public string Inc7 { get; set; }
        public string PP { get; set; }
        public string Matched { get; set; }

    }


    public void BindPayout()
    {
        SqlDataAdapter da = new SqlDataAdapter("select distinct convert(char(10),paymentfromdate,103)+'-'+convert(char(10),paymenttodate,103)+'-('+convert(varchar(3),payoutno)+')' as pname,payoutno from repaymenttrandraft order by Payoutno desc", con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlDateRange.Items.Clear();
            ddlDateRange.DataSource = dt;
            ddlDateRange.DataTextField = "pname";
            ddlDateRange.DataValueField = "payoutno";
            ddlDateRange.DataBind();
        }
        else
        {
            ddlDateRange.Items.Insert(0, new System.Web.UI.WebControls.ListItem("No Payout", "0"));
        }
    }


    public void RankBind()
    {
        SqlDataAdapter da = new SqlDataAdapter("Select Rankid, RankName from RePurchase_Slab Where Rankid>=4 order by Rankid", con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddl_Rank.Items.Clear();
            ddl_Rank.DataSource = dt;
            ddl_Rank.DataTextField = "RankName";
            ddl_Rank.DataValueField = "Rankid";
            ddl_Rank.DataBind();
            ddl_Rank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
        else
        {
            ddl_Rank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
    }


    #endregion
     
}