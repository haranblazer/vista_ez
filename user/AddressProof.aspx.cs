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
using System.Drawing.Drawing2D;

public partial class user_AddressProof : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    InsertFunction inFunc = new InsertFunction();
    protected void Page_Load(object sender, EventArgs e)
    {


        if (Session["userId"] != null)
        {
            if (!IsPostBack)
            {

                //btnreject.Style.Add("display", "none");
                check_status();
                //GetAadharImage();
            }

        }

        else
        {
            Response.Redirect("~/login.aspx");
        }

    }


    protected void check_status()
    {
        try
        {
            con = new SqlConnection(method.str);
            string query1 = "select AaStatus, AadharFront, AadharBack from scandocs inner join AppMst on scandocs.Appmstid=Appmst.AppMstID where AppMst.AppMstRegNo='" + Session["userId"] + "'";
            SqlCommand cmd = new SqlCommand(query1, con);
            con.Open();
            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    if (reader["AaStatus"].ToString() == "2")
                    {
                        string AadharStatus = reader["AaStatus"].ToString();
                        string AadharFrontImage = reader["AadharFront"].ToString();
                        string AadharBackImage = reader["AadharBack"].ToString();
                        if (AadharFrontImage != "" && AadharBackImage != "")
                        {
                            imgUpload2.ImageUrl = "~/images/KYC/AadharImage/Front/" + AadharFrontImage;
                            imgUpload3.ImageUrl = "~/images/KYC/AadharImage/Back/" + AadharBackImage;
                            imgUpload2.Style.Add("display", "block");
                            imgUpload3.Style.Add("display", "block");
                            btnSubmit.Style.Add("display", "none");
                           
                            FU2.Enabled = false;
                            FU3.Enabled = false;
                        }
                    }
                    else if (reader["AaStatus"].ToString() == "1")
                    {
                        imgUpload2.ImageUrl = "~/images/KYC/AadharImage/Front/" + reader["AadharFront"].ToString();
                        imgUpload3.ImageUrl = "~/images/KYC/AadharImage/Back/" + reader["AadharBack"].ToString();
                        btnSubmit.Style.Add("display", "none");
                        btnreject.Style.Add("display", "block");
                        FU2.Enabled = false;
                        FU3.Enabled = false;
                    }
                    else if (reader["AaStatus"].ToString() == "0")
                    {
                        
                        btnSubmit.Style.Add("display", "none");
                        btnreject.Style.Add("display", "none");
                        string strHtml = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Good! </strong> to upload new</div>");
                        confirm.InnerHtml = strHtml;
                        FU2.Enabled = true;
                        FU3.Enabled = true;
                    }
                    else
                    {
                       
                    }

                }

            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(method.str);
            string querry = "select AadharFront, AadharBack from scandocs inner join AppMst on scandocs.Appmstid=Appmst.AppMstID where AppMst.AppMstRegNo='" + Session["userId"] + "'";
            SqlCommand cmd1 = new SqlCommand(querry, con);
            con.Open();
            cmd1.ExecuteScalar();
            using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
            {
                while (reader.Read())
                {
                    string AadharFrontImg = reader["AadharFront"].ToString();
                    string AadharBackImg = reader["AadharBack"].ToString();
                    if (AadharFrontImg != "" && AadharBackImg != "")
                    {
                        string imgPath1 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Front/"), AadharFrontImg);
                        System.IO.File.Delete(imgPath1);
                        string imgPath2 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Back/"), AadharBackImg);
                        System.IO.File.Delete(imgPath2);
                        Response.Write("Image deleted");
                    }
                }
            }
            string upstatus = "Update scandocs set AaStatus=0,AadharFront=null,AadharBack=null from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + Session["userId"] + "'";
            SqlCommand cmd = new SqlCommand(upstatus, con);
            con.Open();
            cmd.ExecuteNonQuery();
            btnSubmit.Visible = true;
            imgUpload2.Visible = false;
            imgUpload3.Visible = false;
            btnreject.Visible = false;
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string fileName1 = Path.GetFileName(FU2.PostedFile.FileName);
        string fileName2 = Path.GetFileName(FU3.PostedFile.FileName);
        string filePath1 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Front/"), Guid.NewGuid().ToString() + fileName1);
        string filePath2 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Back/"), Guid.NewGuid().ToString() + fileName2);
        FU2.PostedFile.SaveAs(filePath1);
        FU3.PostedFile.SaveAs(filePath2);
        string cropFilePath1 = "";
        string cropFilePath2 = "";
        if (!string.IsNullOrEmpty(fileName1) && !string.IsNullOrEmpty(fileName2))
        {
            System.Drawing.Image orgImg = System.Drawing.Image.FromFile(filePath1);
            Rectangle CropArea = new Rectangle(
                Convert.ToInt32(X.Value),
                Convert.ToInt32(Y.Value),
                Convert.ToInt32(W.Value),
                Convert.ToInt32(H.Value));
            System.Drawing.Image orgImg1 = System.Drawing.Image.FromFile(filePath2);
            Rectangle CropArea1 = new Rectangle(
                Convert.ToInt32(X1.Value),
                Convert.ToInt32(Y1.Value),
                Convert.ToInt32(W1.Value),
                Convert.ToInt32(H1.Value));
            try
            {

                Bitmap bitMap = new Bitmap(CropArea.Width, CropArea.Height);
                using (Graphics g = Graphics.FromImage(bitMap))
                {
                    g.DrawImage(orgImg, new Rectangle(0, 0, bitMap.Width, bitMap.Height), CropArea, GraphicsUnit.Pixel);
                }
                Bitmap bitMap1 = new Bitmap(CropArea1.Width, CropArea1.Height);
                using (Graphics g = Graphics.FromImage(bitMap1))
                {
                    g.DrawImage(orgImg1, new Rectangle(0, 0, bitMap1.Width, bitMap1.Height), CropArea1, GraphicsUnit.Pixel);
                }

                string usrId = Session["userId"].ToString();
                string imgFront, imgback, msg;
                inFunc.insertAddressProof(fileName1, fileName2, usrId, out imgFront, out imgback, out msg);
                if (msg == "1")
                {
                    cropFilePath1 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Front/"), imgFront);
                    bitMap.Save(cropFilePath1);
                    imgUpload2.ImageUrl = "~/images/KYC/AadharImage/Front/" + imgFront;
                    cropFilePath2 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Back/"), imgback);
                    bitMap1.Save(cropFilePath2);
                    imgUpload3.ImageUrl = "~/images/KYC/AadharImage/Back/" + imgback;
                    string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Address proof uploaded</div>");
                    confirm.InnerHtml = strHtml1;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
                con.Dispose();

            }
        }
        else
        {
            string strHtml1 = string.Format("<div class='alert alert-danger alert-dismissible' style='background-color: #F12A25;' role='alert'> <strong>Please !</strong>  Select Back Aadhar Image</div>");
            confirm.InnerHtml = strHtml1;
            imgUpload3.Focus();
        }
    }
}