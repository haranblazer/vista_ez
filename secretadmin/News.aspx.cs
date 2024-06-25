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
public partial class admin_News : System.Web.UI.Page
{
    string strPostedFile = string.Empty;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
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
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //if (!string.IsNullOrEmpty(txtDate.Text.Trim()))
        //{
        if (!string.IsNullOrEmpty(txttitle.Text.Trim()))
        {
           
            if (!string.IsNullOrEmpty(txtMsg.Text.Trim()))
            {
                try
                {
                    System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
                    dateInfo.ShortDatePattern = "dd/MM/yyyy";
                    DateTime dt = new DateTime();
                    //try
                    //{
                    //    dt = Convert.ToDateTime(txtDate.Text.Trim(), dateInfo);

                    //}
                    //catch
                    //{
                    //    utility.MessageBox(this,"Invalid date entry.");
                    //    return;
                    //}


                    string lastdayofmonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).AddMonths(1).AddDays(-1).ToString("yyyy-MM-dd");
                    //DateTime dt1 = System.DateTime.UtcNow.AddMinutes(330);
                    //if (Convert.ToDateTime(dt1.ToShortDateString()) <= Convert.ToDateTime(dt.AddMonths(1).ToShortDateString()))
                    //{
                    com = new SqlCommand("sp_News", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@NewsMstValidUpTo", lastdayofmonth);
                    com.Parameters.AddWithValue("@NewsMstTitle", txttitle.Text);
                    com.Parameters.AddWithValue("@NewsMstDiscription", txtMsg.Text.Trim());
                    com.Parameters.AddWithValue("@CurrentRecord", 1);
                    com.Parameters.AddWithValue("@type", ddlNewsType.SelectedValue.ToString());

                    com.Parameters.AddWithValue("@iName", imgUpload.HasFile == false ? "0" : txttitle.Text.Trim().Replace(" ", "").ToString() + System.IO.Path.GetExtension(this.imgUpload.PostedFile.FileName).ToString());

                    com.Parameters.Add("@ImageName", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    con.Open();
                    int p = com.ExecuteNonQuery();
                    if (p > 0)
                    {
                        if (!String.IsNullOrEmpty(com.Parameters["@ImageName"].Value.ToString()))
                        {
                            strPostedFile = (string)com.Parameters["@ImageName"].Value;
                            string targetPath = Server.MapPath("~/images/KYC/News/" + strPostedFile);
                            imgUpload.SaveAs(targetPath);
                            //strPostedFile = (string)cmd.Parameters["@ImageName"].Value;
                            //string targetPath = Server.MapPath("~/CouponIcon/" + strPostedFile);
                            //Stream strm = imgUpload.PostedFile.InputStream;
                            //var targetFile = targetPath;
                            //GenerateThumbnails(0.5, strm, targetFile);
                        }
                        utility.MessageBox(this, "News added successfully!");
                        txttitle.Text = txtMsg.Text = string.Empty;
                        con.Close();
                        //txttitle.Text = a = txtDate.Text = string.Empty;
                    }
                    else
                    {
                        utility.MessageBox(this, "Unsuccessful!");
                    }
                }
                catch (Exception ex)
                {
                }
                //else
                //{
                //    utility.MessageBox(this,"Not a valid date!");
                //}
            }
            else
                utility.MessageBox(this, "Please enter message!");
                txtMsg.Focus();
        }

        else
            utility.MessageBox(this, "Please enter title !");

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
    //        var imageRectangle = new Rectangle(0, 0, newWidth, newHeight);
    //        thumbGraph.DrawImage(image, imageRectangle);
    //        thumbnailImg.Save(targetPath, image.RawFormat);


    //    }
    //}
}
