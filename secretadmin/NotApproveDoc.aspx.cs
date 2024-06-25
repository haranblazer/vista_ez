using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;

public partial class secretadmin_NotApproveDoc : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    SqlCommand cmd;
    DataTable dt = new DataTable();
    utility objutil = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {
                BindNoApproveDoc();
            }
        
        }
        catch
        {

        }

    }
    protected void GridNotApproveDoc_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridNotApproveDoc.PageIndex = e.NewPageIndex;
        BindNoApproveDoc();
    }

    public void BindNoApproveDoc()
    {

        try
        {
            cmd = new SqlCommand("GetNoApproveDoc", con);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            con.Open();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridNotApproveDoc.PageSize = ddPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddPageSize.SelectedValue.ToString());
                GridNotApproveDoc.DataSource = dt;
                GridNotApproveDoc.DataBind();
                lblCount.Text = " No of Records: " + dt.Rows.Count.ToString();
            }
            else
            {
                GridNotApproveDoc.DataSource = null;
                GridNotApproveDoc.DataBind();
                lblCount.Text = string.Empty;

            }
        }
        catch
        {

        }
        finally
        {
            con.Close();
            con.Dispose();
           
        }

    }


    protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {

        BindNoApproveDoc();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {



    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridNotApproveDoc.Rows.Count > 0)
        {
            GridNotApproveDoc.Columns[4].Visible = GridNotApproveDoc.Columns[5].Visible = false;
            GridNotApproveDoc.AllowPaging = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_NoApproveDocs.xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridNotApproveDoc.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }

    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (GridNotApproveDoc.Rows.Count > 0)
        {
           
            GridNotApproveDoc.Columns[4].Visible = GridNotApproveDoc.Columns[5].Visible = false;
            GridNotApproveDoc.AllowPaging = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_NoApproveDocs.doc");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridNotApproveDoc.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }
    protected void lnlSend_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)((LinkButton)sender).NamingContainer;
            TextBox txtMsg = row.FindControl("txtMsg") as TextBox;
            if (!string.IsNullOrEmpty(txtMsg.Text.Trim()))
            {
                string id = row.Cells[1].Text.Trim();
                string name = row.Cells[2].Text.Trim();
                string mobile = row.Cells[3].Text.Trim();
                CheckSmSCredit(mobile, id, name, txtMsg.Text.Trim());
                txtMsg.Text = string.Empty;
            }
            else if (string.IsNullOrEmpty(txtMsg.Text.Trim()))
            {
                utility.MessageBox(this, "Please type your message to reply.");
                txtMsg.Focus();
            }

        }
        catch
        {

        }

    }

    public void CheckSmSCredit(string mobile, string id, string name, string msg)
    {
        SqlCommand cmd = new SqlCommand("checkSmsCredit", con);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                if (!string.IsNullOrEmpty(mobile) && IsValidMobile(mobile))
                {
                    objutil.sendSMSByPage(mobile, "Dear " + name + " " + id + " " + msg);
                    utility.MessageBox(this, "Message has been sent Successfully.");
                }
                else
                {
                    utility.MessageBox(this, "Mobile No. is not valid.");
                    return;
                }
            }
            else
            {
                utility.MessageBox(this, "SMS Credit is Insufficient.");
                return;
            }
            con.Close();
        }
        catch
        {

        }
    }


    public DataSet Bind()
    {
        cmd = new SqlCommand("SearchByUserId", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@regno", txtUserSearch.Text.Trim());
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataSet ds = new DataSet();
        da.Fill(ds);
        if (!object.Equals(ds, null))
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                GridNotApproveDoc.DataSource = ds.Tables[0];
                GridNotApproveDoc.DataBind();
            }

        }


        return ds;
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {

        DataSet ds = Bind();

        if (!object.Equals(ds, null))
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                
                lblCount.Text = " Record Found: " + ds.Tables[0].Rows.Count.ToString();
                
            }
            else
            {


                lblCount.Text = string.Empty;

            }
        }
    }

    public Boolean IsValidMobile(string str)
    {
        if (Regex.Match(str, @"^0?[789]\d{9}$").Success)
        {

            return true;
        }
        else
        {
            return false;
        }

    }
}