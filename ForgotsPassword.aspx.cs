using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;

public partial class ForgotsPassword : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        if (!string.IsNullOrEmpty(txtuserid.Text.Trim()) && Regex.IsMatch(txtuserid.Text.Trim(), "^[a-zA-Z0-9]*$"))
        {
            forgotpassword();
        }
        else
        {
            utility.MessageBox(this, "The user id is required and should be alphanumeric value!");
        }
    }

    public void forgotpassword()
    {
        try
        {
            utility objUtil = new utility();
            SqlCommand com = new SqlCommand("ForgotsPassword", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@userId", txtuserid.Text.Trim());
            com.Parameters.AddWithValue("@type", ddltype.SelectedValue);
            con.Open();
            SqlDataReader dr;
            dr = com.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                if (ddltype.SelectedValue == "1")
                {
                    if(dr["AppMstActivate"].ToString() =="2")
                    {
                        utility.MessageBox(this, "Your ID is Blocked. Please Contact to Administrator.!!");
                        txtuserid.Text = "";
                        return;
                    }

                    if (Regex.IsMatch(dr["AppMstMobile"].ToString(), @"^[6-9][0-9]{9}$"))
                    {
                       string pwd= objUtil.base64Decode(dr["AppMstPassword"].ToString());
                       string UserName = dr["AppmstFName"].ToString();
                       string subUserName,msgtxt = "";
                       if (UserName.Length > 20)
                       {
                           subUserName = UserName.Substring(0, 20).ToString();
                           msgtxt = "Dear " + subUserName + " ID No " + dr["AppMstRegno"].ToString() + " Your Password : " + pwd;
                       }
                       else
                       {
                           msgtxt = "Dear " + UserName + " ID No " + dr["AppMstRegno"].ToString() + " Your Password : " + pwd;
                       }
                        //obj.sendSMSByPage1(dr["MobileNo"].ToString(), msgtxt);
                        //utility.MessageBox(this, "Dear " + dr["CustomerName"].ToString() + " your password has been sent on your mobile number!");
                        //txtUserName.Text = "";
                        objUtil.sendSMSByBilling(dr["AppMstMobile"].ToString(), msgtxt, "FORGETPASSWORD");
                        string mm = "Dear " + dr["appmstfname"].ToString() + " SMS has been sent to your mobile number!";
                        //Dear {#var#} ID No {#var#} Your Password : {#var#} from {#var#} Jai Toptime

                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "myalert", "javascript:alert('" + mm + "');window.location ='Login.aspx';", true);
                        if (dr["IS_OPTIN"].ToString() == "1")
                        {
                            //var Msg = "Dear *" + dr["appmstfname"].ToString() + "* your ID number is *" + dr["AppMstRegno"].ToString() + "* and password is *" + pwd + "* From www.toptimenet.com Jai Toptime";
                            var Msg = "Dear *" + dr["appmstfname"].ToString() + "* your and password is *" + pwd + "*";
                            WhatsApp.Send_WhatsApp_With_Header(dr["AppMstMobile"].ToString(), Msg, "FORGET Password");
                        }

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "swal('" + mm + "').then((value) => { window.location ='Login.aspx'; });", true);
                        txtuserid.Text = "";
                    }
                    else
                    {
                        utility.MessageBox(this, "Dear " + dr["appmstfname"].ToString() + " your registered mobile number is invalid !");
                        txtuserid.Text = "";
                    }
                }
                if (ddltype.SelectedValue == "2")
                {
                    if (Regex.IsMatch(dr["Mobile"].ToString(), @"^[6-9][0-9]{9}$"))
                    {
                        string pwd = objUtil.base64Decode(dr["Password"].ToString());
                        string UserName = dr["Fname"].ToString();
                        string subUserName, msgtxt = "";
                        if (UserName.Length > 20)
                        {
                            subUserName = UserName.Substring(0, 20).ToString();
                            msgtxt = "Dear " + subUserName + " ID No " + dr["Franchiseid"].ToString() + " Your  Password : " + pwd;
                        }
                        else
                        {
                            msgtxt = "Dear " + UserName + " ID No " + dr["Franchiseid"].ToString() + " Your  Password : " + pwd;
                        }
                        //obj.sendSMSByPage1(dr["MobileNo"].ToString(), msgtxt);
                        //utility.MessageBox(this, "Dear " + dr["CustomerName"].ToString() + " your password has been sent on your mobile number!");
                        //txtUserName.Text = "";
                        objUtil.sendSMSByBilling(dr["Mobile"].ToString(), msgtxt, "FORGETPASSWORD");
                        //utility.MessageBox(this, "Dear " + dr["Fname"].ToString() + " SMS has been sent to your mobile number!");
                        string ss = "Dear " + dr["Fname"].ToString() + " SMS has been sent to your mobile number!";
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "myalert", "javascript:alert('" + ss + "');window.location ='Login.aspx';", true);

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "swal('" + ss + "').then((value) => { window.location ='Login.aspx'; });", true);




                        txtuserid.Text = "";
                       }
                    else
                    {
                        utility.MessageBox(this, "Dear " + dr["Fname"].ToString() + " your registered mobile number is invalid !");
                        txtuserid.Text = "";
                    }
                }

            }
            else if (ddltype.SelectedValue == "1")
            {
                utility.MessageBox(this, "Invalid User ID !!");
            }
            else
            {
                utility.MessageBox(this, "Invalid Franchise ID !!");
            }
        }

        catch (Exception ex)
        {

        }
    }
}