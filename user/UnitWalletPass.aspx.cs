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
using System.Drawing;

public partial class user_PointTransfertoBank : System.Web.UI.Page
{
    string regno = "";
    string strajax = "";
    utility objUtil = null;
    SqlConnection con = null;
    SqlCommand com = null;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (string.IsNullOrEmpty(Convert.ToString(Session["userId"])))
        {
            Response.Redirect("~/Default.aspx", false);
            return;
        }

        
        if (pagecheck() != "1")
        {
            Response.Redirect("~/maintenance.aspx", false);
            return;
        }
       
        
        try
        {
            if (!IsPostBack)
            {
                regno = Session["userId"].ToString().Trim();

                BindData();
                //lblUser.Text = GetSponsorName(txtUserID.Text);
                //lblUser.Text = "";

            }

            //string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
            //StringBuilder newFunction = new StringBuilder("function ServerSendValue(arg,ctx){" + js + "}");
            //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);

        }
      
    }

    public void BindData()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("getepointInfo", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno",Session["userId"].ToString().Trim());
        try
        {
            con.Open();
            SqlDataReader dr = com.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                lblBalance.Text = dr["balance"].ToString();
                con.Close();
                con.Dispose();
            }
            else
            {

                con.Close();
                con.Dispose();
                lblBalance.Text = "0";
                //Response.Redirect("welcome.aspx",false);
            }
           
        }
        catch
        {
            con.Close();
            con.Dispose(); Response.Redirect("~/Error.aspx", false);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        objUtil = new utility();

        if (ViewState["membership"] == null)
        {
            utility.MessageBox(this, "Already transfer point");
            return;
        }

        if (usercheck() == false)
        {
            utility.MessageBox(this, ViewState["error"].ToString());
        }

        //if (usercheck() == true)
        //{
        //    utility.MessageBox(this, "This is wallet user");
        //}

        if (txtUserID.Text.Trim() == "" || !objUtil.IsAlphaNumeric(txtUserID.Text.Trim()))
        {
            utility.MessageBox(this, "Invalid user ID");
            return;
        }
        else if (TxtAmount.Text.Trim() == "" || !objUtil.IsNumeric(TxtAmount.Text.Trim()) || Convert.ToDecimal(TxtAmount.Text.Trim()) <= 0)
        {
            utility.MessageBox(this, "Invalid amount");
            return;
        }
        else if (Convert.ToDecimal(TxtAmount.Text.Trim()) > 900000)
        {
            utility.MessageBox(this, "Amount limit 1-900000");
            return;
        }
        else if (Convert.ToDecimal(lblBalance.Text) <= 0)
        {
            utility.MessageBox(this, "You have not sufficient balance");
            return;
        }

        else if (TxtEpassword.Text.Trim() != "")
        {

           // Boolean isfranchise = IsFranchise(regno);
            con = new SqlConnection(method.str);
            com = new SqlCommand("Ptran80toBanktran", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@PregNo", Session["userId"].ToString().Trim());
            com.Parameters.AddWithValue("@cRegNo", txtUserID.Text.Trim());
            com.Parameters.AddWithValue("@Epwd", TxtEpassword.Text.Trim());
            com.Parameters.AddWithValue("@Amt", Convert.ToDecimal(TxtAmount.Text.Trim()));
            com.Parameters.AddWithValue("@Reason", txtRemark.Text.Trim());
            com.Parameters.Add(new SqlParameter("@Abalance", SqlDbType.Float));
            com.Parameters["@Abalance"].Direction = ParameterDirection.Output;
            com.Parameters.Add(new SqlParameter("@flag", SqlDbType.VarChar, 100));
            com.Parameters["@flag"].Direction = ParameterDirection.Output;
            try
            {
                con.Open();
                com.CommandTimeout = 90000;
                com.ExecuteNonQuery();
                string msg = com.Parameters["@flag"].Value.ToString();
                con.Close();
                con.Dispose();
                if (msg == "1")
                {
                    lblBalance.Text = com.Parameters["@Abalance"].Value.ToString();
                    ViewState["error"] = null;
                    ViewState["membership"] = null;
                    lblUser.Text = "";

                    //  sendsms(txtUserID.Text.Trim(), Convert.ToDecimal(Math.Round(Convert.ToDouble(TxtAmount.Text), 2)), Convert.ToDecimal(Math.Round(Convert.ToDouble(lblBalance.Text), 2)), Convert.ToDecimal(Math.Round(Convert.ToDouble(com.Parameters["@CtBalance"].Value.ToString()), 2)));
                    ResetControls();
                    utility.MessageBox(this, "Amount transfered successfully.");
                }
                else
                    utility.MessageBox(this, msg);
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                    con.Dispose();
                }
                //Response.Redirect("~/Error.aspx");
            }

        }
      
      
    }
    public void sendsms(string reg, decimal amt, decimal newBal, decimal ctBal)
    {
        try
        {
            objUtil = new utility();
            con = new SqlConnection(method.str);
            SqlDataAdapter da = new SqlDataAdapter("Select AppMstTitle,AppMstFName,AppMstMobile,(select AppMstMobile from appmst where appmstregno='" + reg + "') as toMobile,(select AppMstTitle+space(1)+Appmstfname from appmst where appmstregno='" + reg + "') as toName  from appmst where appmstRegNo='" + Convert.ToString(Session["userId"]) + "'", con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            string msgtxt = "Dear " + dt.Rows[0]["AppMstTitle"].ToString() + " " + dt.Rows[0]["AppMstFName"].ToString() + " points: " + amt + " has been transfered from your A/c to :" + reg + " and now A/c balance is:" + newBal;
            string msgtxt1 = "Dear " + dt.Rows[0]["toName"].ToString() + " points: " + amt + " has been transfered to your A/c from :" + regno + " and your A/c balance is: " + ctBal;
            if (dt.Rows[0]["AppMstMobile"].ToString().Length > 9)
            {
                //objUtil.sendsms(dt.Rows[0]["AppMstMobile"].ToString(), msgtxt);
            }
            if (dt.Rows[0]["toMobile"].ToString().Length > 9)
            {
                //objUtil.sendsms(dt.Rows[0]["toMobile"].ToString(), msgtxt1);
            }
        }
        catch
        {

        }

    }
    public Boolean IsvalidExdPwd()
    {
        if (regno.Length > 1)
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("IsValidExPwd", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regNo", Session["userId"].ToString().Trim());
            com.Parameters.AddWithValue("@ExPwd", TxtEpassword.Text.Trim());
            try
            {
                con.Open();
                SqlDataReader dr = com.ExecuteReader();
                if (dr.HasRows)
                {
                    con.Close();
                    con.Dispose();
                    return true;
                }
                else
                {
                    con.Close();
                    con.Dispose();
                    return false;
                }
            }
            catch
            {
                return false;

            }
        }
        else
            return false;
    }


    //#region (ICallbackEventHandlar Methods..)
    //public string GetCallbackResult()
    //{
    //    return strajax;
    //}

    //public void RaiseCallbackEvent(string eventArguments)
    //{
    //    if (eventArguments != "")
    //    {
    //        con = new SqlConnection(method.str);
    //        SqlCommand cmd = new SqlCommand();
    //        SqlDataReader dr;
    //        cmd.CommandText = "select appmsttitle+space(1)+appmstfname as name from appmst where appmstregno=@regno";
    //        cmd.Parameters.AddWithValue("@regno", eventArguments.Trim());
    //        cmd.Connection = con;
    //        con.Open();
    //        dr = cmd.ExecuteReader();

    //        if (dr.Read())
    //        {
    //            strajax = Convert.ToString(dr["name"]);
    //            Session["sname"] = Convert.ToString(dr["name"]);
    //        }
    //        else
    //        {
    //            strajax = "User Does Not Exist!";
    //        }
    //        dr.Close();
    //        con.Close();
    //    }
    //    else
    //    {
    //        strajax = "Required field cannot be blank !";
    //    }
    //}
    //#endregion

    private void ResetControls()
    {
        txtUserID.Text = string.Empty;
        TxtAmount.Text = string.Empty;
        TxtEpassword.Text = string.Empty;
        txtRemark.Text = string.Empty;
    }

    //private string GetSponsorName(string regno)
    //{
    //    string name = string.Empty;
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("select appmstfname from AppMst where AppMstRegNo=@regno", con);
    //        com.Parameters.AddWithValue("@regno", Session["userId"].ToString().Trim());
    //        con.Open();
    //        name = com.ExecuteScalar().ToString();
    //        con.Close();
    //    }
    //    catch
    //    {
    //    }
    //    return name;

    //}

      string check;
    public string pagecheck()
    {
       
        try
        {
            SqlDataReader dr;
            con = new SqlConnection(method.str);
            com = new SqlCommand("pageblock", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@type",4);
            con.Open();
            dr = com.ExecuteReader();
            while (dr.Read())
            {


                if (Convert.ToDouble(dr["flag"].ToString()) > 0)
                {

                    check = dr["flag"].ToString();
                }

                else
                {
                    check = "0";
                }
            }

            dr.Close();
            con.Close();


            return check;

        }
        catch (Exception ex)
        {
            check = "0";
            return check;
        }
        finally
        {

        }
    }
    protected void txtUserID_TextChanged(object sender, EventArgs e)
    {
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;

        cmd.CommandText = "userinfo";
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@regno", txtUserID.Text);
      
        cmd.Connection = con;
        con.Open();
        dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            ViewState["type"] = Convert.ToString(dr["incometype"]);

            ViewState["membership"] = Convert.ToString(dr["membership_rank"]);

            if (Convert.ToInt32(dr["incometype"].ToString()) == 1)         
            {
                ViewState["error"] = Convert.ToString(dr["name"]) + " is not Wallet Type user";
                
                lblUser.Text = Convert.ToString(dr["name"]) + " is not Wallet Type user" + " <img  src='../user_images/cross.png' width='25px' height='25px'/>";
                lblUser.ForeColor = Color.Red;
            }

            if ((Convert.ToInt32(dr["incometype"]) == 2) && ((Convert.ToInt32(dr["membership_rank"]) == 4) || (Convert.ToInt32(dr["membership_rank"]) == 5)))                           
            {
                lblUser.Text = Convert.ToString(dr["name"]) + "," + Convert.ToString(dr["Product"]) + " <img  src='../user_images/checksign.png' width='25px' height='25px'/>";

                lblUser.ForeColor = Color.Green;
            }

            if ((Convert.ToInt32(dr["incometype"]) == 2) && ((Convert.ToInt32(dr["membership_rank"]) < 4)))
            {
                ViewState["error"] = Convert.ToString(dr["name"]) + ",is " + Convert.ToString(dr["Product"]) + "Type Product";
                
                lblUser.Text = Convert.ToString(dr["name"]) + ",is " + Convert.ToString(dr["Product"]) + "Type Product" + " <img  src='../user_images/cross.png' width='25px' height='25px'/>";

                lblUser.ForeColor = Color.Red;
            }

            
            
        }
        else
        {
            ViewState["error"] = "User does not exists";
            lblUser.Text = "User does not exists" + " <img  src='../user_images/cross.png' width='25px' height='25px'/>";
            lblUser.ForeColor = Color.Red;
        }
        dr.Close();
        con.Close();
    }

    public Boolean usercheck()
    {
        if ((ViewState["type"].ToString() == "2") && (ViewState["membership"].ToString() == "4" || ViewState["membership"].ToString() == "5"))
        {
            return true;
        }
        return false;
    }
}
