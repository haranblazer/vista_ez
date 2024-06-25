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
using System.IO;
using System.Net;
public partial class admin_selectproduct : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    WebClient client = new WebClient();
    public string mobile;
    string sender_id = "Soga";
    string Profile_id = "20011022";
    string Password = "qde1o3";
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        // this.Button1.Attributes.Add("onclick", "confirmation()");
        this.Button1.Attributes.Add("onClick","conf()");
       
        if (!IsPostBack)
        {
            Button2.Visible = false;
            string str = Convert.ToString(Request.QueryString["n"]);
            TextBox3.Text = str;
            TextBox2.Text = Convert.ToString(Request.QueryString["n1"]);
           
            string  jf = Convert.ToString(Request.QueryString["n2"]);
            
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       
        com = new SqlCommand("upgradeuser", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@downid", TextBox3.Text);
        con.Open();
        int i = com.ExecuteNonQuery();
        con.Close();
        if (i > 0)
        {
            Button1.Visible = false;
            Button2.Visible = true;
            Label2.Text = "Updated Sucessfully !";
            //try
            //{
            //        sendsms();
            //}
            //catch { }
        }
        else
        {
            Label2.Text = " Updation Failed !";
        }
       
    }
    //public void sendsms()
    //{
    //    string userpwd, userid, mobileno, fname, lname, completeName, title,login;
    //    SqlDataReader dr;
    //    com = new SqlCommand("select appmstmobile ,AppmstPassword ,AppMstFName,AppMstLname,AppMstTitle,AppMstLogin from appmst where appmstregno='" + TextBox3.Text + "'", con);
    //    con.Open();
    //    dr = com.ExecuteReader();
    //    dr.Read();
    //    userpwd = dr["AppMstPassword"].ToString();
    //    userid = TextBox3.Text;
    //    login = dr["appmstlogin"].ToString();
    //    mobileno =dr["appmstmobile"].ToString();
    //    fname = dr["AppMstFName"].ToString();
    //    lname = dr["AppMstLname"].ToString(); 
    //    completeName = fname + " " + lname;
    //    title = dr["AppMstTitle"].ToString();
    //    string msgtxt = "Dear " + title + completeName + " Thanks For Joining " + sender_id + "Your Registration Number Is " + userid +" And LogInID Is "+login +" And Your Password is " + userpwd + " Grow With Us..";
    //    //string baseurl = " http://sms.ayuveinfocom.com/sendurl.asp?user=20000520&pwd=123456&senderid=Ayuve&mobileno='" + mobileno + "'&msgtext=" + msgtxt + " ";
    //    string baseurl = " http://sms.ayuveinfocom.com/sendurl.asp?user=" + Profile_id + "&pwd=" + Password + "&senderid=" + sender_id + "&mobileno='" + mobileno + "'&msgtext=" + msgtxt + " ";

    //    Stream data = client.OpenRead(baseurl);
    //    StreamReader reader = new StreamReader(data);
    //    string s = reader.ReadToEnd();
    //    data.Close();
    //    reader.Close();
    //    con.Close();
    //}
    
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("Listunpaid.aspx");
    }

   
}