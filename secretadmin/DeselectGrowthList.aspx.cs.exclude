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
public partial class admin_DeselectGrowthList : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if (!Page.IsPostBack)
            Label1.Visible = false;
    }
    protected void Button2_Click1(object sender, EventArgs e)
    {
        try
        {
            SqlCommand com = new SqlCommand("G_DeselectGrowthId", con);
            com.Parameters.AddWithValue("@Id", TextBox2.Text);
            com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            com.CommandType = CommandType.StoredProcedure;
            con.Open();
            com.ExecuteNonQuery();
            int flag = int.Parse(com.Parameters["@flag"].Value.ToString());
            Label1.Visible = true;
            if (flag == 1)
                Label1.Text = "UserId not Present in Growth List ";
            else if (flag == 2)
                Label1.Text = "UserId cannot be deleted";
            else if (flag == 3)
                Label1.Text = "UserId " + TextBox2.Text + " deselected from Growth List ";
        }
        catch 
        {
            Label1.Text = "Transaction Failed";
        }

    }
}
