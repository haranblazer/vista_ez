using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class admin_CreateAdmin : System.Web.UI.Page
{
    DataTable dt = null;
    SqlDataReader sdr;
    SqlDataAdapter da = null;
    SqlConnection con = null;
    SqlCommand cmd = null;
    utility obj = new utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
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


            BindRole();
            BindState();
            BindRegion();

            ddl_Region.Items.Insert(0, new ListItem("Select Region", "0"));
            ddl_RegionState.Items.Insert(0, new ListItem("Select State", "0"));
        }
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {


        if (txtLogInId.Text.Trim() == "")
        {
            utility.MessageBox(this, "Please Enter userid");
            return;
        }

        if (txtPassword.Text.Trim() == "")
        {
            utility.MessageBox(this, "Please Enter Password");
            return;
        }

        if (txtName.Text.Trim() == "")
        {
            utility.MessageBox(this, "Please Enter SubAdmin Name");
            return;
        }

        if (txtmobile.Text.Trim() == "")
        {
            utility.MessageBox(this, "Please Enter Mobile No");
            return;
        }

        if (DdlState.SelectedValue.ToString() == "0")
        {
            utility.MessageBox(this, "Please Select State");
            return;
        }
        if (obj.hasSpecialChar(txtName.Text.ToString()) == false)
        {
            utility.MessageBox(this, "Please Enter Character in SubaAdmin");
            return;
        }

        if (obj.hasSpecialChar(txtLogInId.Text.ToString()) == false)
        {
            utility.MessageBox(this, "Please Enter alphanumeric key in  userid");
            return;
        }

        if (obj.hasSpecialChar(txtmobile.Text.ToString()) == false)
        {
            utility.MessageBox(this, "Please Enter integer key in  Mobile No");
            return;
        }

        createadmin();
    }


    private void createadmin()
    {
        try
        {
            if (Validation.IsValidPassword(txtPassword.Text.Trim()) == false)
            {
                utility.MessageBox(this, "Password contains [A-Za-z0-9!@#$%^&*()] value.!");
                return;
            }
            utility objUt = new utility();
            string loginId = txtLogInId.Text.Trim(),
                name = txtName.Text.Trim(),
                mobile = txtmobile.Text.Trim(),
                UserRole = ddl_UserRole.SelectedValue,
                Region = ddl_Region.SelectedValue,
                RegionState = ddl_RegionState.SelectedItem.Text;

            if (UserRole == "5")
            {
                if (Region == "0")
                {
                    utility.MessageBox(this, "Please Select Region.!");
                    return;
                }
            }
            if (UserRole == "6")
            {
                if (ddl_RegionState.SelectedValue == "0")
                {
                    utility.MessageBox(this, "Please Select Region State.!");
                    return;
                }
            }
            else { RegionState = ""; }
                


            con = new SqlConnection(method.str);
            cmd = new SqlCommand("addsubadmin", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@loginId", loginId);
            cmd.Parameters.AddWithValue("@pwd", objUt.base64Encode(txtPassword.Text.Trim()));
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@mobile", mobile);
            cmd.Parameters.AddWithValue("@state", DdlState.SelectedItem.Text.Trim());
            cmd.Parameters.AddWithValue("@RoleId", UserRole);
            cmd.Parameters.AddWithValue("@RegionId", Region);
            cmd.Parameters.AddWithValue("@RegionState", RegionState); 
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            string msg = cmd.Parameters["@flag"].Value.ToString();
            if (msg == "1")
            {
                utility.MessageBox(this, "Subadmin created successfully");


                string Text_Msg = "";
                if (name.Length > 20)
                    name = name.Substring(0, 20).ToString();

                Text_Msg = "Dear " + name + " Sign Up Successful ID No: " + loginId + " Password: " + txtPassword.Text.Trim();
                objUt.sendSMSByBilling(mobile, Text_Msg, "SIGNUP");


                var Msg = "Dear {{" + name + "}} you have signed up successfully and your ID No. is {{" + loginId + "}} and Mobile is {{" + mobile + "}}. From www.toptimenet.com. *Jai Toptime*";
                WhatsApp.Send_WhatsApp_MSG(mobile, Msg);


                txtLogInId.Text = txtPassword.Text = txtName.Text = txtmobile.Text = string.Empty;
                DdlState.SelectedValue = "0";
            }
            else
            {
                utility.MessageBox(this, msg);
            }

            con.Close();

        }
        catch (Exception ex)
        {
            con.Close();
            utility.MessageBox(this, ex.StackTrace);
        }
    }
    public void BindRole()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select UserVal, Item_Desc from item_collection where ItemId=6");

        if (dt.Rows.Count > 0)
        {
            ddl_UserRole.Items.Clear();
            ddl_UserRole.DataSource = dt;
            ddl_UserRole.DataTextField = "Item_Desc";
            ddl_UserRole.DataValueField = "UserVal";
            ddl_UserRole.DataBind();
            ddl_UserRole.Items.Insert(0, new ListItem("Select Role", "0"));
        }
    }

    public void BindRegion()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select RID, Region from RegionMst where Isactive=1");
        if (dt.Rows.Count > 0)
        {
            ddl_Region.Items.Clear();
            ddl_Region.DataSource = dt;
            ddl_Region.DataTextField = "Region";
            ddl_Region.DataValueField = "RID";
            ddl_Region.DataBind();
            ddl_Region.Items.Insert(0, new ListItem("Select Region", "0"));
        }
    }

  

    public void BindState()
    {
        try
        {
            con = new SqlConnection(method.str);
            cmd = new SqlCommand("GetState", con);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DdlState.DataSource = dt;
            DdlState.DataTextField = "StateName";
            DdlState.DataValueField = "SId";
            DdlState.DataBind();
            DdlState.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch
        {
        }
    }


    protected void ddl_Region_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Region = ddl_Region.SelectedValue;
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Id, StateName from stategstmst where RId=" + Region);
        if (dt.Rows.Count > 0)
        {
            ddl_RegionState.Items.Clear();
            ddl_RegionState.DataSource = dt;
            ddl_RegionState.DataTextField = "StateName";
            ddl_RegionState.DataValueField = "Id";
            ddl_RegionState.DataBind();
            ddl_RegionState.Items.Insert(0, new ListItem("Select State", "0"));
        }
        else
        {
            ddl_RegionState.Items.Clear();
            ddl_RegionState.Items.Insert(0, new ListItem("Select State", "0"));
        }
    }
}
