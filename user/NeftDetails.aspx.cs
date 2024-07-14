using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class user_NeftDetails : System.Web.UI.Page
{
    string strajax = "";
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    utility objUtil = null;
    static string joinfor = "0";
    Validation val = new Validation();
    string str1;
    SqlDataReader sdr;

    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            str1 = Convert.ToString(Session["userId"]);
            if (str1 == "")
                Response.Redirect("login.aspx");
            else

                if (!Page.IsPostBack)
                {


                    BindBank();

                    if (Regex.Match(str1, @"^[a-zA-Z0-9]*$").Success)
                    {
                        go();
                    }

                    else
                    {
                        //lblMessage.Text = "INVALID ID";
                    }

                }

        }
        catch
        {

        }
    }

    public void BindBank()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetBank", con);
            com.CommandType = CommandType.StoredProcedure;

            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlBankName.DataSource = dt;
            ddlBankName.DataBind();
            ddlBankName.DataTextField = "BankName";
            ddlBankName.DataValueField = "SrNo";
            ddlBankName.DataBind();

        }
        catch
        {

        }
    }

    private void go()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("NEFTDETAILS", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@sid", str1);
            con.Open();
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {






                //ddlBankName.Items.FindByValue(sdr["BankName"].ToString().ToUpper()).Selected = true;
                ddlBankName.SelectedIndex = ddlBankName.Items.IndexOf(ddlBankName.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["BankName"].ToString(), true) == 0).FirstOrDefault());
                TxtIFS.Text = sdr["IFSCode"].ToString();
                txtname.Text = sdr["AppMstFName"].ToString();
                txtaccountno.Text = sdr["acountno"].ToString();
                //ddlAccType.Items.FindByValue(sdr["type"].ToString().ToUpper()).Selected = true;
                ddlAccType.SelectedIndex = ddlAccType.Items.IndexOf(ddlAccType.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["type"].ToString(), true) == 0).FirstOrDefault());
                txtbranch.Text = sdr["branch"].ToString();
                txtpassword.Text = sdr["appmstpassword"].ToString();
                con.Close();
            }
        }
        catch
        {

        }
    }
    protected void btnupdate_Click(object sender, EventArgs e)
    {
        if (Regex.Match(str1, @"^[a-zA-Z0-9]*$").Success)
        {
            //if (ddlBankName.SelectedIndex != 0)
            //{

            updatedata();



            //}
            //else
            //{
            //    utility.MessageBox(this, "Select Bank !");
            //    ddlBankName.Focus();
            //    return;
            //}
        }

        else
        {
            utility.MessageBox(this, "INVALID ID");
            return;
        }
    }

    private void updatedata()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            //string bankName = "";
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            //if (ddlBankName.SelectedIndex != 0)
            //    bankName = ddlBankName.SelectedValue;

            //else
            //    bankName = "";
            lblMessage.Text = "";
            com = new SqlCommand("userexists", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regno", str1);
            con.Open();
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {
                if (txtpassword.Text.ToLower() == sdr[0].ToString().ToLower())
                {
                    con.Close();
                    DataTable dt = new DataTable();
                    if (dt.Rows.Count >= 0)
                    {
                        con.Close();
                        com = new SqlCommand("NEFTprofile", con);
                        com.CommandType = CommandType.StoredProcedure;
                        com.Parameters.AddWithValue("@AppMstFName", txtname.Text.Trim().ToString());
                        com.Parameters.AddWithValue("@bankname", ddlBankName.SelectedItem.Text.Trim());
                        com.Parameters.AddWithValue("@branch", txtbranch.Text.Trim().ToString());
                        if (!string.IsNullOrEmpty(txtaccountno.Text.Trim()))
                        {
                            string AccountNo = txtaccountno.Text.Trim();
                            int index = AccountNo.IndexOf("#");
                            if (index == 0)
                            {
                                AccountNo = txtaccountno.Text.Trim();
                            }
                            else
                            {
                                AccountNo = "#" + txtaccountno.Text.Trim();
                            }
                            com.Parameters.AddWithValue("@accno", AccountNo);
                        }
                        else
                        {
                            com.Parameters.AddWithValue("@accno", txtaccountno.Text.Trim());
                        }
                       
                        com.Parameters.AddWithValue("@type", ddlAccType.SelectedItem.Text);
                        com.Parameters.AddWithValue("@IFSCode", TxtIFS.Text.Trim().ToString());
                        com.Parameters.AddWithValue("@regno", str1);
                        //com.Parameters.AddWithValue("@pwd", txtpassword.Text);
                        con.Open();
                        com.ExecuteNonQuery();
                        go();
                        utility.MessageBox(this, "NEFT Details has been Updated!");
                        con.Close();
                        txtbranch.Enabled = false;
                        ddlBankName.Enabled = false;
                        ddlAccType.Enabled = false;
                        txtaccountno.Enabled = false;
                        txtname.Enabled = false;
                        TxtIFS.Enabled = false;
                        txtpassword.Enabled = false;
                        btnupdate.Enabled = false;
                    }
                    else
                    {

                    }

                }
            }

        }

        catch { }

    }

}