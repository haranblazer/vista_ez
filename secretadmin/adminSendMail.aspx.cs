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
public partial class admin_adminSendMail : System.Web.UI.Page
{
    string str, str1;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e)
    {
        str1 = Convert.ToString(Request.QueryString["n"]);
        str = Convert.ToString(Session["username"]);

        if (!IsPostBack)
        {

            if (str == "")
            {

                Response.Redirect("AdminLog.aspx");

            }
            else if (str1 != null)
            {
                Button1.Text = "Reply";
                string qstr1 = "select * from MailMst where Name='" + str1 + "'";
                com = new SqlCommand(qstr1, con);
                con.Open();
                sdr = com.ExecuteReader();
                if (sdr.Read())
                {

                    TextBox1.Text = sdr[1].ToString();
                    TextBox2.Text = sdr[2].ToString();
                    TextBox3.Text = sdr[3].ToString();

                    TextBox4.Text = sdr[0].ToString();
                    con.Close();



                }
                else { Button1.Text = "Send"; }
            }



        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        string qstr = "insert into AdminMailMst (UserId,Name,Subject,Message) Values('" + TextBox4.Text + "','" + TextBox1.Text + "','" + TextBox2.Text + "','" + TextBox3.Text + "')";
        com = new SqlCommand(qstr, con);
        con.Open();
        int i = com.ExecuteNonQuery();
        if (i >0)
        {
            Label1.Text = "Message Successed!"; 

        }
        else { Label1.Text = "Message Failed!"; }
    }
}
