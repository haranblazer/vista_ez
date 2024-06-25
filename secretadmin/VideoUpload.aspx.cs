using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Drawing;

public partial class admin_VideoUpload : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetVideoTitle();
            GetVideoList();
            BindTitle();
        }
    }


    public void BindTitle()
    {
        String Qry = @"Select Tid, Title, TitleType, Isactive from TitleMst where TitleType='" + ddl_DataType.SelectedValue + "' order by Tid desc";
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(Qry);
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddl_title.SelectedValue == "0")
            {
                utility.MessageBox(this, "Please select title.");
                return;
            }

            if (string.IsNullOrEmpty(txtVideoUpload.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter video link.");
                return;
            }

            string Img = "video_black.jpg";
            if (fuUpload.HasFile)
            {
                if (fuUpload.PostedFile.ContentLength > 512000)
                {
                    utility.MessageBox(this, "Please select an image size should be less than 500 KB.");
                    return;
                }

                Img = Path.GetFileName(Guid.NewGuid().ToString() + fuUpload.PostedFile.FileName);
                string fileName = Guid.NewGuid().ToString() + "." + Path.GetExtension(fuUpload.FileName);

                Stream stream = fuUpload.FileContent;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 700 && height == 500)
                {

                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 700px and height 500px.");
                    return;
                }
            }


            com = new SqlCommand("InsertVideo", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@vname", txtVideoUpload.Text.Trim());
            com.Parameters.AddWithValue("@status", 1);
            com.Parameters.AddWithValue("@Tid", ddl_title.SelectedValue);
            com.Parameters.AddWithValue("@TitleHeader", "");
            com.Parameters.AddWithValue("@Img", Img);
            com.Parameters.AddWithValue("@DataType", ddl_DataType.SelectedValue);
            com.Parameters.AddWithValue("@Descriptions", txt_Desc.Text.Trim());

            con.Open();
            int count = com.ExecuteNonQuery();
            con.Close();
            if (count > 0)
            {
                if (fuUpload.HasFile)
                {
                    fuUpload.PostedFile.SaveAs(Server.MapPath("~/images/Slip/" + Img));
                }
                lblMsg.Visible = true;
                lblMsg.Text = "Video Uploaded Successfully.";
                Response.AppendHeader("X-XSS-Protection", "0");
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
                txtVideoUpload.Text = string.Empty;
            }

            GetVideoList();
        }
        catch (Exception er)
        {

        }
        finally
        {
            con.Dispose();
        }
    }

    public void GetVideoList()
    {
        SqlParameter[] param = new SqlParameter[]
        {
                //new SqlParameter("@DataType", ddl_DataType.SelectedValue)
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "VideoList");
        if (dt.Rows.Count > 0)
        {
            DataVideo.DataSource = dt;
            DataVideo.DataBind();
        }
        else
        {
            DataVideo.DataSource = null;
            DataVideo.DataBind();
        }

    }



    protected void DataVideo_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        DataVideo.PageIndex = e.NewPageIndex;
        BindTitle();
    }

    protected void DataVideo_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = DataVideo.Rows[Convert.ToInt32(e.CommandArgument)];
        string id = DataVideo.DataKeys[row.RowIndex].Values[0].ToString();
        string VImg = DataVideo.DataKeys[row.RowIndex].Values[1].ToString();
        //int rowindex = Convert.ToInt32(e.CommandArgument);
        //GridViewRow row = GridView1.Rows[rowindex];
        //HiddenField hnd_id = (HiddenField)row.FindControl("hnd_id");
        //HiddenField hnd_VImg = (HiddenField)row.FindControl("hnd_VImg");
        if (e.CommandName == "Status")
        {
            SqlCommand cmd = new SqlCommand("Update videomst set Status=(Case when Status=0 then 1 else 0 end) where id=@id", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@id", id);
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception er) { }
            finally
            {
                con.Close();
            }
        }
        if (e.CommandName == "VDELETE")
        {
            var filePath = Server.MapPath("~/images/Slip/" + VImg);
            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }

            com = new SqlCommand("DelVideo", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@id", id);
            con.Open();
            int result = com.ExecuteNonQuery();
            con.Close();
            if (result > 0)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Video Deleted Successfully.";
                Response.AppendHeader("X-XSS-Protection", "0");
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
            }
        }

        //if (e.CommandName == "IMG_UPDATE")
        //{
        //    var filePath = Server.MapPath("~/images/Slip/" + VImg);
        //    if (File.Exists(filePath))
        //    {
        //        File.Delete(filePath);
        //    }

        //    try
        //    {
        //        //var control = (Control)sender;
        //        //var container = control.NamingContainer; 
        //        //var imgdlUpload = container.FindControl("imgdlUpload") as FileUpload;

        //        var imgVUpload = (FileUpload)row.FindControl("imgVUpload");
        //        string Img = "video_black.jpg";
        //        if (imgVUpload.HasFile)
        //        {
        //            if (imgVUpload.PostedFile.ContentLength > 512000)
        //            {
        //                utility.MessageBox(this, "Please select an image size should be less than 500 KB.");
        //                return;
        //            }

        //            Img = Path.GetFileName(Guid.NewGuid().ToString() + imgVUpload.PostedFile.FileName);
        //            string fileName = Guid.NewGuid().ToString() + "." + Path.GetExtension(imgVUpload.FileName);

        //            Stream stream = imgVUpload.FileContent;
        //            Bitmap bitimg = new Bitmap(stream);
        //            int height = bitimg.Height;
        //            int width = bitimg.Width;
        //            if (width == 700 && height == 500)
        //            {
        //                com = new SqlCommand("Update videomst set Img=@img where id=@id", con);
        //                com.Parameters.AddWithValue("@img", Img);
        //                com.Parameters.AddWithValue("@id", id);
        //                con.Open();
        //                int i = com.ExecuteNonQuery();
        //                con.Close();
        //                if (i == 1)
        //                {
        //                    if (imgVUpload.HasFile)
        //                    {
        //                        imgVUpload.PostedFile.SaveAs(Server.MapPath("~/images/Slip/" + Img)); 
        //                    }
        //                }
        //                else
        //                {
        //                    utility.MessageBox(this, "Product Image Update Failed !!!");
        //                }
        //            }
        //            else
        //            {
        //                utility.MessageBox(this, "Image size must be width 700px and height 500px.");
        //                return;
        //            }
        //        }
        //        else
        //        {
        //            utility.MessageBox(this, "Please select an image.");
        //            return;
        //        }
        //    }
        //    catch (Exception er) { }
        //}
        GetVideoList();
    }




    protected void lnkupdate_Click(object sender, EventArgs e)
    {
        try
        {
            var control = (Control)sender;
            var container = control.NamingContainer;
            // access your controls this way
            var hnd_id = container.FindControl("hnd_id") as HiddenField;
            var imgdlUpload = container.FindControl("imgdlUpload") as FileUpload;

            string Img = "video_black.jpg";
            if (imgdlUpload.HasFile)
            {
                if (imgdlUpload.PostedFile.ContentLength > 512000)
                {
                    utility.MessageBox(this, "Please select an image size should be less than 500 KB.");
                    return;
                }

                Img = Path.GetFileName(Guid.NewGuid().ToString() + imgdlUpload.PostedFile.FileName);
                string fileName = Guid.NewGuid().ToString() + "." + Path.GetExtension(imgdlUpload.FileName);

                Stream stream = imgdlUpload.FileContent;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 700 && height == 500)
                {
                    com = new SqlCommand("Update videomst set Img=@img where id=@id", con);
                    com.Parameters.AddWithValue("@img", Img);
                    com.Parameters.AddWithValue("@id", hnd_id.Value);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    if (i == 1)
                    {
                        if (imgdlUpload.HasFile)
                        {
                            imgdlUpload.PostedFile.SaveAs(Server.MapPath("~/images/Slip/" + Img));
                            GetVideoList();
                        }
                    }
                    else
                    {
                        utility.MessageBox(this, "Product Image Update Failed !!!");
                    }
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 700px and height 500px.");
                    return;
                }
            }
            else
            {
                utility.MessageBox(this, "Please select an image.");
                return;
            }

        }
        catch (Exception er) { }
    }


    //protected void lnkDel_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        var control = (Control)sender;
    //        var container = control.NamingContainer;
    //        // access your controls this way
    //        var hnd_id = container.FindControl("hnd_id") as HiddenField;
    //        var hnd_Img = container.FindControl("hnd_Img") as HiddenField;

    //        var filePath = Server.MapPath("~/images/Slip/" + hnd_Img.Value);
    //        if (File.Exists(filePath))
    //        {
    //            File.Delete(filePath);
    //        }


    //        com = new SqlCommand("DelVideo", con);
    //        com.CommandType = CommandType.StoredProcedure;
    //        com.Parameters.AddWithValue("@id", hnd_id.Value);
    //        con.Open();
    //        int result = com.ExecuteNonQuery();
    //        con.Close();
    //        if (result > 0)
    //        {
    //            lblMsg.Visible = true;
    //            lblMsg.Text = "Video Deleted Successfully.";
    //            Response.AppendHeader("X-XSS-Protection", "0");
    //            ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
    //        }
    //        GetVideoList();
    //    }
    //    catch (Exception er)
    //    {

    //    }

    //}

    protected void btn_Title_Click(object sender, EventArgs e)
    {
        GetVideoTitle();
    }


    public void GetVideoTitle()
    {
        try
        {
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable("Select Tid, Title from TitleMst where TitleType='" + ddl_DataType.SelectedValue + "'");
            if (dt.Rows.Count > 0)
            {
                ddl_title.Items.Clear();
                ddl_title.DataSource = dt;
                ddl_title.DataTextField = "Title";
                ddl_title.DataValueField = "Tid";
                ddl_title.DataBind();
                ddl_title.Items.Insert(0, new ListItem("Select Title", "0"));
            }
        }
        catch { }
    }


    protected void ddl_DataType_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetVideoTitle();
        GetVideoList();
        BindTitle();
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("AddTitle", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Title", txt_Title.Text);
            cmd.Parameters.AddWithValue("@TitleType", ddl_DataType.SelectedValue);
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            string flag = cmd.Parameters["@flag"].Value.ToString();
            if (flag == "1")
            {
                BindTitle();
            }
            else
            {
                utility.MessageBox(this, flag);
                return;
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindTitle();
    }

    protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
    {
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int rowindex = Convert.ToInt32(e.CommandArgument);
        GridViewRow row = GridView1.Rows[rowindex];
        HiddenField hnd_Tid = (HiddenField)row.FindControl("hnd_Tid");
        //if (e.CommandName == "ACTIVE_DEACTIVE")
        //{
        //    SqlCommand cmd = new SqlCommand("Update TitleMst set IsActive=(Case when IsActive=0 then 1 else 0 end) where Tid=@Tid", con);
        //    cmd.CommandType = CommandType.Text;
        //    cmd.Parameters.AddWithValue("@Tid", hnd_Tid.Value);
        //    try
        //    {
        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //    }
        //    catch (Exception er) { }
        //    finally
        //    {
        //        con.Close();
        //    }
        //}
        //if (e.CommandName == "DELETE")
        //{
        //    SqlCommand cmd = new SqlCommand("Delete TitleMst where Tid=@Tid", con);
        //    cmd.CommandType = CommandType.Text;
        //    cmd.Parameters.AddWithValue("@Tid", hnd_Tid.Value);
        //    try
        //    {
        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //    }
        //    catch (Exception er) { }
        //    finally
        //    {
        //        con.Close();
        //    }
        //}
        BindTitle();
    }

}