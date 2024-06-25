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
public partial class admin_ShowInvoice : System.Web.UI.Page
{
    string str5;
    string idno;
    int i = 1;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        str5 = Request.QueryString["id"];
        
        string idno;
        int dd, mm, yy;
        DateTime s;
      

        go1();

    }
    public void go1()
    {
        string qstr = "select * from sharemst where appmstid=(select appmstid from appmst where appmstregno='" + str5 + "')";
        com = new SqlCommand(qstr, con);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);


        if (t.Rows.Count > 0)
        {
            dgr.DataSource = t;
            dgr.DataBind();
        }
        else
        {

            dgr.Visible = false;
        }
        con.Close();





    }
}
