using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Web.Mail;
using System.Net;
using System.IO;
using System.Text.RegularExpressions;
using System.Data;
using System.Linq;
using System.Text;

public partial class admin_SendMessageAdmin : System.Web.UI.Page, ICallbackEventHandler
{
    string strajax = "";
    string html = String.Empty;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;   
    utility u = new utility();  
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
            Response.Redirect("adminLog.aspx");
        }
        if (!IsPostBack)
        {
            lblUser.Text = GetSponsorName(txtUserId.Text.Trim());
        }

        string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
        StringBuilder newFunction = new StringBuilder("function ServerSendValue(arg,ctx){" + js + "}");
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        checkvalue();
        
    }
    private void checkvalue()
    {
        if (txtSubject.Text.Trim().Length <= 0)
        {
            utility.MessageBox(this, "Please enter the subject");
            return;
        }
        if (txtMessage.Text.Trim().Length <= 0)
        {
            utility.MessageBox(this, "Please enter the message");
            return;
        }
        saveMessage();
        
    }
    private void saveMessage()
    {
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("saveAdminMessage", con);
            com.CommandType = CommandType.StoredProcedure;
            com.CommandTimeout = 999999;
            com.Parameters.AddWithValue("@SenderId", (string)Session["admin"]);
            com.Parameters.AddWithValue("@ReceiverId", txtUserId.Text);
            com.Parameters.AddWithValue("@Subject", txtSubject.Text.Trim());
            com.Parameters.AddWithValue("@Msg", txtMessage.Text.Trim());
            com.Parameters.AddWithValue("@IpAddress", Request.ServerVariables["REMOTE_HOST"]);
            com.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            int result = Convert.ToInt32(com.Parameters["@flag"].Value.ToString());
            if (result ==1)
            {
                utility.MessageBox(this, "Message sent successfully");
                cleartext();
            }
            else if (result == 11)
            {
                utility.MessageBox(this, "ID / User Id does not exists.");
            }
            else
            {
            }
        }
        catch
        {

        }
        finally
        {
            con.Close();
            con.Dispose();
            com.Dispose();
        }
    }
   
    private void cleartext()
    {
        txtMessage.Text = txtSubject.Text =txtUserId.Text= string.Empty;
    }

    private string GetSponsorName(string regno)
    {
        string name = string.Empty;
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("select appmstfname from AppMst where AppMstRegNo=@regno", con);
            com.Parameters.AddWithValue("@regno", regno.Trim());
            con.Open();
            name = com.ExecuteScalar().ToString();
            con.Close();
        }
        catch
        {
        }
        return name;

    }

    #region (ICallbackEventHandlar Methods..)
    public string GetCallbackResult()
    {
        return strajax;
    }

    public void RaiseCallbackEvent(string eventArguments)
    {
        if (eventArguments != "")
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand();
            SqlDataReader dr;
            cmd.CommandText = "select appmsttitle+space(1)+appmstfname as name from appmst where appmstregno=@regno";
            cmd.Parameters.AddWithValue("@regno", eventArguments.Trim());
            cmd.Connection = con;
            con.Open();
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
    
}
