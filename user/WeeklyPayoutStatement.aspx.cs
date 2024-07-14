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

            DataTable dt = objDu.GetDataTableSP(param, "GetWeekltyPayoutStatment");
            if (dt.Rows.Count > 0)
            {
                lbl_date.Text = dt.Rows[0]["Date"].ToString();
                lbl_user.Text = dt.Rows[0]["Appmstregno"].ToString() + " " + dt.Rows[0]["Appmstfname"].ToString();
                lbl_sponsor.Text = dt.Rows[0]["Sponsorid"].ToString() + " " + dt.Rows[0]["SponsorName"].ToString();
                lbl_PAN.Text = dt.Rows[0]["panno"].ToString();
                lbl_Company.Text = dt.Rows[0]["Company"].ToString();
                lbl_CompAddress.Text = dt.Rows[0]["Comp_address"].ToString();
                lbl_Website.Text = dt.Rows[0]["website"].ToString();


                
                //lbl_BF_self_TPV.Text = dt.Rows[0]["BF_Self_TPV"].ToString();
                //lbl_self_TPV.Text = dt.Rows[0]["Self_TPV"].ToString();
                //lbl_CF_self_TPV.Text = dt.Rows[0]["CF_Self_TPV"].ToString();

                lbl_TopperType.Text = dt.Rows[0]["TopperType"].ToString();
                lbl_TopperRank.Text = dt.Rows[0]["TopperRank"].ToString();

                //lbl_BF_G_TPV.Text = dt.Rows[0]["BF_GRP_TPV"].ToString();
                //lbl_Curr_G_TPV.Text = dt.Rows[0]["GRP_TPV"].ToString();
                //lbl_CF_G_TPV.Text = dt.Rows[0]["CF_GRP_TPV"].ToString();

                lbl_Pairs.Text = dt.Rows[0]["TP"].ToString();
                lbl_Matche.Text = dt.Rows[0]["TotalTP"].ToString();

                lbl_Incentive.Text = dt.Rows[0]["BinaryInc"].ToString();
                lbl_MatchingInc.Text = dt.Rows[0]["BinaryInc"].ToString();

                lbl_TDS.Text = dt.Rows[0]["TDS"].ToString();
                lbl_PCCharges.Text = dt.Rows[0]["handlingCharges"].ToString();

                lbl_TotalIncome.Text = dt.Rows[0]["dispachedamt"].ToString();

            }
        }
    }
}