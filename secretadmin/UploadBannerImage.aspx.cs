using System; 
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Data;
using System.IO;
using System.Drawing;

public partial class secretadmin_UploadBannerImage : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    //SqlDataAdapter da;
    //DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindSliderImage();
            BindBannerImage1();
            BindBannerImage2();
            BindBannerImage3();
            BindBannerImage4();
            BindBannerImage5();
        }
    }

    public void BindBannerImage1()
    {
        SqlParameter[] param = new SqlParameter[] {
           // new SqlParameter("@productId", productId) 
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param, "Select url from slidermst where IsMain = 3");
        if (dt.Rows.Count > 0)
        {
            div_Img1.InnerHtml = "<img src='../images/SliderImage/" + dt.Rows[0]["url"].ToString() + "' alt='' width='100%' height='250px' />";

             // div_Img2.ImageUrl = "~/images/SliderImage/" + dt.Rows[0]["url"].ToString();

        }
    }
    public void BindBannerImage2()
    {
        SqlParameter[] param = new SqlParameter[] {
           // new SqlParameter("@productId", productId) 
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param, "Select url from slidermst where IsMain = 4");
        if (dt.Rows.Count > 0)
        {
            div_Img2.InnerHtml = "<img src='../images/SliderImage/" + dt.Rows[0]["url"].ToString() + "' alt='' width='300px' height='250px' />";

            //Image2.ImageUrl = "~/images/SliderImage/" + dt.Rows[0]["url"].ToString();

        }
    }
    public void BindBannerImage3()
    {
        SqlParameter[] param = new SqlParameter[] {
           // new SqlParameter("@productId", productId) 
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param, "Select url,slider from slidermst where IsMain = 5");
        if (dt.Rows.Count > 0)
        {
            txt_url_3.Text= dt.Rows[0]["slider"].ToString();
            div_Img3.InnerHtml = "<img src='../images/SliderImage/" + dt.Rows[0]["url"].ToString() + "' alt='' width='300px' height='250px' />";

            //Image2.ImageUrl = "~/images/SliderImage/" + dt.Rows[0]["url"].ToString();

        }
    }
    public void BindBannerImage4()
    {
        SqlParameter[] param = new SqlParameter[] {
           // new SqlParameter("@productId", productId) 
        };
        

        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param, "Select url,slider from slidermst where IsMain = 6");
        if (dt.Rows.Count > 0)
        {
            txt_url_4.Text= dt.Rows[0]["slider"].ToString();
            div_Img4.InnerHtml = "<img src='../images/SliderImage/" + dt.Rows[0]["url"].ToString() + "' alt='' width='300px' height='250px' />";

            //Image2.ImageUrl = "~/images/SliderImage/" + dt.Rows[0]["url"].ToString();

        }
    }
    public void BindBannerImage5()
    {
        SqlParameter[] param = new SqlParameter[] {
           // new SqlParameter("@productId", productId) 
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param, "Select url,slider from slidermst where IsMain = 7");
        if (dt.Rows.Count > 0)
        {
            txt_url_5.Text = dt.Rows[0]["slider"].ToString();
            div_Img5.InnerHtml = "<img src='../images/SliderImage/" + dt.Rows[0]["url"].ToString() + "' alt='' width='300px' height='250px' />";

            //Image2.ImageUrl = "~/images/SliderImage/" + dt.Rows[0]["url"].ToString();

        }
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        try
        {
            //if (!string.IsNullOrEmpty(txtImgH1.Text.Trim()))
            //{
            //    if (!string.IsNullOrEmpty(txtImgH2.Text.Trim()))
            //    {

            if (FileSliderImage.HasFile && FileSliderImage.PostedFile.ContentLength <= 2000000)
            {
               string FileName= FileSliderImage.PostedFile.FileName;
                if (Regex.Match(FileSliderImage.FileName, @"^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$").Success)
                {
                    Stream stream = FileSliderImage.PostedFile.InputStream;
                    Bitmap bitimg = new Bitmap(stream);
                    int height = bitimg.Height;
                    int width = bitimg.Width;
                    string name= txt_url.Text.Trim();
                    if (width == 1400 && height == 550)
                    {
                        //Image1.ImageUrl = "../ProductImage/" + dt.Rows[0]["gif1"].ToString();

                        cmd = new SqlCommand("UploadSliderImage", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@h1", "");
                        cmd.Parameters.AddWithValue("@h2", "");
                       // cmd.Parameters.AddWithValue("@url", url);

                        cmd.Parameters.AddWithValue("@Url", FileName);
                        cmd.Parameters.AddWithValue("@UploadedDate", DateTime.UtcNow.AddMinutes(330));
                        cmd.Parameters.AddWithValue("@Status", 1);
                        cmd.Parameters.AddWithValue("@IsMain", ddl_type.SelectedValue);
                        cmd.Parameters.AddWithValue("@slider", name);

                        cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        string msg = cmd.Parameters["@flag"].Value.ToString();
                        if (msg == "2")
                        {
                            FileSliderImage.SaveAs(Server.MapPath("~/images/SliderImage/" + FileName));

                            //string path = Server.MapPath("../images/SliderImage/" + FileSliderImage.PostedFile.FileName);
                            //FileSliderImage.SaveAs(path);
                            utility.MessageBox(this, "Slider Image Uploaded Successfully.");

                        }
                        else
                        {
                            utility.MessageBox(this, "File Name Already Exists!");
                            FileSliderImage.Focus();
                            return;
                        }
                    }
                    else
                    {
                        utility.MessageBox(this, "Image size must be width 1400px and height 550px.");
                        FileSliderImage.Focus();
                        return;
                    }
                    BindSliderImage();

                }
                else
                {
                    utility.MessageBox(this, "Only .jpg/.jpeg/.gif/.png file types are allowed.");
                    FileSliderImage.Focus();
                    return;
                }


            }
            else
            {
                utility.MessageBox(this, "Please select an image and image size should be less than 2 MB.");
                FileSliderImage.Focus();
                return;
            }
            //    }
            //    else
            //    {
            //        utility.MessageBox(this, "Please Enter Image Heading 2.");
            //        txtImgH2.Focus();
            //        return;
            //    }
            //}
            //else
            //{
            //    utility.MessageBox(this, "Please Enter Image Heading 1.");
            //    txtImgH1.Focus();
            //    return;
            //}
            txt_url.Text = "";
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.Message);
        }

    }


    public void BindSliderImage()
    {
        try
        {
            SqlParameter[] param111 = new SqlParameter[]
            {
                  new SqlParameter("@IsMain", ddl_type.SelectedValue)
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param111, "FetchSliderImage");
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
            cmd = new SqlCommand("DeactiveSliderImage", con);
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

    protected void ddl_type_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindSliderImage();
    }
    protected void btn_update_Click(object sender, EventArgs e)
    {
        string VideoName = "", strPostedFile1 = "";
        try
        {
            if (Upload_Img1.HasFile)
            {
                Stream stream = Upload_Img1.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 1600 && height == 700)
                {
               
                    string Random = Guid.NewGuid().ToString();
                    VideoName = Random + Path.GetExtension(Upload_Img1.FileName);
                    
                    SqlCommand com = new SqlCommand("Update slidermst set URL=@URL where IsMain=3", con);
                    com.Parameters.AddWithValue("@URL", VideoName);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    if (i == 1)
                    {
                        Upload_Img1.SaveAs(Server.MapPath("~/images/SliderImage/" + VideoName));
                        //strPostedFile1 = Server.MapPath("../images/SliderImage/" + VideoName);
                        //Upload_Img1.SaveAs(strPostedFile1);
                        utility.MessageBox(this, "Banner upload successfully.!");
                        div_Img1.InnerHtml = "<img src='../images/SliderImage/'" + VideoName + "'' alt='' width='100px' height='100px' />";
                        BindBannerImage1();
                    }
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 1600 and height 700.");
                    return;
                }
            }
        }
        catch (Exception er) { utility.MessageBox(this, er.Message); }
    }
    protected void btn_delete_Click(object sender, EventArgs e)
    {

        // string productId = "";
        try
        {
            // productId = Convert.ToString(Request.QueryString["n"]);
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            { // new SqlParameter("@productId", productId)
              };
            DataTable dt = objDu.GetDataTable(param1, "Select URL from slidermst where IsMain=3");
            if (dt.Rows.Count > 0)
            {
                string OldFilepath = Server.MapPath("../images/SliderImage/" + dt.Rows[0]["URL"].ToString());
                FileInfo info = new FileInfo(OldFilepath);
                if (info.Exists)
                {
                    info.Delete();

                    SqlCommand com = new SqlCommand("Update slidermst set URL=null where IsMain=3", con);
                    // com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "Banner Deleted successfully.!");
                }
                else
                {
                    utility.MessageBox(this, "Banner not exists.!");
                }
                div_Img1.InnerHtml = "";
            }
        }
        catch (Exception er) { utility.MessageBox(this, er.Message); }

    }
    protected void btn_update2_Click(object sender, EventArgs e)
    {

        string VideoName = "", strPostedFile1 = "";
        try
        {
            if (Upload_Img2.HasFile)
            {
                Stream stream = Upload_Img2.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 1600 && height == 700)
                {
                    string Random = Guid.NewGuid().ToString();
                    VideoName = Random + Path.GetExtension(Upload_Img2.FileName);
                    //VideoName ="B2"+ this.Upload_Img2.PostedFile.FileName.ToString();
                    //  Title = txt_title2.Text.ToString();                      <a href='<%# Eval("img","~/images/SliderImage/{0}") %>' data-fancybox="gallery">


                    //string[] strFileNames = Directory.GetFiles(Server.MapPath("~/images/SliderImage/"));
                    //strPostedFile1 = Server.MapPath("../images/SliderImage/" + VideoName);

                    // productId = Convert.ToString(Request.QueryString["n"]);

                    SqlCommand com = new SqlCommand("Update slidermst set URL=@URL where IsMain=4", con);
                    com.Parameters.AddWithValue("@URL", VideoName);
                    //com.Parameters.AddWithValue("@Title_gif2", Title);
                    //  com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    if (i == 1)
                    {
                        Upload_Img2.SaveAs(Server.MapPath("~/images/SliderImage/" + VideoName));

                      //  Upload_Img2.SaveAs(strPostedFile1);
                        utility.MessageBox(this, "Banner upload successfully.!");

                        div_Img2.InnerHtml = "<img src='../images/SliderImage/'" + VideoName + "'' alt='' width='100px' height='100px' />";
                        BindBannerImage2();
                        // BindPDFFile();
                    }
                }
                else {
                    utility.MessageBox(this, "Image size must be width 1600 and height 700.");
                    return;
                }
            }
        }
        catch (Exception er) { utility.MessageBox(this, er.Message); }
    }
    protected void btn_delete2_Click(object sender, EventArgs e)
    {

        try
        {
            // productId = Convert.ToString(Request.QueryString["n"]);
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            { // new SqlParameter("@productId", productId)
              };
            DataTable dt = objDu.GetDataTable(param1, "Select URL from slidermst where IsMain=4");
            if (dt.Rows.Count > 0)
            {
                string OldFilepath = Server.MapPath("../images/SliderImage/" + dt.Rows[0]["URL"].ToString());
                FileInfo info = new FileInfo(OldFilepath);
                if (info.Exists)
                {
                    info.Delete();

                    SqlCommand com = new SqlCommand("Update slidermst set URL=null where IsMain=4", con);
                    // com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "Banner Deleted successfully.!");
                }
                else
                {
                    utility.MessageBox(this, "Banner not exists.!");
                }
                div_Img2.InnerHtml = "";
            }
        }
        catch (Exception er) { utility.MessageBox(this, er.Message); }

    }
    protected void btn3_update_Click(object sender, EventArgs e)
    {
        string VideoName = "", strPostedFile1 = ""; 
        try
        {
            if (Upload_Img3.HasFile)
            {
                Stream stream = Upload_Img3.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 420 && height == 500)
                {
                    string Random = Guid.NewGuid().ToString();
                    VideoName = Random + Path.GetExtension(Upload_Img3.FileName); 
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 420 and height 500.");
                    return;
                }
            }
 

            SqlCommand com = new SqlCommand(@"Update slidermst set slider=@slider,
            URL=(Case when @URL='' then URL else @URL end) where IsMain=5", con);
            com.Parameters.AddWithValue("@URL", VideoName);
            com.Parameters.AddWithValue("@slider", txt_url_3.Text.ToString());
            con.Open();
            int i = com.ExecuteNonQuery();
            con.Close();
            if (i == 1)
            {
                if (Upload_Img3.HasFile)
                {
                    Upload_Img3.SaveAs(Server.MapPath("../images/SliderImage/" + VideoName));
                    div_Img3.InnerHtml = "<img src='../images/SliderImage/'" + VideoName + "'' alt='' width='100px' height='100px' />";
                }
                utility.MessageBox(this, "Banner upload successfully.!");
                BindBannerImage3(); 
                //txt_url_3.Text = "";
            } 
        }


        catch (Exception er)  { utility.MessageBox(this, er.Message); }
    }


    protected void btn3_delete_Click(object sender, EventArgs e)
    {
        try
        {
            
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            { // new SqlParameter("@productId", productId)
              };
            DataTable dt = objDu.GetDataTable(param1, "Select URL from slidermst where IsMain=5");
            if (dt.Rows.Count > 0)
            {
                string OldFilepath = Server.MapPath("../images/SliderImage/" + dt.Rows[0]["URL"].ToString());
                FileInfo info = new FileInfo(OldFilepath);
                if (info.Exists)
                {
                    info.Delete();

                    SqlCommand com = new SqlCommand("Update slidermst set URL=null where IsMain=5", con);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "Banner Deleted successfully.!");
                }
                else
                {
                    utility.MessageBox(this, "Banner not exists.!");
                }
                BindBannerImage3();
            }
        }
        catch (Exception er) { utility.MessageBox(this, er.Message); }
    }

    protected void btn4_update_Click(object sender, EventArgs e)
    {
        string VideoName = "", strPostedFile1 = "";
        try
        {
            if (Upload_Img4.HasFile)
            {
                Stream stream = Upload_Img4.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 420 && height == 500)
                {
                    string Random = Guid.NewGuid().ToString();
                    VideoName = Random + Path.GetExtension(Upload_Img4.FileName);
                    //VideoName ="B2"+ this.Upload_Img2.PostedFile.FileName.ToString();
                    //  Title = txt_title2.Text.ToString();                      <a href='<%# Eval("img","~/images/SliderImage/{0}") %>' data-fancybox="gallery">
                    //string Title4 = txt_url_4.Text.ToString();
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 420 and height 500.");
                    return;
                }
            }
                //string[] strFileNames = Directory.GetFiles(Server.MapPath("~/images/SliderImage/"));
                //strPostedFile1 = Server.MapPath("../images/SliderImage/" + VideoName);

                // productId = Convert.ToString(Request.QueryString["n"]);

                SqlCommand com = new SqlCommand(@"Update slidermst set slider=@slider,
            URL=(Case when @URL='' then URL else @URL end) where IsMain=6", con);
                    com.Parameters.AddWithValue("@URL", VideoName);
                    com.Parameters.AddWithValue("@slider", txt_url_4.Text.ToString());
                    //com.Parameters.AddWithValue("@Title_gif2", Title);
                    //  com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    if (i == 1)
                    {
                if (Upload_Img4.HasFile)
                {

                    Upload_Img4.SaveAs(Server.MapPath("~/images/SliderImage/" + VideoName));
                    div_Img4.InnerHtml = "<img src='../images/SliderImage/'" + VideoName + "'' alt='' width='100px' height='100px' />";

                    // Upload_Img4.SaveAs(strPostedFile1);
                    
                }
                utility.MessageBox(this, "Banner upload successfully.!");
                //div_Img4.InnerHtml = "<img src='../images/SliderImage/'" + VideoName + "'' alt='' width='100px' height='100px' />";
                BindBannerImage4();
                        //txt_url_4.Text = "";
                        // BindPDFFile();
                    }
               
            //}
        }
        catch (Exception er) { utility.MessageBox(this, er.Message); }
    }

    protected void btn4_delete_Click(object sender, EventArgs e)
    {

        try
        {
            
            // productId = Convert.ToString(Request.QueryString["n"]);
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            { // new SqlParameter("@productId", productId)
              };
            DataTable dt = objDu.GetDataTable(param1, "Select URL from slidermst where IsMain=6");
            if (dt.Rows.Count > 0)
            {
                string OldFilepath = Server.MapPath("../images/SliderImage/" + dt.Rows[0]["URL"].ToString());
                FileInfo info = new FileInfo(OldFilepath);
                if (info.Exists)
                {
                    info.Delete();

                    SqlCommand com = new SqlCommand("Update slidermst set URL=null where IsMain=6", con);
                    // com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "Banner Deleted successfully.!");
                }
                else
                {
                    utility.MessageBox(this, "Banner not exists.!");
                }
                BindBannerImage4();
            }
        }
        catch (Exception er) { utility.MessageBox(this, er.Message); }
    }
    protected void btn5_update_Click(object sender, EventArgs e)
    {
        string VideoName = "", strPostedFile1 = "";
        try
        {
            if (Upload_Img5.HasFile)
            {
                Stream stream = Upload_Img5.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 420 && height == 500)
                {
                    string Random = Guid.NewGuid().ToString();
                    VideoName = Random + Path.GetExtension(Upload_Img5.FileName);
                    //VideoName ="B2"+ this.Upload_Img2.PostedFile.FileName.ToString();
                    //  Title = txt_title2.Text.ToString();                      <a href='<%# Eval("img","~/images/SliderImage/{0}") %>' data-fancybox="gallery">
                    //string Title5 = txt_url_5.Text.ToString();
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 420 and height 500.");
                    return;
                }
            }
            //string[] strFileNames = Directory.GetFiles(Server.MapPath("~/images/SliderImage/"));
            //strPostedFile1 = Server.MapPath("../images/SliderImage/" + VideoName);
            //
            // productId = Convert.ToString(Request.QueryString["n"]);

            SqlCommand com = new SqlCommand(@"Update slidermst set slider=@slider,
            URL=(Case when @URL='' then URL else @URL end) where IsMain=7", con);
                    com.Parameters.AddWithValue("@URL", VideoName);
                    com.Parameters.AddWithValue("@slider", txt_url_5.Text.ToString());
                    //com.Parameters.AddWithValue("@Title_gif2", Title);
                    //  com.Parameters.AddWithValue("@productId", productId);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    if (i == 1)
                    {
                if (Upload_Img5.HasFile)
                {
                    Upload_Img5.SaveAs(Server.MapPath("~/images/SliderImage/" + VideoName));
                    div_Img5.InnerHtml = "<img src='../images/SliderImage/'" + VideoName + "'' alt='' width='100px' height='100px' />";
                }
                    //Upload_Img5.SaveAs(strPostedFile1);
                    utility.MessageBox(this, "Banner upload successfully.!");

                        //div_Img5.InnerHtml = "<img src='../images/SliderImage/'" + VideoName + "'' alt='' width='100px' height='100px' />";
                        BindBannerImage5();
                       // txt_url_5.Text = "";
                        // BindPDFFile();
                    }
                //}
               
        }
        catch (Exception er) { utility.MessageBox(this, er.Message); }
    }
    protected void btn5_delete_Click(object sender, EventArgs e)
    {

        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            { // new SqlParameter("@productId", productId)
              };
            DataTable dt = objDu.GetDataTable(param1, "Select URL from slidermst where IsMain=7");
            if (dt.Rows.Count > 0)
            {
                string OldFilepath = Server.MapPath("../images/SliderImage/" + dt.Rows[0]["URL"].ToString());
                FileInfo info = new FileInfo(OldFilepath);
                if (info.Exists)
                {
                    info.Delete();

                    SqlCommand com = new SqlCommand("Update slidermst set URL=null where IsMain=7", con);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    utility.MessageBox(this, "Banner Deleted successfully.!");
                }
                else
                {
                    utility.MessageBox(this, "Banner not exists.!");
                }
                BindBannerImage5();

            }
        }
        catch (Exception er) { utility.MessageBox(this, er.Message); }
    }
    protected void btn_update_offer_Click(object sender, EventArgs e)
    {  // string Offer= txt_Offer.Text.Trim();
        SqlCommand com = new SqlCommand("Update paymentmst set offer_title=@offer_title where srno=1 ", con);
        com.Parameters.AddWithValue("@offer_title", txt_Offer.Text.Trim());
        con.Open();
        int i = com.ExecuteNonQuery();
        con.Close();
        if(i==1)
        {
            utility.MessageBox(this, "Offer Updated Successfully.!");
        }
    }

}
