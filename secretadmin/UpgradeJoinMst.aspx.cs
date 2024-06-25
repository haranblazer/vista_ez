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
using System.Text.RegularExpressions;
public partial class admin_UpgradeJoinMst : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if (Session["admin"] == null)
        {
            Response.Redirect("adminlog.aspx", false);
        }
        else
        {   //stop code start --

            SqlCommand com = new SqlCommand("CheckStartDate", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            int flag = Convert.ToInt32(com.Parameters["@flag"].Value);
            if (flag == 0)
                Response.Redirect("maintenance.aspx");
            con.Close();
            //stop code ends --

        
        }
        if (!IsPostBack)
        {
            BindJoinFor();
        }
    }
    public void BindJoinFor()
    {
       
        SqlCommand com = new SqlCommand("BindJoinFor", con);
        com.CommandType = CommandType.StoredProcedure;

        try
        {
            DataTable dt = new DataTable();
            con.Open();
            SqlDataReader dr = com.ExecuteReader();
            if (dr.HasRows)
            {
                dt.Load(dr);
                ddlJoinFor.DataSource = dt;
                ddlJoinFor.DataTextField = "ProductName";
                ddlJoinFor.DataValueField = "Srno";
                ddlJoinFor.DataBind();
                con.Close();
                con.Dispose();

            }
            else
            {
                con.Close();
                con.Dispose();

            }

        }
        catch
        {

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       

        if (Regex.Match(txtregno.Text.Trim().ToString(), @"^[a-zA-Z0-9]*$").Success)
        {

            if (txtregno.Text.Trim() == "")
                Label1.Text = "Blank User ID !";
            else if (ddlJoinFor.SelectedIndex < 0)
                Label1.Text = "Select Join For !";
            else
            {
                if (IsExistUser())
                {
                    try
                    {

                        string a;
                        int b;
                        a = txtregno.Text.Trim();
                        b = Convert.ToInt32(ddlJoinFor.SelectedItem.Value);
                        con = new SqlConnection(method.str);
                        SqlCommand com = new SqlCommand("upgradeJoinfor", con);
                        com.CommandType = CommandType.StoredProcedure;
                        com.Parameters.AddWithValue("@RegNo", a);
                        com.Parameters.AddWithValue("@srno", b);
                        com.Parameters.Add("@flag", DbType.Int32);
                        com.Parameters["@flag"].Direction = ParameterDirection.Output;
                        con.Open();
                        com.ExecuteNonQuery();
                        int status = Convert.ToInt32(com.Parameters["@flag"].Value);
                        con.Close();
                        con.Dispose();
                        //int status = 1;
                        if (status == 1)
                            Label1.Text = "JoinFor Updated Successfully !";
                        else if (status == -101)
                            Label1.Text = "The New Join For Must Be Greater Than The Current Join For !";
                        else if (status == -102)
                            Label1.Text = "User ID Does Not Exists !";
                        else if (status == -103)
                            Label1.Text = "Insuficient Balance !";
                        else
                            Label1.Text = "Try Later !";

                    }
                    catch
                    {
                        Label1.Text = "Try Later !";
                    }
                }
                else
                {
                    Label1.Text = "User Id Does Not Exist !";
                }
            }
        }
        else
        {
            Label1.Text = "Invalid UserID";
        }








    }
    private Boolean IsExistUser()
    {
      
        SqlCommand com = new SqlCommand("IsExistUser", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", txtregno.Text.Trim());
        try
        {
            con.Open();
            SqlDataReader dr = com.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            con.Close();
            con.Dispose();
            if (dt.Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        catch (Exception ex)
        {
            return false;
        }
    }
}
