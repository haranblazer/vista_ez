using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Drawing;
using System.Text;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.IdentityModel.Protocols.WSTrust;
using System.Activities.Expressions;
//using Org.BouncyCastle.Bcpg;

public partial class secretadmin_blog_AllBlogs : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd = null;
    SqlDataAdapter da;
    DataTable dt;
    utility objutil = new utility();
    int id = 0;
    string sCatgs = string.Empty;
    string sTags = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            id = Convert.ToInt32((Request.QueryString["n"]));
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("~/secretadmin/logout.aspx");

            if (!Page.IsPostBack)
            {
                BindBlogDetails();
                BindCategoriesTags();
            }
        }
        catch
        {

        }
    }
    

    public void BindBlogDetails()
    {
        try
        {
            cmd = new SqlCommand("GetBlogsDetailsByBlogID", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@blogid", id);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                title.Text = dt.Rows[0]["title"].ToString();
                aGoTO.Attributes["href"] = "~/Blog/" + title.Text.Replace(" ", "-");
                description.Text = dt.Rows[0]["description"].ToString();   
                content.Text = dt.Rows[0]["content"].ToString();
                showComments.Checked = Convert.ToBoolean(dt.Rows[0]["showComments"]);
                sCatgs = Convert.ToString(dt.Rows[0]["categories"]);
                sTags = Convert.ToString(dt.Rows[0]["tags"]);
                isPublished.Checked = Convert.ToBoolean(dt.Rows[0]["published"]);
                imgFileName.Text = Convert.ToString(dt.Rows[0]["imageName"]);
            }
        }
        catch (Exception ex)
        {

        }
    }

    public void BindCategoriesTags()
    {
        using (SqlCommand cmd = new SqlCommand("GetBlogCategories_Tags", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            ddl_categories.DataSource = ds.Tables[0];
            ddl_categories.DataBind();
            ddl_tags.DataSource = ds.Tables[1];
            ddl_tags.DataBind();
            foreach (ListItem item in ddl_categories.Items)
            {
                if (sCatgs.Contains(item.Value))
                    item.Selected = true;
            }
            foreach(ListItem item in ddl_tags.Items)
            {
                if(sTags.Contains(item.Value))
                    item.Selected = true;
            }
        }
    }

    //protected void GridAllBlogs_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {

    //        DropDownList ddlAR = (DropDownList)e.Row.FindControl("ddlApproveReject");
    //        Button btn = (Button)e.Row.FindControl("btnSubmit");
    //        if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "sts")) == "Approved")
    //        {
    //            ddlAR.SelectedIndex = ddlAR.Items.IndexOf(ddlAR.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, "Approved", true) == 0).FirstOrDefault());
    //            btn.Visible = false;
    //            e.Row.Enabled = false;
    //            e.Row.ToolTip = "Already Approved.";
    //            e.Row.BackColor = Color.FromName("#D5F5E3");


    //        }
    //        else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "sts")) == "Not Approved")
    //        {
    //            ddlAR.SelectedIndex = ddlAR.Items.IndexOf(ddlAR.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, "Not Approved", true) == 0).FirstOrDefault());
    //            btn.Visible = true;
    //            e.Row.ToolTip = "Not Approved.";
    //            e.Row.BackColor = Color.FromName("#FDEBD0");
    //        }
    //    }
    //}

    



    

   
   

    protected void Save_Click(object sender, EventArgs e)
    {
        string fileName = "noimage.jpg";
        if (id != 0 && (imgUpload.HasFile))
        {
            var FileExtension = Path.GetExtension(imgUpload.PostedFile.FileName);
            fileName = "Blog-" + id + FileExtension;
            imgUpload.PostedFile.SaveAs(Server.MapPath("~/images/blog/"+fileName));
        }
        var s1 = title.Text.Trim();
        var s2 = description.Text.Trim();
        var s3 = content.Text;
        StringBuilder sbCategories = new StringBuilder();
        StringBuilder sbTags = new StringBuilder();
        foreach(ListItem item in ddl_categories.Items)
        {
            if (item.Selected)
            {
                sbCategories.Append(item.Value);
                sbCategories.Append(",");
            }
        }
        foreach(ListItem item in ddl_tags.Items)
        {
            if(item.Selected)
            {
                sbTags.Append(item.Value);
                sbTags.Append(",");
            }
        }
        using (SqlCommand cmd = new SqlCommand("AddEditBlogDetails", con))
        {
            string FileExtension = string.Empty;
            if (id == 0 && (imgUpload.HasFile))
            {
                FileExtension = Path.GetExtension(imgUpload.PostedFile.FileName);
            }

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@blogid", id);
            cmd.Parameters.AddWithValue("@title", s1);
            cmd.Parameters.AddWithValue("@description", s2);
            cmd.Parameters.AddWithValue("@content", s3);
            cmd.Parameters.AddWithValue("@author", Session["admintype"]);
            cmd.Parameters.AddWithValue("@categories", sbCategories.ToString());
            cmd.Parameters.AddWithValue("@tags", sbTags.ToString());    
            cmd.Parameters.AddWithValue("@showComments", showComments.Checked);
            cmd.Parameters.AddWithValue("@imageName", fileName);
            cmd.Parameters.AddWithValue("@published", isPublished.Checked);
            var returnVal = cmd.Parameters.Add("@id", SqlDbType.Int);
            returnVal.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.AddWithValue("extension", FileExtension);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            if (id == 0 && (imgUpload.HasFile))
            {
                fileName = "Blog-" + returnVal.Value + FileExtension;
                imgUpload.PostedFile.SaveAs(Server.MapPath("~/images/blog/" + fileName));
            }
            Response.Redirect("AllBlogs.aspx");
        } 
    }
    
   

    protected void Unpublish_Click(object sender,EventArgs e)
    {

    }
    protected void Edit_Click(object sender, EventArgs e)
    {
        using (GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent)
        {
            txtCustomerID.ReadOnly = true;
            txtCustomerID.Text = row.Cells[0].Text;
            txtContactName.Text = row.Cells[1].Text;
            txtDescription.Text = row.Cells[4].Text;
            popup.Show();
        }

    }

       


}



