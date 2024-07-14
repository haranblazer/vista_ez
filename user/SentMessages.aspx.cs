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
    SqlConnection con = null;
    SqlDataAdapter da = null;
    DataTable dt = null;
    utility u = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Convert.ToString(Session["UserId"])))
        {
            Response.Redirect("loginagain.aspx");
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
            da = new SqlDataAdapter("select MessageId,ReceiverId,SenderId,(select AppMstTitle+space(1)+AppMstFName from Appmst where AppMstRegNo=messagemst.SenderId ) as SenderName,MsgSubject,Msg,convert(varchar(12),DOE,100) as doe,IpAddress,isRead from messagemst where SentBy='user'  and SenderId=@SenderId order by dateadd(minute,330,doe) desc", con);         
            da.SelectCommand.Parameters.AddWithValue("@SenderId", Convert.ToString(Session["UserId"]));    
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
            DataRow[] dr = s_dt.Select("MsgSubject like '%" + txtSearch.Text + "%'");
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
    //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        Image img = (Image)e.Row.FindControl("imgStatus");           
    //        LinkButton lnkbtnSubject = (LinkButton)e.Row.FindControl("lnkbtnSubject");
    //        LinkButton lnkbtnDOE = (LinkButton)e.Row.FindControl("lnkbtnDOE");
    //        if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isRead")) == "True")
    //        {
    //            img.ImageUrl = "images/envelop_open.png";               
    //            lnkbtnSubject.Font.Bold = false;
    //            lnkbtnDOE.Font.Bold = false;
    //        }
    //        else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isRead")) == "False")
    //        {
    //            img.ImageUrl = "images/envelop_closed.png";              
    //            lnkbtnSubject.Font.Bold = true;
    //            lnkbtnDOE.Font.Bold = true;
    //        }
    //        else
    //        {
    //        }
    //    }
    //}
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;        
        Search();
       
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if ((e.CommandName == "ReceiverName") || (e.CommandName == "Subject") || (e.CommandName == "doe"))
        {
            int rowindex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GridView1.Rows[rowindex];
            HiddenField hdnfld = (HiddenField)row.FindControl("hdnfldMessageId");
            Response.Redirect("ViewSentMessage.aspx?mid=" + u.base64Encode(hdnfld.Value.ToString()));
        }

    }

    protected void lnkbtnMessageBox_Click(object sender, EventArgs e)
    {
        Response.Redirect("Messages.aspx");

    }
   

   
  
}
