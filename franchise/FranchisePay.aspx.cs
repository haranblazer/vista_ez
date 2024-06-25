using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Data.SqlClient;
using System.Data;
using System.Text;

public partial class franchise_FranchisePay : System.Web.UI.Page, ICallbackEventHandler
{
    string strajax;
    WebClient client = new WebClient();
    utility obj = new utility();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    string date;
    protected void Page_Load(object sender, EventArgs e)
    {

        txtid.Visible = false;
        if (Session["UserName"] == null)
        {
            Response.Redirect("Logout.aspx");

        }
        
        if (!IsPostBack)
        {
            BindUserID();
        }

        string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
        StringBuilder newFunction = new StringBuilder();
        newFunction.Append("function ServerSendValue(arg,ctx)");
        newFunction.Append("{");
        newFunction.Append(js);
        newFunction.Append(";}");
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);
    }

    #region (ICallbackEventHandlar Methods..)
    public string GetCallbackResult()
    {
        return strajax;
    }
    public void RaiseCallbackEvent(string eventArguments)
    {
        con.Close();
        if (eventArguments != "")
        {
            con.Open();
            SqlCommand cmd = new SqlCommand();
            SqlDataReader dr;
            cmd.CommandText = "select fname as name from franchisemst where username='" + eventArguments.Trim() + "'";
            cmd.Connection = con;
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                strajax = Convert.ToString(dr["name"]);
                Session["sname"] = Convert.ToString(dr["name"]);
            }
            else
            {
                strajax = "User Does Not Exist!";
            }

            dr.Close();
            con.Close();
        }
        else
        {
            strajax = "Required field cannot be blank !";
        }
    }
    #endregion


    private void BindUserID()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            DataTable tbl = new DataTable();
            da = new SqlDataAdapter("select username from franchisemst", con);
            da.Fill(tbl);
            divUserID.InnerText = string.Empty;
            foreach (DataRow row in tbl.Rows)
            {
                divUserID.InnerText += row["username"].ToString().Trim() + ",";
            }

        }
        catch
        {
        }
        finally
        {
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {

            cmd = new SqlCommand("franchisepay", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@username", Session["UserName"]);
            cmd.Parameters.AddWithValue("@allotedto","");
            //cmd.Parameters.AddWithValue("@Amount", txtAmount.Text.Trim());
            //cmd.Parameters.AddWithValue("@ProductId", ddlProduct.SelectedValue.ToString());         
            //cmd.Parameters.AddWithValue("@pintype", ddlPinType.SelectedValue.ToString());
            //cmd.Parameters.AddWithValue("@paidstatus", ddlPaidStatus.SelectedValue.ToString());

            cmd.Parameters.AddWithValue("@mode", ddlMode.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@TransactionNumber", txtTransactionNumber.Text.Trim());
            cmd.Parameters.AddWithValue("@bank", ddlBankName.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@branch", txtBranch.Text.Trim());
            cmd.Parameters.AddWithValue("@depositedamount", txtDepositedAmount.Text.Trim());
            cmd.Parameters.AddWithValue("@Remark", txtRemark.Text.Trim());
            //cmd.Parameters.AddWithValue("@fromPinSrNo", pinno.Text.Trim());
            //cmd.Parameters.AddWithValue("@toPinSrNo", topins);
            con.Open();
            cmd.ExecuteNonQuery();
            utility.MessageBox(this, "data saved successfuly");

            txtRemark.Text  =txtBranch.Text = txtDepositedAmount.Text = txtTransactionNumber.Text = string.Empty;
            ddlMode.SelectedValue = ddlBankName.SelectedValue = "0";

        }

        catch (Exception ex)
        {

            utility.MessageBox(this, ex.ToString());
        }
        finally
        {

            con.Close();
        }
    }



    protected void ddlMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlMode.SelectedItem.Text == "Cash")
        {
            txtTransactionNumber.Text = string.Empty;
            txtTransactionNumber.Enabled = false;
            ddlBankName.SelectedIndex = 0;
            ddlBankName.Enabled = false;
            txtBranch.Text = string.Empty;
            txtBranch.Enabled = false;
            txtDepositedAmount.Text = string.Empty;
            txtDepositedAmount.Enabled = true;
        }
        else if (ddlMode.SelectedItem.Text == "Cheque")
        {
            txtTransactionNumber.Text = string.Empty;
            txtTransactionNumber.Enabled = true;
            ddlBankName.SelectedIndex = 0;
            ddlBankName.Enabled = true;
            txtBranch.Text = string.Empty;
            txtBranch.Enabled = true;
            txtDepositedAmount.Text = string.Empty;
            txtDepositedAmount.Enabled = true;
        }
        else if (ddlMode.SelectedItem.Text == "DD")
        {
            txtTransactionNumber.Text = string.Empty;
            txtTransactionNumber.Enabled = true;
            ddlBankName.SelectedIndex = 0;
            ddlBankName.Enabled = true;
            txtBranch.Text = string.Empty;
            txtBranch.Enabled = true;
            txtDepositedAmount.Text = string.Empty;
            txtDepositedAmount.Enabled = true;
        }
        else if (ddlMode.SelectedItem.Text == "Transfer")
        {

            ddlBankName.SelectedIndex = 0;
            ddlBankName.Enabled = true;
            txtBranch.Text = string.Empty;
            txtBranch.Enabled = true;
            txtDepositedAmount.Text = string.Empty;
            txtDepositedAmount.Enabled = true;
        }
        else
        {
        }
    }

}