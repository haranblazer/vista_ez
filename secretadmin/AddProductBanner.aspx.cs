using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Policy;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

public partial class secretadmin_AddProductBanner : System.Web.UI.Page
{
    string productId, strFile;
   
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                if (Request.QueryString["n"] != null)
                {
                    InsertFunction.CheckAdminlogin();
                    productId = Convert.ToString(Request.QueryString["n"]);
                    hdn_pid.Value = productId;
                    BindSliderImage();
                }
                else
                {
                    Response.Redirect("ProductList.aspx");
                }
            }
            else
            {
                Response.Redirect("ProductList.aspx");
            }
        }


    }


    protected void lnkDel_Click(object sender, EventArgs e)
    {
        try
        {
            DataListItem item = ((LinkButton)sender).NamingContainer as DataListItem;
            Label lblid = (Label)item.FindControl("lblID");
            System.Web.UI.WebControls.Image imgslide = (System.Web.UI.WebControls.Image)item.FindControl("SliderImage");
            string path = Server.MapPath(imgslide.ImageUrl);
            FileInfo info = new FileInfo(path);
            if (info.Exists)
            {
                info.Delete();
            }
            string id = lblid.Text;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("DeleteProdBanr", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            utility.MessageBox(this, "Deleted Successfully.");
            BindSliderImage();
        }
        catch (Exception ex)
        {

            utility.MessageBox(this, ex.Message);
        }

    }

    [WebMethod]
    public static string Upload_Banner(string Id, string ImgName, string URL)
    {
        string result = "0";
        try
        {
            
          
            if (Id != null)
            {
                SqlConnection con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("UploadProdBanrImg", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PID", Id);
                cmd.Parameters.AddWithValue("@slider", ImgName);
                cmd.Parameters.AddWithValue("@Url", URL);
                cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                result = cmd.Parameters["@flag"].Value.ToString();
            }
        }
        catch (Exception er) { result = er.Message; }
        return result;
    }

    public void BindSliderImage()
    {
        try
        {
           
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP( "FetchProdBanrImg");
            if (dt.Rows.Count > 0)
            {
                dlSliderImage.DataSource = dt;
                dlSliderImage.DataBind();
            }
            else
            {
                dlSliderImage.DataSource = null;
                dlSliderImage.DataBind();
            }
        }
        catch
        {

        }
    }

    //protected void btnUpload_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        //if (!string.IsNullOrEmpty(txtImgH1.Text.Trim()))
    //        //{
    //        //    if (!string.IsNullOrEmpty(txtImgH2.Text.Trim()))
    //        //    {

    //        if (FileSliderImage.HasFile && FileSliderImage.PostedFile.ContentLength <= 2000000)
    //        {
    //            string FileName = FileSliderImage.PostedFile.FileName;
    //            if (Regex.Match(FileSliderImage.FileName, @"^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$").Success)
    //            {
    //                Stream stream = FileSliderImage.PostedFile.InputStream;
    //                Bitmap bitimg = new Bitmap(stream);
    //                int height = bitimg.Height;
    //                int width = bitimg.Width;
    //                string name = txt_url.Text.Trim();
    //                if (width == 1400 && height == 550)
    //                {
    //                    //Image1.ImageUrl = "../ProductImage/" + dt.Rows[0]["gif1"].ToString();

    //                    cmd = new SqlCommand("UploadSliderImage", con);
    //                    cmd.CommandType = CommandType.StoredProcedure;
    //                    cmd.Parameters.AddWithValue("@h1", "");
    //                    cmd.Parameters.AddWithValue("@h2", "");
    //                    // cmd.Parameters.AddWithValue("@url", url);

    //                    cmd.Parameters.AddWithValue("@Url", FileName);
    //                    cmd.Parameters.AddWithValue("@UploadedDate", DateTime.UtcNow.AddMinutes(330));
    //                    cmd.Parameters.AddWithValue("@Status", 1);
    //                    cmd.Parameters.AddWithValue("@IsMain", ddl_type.SelectedValue);
    //                    cmd.Parameters.AddWithValue("@slider", name);

    //                    cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
    //                    con.Open();
    //                    cmd.ExecuteNonQuery();
    //                    con.Close();
    //                    string msg = cmd.Parameters["@flag"].Value.ToString();
    //                    if (msg == "2")
    //                    {
    //                        FileSliderImage.SaveAs(Server.MapPath("~/images/SliderImage/" + FileName));

    //                        //string path = Server.MapPath("../images/SliderImage/" + FileSliderImage.PostedFile.FileName);
    //                        //FileSliderImage.SaveAs(path);
    //                        utility.MessageBox(this, "Slider Image Uploaded Successfully.");

    //                    }
    //                    else
    //                    {
    //                        utility.MessageBox(this, "File Name Already Exists!");
    //                        FileSliderImage.Focus();
    //                        return;
    //                    }
    //                }
    //                else
    //                {
    //                    utility.MessageBox(this, "Image size must be width 1400px and height 550px.");
    //                    FileSliderImage.Focus();
    //                    return;
    //                }
    //                BindSliderImage();

    //            }
    //            else
    //            {
    //                utility.MessageBox(this, "Only .jpg/.jpeg/.gif/.png file types are allowed.");
    //                FileSliderImage.Focus();
    //                return;
    //            }


    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "Please select an image and image size should be less than 2 MB.");
    //            FileSliderImage.Focus();
    //            return;
    //        }
    //        //    }
    //        //    else
    //        //    {
    //        //        utility.MessageBox(this, "Please Enter Image Heading 2.");
    //        //        txtImgH2.Focus();
    //        //        return;
    //        //    }
    //        //}
    //        //else
    //        //{
    //        //    utility.MessageBox(this, "Please Enter Image Heading 1.");
    //        //    txtImgH1.Focus();
    //        //    return;
    //        //}
    //        txt_url.Text = "";
    //    }
    //    catch (Exception ex)
    //    {
    //        utility.MessageBox(this, ex.Message);
    //    }

    //}

}