using System;
using System.Data;
using System.Data.SqlClient; 
using System.Web.Services; 

public partial class User_DashboardTopper : System.Web.UI.Page
{
  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
            Response.Redirect("~/Default.aspx", true);

        if (!IsPostBack)
        { 
            GetUserInfo();
            GetImageList(); 
        }
    }


    public void GetImageList()
    {
        try
        {
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP("GetImagePopup");
            div_Popup_img.InnerHtml = "";
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["SelectType"].ToString().Contains("A"))
                {
                    div_Popup_img.InnerHtml += "<img src='../images/PopupImage/" + dt.Rows[0]["imagename"].ToString() + "' width='100%'/>";
                    hnd_Popup.Value = "1";
                }
            }
        }
        catch (Exception er) { }
    }


    private void GetUserInfo()
    {
        SqlParameter[] param = new SqlParameter[]
        {
             new SqlParameter("@regno", Session["userId"].ToString())
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "getUserMaster1");
        if (dt.Rows.Count > 0)
        {
            /************************ Repurchase *****************************/
            
            ProfileImage.ImageUrl = "~/images/KYC/ProfileImage/" + dt.Rows[0]["imagename"].ToString();
            lblUserName.Text = dt.Rows[0]["appmstfname"].ToString();
            lbl_usrid.Text = dt.Rows[0]["appmstregno"].ToString();
             

            /************************ Topper *****************************/
            lblTotLeftBV.Text = dt.Rows[0]["AppMstLeftTotal"].ToString();
            lblTotRightBV.Text = dt.Rows[0]["AppMstRightTotal"].ToString();
            lblNewLeftBV.Text = dt.Rows[0]["TotalNewLeft"].ToString();
            lblNewRightBV.Text = dt.Rows[0]["TotalNewRight"].ToString();
            lblTotCarryLeftBV.Text = dt.Rows[0]["CarryLeft"].ToString();
            lblTotCarryRightBV.Text = dt.Rows[0]["CarryRight"].ToString();
            lbl_Cur_Month_Pair.Text = dt.Rows[0]["Cur_Month_Pair"].ToString();
            lblcpl.Text = dt.Rows[0]["Pairrank"].ToString();
            lbl_BinaryRank.Text = dt.Rows[0]["Biary_rank"].ToString() + "/ " + dt.Rows[0]["JoinFor"].ToString();

            lbl_CummulativeJoinfor.Text = dt.Rows[0]["NewJoinFor"].ToString();
            lbl_SelfTopper.Text = dt.Rows[0]["SelfTopper"].ToString();
            lbl_ValidityDateTopper.Text = dt.Rows[0]["ValidityDateTopper"].ToString();

            lbl_DailyPayoutTime.InnerText = dt.Rows[0]["DailyPayoutDate_Dis"].ToString();
            lbl_MonthlyPayoutTime.InnerText = dt.Rows[0]["MonthlyPayoutDate_Dis"].ToString();
            lbl_LoyaltyPayoutTime.InnerText = dt.Rows[0]["WeeklyPayoutDate_Dis"].ToString();

            hnf_DailyPayoutDate.Value = dt.Rows[0]["DailyPayoutDate"].ToString();
            hnf_WeeklyPayoutDate.Value = dt.Rows[0]["WeeklyPayoutDate"].ToString();
            hnf_MonthlyPayoutDate.Value = dt.Rows[0]["MonthlyPayoutDate"].ToString();

            lbl_TopperBal.InnerHtml = dt.Rows[0]["TopperWalletBal"].ToString();
            lbl_RewardBal.InnerHtml = dt.Rows[0]["RewardWalletBal"].ToString();

        }
    }
     

    [WebMethod]
    public static string CurrencyFormate(string Amount)
    {
        return common.CurrencyFormate(Amount);
    }
 
}
 