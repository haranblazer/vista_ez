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
public partial class admin_adchangeprofile : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {

            }
        }
        catch
        {

        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            if (Regex.IsMatch(txtRegNo.Text.Trim(), @"^[A-Za-z0-9]*$"))
            {
                com = new SqlCommand("select * from AppMst where AppMstregno=@RegNo", con);
                com.Parameters.AddWithValue("@RegNo", txtRegNo.Text.Trim());
                con.Open();
                sdr = com.ExecuteReader();
                if (sdr.Read())
                {
                    Response.Redirect("Edit_Profile.aspx?n=" + txtRegNo.Text);
                    con.Close();
                }
                else
                {
                    con.Close();
                    utility.MessageBox(this, "Wrong user id!");
                }
            }
            else
            {
                utility.MessageBox(this, "User Id Contains AlphaNumeric Value Without Space!");
                txtRegNo.Focus();
                return;
            }

        }
        catch
        {

        }
    }
}