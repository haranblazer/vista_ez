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
using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Text;

public partial class admin_AddAchiever : System.Web.UI.Page, ICallbackEventHandler
{
    string strPostedFile = string.Empty;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    DataTable dt;
    string strajax = "";
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
        if (!Page.IsPostBack)
        {

            BindHGrid();
            lblUser.Text = GetSponsorName(txtUserId.Text.Trim());


        }

        ClientScriptManager cm = Page.ClientScript;
        string js = cm.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
        StringBuilder newFunction = new StringBuilder("function ServerSendValue(arg,ctx){" + js + "}");
        cm.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);

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


    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            GetSponsorName(txtUserId.Text.Trim());
            com = new SqlCommand("AddAchiever", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@desc", txtMessage.Text);
            com.Parameters.AddWithValue("@name", Session["name"]);
            com.Parameters.AddWithValue("@CurrentRecord", "1");
            com.Parameters.AddWithValue("@iName", imgUpload.HasFile == false ? "0" : System.IO.Path.GetExtension(this.imgUpload.PostedFile.FileName).ToString());
            com.Parameters.Add("@ImageName", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            int p = com.ExecuteNonQuery();
            con.Close();
            if (p > 0)
            {
                if (!String.IsNullOrEmpty(com.Parameters["@ImageName"].Value.ToString()))
                {
                    strPostedFile = (string)com.Parameters["@ImageName"].Value;
                    string targetPath = Server.MapPath("~/images/News/" + strPostedFile);
                    imgUpload.SaveAs(targetPath);
                    //strPostedFile = (string)cmd.Parameters["@ImageName"].Value;
                    //string targetPath = Server.MapPath("~/CouponIcon/" + strPostedFile);
                    //Stream strm = imgUpload.PostedFile.InputStream;
                    //var targetFile = targetPath;
                    //GenerateThumbnails(0.5, strm, targetFile);
                }
                utility.MessageBox(this, "Achiever added successfully!");
                BindHGrid();
                txtUserId.Text = txtMessage.Text = string.Empty;

            }
        }
        catch
        {

        }

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.EditIndex = e.NewPageIndex;
        BindHGrid();

    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            System.Web.UI.WebControls.Image img = (System.Web.UI.WebControls.Image)e.Row.FindControl("imgStatus");
            LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkActive");
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "currentrecord")) == "1")
            {
                img.ImageUrl = "images/yes.jpeg";
                lnkbtn.Text = "<i class='fa fa-times-circle'></i>&nbsp;" + "Deactivate";
                lnkbtn.BackColor = Color.FromName("#00a300");
                lnkbtn.CssClass = "btn btn-primary btn-xs";
                lnkbtn.ToolTip = "Click to Deactivate";
                lnkbtn.CommandName = "DeActivate";
            }
            else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "currentrecord")) == "0")
            {
                img.ImageUrl = "images/no.jpeg";
                lnkbtn.Text = "<i class='fa fa-check-circle'></i>&nbsp;" + "Activate";
                lnkbtn.CssClass = "btn btn-danger btn-xs";
                lnkbtn.ToolTip = "Click to Activate";
                lnkbtn.CommandName = "Activate";
            }
        }
    }

    public void BindHGrid()
    {
        try
        {

            com = new SqlCommand("GetHNews", con);
            com.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(com);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();


            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();

            }
        }


        catch
        {
        }
        finally
        {



        }

    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "Page")
        {
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            int id = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
            if (e.CommandName == "DeActivate")
            {
                updateStatus(id, 0);
                utility.MessageBox(this, "DeActivated Successfully !");
            }
            else if (e.CommandName == "Activate")
            {
                updateStatus(id, 1);
                utility.MessageBox(this, "Activated Successfully !");
            }


        }
    }
    public void updateStatus(int id, int st)
    {

        da = new SqlDataAdapter();
        try
        {

            com = new SqlCommand("update newsmst set currentrecord=@Status where NewsMstId=@Id", con);
            com.CommandType = CommandType.Text;
            com.CommandTimeout = 99999;
            com.Parameters.AddWithValue("@Status", st);
            com.Parameters.AddWithValue("@Id", id);
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            BindHGrid();
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            da.Dispose();
        }
    }

    public void Delete(string id)
    {
        try
        {

            com = new SqlCommand("DelAchiever", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@id", id);
            con.Open();
            com.ExecuteNonQuery();
            con.Close();

        }


        catch
        {

        }


    }

    private string GetSponsorName(string regno)
    {
        string name = string.Empty;
        try
        {

            com = new SqlCommand("select appmstfname from AppMst where AppMstRegNo=@regno", con);
            com.Parameters.AddWithValue("@regno", regno.Trim());
            con.Open();
            name = com.ExecuteScalar().ToString();
            Session["name"]=name;
            con.Close();

        }
        catch
        {
        }

        return name;
    }


    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;

        string id = GridView1.DataKeys[gvrow.RowIndex].Value.ToString();
        Delete(id);
        BindHGrid();
        utility.MessageBox(this, "Record Deleted Successfully.");

    }
}



