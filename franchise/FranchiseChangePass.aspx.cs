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

public partial class franchise_FranchiseChangePass : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com = new SqlCommand();
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Logout.aspx");
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        changePwd();
    }
    private void changePwd()
    {
        try
        {

            if (Regex.Match(txtOldPwd.Text.Trim() + txtConfirmPwd.Text.Trim() + txtNewPwd.Text.Trim(), @"^[a-zA-Z0-9]*$").Success)
            {


                string confirmPassword = Convert.ToString(txtConfirmPwd.Text.Trim());
                com = new SqlCommand("updateFPassword", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@FId", Session["franchiseid"].ToString());
                com.Parameters.AddWithValue("@pwd", confirmPassword);
                com.Parameters.AddWithValue("@oldPwd", txtOldPwd.Text.Trim().ToString());
                com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                if (Convert.ToInt32(com.Parameters["@flag"].Value) == 1)
                {
                    utility.MessageBox(this, "Password changed successFully...");
                    txtOldPwd.Text = txtNewPwd.Text = txtConfirmPwd.Text = string.Empty;
                }
                else if (Convert.ToInt32(com.Parameters["@flag"].Value) == 11)
                {
                    utility.MessageBox(this, "Please enter correct old password ...");
                }
                else
                {
                }


                con.Close();
            }
        }
        catch
        {
        }
    }
}