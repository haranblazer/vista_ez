using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Data;


public partial class d2000admin_EditProductImage : Page
{
    string productId, strFile;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
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
                    imgUploadMore.Attributes["multiple"] = "multiple";

                    BindProduct();
                    getProductImage();
                    BindPDFFile();
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

    private void BindProduct()
    {
        try
        {
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@productId", productId) };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "Select ProductCode, ProductName, IsVariant=isnull(IsVariant,0) from ShopProductMst where ProductId=@productId");
            if (dt.Rows.Count > 0)
            {
                ddl_SZId.Items.Clear();
                ddl_SZId.Items.Insert(0, new ListItem("No Size", "0"));
                ddl_CLRId.Items.Clear();
                ddl_CLRId.Items.Insert(0, new ListItem("No Color", "0"));

                lblProductName.Text = dt.Rows[0]["ProductCode"].ToString() + " " + dt.Rows[0]["ProductName"].ToString();
                if (dt.Rows[0]["IsVariant"].ToString() == "True")
                {
                    div_ColorSize.Visible = true;
                    BindSize();
                }
                else
                {
                    ddl_SZId.Items.Clear();
                    ddl_CLRId.Items.Clear();
                }
            }
            else
            {

            }
        }
        catch (Exception er) { }
    }


    private void BindSize()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@pid", productId) };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "Get_Size");
        ddl_SZId.Items.Clear();
        ddl_SZId.Items.Insert(0, new ListItem("No Size", "0"));
        if (dt.Rows.Count > 0)
        {
            ddl_SZId.DataSource = dt;
            ddl_SZId.DataTextField = "Size";
            ddl_SZId.DataValueField = "SZId";
            ddl_SZId.DataBind();
        }

        SqlParameter[] param1 = new SqlParameter[] { new SqlParameter("@pid", productId) };
        dt = objDu.GetDataTable(param1, "Select c.CLRId, ColorName=c.ColorName +'    '+  c.ColorCode from batchmst b inner join tbl_Color c on b.CLRId=c.CLRId where productid=@pid");
        ddl_CLRId.Items.Clear();
        ddl_CLRId.Items.Insert(0, new ListItem("No Color", "0"));
        if (dt.Rows.Count > 0)
        {
            ddl_CLRId.DataSource = dt;
            ddl_CLRId.DataTextField = "ColorName";
            ddl_CLRId.DataValueField = "CLRId";
            ddl_CLRId.DataBind();
        }
    }


    public void getProductImage()
    {
        try
        {
            productId = Request.QueryString["n"].ToString();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Srno", productId) };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "getProductImage");
            if (dt.Rows.Count > 0)
            {
              
                dlproductimage.DataSource = dt;
                dlproductimage.DataBind();
                foreach (DataListItem item in dlproductimage.Items)
                {
                    DataRow row = dt.Rows[item.ItemIndex]; // Assuming each item in DataList corresponds to a row in the DataTable



                    TextBox lblPNo = (TextBox)item.FindControl("txt_PNo");
                    lblPNo.Text = row["PriorityNo"].ToString();

                    // Set checkbox checked status based on IsActive value


                    // Use lblID or other data from the row as needed
                }
            }
            else
            {
                dlproductimage.DataSource = null;
                dlproductimage.DataBind();
            }
        }
        catch (Exception er) { }
    }


    private void ProductImageSave(string PId)
    {
        try
        {
            if (imgUploadMore.HasFile == false)
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "key", "<script>alert('No File Uploaded.')</script>", false);
                return;
            }
            else
            {
                HttpFileCollection fileCollection = Request.Files;
                for (int i = 0; i < fileCollection.Count; i++)
                {
                    HttpPostedFile uploadfile = fileCollection[i];
                    //string fileName = Path.GetFileName(uploadfile.FileName);
                    string fileName = Guid.NewGuid().ToString() + Path.GetExtension(uploadfile.FileName);

                    if (uploadfile.ContentLength > 0)
                    {
                        if (imgUploadMore.PostedFile.ContentLength > 512000)
                        {
                            utility.MessageBox(this, "Please select an image size should be less than 500 KB.");
                            return;
                        }

                        Stream stream = uploadfile.InputStream;
                        Bitmap bitimg = new Bitmap(stream);
                        int height = bitimg.Height;
                        int width = bitimg.Width;
                        if (width == 1100 && height == 1100)
                        {
                            productId = Request.QueryString["n"].ToString();

                            com = new SqlCommand("AddProductImageMst", con);
                            com.CommandType = CommandType.StoredProcedure;
                            com.Parameters.AddWithValue("@ProductId", Convert.ToInt32(productId));
                            com.Parameters.AddWithValue("@SZId", ddl_SZId.SelectedValue);
                            com.Parameters.AddWithValue("@CLRId", ddl_CLRId.SelectedValue);
                            com.Parameters.AddWithValue("@PNo", txt_PrNo.Text);
                            
                            com.Parameters.AddWithValue("@ImageName", fileName);
                            com.Parameters.AddWithValue("@Video", "");
                            com.Parameters.AddWithValue("@flags", SqlDbType.VarChar).Direction = ParameterDirection.Output;
                            con.Open();
                            com.ExecuteNonQuery();
                            string result = com.Parameters["@flags"].Value.ToString();
                            con.Close();
                            if (result == "1")
                            {
                                //imgUploadMore.SaveAs(Server.MapPath("~/ProductImage/") + fileName);
                                uploadfile.SaveAs(Server.MapPath("~/ProductImage/") + fileName);

                                //HttpFileCollection _HttpFileCollection = Request.Files;
                                //for (int i = 0; i < _HttpFileCollection.Count; i++)
                                //{
                                //    HttpPostedFile _HttpPostedFile = _HttpFileCollection[i];
                                //    if (_HttpPostedFile.ContentLength > 0)
                                //        _HttpPostedFile.SaveAs(Server.MapPath("~/image/banner/" + Path.GetFileName(_HttpPostedFile.FileName)));
                                //}


                            }
                            else
                            {
                                utility.MessageBox(this, result);
                                return;
                            }
                        }
                        else
                        {
                            utility.MessageBox(this, "Image size must be width 1100px and height 1100px.");
                            getProductImage();
                            return;
                        }
                    }
                    //else
                    //{
                    //    utility.MessageBox(this, "Please select an image size should be less than 500 KB.");
                    //    getProductImage();
                    //    return;
                    //}
                }
                getProductImage();
            }

        }
        catch (Exception er) { }
    }

    protected void lnkupdate_Click(object sender, EventArgs e)
    {
        try
        {
            DataListItem item = ((LinkButton)sender).NamingContainer as DataListItem;
            Label lblId = (Label)item.FindControl("lblId");
            FileUpload imgdlUpload = (FileUpload)item.FindControl("imgdlUpload");
            if (imgdlUpload.HasFile)
            {
                if (imgdlUpload.PostedFile.ContentLength < 512000)
                {
                    Stream stream = imgdlUpload.PostedFile.InputStream;
                    Bitmap bitimg = new Bitmap(stream);
                    int height = bitimg.Height;
                    int width = bitimg.Width;
                    if (width == 350 && height == 425)
                    {
                        // string filename = Path.GetFileName(imgdlUpload.PostedFile.FileName);
                        string filename = Guid.NewGuid().ToString() + Path.GetExtension(imgdlUpload.FileName);
                        productId = Request.QueryString["n"].ToString();
                        com = new SqlCommand("Update ShopProductImageMst set ImageName=@img where SrNo=@SrNo", con);
                        com.Parameters.AddWithValue("@img", lblId.Text + filename);
                        com.Parameters.AddWithValue("@productId", productId);
                        com.Parameters.AddWithValue("@SrNo", lblId.Text);
                        con.Open();
                        int i = com.ExecuteNonQuery();
                        con.Close();
                        if (i == 1)
                        {
                            imgdlUpload.SaveAs(Server.MapPath("~/ProductImage/" + lblId.Text + filename));
                            //utility.MessageBox(this, "Product Image Updated Successfully");
                            getProductImage();
                        }
                        else
                        {
                            utility.MessageBox(this, "Product Image Update Failed !!!");
                        }
                    }
                    else
                    {
                        utility.MessageBox(this, "Image size must be width 1100px and height 1100px.");
                        return;
                    }
                }
                else
                {
                    utility.MessageBox(this, "Image size must be less than 500 KB .");
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

    protected void lnkDel_Click(object sender, EventArgs e)
    {
        try
        {
            DataListItem item = ((LinkButton)sender).NamingContainer as DataListItem;
            Label lblId = (Label)item.FindControl("lblId");

            System.Web.UI.WebControls.Image imgslide = (System.Web.UI.WebControls.Image)item.FindControl("productimage");
            string path = Server.MapPath(imgslide.ImageUrl);
            FileInfo info = new FileInfo(path);
            if (info.Exists)
                info.Delete();

            SqlParameter outparam = new SqlParameter("@strResult", SqlDbType.VarChar, 500);
            outparam.Direction = ParameterDirection.Output; 
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SrNo",lblId.Text), 
                outparam
            };
            DataUtility objDu = new DataUtility();
            string result = objDu.ExecuteSqlSPS(param, "SP_ShopProductImageMst_Delete");

 
            //com = new SqlCommand("Delete ShopProductImageMst where SrNo=@SrNo", con);
            //com.Parameters.AddWithValue("@SrNo", lblId.Text);
            //con.Open();
            //int i = com.ExecuteNonQuery();
            //con.Close();
            //utility.MessageBox(this, "Deleted Successfully.");
            getProductImage();

        }
        catch (Exception er) { }
    }


    protected void lnkPrimaryDef_Click(object sender, EventArgs e)
    {
        try
        {
            DataListItem item = ((LinkButton)sender).NamingContainer as DataListItem;
            Label lblId = (Label)item.FindControl("lblId");

            com = new SqlCommand("SetPrimaryDefaultImage", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@id", lblId.Text);
            con.Open();
            com.ExecuteNonQuery();
            con.Close();

            getProductImage();
        }
        catch (Exception er) { }
    }


    protected void lnkDef_Click(object sender, EventArgs e)
    {
        try
        {
            DataListItem item = ((LinkButton)sender).NamingContainer as DataListItem;
            Label lblId = (Label)item.FindControl("lblId");

            com = new SqlCommand("SetDefaultProductImage", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@id", lblId.Text);
            con.Open();
            com.ExecuteNonQuery();
            con.Close();

            getProductImage();
        }
        catch (Exception er) { }
    }

    private void GenerateThumbnails(double scaleFactor, Stream sourcePath, string targetPath)
    {
        try
        {
            using (var image = System.Drawing.Image.FromStream(sourcePath))
            {
                var newWidth = 350;
                var newHeight = 425;
                var thumbnailImg = new Bitmap(newWidth, newHeight);
                var thumbGraph = Graphics.FromImage(thumbnailImg);
                thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
                thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
                thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
                var imageRectangle = new System.Drawing.Rectangle(0, 0, newWidth, newHeight);
                thumbGraph.DrawImage(image, imageRectangle);
                thumbnailImg.Save(targetPath, image.RawFormat);
            }
        }
        catch
        {

        }
    }

    protected void btaddmore_Click(object sender, EventArgs e)
    {
        ProductImageSave(productId);
    }



    public void BindPDFFile()
    {
        try
        {
            productId = Request.QueryString["n"].ToString();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@productId", productId) };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "Select gif1, Title_gif1,gif2, Title_gif2,gif3, Title_gif3,gif4, Title_gif4, DocName, VideoName from ShopProductMst where ProductId = @ProductId");
            if (dt.Rows.Count > 0)
            {

                Image1.ImageUrl = "../ProductImage/" + dt.Rows[0]["gif1"].ToString();
                txt_title.Text = dt.Rows[0]["Title_gif1"].ToString();
                Image2.ImageUrl = "../ProductImage/" + dt.Rows[0]["gif2"].ToString();
                txt_title2.Text = dt.Rows[0]["Title_gif2"].ToString();
                Image3.ImageUrl = "../ProductImage/" + dt.Rows[0]["gif3"].ToString();
                txt_title3.Text = dt.Rows[0]["Title_gif3"].ToString();
                Image4.ImageUrl = "../ProductImage/" + dt.Rows[0]["gif4"].ToString();
                txt_title4.Text = dt.Rows[0]["Title_gif4"].ToString();
                string DocName = dt.Rows[0]["DocName"].ToString();
                if (!string.IsNullOrEmpty(DocName))
                {
                    li_pdf.InnerHtml = "<a href='../ProductImage/" + dt.Rows[0]["DocName"].ToString() + "' class='youtube1' target='_blank'><i class='fa fa-file-pdf-o'></i></a>";
                }
                else
                {
                    li_pdf.InnerHtml = "";
                }

                if (!string.IsNullOrEmpty(dt.Rows[0]["VideoName"].ToString()))
                {
                    div_VideoThumbnails.InnerHtml = "<img src='../images/video.jpg' alt='' data-bs-toggle='modal' data-bs-target='.bd-example-modal-lg' width='100px' height='100px' />";
                    div_video.InnerHtml = "<video controls='' autoplay='' muted='' loop='' id='myVideo' style='width: 100%;'> <source src='../Productimage/" + dt.Rows[0]["VideoName"].ToString() + "'> </video>";
                }
                else
                {
                    div_VideoThumbnails.InnerHtml = "";
                    div_video.InnerHtml = "";
                }
            }

        }
        catch (Exception er) { }
    }


    protected void btnPdfUpdate_Click(object sender, EventArgs e)
    {
        string DocName = "", strPostedFile1 = "";
        try
        {
            if (pdfUpload.HasFile)
            {
                DocName = this.pdfUpload.PostedFile.FileName.ToString();
                string[] strFileNames = Directory.GetFiles(Server.MapPath("../ProductImage/"));
                strPostedFile1 = Server.MapPath("../ProductImage/" + DocName);
                int flag = 0;
                for (int ctr = 0; ctr < strFileNames.Length; ctr++)
                {
                    string ss = strFileNames[ctr];
                    if (strPostedFile1 == strFileNames[ctr])
                    {
                        flag = 1;
                    }
                }

                if (flag == 1)
                {
                    utility.MessageBox(this, "File already exits with the same name! Please re-name your file!");
                }
                else
                {
                    productId = Convert.ToString(Request.QueryString["n"]);

                    com = new SqlCommand("Update ShopProductMst set DocName=@DocName where ProductId=@ProductId", con);
                    com.Parameters.AddWithValue("@DocName", DocName);
                    com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    if (i == 1)
                    {
                        pdfUpload.SaveAs(strPostedFile1);
                        utility.MessageBox(this, "PDF file upload successfully.!");

                        li_pdf.InnerHtml = "<a href='../ProductImage/" + DocName + "' class='youtube1' target='_blank'><i class='fa fa-file-pdf-o'></i></a>";
                    }
                }
            }
        }
        catch
        {
        }
    }


    protected void btnPdfDelete_Click(object sender, EventArgs e)
    {
        try
        {
            productId = Request.QueryString["n"].ToString();
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {  new SqlParameter("@productId", productId) };
            DataTable dt = objDu.GetDataTable(param1, "Select DocName from ShopProductMst where ProductId=@ProductId");
            if (dt.Rows.Count > 0)
            {
                string OldFilepath = Server.MapPath("../ProductImage/" + dt.Rows[0]["DocName"].ToString());
                FileInfo info = new FileInfo(OldFilepath);
                if (info.Exists)
                {
                    info.Delete();

                    com = new SqlCommand("Update ShopProductMst set DocName=null where ProductId=@ProductId", con);
                    com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "PDF file Deleted successfully.!");
                }
                else
                {
                    utility.MessageBox(this, "PDF file not exists.!");
                }
                li_pdf.InnerHtml = "";
            }
        }
        catch (Exception er) { }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        string VideoName = "", strPostedFile1 = "";
        try
        {
            if (FU_Video.HasFile)
            {
                VideoName = this.FU_Video.PostedFile.FileName.ToString();
                string[] strFileNames = Directory.GetFiles(Server.MapPath("../ProductImage/"));
                strPostedFile1 = Server.MapPath("../ProductImage/" + VideoName);
                int flag = 0;
                for (int ctr = 0; ctr < strFileNames.Length; ctr++)
                {
                    string ss = strFileNames[ctr];
                    if (strPostedFile1 == strFileNames[ctr])
                    {
                        flag = 1;
                    }
                }

                if (flag == 1)
                {
                    utility.MessageBox(this, "File already exits with the same name! Please re-name your file!");
                }
                else
                {
                    productId = Convert.ToString(Request.QueryString["n"]);

                    com = new SqlCommand("Update ShopProductMst set VideoName=@VideoName where ProductId=@ProductId", con);
                    com.Parameters.AddWithValue("@VideoName", VideoName);
                    com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    if (i == 1)
                    {
                        FU_Video.SaveAs(strPostedFile1);
                        utility.MessageBox(this, "Video file upload successfully.!");

                        div_VideoThumbnails.InnerHtml = "<img src='../images/video.jpg' alt='' data-bs-toggle='modal' data-bs-target='.bd-example-modal-lg' width='100px' height='100px' />";
                        div_video.InnerHtml = "<video controls='' autoplay='' muted='' loop='' id='myVideo' style='width: 100%;'> <source src='../Productimage/" + VideoName + "'> </video>";

                        //BindPDFFile();
                        //li_Video.Text = " <img src='../ProductImage/" + VideoName + "' alt=''/>";
                    }
                }
            }
        }
        catch
        {
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            productId = Convert.ToString(Request.QueryString["n"]);
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {  new SqlParameter("@productId", productId) };
            DataTable dt = objDu.GetDataTable(param1, "Select VideoName from ShopProductMst where ProductId=@ProductId");
            if (dt.Rows.Count > 0)
            {
                string OldFilepath = Server.MapPath("../ProductImage/" + dt.Rows[0]["VideoName"].ToString());
                FileInfo info = new FileInfo(OldFilepath);
                if (info.Exists)
                {
                    info.Delete();

                    com = new SqlCommand("Update ShopProductMst set VideoName=null where ProductId=@ProductId", con);
                    com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "Video file Deleted successfully.!");
                }
                else
                {
                    utility.MessageBox(this, "Video file not exists.!");
                }
                li_pdf.InnerHtml = "";
            }
        }
        catch (Exception er) { }

    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        string VideoName = "", strPostedFile1 = "", Title = "", productId = "";
        try
        {

            //SqlParameter[] param = new SqlParameter[] { new SqlParameter("@productId", productId) };
            //DataUtility objDu = new DataUtility();
            //DataTable dt = objDu.GetDataTable(param, "Select gif1, Title_gif1 from ShopProductMst where ProductId = @ProductId");
            //if (dt.Rows.Count > 0)
            //{
            //    string GIF_1 = dt.Rows[0]["gif1"].ToString();
            //    if (!string.IsNullOrEmpty(GIF_1))
            //    {
            //        Image1.ImageUrl = "<img src='../ProductImage/" + dt.Rows[0]["gif1"].ToString() + "' >";
            //    }
            //    else
            //    {
            //        Image1.ImageUrl = "";
            //    }
            //}
            //if (GIF_Upload.HasFile)
            //{
            VideoName = this.GIF_Upload.PostedFile.FileName.ToString();
            Title = txt_title.Text.ToString();

            string[] strFileNames = Directory.GetFiles(Server.MapPath("../ProductImage/"));
            strPostedFile1 = Server.MapPath("../ProductImage/" + VideoName);
            //int flag = 0;
            //for (int ctr = 0; ctr < strFileNames.Length; ctr++)
            //{
            //    string ss = strFileNames[ctr];
            //    if (strPostedFile1 == strFileNames[ctr])
            //    {
            //        flag = 1;
            //    }
            //}

            //if (flag == 1)
            //{
            //    utility.MessageBox(this, "File already exits with the same name! Please re-name your file!");
            //}
            //else
            //{
            productId = Convert.ToString(Request.QueryString["n"]);

            com = new SqlCommand("Update ShopProductMst set gif1=@gif1,Title_gif1=@Title_gif1 where ProductId=@ProductId", con);
            com.Parameters.AddWithValue("@gif1", VideoName);
            com.Parameters.AddWithValue("@Title_gif1", Title);
            com.Parameters.AddWithValue("@productId", productId);
            con.Open();
            int i = com.ExecuteNonQuery();
            con.Close();
            if (i == 1)
            {
               
                GIF_Upload.SaveAs(strPostedFile1);
                utility.MessageBox(this, "Video file upload successfully.!");

                div_GIF1_thumbnail.InnerHtml = "<img src='../ProductImage/'" + VideoName + "'' alt='' width='100px' height='100px' />";
                // div_video.InnerHtml = "<video controls='' autoplay='' muted='' loop='' id='myVideo' style='width: 100%;'> <source src='../Productimage/" + VideoName + "'> </video>";
                BindPDFFile();
                //BindPDFFile();
                //li_Video.Text = " <img src='../ProductImage/" + VideoName + "' alt=''/>";
            }
        }

        //}
        catch
        {
        }

    }


    protected void Button4_Click(object sender, EventArgs e)
    {
        string productId = "";
        try
        {
            productId = Convert.ToString(Request.QueryString["n"]);
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {  new SqlParameter("@productId", productId) };
            DataTable dt = objDu.GetDataTable(param1, "Select Title_gif1,gif1 from ShopProductMst where ProductId=@ProductId");
            if (dt.Rows.Count > 0)
            {
                string OldFilepath = Server.MapPath("../ProductImage/" + dt.Rows[0]["gif1"].ToString());
                FileInfo info = new FileInfo(OldFilepath);
                if (info.Exists)
                {
                    info.Delete();

                    com = new SqlCommand("Update ShopProductMst set Title_gif1=null,gif1=null where ProductId=@ProductId", con);
                    com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "Video file Deleted successfully.!");
                }
                else
                {
                    utility.MessageBox(this, "Video file not exists.!");
                }
                div_VideoThumbnails.InnerHtml = "";
            }
        }
        catch (Exception er) { }

    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        string VideoName = "", strPostedFile1 = "", Title = "", productId = "";
        try
        {
            VideoName = this.GIF_Upload2.PostedFile.FileName.ToString();
            Title = txt_title2.Text.ToString();

            string[] strFileNames = Directory.GetFiles(Server.MapPath("../ProductImage/"));
            strPostedFile1 = Server.MapPath("../ProductImage/" + VideoName);

            productId = Convert.ToString(Request.QueryString["n"]);

            com = new SqlCommand("Update ShopProductMst set gif2=@gif2,Title_gif2=@Title_gif2 where ProductId=@ProductId", con);
            com.Parameters.AddWithValue("@gif2", VideoName);
            com.Parameters.AddWithValue("@Title_gif2", Title);
            com.Parameters.AddWithValue("@productId", productId);
            con.Open();
            int i = com.ExecuteNonQuery();
            con.Close();
            if (i == 1)
            {
                GIF_Upload2.SaveAs(strPostedFile1);
                utility.MessageBox(this, "Video file upload successfully.!");

                div_gif2.InnerHtml = "<img src='../ProductImage/'" + VideoName + "'' alt='' width='100px' height='100px' />";
                BindPDFFile();
            }
        }


        catch
        {
        }
    }

    protected void Button6_Click(object sender, EventArgs e)
    {
        string productId = "";
        try
        {
            productId = Convert.ToString(Request.QueryString["n"]);
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {  new SqlParameter("@productId", productId) };
            DataTable dt = objDu.GetDataTable(param1, "Select Title_gif2,gif2 from ShopProductMst where ProductId=@ProductId");
            if (dt.Rows.Count > 0)
            {
                string OldFilepath = Server.MapPath("../ProductImage/" + dt.Rows[0]["gif2"].ToString());
                FileInfo info = new FileInfo(OldFilepath);
                if (info.Exists)
                {
                    info.Delete();

                    com = new SqlCommand("Update ShopProductMst set Title_gif2=null,gif2=null where ProductId=@ProductId", con);
                    com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "Video file Deleted successfully.!");
                }
                else
                {
                    utility.MessageBox(this, "Video file not exists.!");
                }
                div_gif2.InnerHtml = "";
            }
        }
        catch (Exception er) { }


    }

    protected void Button7_Click(object sender, EventArgs e)
    {
        string VideoName = "", strPostedFile1 = "", Title = "", productId = "";
        try
        {
            VideoName = this.GIF_Upload3.PostedFile.FileName.ToString();
            Title = txt_title3.Text.ToString();

            string[] strFileNames = Directory.GetFiles(Server.MapPath("../ProductImage/"));
            strPostedFile1 = Server.MapPath("../ProductImage/" + VideoName);

            productId = Convert.ToString(Request.QueryString["n"]);

            com = new SqlCommand("Update ShopProductMst set gif3=@gif3,Title_gif3=@Title_gif3 where ProductId=@ProductId", con);
            com.Parameters.AddWithValue("@gif3", VideoName);
            com.Parameters.AddWithValue("@Title_gif3", Title);
            com.Parameters.AddWithValue("@productId", productId);
            con.Open();
            int i = com.ExecuteNonQuery();
            con.Close();
            if (i == 1)
            {
                GIF_Upload3.SaveAs(strPostedFile1);
                utility.MessageBox(this, "Video file upload successfully.!");

                div_gif3.InnerHtml = "<img src='../ProductImage/'" + VideoName + "'' alt='' width='100px' height='100px' />";
                BindPDFFile();
            }
        }


        catch
        {
        }
    }

    protected void Button8_Click(object sender, EventArgs e)
    {
        string productId = "";
        try
        {
            productId = Convert.ToString(Request.QueryString["n"]);
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {  new SqlParameter("@productId", productId) };
            DataTable dt = objDu.GetDataTable(param1, "Select Title_gif3,gif3 from ShopProductMst where ProductId=@ProductId");
            if (dt.Rows.Count > 0)
            {
                string OldFilepath = Server.MapPath("../ProductImage/" + dt.Rows[0]["gif3"].ToString());
                FileInfo info = new FileInfo(OldFilepath);
                if (info.Exists)
                {
                    info.Delete();

                    com = new SqlCommand("Update ShopProductMst set Title_gif3=null,gif3=null where ProductId=@ProductId", con);
                    com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "Video file Deleted successfully.!");
                }
                else
                {
                    utility.MessageBox(this, "Video file not exists.!");
                }
                div_gif3.InnerHtml = "";
            }
        }
        catch (Exception er) { }

    }

    protected void Button9_Click(object sender, EventArgs e)
    {
        string VideoName = "", strPostedFile1 = "", Title = "", productId = "";
        try
        {
            VideoName = this.GIF_Upload4.PostedFile.FileName.ToString();
            Title = txt_title4.Text.ToString();

            string[] strFileNames = Directory.GetFiles(Server.MapPath("../ProductImage/"));
            strPostedFile1 = Server.MapPath("../ProductImage/" + VideoName);

            productId = Convert.ToString(Request.QueryString["n"]);

            com = new SqlCommand("Update ShopProductMst set gif4=@gif4,Title_gif4=@Title_gif4 where ProductId=@ProductId", con);
            com.Parameters.AddWithValue("@gif4", VideoName);
            com.Parameters.AddWithValue("@Title_gif4", Title);
            com.Parameters.AddWithValue("@productId", productId);
            con.Open();
            int i = com.ExecuteNonQuery();
            con.Close();
            if (i == 1)
            {
                GIF_Upload4.SaveAs(strPostedFile1);
                utility.MessageBox(this, "Video file upload successfully.!");

                div_gif4.InnerHtml = "<img src='../ProductImage/'" + VideoName + "'' alt='' width='100px' height='100px' />";
                BindPDFFile();
            }
        }


        catch
        {
        }
    }

    protected void Button10_Click(object sender, EventArgs e)
    {
        string productId = "";
        try
        {
            productId = Convert.ToString(Request.QueryString["n"]);
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {  new SqlParameter("@productId", productId) };
            DataTable dt = objDu.GetDataTable(param1, "Select Title_gif4,gif4 from ShopProductMst where ProductId=@ProductId");
            if (dt.Rows.Count > 0)
            {
                string OldFilepath = Server.MapPath("../ProductImage/" + dt.Rows[0]["gif4"].ToString());
                FileInfo info = new FileInfo(OldFilepath);
                if (info.Exists)
                {
                    info.Delete();

                    com = new SqlCommand("Update ShopProductMst set Title_gif4=null,gif4=null where ProductId=@ProductId", con);
                    com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "Video file Deleted successfully.!");
                }
                else
                {
                    utility.MessageBox(this, "Video file not exists.!");
                }
                div_gif3.InnerHtml = "";
            }
        }
        catch (Exception er) { }

    }

    protected void txt_PNo_TextChanged(object sender, EventArgs e)
    {
        TextBox PNO = (TextBox)sender;

        DataListItem item = (DataListItem)PNO.NamingContainer;
        TextBox txt_PNo = (TextBox)item.FindControl("txt_PNo");
        Label lblID = (Label)item.FindControl("lblId");
        // int statusValue = chkStatus.Checked ? 1 : 0;

        try
        {
            SqlParameter[] param111 = new SqlParameter[]
            {
              new SqlParameter("@srno", lblID.Text),
               new SqlParameter("@PNo", txt_PNo.Text)
            };
           
            //ShopProductImageMst add PriorityNo int
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param111, "Update ShopProductImageMst set PriorityNo=@PNo where srno=@srno");

            dlproductimage.DataSource = dt;
            dlproductimage.DataBind();
            getProductImage();
        }
        catch (Exception ex)
        {
            // Handle the exception
        }
    }
}
