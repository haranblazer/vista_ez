using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class secretadmin_WeeklyPayoutStatement : System.Web.UI.Page
{
    string Regno = "";
    string payoutno = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        utility objUtil = new utility();

          Regno = objUtil.base64Decode(Request.QueryString["id"]);
          payoutno = objUtil.base64Decode(Request.QueryString["n"]);
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
                // lbl_TPL lbl_TPR lbl_NPL lbl_NPR
                //lblTotalBVGroupA lblTotalBVGroupB    lbl_CFL lbl_CFR
                //  lblTotalMatchedBVGroupA  lblTotalMatchedBVGroupB
                //lblTotalMatchedBVGroupA.Text = dt.Rows[0][" "].ToString();
                //lblTotalMatchedBVGroupB.Text = dt.Rows[0][" "].ToString();
                //     <% --lbl_BFL lbl_BFR lbl_NPL  lbl_NPR lbl_TML  lbl_TMR lbl_CFL  lbl_CFR  lblTotalBVGroupA  lblTotalBVGroupB-- %>
                lblRank.Text = dt.Rows[0]["RankName"].ToString();
                lblTotalBVGroupA.Text = dt.Rows[0]["TPL"].ToString();
                lblTotalBVGroupB.Text = dt.Rows[0]["TPR"].ToString();
                lbl_TPL.Text = dt.Rows[0]["TPL"].ToString();
                lbl_TPR.Text = dt.Rows[0]["TPR"].ToString();
                lbl_NPL.Text = dt.Rows[0]["NPL"].ToString();
                lbl_NPR.Text = dt.Rows[0]["NPR"].ToString();

                lbl_TML.Text = dt.Rows[0]["CPL"].ToString();
                lbl_TMR.Text = dt.Rows[0]["CPR"].ToString();
                lbl_BFL.Text = dt.Rows[0]["bfl"].ToString();
                lbl_BFR.Text = dt.Rows[0]["bfr"].ToString();
                lbl_SRBV.Text = dt.Rows[0]["TotalBV"].ToString();
                lbl_FPBV.Text = dt.Rows[0]["First_PV"].ToString();
                lbl_HDBV.Text = dt.Rows[0]["Highest_Leg_1"].ToString();
                lbl_SHBV.Text = dt.Rows[0]["Highest_Leg_2"].ToString();
                lbl_ROLBV.Text = dt.Rows[0]["Rest_Legs"].ToString();
                lbl_CFL.Text = dt.Rows[0]["CFL"].ToString();
                lbl_CFR.Text = dt.Rows[0]["CFR"].ToString();
                lbl_PV.Text = dt.Rows[0]["PBVAmt"].ToString();

                lblname.Text = dt.Rows[0]["appmstfname"].ToString();
                lblmobile.Text = dt.Rows[0]["appmstmobile"].ToString();
                lblpanno.Text = dt.Rows[0]["panno"].ToString();
                lbladdress.Text = dt.Rows[0]["appmstaddress1"].ToString();
                lblid.Text = dt.Rows[0]["appmstregno"].ToString();
                lbl_date.Text = dt.Rows[0]["Date"].ToString();
                lbl_user.Text = dt.Rows[0]["Appmstregno"].ToString() + " " + dt.Rows[0]["Appmstfname"].ToString();
                lbl_sponsor.Text = dt.Rows[0]["Sponsorid"].ToString() + " " + dt.Rows[0]["SponsorName"].ToString();
                lbl_PAN.Text = dt.Rows[0]["panno"].ToString();
                lbl_Company.Text = dt.Rows[0]["Company"].ToString();
                lblfrmdate.Text = dt.Rows[0]["FromD"].ToString();
                lbltodate.Text = dt.Rows[0]["ToD"].ToString();
                lbl_Status.Text = dt.Rows[0]["Status"].ToString();
                //lbl_BF_self_TPV.Text = dt.Rows[0]["BF_Self_TPV"].ToString();
                //lbl_self_TPV.Text = dt.Rows[0]["Self_TPV"].ToString();
                //lbl_CF_self_TPV.Text = dt.Rows[0]["CF_Self_TPV"].ToString();

                lbl_TopperType.Text = dt.Rows[0]["TopperType"].ToString();
                lbl_TopperRank.Text = dt.Rows[0]["RankName"].ToString();
                lblpayoutno.Text = dt.Rows[0]["PayoutNo"].ToString();
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

       // ChildData();
    }



    public void ChildData()
    {

        DataUtility objDu = new DataUtility();
        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@Regno", Regno),
            new SqlParameter("@payoutno", payoutno)
        }; 
        DataTable dt = objDu.GetDataTable(param, @"Select a.AppMstRegNo, a.AppMstFName, CarryForward=isnull(TI.cfl,0)+ isnull(TI.cfr,0), GRP_TPV=isnull(TI.GRP_TPV,0) 
        from TopperWeeklyIncome TI Join AppMst a on TI.appmstid1=a.AppMstID where TI.payoutno=@payoutno 
        and TI.appmstid1 in(Select AppMstID from AppMst where SponsorID=(Select AppMstID from AppMst where AppMstRegNo=@Regno)) order by isnull(TI.GRP_TPV,0) desc"); 
        if (dt.Rows.Count > 0)
        {
            Repeater.DataSource = dt;
            Repeater.DataBind();
        }
        else
        {
            Repeater.DataSource = null;
            Repeater.DataBind();
        }
    }


}