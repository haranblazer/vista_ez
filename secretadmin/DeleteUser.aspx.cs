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
public partial class admin_DeleteUser : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Label1.Visible = false;
        }
    }
    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {
        Label1.Visible = false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            int f = 0;
            SqlCommand com = new SqlCommand("DeleteId1", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@id", TextBox1.Text);
            com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            f = int.Parse(com.Parameters["@flag"].Value.ToString());
            Label1.Visible = true;
            if (f == 3)
                Label1.Text = "Id Cannot be Deleted";
            else if (f == 2)
                Label1.Text = "Id Doesnot exist";
            else if (f == 1)
                Label1.Text = "Id  Deleted";
        }
        catch (Exception x)
        {
            Label1.Visible=true;
            Label1.Text = "Wrong Entry";
        }
               
    }
   
}
