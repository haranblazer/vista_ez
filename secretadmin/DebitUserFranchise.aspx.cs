using System; 
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class secretadmin_DebitUserFranchise : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand com = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            InsertFunction.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            InsertFunction.CheckAdminlogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx", false);
        }
        if (!IsPostBack)
        {

            Session["CheckRefresh"] = System.DateTime.Now.ToString();
        }
    }
    protected void txtUserid_TextChanged(object sender, EventArgs e)
    {
        FIRSTCLEAR();
        GetDetail(txtUserid.Text.Trim());
    }
    private void GetDetail(string Regno)
    {
        try
        {
            if (txtUserid.Text != "")
            {
                con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("FindUserDtl", con);
                SqlDataReader dr;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@regno", Regno.Trim());
                cmd.Parameters.AddWithValue("@UserType", rdobtn.SelectedValue);
                cmd.Connection = con;
                con.Open();
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtusername.Text = Convert.ToString(dr["name"]);
                    string RgNo = Convert.ToString(dr["appmstregno"]);
                    BindWallet(RgNo);
                  
                    divABal.Visible = true;
                }
                else
                {
                    utility.MessageBox(this, "Please enter a valid " + rdobtn.SelectedItem.Text + " user id");
                    divABal.Visible = false;
                    txtusername.Text = "";
                }
            }
            else
            {
            }
        }
        catch
        {

        }
    }

    private void BindWallet(string RegNo)
    {
        try
        {

            if (RegNo != "" && rdobtn.SelectedValue == "0" && ddlwallettype.SelectedValue=="1")
            {
              
                con = new SqlConnection(method.str);
                com = new SqlCommand("getwalletBalanceUser", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@AppMstRegNo", RegNo);
                com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string Amt = com.Parameters["@Bal"].Value.ToString();
                lbldrBal.Text = Amt.ToString();
            }
            else if (RegNo != "" && rdobtn.SelectedValue == "0" && ddlwallettype.SelectedValue == "4")
            {
                con = new SqlConnection(method.str);
                com = new SqlCommand("getRedeemWalletBal", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@AppMstRegNo", RegNo);
                com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string Amt = com.Parameters["@Bal"].Value.ToString();
                lbldrBal.Text = Amt.ToString();
            }
            else if (RegNo != "" && rdobtn.SelectedValue == "0" && ddlwallettype.SelectedValue == "6")
            {
                con = new SqlConnection(method.str);
                com = new SqlCommand("getRewardBalanceUser", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@AppMstRegNo", RegNo);
                com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string Amt = com.Parameters["@Bal"].Value.ToString();
                lbldrBal.Text = Amt.ToString();
            }
            else if (RegNo != "" && rdobtn.SelectedValue == "1" && ddlwallettype.SelectedValue == "3")
            {
               
                con = new SqlConnection(method.str);
                com = new SqlCommand("getwalletBalanceFran", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@appmstid", RegNo);
                com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string Amt = com.Parameters["@Bal"].Value.ToString();
                lbldrBal.Text = Amt.ToString();
            }
            else if (RegNo != "" && rdobtn.SelectedValue == "1" && ddlwallettype.SelectedValue == "5")
            {

                con = new SqlConnection(method.str);
                com = new SqlCommand("getOD_walletBalFran", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@appmstid", RegNo);
                com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string Amt = com.Parameters["@Bal"].Value.ToString();
                lbldrBal.Text = Amt.ToString();
            }
            else if (RegNo != "" && rdobtn.SelectedValue == "0" && ddlwallettype.SelectedValue == "2")
            {
               
                con = new SqlConnection(method.str);
                com = new SqlCommand("getepointInfo", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@regno", RegNo.Trim());
                try
                {
                    con.Open();
                    SqlDataReader dr = com.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        lbldrBal.Text = dr["balance"].ToString();
                        con.Close();
                        con.Dispose();                    }
                    else
                    {

                        con.Close();
                        con.Dispose();
                        lbldrBal.Text = "0";
                    }

                }
                catch
                {
                }
            }
            bindadminbal(ddlwallettype.SelectedValue);

        }
        catch (Exception ex)
        { }
    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        FIRSTCLEAR();
        GetDetail(txtUserid.Text.Trim());
    }
    protected void rdobtn_SelectedIndexChanged(object sender, EventArgs e)
    {
        dumyddlbind();
    }
    private void dumyddlbind()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Id", typeof(Int32));
        dt.Columns.Add("WALLETTYPE", typeof(string));
        ddlwallettype.Items.Clear();
        if (rdobtn.SelectedValue == "0")
        {
            dt.Rows.Add(1, "Company Wallet");
            //dt.Rows.Add(2, "Payout Wallet");
            //dt.Rows.Add(4, "Loyalty Wallet");
            //dt.Rows.Add(6, "R Wallet");
        }
        else
        {
           // dt.Rows.Add(3, "Franchise Wallet");
            dt.Rows.Add(5, "OD Wallet");
        }
        ddlwallettype.DataSource = dt;
        ddlwallettype.DataTextField = "WALLETTYPE";
        ddlwallettype.DataValueField = "Id";
        ddlwallettype.DataBind();
        FIRSTCLEAR();
        txtUserid.Text = "";
    }
    private void FIRSTCLEAR()
    {
        txtusername.Text = "";
        rbltype.SelectedValue = "0";
        txtAmount.Text = "";
        txtRemark.Text = "";
        lblcrBal.Text = "0";
        lbldrBal.Text = "0";
       // lblcrBal.Visible=false;
        //lbldrBal.Visible = true;
       // divePassconf.Visible = false;
     //   divABal.Visible = false;
        //divall.Visible = true;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (rbltype.SelectedValue == "0" && ddlwallettype.SelectedValue == "5")
        {
            utility.MessageBox(this, "Debit Process not valid in OD Wallet.!!");
            return;
        }
        if (String.IsNullOrEmpty(txtAmount.Text))
        {
            utility.MessageBox(this, "Please Enter Amount ");
            return;
        }
        if (Regex.Match(txtAmount.Text.Trim(), @"^[0-9 ]*$").Success)
        { }
        else
        {
            utility.MessageBox(this, "Please Enter Valid Amount ");
            return;
        }

        if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();

            SaveWallet();
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    private void SaveWallet()
    {
       
        if (txtepassword.Text != "")
        {
            if (Regex.Match(txtepassword.Text, @"^[a-zA-Z0-9]{3,}$").Success)
            {
                con = new SqlConnection(method.str);
                SqlDataAdapter sda = new SqlDataAdapter("ePasswordAdmin", con);
                sda.SelectCommand.CommandType = CommandType.StoredProcedure;
                sda.SelectCommand.Parameters.AddWithValue("@pwd", txtepassword.Text);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    if (txtepassword.Text == dt.Rows[0]["ePassword"].ToString())
                    {
                        try
                        {
                            
                        con = new SqlConnection(method.str);
                        com = new SqlCommand("DebitCredit", con);
                        com.CommandType = CommandType.StoredProcedure;
                        com.Parameters.AddWithValue("@Regno", txtUserid.Text.Trim());
                        com.Parameters.AddWithValue("@UserTypes", rdobtn.SelectedValue);
                        com.Parameters.AddWithValue("@amt", lbldrBal.Text.Trim());
                        com.Parameters.AddWithValue("@cramt", lblcrBal.Text.Trim());
                        com.Parameters.AddWithValue("@Amount", txtAmount.Text.Trim());
                        com.Parameters.AddWithValue("@Remark", txtRemark.Text);
                        com.Parameters.AddWithValue("@DrCr", rbltype.SelectedValue);
                        com.Parameters.AddWithValue("@WalletType", ddlwallettype.SelectedValue);
                        com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                        com.Parameters.Add("@Status", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                        con.Open();
                        com.ExecuteNonQuery();
                        string flag = (com.Parameters["@flag"].Value).ToString();
                        string status = (com.Parameters["@Status"].Value).ToString();
                        con.Close();
                        con.Dispose();
                            if (status == "1")
                            {                           
                                    utility.MessageBox(this, flag);
                                    FIRSTCLEAR();
                                    txtUserid.Text = "";
                                    rdobtn.SelectedValue = "0";
                               
                            }
                            else
                            {
                                utility.MessageBox(this, flag);
                            
                            }
                        }
                        catch
                        {
                            utility.MessageBox(this, "Transaction Error.");
                            return;
                        }
                    }
                }
                else
                {
                    utility.MessageBox(this, "Please Enter Correct  E-Pasword !!!");
                }
            }
            else
            {
                utility.MessageBox(this, "Password must be six characters long including letters and numbers !");
                txtepassword.Focus();
                return;
            }
        }
        else
        {
            utility.MessageBox(this, "Please Enter E-Pasword !!!");
        }
    }
    protected void btnok_Click(object sender, EventArgs e)
    {
       
    }
    protected void btnback_Click(object sender, EventArgs e)
    {
        divePassconf.Visible = false;
        divall.Visible = true;
    } 
    protected void rbltype_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rbltype.SelectedValue == "0")
        {
            lbldrBal.Visible = true;
            lblcrBal.Visible = false;
            lblcrBal.Text = "0";
            bindadminbal(ddlwallettype.SelectedValue);
        }
        else
        {
            lblcrBal.Text = "0";
            lbldrBal.Visible = false;
            lblcrBal.Visible = true;
            bindadminbal(ddlwallettype.SelectedValue);

        }
      // bindadminbal(ddlwallettype.SelectedValue);
       
    }
    protected void ddlwallettype_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (rbltype.SelectedValue == "0")
        {
            lbldrBal.Visible = true;
            lblcrBal.Visible = false;
            lblcrBal.Text = "0";
            bindadminbal(ddlwallettype.SelectedValue);
        }
        else if (rbltype.SelectedValue == "1")
        {
            lblcrBal.Text = "0";
            lbldrBal.Visible = false;
            lblcrBal.Visible = true;
            bindadminbal(ddlwallettype.SelectedValue);

        }
            BindWallet(txtUserid.Text.Trim());
         
    }
    private void bindadminbal(string type)
    {
        try
        {

            
            lblcrBal.Text = "0";
            con = new SqlConnection(method.str);
            SqlDataAdapter sda = new SqlDataAdapter("GETADMINWALLETBAL", con);
            sda.SelectCommand.CommandType = CommandType.StoredProcedure;
            sda.SelectCommand.Parameters.AddWithValue("@TYPE", type);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lblcrBal.Text = dt.Rows[0]["banktranbalance"].ToString();
            }
            else
            {
                lblcrBal.Text = "0";
            }
           
        }
        catch
        {
        }
    }

   
}