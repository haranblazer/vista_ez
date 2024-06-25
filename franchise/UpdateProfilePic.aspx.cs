using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Web.UI.HtmlControls;


public partial class User_UpdateprofilePic : System.Web.UI.Page
{
    SqlConnection con = null;
    InsertFunction insFunc = new InsertFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Logout.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                btnreject.Visible = true;
                go();
            }
        }
    }

    private void go()
    {
        try
        {
            con = new SqlConnection(method.str);
            string queryr = "select imagename from FranchiseMst where FranchiseId='" + Session["franchiseid"] + "'";
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

            string upStatus = "Update FranchiseMst set imagename='noimage.png' where FranchiseId ='" + Session["franchiseid"] + "'";
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
            string queryr = "select imagename from FranchiseMst where FranchiseId='" + Session["franchiseid"] + "'";
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
        if (picup.HasFile)
        {
            //if (picup.PostedFile.ContentLength > 512000)
            //{
            //    utility.MessageBox(this, "Please select an image size should be less than 500 KB.");
            //    return;
            //}

            DeleteOldImg();

           // Slip = Path.GetFileName(Guid.NewGuid().ToString() + fuUpload.PostedFile.FileName);
            //string fileName = Guid.NewGuid().ToString() + "." + Path.GetExtension(uploadfile.FileName);


            string fileName = Path.GetFileName(Guid.NewGuid().ToString() + picup.PostedFile.FileName);
            //string fileExtension = Path.GetExtension(fileName).ToLower();
            picup.PostedFile.SaveAs(Server.MapPath("~/images/KYC/ProfileImage/" + fileName));
            try
            {
                insFunc.UpdateFranchiseProImg(Session["franchiseid"].ToString(), fileName);
                imgUpload1.ImageUrl = "~/images/KYC/ProfileImage/" + fileName;
                picup.Enabled = false;
                btnInsert.Visible = false;
                btnreject.Style.Add("display", "block");
                string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842; color:#fff;' role='alert'> <strong>Successfully!</strong> Profile Pic uploaded</div>");
                confirm.InnerHtml = strHtml1;
                utility.MessageBox(this, "Successfully! Profile Pic uploaded.");
                Response.Redirect("UpdateprofilePic.aspx");
                // go();
            }
            catch (Exception ex)
            {
                utility.MessageBox(this, ex.Message);
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