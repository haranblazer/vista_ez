using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.IO;

public partial class contact_us : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    utility util = new utility();
    string body;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindState();
        }
    }
    private void AddContact()
    {
        try
        {
            if (!string.IsNullOrEmpty(txtName.Text.Trim()) && IsAlphabets(txtName.Text.Trim()))
            {
                if (!string.IsNullOrEmpty(txt_City.Text.Trim()))
                {

                    if (!string.IsNullOrEmpty(txtMobile.Text.Trim()) && IsValidMobile(txtMobile.Text.Trim()))
                    {

                        if (!string.IsNullOrEmpty(txt_Pincode.Text.Trim()) && IsAlphabets(txt_Pincode.Text.Trim()))
                        {

                            if (!string.IsNullOrEmpty(txtMsg.Text.Trim()))
                            {

                                cmd = new SqlCommand("InsertEnquiry", con);
                                cmd.CommandTimeout = 2000;
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                                cmd.Parameters.AddWithValue("@Email", DdlState.SelectedItem.ToString());
                                cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                                cmd.Parameters.AddWithValue("@Subject", ddlDistrict.SelectedItem.ToString());
                                cmd.Parameters.AddWithValue("@remarks", txtMsg.Text.Trim());
                                cmd.Parameters.AddWithValue("@entrytype", 1);

                                //cmd.Parameters.AddWithValue("@status", 1);
                                //cmd.Parameters.AddWithValue("@flag", SqlDbType.VarChar).Direction = ParameterDirection.Output;
                                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;

                                con.Open();
                                int result = cmd.ExecuteNonQuery();
                                string enqid = cmd.Parameters["@flag"].Value.ToString();
                                con.Close();
                                if (result == 1)
                                {

                                    string usermsg = "Dear," + " " + txtName.Text.Trim() + " " + "Your Enquiry has been sent with EnqId " + enqid + " we will revert you soon.";
                                    util.sendSMSByPage(txtMobile.Text.Trim(), usermsg);
                                    //PopulateBody(enqid, txtName.Text, txt_City.Text, txtMsg.Text);
                                    utility.MessageBox(this, "Query has been sent successfully.");
                                    txtName.Text = txt_City.Text = txtMobile.Text = txt_Pincode.Text = txtMsg.Text = string.Empty;
                                }
                            }
                            else
                            {
                                utility.MessageBox(this, "The message is required and can't be empty.");
                                txtMsg.Focus();
                                return;
                            }

                        }
                        else
                        {
                            utility.MessageBox(this, "The subject is required and Contains alphabetic value.");
                            txt_Pincode.Focus();
                            return;
                        }

                    }
                    else
                    {

                        utility.MessageBox(this, "The mobile no. is required and should be valid Mobile No.");
                        txtMobile.Focus();
                        return;
                    }


                }
                else
                {

                    utility.MessageBox(this, "The e-mail is required and should be valid e-mail address.");
                    txt_City.Focus();
                    return;
                }


            }
            else
            {
                utility.MessageBox(this, "The name is required and Contains alphabetic value.");
                txtName.Focus();
                return;
            }
        }
        catch
        {

            utility.MessageBox(this, "Couldn't Sent.");
            con.Close();
            con.Dispose();
            return;
        }
    }

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDistrict(DdlState.SelectedValue);
    }

    public void BindState()
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[] { };
        DataTable dt = objDu.GetDataTableSP(param1, "GetState");
        DdlState.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            DdlState.DataSource = dt;
            DdlState.DataTextField = "StateName";
            DdlState.DataValueField = "SId";
            DdlState.DataBind();
            DdlState.Items.Insert(0, new ListItem("Select State", ""));
        }
        else
        {
            DdlState.Items.Insert(0, new ListItem("Select State", ""));
        }
        ddlDistrict.Items.Clear();
        ddlDistrict.Items.Insert(0, new ListItem("Select District", ""));
    }

    public void BindDistrict(string value)
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("GetStateDistrict", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@state", value);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddlDistrict.DataSource = dt;
                ddlDistrict.Items.Clear();
                ddlDistrict.DataTextField = "DistrictName";
                ddlDistrict.DataValueField = "Id";
                ddlDistrict.DataBind();
                ddlDistrict.Items.Insert(0, new ListItem("Select District", ""));
            }
            else
            {
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, new ListItem("Select District", ""));
            }
        }
        catch
        {
        }
    }

    public Boolean IsAlphabets(string str)
    {
        if (Regex.Match(str, @"^[a-zA-Z][a-zA-Z\s]*$").Success)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public Boolean IsValidEmail(string str)
    {
        if (Regex.Match(str, @"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$").Success)
        {
            return true;

        }
        else
        {
            return false;
        }
    }

    public Boolean IsValidMobile(string str)
    {
        if (Regex.Match(str, @"^[6-9]\d{9}$").Success)
        {

            return true;
        }
        else
        {
            return false;
        }

    }

    private void PopulateBody(string enqid, string name, string email, string msg)
    {
        try
        {
            string ActivationUrl;
            ActivationUrl = "http://eksbd.com";
            WebRequest request = WebRequest.Create("http://eksbd.com/Mailer/EnquiryQ.htm");
            WebResponse response = request.GetResponse();
            Stream data = response.GetResponseStream();
            using (StreamReader sr = new StreamReader(data))
            {
                body = sr.ReadToEnd();
            }
            body = body.Replace("dt", DateTime.Now.ToString("dd/MM/yyyy"));
            body = body.Replace("{qst}", msg);
            body = body.Replace("Enqid", enqid);
            body = body.Replace("{Name}", name);
            body = body.Replace("{cn}", util.companyname().AsEnumerable().FirstOrDefault().Field<string>("companyname"));
            //body = body.Replace("{cmpeml}", util.companyname().AsEnumerable().FirstOrDefault().Field<string>("noreply"));
            body = body.Replace("{Link}", "<a href='" + ActivationUrl + "'>Click here for visit site</a>");
            util.SendbyZoho(email, "EKSBD : Enquiry Details", body);
        }
        catch
        {

        }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        AddContact();
    }

    
}