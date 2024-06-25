using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class secretadmin_RunTour : System.Web.UI.Page
{


    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        
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

        if (!IsPostBack)
        {
            voidshow();
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlCommand com = new SqlCommand("Runtour", con);
        com.CommandTimeout = 999999999;
        com.CommandType = CommandType.StoredProcedure;
        con.Open();
        com.ExecuteNonQuery();
        con.Close();
        utility.MessageBox(this,"Thanks For Tour Submittion");
    }


    public void voidshow()
    {
            SqlDataAdapter sda = new SqlDataAdapter("lasttour", con);
            sda.SelectCommand.CommandType = CommandType.StoredProcedure;           
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lbldtour.Text = dt.Rows[0][0].ToString();
                lblitour.Text = dt.Rows[0][1].ToString();
            }
    }
}