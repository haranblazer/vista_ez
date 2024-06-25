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
public partial class user_SentMessages : System.Web.UI.Page
{
    SqlCommand com = null;
    SqlConnection con = null;
    SqlDataAdapter da = null;
    DataTable dt = null;
    utility u = new utility();
    string mid, frm;
    bool sts;
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
        }

    }
    private void BindGrid()
    {
        con = new SqlConnection(method.str);
        dt = new DataTable();
        ViewState["dt"] = null;        
        try
        {
            da = new SqlDataAdapter("sentadmin", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@sid", (string)Session["admin"]);          
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
    private void Search()
    {
        if (ViewState["dt"] != null)
        {
            if (txtSearch.Text == "")
            {
                utility.MessageBox(this,"Please enter receiver id !");
                return;
            }
            var s_dt = ((DataTable)ViewState["dt"]).AsEnumerable();
           // DataRow[] dr = s_dt.Select("ReceiverId="+ txtSearch.Text.Trim());
            var q = from row in s_dt where row.Field<string>("ReceiverId") == txtSearch.Text.Trim() select new { MessageId = row.Field<int>("MessageId"), ReceiverId = row.Field<string>("ReceiverId"), SenderId = row.Field<string>("SenderId"), ReceiverName = row.Field<string>("ReceiverName"), MsgSubject = row.Field<string>("MsgSubject"), doe = row.Field<string>("doe") };
            GridView1.DataSource = q;
            GridView1.DataBind();
           
        }
        else
            utility.MessageBox(this, "No data found!");
    }


    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;        
        Search();
       
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if ((e.CommandName == "DID") || (e.CommandName == "Id") || (e.CommandName == "ReceiverName") || (e.CommandName == "Subject") || (e.CommandName == "doe"))
        {
            int rowindex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GridView1.Rows[rowindex];
            HiddenField hdnfld = (HiddenField)row.FindControl("hdnfldMessageId");
            BindGridView(hdnfld.Value.ToString());
           // Response.Redirect("ViewSentMessage.aspx?mid=" + u.base64Encode(hdnfld.Value.ToString()));
        }

    }

    protected void lnkbtnMessageBox_Click(object sender, EventArgs e)
    {
        Response.Redirect("Messages.aspx");

    }
   ////****************************************************************////////////////*************************************************************
    private void BindGridView(string mid)
    {
        lblIP.Text = Request.ServerVariables["REMOTE_HOST"];
        lnkbtnSend.Visible = false;
        lnkbtnCancel.Visible = false;
        trIP.Visible = false;
        Tblid1.Visible = false;
        Tblid2.Visible = true;
        con = new SqlConnection(method.str);
        dt = new DataTable();

        try
        {
            da = new SqlDataAdapter("select MessageId,ReceiverId,(select appmstfname+' '+appmstlname from appmst where appmstregno=messagemst.ReceiverId) as ReceiverName,SenderId,MsgSubject,Msg,convert(varchar(12),DOE,107) as doe,IpAddress,isRead from messagemst where SentBy='admin' and  MessageId=@MessageId", con);
            da.SelectCommand.Parameters.AddWithValue("@MessageId", mid);

            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lblDate.Text = dt.Rows[0]["DOE"].ToString();
                lblSenderId.Text = dt.Rows[0]["SenderId"].ToString();
                lblSentTo.Text = dt.Rows[0]["ReceiverId"].ToString();
                lblSentToName.Text = dt.Rows[0]["ReceiverName"].ToString();
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
            com.Parameters.AddWithValue("@ReceiverId", lblSentTo.Text);
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
            u.sendFromGmail(emailid, "You have receieved new message", msgtxt);
            txtMessage.Text = "";
            utility.MessageBox(this, "Message Sent Succressfully !");
        }
        catch
        {
            utility.MessageBox(this, "Send failure, Try Again !");
        }
    }
    protected void lnkbtnCancel_Click(object sender, EventArgs e)
    {
        lnkbtnReply.Visible = true;
        lnkbtnSend.Visible = false;
        lnkbtnCancel.Visible = false;
        trIP.Visible = false;
        Tblid1.Visible = true;
        Tblid2.Visible = false;
    }

}
