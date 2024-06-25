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

    protected void Page_Load(object sender, EventArgs e)
    {
        utility obj = new utility();
       if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        str2 = obj.base64Decode(Request.QueryString["id"].ToString());
        
        companyname();
        databind();


      
    }


    private void databind()
    {
        SqlCommand cmd = new SqlCommand("select (select isnull(productname,'0') from productmst where srno=appmst.ProductId) as productname,(select isnull(amount,0) from productmst where srno=appmst.ProductId) as productamount,isnull(Jamount,0) as Jamount,appmsttitle,appmstfname,AppMstAddress1,AppMstState,AppMstPinCode,AppMstPrimaryPhone,AppMstCity,AppMstPassword,distt,panno,email,sponsorid,appmstregno,CONVERT(VARCHAR(10), userdob, 103) as userdob ,CONVERT(VARCHAR(10), appmstdoj, 103) as appmstdoj  from appmst where AppMstRegNo=@regno", con);
        cmd.Parameters.AddWithValue("@regno", str2);
        SqlDataReader dr;
        con.Open();
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            lblfname.Text = lblClientName.Text = Convert.ToString(dr["appmsttitle"]) + " " + Convert.ToString(dr["appmstfname"]);
            lblAdress.Text = Convert.ToString(dr["AppMstAddress1"]);
            lblCity.Text = Convert.ToString(dr["AppMstCity"]);
            lblState.Text = Convert.ToString(dr["AppMstState"]);
            lblpincode.Text = Convert.ToString(dr["AppMstPinCode"]);
            lblDOJ.Text = Convert.ToString(dr["appmstdoj"]);
            lblPwd.Text = Convert.ToString(dr["AppMstPassword"]);
            lblUniqueID.Text = lblID.Text = lblID1.Text = str2 ;
            lblPackgName.Text = Convert.ToString(dr["productname"]);
            lblAmount.Text = Convert.ToString(dr["productamount"]);
        }
        con.Close();
    }
    private void companyname()
    {


        SqlCommand cmd = new SqlCommand("companydetails", con);
        cmd.CommandType = CommandType.StoredProcedure;
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lblCName3.Text = lblCompanyName1.Text = lblCompanyName2.Text = lblCompanyName3.Text = lblCompanyName4.Text = Convert.ToString(dr["companyname"]);
            lblCompnyHead.Text = Convert.ToString(dr["CompanyHead"]);
            imgLogo.ImageUrl = "~/images/" + Convert.ToString(dr["logoURL"]);
        }
        con.Close();
    }


}
