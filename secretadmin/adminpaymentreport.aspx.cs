using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class payoutstatement : System.Web.UI.Page
{
    static string strsession, strsession2;
    public string pbv, gbv;
    int payoutno;
    string str;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    utility objUtil = new utility();
    string franchise;
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        // InsertFunction.CheckAdminlogin();

        // Response.Cache.SetAllowResponseInBrowserHistory(true);

        strsession = Convert.ToString(objUtil.base64Decode(Request.QueryString["id"]));

        payoutno = Convert.ToInt32(objUtil.base64Decode(Request.QueryString["n"]));

        //strsession = Convert.ToString(objUtil.base64Decode(Request.QueryString["id"]));
        //payoutno = Convert.ToInt32(Session["payoutno"].ToString());

       // GetBinaryDetails(strsession, payoutno);
        if (Regex.Match(strsession + payoutno, @"^[A-Za-z0-9]*$").Success)
        {
            con.Open();
            com = new SqlCommand("result", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@appmstid", strsession);
            com.Parameters.AddWithValue("@payoutno", payoutno);
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {
                //   Label1.Text = sdr["TPL"].ToString();
                //Label5.Text = sdr["TPR"].ToString();

                //// Label2.Text = sdr["NPL"].ToString();
                //Label6.Text = sdr["NPR"].ToString();

                //Label3.Text = sdr["BFL"].ToString();
                //Label7.Text = sdr["BFR"].ToString();

                //  Label17.Text = sdr["CFL"].ToString();
                //Label19.Text = sdr["CFR"].ToString();

                //Label4.Text = sdr["CPL"].ToString();
                //Label8.Text = sdr["CPR"].ToString();
                lblBinary.Text = sdr["RoyltyAmt"].ToString();

                lbl_SelfHelpClubBonus.Text = sdr["binaryamt"].ToString();
                //lblTotal.Text = sdr["totalearning"].ToString();
                lblTDS.Text = sdr["TDS"].ToString();
                lblOC.Text = sdr["handlingCharges"].ToString();
                //lblroyaltyfund.Text = sdr["RoyaltyAmt"].ToString();
                lblPayoutFromDate.Text = sdr["paymentfromdate"].ToString();
                lblPayoutToDate.Text = sdr["paymenttodate"].ToString();
                lblNet.Text = sdr["dispachedamt"].ToString();



                //lblBFL.Text = sdr["BFL"].ToString();
                //lblBFR.Text = sdr["BFR"].ToString();

                //lblNewLeft.Text = sdr["NPL"].ToString();
                //lblNewRight.Text = sdr["NPR"].ToString();

                //lblTLB.Text = sdr["appmstlefttotal"].ToString();
                //lblTRB.Text = sdr["appmstrighttotal"].ToString();

                //lblCarryLeft.Text = sdr["carryleft"].ToString();
                //lblCarryRight.Text = sdr["carryright"].ToString();
                lblTMIRight.Text = sdr["carryright"].ToString();
                lblTMILeft.Text = sdr["carryleft"].ToString();
                lblNewTCCRight.Text = sdr["NPR"].ToString();
                lblNewTCCLeft.Text = sdr["NPL"].ToString();
                lblTCCRight.Text = sdr["TPR"].ToString();
                lblTCCLeft.Text = sdr["TPL"].ToString();
                lblmatched.Text = sdr["TP"].ToString();



                lblPayoutNo.Text = payoutno.ToString();

                lblTotal.Text = sdr["TotalEarning"].ToString();

                lbl_ReleaseAmt.Text = sdr["ReleaseAmt"].ToString();


                lbl_SelfFirstPurchase.Text = sdr["PBV"].ToString();
                lbl_GroupFirstPurchase.Text = sdr["TP"].ToString();
                lbl_SelfQualified.Text = sdr["SelfQualified"].ToString() == "0" ? "No" : "Yes";
                lbl_PayoutStatus.Text = sdr["iselegible"].ToString() == "1" ? "Payout" : "Hold";

                lbl_PANStatus.Text = sdr["panstatus"].ToString() == "20" ? "No ( 20% TDS)" : "Yes ( " + sdr["panstatus"].ToString() + "% TDS)";
                lbl_BankStatus.Text = sdr["BankStatus"].ToString() == "1" ? "Yes" : "No";




                //lblfranchiseincome.Text = sdr["fpi"].ToString();

                //franchise = sdr["checkdata"].ToString();



                //if (franchise == "No Franchise")
                //{

                //    tr1.Visible = false;
                //}
                //if (franchise == "Franchise")
                //{

                //    tr1.Visible = true;
                //}


                //  lblCoSponsor.Text = sdr["Cosponsor"].ToString();
                //PI.Text = sdr["leadershipamt"].ToString();
                //lblperofrmancebonus.Text = sdr["GrowthAmt"].ToString();
                //lblperfonanceroyalty.Text = sdr["RoyaltyIncome"].ToString();
                //lblbikefund.Text = sdr["balanceamt"].ToString();
                //bltravelfund.Text = sdr["Levelamt"].ToString();
                //lblcarfund.Text = sdr["depthAmt"].ToString();
                //lblhousefund.Text = sdr["leadershipbonusAmt"].ToString();
                //lblroyaltyfund.Text = sdr["directAmt"].ToString();
                //lblFi.Text = sdr["FI"].ToString();

                //if (sdr["Cosponsor"].ToString() == "")
                //{

                //    lblCoSponsor.Text = "0";
                //}

                //if (sdr["FI"].ToString() == "")
                //{
                //    lblFi.Text = "0";
                //}
                //lbltds.Text = sdr["othercharges"].ToString();
                //lbltds.Text = sdr["TDS"].ToString();
                //lbltotalearning.Text = sdr["totalearning"].ToString();

            }
            con.Close();

            //string qstr1 = "select 'website : '+ website=(select caption from settingmst where caption='WEBSITE') + '  /'+' email '+emailid=(select caption from settingmst where caption='COM_EMAIL') ,companyname=(select caption from settingmst where caption='COMPANYNAME'),address=(select caption from settingmst where caption='COM_ADDRESS'),ap.panno,ap.AppMstTitle,ap.AppmstFname,ap.appmstdoj,ap.appmstregno,ap.appmstaddress1 +' '+ap.AppMstCity +' '+ap.appmststate as appmstaddress1,ap.email,ap.appmstpincode,ap.AppMstMobile,ap.distt,ap.AppMstCity,ap.appmststate,ap.AppMstPinCode,py.depthamt from appmst ap,paymenttrandraft py where ap.appmstregno=py.appmstid and ap.appmstregno='" + strsession + "'";

            string qstr1 = "select website='website : '+ (select Userval from settingmst where caption='WEBSITE') + '  / email :'+(select Userval from settingmst where caption='COM_EMAIL') ,companyname=(select Userval from settingmst where caption='COMPANYNAME'),address=(select Userval from settingmst where caption='COM_ADDRESS'),ap.panno,ap.AppMstTitle,ap.AppmstFname,ap.appmstdoj,ap.appmstregno,ap.appmstaddress1 +' '+ap.AppMstCity +' '+ap.appmststate+' '+ap.appmstpincode as appmstaddress1,ap.email,ap.appmstpincode,ap.AppMstMobile,ap.distt,ap.AppMstCity,ap.appmststate,ap.AppMstPinCode,py.depthamt from appmst ap,paymenttrandraft py where ap.appmstregno=py.appmstid and ap.appmstregno='" + strsession + "'";


            con.Open();
            com = new SqlCommand(qstr1, con);

            sdr = com.ExecuteReader();
            if (sdr.Read())
            {

                lblName.Text = sdr["AppmstFname"].ToString();

                lblUserId.Text = sdr["appmstregno"].ToString();


                lblAddress.Text = sdr["appmstaddress1"].ToString();


                lblMobile.Text = sdr["AppMstMobile"].ToString();

                lblPAN.Text = sdr["panno"].ToString();

                lblEMailId.Text = sdr["email"].ToString();

                // lblPayoutFromDate.Text = sdr["appmstdoj"].ToString();
                lblComapnyName.Text = sdr["companyname"].ToString();

                lblCompanyAddress.Text = sdr["address"].ToString();
                lblcompanywebsite.Text = method.WEB_URL;
                lblcompanyemail.Text = method.COMP_EMAIL;

                // <asp:Label ID="lblCompanyAddress"  runat="server" ></asp:Label>

                // Label21.Text = sdr["AppMstTitle"].ToString() + " " + sdr["appmstfname"].ToString() + " &nbsp" + "(" + "ID No" + sdr["appmstregno"].ToString() + ")" + "<br>" + "Address" + " : " + sdr["appmstaddress1"].ToString() + "<br>" + "District" + " : " + sdr["distt"].ToString() + "<br>" + "City" + " : " + sdr["AppMstCity"].ToString() + "<br>" + "State" + " : " + sdr["AppMstState"].ToString() + "<br>" + "Pin Code" + " : " + sdr["AppMstPinCode"].ToString() + "<br>" + "Mob No" + " : " + sdr["AppMstMobile"].ToString();
                // Label10.Text = "Id No : " + sdr["appmstregno"].ToString();
                pbv = objUtil.getvalue()[1].ToString();
                gbv = objUtil.getvalue()[1].ToString();
            }
            sdr.Close();
            con.Close();
        }

        con.Open();
        com = new SqlCommand("CurrentPayout", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", strsession);
        sdr = com.ExecuteReader();
        sdr.Close();
        con.Close();
    }


    private void GetBinaryDetails(string strsession, int payoutno)
    {

        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[]
            {
                new SqlParameter("@PayoutNo",payoutno),
                new SqlParameter("@Appmstregno",strsession)
            };

        DataTable dt = objDu.GetDataTable(param1, @"Select Name= ' Rate-' + Cast(isnull(c.JoinFor,0) as nvarchar(20)) + ', Pair-' + Cast(isnull(c.Old ,0) as nvarchar(20)) 
                                from BinarySlab b left join Causeid c on b.LevelId=c.rank and c.PaymentCause in ('b1','b2','b3','b4','b5')  
                                and c.userid=(Select Appmstid from Appmst where Appmstregno=@Appmstregno)
                                and Cast(c.effectdate as date) between Cast((Select PayFromDate from Payoutdate where PayoutNo=@PayoutNo) as date) 
                                and Cast((Select PayToDate from Payoutdate where PayoutNo=@PayoutNo) as date) ");
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {


            }
        }
    }
}
