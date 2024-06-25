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
public partial class admin_modifynews1 : System.Web.UI.Page
{
    string strPostedFile;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    public static string photo;
    string strmin = "";
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
        if (!IsPostBack)
        {
            Session["id"] = Convert.ToString(Request.QueryString["n"]);
            go();
            //txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

        }
    }
    private void go()
    {
        com = new SqlCommand("select NewsMstId,convert(varchar(20),NewsMstValidUpTo,103) as NewsMstValidUpTo,photo,NewsMstTitle,NewsMstDiscription,CurrentRecord,newstype,photo from NewsMst where NewsMstId=@id", con);
        com.Parameters.AddWithValue("@id", Convert.ToInt32(Session["id"]));
        con.Open();
        sdr = com.ExecuteReader();
        if (sdr.Read())
        {
            if (sdr["photo"].ToString() == "0")
            {
                Image1.ImageUrl = "~/images/KYC/News/noimage.png";
            }
            else
            {
                Image1.ImageUrl = "~/images/KYC/News/" + Convert.ToString(sdr["photo"]);
            }
            //Image1.ImageUrl = "~/images/KYC/News/" + Convert.ToString(sdr["photo"]);
            //txtDate.Text = sdr["NewsMstValidUpTo"].ToString();
            txttitle.Text = sdr["NewsMstTitle"].ToString().ToUpper();
            txtMessage.Text = sdr["NewsMstDiscription"].ToString();
            con.Close();
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        DateTime dt = new DateTime();
        try
        {
            
            com = new SqlCommand("UpdateNews", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@NewsMstValidUpTo", strmin);
            com.Parameters.AddWithValue("@NewsMstTitle", txttitle.Text);
            com.Parameters.AddWithValue("@NewsMstDiscription", txtMessage.Text.Trim());
            com.Parameters.AddWithValue("@id", Convert.ToInt32(Session["id"]));

            com.Parameters.AddWithValue("@iName", FileUpload1.HasFile == false ? "0" : txttitle.Text.Trim().Replace(" ", "").ToString() + System.IO.Path.GetExtension(this.FileUpload1.PostedFile.FileName).ToString());

            com.Parameters.Add("@ImageName", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            int p = com.ExecuteNonQuery();
            if (p > 0)
            {
                if (FileUpload1.HasFile)
                {

                    // string s1 = "select photo from newsmst where NewsmstID IN (" +  gvIDs.Substring(0, gvIDs.LastIndexOf(",")) + ")";

                    //com = new SqlCommand(s1,con);
                    // con.Open();
                    // SqlDataReader dr;
                    // dr = com.ExecuteReader();
                    // while (dr.Read())
                    // {

                    //     photo = dr["photo"].ToString();

                    // }

                    // dr.Close();
                    // con.Close();



                    //string path = Server.MapPath(@"~/NotificationImages/" + photo);
                    //FileInfo file = new FileInfo(path);
                    //if (file.Exists)//check file exsit or not
                    //{
                    //    file.Delete();
                    //    ////    lbl_output.Text = file_name + " file deleted successfully";
                    //    ////    lbl_output.ForeColor = Color.Green;
                    //}

                    strPostedFile = (string)com.Parameters["@ImageName"].Value;
                    string targetPath = Server.MapPath("~/images/KYC/News/" + strPostedFile);
                    //strPostedFile = (string)cmd.Parameters["@ImageName"].Value;
                    //string targetPath = Server.MapPath("~/CouponIcon/" + strPostedFile);
                    Stream strm = FileUpload1.PostedFile.InputStream;
                    var targetFile = targetPath;
                    GenerateThumbnails(0.5, strm, targetFile);

                }

                utility.MessageBox(this, "News updated successfully !");
                txttitle.Text = txtMessage.Text = string.Empty;

            }
            else
                utility.MessageBox(this, "Not successful!");

            con.Close();
        }
        catch
        {
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }
        go();
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

}
