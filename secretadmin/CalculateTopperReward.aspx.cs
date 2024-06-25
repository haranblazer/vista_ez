using System;
using System.Data;
using System.Data.SqlClient; 
public partial class secretadmin_CalculateTopperReward : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
            {
                utility.CheckSuperAdminLogin();
            }
            else if (Convert.ToString(Session["admintype"]) == "a")
            {
                utility.CheckAdminLogin();
            }
            else
            {
                Response.Redirect("adminLog.aspx");
            }
             
        }
        catch
        {

        }
    } 
    protected void btn_cal_title_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("Calc_TopperReward", con);
            com.CommandType = CommandType.StoredProcedure;
            con.Open();
            com.CommandTimeout = 1900;
            com.ExecuteNonQuery();
            con.Close();
            utility.MessageBox(this, "Topper Reward Updated Successfully.");
        }
        catch { }
    }
}