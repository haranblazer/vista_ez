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
public partial class admin_shareamount : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    DataTable t = new DataTable();
    string strmin;
    string strmax;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        string min = Convert.ToString(Session["mindate"]);
        string max = Convert.ToString(Session["maxdate"]);
        string uid = Convert.ToString(Request.QueryString["n"]);

        string qstr = "select userid,causeid,amount,effectdate=convert(char(10),effectdate,103) from causeid where paymentcause='s' and CAST(FLOOR(CAST(effectdate as float)) as datetime) between '" + min + "' and '" + max + "' and userid=(select appmstid from appmst where appmstregno='" + uid + "')";
        com = new SqlCommand(qstr, con);
        con.Open();
        sdr = com.ExecuteReader();
        if (sdr.HasRows)
        {

            GridView1.DataSource = sdr;
            GridView1.DataBind();
            con.Close();

        }
        else
        {
            con.Close();
            Label1.Text = "No Data Found!";

        }


    }
}