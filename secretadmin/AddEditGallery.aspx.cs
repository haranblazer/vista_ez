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
using System.Text.RegularExpressions;
using System.IO;

public partial class admin_AddEditGallery : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    utility objUtil = new utility();
    SqlDataAdapter da;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str;
        try
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
            if (!IsPostBack)
            {
                str = Session["admin"].ToString();
                BindGrid(string.Empty);
            }

        }
        catch
        {

        }
         
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtTitle.Text.Trim()))
        {
            addGalleryTitle();
        }
        else
        {
            lblMsg.Text = "Please gallery title!";
        }
        BindGrid(string.Empty);
    }
    private void addGalleryTitle()
    {
        try
        {
            com = new SqlCommand("AddGalleryTitle", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@Title", txtTitle.Text.Trim().ToString());
            com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            com.CommandTimeout = 999999;
            com.ExecuteNonQuery();
            int status = Convert.ToInt32(com.Parameters["@flag"].Value);
            if (status == 11)
            {
                lblMsg.Text = "Gallery title added successfully !";
                txtTitle.Text = string.Empty;
            }
            else if (status == 1)
            {
                lblMsg.Text = "This gallery title already exists in acitve list !";
            }
            else if (status == 0)
            {
                lblMsg.Text = "This gallery Tttle already exists in in-acitve list,please activate from there !";
            }
            else
            {
                lblMsg.Text = "Operation unsuccessful!please try later...";
            }
        }
        catch
        {
        }
        finally
        {
            con.Close();
        }
    }
    private void BindGrid(string Title)
    {

        SqlConnection con = new SqlConnection(method.str);
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {
            da = new SqlDataAdapter("getGalleryTitle", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@Title", Title);
            da.SelectCommand.Parameters.AddWithValue("@isDeleted", ddlStatus.SelectedValue.ToString());
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
            con.Dispose();
            dt.Dispose();
            da.Dispose();
        }
    }



    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image img = (Image)e.Row.FindControl("imgStatus");
            LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkbtnStatus");
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isDeleted")) == "False")
            {
                img.ImageUrl = "images/yes.jpeg";
                lnkbtn.Text = "De Activate";
                lnkbtn.CommandName = "DeActivate";
            }
            else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isDeleted")) == "True")
            {
                img.ImageUrl = "images/no.jpeg";
                lnkbtn.Text = "Activate";
                lnkbtn.CommandName = "Activate";
            }
            else
            {
            }
        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        txtTitle.Text = lblMsg.Text = string.Empty;
        if (e.CommandName != "Page")
        {
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            int id = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
            if (e.CommandName == "DeActivate")
            {
                updateStatus(id, 1);
                lblMsg.Text = "Title de activated successfully !";
            }
            else if (e.CommandName == "Activate")
            {
                updateStatus(id, 0);
                lblMsg.Text = "Title activated successfully !";
            }
            else if (e.CommandName == "ViewAddEdit")
            {
                Response.Redirect("ViewAddEditImage.aspx?i=" + objUtil.base64Encode(Convert.ToString(id)), false);
            }
            else if (e.CommandName == "Del")
            {


                try
                {
                    if (id.ToString() != "")
                    {
                        com = new SqlCommand("select imagename from GalleryimageMst where titleid=@titleId", con);
                        com.CommandType = CommandType.Text;
                        con.Open();
                        com.Parameters.AddWithValue("@titleId", id);
                        da = new SqlDataAdapter(com);
                        dt = new DataTable();
                        da.Fill(dt);
                        con.Close();
                        if (dt.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                string path = Server.MapPath("~/GalleryImages/" + dt.Rows[i]["imagename"].ToString());
                                com = new SqlCommand("DelGallery", con);
                                com.CommandType = CommandType.StoredProcedure;
                                con.Open();
                                com.Parameters.AddWithValue("@titleId", id);
                                FileInfo info = new FileInfo(path);
                                if (info.Exists)
                                {
                                    info.Delete();
                                }
                                com.ExecuteNonQuery();
                                con.Close();
                               
                            }
                            utility.MessageBox(this, "Record Deleted successfully.");
                        }
                        else
                        {
                            com = new SqlCommand("DeleteGalTitle", con);
                            com.CommandType = CommandType.StoredProcedure;
                            con.Open();
                            com.Parameters.AddWithValue("@titleId", id);
                            com.ExecuteNonQuery();
                            con.Close();
                            utility.MessageBox(this, "Gallery Deleted successfully.");
                        }

                        BindGrid(string.Empty);
                    }

                }
                catch (Exception ex)
                {

                }
            }
        }

    }
    public void updateStatus(int id, int sts)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand();
        try
        {
            com = new SqlCommand("updateGalleryTitle", con);
            com.CommandType = CommandType.StoredProcedure;
            com.CommandTimeout = 99999;
            com.Parameters.AddWithValue("@isDeleted", sts);
            com.Parameters.AddWithValue("@TitleId", id);
            con.Open();
            int result = (int)com.ExecuteNonQuery();
            con.Close();
            if (result > 0)
            {
                BindGrid(string.Empty);
            }

        }
        catch
        {
        }
        finally
        {
            con.Dispose();
        }
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {

        GridView1.EditIndex = e.NewEditIndex;
        if (!string.IsNullOrEmpty(txtTitle.Text.Trim()))
            BindGrid(txtTitle.Text.Trim());
        else
            BindGrid(string.Empty);

    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        lblMsg.Text = string.Empty;
        GridView1.EditIndex = -1;
        if (!string.IsNullOrEmpty(txtTitle.Text.Trim()))
            BindGrid(txtTitle.Text.Trim());
        else
            BindGrid(string.Empty);
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView1.EditIndex = e.RowIndex;
        string TitleId = GridView1.DataKeys[e.RowIndex].Value.ToString();
        //string TitleId = ((Label)GridView1.Rows[e.RowIndex].Cells[1].FindControl("lblId")).Text;
        string Title = ((TextBox)(GridView1.Rows[e.RowIndex].Cells[1].Controls[0])).Text.Trim();
        if (!string.IsNullOrEmpty(Title))
        {
            editTitle(TitleId, Title);
            GridView1.EditIndex = -1;
            if (!string.IsNullOrEmpty(txtTitle.Text.Trim()))
                BindGrid(txtTitle.Text.Trim());
            else
                BindGrid(string.Empty);
        }
        else
        {
            lblMsg.Text = "Please enter gallery title!";
        }
    }
    public void editTitle(string TitleId, string Title)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand();
        try
        {
            cmd = new SqlCommand("update  GalleryTitleMst set Title=@Title where TitleId=@TitleId", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@TitleId", TitleId);
            cmd.Parameters.AddWithValue("@Title", Title);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            lblMsg.Text = "Title edited successfully !";
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            cmd.Dispose();
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        if (!string.IsNullOrEmpty(txtTitle.Text.Trim()))
            BindGrid(txtTitle.Text.Trim());
        else
            BindGrid(string.Empty);
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        txtTitle.Text = lblMsg.Text = string.Empty;
        BindGrid(string.Empty);
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;
        if (!string.IsNullOrEmpty(txtTitle.Text.Trim()))
            BindGrid(txtTitle.Text.Trim());
        else
            lblMsg.Text = "Please enter title!";

    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtTitle.Text.Trim()))
                BindGrid(txtTitle.Text.Trim());
            else
                BindGrid(string.Empty);

            GridView1.Columns[3].Visible = GridView1.Columns[4].Visible = GridView1.Columns[5].Visible = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_GalleryTitle.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
            lblMsg.Text = "Can't export,no record found!";


    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtTitle.Text.Trim()))
                BindGrid(txtTitle.Text.Trim());
            else
                BindGrid(string.Empty);
            GridView1.Columns[3].Visible = GridView1.Columns[4].Visible = GridView1.Columns[5].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_GalleryTitle.doc");
            Response.ContentType = "application/vnd.ms-word";
            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }
        else
            lblMsg.Text = "Can't export,no record found!";

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btnShowAll_Click(object sender, EventArgs e)
    {
        txtTitle.Text = lblMsg.Text = string.Empty;
        BindGrid(string.Empty);
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtTitle.Text = lblMsg.Text = string.Empty;
        BindGrid(string.Empty);
    }
}
