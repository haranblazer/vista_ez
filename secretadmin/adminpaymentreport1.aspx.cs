using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Data;

public partial class admin_adminpaymentreport1 : System.Web.UI.Page
{
    static string strsession, strsession2;
    int payoutno;

    string date, uid;
    string str;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;

    string fsi;
    utility objUtil = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {

        Response.Cache.SetNoStore();
        if (!IsPostBack)
            InsertFunction.CheckAdminlogin();

        Response.Cache.SetAllowResponseInBrowserHistory(true);

        strsession = Convert.ToString(objUtil.base64Decode(Request.QueryString["id"]));

       uid = Convert.ToString(objUtil.base64Decode(Request.QueryString["uid"]));

        date = Convert.ToString(objUtil.base64Decode(Request.QueryString["date"]));

        // payoutno = Convert.ToInt32(objUtil.base64Decode(Request.QueryString["n"]));

        //strsession = Convert.ToString(objUtil.base64Decode(Request.QueryString["id"]));

        payoutno = Convert.ToInt32(Session["payoutno"].ToString());
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

               
                lblhousefund.Text = sdr["hf"].ToString();
                lblroyaltyfund.Text = sdr["rb"].ToString();
                lblTotal.Text = sdr["dispachedamt"].ToString();
                lblgbv.Text =   Convert.ToString(double.Parse(sdr["gbv"].ToString()));
                lblpbv.Text = Convert.ToString(double.Parse(sdr["pbv"].ToString()));
               
                lblPayoutFromDate.Text = sdr["paymentfromdate"].ToString();
                lblPayoutToDate.Text = sdr["paymenttodate"].ToString();

                lblTDS.Text = sdr["tds"].ToString();

                lblOC.Text = sdr["handlingcharges"].ToString();

                lblCoSponsor.Text = sdr["cosponsor"].ToString();

                lblfsi.Text = sdr["fsi"].ToString();

                fsi = sdr["checkdata"].ToString();



                if (sdr["FI"].ToString() == "")
                {
                    lblFi.Text = "0";
                }



                if (fsi == "No fsi")
                {

                    tr1.Visible = false;
                }
                if (fsi == "fsi")
                {

                    tr1.Visible = true;
                }
              

            }

            sdr.Close();
            con.Close();

            string qstr1 = "select 'website : '+ website + '  /'+' email '+emailid as website ,p.companyname,p.address,ap.AppMstTitle,ap.AppmstFname,ap.appmstdoj,ap.appmstregno,ap.appmstaddress1,ap.email,ap.appmstpincode,ap.AppMstMobile,ap.distt,ap.AppMstCity,ap.AppMstState,ap.AppMstPinCode from appmst ap,paymentmst p where ap.appmstregno='" + strsession + "'";
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

              
                lblComapnyName.Text = sdr["companyname"].ToString();

                lblCompanyAddress.Text = sdr["address"].ToString();
                lblcompanywebsite.Text = sdr["website"].ToString();
                

            }
            sdr.Close();
            con.Close();

            fetch();
        }
    }


    public void fetch()
    {

        SqlDataAdapter da = new SqlDataAdapter("detail2", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.CommandTimeout = 999999;
        da.SelectCommand.Parameters.AddWithValue("@userid",uid );
        da.SelectCommand.Parameters.AddWithValue("@date", date);
        da.SelectCommand.Parameters.AddWithValue("@paymentcause","PI");
        //da.SelectCommand.Parameters.AddWithValue("@Types", "WELCOME");
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            Repeater1.DataSource = dt;
            Repeater1.DataBind();
        }
        else
        {
            Repeater1.DataSource = null;
            Repeater1.DataBind();
        }

    }



   
}
