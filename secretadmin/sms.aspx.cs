using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Net;
using System.IO;
using System.Text;
using System.Net.Mail;
using System.Text.RegularExpressions;

public partial class tohadmin_sms : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    utility objUtility = new utility();
    WebClient client = new WebClient();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            InsertFunction.CheckSuperAdminlogin();
            getSMSCredit();
            trState.Attributes.Add("style", "display:none");
            trTextInput.Attributes.Add("style", "display:none");
            trTextMultiple.Attributes.Add("style", "display:block");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if ((ddlList.SelectedValue.ToString() == "1"))
        {
            if (!txtMultiple.Text.Contains(","))
            {
                if (Regex.Match(txtMultiple.Text, @"^[0-9]*$").Success)
                {
                    if ((txtMultiple.Text.Trim().Length > 9) && (txtMultiple.Text.Trim().Length < 11))
                    {
                        sendSMS("Mobile");
                    }
                    else
                        lblMsg.Text = "Please Enter 10 Digit Mobile Number!";
                }
                else
                {
                    lblMsg.Text = "Invalid Mobile Number!";
                }
            }
            else
            {
                sendSMS("Mobile");
            }
        }
        else if ((ddlList.SelectedValue.ToString() == "3"))
        {
            sendSMS("a");
        }
        else if ((ddlList.SelectedValue.ToString() == "2") || (ddlList.SelectedValue.ToString() == "4"))
        {
            if (!string.IsNullOrEmpty(txtInput.Text.Trim()))
            {
                if (Regex.Match(txtInput.Text, @"^[a-zA-Z0-9]*$").Success)
                {
                    try
                    {
                        sendSMS(ddlList.SelectedValue.ToString() == "2" ? "s" : "d");
                    }
                    catch (Exception ex)
                    {
                        lblMsg.Text = "Message couldn't sent,Please try later!";
                    }
                }
                else
                {
                    lblMsg.Text = "Only Alpha Numeric Value Is Allowed!";
                }
            }
            else
            {
                lblMsg.Text = "Please Enter User Name !";
            }
        }
        else if (ddlList.SelectedValue.ToString() == "5")
        {
            if (!string.IsNullOrEmpty(txtInput.Text.Trim()))
            {
                if (Regex.Match(txtInput.Text, @"^[0-9]*$").Success)
                {
                    try
                    {
                        sendSMS("p");
                    }
                    catch
                    {
                        lblMsg.Text = "Message couldn't sent,Please try later!";
                    }
                }
                else
                {
                    lblMsg.Text = "Only Numeric Value Is Allowed For Payout Number!";
                }
            }
            else
            {
                lblMsg.Text = "Please Enter Payout Number!";
            }
        }
        else if (ddlList.SelectedValue.ToString() == "6")
        {
            if (ddlState.SelectedIndex != 0)
            {
                try
                {
                    sendSMS("state");
                }
                catch
                {
                    lblMsg.Text = "Message couldn't sent,Please try later!";
                }
            }
            else
            {
                lblMsg.Text = "Please Select State!";
            }
        }
        else if ((ddlList.SelectedValue.ToString() == "7"))
        {
            sendSMS("pm");
        }

        setControlsVisibility();
        getSMSCredit();
    }
    public void setControlsVisibility()
    {
        if (ddlList.SelectedValue == "1")
        {
            trState.Attributes.Add("style", "display:none");
            trTextInput.Attributes.Add("style", "display:none");
            trTextMultiple.Attributes.Add("style", "display:block");
        }
        else if ((ddlList.SelectedValue == "2") || (ddlList.SelectedValue == "4") || (ddlList.SelectedValue == "5") )
        {
            trState.Attributes.Add("style", "display:none");
            trTextInput.Attributes.Add("style", "display:block");
            trTextMultiple.Attributes.Add("style", "display:none");
        }
        else if ((ddlList.SelectedValue == "3")|| (ddlList.SelectedValue == "7"))
        {
            trState.Attributes.Add("style", "display:none");
            trTextInput.Attributes.Add("style", "display:none");
            trTextMultiple.Attributes.Add("style", "display:none");
        }
        else
        {
            trState.Attributes.Add("style", "display:block");
            trTextInput.Attributes.Add("style", "display:none");
            trTextMultiple.Attributes.Add("style", "display:none");
            //txtInput.MaxLength 
        }
    }

    public void sendSMS(string type)
    {
        if (!string.IsNullOrEmpty(txtMessage.Text.Trim()))
        {
            if (type == "Mobile")
            {
                try
                {
                    SqlCommand com = new SqlCommand("SendBulkSMS", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandTimeout = 999999999;
                    com.Parameters.AddWithValue("@Input", "");
                    com.Parameters.AddWithValue("@Type", type);
                    com.Parameters.AddWithValue("@mobiles", txtMultiple.Text.Trim());
                    com.Parameters.AddWithValue("@text", txtMessage.Text);
                    com.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;

                    con.Open();
                    com.ExecuteNonQuery();
                    int msg = Convert.ToInt32(com.Parameters["@flag"].Value.ToString());

                    if (msg == 1)
                    {
                        lblMsg.Text = "SMS sentsuccessfully";
                        txtInput.Text = txtMessage.Text = txtMultiple.Text= string.Empty;
                    }
                    //DataTable dt = new DataTable();
                    //con.Open();
                    //SqlDataReader reader = com.ExecuteReader();
                    //dt.Load(reader);
                    //string retrn = "";
                    //con.Close();
                    //string text = string.Empty;

                    //foreach (DataRow drow in dt.Rows)
                    //{
                    //    text = "Dear, " + drow["MemberName"].ToString() + ", " + txtMessage.Text.Trim();
                    //    if (objUtility.sendSMSByPage(drow["AppMstMobile"].ToString(), text) > 0)
                    //        retrn = "1";
                    //    //string retrn = com.Parameters["@flag"].Value.ToString();
                    //}
                    //if (retrn == "1")
                    //{
                    //    txtMultiple.Text = txtMessage.Text = string.Empty;
                    //    lblMsg.Text = "Message Sent Successfully!";
                    //}
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                    lblMsg.Text = "Message couldn't sent,Please try later!";
                }
            }
            else
            {
                try
                {
                    //SendBulkSMS(@Input varchar(50)=null,@type varchar(50),@mobiles varchar(8000),@text varchar(300),@flag int out)
                    SqlCommand com = new SqlCommand("SendBulkSMS", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandTimeout = 999999999;
                    com.Parameters.AddWithValue("@Input", type == "state" ? ddlState.SelectedItem.Text.ToString() : txtInput.Text.Trim());
                    com.Parameters.AddWithValue("@Type", type);
                    com.Parameters.AddWithValue("@mobiles", "");
                    com.Parameters.AddWithValue("@text", txtMessage.Text);
                    com.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                    con.Open();
                    com.ExecuteNonQuery();
                    int msg =Convert.ToInt32(com.Parameters["@flag"].Value.ToString());

                    if (msg == 1)
                    {
                        lblMsg.Text = "SMS sentsuccessfully";
                        txtInput.Text = txtMessage.Text = txtMultiple.Text = string.Empty;
                    }
                }


                catch(Exception ex)
                {

                    Response.Write(ex.Message);
                    lblMsg.Text = "Message couldn't sent,Please try later!";
                }
                //    DataTable dt = new DataTable();
                //    con.Open();
                //    SqlDataReader reader = com.ExecuteReader();
                //    dt.Load(reader);
                //    string retrn = "";
                //    con.Close();
                //    string text = string.Empty;

                //    foreach (DataRow drow in dt.Rows)
                //    {
                //        //Dear #VAL# Req #VAL# from#VAL# Thanks
                //        text = "Dear " + drow["MemberName"].ToString() + " Req " + txtMessage.Text.Trim();
                //        if (objUtility.sendSMSByPage1(drow["AppMstMobile"].ToString(), text) > 0)
                //            retrn = "1";
                //        //string retrn = com.Parameters["@flag"].Value.ToString();

                //    }
                //    if (retrn == "1")
                //    {
                //        lblMsg.Text = "SMS sentsuccessfully";
                //        txtInput.Text = txtMessage.Text = string.Empty;
                //    }
                //    else
                //    {
                //        if (type == "p")
                //            lblMsg.Text = "Payout of this  number has not calculated!";
                //        else if (type == "state")
                //            lblMsg.Text = "No Member Found In This State!";
                //        else
                //            lblMsg.Text = "Invalid Registration Number!";
                //    }
                //}
                //catch (Exception ex)
                //{
                //}
            }
        }
        else
            lblMsg.Text = "Please Enter Message!";

    }

    private void getSMSCredit()
    {

        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("select SMSCredit from paymentmst", con);
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lblSMS.Text = "SMS credit is " + Convert.ToString(dr["SMSCredit"]);
        }
        con.Close();
    }
}
