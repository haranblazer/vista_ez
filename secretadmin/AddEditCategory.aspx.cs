using System;
using System.Data.SqlClient;
using System.IO;
using System.Data;
using System.Drawing;

public partial class d2000admin_AddEditCategory : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    string strPostedFile;

    protected void Page_Load(object sender, EventArgs e)
    {
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
                InsertFunction.CheckAdminlogin();
                txtCategoryName.Text = string.Empty;


                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["id"] != null)
                    {
                        BindProduct(Request.QueryString["id"].ToString());
                    }
                }

            }
        }
        catch
        {
        }
    }


    public void BindProduct(String CatId)
    {
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {  new SqlParameter("@CatId", CatId) };
            DataTable dt = objDu.GetDataTable(param1, "select CatName, imagename, IconImg, PriorityDispaly from CategoryMst where CatId=@CatId");
            if (dt.Rows.Count > 0)
            {
                txtCategoryName.Text = dt.Rows[0]["CatName"].ToString();
                div_CatImg.InnerHtml = "<a href='../images/product/icon/" + dt.Rows[0]["imagename"].ToString() + "' data-fancybox='gallery'> <img src='../images/product/icon/" + dt.Rows[0]["imagename"].ToString() + "' alt='img' Width='120px' Height='75px'>  </a>'"; 
                div_IconImg.InnerHtml = "<a href='../images/product/icon/" + dt.Rows[0]["IconImg"].ToString() + "' data-fancybox='gallery'> <img src='../images/product/icon/" + dt.Rows[0]["IconImg"].ToString() + "' alt='img' Width='120px' Height='75px'>  </a>'";  
            }
        }
        catch (Exception er) { }
        {
        }
    }



    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        if (!string.IsNullOrEmpty(txtCategoryName.Text.Trim()))
        {
            if (txtCategoryName.Text.Trim().Length > 0 && txtCategoryName.Text.Trim().Length < 51)
            {
                try
                {

                    String CatImg = "";
                    if (fu_CatImg.HasFile)
                    {
                        Stream stream = fu_CatImg.PostedFile.InputStream;
                        Bitmap bitimg = new Bitmap(stream);
                        int height = bitimg.Height;
                        int width = bitimg.Width;
                        if (width == 1350 && height == 350)
                        {
                            string Random = Guid.NewGuid().ToString();
                            CatImg = Random + Path.GetExtension(fu_CatImg.FileName);
                        }
                        else
                        {
                            utility.MessageBox(this, "Image size must be width 1350px and height 350px.");
                            return;
                        }
                    }


                    String IconImg = "";
                    if (fu_IconImg.HasFile)
                    {
                        Stream stream = fu_IconImg.PostedFile.InputStream;
                        Bitmap bitimg = new Bitmap(stream);
                        int height = bitimg.Height;
                        int width = bitimg.Width;
                        if (width == 40 && height == 40)
                        {
                            string Random = Guid.NewGuid().ToString();
                            IconImg = Random  + Path.GetExtension(fu_IconImg.FileName);
                        }
                        else
                        {
                            utility.MessageBox(this, "Image size must be width 100px and height 100px.");
                            return;
                        }
                    }

                    string CatId = "0";
                    if (Request.QueryString.Count > 0)
                    {
                        if (Request.QueryString["id"] != null)
                            CatId = Request.QueryString["id"].ToString();
                    }
 
                    SqlCommand com = new SqlCommand("AddCategory", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@CatId", CatId);
                    com.Parameters.AddWithValue("@CatName", txtCategoryName.Text.Trim());
                    com.Parameters.AddWithValue("@CatImg", CatImg);
                    com.Parameters.AddWithValue("@IconImg", IconImg);
                    com.Parameters.AddWithValue("@PriorityDispaly", txt_priority.Text.Trim()); 
                    com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                    con.Open();
                    com.ExecuteNonQuery();
                    if (com.Parameters["@flag"].Value.ToString() == "1")
                    {

                        if (fu_CatImg.HasFile)
                        {
                            fu_CatImg.PostedFile.SaveAs(Server.MapPath("../images/product/icon/" + CatImg));
                        }

                        if (fu_IconImg.HasFile)
                        {
                            fu_IconImg.PostedFile.SaveAs(Server.MapPath("../images/product/icon/" + IconImg));
                        }


                        Response.Redirect("CategoryList.aspx"); 
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
            else
            {
                utility.MessageBox(this, "Only 50 characters in category are allowed!");
            }
        }
        else
        {
            utility.MessageBox(this, "Please enter 50 character category !");
        }

    }

    public void resetControls()
    {
        txtCategoryName.Text = string.Empty;
    }

    //private void GenerateThumbnails(double scaleFactor, Stream sourcePath, string targetPath)
    //{

    //    using (var image = System.Drawing.Image.FromStream(sourcePath))
    //    {
    //        // can give static width (e.g. 1024) of image as we want
    //        var newWidth = (int)(scaleFactor * image.Width);
    //        //You can give static height (e.g. 1024) of image as we want
    //        var newHeight = (int)(scaleFactor * image.Height);
    //        var thumbnailImg = new Bitmap(newWidth, newHeight);
    //        var thumbGraph = Graphics.FromImage(thumbnailImg);
    //        thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
    //        thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
    //        thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
    //        var imageRectangle = new System.Drawing.Rectangle(0, 0, newWidth, newHeight);
    //        thumbGraph.DrawImage(image, imageRectangle);
    //        thumbnailImg.Save(targetPath, image.RawFormat);


    //    }
    //}

}