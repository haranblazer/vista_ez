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
public partial class admin_adgenology : System.Web.UI.Page
{
    SqlConnection con =null;
    SqlCommand com;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        string str;
        str = Convert.ToString(Session["admin"]);
       
        if (Page.IsPostBack)
        {
            go();
        }
    }
    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {
        if (RadioButton1.Checked)
        {
            txtRegNo.Visible = true;
            //TextBox2.Visible = false;
        }
    }
    protected void RadioButton2_CheckedChanged(object sender, EventArgs e)
    {
        if (RadioButton2.Checked)
        {
            //TextBox2.Visible = true;
            txtRegNo.Visible = true;

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        go();
    }

    public void go()
    {
        try
        {
            string sregno = txtRegNo.Text.Trim();
            txtRegNo.Text = InsertFunction.checkHacked(txtRegNo.Text.Trim());
            if (Regex.Match(sregno, @"^[a-zA-Z0-9]*$").Success)
            {
                if (RadioButton2.Checked)
                {
                    con = new SqlConnection(method.str);
                    com = new SqlCommand("sp_adtreeuname", con);
                    com.CommandType = CommandType.StoredProcedure;

                    com.Parameters.AddWithValue("@AppMstFName", txtRegNo.Text.Trim());
                    con.Open();
                    sdr = com.ExecuteReader();
                    if (sdr.Read())
                    {
                        Session["userId"] = sdr["AppMstregno"].ToString();
                        string userName = sdr["AppMstFName"].ToString();
                        Session.Timeout = 20;
                        //string qstr = "?n=" + userId + "&n1=" + userName + "";
                        Response.Redirect("~/user/direct.aspx", false);
                    }
                    else { utility.MessageBox(this,"User name not found!"); }
                    con.Close();
                }
                else
                {
                    con = new SqlConnection(method.str);
                    com = new SqlCommand("sp_adLogintree", con);
                    com.CommandType = CommandType.StoredProcedure;

                    com.Parameters.AddWithValue("@AppMstID", txtRegNo.Text.Trim());
                    con.Open();
                    sdr = com.ExecuteReader();
                    if (sdr.Read())
                    {
                        Session["userId"] = sdr["AppMstregno"].ToString();
                        string userName = sdr["AppMstFName"].ToString();
                        //Session["userId"] = userId.Trim();

                        Session.Timeout = 20;
                        //string qstr = "?n=" + userId + "&n1=" + userName + "";

                        Response.Redirect("~/user/welcome.aspx", false);

                    }
                    else
                    {
                        utility.MessageBox(this,"Id not found!");
                    } con.Close();
                }
            }
        }
        catch
        {
        }
    }
}