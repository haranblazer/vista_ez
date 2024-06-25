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
public partial class user_DeletedMessages : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlDataAdapter da = null;
    DataTable dt = null;
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
        if (!Page.IsPostBack)
        {
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
            da = new SqlDataAdapter("getAdminMessageList", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@isDeleted", true);
            da.SelectCommand.Parameters.AddWithValue("@type", "cl");
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

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
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
                lnkbtnSenderName.Font.Bold = false;
                lnkbtnSubject.Font.Bold = false;
                lnkbtnDOE.Font.Bold = false;
            }
            else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isRead")) == "False")
            {
                img.ImageUrl = "~/user/images/envelop_closed.png";
                lnkbtnSenderName.Font.Bold = true;
                lnkbtnSubject.Font.Bold = true;
                lnkbtnDOE.Font.Bold = true;
            }
            else
            {
            }
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;      
        Search();       
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if ((e.CommandName == "SenderName") || (e.CommandName == "Subject") || (e.CommandName == "doe"))
        {
            //int rowindex = Convert.ToInt32(e.CommandArgument);
            //GridViewRow row = GridView1.Rows[rowindex];
            //HiddenField hdnfld = (HiddenField)row.FindControl("hdnfldMessageId");
            //Response.Redirect("ViewMessage.aspx?mid=" + u.base64Encode(hdnfld.Value.ToString()) + "&frm=" + u.base64Encode("dm"));
        }
        
    }
 
    protected void lnkbtnMessageBox_Click(object sender, EventArgs e)
    {
        Response.Redirect("Messages.aspx");
        
    }
    protected void lnkbtnDeletedMessages_Click(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;
        BindGrid();
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
            da.SelectCommand.Parameters.AddWithValue("@isDeleted", true);
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

    protected void lnkbtnSentMessages_Click1(object sender, EventArgs e)
    {
        Response.Redirect("SentMessages.aspx", false);
    }
}
