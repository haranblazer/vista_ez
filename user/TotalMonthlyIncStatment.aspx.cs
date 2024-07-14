using System;
using System.Data;
using System.Data.SqlClient;

public partial class User_TotalMonthlyIncStatment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
            return;
        }

        utility objUtil = new utility();

        string Month = objUtil.base64Decode(Request.QueryString["m"]);

        DataUtility objDu = new DataUtility();
        SqlParameter[] param = new SqlParameter[]
        {
               new SqlParameter("@Regno", Session["userId"].ToString()),
               new SqlParameter("@Month", Month)
        };

        DataTable dt = objDu.GetDataTableSP(param, "TotalMonthlyIncStatment");
        if (dt.Rows.Count > 0)
        {
            lbl_date.Text = dt.Rows[0]["Date"].ToString();
            lbl_user.Text = dt.Rows[0]["Appmstregno"].ToString() + " " + dt.Rows[0]["Appmstfname"].ToString();
            lbl_sponsor.Text = dt.Rows[0]["Sponsorid"].ToString() + " " + dt.Rows[0]["SponsorName"].ToString();
            lbl_PAN.Text = dt.Rows[0]["panno"].ToString();
            lbl_Website.Text = dt.Rows[0]["Website"].ToString();
            lbl_Company.Text = dt.Rows[0]["Company"].ToString();
            lbl_CompAddress.Text = dt.Rows[0]["CompAddress"].ToString();

            lbl_RepurchaseRank.Text = dt.Rows[0]["RepurchaseRank"].ToString();
            //lbl_TopperRank.Text = dt.Rows[0]["TopperRank"].ToString();


            //lbl_TopperMatchingInc.Text = dt.Rows[0]["TopperMatchingInc"].ToString();
            //lbl_TopperFundInc.Text = dt.Rows[0]["TopperFundInc"].ToString();
            lbl_RepurchaseIncome.Text = dt.Rows[0]["RepurchaseIncome"].ToString();
            lbl_AnnualRoyalty.Text = dt.Rows[0]["AnnualRoyalty"].ToString();
            lbl_ProdWallet.Text = dt.Rows[0]["PW_Wallet"].ToString();
            lbl_TotalIncome.Text = dt.Rows[0]["TotalIncome"].ToString();

        }

    }
}