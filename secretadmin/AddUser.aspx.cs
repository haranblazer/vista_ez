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
public partial class admin_AddUser : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str;
        str = Session["admin"].ToString();
        if (str == "")
            Response.Redirect("adminLog.aspx");
        Label1.Text = "";
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Label1.Text = "";
        string qstr = "select UserName,password from Controlmst where UserName='"+TextBox1.Text+"' ";
        com = new SqlCommand(qstr, con);
        con.Open();
        sdr = com.ExecuteReader();
        if (sdr.HasRows)
        {
            Label1.Text = "Username already exist";
        }
        else
        {
            con.Close();
            go1();
        }
   }
    public void go1() {
        try
        {
            string qstr1 = "insert into controlmst (username,password)values('" + TextBox1.Text  + "','" + TextBox2.Text + "')";
            com = new SqlCommand(qstr1, con);
            con.Open();
            com.ExecuteNonQuery();
        }
        catch (Exception ex)
        {

            Label1.Text = "value Not Inserted!";

        }
        finally { con.Close(); Label1.Text = "uccessfully!"; }
    
    
    }
}
