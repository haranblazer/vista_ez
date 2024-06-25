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
public partial class admin_controlpanel : System.Web.UI.Page
{
    string uname;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    int c, c1, c2, c3, c4, c5, c6, c7, c8, c16;
    protected void Page_Load(object sender, EventArgs e)
    {


        uname = Convert.ToString(Request.QueryString["n"]);
if(!IsPostBack){
        if (uname == null)
        {

            Response.Redirect("adminLog.aspx");
        }
        else
        {
            string qstr = "select * from ControlMst where UserName='" + uname + "'";
            com = new SqlCommand(qstr, con);
            con.Open();
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {

                if (sdr[2].ToString() == "1")
                {

                    CheckBox1.Checked = true;
                }

                if (sdr[3].ToString() == "1")
                {

                    CheckBox2.Checked = true;
                } if (sdr[4].ToString() == "1")
                {

                    CheckBox3.Checked = true;
                } if (sdr[5].ToString() == "1")
                {

                    CheckBox4.Checked = true;
                } if (sdr[6].ToString() == "1")
                {

                    CheckBox5.Checked = true;
                } if (sdr[7].ToString() == "1")
                {

                    CheckBox6.Checked = true;
                } if (sdr[8].ToString() == "1")
                {

                    CheckBox7.Checked = true;
                } if (sdr[9].ToString() == "1")
                {

                    CheckBox16.Checked = true;
                }
            } con.Close();
        }
    }
}
        
        

    protected void Button1_Click(object sender, EventArgs e)
    {


        if (CheckBox1.Checked)
        {

            c1 = 1;
        }
        else { c1 = 0; }

        if (CheckBox2.Checked)
        {

            c2 = 1;
        }
        else { c2 = 0; }
        if (CheckBox3.Checked)
        {

            c3 = 1;
        }
        else { c3 = 0; } 
        if (CheckBox4.Checked)
        {

            c4 = 1;
        }
        else { c4 = 0; }
        if (CheckBox5.Checked)
        {

            c5 = 1;
        }
        else { c5 = 0; } 
        if (CheckBox6.Checked)
        {

            c6 = 1;
        }
        else { c6 = 0; }
        if (CheckBox7.Checked)
        {

            c7 = 1;
        }
        else { c7 = 0; }
        if (CheckBox16.Checked)
        {

            c16 = 1;
        }
        else { c16 = 0; }



        string qstr = "update controlmst set pingeneration='"+c1+"',changeprofile='"+c2+"',payout='"+c3+"',Awards='"+c4+"',reports='"+c5+"',changepassword='"+c6+"',activate='"+c7+"',news='"+c16+"'where username='"+uname+"'";

        com = new SqlCommand(qstr,con);
        con.Open();
    int i=(int) com.ExecuteNonQuery();
        if(i==0){
            Label1.Text = "Not Updated, Try Again!";
        con.Close();
    }else{
        
        Label1.Text="Update Your Profile !";
            con.Close();
        
        }
}
}