using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_PowerLegs : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
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
                Session["CheckRefresh"] = System.DateTime.Now.ToString();
            }
        
        }
        catch
        {

        }

       
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(txtUserId.Text.Trim()))
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();
                com = new SqlCommand("powerleg", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@Regno", txtUserId.Text.Trim());
                com.Parameters.AddWithValue("@LeftRight", rdobtnLeftTight.SelectedValue);
                com.Parameters.AddWithValue("@Point", txtPoint.Text.Trim());
                com.Parameters.AddWithValue("@RewardP", 0);
                com.Parameters.AddWithValue("@TourP", 0); 
                com.Parameters.AddWithValue("@flag", SqlDbType.VarChar).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                if (com.Parameters["@flag"].Value.ToString() == "1")
                {
                    utility.MessageBox(this, "Point Updated Successful.");
                }
            }
            else
            {
                utility.MessageBox(this, "Don't Refresh Page and Press Back Button.");
                return;
            }
        }
        else
        {
            utility.MessageBox(this, "Please enter user id.");
            return;
        }
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
}