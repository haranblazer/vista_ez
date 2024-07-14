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
using System.IO;
using System.Text;
using System.Web.Services;

public partial class user_WithdrawRequest : System.Web.UI.Page
{

    string regno, strajax;
    utility objUtil = null;
    SqlConnection con = null;
    SqlCommand com = null;

    string flagvalue = null;
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (string.IsNullOrEmpty(Convert.ToString(Session["userId"])))
            {
                Response.Redirect("~/login.aspx", false);
            }
            else
            {
                regno = Session["userId"].ToString().Trim();
                if (regno == "")
                    Response.Redirect("~/Error.aspx", false);
                if (!Regex.Match(regno, @"^[a-zA-Z0-9]*$").Success)
                    Response.Redirect("~/Default.aspx", false);
                if (!IsPostBack)
                {
                    BindData();
                 
                    //if (!string.IsNullOrEmpty(Request.QueryString["u"]))
                    //btnSubmit.CommandArgument = obj.base64Decode(Request.QueryString["u"].ToString());
                }
            }
            //string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
            //StringBuilder newFunction = new StringBuilder("function ServerSendValue(arg,ctx){" + js + "};");
            //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);
        }
        catch
        {
            Response.Redirect("~/Default.aspx", false);
        }

    }


    public void BindData()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("ExecuteFunction", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@function", "getEwalletBalance");
            com.Parameters.AddWithValue("@functionparameter", "'" + regno.Trim() + "'");
            SqlDataAdapter adp = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            adp.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lblBalance.Text = dt.Rows[0]["column1"].ToString();
            }
        }
        catch
        {
            Response.Redirect("~/Error.aspx", false);
        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if ((Convert.ToDouble(lblBalance.Text) >= Convert.ToDouble(TxtAmount.Text)) && (Convert.ToDouble(TxtAmount.Text)) >= 500)
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("withdrawrequest", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regno", regno);
            com.Parameters.AddWithValue("@amount", TxtAmount.Text);
            com.Parameters.AddWithValue("@epassword", TxtEpassword.Text);
            com.Parameters.AddWithValue("@remark", txtRemark.Text == "" ? "No remark" : txtRemark.Text);
            com.Parameters.AddWithValue("@type", "OTP");

            com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            flagvalue = (string)com.Parameters["@flag"].Value;
            if (flagvalue == "1")
            {

                con.Close();
                utility.MessageBox(this, "Wallet Request Added Successfull");
                BindData();
                btnSubmit.Enabled = false;
                TxtAmount.Text = TxtEpassword.Text = txtRemark.Text = string.Empty;
                return;
            }

            if (flagvalue == "Invalid Amount")
            {

                utility.MessageBox(this, "Invalid Amount");

                return;
            }


            if (flagvalue == "Password Is Not valid")
            {

                utility.MessageBox(this, "Password Is Not valid");

                return;
            }


            if ((flagvalue != "1") && (flagvalue != "Password Is Not valid") && (flagvalue != "Invalid Amount"))
            {

                utility.MessageBox(this, "Wallet Not Request Added Successfull.");

                return;
            }

        }
        else
        {
            utility.MessageBox(this, "Enter valid amount.");
            btnSubmit.Enabled = false;
        }
    }


    [WebMethod]
    public static string GenerateOTP(string Amount)
    {
        string Result = "0";
        DataTable dt = new DataTable();
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        da = new SqlDataAdapter("GenerateOTP", con);
        da.SelectCommand.Parameters.AddWithValue("@RegNo",HttpContext.Current.Session["userId"].ToString());
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            utility objUtil = new utility();
            //string msg = "Dear " + HttpContext.Current.Session["userId"].ToString() + " Your Withdraw Request Rs. " + Amount.Trim() +
            //    " from your Company Wallet use OTP. OTP is " + dt.Rows[0]["OTP"].ToString().Trim() + ". Don't share with anyone.";

            //string msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 30 min";
            String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 15 min from:toptimenet.com Jai Toptime";
            if (Convert.ToDecimal(Amount) > 499)
            {
                objUtil.sendSMSByBilling(dt.Rows[0]["AppMstMobile"].ToString().Trim(), msg, "OTP");
            }
            else
            {
                  Result = "Withdraw Request Amount can not less than 500.!!";

            }
        }

        return Result;
    }
    [WebMethod]
    public static string VerifyOTP(string OTP)
    {

        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("VerifyOTP", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@RegNo", HttpContext.Current.Session["userId"].ToString());
        com.Parameters.AddWithValue("@OTP", OTP);
        com.Parameters.Add("@IsValid", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        string Result = com.Parameters["@IsValid"].Value.ToString();
        if (Result == "0")
        {

            //divbind.Enabled = false;
        }
        else
        {
        }
        return Result;
    }


}