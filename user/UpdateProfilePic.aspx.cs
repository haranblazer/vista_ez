using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;


public partial class User_UpdateprofilePic : System.Web.UI.Page
{
    SqlConnection con = null;
    InsertFunction insFunc = new InsertFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/Default.aspx");
        }

        if (!IsPostBack)
        {
            btnreject.Visible = true;
            //panndetail();
            //check_status();
            go();
        }
    }

    private void go()
    {
        try
        {
            con = new SqlConnection(method.str);
            string queryr = "select imagename from Appmst where AppMstRegNo='" + Session["userId"] + "'";
            SqlCommand cmd1 = new SqlCommand(queryr, con);
            con.Open();
            cmd1.ExecuteScalar();
            using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
            {
                while (reader.Read())
                {
                    string profimage = reader["imagename"].ToString();
                    if (profimage != "")
                    {
                        if (profimage == "noimage.png")
                        {
                            imgUpload1.ImageUrl = "~/images/KYC/ProfileImage/" + profimage;
                            System.Web.UI.WebControls.Image imgOnMasterPage = (System.Web.UI.WebControls.Image)(this.Master.FindControl("ProfileImage"));
                            imgOnMasterPage.ImageUrl = "~/images/KYC/ProfileImage/" + profimage;
                            System.Web.UI.WebControls.Image mobimg = (System.Web.UI.WebControls.Image)(this.Master.FindControl("MobProfileImg"));
                            mobimg.ImageUrl = "~/images/KYC/ProfileImage/" + profimage;
                            btnreject.Visible = true;
                        }
                        else
                        {
                            imgUpload1.ImageUrl = "~/images/KYC/ProfileImage/" + profimage;
                            System.Web.UI.WebControls.Image imgOnMasterPage = (System.Web.UI.WebControls.Image)(this.Master.FindControl("ProfileImage"));
                            imgOnMasterPage.ImageUrl = "~/images/KYC/ProfileImage/" + profimage;
                            System.Web.UI.WebControls.Image mobimg = (System.Web.UI.WebControls.Image)(this.Master.FindControl("MobProfileImg"));
                            mobimg.ImageUrl = "~/images/KYC/ProfileImage/" + profimage;
                            btnreject.Visible = true;
                        }
                    }
                    else
                    {
                        imgUpload1.ImageUrl = "~/images/KYC/ProfileImage/noimage.png";
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        try
        {
            DeleteOldImg();

            string upStatus = "Update appmst set imagename='noimage.png' from  AppMst where AppMstRegNo ='" + Session["userId"] + "'";
            SqlCommand cmd = new SqlCommand(upStatus, con);
            con.Open();
            cmd.ExecuteNonQuery();
            picup.Enabled = false;
            btnInsert.Visible = true;
            imgUpload1.Visible = false;
            btnreject.Visible = false;
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        catch (Exception ex)
        {

        }
    }

    private void DeleteOldImg()
    {
        try
        {
            con = new SqlConnection(method.str);
            string queryr = "select imagename from Appmst where AppMstRegNo='" + Session["userId"] + "'";
            SqlCommand cmd1 = new SqlCommand(queryr, con);
            con.Open();
            cmd1.ExecuteScalar();
            using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
            {
                while (reader.Read())
                {
                    string proimage = reader["imagename"].ToString();
                    if (proimage != "")
                    {
                        if (proimage != "noimage.png")
                        {
                            string imgPath = Path.Combine(Server.MapPath("~/images/KYC/ProfileImage/"), proimage);
                            System.IO.File.Delete(imgPath);
                        }

                    }
                }
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //if (picup.HasFile)
        //{
        //    DeleteOldImg();
        //    string fileName = Path.GetFileName(Session["userId"].ToString() + picup.PostedFile.FileName);
        //    string fileExtension = Path.GetExtension(fileName).ToLower();
        //    picup.PostedFile.SaveAs(Server.MapPath("~/images/KYC/ProfileImage/" + fileName));
        //    try
        //    {
        //        insFunc.insertProfileImage(Session["userId"].ToString(), fileName);
        //        imgUpload1.ImageUrl = "~/images/KYC/ProfileImage/" + fileName;
        //        picup.Enabled = false;
        //        btnInsert.Visible = false;
        //        btnreject.Style.Add("display", "block");
        //        string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Profile Pic uploaded</div>");
        //        confirm.InnerHtml = strHtml1;
        //        go();

        //    }
        //    catch (Exception ex)
        //    {
        //        utility.MessageBox(this, ex.Message);
        //        return;
        //    }
        //}
        //else
        //{
        //    utility.MessageBox(this, "Please select a file or click on upload");
        //    return;
        //}

        //Commented by Ajay
        if (picup.HasFile)
        {
            DeleteOldImg();
            Random Random = new Random();
            string fileName = Random.Next().ToString() + Path.GetExtension(picup.FileName);


            //string fileName = Path.GetFileName(picup.PostedFile.FileName);
            //string fileExtension = Path.GetExtension(fileName).ToLower();
            string filePath = Path.Combine(Server.MapPath("~/images/KYC/ProfileImage/"), Random.Next().ToString() + fileName);
            if (System.IO.File.Exists(filePath))
            {
                System.IO.File.Delete(filePath);
            }
            picup.PostedFile.SaveAs(filePath);
            string cropFilePath = "";
            if (!string.IsNullOrEmpty(filePath))
            {
                System.Drawing.Image orgImg = System.Drawing.Image.FromFile(filePath);
                Rectangle CropArea = new Rectangle(
                    Convert.ToInt32(X.Value),
                    Convert.ToInt32(Y.Value),
                    Convert.ToInt32(W.Value),
                    Convert.ToInt32(H.Value));
                try
                {
                    Bitmap bitMap = new Bitmap(CropArea.Width, CropArea.Height);
                    using (Graphics g = Graphics.FromImage(bitMap))
                    {
                        g.DrawImage(orgImg, new Rectangle(0, 0, bitMap.Width, bitMap.Height), CropArea, GraphicsUnit.Pixel);
                    }


                    string usrId = Session["userId"].ToString();
                    string imagename = insFunc.insertProfileImage(usrId, fileName);
                    cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/ProfileImage/"), imagename);
                    bitMap.Save(cropFilePath);
                    imgUpload1.ImageUrl = "~/images/KYC/ProfileImage/" + imagename;
                    picup.Enabled = false;
                    btnInsert.Visible = false;
                    btnreject.Style.Add("display", "block");

                    string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Profile Pic uploaded</div>");
                    confirm.InnerHtml = strHtml1;
                    go();

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else
            {
                utility.MessageBox(this, "Please select a file or click on upload");
                return;
            }
             
        }
        else
        {
            utility.MessageBox(this, "Please select a file or click on upload");
            return;
        }

    }
}