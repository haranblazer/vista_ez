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

public partial class admin_TeamIncome : System.Web.UI.Page
{
    int a = 0;
    SqlConnection con = new SqlConnection(method.str);    
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        checkdata();
    }
    private void checkdata()
    {
        SqlDataAdapter da = new SqlDataAdapter("select * from appmst where TeamIncomeYorN='0'", con);
        DataSet ds = new DataSet();
        da.Fill(ds);
        a = ds.Tables[0].Rows.Count;
        if(a>0)
            a--;
        Label5.Text = a.ToString();
        if (a < 1)
            Button2.Visible = false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        if (a > 0)
        {
            con.Close();
            SqlCommand cmd = new SqlCommand("TeamIncome", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            ok.Text = "Team Income Calculated";
        }
        else
            ok.Text = "No New Member";
        checkdata();
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        int b = 0;
        SqlCommand cmd = new SqlCommand("select * from appmst where AppMstRegNo='" + TextBox1.Text + "'", con);
        con.Open();
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            b = Convert.ToInt32(TextBox2.Text);
            if (b <= 13)
            {
                con.Close();
                cmd = new SqlCommand("update appmst set AppMstRank='" + TextBox2.Text + "' where AppMstRegNo='" + TextBox1.Text + "'", con);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                error.Text = "Update SuccessFully";
            }
            else
                error.Text = "Invalid Rank No.";
        }
        else
            error.Text = "Invalid IdNo.";
        con.Close();
        
    }
}
