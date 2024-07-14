using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Text;
using System.Drawing;
using System.Security.Cryptography;
using System.IO;

public partial class user_welcome : System.Web.UI.Page
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
        string str = Convert.ToString(Session["userId"]);
        news();

        if (!ClientScript.IsStartupScriptRegistered("alert"))
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "getdate();", true);
        }

        if (!IsPostBack)
        {
            GetImageList();
            //GetDate();
            RankImage(str);
            GetPaymentDetails();
             

            con.Open();
            com = new SqlCommand("getUserMaster1", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regno", str);
            try
            {
                sr = com.ExecuteReader();
                if (sr.Read())
                {
                    lbleligibleclosings.Text = sr["eligibleDate"].ToString();


                    m1timer = "";
                   

                    if (sr["SelfRepurchse"].ToString() == "0")
                    {
                        lblslfprchase.Text = "<i class='fa fa-close' style='font-size:25px;color:red'></i>";
                    }
                    else
                    {
                        lblslfprchase.Text = "<i class='fa fa-check' style='font-size:25px;color:green'></i>";

                    }

                   

                    if (sr["bankstatus"].ToString() == "0")
                    {
                        a1.Visible = false;
                    }

                    if (sr["pstatus"].ToString() == "0")
                    {
                        a2.Visible = false;
                    }

                    if (sr["astatus"].ToString() == "0" || sr["aastatus"].ToString() == "0")
                    {
                        a3.Visible = false;
                    }

                    if (sr["bankstatus"].ToString() == "1")
                    {
                        a1.Visible = false;
                    }

                    if (sr["pstatus"].ToString() == "1")
                    {
                        a2.Visible = false;
                    }

                    if (sr["astatus"].ToString() == "1" || sr["aastatus"].ToString() == "1")
                    {
                        a3.Visible = false;
                    }


                    if (sr["pstatus"].ToString() == "2")
                    {
                        HyperLink1.Enabled = false;
                        HyperLink1.Text = "PAN Verification Status";


                        lblpanvarify.Text = "Verified";
                        lblpanconfirmed.Text = "Confirmed";
                        a1.Visible = true;
                    }

                    if (sr["bankstatus"].ToString() == "2")
                    {
                        HyperLink2.Enabled = false;
                        HyperLink2.Text = "Bank Account Verification Status";
                        lblbankvarify.Text = "Verified";
                        lblbankconfirmed.Text = "Confirmed";

                        a2.Visible = true;
                    }

                    if (sr["astatus"].ToString() == "2" || sr["aastatus"].ToString() == "2")
                    {
                        HyperLink3.Enabled = false;
                        HyperLink3.Text = "Aadhar or Address Proof Verification Status";
                        lblkycvarify.Text = "Verified";
                        lblkycconfirmed.Text = "Confirmed";
                        a3.Visible = true;
                    }


                    //lbl_holdPayout.Text = sr["HoldPayout"].ToString();
                    //lbl_ReleaseCV.Text = sr["ReleaseCV"].ToString();

                    lblrank.Text = sr["appmstrank"].ToString();
                    lbllevel.Text = sr["leveltype"].ToString();
                    lblcurrentgbv.Text = sr["pbvamt"].ToString();
                    lblcurrentpbv.Text = sr["gbvamt"].ToString();

                    /*--------------------------------------------------------*/

                    //lnkDSAGroupA.Text = sr["leftpoint"].ToString();
                    //lnkDSAGroupB.Text = sr["rightpoint"].ToString();


                    lnkDSAGroupA.Text = sr["pbvamt"].ToString();
                    lnkDSAGroupB.Text = sr["TotalSponsorPV"].ToString();

                    lnkDSAGroupAB.Text = sr["paidleftrightdirect"].ToString();

                    lnkDSAGroupAT.Text = sr["totalleftdirect"].ToString();
                    lnkDSAGroupBT.Text = sr["totalrightdirect"].ToString();
                    lnkDSAGroupABT.Text = sr["totalleftrightdirect"].ToString();


                    lnkGSAGroupA.Text = sr["paidleftotal"].ToString();
                    lnkGSAGroupB.Text = sr["paidrighttotal"].ToString();
                    lnkGSAGroupAB.Text = sr["paidleftrighttotal"].ToString();


                    lnkGSAGroupAT.Text = sr["lefttotal"].ToString();
                    lnkGSAGroupBT.Text = sr["righttotal"].ToString();
                    lnkGSAGroupABT.Text = sr["leftrighttotal"].ToString();

                    /*-------------------------------------------------*/
                    lnkDSAGroupA.NavigateUrl = "PersonalPVList.aspx";
                    lnkDSAGroupAT.NavigateUrl = "Totaluser.aspx?t=" + utl.base64Encode("4") + "&p=" + utl.base64Encode("0");

                    // lnkDSAGroupB.NavigateUrl = "Totaluser.aspx?t=" + utl.base64Encode("5") + "&p=" + utl.base64Encode("1");
                    lnkDSAGroupB.NavigateUrl = "PVList.aspx";
                    lnkDSAGroupBT.NavigateUrl = "Totaluser.aspx?t=" + utl.base64Encode("5") + "&p=" + utl.base64Encode("0");

                    lnkDSAGroupAB.NavigateUrl = "Totaluser.aspx?t=" + utl.base64Encode("6") + "&p=" + utl.base64Encode("1");
                    lnkDSAGroupABT.NavigateUrl = "Totaluser.aspx?t=" + utl.base64Encode("6") + "&p=" + utl.base64Encode("0");

                    lnkGSAGroupA.NavigateUrl = "Totaluser.aspx?t=" + utl.base64Encode("1") + "&p=" + utl.base64Encode("1");
                    lnkGSAGroupAT.NavigateUrl = "Totaluser.aspx?t=" + utl.base64Encode("1") + "&p=" + utl.base64Encode("0");

                    lnkGSAGroupB.NavigateUrl = "Totaluser.aspx?t=" + utl.base64Encode("2") + "&p=" + utl.base64Encode("1");
                    lnkGSAGroupBT.NavigateUrl = "Totaluser.aspx?t=" + utl.base64Encode("2") + "&p=" + utl.base64Encode("0");

                    lnkGSAGroupAB.NavigateUrl = "Totaluser.aspx?t=" + utl.base64Encode("3") + "&p=" + utl.base64Encode("1");
                    lnkGSAGroupABT.NavigateUrl = "Totaluser.aspx?t=" + utl.base64Encode("3") + "&p=" + utl.base64Encode("0");
                    /*--------------------------------------------------------------------------------------------------------*/


                    lblDSRPGroupA.Text = sr["directleftpbv"].ToString();
                    lblTTB.Text = sr["directleftpbv"].ToString();
                    /*lblDSRPGroupB.Text = sr["directrightpbv"].ToString();*/

                    lblDSRPGroupAB.Text = sr["directleftrightpbv"].ToString();


                    DgroupA.Text = sr["totalleftpoint"].ToString();
                    DgroupB.Text = sr["totalrightpoint"].ToString();

                    DgroupAB.Text = sr["directleftrightgbv"].ToString();

                    lblGSRPGroupA.Text = sr["leftpoint"].ToString();
                    lblGSRPGroupB.Text = sr["rightpoint"].ToString();
                    lblGSRPGroupAB.Text = sr["leftrightpoint"].ToString();
                    GgroupA.Text = sr["totalleftpoint"].ToString();
                    GgroupB.Text = sr["totalrightpoint"].ToString();

                    GgroupAB.Text = sr["totalleftrightpoint"].ToString();

                    lblcaping.Text = sr["carank"].ToString();
                    lblPPV.Text = sr["PBV"].ToString();

                    lblCarryLeftTotal.Text = sr["carryleft"].ToString();
                    lblCarryRightTotal.Text = sr["carryright"].ToString();


                    lblRPVL.Text = sr["PBV"].ToString();
                    lblRPVR.Text = sr["PBV"].ToString();
                    lblGSPVL.Text = sr["PBV"].ToString();
                    lblGSPVR.Text = sr["PBV"].ToString();
                    lblTTBCV.Text = sr["PBV"].ToString();

                    lblCarryLeftBV.Text = lblCarryRightBV.Text = sr["PBV"].ToString();


                    //lblSliverClub.Text = sr["SliverClub"].ToString();
                    //lblPlatinumClub.Text = sr["PlatinumClub"].ToString();
                    //lblRoyalClub.Text = sr["RoyalClub"].ToString();

                    //if (sr["billstatus"].ToString() == "1")
                    //{

                    //    HyperLink4.Text = "Yes";
                    //    HyperLink4.NavigateUrl = "PrintBill.aspx?id=" + sr["billno"].ToString() + "&st=" + sr["billstatus"].ToString() + "";
                    //}

                    //if (sr["billstatus"].ToString() == "0")
                    //{
                    //    HyperLink4.Text = "NO";
                    //}


                    //lblrewardrank.Text = sr["rewardrank"].ToString();
                    //lblrank.Text = sr["appmstrank"].ToString();

                    lblrank.Text = sr["appmstrank"].ToString();
                    lblrewardrank.Text = sr["rewardrank"].ToString();
                    //lblbinaryincome.Text = sr["Bincome"].ToString();
                    lblbinaryincome.Text = "0";


                    lbltotalgbv.Text = sr["oldgbv"].ToString();
                    // lbltotalpbv.Text = sr["oldpbv"].ToString();

                    //lblDoj.Text = sr["AppMstDOJ"].ToString();
                    //lblName.Text = sr["name"].ToString();
                    //lblmobile.Text = sr["AppMstMobile"].ToString();
                    //lblemail.Text = sr["email"].ToString();

                    //Ragh add
                    lblusename.Text = sr["AppMstregno"].ToString();
                    lblname.Text = sr["name"].ToString();
                    lblpanno.Text = sr["panno"].ToString();
                    lblmobile.Text = sr["AppMstMobile"].ToString();
                    lblsponsorid.Text = sr["SponsorRegNo"].ToString();
                    lblsponsorname.Text = " ("+sr["SponsorName"].ToString()+")";

                    progressbarval = sr["progressbarValue"].ToString();

                    if (Convert.ToInt32(sr["progressbarCV"]) < 1000)
                        divcv.Visible = false;
                    else
                        divcv.Visible = true;

                    progressbarcv = sr["progressbarCV"].ToString() + " CV";


                    string userimage = sr["imagename"].ToString();
                    if (userimage != "")
                    {
                        imguser.ImageUrl = imguser.ImageUrl = "~/KYC/ProfileImage/" + userimage;
                      //  imguser.ImageUrl = "~/KYC/ProfileImage/" + userimage;
                    }
                    else
                    {
                      imguser.ImageUrl = "~/KYC/ProfileImage/noimage.png";
                    }

                    // lblusename,imguser,lblname,lblpanno,lblsponsorid,lblsponsorname

                   // lnkGSAGroupA.Text = sr["leftmember"].ToString();

                   // lnkGSAGroupB.Text = sr["rightmember"].ToString();
                   // lnkGSAGroupAB.Text = sr["leftrightmember"].ToString();
                }
                else
                {
                    Response.Write("<script>alert('-Sorry :- Error..... :-')</script>");
                }
            }
            catch
            {
            }

            con.Close();
            paymentdet();
            //LeftRihgt()
           // DataSet ds = LeftRight();
           // string left = ds.Tables[0].Rows[0]["referlink"].ToString() + "" + utl.base64Encode(Session["userId"].ToString()) + "&pos=" + utl.base64Encode("Left") + "";
            //string right = ds.Tables[0].Rows[0]["referlink"].ToString() + "" + utl.base64Encode(Session["userId"].ToString()) + "&pos=" + utl.base64Encode("Right") + "";

            //lblUserInLeft.Text = left;
           // lblUserInRight.Text = right;

        }




    }

    private void RankImage(string str)
    {
        con.Open();
        com = new SqlCommand("Rankimage", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@reg", str);
        try
        {
            sr = com.ExecuteReader();
            if (sr.Read())
            {
                Image1.ImageUrl = "~/images/" + sr["ranktype"].ToString();
            }
        }
        catch
        {
        }

        con.Close();
    }


    private void paymentdet()
    {
        try
        {
            idno = Convert.ToString(Session["userId"]);
            int TTM = 0;
            int TTPM = 0;
            //isnull(IsRltAchvr,0) as IsRltAchvr,isnull(rltAchvrDate,'2010-01-01') as rltAchvrDate,GBVNL,GBVNR,GBVCL,GBVCR,GBVLM,GBVRM,
            SqlCommand cmd = new SqlCommand("select bstatus,Appmstid, AppmstSponsorTotal,tempheadleft,tempheadright,paidheadright,paidheadleft,PBVAmt,GBVAmt,AppMstRank,isnull(RankOld,0) as RankOld,AppMstLeftTotal,AppMstRightTotal,tourPointL,tourPointR,(tourPointL+tourPointR)as TourPoinT,RewardLeft,RewardRight,(RewardLeft+RewardRight)as RewardPoint from  appmst where appmstregno='" + idno + "'", con);

            con.Open();
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                TTM = Convert.ToInt32(dr["tempheadleft"]);
                TTM = TTM + Convert.ToInt32(dr["tempheadright"]);
                //lblTTM.Text = TTM.ToString();
                TTPM = Convert.ToInt32(dr["paidheadleft"]);
                TTPM = TTPM + Convert.ToInt32(dr["paidheadright"]);
                //lblTTPM.Text = TTPM.ToString();
                // lblDirect.Text = dr["AppmstSponsorTotal"].ToString();
                //lbl_PBV.Text = dr["PBVAmt"].ToString();
                //lblTeamBV.Text = dr["GBVAmt"].ToString();

                //if (Convert.ToInt32( dr["bstatus"].ToString()) ==2)
                //{
                //    lnkDocApp.Text = "Yes";
                //}
                // lblLeft.Text =Convert.ToInt32(dr["PBVAmt"])+Convert.ToInt32(dr["GBVAmt"]).ToString();
                //  lblLeft.Text = Convert.ToInt32(dr["GBVAmt"]).ToString();
                // lblRight.Text = dr["AppMstRightTotal"].ToString();
                //lblGBVT.Text = dr["GBVAmt"].ToString();
                //lblPBVT.Text = dr["PBVAmt"].ToString();
                //  lblCarryFL.Text = dr["GBVCL"].ToString();
                // lblCarryFR.Text = dr["GBVCR"].ToString();
                // lblCarryFLM.Text = dr["GBVLM"].ToString();
                // lblCarryFRM.Text = dr["GBVRM"].ToString();
                //   LinkRewardL.Text = dr["RewardLeft"].ToString();
                //LinkRewardR.Text = dr["RewardRight"].ToString();
                //   LinkRewardT.Text = dr["RewardPoint"].ToString();
                //  linkTourPL.Text = dr["tourPointL"].ToString();
                //  linkTourPR.Text = dr["tourPointR"].ToString();
                //  linkTourPT.Text = dr["TourPoinT"].ToString();
                // lbl_DV.Text = ((Convert.ToDouble(dr["GBVNL"])) + (Convert.ToDouble(dr["GBVNR"]))).ToString();

                //if (Convert.ToInt32(dr["AppMstRank"].ToString()) != 0)
                //{
                //    con = new SqlConnection(method.str);
                //    com = new SqlCommand("select RankName from tblRank where Rid=@Rid", con);
                //    com.Parameters.AddWithValue("@Rid", dr["AppMstRank"].ToString());
                //    con.Open();
                //   // lblNewRank.Text = com.ExecuteScalar().ToString();
                //    con.Close();
                //}
                if (Convert.ToInt32(dr["RankOld"].ToString()) != 0)
                {
                    con = new SqlConnection(method.str);
                    com = new SqlCommand("select RankName from tblRank where Rid=@Rid", con);
                    com.Parameters.AddWithValue("@Rid", dr["RankOld"].ToString());
                    con.Open();
                    // lblOldRank.Text = com.ExecuteScalar().ToString();
                    con.Close();
                }

                if (Convert.ToDouble(dr["PBVAmt"].ToString()) > 0)
                {
                    con = new SqlConnection(method.str);
                    com = new SqlCommand("SELLERBONUSshow", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@PBV", dr["PBVAmt"].ToString());
                    con.Open();
                    //  lblSellerbonus.Text = com.ExecuteScalar().ToString();
                    con.Close();
                }
                //******************Enrollment Level
                if (Convert.ToInt32(dr["Appmstid"].ToString()) > 1)
                {
                    con = new SqlConnection(method.str);
                    com = new SqlCommand("select isnull(max(appmstLevel),0)as Level from appTran where appmstid=@Userid", con);
                    com.Parameters.AddWithValue("@Userid", dr["Appmstid"].ToString());
                    con.Open();
                    // lblEnrollLevel.Text = com.ExecuteScalar().ToString();
                    con.Close();
                }
                //****************************My Order
                if (Convert.ToInt32(dr["Appmstid"].ToString()) > 0)
                {
                    con = new SqlConnection(method.str);
                    com = new SqlCommand("select count(*)as cnt from billmst where appmstid=@Userid", con);
                    com.Parameters.AddWithValue("@Userid", dr["Appmstid"].ToString());
                    con.Open();
                    // lblOrder.Text = com.ExecuteScalar().ToString();
                    con.Close();
                }
                //****************************My Order
                if (Convert.ToInt32(dr["Appmstid"].ToString()) > 0)
                {
                    con = new SqlConnection(method.str);
                    com = new SqlCommand("select count(*) from billmst where appmstid in(select appmstid from appTran where parentid=@Userid)", con);
                    com.Parameters.AddWithValue("@Userid", dr["Appmstid"].ToString());
                    con.Open();
                    // lblGroupOrder.Text = com.ExecuteScalar().ToString();
                    con.Close();
                }

            }
            dr.Close();
            con.Close();
        }
        catch
        {
        }
    }

    public void saveImage(string file)
    {
        try
        {
            com = new SqlCommand("saveProfileImage", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@AppMstregno", RegNo);
            com.Parameters.AddWithValue("@image", file);
            con.Open();
            com.ExecuteNonQuery();
            utility.MessageBox(this, "Image uploaded successfully!");
        }
        catch
        {
            utility.MessageBox(this, "Unsuccessfull...please try later!");
        }
        finally
        {
            con.Close();
        }
    }

    private void gocharacter(int sum)
    {
        string s = "";
        while (sum > 0)
        {
            if (sum < 20)
            {
                if (sum == 0)
                    s = s + " ZERO";
                if (sum == 1)
                    s = s + " ONE";
                if (sum == 2)
                    s = s + " TWO";
                if (sum == 3)
                    s = s + " THREE";
                if (sum == 4)
                    s = s + " FOUR";
                if (sum == 5)
                    s = s + " FIVE";
                if (sum == 6)
                    s = s + " SIX";
                if (sum == 7)
                    s = s + " SEVEN";
                if (sum == 8)
                    s = s + " EIGHT";
                if (sum == 9)
                    s = s + " NINE";
                if (sum == 10)
                    s = s + " TEN";
                if (sum == 11)
                    s = s + " ELEVEN";
                if (sum == 12)
                    s = s + " TWELVE";
                if (sum == 13)
                    s = s + " THIRTY";
                if (sum == 14)
                    s = s + " FOURTY";
                if (sum == 15)
                    s = s + " FIFTY";
                if (sum == 16)
                    s = s + " SIXTY";
                if (sum == 17)
                    s = s + " SEVENTY";
                if (sum == 18)
                    s = s + " EIGHTY";
                if (sum == 19)
                    s = s + " NINTY";
                sum = 0;
            }
            if (sum > 19 && sum < 100)
            {
                int p = sum % 10;
                sum = sum / 10;
                if (sum == 2)
                    s = s + " TWENTY";
                if (sum == 3)
                    s = s + " THIRTY";
                if (sum == 4)
                    s = s + " FOURTY";
                if (sum == 5)
                    s = s + " FIFTY";
                if (sum == 6)
                    s = s + " SIXTY";
                if (sum == 7)
                    s = s + " SEVENTY";
                if (sum == 8)
                    s = s + " EIGHTY";
                if (sum == 9)
                    s = s + " NINTY";
                sum = p;
            }
            if (sum > 99 && sum < 1000)
            {
                int c = sum % 100;
                sum = sum - c;
                if (sum == 100)
                    s = s + " ONE HUNDRED";
                if (sum == 200)
                    s = s + " TWO HUNDRED";
                if (sum == 300)
                    s = s + " THREE HUNDRED";
                if (sum == 400)
                    s = s + " FOUR HUNDRED";
                if (sum == 500)
                    s = s + " FIVE HUNDRED";
                if (sum == 600)
                    s = s + " SIX HUNDRED";
                if (sum == 700)
                    s = s + " SEVEN HUNDRED";
                if (sum == 800)
                    s = s + " EIGHT HUNDRED";
                if (sum == 900)
                    s = s + " NINE HUNDRED";
                sum = c;
            }
            if (sum > 999 && sum <= 9999)
            {
                int c = sum % 1000;
                sum = sum - c;
                if (sum == 1000)
                    s = s + " ONE THOUSAND";
                if (sum == 2000)
                    s = s + " TWO THOUSAND";
                if (sum == 3000)
                    s = s + " THREE THOUSAND";
                if (sum == 4000)
                    s = s + " FOUR THOUSAND";
                if (sum == 5000)
                    s = s + " FIVE THOUSAND";
                if (sum == 6000)
                    s = s + " SIX THOUSAND";
                if (sum == 7000)
                    s = s + " SEVEN THOUSAND";
                if (sum == 8000)
                    s = s + " EIGHT THOUSAND";
                if (sum == 9000)
                    s = s + " NINE THOUSAND";
                sum = c;
            }
            if (sum > 9999 && sum <= 99999)
            {
                int b, f, g, t;
                int c = sum % 1000;
                sum = sum - c;
                b = sum / 1000;
                t = b % 10;
                f = t;
                f = f * 1000;
                sum = sum - f;
                if (sum == 10000)
                    s = s + " TEN";
                if (sum == 20000)
                    s = s + " TWENTY";
                if (sum == 30000)
                    s = s + " THIRTY";
                if (sum == 40000)
                    s = s + " FOURTY";
                if (sum == 50000)
                    s = s + " FIFTY";
                if (sum == 60000)
                    s = s + " SIXTY";
                if (sum == 70000)
                    s = s + " SEVENTY";
                if (sum == 80000)
                    s = s + " EIGHTY";
                if (sum == 90000)
                    s = s + " NINTY";
                if (t == 0)
                    s = s + " THOUSAND";
                if (t == 1)
                    s = s + " ONE THOUSAND";
                if (t == 2)
                    s = s + " TWO THOUSAND";
                if (t == 3)
                    s = s + " THREE THOUSAND";
                if (t == 4)
                    s = s + " FOUR THOUSAND";
                if (t == 5)
                    s = s + " FIVE THOUSAND";
                if (t == 6)
                    s = s + " SIX THOUSAND";
                if (t == 7)
                    s = s + " SEVEN THOUSAND";
                if (t == 8)
                    s = s + " EIGHT THOUSAND";
                if (t == 9)
                    s = s + " NINE THOUSAND";



                sum = c;
            }
        }
        s = s + " ONLY";
        //lblcharacter.Text = s;
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
                //else if (dt.Rows[i]["newstype"].ToString() == "OF")
                //{
                //    offernews.Append(dt.Rows[i]["photo"].ToString() + " " + dt.Rows[i]["NewsMstDiscription"].ToString() + " ");
                //}
                //else if (dt.Rows[i]["newstype"].ToString() == "YO")
                //{
                //    productinfonews.Append(dt.Rows[i]["photo"].ToString() + " " + dt.Rows[i]["NewsMstDiscription"].ToString() + " ");
                //}
            }
            dvNews.InnerHtml = sbNews.ToString();

        }
    }




    private void GetPaymentDetails()
    {
        try
        {
            com = new SqlCommand("FetchPaymentDetails", con);
            com.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(com);
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lblPBV.Text = lblCM.Text = lblTC.Text = dt.Rows[0]["RPBV"].ToString();
                lblGBV.Text = lblTGBV.Text = dt.Rows[0]["RGBV"].ToString();

            }

        }
        catch
        {

        }
    }

    public void GetImageList()
    {

        try
        {
            
            StringBuilder sbimg = new StringBuilder();
            com = new SqlCommand("GetImagePopup", con);
            com.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(com);
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count >= 1)
            {
                ab.Visible = true;

                if (dt.Rows.Count == 1)
                {
                    //rptrImages.DataSource = dt;
                    //rptrImages.DataBind();
                    str2 = dt.Rows[0]["imagename"].ToString();
                }
                else
                    if (dt.Rows.Count > 1)
                    {
                        str2 = dt.Rows[0]["imagename"].ToString();
                        dt.Rows[0].Delete();
                        dt.AcceptChanges();
                        rptrImages.DataSource = dt;
                        rptrImages.DataBind();
                    }
            }
            else
            {
                //ab.InnerText = ".hidden{display:none;}";
                ab.Visible = false;
                //overlay.InnerText = ".hidden{display:none;}";
                rptrImages.DataSource = null;
                rptrImages.DataBind();
            }
        }
        catch
        {
            //overlay.InnerText = ".hidden{display:none;}";

        }
    }

    private DataSet LeftRight()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("spLeftRight", con);
        com.CommandType = CommandType.StoredProcedure;
        //com.Parameters.AddWithValue("@regno", str);
        SqlDataAdapter adp = new SqlDataAdapter(com);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        return ds;
    }

    protected void lblUserInLeft_Click(object sender, EventArgs e)
    {
        DataSet ds = LeftRight();
        string left = ds.Tables[0].Rows[0]["referlink"].ToString() + "" + utl.base64Encode(Session["userId"].ToString()) + "&pos=" + utl.base64Encode("Left") + "";
        Session.Abandon();
        Response.Redirect("" + left + "");
    }
    protected void lblUserInRight_Click(object sender, EventArgs e)
    {
        DataSet ds = LeftRight();
        string right = ds.Tables[0].Rows[0]["referlink"].ToString() + "" + utl.base64Encode(Session["userId"].ToString()) + "&pos=" + utl.base64Encode("Right") + "";
        Session.Abandon();
        Response.Redirect("" + right + "");
    }










}
