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
public partial class admin_DeleteAdmin : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        //else if (Convert.ToString(Session["admintype"]) == "a")
        //{
        //    utility.CheckAdminLogin();
        //}
        else
        {
            Response.Redirect("adminLog.aspx");
        }       
       
        if (Page.IsPostBack == false)
        {
            getLogInId();
        }
       
    }
    public void getLogInId()
    {
        ddlLogInId.Items.Clear();
        ddlLogInId.Items.Add("Select");
        SqlDataAdapter adp = new SqlDataAdapter("select username from controlmst where admintype='a'", con);
        con.Open();

        DataTable dt = new DataTable();
        adp.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string str = dt.Rows[i]["username"].ToString();
                ddlLogInId.Items.Add(str);
            }
        }
        con.Close();
    }
    private void FetchAdminDeatils()
    {

        cmd = new SqlCommand("select username,password,name from controlmst  where username=@login", con);
        cmd.Parameters.AddWithValue("@login", ddlLogInId.SelectedItem.Text.Trim());
        con.Open();
        sdr = cmd.ExecuteReader();
        if (sdr.Read())
        {
            txtLogInId.Text = sdr["username"].ToString().Trim();
            txtPassword.Text = sdr["password"].ToString().Trim();            
            txtName.Text = sdr["name"].ToString().Trim();
        }
        con.Close();
    }
    protected void ddlLogInId_SelectedIndexChanged(object sender, EventArgs e)
    {
        FetchAdminDeatils();

    }

    private void deleteadmin()
    {  
        cmd = new SqlCommand("deleteadmin", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@uid", ddlLogInId.SelectedItem.Text);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();      
        txtName.Text = txtLogInId.Text = txtPassword.Text = string.Empty;        
        getLogInId();
        utility.MessageBox(this,"Admin deleted successfully!");
    }
    
    protected void Button1_Click(object sender, EventArgs e)
    {
        deleteadmin();
    }
}
