using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using System.Web;
using System.Collections.Generic;


public partial class User_Dashboard : System.Web.UI.Page
{

    SqlDataReader sr;
    SqlCommand com;
    string str1;
    public string m1timer, m1timer2;
    public string str2;
    public string progressbarval, progressbarcv;
    string RegNo;
    SqlConnection con = new SqlConnection(method.str);
    string idno;
    utility utl = new utility();
    StringBuilder sbNews = new StringBuilder();
    StringBuilder timer = new StringBuilder();
    SqlDataAdapter sda;
    DataTable dt = new DataTable();
    StringBuilder offernews = new StringBuilder();
    StringBuilder productinfonews = new StringBuilder();
    int i = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
            Response.Redirect("~/Default.aspx", true);

        if (!IsPostBack)
        {

            // news();
            GetUserInfo();
            LeftRight();
            //GetImageList();
            GetLoyalty();
            RetailBooster();
            // Months();
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
            int flag = 0;
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["SelectType"].ToString().Contains("A"))
                {

                    foreach (DataRow dr in dt.Rows)
                    {
                        if (flag == 0)
                        {
                            div_Popup_img.InnerHtml += "<div class='carousel-item active'> <img class='d-block w-100' src='../images/PopupImage/" + dr["imagename"].ToString() + "' > </div>";
                        }
                        else
                        {
                            div_Popup_img.InnerHtml += "<div class='carousel-item'> <img class='d-block w-100' src='../images/PopupImage/" + dr["imagename"].ToString() + "' > </div>";
                        }
                        flag++;
                        /* 
                        
                        <div class="carousel-item">
                            <img class="d-block w-100" src="https://toptimenet.com/images/SliderImage/show%20the%20plan%20(1).jpg">
                        </div>                      
                    </div> */

                        //div_Popup_img.InnerHtml += "<img src='../images/PopupImage/" + dr["imagename"].ToString() + "' width='100%'/>";
                        hnd_Popup.Value = "1";
                    }

                }
            }
        }
        catch (Exception er) { }
    }



    #region check_KYC
    [WebMethod]
    public static Kyc[] CheckStatus()
    {
        List<Kyc> kycdetails = new List<Kyc>();
        if (HttpContext.Current.Session["userId"] != null)
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand(@"select a.panno, s.panImage, 
            
            pkstatus=(Case when (s.pstatus='2' or s.OnlinePanVerify='1') then '2' else isnull(s.pstatus,0) end),
            bkstatus=isnull(s.bankstatus,0), s.BankImage,
            aastatus=(Case when (s.aastatus='2' or s.OnlineAadharVerify='1') then '2' else isnull(s.aastatus,0) end), 
            s.Aadharfront, s.AadharBack,  a.Verified as verified 
            from scandocs s inner join AppMst a on s.Appmstid=a.AppMstID where a.AppMstRegNo='" + HttpContext.Current.Session["userId"] + "'", con);
            com.CommandType = CommandType.Text;
            com.CommandTimeout = 999999;
            con.Open();
            SqlDataReader dr = com.ExecuteReader();
            if (dr.HasRows == true)
            {
                while (dr.Read())
                {
                    Kyc kycdet = new Kyc();
                    kycdet.psts = dr["pkstatus"].ToString();
                    kycdet.bsts = dr["bkstatus"].ToString();
                    kycdet.asts = dr["aastatus"].ToString();
                    kycdet.veri = dr["verified"].ToString();
                    kycdetails.Add(kycdet);
                }
            }
        }
        return kycdetails.ToArray();

    }
    #endregion

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

            hnf_LastActiveDate.Value = dt.Rows[0]["LastActiveDate"].ToString();

            lblSponsor.Text = lblSponsor_FirstPurch.InnerText = dt.Rows[0]["directsalesTotal"].ToString();
            lblPaidSponsor_FirstPurch.InnerText = lblPaidSponsor.Text = dt.Rows[0]["AppMstSponsorTotal"].ToString();

            lbl_RepurchaseRank.Text = lbl_RepurchaseRank_FirstPurch.InnerText = dt.Rows[0]["RePurchase_rankName"].ToString();
            lbl_NoOfAssociate.Text = lbl_NoOfAssociate_FirstPurch.InnerHtml = dt.Rows[0]["TotalMember"].ToString();


            ProfileImage.ImageUrl = "~/images/KYC/ProfileImage/" + dt.Rows[0]["imagename"].ToString();


            lbl_UserName_CWallet.Text = lbl_UserName_PWallet.Text = lbl_UserName_GWallet.Text = lbl_UserName_Loyalty.Text =
            lblUserName.Text = dt.Rows[0]["appmstfname"].ToString();



            lbl_BV_Weekly.InnerHtml = dt.Rows[0]["WKLY_Self_TPV"].ToString();
            lbl_GPV_Weekly.InnerHtml = dt.Rows[0]["WKLY_GRP_TPV"].ToString();
            lbl_Matched.InnerHtml = dt.Rows[0]["nPairrank"].ToString();
            lbl_BV_Weekly_CarryForward.InnerHtml = dt.Rows[0]["CarryForward"].ToString();
            
           
            lbl_BV_Monthly.InnerHtml = dt.Rows[0]["currPBV"].ToString();
            lbl_GPV_Monthly.InnerHtml = dt.Rows[0]["currgbv"].ToString();
            lbl_First_PV.InnerHtml = dt.Rows[0]["First_PV"].ToString();
            lbl_Rest_PV.InnerHtml = dt.Rows[0]["Rest_PV"].ToString();


            lbl_usrid.Text = dt.Rows[0]["appmstregno"].ToString();
            lbl_currentMonth_PPV.Text = dt.Rows[0]["currPBV"].ToString();
            lbl_currentMonth_GPV.Text = dt.Rows[0]["currgbv"].ToString();

            lbl_currentMonth_GPV_FirstPurch.InnerHtml = lbl_currentMonth_TPV.Text = dt.Rows[0]["TPV"].ToString();
            lbl_currentMonth_TGBV.Text = (Convert.ToDouble(dt.Rows[0]["TPV"]) + Convert.ToDouble(dt.Rows[0]["currgbv"])).ToString();

            //lbl_Previous_PPV.Text = dt.Rows[0]["oldPBV"].ToString();
            //lbl_Previous_GPV.Text = dt.Rows[0]["oldGBV"].ToString();
            lbl_Previous_TPV.Text = dt.Rows[0]["oldtpv"].ToString();
            lbl_Previous_TGBV.Text = (Convert.ToDouble(dt.Rows[0]["oldtpv"]) + Convert.ToDouble(dt.Rows[0]["oldGBV"])).ToString();

            //lbl_Cumulative_PPV.Text = dt.Rows[0]["storePBV"].ToString();
            //lbl_Cumulative_GPV.Text = dt.Rows[0]["storeGBV"].ToString();
            lbl_currentMonth_PPV_FirstPurch.InnerHtml = lbl_Cumulative_TPV.Text = dt.Rows[0]["TotalPV"].ToString();
            lbl_Cumulative_TGBV.Text = (Convert.ToDouble(dt.Rows[0]["TotalPV"]) + Convert.ToDouble(dt.Rows[0]["storeGBV"])).ToString();



            lbl_Rep_Required.Text = dt.Rows[0]["Rep_Required"].ToString();
            lbl_Rep_Achieved.Text = dt.Rows[0]["Rep_Achieved"].ToString();
            lbl_Rep_Shortfall.Text = dt.Rows[0]["Rep_Shortfall"].ToString();

            /************************ Topper *****************************/


            lblTotLeftBV.Text = dt.Rows[0]["AppMstLeftTotal"].ToString();
            lblTotRightBV.Text = dt.Rows[0]["AppMstRightTotal"].ToString();
            lblNewLeftBV.Text = dt.Rows[0]["TotalNewLeft"].ToString();
            lblNewRightBV.Text = dt.Rows[0]["TotalNewRight"].ToString();
            lblTotCarryLeftBV.Text = dt.Rows[0]["CarryLeft"].ToString();
            lblTotCarryRightBV.Text = dt.Rows[0]["CarryRight"].ToString();
            lbl_Cur_Month_Pair.Text = dt.Rows[0]["Cur_Month_Pair"].ToString();
            lblcpl.Text = dt.Rows[0]["Pairrank"].ToString();
            //lblLeftTotal.Text = dt.Rows[0]["lefttotal"].ToString();
            //lblRightTot.Text = dt.Rows[0]["righttotal"].ToString();
            //lblLeftPaidTot.Text = dt.Rows[0]["paidleftotal"].ToString();
            //lblRightPaidTot.Text = dt.Rows[0]["paidrighttotal"].ToString();
            lbl_BinaryRank.Text = dt.Rows[0]["Biary_rank"].ToString() + "/ " + dt.Rows[0]["JoinFor"].ToString();

            lbl_CummulativeJoinfor.Text = dt.Rows[0]["NewJoinFor"].ToString();
            lbl_SelfTopper.Text = dt.Rows[0]["SelfTopper"].ToString();
            lbl_ValidityDateTopper.Text = dt.Rows[0]["ValidityDateTopper"].ToString();
            //lbl_LeftTopper.Text = dt.Rows[0]["LeftTopper"].ToString();
            //lbl_RightTopper.Text = dt.Rows[0]["RightTopper"].ToString();


            lbl_DailyPayoutTime.InnerText = dt.Rows[0]["DailyPayoutDate_Dis"].ToString();
            //lbl_MonthlyPayoutTime.InnerText = dt.Rows[0]["MonthlyPayoutDate_Dis"].ToString();
            //lbl_LoyaltyPayoutTime.InnerText = dt.Rows[0]["WeeklyPayoutDate_Dis"].ToString();

            hnf_DailyPayoutDate.Value = dt.Rows[0]["DailyPayoutDate"].ToString();
            hnf_WeeklyPayoutDate.Value = dt.Rows[0]["WeeklyPayoutDate"].ToString();
            hnf_MonthlyPayoutDate.Value = dt.Rows[0]["MonthlyPayoutDate"].ToString();


            // div_LoyaltyAchived.InnerHtml = "<div class='card card-body text-left'> <div class='d-flex flex-row text-left'> <div class='card-header__title m-0'>Last Loyalty Achieved: " + dt.Rows[0]["Loyalty"].ToString() + " </div> </div> </div>";

            lbl_C_Wallet.InnerHtml = dt.Rows[0]["CompnayWalletBal"].ToString();
            lbl_P_Wallet.InnerHtml = dt.Rows[0]["ProductWalletBal"].ToString();
            lbl_GenerationBal.InnerHtml = dt.Rows[0]["PayoutWalletBal"].ToString();
            lbl_LoyaltyWallet.InnerHtml = dt.Rows[0]["LoyaltyWalletBal"].ToString();
            //lbl_TopperBal.InnerHtml = dt.Rows[0]["TopperWalletBal"].ToString();
            //lbl_RewardBal.InnerHtml = dt.Rows[0]["RewardWalletBal"].ToString();



            lbl_Coupon.InnerHtml = dt.Rows[0]["Coupon"].ToString();
            div_GoaQualifyCount.InnerHtml = div_GoaCount.InnerHtml = dt.Rows[0]["GoaCount"].ToString();

            div_GoaCountTotal.InnerHtml = dt.Rows[0]["GoaCountTotal"].ToString();


            /// ************ Insurance
            lbl_Inc_UserName.InnerHtml = dt.Rows[0]["appmstfname"].ToString();
            lbl_Inc_Userid.InnerHtml = dt.Rows[0]["appmstregno"].ToString();
            lbl_Inc_PolicyNo.InnerHtml = dt.Rows[0]["PolicyNo"].ToString();
            lbl_Inc_SumInsured.InnerHtml = dt.Rows[0]["SumInsured"].ToString();
            lbl_Inc_StartDate.InnerHtml = dt.Rows[0]["StartDate"].ToString();
            lbl_Inc_EndDate.InnerHtml = dt.Rows[0]["EndDate"].ToString();

        }

    }

    public void news()
    {
        com = new SqlCommand("GetUserNews", con);
        com.CommandType = CommandType.StoredProcedure;
        sda = new SqlDataAdapter(com);
        sda.Fill(dt);
        if (dt.Rows.Count >= 1)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["newstype"].ToString() == "UN")
                {
                    sbNews.Append(dt.Rows[i]["NewsMstDiscription"].ToString() + "  ");
                }
            }
            //dvNews.InnerHtml = sbNews.ToString();
        }
    }

    private DataSet LeftRight()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("spLeftRight", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", Session["userId"].ToString());
        SqlDataAdapter adp = new SqlDataAdapter(com);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        lblUserInLeft.Text = method.WEB_URL + "/newjoin.aspx?id=" + Session["userId"].ToString(); // + "" + "&pos=Left" + "";
        lblUserInRight.Text = method.WEB_URL + "/newjoin.aspx?id=" + Session["userId"].ToString() + "" + "&pos=Right" + "";
        return ds;
    }

    protected void lblUserInLeft_Click(object sender, EventArgs e)
    {
        DataSet ds = LeftRight();
        string left = method.WEB_URL + "/newjoin.aspx?id=" + Session["userId"].ToString().Trim(); // + "" + "&pos=Left" + "";
        Session.Abandon();
        Response.Redirect("" + left + "");
    }
    protected void lblUserInRight_Click(object sender, EventArgs e)
    {
        DataSet ds = LeftRight();
        string right = method.WEB_URL + "/newjoin.aspx?id=" + Session["userId"].ToString().Trim() + "" + "&pos=Right" + "";
        //string right = ds.Tables[0].Rows[0]["referlink"].ToString() + "" + utl.base64Encode(Session["userId"].ToString()) + "&pos=" + utl.base64Encode("Right") + "";
        Session.Abandon();
        Response.Redirect("" + right + "");
    }


    private void GetLoyalty()
    {
        String Result = "", Result1 = "", Result2 = "", Result3 = "", Result4 = "", Result5 = "";
        String Header1 = "", Header2 = "", Header3 = "", Header4 = "", Header5 = "";
        SqlParameter[] param = new SqlParameter[]
        {
             new SqlParameter("@Regno", Session["userId"].ToString())
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetUserLoyalty");
        foreach (DataRow dr in dt.Rows)
        {

            // LoyaltyName LoyalityType    MaxRoyalty
            string Loyalty = dr["Loyalty"].ToString();
            string LoyalityType = dr["LoyalityType"].ToString();
            if (Loyalty == "1" && LoyalityType == "1")
            {
                Header1 = "1 " + dr["LoyaltyName"].ToString();
                Result1 += " <tr> <td class='selected'>  " + dr["Doe"].ToString() + " </td> <td> " + dr["Amount"].ToString() + " </td> </tr> ";
            }
            if (Loyalty == "2" && LoyalityType == "1")
            {
                Header2 = "2 " + dr["LoyaltyName"].ToString();
                Result2 += " <tr> <td class='selected'>  " + dr["Doe"].ToString() + " </td> <td> " + dr["Amount"].ToString() + " </td> </tr> ";
            }
            if (Loyalty == "3" && LoyalityType == "1")
            {
                Header3 = "3 " + dr["LoyaltyName"].ToString();
                Result3 += " <tr> <td class='selected'>  " + dr["Doe"].ToString() + " </td> <td> " + dr["Amount"].ToString() + " </td> </tr> ";
            }
            if (Loyalty == "1" && LoyalityType == "2")
            {
                Header4 = "1 " + dr["LoyaltyName"].ToString();
                Result4 += " <tr> <td class='selected'>  " + dr["Doe"].ToString() + " </td> <td> " + dr["Amount"].ToString() + " </td> </tr> ";
            }
            if (Loyalty == "2" && LoyalityType == "2")
            {
                Header5 = "2 " + dr["LoyaltyName"].ToString();
                Result5 += " <tr> <td class='selected'>  " + dr["Doe"].ToString() + " </td> <td> " + dr["Amount"].ToString() + " </td> </tr> ";
            }
        }
        if (Result1 != "")
        {
            Result += " <div class='col-xl-4 col-xxl-4 col-lg-4 col-sm-4'>";
            Result += " <div class='widget-stat card bg-blue'>";
            Result += " <div class='card-body p-4'>";
            Result += " <table class='table text-white'>";
            Result += " <thead> <tr> <th colspan='2'>" + Header1 + "</th> </tr> </thead>";
            Result += " <thead> <tr> <th class='selected'>Month </th> <th> Amount </th> </tr> </thead>";
            Result += " <tbody>" + Result1 + " </tbody>  ";
            Result += "  </table> ";
            Result += " </div>";
            Result += " </div>";
            Result += " </div>";
        }

        if (Result2 != "")
        {
            Result += " <div class='col-xl-4 col-xxl-4 col-lg-4 col-sm-4'>";
            Result += " <div class='widget-stat card bg-grey'>";
            Result += " <div class='card-body p-4'>";
            Result += " <table class='table text-black'>";
            Result += " <thead> <tr> <th colspan='2'>" + Header2 + "</th> </tr> </thead>";
            Result += " <thead> <tr> <th class='selected'>Month </th> <th> Amount </th> </tr> </thead>";
            Result += " <tbody>" + Result2 + " </tbody>  ";
            Result += "  </table> ";
            Result += " </div>";
            Result += " </div>";
            Result += " </div>";
        }

        if (Result3 != "")
        {
            Result += " <div class='col-xl-4 col-xxl-4 col-lg-4 col-sm-4'>";
            Result += " <div class='widget-stat card bg-blue'>";
            Result += " <div class='card-body p-4'>";
            Result += " <table class='table text-white'>";
            Result += " <thead> <tr> <th colspan='2'>" + Header3 + "</th> </tr> </thead>";
            Result += " <thead> <tr> <th class='selected'>Month </th> <th> Amount </th> </tr> </thead>";
            Result += " <tbody>" + Result3 + " </tbody>  ";
            Result += "  </table> ";
            Result += " </div>";
            Result += " </div>";
            Result += " </div>";
        }

        if (Result4 != "")
        {
            Result += " <div class='col-xl-4 col-xxl-4 col-lg-4 col-sm-4'>";
            Result += " <div class='widget-stat card bg-grey'>";
            Result += " <div class='card-body p-4'>";
            Result += " <table class='table text-black'>";
            Result += " <thead> <tr> <th colspan='2'>" + Header4 + "</th> </tr> </thead>";
            Result += " <thead> <tr> <th class='selected'>Month </th> <th> Amount </th> </tr> </thead>";
            Result += " <tbody>" + Result4 + " </tbody>  ";
            Result += "  </table> ";
            Result += " </div>";
            Result += " </div>";
            Result += " </div>";
        }

        if (Result5 != "")
        {
            Result += " <div class='col-xl-4 col-xxl-4 col-lg-4 col-sm-4'>";
            Result += " <div class='widget-stat card bg-blue'>";
            Result += " <div class='card-body p-4'>";
            Result += " <table class='table text-white'>";
            Result += " <thead> <tr> <th colspan='2'>" + Header5 + "</th> </tr> </thead>";
            Result += " <thead> <tr> <th class='selected'>Month </th> <th> Amount </th> </tr> </thead>";
            Result += " <tbody>" + Result5 + " </tbody>  ";
            Result += "  </table> ";
            Result += " </div>";
            Result += " </div>";
            Result += " </div>";
        }

        div_MonthlyPurchaseRoyalty.InnerHtml = Result;
    }

    private void RetailBooster()
    {
        String Result = "", Result1 = "", Result2 = "", Result3 = "", Result4 = "", Result5 = "";
        SqlParameter[] param = new SqlParameter[]
        {
             new SqlParameter("@Regno", Session["userId"].ToString())
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetUserRetailBooster");
        foreach (DataRow dr in dt.Rows)
        {
            if (dr["Loyalty"].ToString() == "1")
            {
                Result1 += " <tr> <td class='selected'>  " + dr["Doe"].ToString() + " </td> <td> " + dr["Amount"].ToString() + " </td> </tr> ";
            }
            if (dr["Loyalty"].ToString() == "2")
            {
                Result2 += " <tr> <td class='selected'>  " + dr["Doe"].ToString() + " </td> <td> " + dr["Amount"].ToString() + " </td> </tr> ";
            }
            if (dr["Loyalty"].ToString() == "3")
            {
                Result3 += " <tr> <td class='selected'>  " + dr["Doe"].ToString() + " </td> <td> " + dr["Amount"].ToString() + " </td> </tr> ";
            }
            if (dr["Loyalty"].ToString() == "4")
            {
                Result4 += " <tr> <td class='selected'>  " + dr["Doe"].ToString() + " </td> <td> " + dr["Amount"].ToString() + " </td> </tr> ";
            }
            if (dr["Loyalty"].ToString() == "5")
            {
                Result5 += " <tr> <td class='selected'>  " + dr["Doe"].ToString() + " </td> <td> " + dr["Amount"].ToString() + " </td> </tr> ";
            }
        }

        Result += " <div class='col-xl-4 col-xxl-4 col-lg-4 col-sm-4'>";
        Result += " <div class='widget-stat card bg-blue'>";
        Result += " <div class='card-body p-4'>";
        Result += " <table class='table text-white'>";
        Result += " <thead> <tr> <th colspan='2'>Arogyam Wellness 1</th> </tr> </thead>";
        Result += " <thead> <tr> <th class='selected'>Month </th> <th> Amount </th> </tr> </thead>";
        Result += " <tbody>" + Result1 + " </tbody>  ";
        Result += "  </table> ";
        Result += " </div>";
        Result += " </div>";
        Result += " </div>";


        Result += " <div class='col-xl-4 col-xxl-4 col-lg-4 col-sm-4'>";
        Result += " <div class='widget-stat card bg-grey'>";
        Result += " <div class='card-body p-4'>";
        Result += " <table class='table text-black'>";
        Result += " <thead> <tr> <th colspan='2'>Arogyam Wellness 2</th> </tr> </thead>";
        Result += " <thead> <tr> <th class='selected'>Month </th> <th> Amount </th> </tr> </thead>";
        Result += " <tbody>" + Result2 + " </tbody>  ";
        Result += "  </table> ";
        Result += " </div>";
        Result += " </div>";
        Result += " </div>";


        Result += " <div class='col-xl-4 col-xxl-4 col-lg-4 col-sm-4'>";
        Result += " <div class='widget-stat card bg-blue'>";
        Result += " <div class='card-body p-4'>";
        Result += " <table class='table text-white'>";
        Result += " <thead> <tr> <th colspan='2'>Arogyam Wellness 3</th> </tr> </thead>";
        Result += " <thead> <tr> <th class='selected'>Month </th> <th> Amount </th> </tr> </thead>";
        Result += " <tbody>" + Result3 + " </tbody>  ";
        Result += "  </table> ";
        Result += " </div>";
        Result += " </div>";
        Result += " </div>";


        Result += " <div class='col-xl-4 col-xxl-4 col-lg-4 col-sm-4'>";
        Result += " <div class='widget-stat card bg-grey'>";
        Result += " <div class='card-body p-4'>";
        Result += " <table class='table text-black'>";
        Result += " <thead> <tr> <th colspan='2'>Arogyam Wellness 4</th> </tr> </thead>";
        Result += " <thead> <tr> <th class='selected'>Month </th> <th> Amount </th> </tr> </thead>";
        Result += " <tbody>" + Result4 + " </tbody>  ";
        Result += "  </table> ";
        Result += " </div>";
        Result += " </div>";
        Result += " </div>";


        Result += " <div class='col-xl-4 col-xxl-4 col-lg-4 col-sm-4'>";
        Result += " <div class='widget-stat card bg-blue'>";
        Result += " <div class='card-body p-4'>";
        Result += " <table class='table text-white'>";
        Result += " <thead> <tr> <th colspan='2'>Arogyam Wellness 5</th> </tr> </thead>";
        Result += " <thead> <tr> <th class='selected'>Month </th> <th> Amount </th> </tr> </thead>";
        Result += " <tbody>" + Result5 + " </tbody>  ";
        Result += "  </table> ";
        Result += " </div>";
        Result += " </div>";
        Result += " </div>";

        div_RetailBooster.InnerHtml = Result;
    }



    [WebMethod]
    public static Achieving[] GetAchieving(string flag, string Month)
    {
        List<Achieving> details = new List<Achieving>();
        try
        {
            DataUtility objDu = new DataUtility();
            if (flag == "GenerationRank" || flag == "TopperRank")
            {

                SqlParameter[] param = new SqlParameter[]
                {
                   new SqlParameter("@SearchType", flag == "GenerationRank" ?"GENERATION" :"TOPPER"),
                   new SqlParameter("@MinDate", ""),
                   new SqlParameter("@MaxDate", ""),
                   new SqlParameter("@Userid",  HttpContext.Current.Session["userId"].ToString()),
                   new SqlParameter("@RankId", 0),
                   new SqlParameter("@Month", Month),
                };
                SqlDataReader dr = objDu.GetDataReaderSP(param, "GetMonthlyAchievers");
                while (dr.Read())
                {
                    Achieving data = new Achieving();
                    data.BackGroundImg = dr["BackGroundImg"].ToString();
                    data.UserName = dr["UserName"].ToString();
                    data.District = dr["District"].ToString();
                    data.State = dr["State"].ToString();
                    data.imagename = dr["imagename"].ToString();
                    data.Month = dr["Month"].ToString();
                    data.Rank = flag == "GenerationRank" ? "GENERATION" : "TOPPER";
                    data.RN = dr["Achievement"].ToString();
                    details.Add(data);
                }
            }
            else if (flag == "DomesticTour" || flag == "InternationalTour")
            {

                SqlParameter[] param = new SqlParameter[]
                {
                    new SqlParameter("@min", ""),
                    new SqlParameter("@max", ""),
                    new SqlParameter("@Userid", HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@Tid", 0),
                    new SqlParameter("@Pack_rep", "-1"),
                    new SqlParameter("@RankId", 0),
                    new SqlParameter("@Month", Month),
                };
                // DataTable dr = objDu.GetDataTableSP(param, "GetUserTourList"); 

                SqlDataReader dr = objDu.GetDataReaderSP(param, "GetUserTourList");
                while (dr.Read())
                {

                    if (flag == "DomesticTour")
                    {
                        if (dr["TourType"].ToString() == "Domestic Tour")
                        {
                            Achieving data = new Achieving();
                            data.BackGroundImg = dr["BackGroundImg"].ToString();
                            data.UserName = dr["UserName"].ToString();
                            data.District = dr["District"].ToString();
                            data.State = dr["Satate"].ToString();
                            data.imagename = dr["imagename"].ToString();
                            data.Month = dr["Month"].ToString();
                            data.Rank = dr["TourType"].ToString();
                            data.RN = dr["DisplayName"].ToString();
                            details.Add(data);
                        }
                    }
                    if (flag == "InternationalTour")
                    {
                        if (dr["TourType"].ToString() == "International Tour")
                        {
                            Achieving data = new Achieving();
                            data.BackGroundImg = dr["BackGroundImg"].ToString();
                            data.UserName = dr["UserName"].ToString();
                            data.District = dr["District"].ToString();
                            data.State = dr["Satate"].ToString();
                            data.imagename = dr["imagename"].ToString();
                            data.Month = dr["Month"].ToString();
                            data.Rank = dr["TourType"].ToString();
                            data.RN = dr["DisplayName"].ToString();
                            details.Add(data);
                        }
                    }

                }
            }
            else if (flag == "Loyalty")
            {

                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@Regno", HttpContext.Current.Session["userId"].ToString()),
                new SqlParameter("@Payoutno", 0),
                new SqlParameter("@MstKey", "Main"),
                new SqlParameter("@Month", Month),
                };
                SqlDataReader dr = objDu.GetDataReaderSP(param, "GetLoyalityDetails");
                while (dr.Read())
                {
                    Achieving data = new Achieving();

                    data.BackGroundImg = dr["BackGroundImg"].ToString();
                    data.Month = dr["Dates"].ToString();
                    data.UserName = dr["UserName"].ToString();
                    data.District = dr["District"].ToString();
                    data.State = dr["State"].ToString();
                    data.Rank = dr["NoOfQualfy"].ToString();

                    data.TotalAmount = dr["LoyalityInc"].ToString();
                    data.imagename = dr["imagename"].ToString();

                    details.Add(data);
                }
            }
            else if (flag == "RetailBoosterLoyalty")
            {
                SqlParameter[] param = new SqlParameter[]
               {
                new SqlParameter("@Regno", HttpContext.Current.Session["userId"].ToString()),
                new SqlParameter("@Payoutno", 0),
                new SqlParameter("@MstKey", "Main"),
                 new SqlParameter("@Month", Month),
               };
                SqlDataReader dr = objDu.GetDataReaderSP(param, "GetRetail_Booster_Monthly_Loyalty");
                while (dr.Read())
                {
                    Achieving data = new Achieving();
                    data.BackGroundImg = dr["BackGroundImg"].ToString();
                    data.Month = dr["Dates"].ToString();
                    data.UserName = dr["UserName"].ToString();
                    data.District = dr["District"].ToString();
                    data.State = dr["State"].ToString();
                    data.Rank = dr["NoOfQualfy"].ToString();
                    data.TotalAmount = dr["LoyalityInc"].ToString();
                    data.imagename = dr["imagename"].ToString();
                    details.Add(data);
                }
            }
            else if (flag == "Staterfund")
            {
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@payoutno", 0),
                new SqlParameter("@iselegible", "-1"),
                new SqlParameter("@UserId", HttpContext.Current.Session["userId"].ToString()),
                new SqlParameter("@IsKYC", "-1"),
                new SqlParameter("@RankId", 0),
                new SqlParameter("@ReqTypeSponsor", ">="),
                new SqlParameter("@Condition", 0),
                };
                SqlDataReader dr = objDu.GetDataReaderSP(param, "PayoutList1");
                while (dr.Read())
                {
                    if (dr["PIN"].ToString() == "Silver")
                    {
                        if (Convert.ToDecimal(dr["Dispatch Amount"].ToString()) >= 10000)
                        {
                            Achieving data = new Achieving();
                            data.BackGroundImg = dr["BackGroundImg"].ToString();
                            data.UserName = dr["User Name"].ToString();
                            data.State = dr["State"].ToString();
                            data.District = dr["District"].ToString();
                            data.Month = dr["Month"].ToString();
                            data.imagename = dr["imagename"].ToString();
                            data.Rank = dr["PIN"].ToString();
                            data.TotalAmount = dr["Dispatch Amount"].ToString();
                            details.Add(data);
                        }
                    }
                }
            }
            else if (flag == "TopEarnersclub")
            {
                SqlParameter[] param = new SqlParameter[]
                {
                 new SqlParameter("@Userid", HttpContext.Current.Session["userId"].ToString()),
                 new SqlParameter("@Month", Month)
                };
                SqlDataReader dr = objDu.GetDataReaderSP(param, "GetBusinessInformationAdmin");
                utility objutil = new utility();
                while (dr.Read())
                {
                    if (Convert.ToDecimal(dr["TotalAmount"].ToString()) >= 1000)
                    {
                        Achieving data = new Achieving();
                        data.BackGroundImg = dr["BackGroundImg"].ToString();
                        data.UserName = dr["UserName"].ToString();
                        data.District = dr["District"].ToString();
                        data.State = dr["State"].ToString();
                        data.imagename = dr["imagename"].ToString();
                        data.Month = dr["Month"].ToString();
                        data.TotalAmount = dr["TotalAmount"].ToString();
                        details.Add(data);
                    }
                }
            }
            else if (flag == "RankUpgrade")
            {

                SqlParameter[] param = new SqlParameter[]
                {
                   new SqlParameter("@SearchType", flag),
                   new SqlParameter("@MinDate", ""),
                   new SqlParameter("@MaxDate", ""),
                   new SqlParameter("@Userid",  HttpContext.Current.Session["userId"].ToString()),
                   new SqlParameter("@RankId", 0),
                   new SqlParameter("@Month", Month),
                };

                SqlDataReader dr = objDu.GetDataReaderSP(param, "GetMonthlyAchievers");
                while (dr.Read())
                {
                    Achieving data = new Achieving();
                    data.BackGroundImg = dr["BackGroundImg"].ToString();
                    data.UserName = dr["UserName"].ToString();
                    data.District = dr["District"].ToString();
                    data.State = dr["State"].ToString();
                    data.imagename = dr["imagename"].ToString();
                    data.Month = dr["Month"].ToString();
                    data.Rank = dr["Rank"].ToString();
                    data.RN = dr["Achievement"].ToString();
                    details.Add(data);
                }
            }

            return details.ToArray();
        }
        catch (Exception ex) { return details.ToArray(); }

    }


    public class Achieving
    {
        public String BackGroundImg { get; set; }
        public String UserName { get; set; }
        public String District { get; set; }
        public String State { get; set; }
        public String imagename { get; set; }
        public String Month { get; set; }
        public String Rank { get; set; }
        public String RN { get; set; }
        public String TotalAmount { get; set; }
    }




    [WebMethod]
    public static Tour[] TourList()
    {
        List<Tour> details = new List<Tour>();
        DataUtility objDu = new DataUtility();
        SqlParameter[] param = new SqlParameter[] {
            new SqlParameter("@Regno", HttpContext.Current.Session["userId"].ToString())
        };
        SqlDataReader dr = objDu.GetDataReaderSP(param, "GetTourList_New");
        while (dr.Read())
        {
            Tour data = new Tour();

            data.Tid = dr["Tid"].ToString();
            data.TourName = dr["TourName"].ToString();
            data.Perid = dr["Perid"].ToString();
            data.TourType = dr["TourType"].ToString();
            data.Pack_Rep = dr["Pack_Rep"].ToString();
            data.Condition = dr["Condition"].ToString();
            data.LegID = dr["LegID"].ToString();
            data.UserName = dr["UserName"].ToString();
            data.Required = dr["Required"].ToString();
            data.Achieved = dr["Achieved"].ToString();
            data.PermittedGPV = dr["PermittedGPV"].ToString();
            data.Shortfall = dr["Shortfall"].ToString();
            data.ProductCondition = dr["ProductCondition"].ToString();
            data.NoOfTours = dr["NoOfTours"].ToString();
            details.Add(data);
        }
        return details.ToArray();
    }


    [WebMethod]
    public static string CurrencyFormate(string Amount)
    {
        return common.CurrencyFormate(Amount);
    }


    //public void Months()
    //{
    //    DataUtility objDu = new DataUtility();
    //    DataTable dt = objDu.GetDataTable(@" Select Dates From(
    //    Select payoutno=99999, Dates=Cast(DateName(Month, Getdate()) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Getdate()),2) Union All 
    //    Select payoutno, Dates=Cast(DateName(Month, paytodate) as nvarchar(3)) + '-' + RIGHT(DateName(Year, paytodate),2) from repayoutdate 
    //    )t order by t.payoutno desc");
    //    if (dt.Rows.Count > 0)
    //    {
    //        ddl_Month.Items.Clear();
    //        ddl_Month.DataSource = dt;
    //        ddl_Month.DataTextField = "Dates";
    //        ddl_Month.DataValueField = "Dates";
    //        ddl_Month.DataBind();
    //    }
    //    else
    //    {
    //        ddl_Month.Items.Insert(0, new System.Web.UI.WebControls.ListItem("No Data", ""));
    //    }
    //}


    [System.Web.Services.WebMethod]
    public static UserDetails[] BindEventTour()
    {

        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
           {
                new SqlParameter("@Min", ""),
                new SqlParameter("@Max", "") ,
                new SqlParameter("@Userid", HttpContext.Current.Session["userId"].ToString()),
                new SqlParameter("@Tid", 0),
                new SqlParameter("@QRCode", ""),
                new SqlParameter("@IsScaned", -1)
           };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetTourProductWiseList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                data.AppMstRegNo = dr["AppMstRegNo"].ToString();
                data.AppMstFName = dr["AppMstFName"].ToString();
                data.TourName = dr["TourName"].ToString();
                data.QRCode = dr["QRCode"].ToString();
                data.Qualify_date = dr["Qualify_date"].ToString();
                data.Scan_date = dr["Scan_date"].ToString();
                data.IsScaned = dr["IsScaned"].ToString();
                data.Remark = dr["Remark"].ToString();
                data.Date = dr["Date"].ToString();
                data.Time = dr["Time"].ToString();
                data.Place = dr["Place"].ToString();
                data.Venue = dr["Venue"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }

    public class UserDetails
    {
        public String AppMstRegNo { get; set; }
        public String AppMstFName { get; set; }
        public String TourName { get; set; }
        public String QRCode { get; set; }
        public String Qualify_date { get; set; }
        public String Scan_date { get; set; }
        public String IsScaned { get; set; }
        public String Remark { get; set; }
        public String Date { get; set; }
        public String Time { get; set; }
        public String Place { get; set; }
        public String Venue { get; set; }

    }

}




//Kyc details List to retrive in key value
#region KYC_INDEX_CLASS
public class Tour
{
    public String Tid { get; set; }
    public String TourName { get; set; }
    public String Perid { get; set; }
    public String TourType { get; set; }
    public String Pack_Rep { get; set; }
    public String Condition { get; set; }
    public String LegID { get; set; }
    public String UserName { get; set; }
    public String Required { get; set; }
    public String Achieved { get; set; }
    public String PermittedGPV { get; set; }
    public String Shortfall { get; set; }
    public String ProductCondition { get; set; }
    public String NoOfTours { get; set; }
}



public class Kyc
{
    public string psts { get; set; }
    public string bsts { get; set; }
    public string asts { get; set; }
    public string veri { get; set; }
}
#endregion

