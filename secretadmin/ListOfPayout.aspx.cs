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

public partial class admin_ListOfPayout2 : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        go();
    }
    private void go()
    {
        SqlCommand com = new SqlCommand("select a.Appmstid as RegNo,b.Appmstfname as FirstName,a.jumboclub1amt,a.jumboclub2amt ,a.TotalEarning,a.DispachedAmt from paymenttrandraft a,appmst b where a.payoutno='" + txtpayoutno.Text + "' and a.appmstid=b.appmstregno", con);
        SqlDataReader dr;
        con.Open();
        dr = com.ExecuteReader();
        if (dr.Read())
        {
            GridView1.DataSource = dr;
            GridView1.DataBind();
        }
        else
        {
  Label1.Text = "Record Not Found !";
        }
        con.Close();
    }
   
}
