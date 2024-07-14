using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;

public partial class user_RePurchaseList : System.Web.UI.Page
{
    static string strsession, strsession2;
    int payoutno;
    string str;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    utility objUtil = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
            //  InsertFunction.CheckAdminlogin();


            strsession = Convert.ToString(Session["userId"].ToString());

        //    strsession = Convert.ToString(objUtil.base64Decode(Request.QueryString["n"]));

        payoutno = Convert.ToInt32(objUtil.base64Decode(Request.QueryString["n"]));

        // payoutno = Convert.ToInt32(Session["payoutno"].ToString());
        if (Regex.Match(strsession + payoutno, @"^[A-Za-z0-9]*$").Success)
        {


            con.Open();
            com = new SqlCommand("result2", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@appmstid", strsession);
            com.Parameters.AddWithValue("@payoutno", payoutno);

            sdr = com.ExecuteReader();
            if (sdr.Read())
            {

                lblFi.Text = sdr["FI"].ToString();
                PI.Text = sdr["pi"].ToString();
                lblperofrmancebonus.Text = sdr["pb"].ToString();
                lblperfonanceroyalty.Text = sdr["pr"].ToString();
                lblbikefund.Text = sdr["bf"].ToString();
                bltravelfund.Text = sdr["tf"].ToString();
                lblcarfund.Text = sdr["cf"].ToString();


                lblCoSponsor.Text = sdr["cosponsor"].ToString();
                 lblhousefund.Text = sdr["hf"].ToString();
                lblroyaltyfund.Text = sdr["rb"].ToString();
                lblTotal.Text = sdr["totalearning"].ToString();
                lblgbv.Text = Convert.ToString(double.Parse(sdr["gbv"].ToString()));
                lblpbv.Text = Convert.ToString(double.Parse(sdr["pbv"].ToString()));
                //lblpbv.Text = sdr["pbv"].ToString(); 
                lblPayoutFromDate.Text = sdr["paymentfromdate"].ToString();
                lblPayoutToDate.Text = sdr["paymenttodate"].ToString();

                if (sdr["FI"].ToString() == "")
                {
                    lblFi.Text = "0";
                }
              

               

                con.Close();
            }


            string qstr1 = "select AppMstTitle,AppmstFname,appmstregno,appmstaddress1,email,appmstpincode,AppMstMobile,distt,AppMstCity,AppMstState,AppMstPinCode from appmst where appmstregno='" + strsession + "'";
            con.Open();
            com = new SqlCommand(qstr1, con);
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {


                lblName.Text = sdr["AppmstFname"].ToString();

                lblUserId.Text = sdr["appmstregno"].ToString();

                lblAddress.Text = sdr["appmstaddress1"].ToString();

                lblMobile.Text = sdr["AppMstMobile"].ToString();

                lblEMailId.Text = sdr["email"].ToString();


               
            }
            sdr.Close();
            con.Close();
        }
    }


}
