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

public partial class admin_CalculateGrowthIncome : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if (!Page.IsPostBack)
        {
            Label1.Visible = false;
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {

            SqlCommand com = new SqlCommand("G_CalculateGrowthIncome", con);
            com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            com.Parameters.AddWithValue("@ClosingNo", SqlDbType.Int).Direction = ParameterDirection.Output;
            com.CommandType = CommandType.StoredProcedure;
            con.Open();
            com.ExecuteNonQuery();
            int flag = int.Parse(com.Parameters["@flag"].Value.ToString());
            int ClosingNo = int.Parse(com.Parameters["@ClosingNo"].Value.ToString());
            con.Close();
            Label1.Visible = true;
            if (flag == 1)
                Label1.Text = "No New  User Present";
            else
            {
                //updateGrowthPayment();
                Label1.Text = "Closing " + ClosingNo + " Complete";
            }

        }
        catch (Exception ex)
        {
            Label1.Text = "Transaction Failed";
        }


    }
    public void updateGrowthPayment()
    {
        try
        {
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter("select userid,sum(Income) from StoreGrowth group by userId ",con);
            da.Fill(ds);
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                SqlCommand com = new SqlCommand("G_updateGrowthIncome", con);
                com.Parameters.AddWithValue("@id", ds.Tables[0].Rows[i][0]);
                com.Parameters.AddWithValue("@Income", ds.Tables[0].Rows[i][1]);
                com.CommandType = CommandType.StoredProcedure;
                con.Open();
                com.ExecuteNonQuery();
                con.Close();
            }


        }
        catch { }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            con.Close();
            Label1.Visible = true;
            SqlCommand com = new SqlCommand("SponserGrowthPayment", con);
            com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            com.CommandType = CommandType.StoredProcedure;
            con.Open();
            com.ExecuteNonQuery();
            int flag = Convert.ToInt32((com.Parameters["@flag"].Value));
            updateGrowthPayment();
            con.Close();
            Label1.Visible = true;
            if (flag == 50)
            {
                Label1.Text = "No New  User Present";
            }
            else
            {
                Label1.Text = "Closing " + flag + " Complete";
            }
        }
        catch(Exception ex)
        {
            Label1.Text = "Transaction Failed";
        }

    }
}
