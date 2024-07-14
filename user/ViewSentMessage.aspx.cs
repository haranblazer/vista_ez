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
public partial class user_ViewSentMessage : System.Web.UI.Page
{
    string mid, frm;
    bool sts;
    SqlConnection con = null;
    SqlCommand com = null;
    SqlDataAdapter da = null;
    DataTable dt = null;
    utility u = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        mid = u.base64Decode(Convert.ToString(Request.QueryString["mid"]));
        lblIP.Text = Request.ServerVariables["REMOTE_HOST"];
        if (string.IsNullOrEmpty(Convert.ToString(Session["UserId"])))
        {
            Response.Redirect("loginagain.aspx");
        }
        if (!Page.IsPostBack)
        {
            BindGrid();
            lnkbtnSend.Visible = false;
            lnkbtnCancel.Visible = false;
            trIP.Visible = false;
        }
    }
    private void BindGrid()
    {
        con = new SqlConnection(method.str);
        dt = new DataTable();

        try
        {
           // da = new SqlDataAdapter("select MessageId,ReceiverId,SenderId,MsgSubject,Msg,convert(varchar(12),DOE,107) as doe,IpAddress,isRead,(select appmstfname+ ' '+appmstlname from appmst where appmstregno=messagemst.ReceiverId) as ReceiverName,(select DIDId from appmst where appmstregno=messagemst.ReceiverId) as ReceiverDID,(select isnull(mobileno,0) from controlmst where username=messagemst.SenderId) as Mobile from messagemst where SentBy='user'  and SenderId=@SenderId and MessageId=@MessageId", con);          
            da = new SqlDataAdapter("select MessageId,ReceiverId,SenderId,MsgSubject,Msg,convert(varchar(12),DOE,107) as doe,IpAddress,isRead,(select isnull(mobileno,0) from controlmst where username=messagemst.SenderId) as Mobile from messagemst where SentBy='user'  and SenderId=@SenderId and MessageId=@MessageId", con);
            da.SelectCommand.Parameters.AddWithValue("@SenderId", Convert.ToString(Session["UserId"]));
            da.SelectCommand.Parameters.AddWithValue("@MessageId", mid);            
            da.SelectCommand.Parameters.AddWithValue("@type", "ms");
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lblDate.Text = dt.Rows[0]["DOE"].ToString();
                lblSenderId.Text = lblName.Text = dt.Rows[0]["SenderId"].ToString();      

                lblMobileNo.Text = dt.Rows[0]["Mobile"].ToString();
                lblSubject.Text = dt.Rows[0]["MsgSubject"].ToString();

                txtMessage.Text = dt.Rows[0]["Msg"].ToString();
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
            con.Dispose();
            dt.Dispose();
            da.Dispose();

        }

    }
    protected void lnkbtnBack_Click(object sender, EventArgs e)
    {

        Response.Redirect("SentMessages.aspx");
    

    }
    protected void lnkbtnReply_Click(object sender, EventArgs e)
    {
        txtMessage.Text = "";
        lnkbtnReply.Visible = false;
        lnkbtnSend.Visible = true;
        lnkbtnCancel.Visible = true;
        trIP.Visible = true;
    }
    protected void lnkbtnSend_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtMessage.Text))
            saveMessage();
        else
            utility.MessageBox(this,"Please Enter Message!");
    }
    private void saveMessage()
    {

        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("saveUserMessage", con);
            com.CommandType = CommandType.StoredProcedure;
            com.CommandTimeout = 999999;
            com.Parameters.AddWithValue("@SenderId", Convert.ToString(Session["UserId"]));
            com.Parameters.AddWithValue("@ReceiverId","0");
            com.Parameters.AddWithValue("@Subject", lblSubject.Text.Trim());
            com.Parameters.AddWithValue("@Msg", txtMessage.Text.Trim());
            com.Parameters.AddWithValue("@IpAddress", lblIP.Text.Trim().ToString());
            con.Open();
            int result = (int)com.ExecuteNonQuery();
            if (result > 0)
            {
                utility.MessageBox(this, "Message sent successfully.");
                txtMessage.Text = string.Empty;
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
    private void sendMail(string name, string emailid)
    {

        try
        {

            string msgtxt = "Dear,<br/> " + name + ",<br/><br/><b>Subject: </b> " + lblSubject.Text.Trim() + "<br/><br/>" + ((Label)Master.FindControl("lblName")).Text + " has sent you message on MLM Union. <br/><br/> please log on to www.mlmunion.in to view the message.<br/><br/><br/><img alt='MLM Union' src='www.mlmunion.in/images/mlm_india.png' style='height: 60px; width: 71px' /><br/>From:<br/>Team MLM Union <br/>www.mlmunion.in";
            u.sendFromGmail(emailid, "You have receieved new message", msgtxt);
            txtMessage.Text = "";
           utility.MessageBox(this,"Message Sent Successfully !");
        }
        catch
        {
            utility.MessageBox(this,"Send failure, Try Again !");
        }
    }
    protected void lnkbtnCancel_Click(object sender, EventArgs e)
    {
        lnkbtnReply.Visible = true;
        lnkbtnSend.Visible = false;
        lnkbtnCancel.Visible = false;
        trIP.Visible = false;
        BindGrid();
    }
}
