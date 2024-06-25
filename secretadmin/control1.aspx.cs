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
public partial class admin_control1 : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e)
    { 
        
        string str=Convert.ToString(Session["username"]);
        if(str==""){
            Response.Redirect("adminlog.aspx");
        }


       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string qstr = "select * from Controlmst";
        com = new SqlCommand(qstr, con);
        con.Open();
        sdr = com.ExecuteReader();
        GridView1.DataSource = sdr;
        GridView1.DataBind();
        con.Close();
    }
}
