using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;

public partial class user_UploadPANCard : System.Web.UI.Page
{
    SqlConnection con = null;
    InsertFunction insFunc = new InsertFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }

        if (!IsPostBack)
        {
            txtPANDetails.Text = "";
            btnreject.Style.Add("display", "none");
            check_status();
        }

    }

    //reject event for rejecting image
    protected void btnReject_Click(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(method.str);
            string queryr = "select PanImage from scandocs inner join AppMst on Appmst.AppMstID=scandocs.Appmstid where Appmst.AppMstRegNo='" + Session["userId"] + "'";
            SqlCommand cmd1 = new SqlCommand(queryr, con);
            con.Open();
            cmd1.ExecuteScalar();
            using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
            {
                while (reader.Read())
                {
                    string panimage = reader["panImage"].ToString();
                    if (panimage != "")
                    {
                        string imgPath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), panimage);
                        System.IO.File.Delete(imgPath);
                        Response.Write("Image deleted");
                    }
                }
            }
            string upStatus = "Update scandocs set PStatus=0,PanImage=null from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + Session["userId"] + "'";
            SqlCommand cmd = new SqlCommand(upStatus, con);
            con.Open();
            cmd.ExecuteNonQuery();
            txtPANDetails.ReadOnly = false;
            FU1.Enabled = true;
            btnSubmit.Visible = true;
            imgUpload.Visible = false;
            btnreject.Visible = false;
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //check status of approve by admin 
    protected void check_status()
    {
        try
        {
            con = new SqlConnection(method.str);
            string query1 = "select PStatus, panno, panImage from scandocs inner join AppMst on scandocs.Appmstid=Appmst.AppMstID where AppMst.AppMstRegNo='" + Session["userId"] + "'";
            SqlCommand cmd = new SqlCommand(query1, con);
            con.Open();
            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    if (reader["PStatus"].ToString() == "2")
                    {
                        string panno = reader["panno"].ToString();
                        string panimage = reader["panImage"].ToString();
                        txtPANDetails.Text = panno;
                        txtPANDetails.ReadOnly = true;
                        FU1.Enabled = false;
                        btnSubmit.Visible = false;
                        btnreject.Visible = false;
                        if (panimage != "")
                        {
                            imgUpload.ImageUrl = "~/images/KYC/PanImage/" + panimage;
                            imgUpload.Style.Add("display", "block");
                        }
                    }
                    else if (reader["PStatus"].ToString() == "0")
                    {
                        txtPANDetails.Text = reader["panno"].ToString();
                        string strHtml = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Good! </strong> to upload new</div>");
                        confirm.InnerHtml = strHtml;
                        btnSubmit.Style.Add("display", "none");
                        txtPANDetails.ReadOnly = true;
                        imgUpload.Style.Add("display", "none");
                        btnreject.Style.Add("display", "none");
                        //rotateImg.Style.Add("display", "none");
                    }
                    else if (reader["PStatus"].ToString() == "1")
                    {
                        btnreject.Style.Add("display", "block");
                        txtPANDetails.Text = reader["panno"].ToString();
                        txtPANDetails.ReadOnly = true;
                        imgUpload.Style.Add("display", "block");
                        imgUpload.ImageUrl = "~/images/KYC/PanImage/" + reader["panimage"].ToString();
                        btnSubmit.Style.Add("display", "none");
                        //rotateImg.Style.Add("display", "block");
                    }
                    else
                    {
                        txtPANDetails.ReadOnly = false;
                        btnreject.Style.Add("display", "none");
                        txtPANDetails.Text = reader["panno"].ToString();
                        imgUpload.Style.Add("display", "none");
                        //rotateImg.Style.Add("display", "none");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    //submit details with cropped image
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtPANDetails.Text.Trim()))
        {
            string fileName = Path.GetFileName(FU1.PostedFile.FileName);
            string fileExtension = Path.GetExtension(fileName).ToLower();
            string filePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), Guid.NewGuid().ToString() + fileName);
            if (System.IO.File.Exists(filePath))
            {
                System.IO.File.Delete(filePath);

            }
            FU1.PostedFile.SaveAs(filePath);
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

                    string panText = txtPANDetails.Text.Trim();
                    string usrId = Session["userId"].ToString();
                    string imagename = insFunc.insertPanDetail(panText, usrId, fileName);
                    cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), imagename);
                    bitMap.Save(cropFilePath);
                    imgUpload.ImageUrl = "~/images/KYC/PanImage/" + imagename;
                    txtPANDetails.ReadOnly = true;
                    FU1.Enabled = false;
                    btnSubmit.Visible = false;
                    btnreject.Style.Add("display", "block");
                    check_status();
                    string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Pan card uploaded</div>");
                    confirm.InnerHtml = strHtml1;

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
            utility.MessageBox(this, "Please Enter PAN Number.");
            return;
        }
    }

    //not using this method for future referencre
    public void panndetail()
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("checkdoc", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@action", "P");
            cmd.Parameters.AddWithValue("@regno", Session["userId"].ToString());
            SqlDataReader sdr;
            con.Open();
            sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {
                imgUpload.ImageUrl = "~/images/KYC/PanImage/" + sdr["panimage"].ToString();
                txtPANDetails.Text = sdr["panno"].ToString();

            }

            sdr.Close();
            con.Close();
        }
        catch
        {

        }
    }


}