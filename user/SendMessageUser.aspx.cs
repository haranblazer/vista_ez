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

public partial class user_SendMessageUser : System.Web.UI.Page
{
    
    string html = String.Empty;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;   
    utility u = new utility();  
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.Checklogin();       
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
            com = new SqlCommand("saveUserMessage", con);
            com.CommandType = CommandType.StoredProcedure;
            com.CommandTimeout = 999999;
            com.Parameters.AddWithValue("@SenderId", Convert.ToString(Session["userId"]));
            com.Parameters.AddWithValue("@ReceiverId", "0");           
            com.Parameters.AddWithValue("@Subject", txtSubject.Text.Trim());
            com.Parameters.AddWithValue("@Msg", txtMessage.Text.Trim());
            com.Parameters.AddWithValue("@IpAddress", Request.ServerVariables["REMOTE_HOST"]);
            com.Parameters.AddWithValue("@isret",0);
            con.Open();
            int result = (int)com.ExecuteNonQuery();
            if (result > 0)
            {
                utility.MessageBox(this, "Message sent successfully");
                cleartext();
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
        txtMessage.Text = txtSubject.Text = string.Empty;
    }
    
}
