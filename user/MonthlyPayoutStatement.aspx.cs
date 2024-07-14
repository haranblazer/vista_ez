using System; 
using System.Data;
using System.Data.SqlClient; 
using System.Text.RegularExpressions; 

public partial class secretadmin_WeeklyPayoutStatement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        utility objUtil = new utility();

        string Regno = objUtil.base64Decode(Request.QueryString["id"]);
        string payoutno = objUtil.base64Decode(Request.QueryString["n"]);
        if (Regex.Match(Regno + payoutno, @"^[A-Za-z0-9]*$").Success)
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
               new SqlParameter("@Regno", Regno),
               new SqlParameter("@payoutno", payoutno)
            };

            DataTable dt = objDu.GetDataTableSP(param, "GetMonthlyPayoutStatment");
            if (dt.Rows.Count > 0)
            {
                lbl_date.Text = dt.Rows[0]["Date"].ToString();
                lbl_user.Text = dt.Rows[0]["Appmstregno"].ToString() + " " + dt.Rows[0]["Appmstfname"].ToString();
                lbl_sponsor.Text = dt.Rows[0]["Sponsorid"].ToString() + " " + dt.Rows[0]["SponsorName"].ToString();
                lbl_PAN.Text = dt.Rows[0]["panno"].ToString();
                lbl_Website.Text = dt.Rows[0]["Website"].ToString();
                lbl_Company.Text = dt.Rows[0]["Company"].ToString();
                lbl_CompAddress.Text = dt.Rows[0]["CompAddress"].ToString();
                //lbl_BF_self_TPV.Text = dt.Rows[0]["BF_Self_TPV"].ToString();
                //lbl_self_TPV.Text = dt.Rows[0]["Self_TPV"].ToString();
                //lbl_CF_self_TPV.Text = dt.Rows[0]["CF_Self_TPV"].ToString();

                //lbl_TopperType.Text = dt.Rows[0]["TopperType"].ToString();

                lbl_Pairs.Text = dt.Rows[0]["TP"].ToString();
                lbl_Matching.Text = dt.Rows[0]["TotalTP"].ToString();
                lbl_TopperRank.Text = dt.Rows[0]["TopperRank"].ToString();

                //lbl_CurMatchPoint.Text = dt.Rows[0]["TP"].ToString();
                //lvl_cur_TPV.Text = dt.Rows[0]["GRP_TPV"].ToString();

                //lbl_BF_G_TPV.Text = dt.Rows[0]["BF_GRP_TPV"].ToString();
                //lbl_Curr_G_TPV.Text = dt.Rows[0]["GRP_TPV"].ToString();
                //lbl_CF_G_TPV.Text = dt.Rows[0]["CF_GRP_TPV"].ToString();

                //lbl_BusinessMatched.Text = dt.Rows[0]["TP"].ToString(); 

                lbl_Bronze_Silver.Text = dt.Rows[0]["BSF_T"].ToString();
                lbl_Gold.Text = dt.Rows[0]["GF_T"].ToString();
                lbl_Ruby.Text = dt.Rows[0]["RF_T"].ToString();
                lbl_Pearl.Text = dt.Rows[0]["PF_T"].ToString();
                lbl_Diamond.Text = dt.Rows[0]["DF_T"].ToString();
                lbl_DoubleDiamond.Text = dt.Rows[0]["DDF_T"].ToString();
                lbl_BlueDiamond.Text = dt.Rows[0]["BLUEDF_T"].ToString();
                lbl_BlackDiamond.Text = dt.Rows[0]["BLACKDF_T"].ToString();
                lbl_CrownAmbassador.Text = dt.Rows[0]["CAF_T"].ToString();
                lbl_OfferIncome.Text = dt.Rows[0]["OI_T"].ToString();
                lbl_RewardFund.Text = dt.Rows[0]["RWDF_T"].ToString();

                lbl_Incentive.Text = dt.Rows[0]["totalearning"].ToString();
                lbl_TDS.Text = dt.Rows[0]["TDS"].ToString();
                lbl_PCCharges.Text = dt.Rows[0]["handlingCharges"].ToString();
                lbl_TotalIncome.Text = dt.Rows[0]["dispachedamt"].ToString();

            }
        }
    }
}