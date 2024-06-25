using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class secretadmin_GenerateFund : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand com = null;
    utility objUtil = new utility();
    protected string f;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();
                SetBalance();
            }
        }
        catch
        {

        }

       
    }

    public void SetBalance()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("declare @query varchar(500) set @query='select ['+ schema_name()+'].getEwalletBalanceF(-111) as balance' exec(@query) ", con);
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
                lblfund.Text = dt.Rows[0]["balance"].ToString();
            }
            else
            {
                lblfund.Text = "0";
            }
        }
        catch (Exception ex)
        {
            con.Close();
            con.Dispose();
            Response.Redirect("~/Error.aspx");
        }
    }

    public void setloginBalance()
    {
        lblfund.Text = "0";
        con = new SqlConnection(method.str);
        com = new SqlCommand("declare @query varchar(500) set @query='select ['+ schema_name()+'].getbalance(-111) as balance' exec(@query) ", con);
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
                lblfund.Text = dt.Rows[0]["balance"].ToString();
            }
            else
            {
                lblfund.Text = "0";
            }
        }
        catch (Exception ex)
        {
            con.Close();
            con.Dispose();
            Response.Redirect("~/Error.aspx");
        }
    }


    public void SetRedemptionBalance()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("getRedeemWalletBal", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@AppMstRegNo", "-111");
            com.Parameters.Add("@Bal", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.CommandTimeout = 1900;
            com.ExecuteNonQuery();
            lblfund.Text = com.Parameters["@Bal"].Value.ToString();
            con.Close();
            con.Dispose();
        }
        catch (Exception ex)
        {
            con.Close();
            con.Dispose();
            Response.Redirect("~/Error.aspx");
        }
    }
  public void SetODWalletBalance()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("GetODWalletBal", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@AppMstRegNo", "-111");
            com.Parameters.Add("@Bal", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.CommandTimeout = 1900;
            com.ExecuteNonQuery();
            lblfund.Text = com.Parameters["@Bal"].Value.ToString();
            con.Close();
            con.Dispose();
        }
        catch (Exception ex)
        {
            con.Close();
            con.Dispose();
            Response.Redirect("~/Error.aspx");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string status = "";
        if (string.IsNullOrEmpty(txtfund.Text.Trim()))
        {
            utility.MessageBox(this, "Enter Wallet.");
            return;
        }
        else if (!objUtil.IsNumeric(txtfund.Text.Trim()))
        {
            utility.MessageBox(this, "Invalid entry for Wallet.");
            return;
        }
        else if (Convert.ToDecimal(txtfund.Text.Trim()) < 0)
        {
            utility.MessageBox(this, "Invalid entry for Wallet.");
            return;
        }
        else if (Convert.ToDecimal(txtfund.Text.Trim()) > 10000000)
        {
            utility.MessageBox(this, "Amount should not be greater than 1 crore.");
            return;
        }

        if (ddlType.SelectedValue == "1")
        {

            con = new SqlConnection(method.str);
            try
            {
                com = new SqlCommand("GenerateServiceFund ", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@bal", txtfund.Text.Trim());
                con.Open();
                com.CommandTimeout = 90000;
                if (com.ExecuteNonQuery() > 0)
                {
                    utility.MessageBox(this, "Unit Wallet is credited by :" + txtfund.Text.Trim());
                    txtfund.Text = string.Empty;
                    SetBalance();
                }
                else
                {
                    utility.MessageBox(this, "try later.");
                    con.Close();
                }
            }
            catch
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }

        }
        else if (ddlType.SelectedValue == "2")
        {

            con = new SqlConnection(method.str);
            try
            {
                com = new SqlCommand("GenerateBankTranfund", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@bal", txtfund.Text.Trim());
                con.Open();
                com.CommandTimeout = 90000;


                if (com.ExecuteNonQuery() > 0)
                {
                    utility.MessageBox(this, "Company Wallet is credited by :" + txtfund.Text.Trim());
                    txtfund.Text = string.Empty;
                    setloginBalance();
                }
                else
                {
                    utility.MessageBox(this, "try later.");
                    con.Close();
                }
            }
            catch
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }

        }
        else if (ddlType.SelectedValue == "3")
        {
            con = new SqlConnection(method.str);
            try
            {
                com = new SqlCommand("GenerateRedeemfund", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@bal", txtfund.Text.Trim());
                con.Open();
                com.CommandTimeout = 90000;
                if (com.ExecuteNonQuery() > 0)
                {
                    utility.MessageBox(this, "Redemption Wallet is credited by :" + txtfund.Text.Trim());
                    txtfund.Text = string.Empty;
                    SetRedemptionBalance();
                }
                else
                {
                    utility.MessageBox(this, "try later.");
                    con.Close();
                }
            }
            catch
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }

        }
        else if (ddlType.SelectedValue == "4")
        {
            con = new SqlConnection(method.str);
            try
            {
                com = new SqlCommand("GenerateODWallet", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@bal", txtfund.Text.Trim());
                con.Open();
                com.CommandTimeout = 90000;
                if (com.ExecuteNonQuery() > 0)
                {
                    utility.MessageBox(this, "OD Wallet is credited by :" + txtfund.Text.Trim());
                    txtfund.Text = string.Empty;
                    SetRedemptionBalance();
                }
                else
                {
                    utility.MessageBox(this, "try later.");
                    con.Close();
                }
            }
            catch
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }

        }
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType.SelectedValue == "1")
        {
            SetBalance();
        }
        else if (ddlType.SelectedValue == "2")
        {
            setloginBalance();
        }
        else if (ddlType.SelectedValue == "3")
        {
            SetRedemptionBalance();
        }
        else if (ddlType.SelectedValue == "4")
        {
            SetODWalletBalance();
        }
    }
}