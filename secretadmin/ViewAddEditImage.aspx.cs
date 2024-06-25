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
using System.IO;
using System.Drawing.Drawing2D;
using System.Drawing;
using System.Text.RegularExpressions;
public partial class admin_ViewAddEditImage : System.Web.UI.Page
{
    int tid;
    utility objUtil = new utility();
    string strPostedFile = string.Empty;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    HttpPostedFile hpf;
    SqlDataAdapter da;
    DataTable dt;
    string filename = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;
        txtTitle.Visible = false;
        string str;
        if (Session["admin"] != null)
        {

            str = Session["admin"].ToString();
        }
        else
        {
            Response.Redirect("adminLog.aspx", false);
        }
        if (Request.QueryString["i"] != null)
        {
            tid = Convert.ToInt32(objUtil.base64Decode(Request.QueryString["i"]));
        }
        if (!Page.IsPostBack)
        {
            btnEdit.Visible = false;
            btnCancelEdit.Visible = false;
            BindGrid();
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (imgUpload.HasFile)
        {

            HttpFileCollection hfc = Request.Files;
            for (int i = 0; i < hfc.Count; i++)
            {
                hpf = hfc[i];
                if (hpf.ContentLength > 0)
                {
                    try
                    {
                        Regex reg = new Regex(@"^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$");
                        filename = Path.GetFileName(hpf.FileName);
                        if (reg.IsMatch(filename))
                        {
                            SqlConnection con = new SqlConnection(method.str);
                            SqlCommand com = new SqlCommand("AddGalleryImage", con);
                            com.CommandType = CommandType.StoredProcedure;
                            com.Parameters.AddWithValue("@GalleryTitleId", tid);
                            com.Parameters.AddWithValue("@ImageTitle", filename);
                            com.Parameters.AddWithValue("@iName", filename);
                            com.Parameters.Add("@ImageName", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                            con.Open();
                            com.ExecuteNonQuery();
                            saveImg(com.Parameters["@ImageName"].Value.ToString());
                            lblMsg.Text +=filename +" have been uploaded successfully."+"<br/>";
                            con.Close();
                            btnEdit.Visible = false;
                            BindGrid();
                        }
                        else
                        {
                            lblMsg.Text += filename + " have been uploaded fail , please check file format!"+"<br/>";
                            
                        }
                    }
                    catch
                    {


                    }

                }
            }

        }
        else
        {
            utility.MessageBox(this, "Please select an image.");
            return;
        }

    }

    public void saveImg(string file)
    {
        try
        {
            if (hpf.ContentLength > 0)
            {

                string targetPath = Server.MapPath("~/images/GalleryImages/" + file);
                Stream strm = hpf.InputStream;
                var targetFile = targetPath;
                GenerateThumbnails(0.5, strm, targetFile);

            }
            else
            { }
        }
        catch
        { }
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblMessage.Text = string.Empty;
        BindGrid();
    }
    private void BindGrid()
    {
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {
            da = new SqlDataAdapter("select ImageId,TitleId,ImageTitle,ImageName,case isDeleted when 0 then 'De-Activate' when 1 then 'Activate' end as sts,(select Title from GalleryTitleMst where  TitleId=GalleryImageMst.TitleId) as GalleryTitle  from GalleryImageMst where isDeleted=@isDeleted and TitleId=@TitleId", con);
            da.SelectCommand.Parameters.AddWithValue("@TitleId", tid);
            da.SelectCommand.Parameters.AddWithValue("@isDeleted", ddlStatus.SelectedValue.ToString());
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                dtlst.DataSource = dt;
                dtlst.DataBind();
                lblGalleryTitle.Text = " ( Gallery : " + Convert.ToString(dt.Rows[0]["GalleryTitle"]) + " )";
            }
            else
            {
                dtlst.DataSource = null;
                dtlst.DataBind();
                lblMessage.Text = "Record not found!";
            }
        }
        catch
        {
        }

    }
    protected void dtlst_EditCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandSource.GetType().ToString() == "System.Web.UI.WebControls.LinkButton")
        {

            if (e.CommandName == "Edit")
            {
                if (((LinkButton)e.CommandSource).ID.ToString() == "lnkbtnEdit")
                {
                    btnEdit.Visible = true;
                    btnCancelEdit.Visible = true;
                    btnAdd.Visible = false;
                    lblMsg.Text = lblMessage.Text = string.Empty;
                    getImage(e.CommandArgument.ToString());
                }
                else if (((LinkButton)e.CommandSource).ID.ToString() == "lnkbtnStatus")
                {
                    updateStatus(Convert.ToInt32(e.CommandArgument.ToString()), ((LinkButton)e.CommandSource).Text == "Activate" ? 0 : 1);
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
            com = new SqlCommand("update GalleryImageMst set isDeleted=@isDeleted where ImageId=@ImageId", con);
            com.CommandType = CommandType.Text;
            com.CommandTimeout = 99999;
            com.Parameters.AddWithValue("@isDeleted", sts);
            com.Parameters.AddWithValue("@ImageId", id);
            con.Open();
            int result = (int)com.ExecuteNonQuery();
            con.Close();
            if (result > 0)
            {
                BindGrid();
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
    private void getImage(string image_id)
    {

        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {
            da = new SqlDataAdapter("select ImageId,TitleId,ImageTitle,ImageName from GalleryImageMst  where ImageId=@ImageId", con);
            da.SelectCommand.Parameters.AddWithValue("@ImageId", image_id);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                txtTitle.Text = Convert.ToString(dt.Rows[0]["ImageTitle"]);
                img.ImageUrl = "~/images/GalleryImages/" + Convert.ToString(dt.Rows[0]["ImageName"]);
                ViewState["ImageName"] = Convert.ToString(dt.Rows[0]["ImageName"]);
                ViewState["image_id"] = image_id;
                img.Height = 100;
                img.Width = 100;
            }
            else
            {
                ViewState["ImageName"] = "0";
                lblMsg.Text = "Image not found";
            }
        }
        catch
        {
        }

    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        HttpFileCollection hfc = Request.Files;
        for (int i = 0; i < hfc.Count; i++)
        {
            hpf = hfc[i];
            if (hpf.ContentLength > 0)
            {


                if (!string.IsNullOrEmpty(txtTitle.Text.Trim()))
                {
                    com = new SqlCommand("EditGalleryImage", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@ImageId", ViewState["image_id"]);
                    com.Parameters.AddWithValue("@ImageTitle", txtTitle.Text);
                    com.Parameters.AddWithValue("@ImageName", ViewState["image_id"] + imgUpload.PostedFile.FileName);
                    con.Open();
                    int result = com.ExecuteNonQuery();
                    if (result > 0)
                    {
                        con.Close();
                        lblMessage.Text = string.Empty;
                        lblMsg.Text = "Details edited successfully!";
                        if (imgUpload.HasFile)
                        {
                            saveImg(ViewState["image_id"] + imgUpload.PostedFile.FileName);
                        }
                        btnEdit.Visible = false;
                        btnCancelEdit.Visible = false;
                        btnAdd.Visible = true;
                        img.ImageUrl = null;
                        img.Height = 0;
                        img.Width = 0;
                        txtTitle.Text = string.Empty;
                        ViewState["ImageName"] = "0";
                        ViewState["image_id"] = "0";
                        BindGrid();
                    }
                    else
                        lblMsg.Text = "Unsuccessful...please try later!";

                }
                else
                    lblMsg.Text = "Please enter title !";

            }
        }
    }
    protected void btnCancelEdit_Click(object sender, EventArgs e)
    {
        btnEdit.Visible = false;
        btnCancelEdit.Visible = false;
        btnAdd.Visible = true;
        img.ImageUrl = null;
        img.Height = 0;
        img.Width = 0;
        txtTitle.Text = string.Empty;
        ViewState["ImageName"] = "0";
        ViewState["image_id"] = "0";
        BindGrid();
    }


    private void GenerateThumbnails(double scaleFactor, Stream sourcePath, string targetPath)
    {

        using (var image = System.Drawing.Image.FromStream(sourcePath))
        {
            // can give static width (e.g. 1024) of image as we want
            var newWidth = (int)(scaleFactor * image.Width);
            //You can give static height (e.g. 1024) of image as we want
            var newHeight = (int)(scaleFactor * image.Height);
            var thumbnailImg = new Bitmap(newWidth, newHeight);
            var thumbGraph = Graphics.FromImage(thumbnailImg);
            thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
            thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
            thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
            var imageRectangle = new Rectangle(0, 0, newWidth, newHeight);
            thumbGraph.DrawImage(image, imageRectangle);
            thumbnailImg.Save(targetPath, image.RawFormat);


        }
    }
    protected void dtlst_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "Del")
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (id.ToString() != "Del")
            {

                com = new SqlCommand("select imagename from GalleryimageMst where imageid=@imageid", con);
                com.CommandType = CommandType.Text;
                con.Open();
                com.Parameters.AddWithValue("@imageid", id);
                da = new SqlDataAdapter(com);
                dt = new DataTable();
                da.Fill(dt);
                con.Close();
                if (dt.Rows.Count > 0)
                {
                    string filename = dt.Rows[0]["imagename"].ToString();
                    string path = Server.MapPath("~/images/GalleryImages/" + filename);
                    com = new SqlCommand("DelGalleryImg", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@imageid", id);
                    FileInfo info = new FileInfo(path);
                    if (info.Exists)
                    {
                        info.Delete();
                        e.Item.FindControl("ibtnProductImage").Visible = false;
                        e.Item.FindControl("lnkbtnEdit").Visible = false;
                        e.Item.FindControl("lnkbtnStatus").Visible = false;
                        e.Item.FindControl("lnkDelete").Visible = false;

                    }

                    con.Open();
                    com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "image deleted successfully.");
                }
            }
        }


    }
}
