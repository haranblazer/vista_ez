using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class member_ChangePassword : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com = new SqlCommand();
    SqlDataReader sdr;
    string str;
    utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        str = Convert.ToString(Session["MemberId"]);

    }

    private void checkpwd()
    {
        //lblerror.Visible = true;
        string id = Convert.ToString(txtOldPwd.Text);

        com = new SqlCommand("checkpwd", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@username", str);
        com.Parameters.AddWithValue("@password", obj.base64Encode(id));
        con.Open();
        sdr = com.ExecuteReader();
        if (sdr.HasRows)
        {
            con.Close();


            if (txtNewPwd.Text == txtConfirmPwd.Text)
            {
                updatepwd();
            }
            else
            {
                utility.MessageBox(this, "New password doesn't match with confirm password.");
                return;
            }

        }
        else
        {
            utility.MessageBox(this, "Please Enter Correct Current Password.");
            txtOldPwd.Text = "";
            txtNewPwd.Text = "";
            txtConfirmPwd.Text = "";
            return;
            //lblerror.Text = "Please Enter Correct old Password...";

        }
        con.Close();

    }
    private void updatepwd()
    {

        //lblerror.Visible = true;
        str = Convert.ToString(Session["MemberId"]);
        string confirmpassword = Convert.ToString(txtConfirmPwd.Text);

        com = new SqlCommand("updatepwd", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", str);
        com.Parameters.AddWithValue("@pwd", obj.base64Encode(txtConfirmPwd.Text));
        con.Open();
        com.ExecuteNonQuery();
        utility.MessageBox(this, "Password Changed SuccessFully.");
        txtOldPwd.Text = "";
        txtNewPwd.Text = "";
        txtConfirmPwd.Text = "";
        con.Close();
        return;
        //lblerror.Text = ("Password Changed SuccessFully...");


    }

    protected void ImageButton1_Click(object sender, EventArgs e)
    {
        if (Regex.Match(str, @"^[a-zA-Z0-9]*$").Success)
        {
            checkpwd();
        }

        else
        {
            utility.MessageBox(this, "INVALID ID !!!");
            return;
            //lblerror.Text = "INVALID ID";
        }



    }
}