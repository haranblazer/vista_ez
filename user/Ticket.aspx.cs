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
using System.ServiceModel.Configuration;

public partial class user_Messages : System.Web.UI.Page
{
    SqlConnection con=null;
    SqlDataAdapter da=null;
    DataTable dt = null;
    utility u = new utility();
    SqlCommand com;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Convert.ToString(Session["userId"])))
        {
            Response.Redirect("~/login.aspx");
        }
        if (!Page.IsPostBack)
        {
            BindTicketType();
            BindGrid();
           // clearMessages();
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
    private void BindTicketType()
    {
        using(SqlConnection con = new SqlConnection(method.str))
        {
            SqlDataAdapter sda = new SqlDataAdapter("Select * from TicketRouter", con);
            dt = new DataTable();
            sda.SelectCommand.CommandType = CommandType.Text;
            sda.Fill(dt);
            ddl_ticketType.DataSource = dt;
            ddl_ticketType.DataBind();
            ddl_ticketType.Items.Insert(0, new ListItem("Select", ""));
            ViewState["dtType"] = dt;
        }
    }
    private void BindGrid()
    {
        con = new SqlConnection(method.str);
        dt = new DataTable();
        ViewState["dt"] = null;
            try
            {
                da = new SqlDataAdapter("ManageTickets", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.SelectCommand.Parameters.AddWithValue("@TranType", "SELECT");
                //da.SelectCommand.Parameters.AddWithValue("@ReceiverId", Convert.ToString(Session["userId"]));
                //da.SelectCommand.Parameters.AddWithValue("@isDeleted", false);               
                //da.SelectCommand.Parameters.AddWithValue("@type", "cl");
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
                    //utility.MessageBox(this,"No Message Found!");                    
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
        BindGrid();
    }
    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    lblMsg.Text = string.Empty;
    //    Search();
    //}
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    { 
        if ((e.CommandName == "SenderName") || (e.CommandName == "Subject") || (e.CommandName == "doe"))
        {          
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            string mid = GridView1.DataKeys[row.RowIndex].Value.ToString();
            Response.Redirect("ViewMessage.aspx?mid=" + u.base64Encode(mid) + "&frm=" + u.base64Encode("m"));
        }
    }
    protected void lnkbtnDelete_Click(object sender, EventArgs e)
    {
        //txtSearch.Text = string.Empty;
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
                    BindGrid();
                   utility.MessageBox(this,"Message Deleted Successfully !");
                }
                
            }          
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
       // txtSearch.Text=lblMsg.Text = string.Empty;      
        BindGrid();
    }
    protected void lnkbtnDeletedMessages_Click(object sender, EventArgs e)
    {
        //txtSearch.Text = string.Empty;
        Response.Redirect("DeletedMessages.aspx",false);
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
                img.ImageUrl = "images/envelop_open.png";
                lnkbtnSenderName.Font.Bold = false;
                lnkbtnSubject.Font.Bold = false;
                lnkbtnDOE.Font.Bold = false;
            }
            else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isRead")) == "False")
            {
                img.ImageUrl = "images/envelop_closed.png";
                lnkbtnSenderName.Font.Bold = true;
                lnkbtnSubject.Font.Bold = true;
                lnkbtnDOE.Font.Bold = true;
            }
            else
            {
            }
        }
    }
    private void Search()
    {
        if (ViewState["dt"] != null)
        {
            DataTable s_dt = (DataTable)ViewState["dt"];
            DataRow[] dr = s_dt.Select("MsgSubject like '%*%'");
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
    protected void lnkbtnReadMessages_Click(object sender, EventArgs e)
    {
        //txtSearch.Text =lblMsg.Text = string.Empty;      
        BindGridReadUnRead(true);
    }
    protected void lnkbtnUnReadMessages_Click(object sender, EventArgs e)
    {
       // txtSearch.Text = lblMsg.Text = string.Empty;  
        BindGridReadUnRead(false);
    }
    private void BindGridReadUnRead(bool isRead)
    {
        con = new SqlConnection(method.str);
        dt = new DataTable();
        ViewState["dt"] = null;
        try
        {
            da = new SqlDataAdapter("getUserMessageList", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@ReceiverId", Convert.ToString(Session["UserId"]));
            da.SelectCommand.Parameters.AddWithValue("@isRead", isRead);
            da.SelectCommand.Parameters.AddWithValue("@isDeleted", false);
            da.SelectCommand.Parameters.AddWithValue("@type", "clru");            
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ViewState["dt"] =dt;    
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
                    utility.MessageBox(this,"Please Select Message !");
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
        //txtSearch.Text = lblMsg.Text = string.Empty;  
        BindGridReadUnRead(false);
    }
    protected void ImageButton5_Click(object sender, ImageClickEventArgs e)
    {
        lblMsg.Text = string.Empty;
        BindGrid();
    }
   
    protected void lnkbtnSentMessages_Click1(object sender, EventArgs e)
    {
        Response.Redirect("SentMessages.aspx", false);
    }

    protected void btnCreate_Click(object sender, EventArgs e)
    {
        int type = Conver.ToInt32(ddl_ticketType.SelectedValue)ch;
        string desc = txtProblemDesc.Text;
        DataTable dtType = (DataTable)ViewState["dtType"];
        DataRow[] dr = dtType.Select("ID=" + type);
        string assignedTo = dr[0]["ControlBy"].ToString();
        using (SqlConnection conn = new SqlConnection(method.str))
        {
            SqlCommand cmd = new SqlCommand("ManageTickets", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@TranType", "ADD");
            cmd.Parameters.AddWithValue("@ticketType", type);



        }
    }
}
