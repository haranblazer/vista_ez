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
public partial class admin_InsertPoolId : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        Label3.Visible = false;
    }
    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        SqlCommand com = new SqlCommand("C_InsertPoolFid1", con);
        com.CommandType = CommandType.StoredProcedure;
        con.Open();
        com.Parameters.AddWithValue("@Userid", TextBox2.Text);
        com.ExecuteNonQuery();
        con.Close();
        Label3.Visible = true;
        Label3.Text = "data Added Successfully";
    }
}
