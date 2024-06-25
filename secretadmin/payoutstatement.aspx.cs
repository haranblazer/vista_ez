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
public partial class payoutstatement : System.Web.UI.Page
{
    static string strsession;
    string str;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {

        InsertFunction.Checklogin();  
        strsession = Convert.ToString(Session["userId"]);  // Convert.ToString(Session["login"]);
            
                if (strsession == "")
        {
            Response.Redirect("..//login.aspx");
        }
     str = Convert.ToString(Request.QueryString["n"]);    

     con.Open();
     com = new SqlCommand("sp_acountdate", con);
     com.CommandType = CommandType.StoredProcedure;
     com.Parameters.AddWithValue("@appmstid", strsession);
     com.Parameters.AddWithValue("@payoutno", str);
     sdr = com.ExecuteReader();
     if (sdr.Read())
     {
         Label20.Text = sdr["paymentfromdate"].ToString() + "--" + sdr["paymenttodate"].ToString();
         con.Close();
     }
     else {
         Label20.Text = "No Date Found";
         con.Close();
     }       


        con.Open();
        com = new SqlCommand("result", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@appmstid", strsession);
        com.Parameters.AddWithValue("@payoutno", str);
       
        sdr = com.ExecuteReader();
        if (sdr.Read())
        {
           
            lblTotalPaid.Text = Convert.ToInt32(sdr["TPL"])+ Convert.ToInt32(sdr["TPR"]).ToString();           
            lblTotalNewpaid.Text = Convert.ToInt32(sdr["NPL"]) + Convert.ToInt32(sdr["NPR"]).ToString();
            lblbrtfrwd.Text = Convert.ToInt32(sdr["BFL"]) + Convert.ToInt32(sdr["BFR"]).ToString();            
            lblCalculatepaid.Text = Convert.ToInt32(sdr["CPL"]) + Convert.ToInt32(sdr["CPR"]).ToString();
            lblCarriefrwd.Text = Convert.ToInt32(sdr["CFL"]) + Convert.ToInt32(sdr["CFR"]).ToString();          
            lbltotpair.Text = sdr["TP"].ToString();

            Label15.Text = sdr["dispachedamt"].ToString();

            lblBinaryIncome.Text = sdr["binaryamt"].ToString();
            lblLB.Text = sdr["leadershipamt"].ToString();
            lblRoyalty.Text = sdr["RoyaltyAmt"].ToString();
            lblEfund.Text = sdr["othercharges"].ToString();
           
            totalearning.Text = sdr["totalearning"].ToString();
            Label13.Text = sdr["TDS"].ToString();


            Label14.Text = sdr["handlingCharges"].ToString();        
           
            
            Label26.Text = sdr["paymenttrandraftno"].ToString();
            lblPerformanceBonus.Text = sdr["PerformanceBonus"].ToString();
            lblGBV.Text = sdr["gbvamt"].ToString();
            lblPBV.Text = sdr["pbvamt"].ToString();
            lblLevel.Text = sdr["levelperc"].ToString();
            con.Close();

            string qstr1 = "select AppMstTitle,AppmstFname,appmstregno,appmstaddress1,appmstpincode,AppMstMobile,distt,AppMstCity,AppMstState,AppMstPinCode from appmst where appmstregno='" + strsession + "'";
            con.Open();
            com = new SqlCommand(qstr1, con);
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {
                Label21.Text = sdr["AppMstTitle"].ToString() + " " + sdr["appmstfname"].ToString() + " &nbsp" + "(" + "ID No" + sdr["appmstregno"].ToString() + ")" + "<br>" + "Address" + " : " + sdr["appmstaddress1"].ToString() + "<br>" + "District" + " : " + sdr["distt"].ToString() + "<br>" + "City" + " : " + sdr["AppMstCity"].ToString() + "<br>" + "State" + " : " + sdr["AppMstState"].ToString() + "<br>" + "Pin Code" + " : " + sdr["AppMstPinCode"].ToString() + "<br>" + "Mob No" + " : " + sdr["AppMstMobile"].ToString();
                Label10.Text = "Id No : " + sdr["appmstregno"].ToString();
                con.Close();
            } con.Close();
        }
    }
}