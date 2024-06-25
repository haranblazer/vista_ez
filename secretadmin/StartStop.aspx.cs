using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Drawing;
using System.Data;

public partial class admin_StartStop : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataReader dr;
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
                check();
            }
        }
        catch
        {

        }
        
    }


    public void check()
    {
        cmd = new SqlCommand("pageprocess", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@action", "1");
        con.Open();
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (dr["signup"].ToString() == "ON")
            {

                btnSignupOn.BackColor = Color.Green;

                btnSignupOn.Text = "ON";

            }


            if (dr["logins"].ToString() == "ON")
            {
                btnLoginOn.BackColor = Color.Green;
                btnLoginOn.Text = "ON";
            }

            if (dr["billing"].ToString() == "ON")
            {
                btnBillingOn.BackColor = Color.Green;

                btnBillingOn.Text = "ON";
            }


            if (dr["signup"].ToString() == "OFF")
            {

                btnSignupOn.BackColor = Color.Red;
                btnSignupOn.Text = "OFF";
            }


            if (dr["logins"].ToString() == "OFF")
            {
                btnLoginOn.BackColor = Color.Red;
                btnLoginOn.Text = "OFF";
            }

            if (dr["billing"].ToString() == "OFF")
            {
                btnBillingOn.BackColor = Color.Red;
                btnBillingOn.Text = "OFF";
            }

        }


        dr.Close();

        con.Close();

    }
    protected void btnSignupOn_Click(object sender, EventArgs e)
    {
        cmd = new SqlCommand("pageprocess", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@action", "2");
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        check();

       
    }
    protected void btnLoginOn_Click(object sender, EventArgs e)
    {
        cmd = new SqlCommand("pageprocess", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@action", "3");
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        check();
    }
    protected void btnBillingOn_Click(object sender, EventArgs e)
    {
        cmd = new SqlCommand("pageprocess", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@action", "4");
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        check();
    }
}