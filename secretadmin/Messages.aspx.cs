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

using System.Collections.Generic;
public partial class user_Messages : System.Web.UI.Page
{
    string mid, frm;
    SqlConnection con=null;
    SqlDataAdapter da=null;
    DataTable dt = null;
    utility u = new utility();
    SqlCommand com;
    
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
        if (!Page.IsPostBack)
        {
            Tblid1.Visible = true;
            Tblid2.Visible = false;
            BindGrid();
            clearMessages();
        }
        
    }
    public void clearMessages()
    {

        com = new SqlCommand("deleteMessage", con);
        com.CommandType = CommandType.StoredProcedure;       
        try
        {
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
        }
        catch
        {
        }
    }
    private void BindGrid()
    {
        con = new SqlConnection(method.str);
        dt = new DataTable();       
        ViewState["dt"] = null;        
            try
            {
                da = new SqlDataAdapter("getAdminMessageList", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.SelectCommand.Parameters.AddWithValue("@isDeleted", false);               
                da.SelectCommand.Parameters.AddWithValue("@type", "cl");
                da.Fill(dt);
                if (dt.Rows.Count >0)
                {
                    ViewState["dt"] = dt;
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                else
                {
                    ViewState["dt"] = null;
                    utility.MessageBox(this,"No Message Found!");                    
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                   
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
   

 
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        if (txtSearch.Text.Trim() != "")
            Search();
        else
            BindGrid();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;
        Search();
    }
    private void Search()
    {
        if (ViewState["dt"] != null)
        {            
            DataTable s_dt = (DataTable)ViewState["dt"];
            DataRow[] dr = s_dt.Select("SenderId = '" + txtSearch.Text + "' or SenderDID= '" + txtSearch.Text + "'");
            if (dr.Length > 0)
            {
                GridView1.DataSource = dr.CopyToDataTable();
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        else
            utility.MessageBox(this, "No data found!");
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    { 
        if ((e.CommandName == "SenderName") || (e.CommandName == "Subject") || (e.CommandName == "doe"))
        {          
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            string mid = GridView1.DataKeys[row.RowIndex].Value.ToString();
            BindGridView (mid, "m");
            //Response.Redirect("ViewMessage.aspx?mid=" + u.base64Encode(mid) + "&frm=" + u.base64Encode("m"));
        }
    }
    protected void lnkbtnDelete_Click(object sender, EventArgs e)
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter();
        dt = new DataTable();
        try
        {
            foreach (GridViewRow gr in GridView1.Rows)
            {
                CheckBox Rchkbox = (CheckBox)gr.FindControl("deleteRec");
                HiddenField hdnfld = (HiddenField)gr.FindControl("hdnfldMessageId");
                if (Rchkbox.Checked)
                {
                    da = new SqlDataAdapter("update messagemst set isDeleted=1 where MessageId='" + hdnfld.Value.ToString() + "'", con);
                    da.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    utility.MessageBox(this,"Message Deleted Successfully !");

                }
                
            }
            BindGrid();
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            da.Dispose();
            dt.Dispose();
        }

    }
    protected void lnkbtnMessageBox_Click(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;
        ViewState["isAllSearch"] = "1";
        BindGrid();
    }
    protected void lnkbtnDeletedMessages_Click(object sender, EventArgs e)
    {
        Response.Redirect("DeletedMessages.aspx");
    }



    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image img = (Image)e.Row.FindControl("imgStatus");
            LinkButton lnkbtnSenderName = (LinkButton)e.Row.FindControl("lnkbtnSenderName");
            LinkButton lnkbtnSubject = (LinkButton)e.Row.FindControl("lnkbtnSubject");
            LinkButton lnkbtnDOE = (LinkButton)e.Row.FindControl("lnkbtnDOE");
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isRead")) == "True")
            {
                img.ImageUrl = "~/user/images/envelop_open.png";
                //lnkbtnSenderName.Font.Bold = false;
                //lnkbtnSubject.Font.Bold = false;
                //lnkbtnDOE.Font.Bold = false;
            }
            else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isRead")) == "False")
            {
                img.ImageUrl = "~/user/images/envelop_closed.png";
                //lnkbtnSenderName.Font.Bold = true;
                //lnkbtnSubject.Font.Bold = true;
                //lnkbtnDOE.Font.Bold = true;
            }
            else
            {
            }
        }
    }
    protected void lnkbtnReadMessages_Click(object sender, EventArgs e)
    {
        txtSearch.Text = lblMsg.Text = string.Empty;            
        BindGridReadUnRead(true);
    }
    protected void lnkbtnUnReadMessages_Click(object sender, EventArgs e)
    {
        txtSearch.Text = lblMsg.Text = string.Empty;    
        BindGridReadUnRead(false);
    }
    private void BindGridReadUnRead(bool isRead)
    {
        con = new SqlConnection(method.str);
        dt = new DataTable();
        ViewState["dt"] = null;
        try
        {
            da = new SqlDataAdapter("getAdminMessageList", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;           
            da.SelectCommand.Parameters.AddWithValue("@isRead", isRead);
            da.SelectCommand.Parameters.AddWithValue("@isDeleted", false);               
            da.SelectCommand.Parameters.AddWithValue("@type", "clru");
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ViewState["dt"] = dt;
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                ViewState["dt"] = null;
                utility.MessageBox(this,"No Message Found!");
                GridView1.DataSource = null;
                GridView1.DataBind();

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
 
   
    protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("SendMessageAdmin.aspx", false);
    }
    protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter();
        dt = new DataTable();
        try
        {
            foreach (GridViewRow gr in GridView1.Rows)
            {
                CheckBox Rchkbox = (CheckBox)gr.FindControl("deleteRec");
                HiddenField hdnfld = (HiddenField)gr.FindControl("hdnfldMessageId");
                if (Rchkbox.Checked)
                {
                    da = new SqlDataAdapter("update messagemst set isDeleted=1 where MessageId='" + hdnfld.Value.ToString() + "'", con);
                    da.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                   utility.MessageBox(this,"Message Deleted Successfully !");

                }
                else
                {
                    utility.MessageBox(this, "Please Select Message !");
                }
            }
            BindGrid();
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            da.Dispose();
            dt.Dispose();
        }

    }
    protected void ImageButton6_Click(object sender, ImageClickEventArgs e)
    {
        txtSearch.Text = lblMsg.Text = string.Empty;      
        BindGridReadUnRead(false);
    }
    protected void ImageButton5_Click(object sender, ImageClickEventArgs e)
    {
        lblMsg.Text = string.Empty;       
        BindGrid();
    }
    protected void lnkbtnCompose_Click(object sender, EventArgs e)
    {
        Response.Redirect("SendMessageAdmin.aspx", false);
    }
    protected void lnkbtnSentMessages_Click1(object sender, EventArgs e)
    {
        Response.Redirect("SentMessages.aspx", false);
    }

    /////////////////////////**************************************************************************************************
    private void BindGridView(string mid, string frm)
    {
        Tblid1.Visible = false;
        Tblid2.Visible = true;
        lnkbtnSend.Visible = false;
        lnkbtnCancel.Visible = false;
        trIP.Visible = false;
        lblIP.Text = Request.ServerVariables["REMOTE_HOST"];
        con = new SqlConnection(method.str);
        dt = new DataTable();

        try
        {
            da = new SqlDataAdapter("getAdminMessageList", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@MessageId", mid);
            da.SelectCommand.Parameters.AddWithValue("@type", "ms");
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lblDate.Text = dt.Rows[0]["DOE"].ToString();
                lblName.Text = dt.Rows[0]["SenderName"].ToString();
                lblSenderId.Text = dt.Rows[0]["SenderId"].ToString();
                lblReceiver.Text = dt.Rows[0]["ReceiverId"].ToString();
                lblEMailId.Text = dt.Rows[0]["EMailId"].ToString();
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
        Tblid1.Visible = true;
        Tblid2.Visible = false;
        if (frm == "m")
        {
            Response.Redirect("Messages.aspx");
        }
        else if (frm == "dm")
        {
            Response.Redirect("DeletedMessages.aspx");
        }

    }
    protected void lnkbtnReply_Click(object sender, EventArgs e)
    {
        txtMessage.Text = string.Empty;
        lnkbtnReply.Visible = false;
        lnkbtnSend.Visible = lnkbtnCancel.Visible = trIP.Visible = true;
    }
    protected void lnkbtnSend_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtMessage.Text))
            saveMessage();
        else
            utility.MessageBox(this, "Please Enter Message!");
    }
    private void saveMessage()
    {

        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("saveAdminMessage", con);
            com.CommandType = CommandType.StoredProcedure;
            com.CommandTimeout = 999999;
            com.Parameters.AddWithValue("@SenderId", (string)Session["admin"]);
            com.Parameters.AddWithValue("@ReceiverId", lblSenderId.Text);
            com.Parameters.AddWithValue("@Subject", lblSubject.Text.Trim());
            com.Parameters.AddWithValue("@Msg", txtMessage.Text.Trim());
            com.Parameters.AddWithValue("@IpAddress", lblIP.Text.Trim().ToString());
            com.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            int result = Convert.ToInt32(com.Parameters["@flag"].Value.ToString());
            if (result == 1)
            {
                utility.MessageBox(this, "Message sent successfully");
                txtMessage.Text = string.Empty;
            }
            else if (result == 11)
            {
                utility.MessageBox(this, "DID / User Id does not exists.");
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
            u.sendFromGmail(emailid, "You have receieved a new message", msgtxt);
            txtMessage.Text = string.Empty;
            utility.MessageBox(this, "Message Sent Successfully !");
        }
        catch
        {
            utility.MessageBox(this, "Send failure, Try Again !");
        }
    }
    protected void lnkbtnCancel_Click(object sender, EventArgs e)
    {
        Tblid1.Visible = true;
        Tblid2.Visible = false;
        lnkbtnReply.Visible = true;
        lnkbtnSend.Visible = false;
        lnkbtnCancel.Visible = false;
        trIP.Visible = false;
       // BindGridView(mid, "m");
    }
}
