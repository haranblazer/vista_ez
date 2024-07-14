using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;


public partial class User_TransferWallet : System.Web.UI.Page
{
    static string regno = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx", false);
        }
        else
        {
            regno = Session["userId"].ToString().Trim();
            if (!IsPostBack)
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();
                lblBalance.Text = " Bal: " + GetBal("7");
                lbl_CWallet.Text = GetBal("8");
                lbl_msg.Text = "";
            }
        }

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }

    protected void ddl_BillType_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblBalance.Text = " Bal: " + GetBal(ddl_BillType.SelectedValue);
        Session["CheckRefresh"] = System.DateTime.Now.ToString();
    }

    public string GetBal(string WalletType)
    {
        String Balance = "0", ProcName = "";
        try
        {
            if (WalletType == "7")
                ProcName = "getPayoutBalanceUser";
            else if (WalletType == "8")
                ProcName = "getwalletBalanceUser";
            else if (WalletType == "11")
                ProcName = "getTopperBalanceUser";
            else if (WalletType == "12")
                ProcName = "getRewardBalanceUser";


            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand(ProcName, con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@AppMstRegNo", regno);
            com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            Balance = com.Parameters["@Bal"].Value.ToString();
            return Balance;
        }
        catch (Exception ex) { return "0"; }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            lbl_msg.Text = "";
              var WalletType = ddl_BillType.SelectedValue;
            if (WalletType == "7")
                WalletType = "PTran80";
            else if (WalletType == "11")
                WalletType = "PTran20";
            else if (WalletType == "12")
                WalletType = "RewardWallet";

            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                SqlConnection con = new SqlConnection(method.str);
                SqlCommand com = new SqlCommand("WalletTransfer", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@regno", regno);
                com.Parameters.AddWithValue("@amount", TxtAmount.Text);
                com.Parameters.AddWithValue("@remark", txtRemark.Text == "" ? "No remark" : txtRemark.Text);
                com.Parameters.AddWithValue("@WalletType", WalletType);

                com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string Result = com.Parameters["@flag"].Value.ToString();
                if (Result == "1")
                {
                    con.Close();
                    lblBalance.Text = " Bal: " + GetBal(ddl_BillType.SelectedValue);
                    lbl_CWallet.Text = GetBal("8");
                    Reset();
                    lbl_msg.Text = "Your Wallet Transfer Successfull";
                    return;
                }
                else
                {
                    lbl_msg.Text = Result;
                    utility.MessageBox(this, Result);
                    return;
                }
            }
            else
            {
                utility.MessageBox(this, "Don't refresh page.");
                return;
            }
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.Message);
            return;
        }
    }


    void Reset()
    {
        TxtAmount.Text = "0";
        txtRemark.Text = "";
    }
         
}