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
public partial class user_genology : System.Web.UI.Page
{
    string imgg;
    string img;
    string qstr1, strname, url;
    string userid;
    string id;
    string ypin;
    DataTable dt;
    SqlDataAdapter da;
    string str, str1;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    string tooltip = "";

    utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {

        string strPreviousPage = "";
        if (Request.UrlReferrer != null)
        {
            strPreviousPage = Request.UrlReferrer.Segments[Request.UrlReferrer.Segments.Length - 1];
        }
        //if (strPreviousPage == "")
        //{
        //    Response.Redirect("~/Login.aspx");
        //}
        if (Request.QueryString["n"] != null)
        {
            qstr1 = obj.base64Decode(Convert.ToString(Request.QueryString["n"]));
            strname = obj.base64Decode(Convert.ToString(Request.QueryString["n1"]));
            if (qstr1 == "" || strname == "")
                Response.Redirect("~/Error.aspx", false);
        }
        if (Request.QueryString["uid"] != null)
        {
            Session["userId"] = obj.base64Decode(Convert.ToString(Request.QueryString["uid"]));
        }
        if (Session["userId"] == null)
            Response.Redirect("~/login.aspx", false);



        if (!IsPostBack)
        {
            imgR1.Visible = false;
            imgR2.Visible = false;
            imgR3.Visible = false;
            imgR4.Visible = false;
            imgR5.Visible = false;
            imgR6.Visible = false;
            imgR7.Visible = false;
            imgR8.Visible = false;
            imgR9.Visible = false;
            imgR10.Visible = false;
            imgR11.Visible = false;
            imgR12.Visible = false;
            imgR13.Visible = false;
            imgR14.Visible = false;
            imgR15.Visible = false;

        }
        str = Convert.ToString(Session["userName"]);
        str1 = Convert.ToString(Session["userId"]);

        if (qstr1 != null)
        {
            go(qstr1);
        }
        else if (str1 != "")
        {

            go(str1);
        }
        else
        {
            Response.Redirect("../login.aspx");
        }
    }

    public void go(string strreg)
    {
        da = new SqlDataAdapter("rootnode1", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@regno", strreg);

        DataTable t = new DataTable();
        da.Fill(t);
        HyperLink1.Text = "";
        if (t.Rows.Count > 0)
        {
            id = t.Rows[0]["AppMstRegNo"].ToString().Trim();
            ypin = t.Rows[0]["ypin"].ToString().Trim();


            //    t.Rows[0]["Rewardleft"].ToString();t.Rows[0]["rewardright"].ToString();
            //   t.Rows[0]["TourpointR"].ToString(); t.Rows[0]["TourpointL"].ToString();

            //HyperLink1.Text += t.Rows[0]["AppMstFName"].ToString().Trim() + "<br>";
            //HyperLink1.Text += id.ToString() + "(PV:" + t.Rows[0]["JoinFor"].ToString() + ")<br/>";
            //HyperLink1.Text += "PP:" + t.Rows[0]["pp"].ToString();

            BindHyperLink(HyperLink1, t.Rows[0]["AppMstRegNo"].ToString().Trim(), t.Rows[0]["AppMstFName"].ToString().Trim(), t.Rows[0]["JoinFor"].ToString(),
                 t.Rows[0]["Appmstlefttotal"].ToString(), t.Rows[0]["AppmstRighttotal"].ToString(), t.Rows[0]["carryleft"].ToString(),
                t.Rows[0]["carryright"].ToString(), t.Rows[0]["totalnewleft"].ToString(), t.Rows[0]["totalnewright"].ToString(), t.Rows[0]["appmstpaid"].ToString(), t.Rows[0]["ypin"].ToString(), ImageButton1,

                t.Rows[0]["LeftRp"].ToString(), t.Rows[0]["RightRp"].ToString(),
                 t.Rows[0]["Rewardleft"].ToString(), t.Rows[0]["rewardright"].ToString(),
                t.Rows[0]["TourpointL"].ToString(), t.Rows[0]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),1);


            // tooltip = "Tour Left : " + t.Rows[0]["TourPointL"].ToString() + "  " + "Tour Right : " + t.Rows[0]["TourPointR"].ToString() + "<br/>Bonus Left : " + t.Rows[0]["RewardLeft"].ToString() + " " + "Bonus Right : " + t.Rows[0]["RewardRight"].ToString();

            con.Close();
            // imgReward(id, imgR1, ImageButton1, Convert.ToDecimal(t.Rows[0]["JoinFor"].ToString()), t.Rows[0]["appmstpaid"].ToString());
            go1(id);
        }

    }

    //=========label1=========
    public void go1(string str)
    {
        HyperLink2.Visible = true;

        HyperLink2.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("left");
        HyperLink3.Visible = true;
        HyperLink3.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("right");
        com = new SqlCommand("sp_tree11", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@AppMstRegNo", str);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (t.Rows[i]["AppMstLeftRight"].ToString() == "0")
            {
                HyperLink2.Text = "";
                HyperLink2.NavigateUrl = "#";
                id = t.Rows[i]["appmstregno"].ToString().Trim();
                // imgReward(id, imgR2, ImageButton2, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());

                BindHyperLink(HyperLink2, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
                t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
               t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton2, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                 t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),2);



                lnext5(id);
            }
            else
            {
                HyperLink3.Text = "";
                HyperLink3.NavigateUrl = "#";
                id = t.Rows[i]["appmstregno"].ToString().Trim();
                //imgReward(id, imgR3, ImageButton3, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());

                BindHyperLink(HyperLink3, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
               t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
              t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton3, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                 t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),3);

                string name = t.Rows[i]["appmstfname"].ToString();



                rnext7(id);
            }
        }
    }
    //======label2=========
    public void lnext5(string str)
    {
        HyperLink4.Visible = true;
        HyperLink4.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("left");
        HyperLink5.Visible = true;
        HyperLink5.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("right");
        com = new SqlCommand("sp_tree11", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@AppMstRegNo", str);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (t.Rows[i]["AppMstLeftRight"].ToString() == "0")
            {
                HyperLink4.Text = "";
                HyperLink4.NavigateUrl = "#";
                id = t.Rows[i]["appmstregno"].ToString().Trim();
                //imgReward(id, imgR4, ImageButton4, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());

                BindHyperLink(HyperLink4, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
              t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
             t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton4, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                 t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),4);



                string name = t.Rows[i][1].ToString();


                lnext9(id);
            }
            else
            {
                HyperLink5.Text = "";
                HyperLink5.NavigateUrl = "#";
                id = t.Rows[i]["appmstregno"].ToString().Trim();
                // imgReward(id, imgR5, ImageButton5, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());
                BindHyperLink(HyperLink5, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
             t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
            t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton5, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                 t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),5);



                string name = t.Rows[i]["appmstfname"].ToString();


                rnext11(id);
            }
        }
    }
    public void rnext7(string str)
    {
        HyperLink6.Visible = true;
        HyperLink6.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("left");
        HyperLink7.Visible = true;
        HyperLink7.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("right");
        com = new SqlCommand("sp_tree11", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@AppMstRegNo", str);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (t.Rows[i]["AppMstLeftRight"].ToString() == "0")
            {
                HyperLink6.Text = "";
                HyperLink6.NavigateUrl = "#";
                id = t.Rows[i]["appmstregno"].ToString().Trim();
                //imgReward(id, imgR6, ImageButton6, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());
                BindHyperLink(HyperLink6, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
                t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
                t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton6, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),6);

                string name = t.Rows[i]["appmstfname"].ToString();




                lnext11(id);
            }
            else
            {
                HyperLink7.Text = "";
                HyperLink7.NavigateUrl = "#";
                id = t.Rows[i]["appmstregno"].ToString().Trim();
                //imgReward(id, imgR7, ImageButton7, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());

                BindHyperLink(HyperLink7, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
                t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
                t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton7, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),7);

                string name = t.Rows[i]["appmstfname"].ToString();


                rnext15(id);
            }
        }
    } //    //==============label2=================
    public void lnext9(string str)
    {
        HyperLink8.Visible = true;

        HyperLink9.Visible = true;
        HyperLink8.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("left");

        HyperLink9.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("right");

        com = new SqlCommand("sp_tree11", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@AppMstRegNo", str);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (t.Rows[i]["AppMstLeftRight"].ToString() == "0")
            {
                HyperLink8.Text = "";
                HyperLink8.NavigateUrl = "#";

                id = t.Rows[i]["appmstregno"].ToString().Trim();
                //imgReward(id, imgR8, ImageButton8, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());

                BindHyperLink(HyperLink8, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
              t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
             t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton8, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                 t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),8);



            }
            else
            {
                HyperLink9.Text = "";
                HyperLink9.NavigateUrl = "#";

                id = t.Rows[i]["appmstregno"].ToString().Trim();
                // imgReward(id, imgR9, ImageButton9, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());

                BindHyperLink(HyperLink9, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
             t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
            t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton9, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                 t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),9);

            }
        }
    }
    public void rnext11(string str)
    {
        HyperLink10.Visible = true;

        HyperLink11.Visible = true;
        HyperLink10.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("right");
        HyperLink11.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("right");


        com = new SqlCommand("sp_tree11", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@AppMstRegNo", str);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (t.Rows[i]["AppMstLeftRight"].ToString() == "0")
            {
                HyperLink10.Text = "";

                HyperLink10.NavigateUrl = "#";


                id = t.Rows[i]["appmstregno"].ToString().Trim();
                // imgReward(id, imgR10, ImageButton10, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());

                BindHyperLink(HyperLink10, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
                t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
                t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton10, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),10);

            }
            else
            {
                HyperLink11.Text = "";
                HyperLink11.NavigateUrl = "#";

                id = t.Rows[i]["appmstregno"].ToString().Trim();
                //imgReward(id, imgR11, ImageButton11, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());

                BindHyperLink(HyperLink11, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
                t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
                t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton11, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),11);
            }
        }
    }
    //}
    public void lnext11(string str)
    {
        HyperLink12.Visible = true;
        HyperLink12.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("left");
        HyperLink13.Visible = true;
        HyperLink13.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("right");
        com = new SqlCommand("sp_tree11", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@AppMstRegNo", str);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (t.Rows[i]["AppMstLeftRight"].ToString() == "0")
            {
                HyperLink12.Text = "";
                HyperLink12.NavigateUrl = "#";
                id = t.Rows[i]["appmstregno"].ToString().Trim();
                //imgReward(id, imgR12, ImageButton12, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());

                BindHyperLink(HyperLink12, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
                t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
                t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton12, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),12);

            }
            else
            {
                HyperLink13.Text = "";
                HyperLink13.NavigateUrl = "#";
                id = t.Rows[i]["appmstregno"].ToString().Trim();
                // imgReward(id, imgR13, ImageButton13, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());

                BindHyperLink(HyperLink13, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
                t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
                t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton13, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),13);

            }
        }
    }

    public void rnext15(string str)
    {
        HyperLink14.Visible = true;
        HyperLink14.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("left");
        HyperLink15.Visible = true;
        HyperLink15.NavigateUrl = "newjoin.aspx?n=" + obj.base64Encode(str) + "&n2=" + obj.base64Encode(str1) + "&n1=" + obj.base64Encode("right");
        com = new SqlCommand("sp_tree11", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@AppMstRegNo", str);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        for (int i = 0; i < t.Rows.Count; i++)
        {
            if (t.Rows[i]["AppMstLeftRight"].ToString() == "0")
            {
                HyperLink14.Text = "";
                HyperLink14.NavigateUrl = "#";
                id = t.Rows[i]["appmstregno"].ToString().Trim();
                // imgReward(id, imgR14, ImageButton14, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());
                BindHyperLink(HyperLink14, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
             t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
            t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton14, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                 t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),14);

            }
            else
            {
                HyperLink15.Text = "";
                HyperLink15.NavigateUrl = "#";
                id = t.Rows[i]["appmstregno"].ToString().Trim();
                // imgReward(id, imgR15, ImageButton15, Convert.ToDecimal(t.Rows[i]["JoinFor"].ToString()), t.Rows[i]["appmstpaid"].ToString());

                BindHyperLink(HyperLink15, t.Rows[i]["AppMstRegNo"].ToString().Trim(), t.Rows[i]["AppMstFName"].ToString().Trim(), t.Rows[i]["JoinFor"].ToString(),
            t.Rows[i]["Appmstlefttotal"].ToString(), t.Rows[i]["AppmstRighttotal"].ToString(), t.Rows[i]["carryleft"].ToString(),
           t.Rows[i]["carryright"].ToString(), t.Rows[i]["totalnewleft"].ToString(), t.Rows[i]["totalnewright"].ToString(), t.Rows[i]["appmstpaid"].ToString(), t.Rows[i]["ypin"].ToString(), ImageButton15, t.Rows[i]["LeftRp"].ToString(), t.Rows[i]["RightRp"].ToString(),
                 t.Rows[i]["Rewardleft"].ToString(), t.Rows[i]["rewardright"].ToString(),
                t.Rows[i]["TourpointL"].ToString(), t.Rows[i]["TourpointR"].ToString(), t.Rows[0]["gbvamt"].ToString(), t.Rows[0]["pbvamt"].ToString(), t.Rows[0]["pbv"].ToString(), t.Rows[0]["gbv"].ToString(),15);

            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string qstr1 = "select Appmstregno,AppMstFName,appmstid from AppMst where Appmstregno=@regno";
        con.Open();
        com = new SqlCommand(qstr1, con);
        com.Parameters.AddWithValue("@regno", str1);
        sdr = com.ExecuteReader();
        if (sdr.Read())
        {
            int id = Convert.ToInt32(sdr[2].ToString());
            con.Close();
            find1(id);
        }
    }
    public void find1(int id1)
    {

        try
        {
            string qstr = "select a.Appmstregno,a.AppMstFName from apptran ap inner join appmst a on ap.appmstid=a.appmstid where ap.parentid=@appid and a.Appmstregno=@regno";

            con.Open();
            com = new SqlCommand(qstr, con);
            com.Parameters.AddWithValue("@regno", TextBox1.Text.Trim());
            com.Parameters.AddWithValue("@appid", id1);
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {
                string id2 = sdr["Appmstregno"].ToString().Trim();
                string name = sdr["AppMstFName"].ToString().Trim();
                con.Close();
                string str = "?n=" + obj.base64Encode(id2) + "&n1=" + obj.base64Encode(name) + "";
                Response.Redirect("genology.aspx" + str);
            }
            else
            {
                lblmsg.Text = "Not Your DownLine";
                con.Close();
            }
        }
        catch
        {
            con.Close();
        }
    }
    public void imag1(string str, ImageButton ibtn, decimal joinfor, string paid, string ypin)
    {
        com = new SqlCommand("sp_images", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@UserId", str);
        con.Open();
        sdr = com.ExecuteReader();
        if (sdr.Read())
        {
            imgg = "~/user_images/" + sdr["image"].ToString();
            ibtn.ImageUrl = imgg;
            con.Close();
        }
        else
        {
            con.Close();
            if (paid == "1" || ypin == "1")
                imgg = "~/user_images/paid.gif";


            else
                imgg = "~/user_images/unpaid.gif";
            ibtn.ImageUrl = imgg;
        }
        con.Close();
    }

    //public void imgReward(string str, Image img, ImageButton imgbtn, decimal joinfor, string paid)
    //{

    //    //string idd = img.ID.ToString();
    //    string url = "";
    //    DataTable dt = new DataTable();
    //    com = new SqlCommand("select AwardName from tblreward where appmstregno =@regno and totalpair =(select max(totalpair) from tblreward where appmstregno = @regno)", con);
    //    com.Parameters.AddWithValue("@regno", str);
    //    con.Open();
    //    sdr = com.ExecuteReader();
    //    if (sdr.HasRows)
    //    {

    //        while (sdr.Read())
    //        {
    //            string awd = Convert.ToString(sdr["AwardName"]);
    //            if (string.Compare(awd, "Calling Tab (Physical)", true) == 0)
    //            {
    //                url = "~/user_images/CallTab.gif";
    //            }
    //            if (string.Compare(awd, "For Laptop (Worth – Rs. 15000/-)", true) == 0)
    //            {
    //                url = "~/user_images/Laptop.gif";
    //            }

    //            if (string.Compare(awd, "For Bike (Worth – Rs.35000/-)", true) == 0)
    //            {
    //                url = "~/user_images/bike.gif";
    //            }


    //            if (string.Compare(awd, "For Alto (Worth- Rs.200000/-)", true) == 0)
    //            {
    //                url = "~/user_images/alto.gif";
    //            }


    //            if (string.Compare(awd, "For Swift (Worth- Rs.500000/-)", true) == 0)
    //            {
    //                url = "~/user_images/swift.gif";
    //            }



    //            if (string.Compare(awd, "For H.City (Worth- Rs.1000000/-)", true) == 0)
    //            {
    //                url = "~/user_images/HCity.gif";
    //            }
    //            if (string.Compare(awd, "For Endeavour(Worth- Rs.1600000/-)", true) == 0)
    //            {
    //                url = "~/images/Endeavor.gif";
    //            }

    //            if (string.Compare(awd, "For Mercedes (Worth- Rs.2100000/-)", true) == 0)
    //            {
    //                url = "~/images/Mercedes-benz.gif";
    //            }

    //            if (string.Compare(awd, "For BMW (Worth- Rs.3500000/-)", true) == 0)
    //            {
    //                url = "~/images/bmw.gif";
    //            }


    //            //~/images/endevor-18.png 

    //        }
    //        img.Visible = true;
    //        img.ImageUrl = url;
    //        img.Height = 40;
    //        img.Width = 50;
    //        con.Close();
    //        if (url != "")
    //        {
    //            imgbtn.Visible = false;
    //        }
    //    }
    //    else
    //    {
    //        con.Close();
    //        img.Visible = false;
    //        imag1(id, imgbtn, joinfor, paid, ypin);
    //    }
    //}

    private void BindHyperLink(HyperLink hlnk, string regno, string name, string joinfor, string appmstLeftTotal, string appmstRightTotal, string carryLeft, string carryRight, string totalNewLeft, string TotalNewRight, string paid, string ypin, ImageButton imgbtn, string LeftRP, string RightRP, string RWL, string RWR, string TourL, string TourR, string GBV, string PBV, string pbv1, string gbv1,int count)
    {




        HtmlGenericControl div = new HtmlGenericControl();

        string tab = "table" + Convert.ToString(count);


        div.InnerHtml = "<div class='container-fluid'>";
        div.InnerHtml = "<<div class='row'>";

       


        div.InnerHtml = "<table   align='background-color:Blue' style='padding:0px;margin:0px' >";
        

        div.InnerHtml += "<tr><td>" + name + "</td><tr>";
        if (hlnk == HyperLink1)
            div.InnerHtml += "<tr ><td><a style='color:black' href='javascript:void'>" + regno + "</a></td><tr>";
        else

        div.InnerHtml += "<tr ><td ><a style='color:black' href='genology.aspx?n=" + obj.base64Encode(regno) + "&n1=" + obj.base64Encode(name) + "'>" + regno + "</a></td><tr>";
        div.InnerHtml += "<tr ><td>";

        if (count == 3 || count == 6 || count == 7 || count == 12 || count == 13 || count == 14 || count == 15)
        {
            div.InnerHtml += "<table class='table table-sm' style='data-placement:left'   border='1'  id=" + tab;
        }

        else
        {
            div.InnerHtml += "<table class='table table-sm' style='data-placement:top'   border='1'  id=" + tab;
        }

        div.InnerHtml += "><tr ><td colspan='4' style='text-align:center;width:25%'  ><span style='font-size:14px;font-weight:bold'>User Information</span></td></tr>";

        div.InnerHtml += "<tr><td style='width:25%' >User ID</td><td style='width:25%' >" + regno + "</td><td style='width:25%'>User Name</td><td style='width:25%'>" + name + "</td></tr>";



        div.InnerHtml += "<tr ><td style='width:25%'>Left Total</td><td style='width:25%'>" + appmstLeftTotal + "</td><td style='width:25%' class='d-inline-block col-3'>Right Total</td><td style='width:25%'>" + appmstRightTotal + "</td></tr>";

        div.InnerHtml += "<tr ><td style='width:25%'>New Left</td><td style='width:25%'>" + totalNewLeft + "</td><td style='width:25%'>New Right</td><td style='width:25%'>" + TotalNewRight + "</td></tr>";


        div.InnerHtml += "<tr ><td style='width:25%'>GBV</td><td style='width:25%'>" + GBV + "</td><td style='width:25%'>PBV</td><td style='width:25%'>" + PBV + "</td></tr>";

        div.InnerHtml += "<tr ><td style='width:25%'>Reward Left</td><td style='width:25%'>" + RWL + "</td><td style='width:25%'>Reward Right</td><td style='width:25%'>" + RWR + "</td></tr>";


        div.InnerHtml += "<tr ><td style='width:25%'>Tour Left</td><td style='width:25%'>" + TourL + "</td><td style='width:25%'>Tour Right</td><td style='width:25%'>" + TourR + "</td></tr>";

       
        
        
        //hlnk.ToolTip += Environment.NewLine + pbv1 + ":" + GBV + " | " + gbv1 + ":" + PBV;

        //hlnk.ToolTip += Environment.NewLine + "Reward Left:" + RWL + " | " + "Reward Right:" + RWR;

        //hlnk.ToolTip += Environment.NewLine + "Tour Left:" + TourL + " | " + "Tour Right:" + TourR;
        //div.InnerHtml += "<tr><td style='width:25%'>Sponsor ID</td><td style='width:25%'>" + sponsorid + "</td><td style='width:25%'>Sponsor Name</td><td style='width:25%'>" + sponsorname + "</td></tr>";
        //div.InnerHtml += "<tr><td style='width:25%'>Doj</td><td style='width:25%'>" + appmstdoj + "</td><td style='width:25%'>PaidDate</td><td style='width:25%'>" + paiddoe + "</td></tr>";




        //div.InnerHtml += "<tr><td style='width:25%'>Left Total</td><td style='width:25%'>" + templeft + "</td><td style='width:25%'>Right Total</td><td style='width:25%'>" + tempright + "</td></tr>";

        //div.InnerHtml += "<tr><td colspan='2' style='text-align:center;' ><span style='font-size:14px;font-weight:bold'>Package</span></td><td colspan='2' style='text-align:center;' ><span style='font-size:14px;font-weight:bold'>" + idtype + "</span></td></tr>";




        div.InnerHtml += "</td></table>";
        div.InnerHtml += "</tr>";

        div.InnerHtml += "</table>";

        div.InnerHtml += "</div>";

        div.InnerHtml += "</div>";
        hlnk.Controls.Add(div);



        if (paid == "1")
            imgbtn.ImageUrl = "~/user_images/paid13.png";
        else if (paid == "0" && ypin == "0")
            imgbtn.ImageUrl = "~/user_images/unpaid.png";
        else if (ypin == "1")
            imgbtn.ImageUrl = "~/user_images/paid12.png";
        
        
        
        
        
        
        
        
        
        
        
       
    }
}
