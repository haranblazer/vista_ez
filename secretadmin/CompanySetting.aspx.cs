using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Globalization;
using System.Drawing;

public partial class admin_Pamentmst : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
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
            if (!IsPostBack)
            {
                BindSettingDetails();
            }
        }
        catch
        {

        }
       

    }


    public void BindSettingDetails()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("CompSetting", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Master", "SELECT");
            cmd.Parameters.AddWithValue("@caption", txtCaption.Text);
            cmd.Parameters.AddWithValue("@uval", txtUserValue.Text);
            cmd.Parameters.AddWithValue("@isactive", chkIsActive.Checked == true ? "1" : "0");
            cmd.Parameters.AddWithValue("@desc ", txtDescription.Text);
            cmd.Parameters.AddWithValue("@sno", lblsno.Text);
            cmd.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                btnSave.Text = "ADD";
                txtCaption.Text = "";
                txtUserValue.Text = "";
                txtDescription.Text = "";
                chkIsActive.Checked = false;
                txtCaption.Enabled = true;
                lblsno.Text = "0";
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
            }
        }
        catch
        {

        }
    }
 

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("CompSetting", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Master", btnSave.Text);
            cmd.Parameters.AddWithValue("@caption", txtCaption.Text);
            cmd.Parameters.AddWithValue("@uval", txtUserValue.Text);
            cmd.Parameters.AddWithValue("@isactive", chkIsActive.Checked == true ? "1" : "0");
            cmd.Parameters.AddWithValue("@desc ", txtDescription.Text);
            cmd.Parameters.AddWithValue("@sno", lblsno.Text);
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            string flag = cmd.Parameters["@flag"].Value.ToString();
            BindSettingDetails();
            ClientScriptManager csm = Page.ClientScript;
            csm.RegisterStartupScript(this.GetType(), "message", "alert('" + flag + "')", true);
        }
        catch
        {
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        int rowindex = Convert.ToInt32(e.CommandArgument);
        GridViewRow row = GridView1.Rows[rowindex];
        Label lbl = (Label)row.FindControl("lblId");
        if (e.CommandName == "Edit")
        {
            SqlCommand cmd = new SqlCommand("select * from settingmst where sno=@sno", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@sno", lbl.Text);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                txtCaption.Text = dt.Rows[0]["Caption"].ToString();
                txtUserValue.Text = dt.Rows[0]["UserVal"].ToString();
                bool chk = dt.Rows[0]["Isactive"].ToString() == "1" ? true : false;
                chkIsActive.Checked = chk;
                txtDescription.Text = dt.Rows[0]["description"].ToString();
                lblsno.Text = dt.Rows[0]["sno"].ToString();
                btnSave.Text = "Update";
                txtCaption.Enabled = false;
            }
            else
            {
                btnSave.Text = "ADD";
                txtCaption.Enabled = true;
            }
        }
    }



    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindSettingDetails();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }


    protected void btn_BillInvReset_Click(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("update FranchiseMst set InvNo=1", con);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 99999;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            con.Dispose();
             
        }
        catch
        {
        }
        finally
        {
        }
    }
    protected void btn_StockInvReset_Click(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("update FranchiseMst set StockInv=1", con);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 99999;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            con.Dispose();
            
        }
        catch
        {
        }
        finally
        {
        }
    }


}

