using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class admin_WelcomeLetter : System.Web.UI.Page
{
    string str2;
    SqlConnection con = new SqlConnection(method.str);
    public string coAdd, coEmail,coWeb,coHeadName,coHeadDesignation;
    utility objUtil = new utility();
    SqlDataReader dr;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.Checklogin();
        coAdd = objUtil.getvalue()[7].ToString();
        coEmail = objUtil.getvalue()[5].ToString();
        coWeb = objUtil.getvalue()[6].ToString();
        coHeadName = objUtil.getvalue()[11].ToString();
        coHeadDesignation = objUtil.getvalue()[10].ToString();
        //companyname();
        con.Open();
        SqlCommand cmd = new SqlCommand("wletter", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@regno", Convert.ToString(Session["userId"]));
        dr = cmd.ExecuteReader();
        if(dr.Read())
        {
            lbluserid.Text = Convert.ToString(dr["appmstregno"]);
            lblname2.Text = Convert.ToString(dr["appmstfname"]);
            //lblmobileno.Text = Convert.ToString(dr["appmstmobile"]);
            lblemailid.Text = Convert.ToString(dr["email"]);
            lbldoj.Text = Convert.ToString(dr["doe"]);
            //lblcemailid.Text = lblcemailid2.Text = Convert.ToString(dr["reply"]);
            //lblcompanyaddress.Text = Convert.ToString(dr["caddress"]);
            //lblcname.Text = Convert.ToString(dr["cname"]);
            //lblfname.Text = lblClientName.Text = Convert.ToString(dr["appmsttitle"]) + " " + Convert.ToString(dr["appmstfname"]);
            lblAdress.Text = Convert.ToString(dr["AppmstAdd"]);
            //lblCity.Text = Convert.ToString(dr["AppMstCity"]);
            //lblState.Text = Convert.ToString(dr["AppMstState"]);
            //lblpincode.Text = Convert.ToString(dr["AppMstPinCode"]);
            //lblDOJ.Text = Convert.ToString(dr["appmstdoj"]);
            //lblPwd.Text = Convert.ToString(dr["AppMstPassword"]);
            //lblUniqueID.Text = lblID.Text = lblID1.Text = Convert.ToString(Session["userId"]);

            //lblPackgName.Text = Convert.ToString(dr["productname"]);
            //lblAmount.Text = Convert.ToString(dr["productamount"]);

        }

        con.Close();
    }
    //private void companyname()
    //{


    //    SqlCommand cmd = new SqlCommand("companydetails", con);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    con.Open();
    //    SqlDataReader dr = cmd.ExecuteReader();
    //    if (dr.Read())
    //    {
    //        lblCName3.Text = lblCompanyName1.Text = lblCompanyName2.Text = lblCompanyName3.Text = lblCompanyName4.Text = Convert.ToString(dr["companyname"]);
    //        lblCompnyHead.Text = Convert.ToString(dr["CompanyHead"]);
    //        imgLogo.ImageUrl = "~/images/" + Convert.ToString(dr["logoURL"]);
    //    }
    //    con.Close();
    //}


}
