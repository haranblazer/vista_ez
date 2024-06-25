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

public partial class admin_ChangeSponsor : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);    
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
    }
    protected void btnActivate_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand("UpdateSponsor", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@regno", regno.Text);
        cmd.Parameters.AddWithValue("@sponsorid", newsponsor.Text);    
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        Ok.Text = "Success Data";
        regno.Text = "";
        newsponsor.Text = "0";
    }
}
