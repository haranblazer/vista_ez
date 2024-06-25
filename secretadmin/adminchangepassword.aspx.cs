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
public partial class admin_adminchangepassword : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com = new SqlCommand();
    SqlDataReader sdr;
    utility obj = new utility();  
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


    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        changePwd();
    }
    private void changePwd()
    {
        try
        {

            if (Regex.Match(txtOldPwd.Text.Trim() + txtConfirmPwd.Text.Trim() + txtNewPwd.Text.Trim(), @"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&amp;])[A-Za-z\d$@$!%*#?&amp;]{8,}$").Success)
            {
                string confirmPassword = Convert.ToString(txtConfirmPwd.Text);
                com = new SqlCommand("updateAdminPassword", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@UName", Convert.ToString(Session["admin"]));
                com.Parameters.AddWithValue("@pwd", obj.base64Encode(confirmPassword));
                com.Parameters.AddWithValue("@oldPwd", obj.base64Encode(txtOldPwd.Text.Trim().ToString()));
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
                    utility.MessageBox(this, "Please enter valid current password.");
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
