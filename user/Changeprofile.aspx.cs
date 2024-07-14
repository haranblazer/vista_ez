using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Web.Services;

public partial class user_Changeprofile : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlCommand cmd;
    SqlDataReader sdr;
    SqlDataAdapter da;
    DataTable dt;
    InsertFunction insFunc = new InsertFunction();

    string str1;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            str1 = Convert.ToString(Session["userId"]);
            hfuserid.Value = Convert.ToString(Session["userId"]);

            if (str1 == "")
                Response.Redirect("~/login.aspx");
            else

                if (!Page.IsPostBack)
            {
                txtDOB.Text = DateTime.Now.AddYears(-18).ToString("dd/MM/yyyy").Replace("-", "/");

                BindBank();
                CheckStatus();
                BindState();
                BindData();
                bankdetail();

                confirm.Visible = false;
                if (Regex.Match(str1, @"^[a-zA-Z0-9]*$").Success)
                {
                    go();
                }

                else
                {
                    lblMessage.Text = "INVALID ID";
                }

            }
        }
        catch (Exception ex)
        {

        }
    }

    #region CheckProfileEdit
    private void CheckStatus()
    {
        con = new SqlConnection(method.str);
        string quer = @"select s.bankstatus as bkstatus, panno, s.pstatus as pkstatus, panImage,
        s.BankImage, Aadharfront, AadharBack, s.aastatus as aastatus,
        OnlinePanVerify=isnull(s.OnlinePanVerify,0), OnlineAadharVerify=isnull(s.OnlineAadharVerify,0),
        s.GST_Img, a.GST, GST_Status=isnull(s.GST_Status,0)
        from scandocs s inner join AppMst a on s.Appmstid=a.AppMstID 
        where a.AppMstRegNo='" + Session["userId"] + "'";
        SqlCommand cmd1 = new SqlCommand(quer, con);
        con.Open();
        cmd1.ExecuteScalar();
        using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
        {
            while (reader.Read())
            {
                string bkstatus = reader["bkstatus"].ToString();
                string bankImg = reader["BankImage"].ToString();
                string pstatus = reader["pkstatus"].ToString();
                string aastatus = reader["aastatus"].ToString();

                string OnlinePanVerify = reader["OnlinePanVerify"].ToString();
                string OnlineAadharVerify = reader["OnlineAadharVerify"].ToString();

                string GST_Status = reader["GST_Status"].ToString();
                string GST_Img = reader["GST_Img"].ToString();
                txt_GSTNo.Text = reader["GST"].ToString();

                if (pstatus == "2" || OnlinePanVerify == "1")
                {
                    string panimage = reader["panImage"].ToString();
                    txtPANDetails.ReadOnly = true;
                    FU1.Enabled = false;
                    //btnSubmit.Visible = false;
                    btnreject.Visible = false;
                    if (panimage != "")
                    {
                        imgUpload.ImageUrl = "~/images/KYC/PanImage/" + panimage;
                        imgUpload.Style.Add("display", "block");
                    }
                    else
                    {
                        imgUpload.Style.Add("display", "none");
                    }
                    if (OnlinePanVerify == "1")
                    {
                        lbl_OnlinePanMsg.Text = "Online Verified";
                    }
                    approveRejectimg.Src = "~/images/ApproveGreen.png";
                }
                else if (pstatus == "0")
                {
                    string strHtml = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Good! </strong> to upload</div>");
                    confirm.InnerHtml = strHtml;
                    Button1.Style.Add("display", "none");
                    txtPANDetails.ReadOnly = false;
                    btnreject.Style.Add("display", "none");
                    approveRejectimg.Src = "~/images/rejectStamp.png";
                }
                else if (pstatus == "1")
                {
                    btnreject.Style.Add("display", "block");
                    txtPANDetails.ReadOnly = true;
                    FU1.Enabled = false;
                    imgUpload.Style.Add("display", "block");
                    hiddenpanimg.Value = reader["panimage"].ToString();
                    imgUpload.ImageUrl = "~/images/KYC/PanImage/" + reader["panimage"].ToString();
                    Button1.Style.Add("display", "none");
                    btnreject.Style.Add("display", "block");
                    approveRejectimg.Src = "~/images/pendingStamp.png";
                    //rotateImg.Style.Add("display", "block");
                }



                if (bkstatus == "0")
                {
                    bankdetail();
                    imgUpload1.Style.Add("display", "none");
                    btnreject1.Style.Add("display", "none");
                    approveRejectImg1.Src = "~/images/rejectStamp.png";
                }
                else if (bkstatus == "1")
                {
                    bankdetail();
                    ddlBankName.Enabled = false;
                    ddlAcType.Enabled = false;
                    txtAccNo.Enabled = false;
                    txtbranch.Enabled = false;
                    txtifs.Enabled = false;
                    fileCancelCq.Enabled = false;
                    imgUpload1.Style.Add("display", "block");
                    imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + bankImg;
                    //rotateImg.Style.Add("display", "block");
                    btnreject1.Style.Add("display", "block");
                    approveRejectImg1.Src = "~/images/pendingStamp.png";
                }
                else if (bkstatus == "2")
                {
                    ddlBankName.Enabled = false;
                    ddlAcType.Enabled = false;
                    txtAccNo.Enabled = false;
                    txtbranch.Enabled = false;
                    txtifs.Enabled = false;
                    fileCancelCq.Enabled = false;
                    ddlAcType.Enabled = false;
                    btnreject1.Visible = false;
                    if (bankImg != "")
                    {
                        imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + bankImg;
                        approveRejectImg1.Src = "~/images/ApproveGreen.png";
                    }
                }



                if (aastatus == "2" || OnlineAadharVerify == "1")
                {
                    txtAadharNo.Enabled = false;
                    approveRejectImg2.Src = "~/images/ApproveGreen.png";
                    imgUpload2.ImageUrl = "~/images/KYC/AadharImage/Front/" + reader["AadharFront"].ToString();
                    imgUpload3.ImageUrl = "~/images/KYC/AadharImage/Back/" + reader["AadharBack"].ToString();
                    FU2.Enabled = false;
                    FU3.Enabled = false;
                    if (OnlineAadharVerify == "1")
                        lbl_OnlineAadharMsg.Text = "Online Verified";
                }
                else if (aastatus == "0")
                {
                    Button6.Style.Add("display", "none");
                    btnreject2.Style.Add("display", "none");
                    FU2.Enabled = true;
                    FU3.Enabled = true;
                    approveRejectImg2.Src = "~/images/rejectStamp.png";
                }
                else if (aastatus == "1")
                {
                    txtAadharNo.Enabled = false;
                    imgUpload2.ImageUrl = "~/images/KYC/AadharImage/Front/" + reader["AadharFront"].ToString();
                    imgUpload3.ImageUrl = "~/images/KYC/AadharImage/Back/" + reader["AadharBack"].ToString();
                    Button6.Style.Add("display", "none");
                    btnreject2.Style.Add("display", "block");
                    FU2.Enabled = false;
                    FU3.Enabled = false;
                    approveRejectImg2.Src = "~/images/pendingStamp.png";
                }


                if (GST_Status == "2")
                {
                    txt_GSTNo.ReadOnly = true;
                    FU_GST.Enabled = false;
                    if (GST_Img != "")
                    {
                        Img_GST.ImageUrl = "~/images/KYC/PanImage/" + GST_Img;
                        Img_GST.Style.Add("display", "block");
                    }
                    else
                        Img_GST.Style.Add("display", "none");

                    approveReject_GST_Img.Src = "~/images/ApproveGreen.png";
                }
                else if (GST_Status == "0")
                {
                    Img_GST.Style.Add("display", "none");
                    txt_GSTNo.ReadOnly = false;
                    btn_Reject_GST.Style.Add("display", "none");
                    approveReject_GST_Img.Src = "~/images/rejectStamp.png";
                }
                else if (GST_Status == "1")
                {
                    btn_Reject_GST.Style.Add("display", "block");
                    txt_GSTNo.ReadOnly = true;
                    FU_GST.Enabled = false;
                    Img_GST.Style.Add("display", "block");
                    Img_GST.ImageUrl = "~/images/KYC/PanImage/" + GST_Img;
                    approveReject_GST_Img.Src = "~/images/pendingStamp.png";
                }



                if (pstatus == "2" && bkstatus == "2" && aastatus == "2" && GST_Status == "2")
                {
                    txtotp.Visible = false;
                    ddlGtitle.Enabled = false;
                    //branch.Enabled = false;
                    txtAadharNo.Enabled = false;
                    // ddlBankName.Enabled = false;
                    // ddlAccountType.Enabled = false;
                    //acno.Enabled = false;
                    title.Enabled = false;
                    txtFirstName.Enabled = false;
                    txtGName.Enabled = false;
                    txtpincode.Enabled = false;
                    ddlState.Enabled = false;
                    ddlDistrict.Enabled = false;
                    txtOccupation.Enabled = false;
                    //flup.Enabled = false;
                    rbtnGender.Enabled = false;
                    RdoMarital.Enabled = false;
                    txtAddress.Enabled = false;
                    txtMobile.Enabled = false;
                    txtEmail.Enabled = false;
                    txtnomniName.Enabled = false;
                    txtrelation.Enabled = false;
                    txtCity.Enabled = false;
                    txtDOB.Enabled = false;
                    //txtIFSCode.Enabled = false;
                    // panno.Enabled = false;
                    //btnSubmit.Enabled = false;
                    txtpassword.Enabled = false;
                    txtepassword.Enabled = false;
                    txtAadharNo.Enabled = false;
                    approveRejectImg2.Src = "~/images/ApproveGreen.png";
                    ddlBankName.Enabled = false;
                    ddlAcType.Enabled = false;
                    txtAccNo.Enabled = false;
                    txtbranch.Enabled = false;
                    txtifs.Enabled = false;
                    fileCancelCq.Enabled = false;
                    ddlAcType.Enabled = false;
                    btnreject1.Visible = false;
                    approveRejectImg1.Src = "~/images/ApproveGreen.png";
                    txtPANDetails.ReadOnly = true;
                    FU1.Enabled = false;
                    //btnSubmit.Visible = false;
                    btnreject.Visible = false;
                    approveRejectimg.Src = "~/images/ApproveGreen.png";
                    FU2.Enabled = false;
                    FU3.Enabled = false;

                }
            }
        }
    }
    #endregion
    private void go()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("CheckSponsor1", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@sid", str1);
            con.Open();
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {

                if (sdr["Verified"].ToString() == "1")
                {
                    txtotp.Visible = false;
                    ddlGtitle.Enabled = false;
                    //branch.Enabled = false;
                    txtAadharNo.Enabled = false;
                    // ddlBankName.Enabled = false;
                    // ddlAccountType.Enabled = false;
                    //acno.Enabled = false;
                    title.Enabled = false;
                    txtFirstName.Enabled = false;
                    txtGName.Enabled = false;
                    txtpincode.Enabled = false;
                    ddlState.Enabled = false;
                    ddlDistrict.Enabled = false;
                    txtOccupation.Enabled = false;
                    //flup.Enabled = false;
                    rbtnGender.Enabled = false;
                    RdoMarital.Enabled = false;
                    txtAddress.Enabled = false;
                    txtMobile.Enabled = false;
                    txtEmail.Enabled = false;
                    txtnomniName.Enabled = false;
                    txtrelation.Enabled = false;
                    txtCity.Enabled = false;
                    txtDOB.Enabled = false;
                    //txtIFSCode.Enabled = false;
                    // panno.Enabled = false;
                    //btnSubmit.Enabled = false;
                    txtpassword.Enabled = false;
                    txtepassword.Enabled = false;
                    txtAadharNo.Enabled = false;
                    approveRejectImg2.Src = "~/images/ApproveGreen.png";
                    ddlBankName.Enabled = false;
                    ddlAcType.Enabled = false;
                    txtAccNo.Enabled = false;
                    txtbranch.Enabled = false;
                    txtifs.Enabled = false;
                    fileCancelCq.Enabled = false;
                    ddlAcType.Enabled = false;
                    btnreject1.Visible = false;
                    approveRejectImg1.Src = "~/images/ApproveGreen.png";
                    txtPANDetails.ReadOnly = true;
                    FU1.Enabled = false;
                    //btnSubmit.Visible = false;
                    btnreject.Visible = false;
                    approveRejectimg.Src = "~/images/ApproveGreen.png";
                    FU2.Enabled = false;
                    FU3.Enabled = false;
                }



                //if (sdr["isProUp"].ToString() == "1")
                //{
                //    // btn.Text = "Generate OTP";
                //    // btn.Visible = true;
                //    btnSubmit.Visible = false;
                //    txtotp.Visible = false;
                //    ddlGtitle.Enabled = false;
                //    //branch.Enabled = true;
                //    //txtAadharNo.Enabled = true;
                //    //ddlBankName.Enabled = true;
                //    //ddlAccountType.Enabled = true;
                //    //acno.Enabled = true;
                //    title.Enabled = false;
                //    txtFirstName.Enabled = false;
                //    txtGName.Enabled = false;
                //    txtpincode.Enabled = false;
                //    ddlState.Enabled = false;
                //    ddlDistrict.Enabled = false;
                //    txtOccupation.Enabled = false;
                //    //flup.Enabled = true;
                //    rbtnGender.Enabled = false;
                //    RdoMarital.Enabled = false;
                //    txtAddress.Enabled = false;
                //    txtMobile.Enabled = false;
                //    txtEmail.Enabled = false;
                //    txtnomniName.Enabled = false;
                //    txtrelation.Enabled = false;
                //    txtCity.Enabled = false;
                //    txtDOB.Enabled = false;
                //    RdoGenderNew.Enabled = false;
                //    //txtIFSCode.Enabled = true;
                //    //panno.Enabled = true;ddlGtitle
                //    //btnSubmit.Enabled = false;
                //    ottp.Visible = false;
                //}
                title.SelectedValue = sdr["AppMstTitle"].ToString();
                //title.SelectedIndex = title.Items.IndexOf(title.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["AppMstTitle"].ToString(), true) == 0).FirstOrDefault());
                // ddlGtitle.SelectedIndex = ddlGtitle.Items.IndexOf(ddlGtitle.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["gtitle"].ToString(), true) == 0).FirstOrDefault());
                //ddlMtitle.SelectedIndex = ddlMtitle.Items.IndexOf(ddlMtitle.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["gtitle"].ToString(), true) == 0).FirstOrDefault());
                //ddlAccountType.SelectedIndex = ddlAccountType.Items.IndexOf(ddlAccountType.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["type"].ToString(), true) == 0).FirstOrDefault());
                //ddlProof.SelectedIndex = ddlProof.Items.IndexOf(ddlProof.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["proofType"].ToString(), true) == 0).FirstOrDefault());
                //ddlProof.Enabled = false;
                ddlGtitle.SelectedValue = sdr["gtitle"].ToString();
                try
                {
                    txtDOB.Text = sdr["userdob"].ToString();
                }
                catch (Exception ex)
                {
                }
                lblid.Text = Session["userId"].ToString();
                lbl_username.Text = sdr["AppMstFName"].ToString();
                txtpassword.Text = sdr["appmstpassword"].ToString();
                //txtIFSCode.Text = sdr["IFSCode"].ToString();

                txtFirstName.Text = sdr["AppMstFName"].ToString();
                txtGName.Text = sdr["GName"].ToString();
                //txtMName.Text = sdr["MName"].ToString();
                //txtOccupation.Text = sdr["Occupation"].ToString();
                //rbtnGender.SelectedIndex = rbtnGender.Items.IndexOf(rbtnGender.Items.FindByValue(sdr["Gender"].ToString()));
                //RdoMarital.SelectedIndex = RdoMarital.Items.IndexOf(RdoMarital.Items.FindByValue(sdr["MStatus"].ToString()));
                RdoGenderNew.SelectedValue = sdr["Gender"].ToString();
                txtAddress.Text = sdr["AppMstAddress1"].ToString();
                txtMobile.Text = sdr["AppMstMobile"].ToString();
                txtpincode.Text = sdr["AppMstPinCode"].ToString();
                //branch.Text = sdr["branch"].ToString();

                //acno.Text = sdr["acountno"].ToString();

                //panno.Text = sdr["panno"].ToString();
                txtPANDetails.Text = sdr["panno"].ToString();

                txtAadharNo.Text = sdr["Aadharno"].ToString();

                txtEmail.Text = sdr["email"].ToString();
                txtnomniName.Text = sdr["nom_name"].ToString();
                txtrelation.Text = sdr["nom_rela"].ToString();
                txtCity.Text = sdr["appmstcity"].ToString();
                txtepassword.Text = sdr["ePassword"].ToString();
                //rbpanlist.SelectedIndex = rbpanlist.Items.IndexOf(rbpanlist.Items.FindByValue(sdr["panstatus"].ToString()));

                System.Web.UI.WebControls.Image imgOnMasterPage = (System.Web.UI.WebControls.Image)(this.Master.FindControl("ProfileImage"));
                System.Web.UI.WebControls.Image mobimg = (System.Web.UI.WebControls.Image)(this.Master.FindControl("MobProfileImg"));
                if (imgOnMasterPage != null)
                {
                    imgOnMasterPage.ImageUrl = mobimg.ImageUrl = "~/images/KYC/ProfileImage/" + sdr["imagename"].ToString();
                }

                try
                {
                    if (sdr["appmststate"].ToString() != "")
                    {
                        ddlState.Items.FindByText(sdr["appmststate"].ToString()).Selected = true;
                    }
                    BindDistrict(ddlState.SelectedItem.Value.ToString());
                    if (sdr["distt"].ToString() != "")
                    {
                        if (!string.IsNullOrEmpty(sdr["distt"].ToString()))
                            ddlDistrict.Items.FindByText(sdr["distt"].ToString()).Selected = true;
                    }
                     
                    ddlBankName.SelectedValue = sdr["BankName"].ToString();
                }
                catch (Exception ex) { }
                con.Close();
            }
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.Message);
        }
    }



    protected void Button1_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtPANDetails.Text.Trim()) && Regex.IsMatch(txtPANDetails.Text.Trim(), @"[A-Z]{5}[0-9]{4}[A-Z]{1}"))
        {

            string Random = Guid.NewGuid().ToString();

            string fileName = Path.GetFileName(Random + Path.GetExtension(FU1.FileName));
            if (!string.IsNullOrEmpty(fileName))
            {
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



                        int filesize = FU1.PostedFile.ContentLength;
                        if (filesize < 500000)
                        {
                            Bitmap resizedImg = new Bitmap(CropArea.Width, CropArea.Height);
                            using (Graphics g = Graphics.FromImage(resizedImg))
                            {
                                g.DrawImage(orgImg, new Rectangle(0, 0, resizedImg.Width, resizedImg.Height), CropArea, GraphicsUnit.Pixel);
                                resizedImg.SetResolution(96, 96);
                            }
                            string panText = txtPANDetails.Text.Trim();
                            string usrId = Session["userId"].ToString();
                            string imagename = insFunc.insertPanDetail(panText, usrId, fileName);
                            cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), imagename);
                            resizedImg.Save(cropFilePath);
                            imgUpload.ImageUrl = "~/images/KYC/PanImage/" + imagename;
                            txtPANDetails.ReadOnly = true;
                            FU1.Enabled = false;
                            btnreject.Style.Add("display", "block");
                            CheckStatus();
                        }
                        else
                        {
                            Bitmap resizedImg = new Bitmap(200, 200);
                            double ratioX = (float)resizedImg.Width / (float)orgImg.Width;
                            double ratioY = (float)resizedImg.Height / (float)orgImg.Height;
                            double ratio = ratioX < ratioY ? ratioX : ratioY;
                            int newHeight = Convert.ToInt32(CropArea.Height * ratio * 1);
                            int newWidth = Convert.ToInt32(CropArea.Width * ratio * 1);
                            using (Graphics g = Graphics.FromImage(resizedImg))
                            {
                                g.SmoothingMode = SmoothingMode.AntiAlias;
                                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                                g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                                g.DrawImage(orgImg, new Rectangle(0, 0, newWidth, newHeight), CropArea, GraphicsUnit.Pixel);
                                resizedImg.SetResolution(96, 96);
                            }
                            string panText = txtPANDetails.Text.Trim();
                            string usrId = Session["userId"].ToString();
                            string imagename = insFunc.insertPanDetail(panText, usrId, fileName);
                            cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), imagename);
                            resizedImg.Save(cropFilePath);
                            imgUpload.ImageUrl = "~/images/KYC/PanImage/" + imagename;
                            txtPANDetails.ReadOnly = true;
                            FU1.Enabled = false;
                            btnreject.Style.Add("display", "block");
                            CheckStatus();
                        }
                        //Bitmap bitMap = new Bitmap(CropArea.Width, CropArea.Height);
                        //using (Graphics g = Graphics.FromImage(bitMap))
                        //{
                        //    g.DrawImage(orgImg, new Rectangle(0, 0, bitMap.Width, bitMap.Height), CropArea, GraphicsUnit.Pixel);
                        //    bitMap.SetResolution(72, 72);
                        //}


                    }
                    catch (Exception ex)
                    {
                        //  throw ex;
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
        else
        {
            utility.MessageBox(this, "Please Enter valid PAN Number.");
            return;
        }
    }

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        string ifsc = txtifs.Text.Trim();
        string txtAccno = txtAccNo.Text.Trim();
        string ifscPattern = @"^[A-Z]{4}0[A-Z0-9]{6}$";
        string isAccNoPattern = @"^#?[0-9]*$";
        bool isIFSCPattern = Regex.IsMatch(ifsc, ifscPattern);
        bool isAccNo = Regex.IsMatch(txtAccno, isAccNoPattern);
        string ddlBkName = ddlBankName.SelectedItem.Text.Trim();
        string ddlActype = ddlAcType.SelectedItem.Text.Trim();

       

        if (ddlBankName.SelectedValue == "")
        {
            ddlBkName = "";
        }

        if (ddlAcType.SelectedValue == "")
        {
            ddlActype = "";
        }

        if (!isIFSCPattern)
        {
            utility.MessageBox(this, "Valid IFSC should be 11 characters long, first four characters should be upper case alphabets,  fifth character should be 0 , last six characters usually numeric, but can also be alphabetic.");
            txtifs.Focus();
            return;
        }
        if (string.IsNullOrEmpty(ifsc))
        {
            utility.MessageBox(this, "Valid IFSC should be 11 characters long, first four characters should be upper case alphabets,  fifth character should be 0 , last six characters usually numeric, but can also be alphabetic.");
            txtifs.Focus();
            return;
        }
        if (!isAccNo)
        {
            utility.MessageBox(this, "Account Number Contains Numeric Value Without Space.");
            txtAccNo.Focus();
            return;
        }

        if (string.IsNullOrEmpty(txtAccNo.Text.Trim()))
        {
            utility.MessageBox(this, "Account Number Contains Numeric Value Without Space.");
            txtAccNo.Focus();
            return;
        }

        Validation obj = new Validation();
        if (!obj.IsAlphaNumeric_and_SpecialChar(ddlBkName))
        {
            utility.MessageBox(this, "Please select valid Bank.!!");
            ddlBankName.Focus();
            return;
        }
        if (!obj.IsAlphaNumeric_and_SpecialChar(ddlActype))
        {
            utility.MessageBox(this, "Please select valid A/c Type.!!");
            ddlAcType.Focus();
            return;
        }

        if (string.IsNullOrEmpty(txtbranch.Text.Trim()))
        {
            utility.MessageBox(this, "Please Enter Branch");
            txtbranch.Focus();
            return;
        }
        else
        {
            string Random = Guid.NewGuid().ToString();

            string fileName = Path.GetFileName(Random + Path.GetExtension(fileCancelCq.FileName));
            if (fileName != "")
            {
                string fileExtension = Path.GetExtension(fileName).ToLower();
                string filePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), Guid.NewGuid().ToString() + fileName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);

                }
                fileCancelCq.PostedFile.SaveAs(filePath);
                string cropFilePath = "";
                if (!string.IsNullOrEmpty(filePath))
                {
                    System.Drawing.Image orgImg = System.Drawing.Image.FromFile(filePath);
                    Rectangle CropArea = new Rectangle(
                        Convert.ToInt32(X1.Value),
                        Convert.ToInt32(Y1.Value),
                        Convert.ToInt32(W1.Value),
                        Convert.ToInt32(H1.Value));
                    try
                    {

                        int filesize = fileCancelCq.PostedFile.ContentLength;
                        if (filesize < 500000)
                        {
                            Bitmap resizedImg = new Bitmap(CropArea.Width, CropArea.Height);
                            using (Graphics g = Graphics.FromImage(resizedImg))
                            {
                                g.DrawImage(orgImg, new Rectangle(0, 0, resizedImg.Width, resizedImg.Height), CropArea, GraphicsUnit.Pixel);
                                resizedImg.SetResolution(96, 96);
                            }
                            imgUpload1.ImageUrl = cropFilePath;

                            string txtacno = "";
                            txtacno = txtAccNo.Text.Trim();
                            if (!string.IsNullOrEmpty(txtacno))
                            {
                                int index = txtacno.IndexOf("#");
                                if (index == 0)
                                {
                                    txtacno = txtAccNo.Text.Trim();
                                }
                                else
                                {
                                    txtacno = "#" + txtAccNo.Text.Trim();
                                }

                            }
                            string txtIfsc = txtifs.Text.Trim();
                            string usrId = Session["userId"].ToString();
                            string txtBranch = txtbranch.Text.Trim();
                            string flag = insFunc.insertBankDetail(fileName, ddlBkName, ddlActype, txtacno, txtIfsc, txtBranch, usrId);
                            if (flag == "1")
                            {
                                cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), fileName);
                                resizedImg.Save(cropFilePath);
                                imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + fileName;
                                string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong>Your Bank details uploaded successfully</div>");
                                CheckStatus();
                            }
                            else
                            {
                                utility.MessageBox(this, flag);
                                return;
                            }
                        }
                        else
                        {
                            Bitmap resizedImg = new Bitmap(200, 200);
                            double ratioX = (float)resizedImg.Width / (float)orgImg.Width;
                            double ratioY = (float)resizedImg.Height / (float)orgImg.Height;
                            double ratio = ratioX < ratioY ? ratioX : ratioY;
                            int newHeight = Convert.ToInt32(CropArea.Height * ratio * 1);
                            int newWidth = Convert.ToInt32(CropArea.Width * ratio * 1);
                            using (Graphics g = Graphics.FromImage(resizedImg))
                            {
                                g.SmoothingMode = SmoothingMode.AntiAlias;
                                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                                g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                                g.DrawImage(orgImg, new Rectangle(0, 0, newWidth, newHeight), CropArea, GraphicsUnit.Pixel);
                                resizedImg.SetResolution(96, 96);
                            }

                            imgUpload1.ImageUrl = cropFilePath;

                            string txtacno = "";
                            txtacno = txtAccNo.Text.Trim();
                            if (!string.IsNullOrEmpty(txtAccno))
                            {

                                int index = txtacno.IndexOf("#");
                                if (index == 0)
                                {
                                    txtacno = txtAccNo.Text.Trim();
                                }
                                else
                                {
                                    txtacno = "#" + txtAccNo.Text.Trim();
                                }

                            }
                            string txtIfsc = txtifs.Text.Trim();
                            string usrId = Session["userId"].ToString();
                            string txtBranch = txtbranch.Text.Trim();
                            string flag = insFunc.insertBankDetail(fileName, ddlBkName, ddlActype, txtAccno, txtIfsc, txtBranch, usrId);
                            if (flag == "1")
                            {
                                cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), fileName);
                                resizedImg.Save(cropFilePath);
                                imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + fileName;
                                string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong>Your Bank details uploaded successfully</div>");
                                CheckStatus();
                            }
                            else
                            {
                                utility.MessageBox(this, flag);
                                return;
                            }
                        }
                        //Bitmap bitMap = new Bitmap(CropArea.Width, CropArea.Height);
                        //using (Graphics g = Graphics.FromImage(bitMap))
                        //{
                        //    g.DrawImage(orgImg, new Rectangle(0, 0, bitMap.Width, bitMap.Height), CropArea, GraphicsUnit.Pixel);
                        //}


                    }
                    catch (Exception ex)
                    {
                        // throw ex;
                    }

                }
            }
            else
            {
                utility.MessageBox(this, "Please Select Bank Image");
                txtAccNo.Focus();
            }
        }
    }


    protected void Button6_click(object sender, EventArgs e)
    {
        string AadharNo = txtAadharNo.Text.Trim();
        if (string.IsNullOrEmpty(txtAadharNo.Text.Trim()))
        {
            utility.MessageBox(this, "Please enter Valid Address ID!");
            txtAadharNo.Focus();
            return;
        }
        else
        {
            string Random = Guid.NewGuid().ToString();
            string Random1 = Guid.NewGuid().ToString();


            string fileName1 = Path.GetFileName(Random + Path.GetExtension(FU2.FileName));  //Path.GetFileName(FU2.PostedFile.FileName);
            string fileName2 = Path.GetFileName(Random1 + Path.GetExtension(FU3.FileName)); // Path.GetFileName(FU3.PostedFile.FileName);
            string filePath1 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Front/"), Guid.NewGuid().ToString() + fileName1);
            string filePath2 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Back/"), Guid.NewGuid().ToString() + fileName2);


            //string fileName1 = Path.GetFileName(FU2.PostedFile.FileName);
            //string fileName2 = Path.GetFileName(FU3.PostedFile.FileName);
            //string filePath1 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Front/"), Guid.NewGuid().ToString() + fileName1);
            //string filePath2 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Back/"), Guid.NewGuid().ToString() + fileName2);
            FU2.PostedFile.SaveAs(filePath1);
            FU3.PostedFile.SaveAs(filePath2);
            string cropFilePath1 = "";
            string cropFilePath2 = "";
            if (!string.IsNullOrEmpty(fileName1) && !string.IsNullOrEmpty(fileName2))
            {
                System.Drawing.Image orgImg = System.Drawing.Image.FromFile(filePath1);
                Rectangle CropArea = new Rectangle(
                    Convert.ToInt32(X2.Value),
                    Convert.ToInt32(Y2.Value),
                    Convert.ToInt32(W2.Value),
                    Convert.ToInt32(H2.Value));
                System.Drawing.Image orgImg1 = System.Drawing.Image.FromFile(filePath2);
                Rectangle CropArea1 = new Rectangle(
                    Convert.ToInt32(X3.Value),
                    Convert.ToInt32(Y3.Value),
                    Convert.ToInt32(W3.Value),
                    Convert.ToInt32(H3.Value));
                try
                {


                    int filesize = FU2.PostedFile.ContentLength;
                    int filesize1 = FU3.PostedFile.ContentLength;
                    if (filesize < 500000 && filesize1 < 500000)
                    {
                        Bitmap resizedImg = new Bitmap(CropArea.Width, CropArea.Height);
                        using (Graphics g = Graphics.FromImage(resizedImg))
                        {
                            g.DrawImage(orgImg, new Rectangle(0, 0, resizedImg.Width, resizedImg.Height), CropArea, GraphicsUnit.Pixel);
                        }
                        Bitmap resizedImg1 = new Bitmap(CropArea1.Width, CropArea1.Height);
                        using (Graphics g = Graphics.FromImage(resizedImg1))
                        {
                            g.DrawImage(orgImg1, new Rectangle(0, 0, resizedImg1.Width, resizedImg1.Height), CropArea1, GraphicsUnit.Pixel);
                        }
                        string usrId = Session["userId"].ToString();
                        string adaharText = txtAadharNo.Text.Trim();
                        string imgFront, imgback, msg;
                        insFunc.insertAddressProof(fileName1, fileName2, usrId, adaharText, out imgFront, out imgback, out msg);
                        if (msg == "1")
                        {
                            cropFilePath1 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Front/"), imgFront);
                            resizedImg.Save(cropFilePath1);
                            imgUpload2.ImageUrl = "~/images/KYC/AadharImage/Front/" + imgFront;
                            cropFilePath2 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Back/"), imgback);
                            resizedImg1.Save(cropFilePath2);
                            imgUpload3.ImageUrl = "~/images/KYC/AadharImage/Back/" + imgback;
                            string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Address proof uploaded</div>");
                            CheckStatus();
                        }
                    }
                    else
                    {
                        Bitmap resizedImg = new Bitmap(200, 200);
                        double ratioX = (float)resizedImg.Width / (float)orgImg.Width;
                        double ratioY = (float)resizedImg.Height / (float)orgImg.Height;
                        double ratio = ratioX < ratioY ? ratioX : ratioY;
                        int newHeight = Convert.ToInt32(CropArea.Height * ratio * 1);
                        int newWidth = Convert.ToInt32(CropArea.Width * ratio * 1);
                        using (Graphics g = Graphics.FromImage(resizedImg))
                        {
                            g.SmoothingMode = SmoothingMode.AntiAlias;
                            g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                            g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                            g.DrawImage(orgImg, new Rectangle(0, 0, newWidth, newHeight), CropArea, GraphicsUnit.Pixel);
                            resizedImg.SetResolution(96, 96);
                        }

                        Bitmap resizedImg1 = new Bitmap(200, 200);
                        double ratioX1 = (float)resizedImg1.Width / (float)orgImg.Width;
                        double ratioY1 = (float)resizedImg1.Height / (float)orgImg.Height;
                        double ratio1 = ratioX1 < ratioY1 ? ratioX1 : ratioY1;
                        int newHeight1 = Convert.ToInt32(CropArea.Height * ratio1 * 1);
                        int newWidth1 = Convert.ToInt32(CropArea.Width * ratio1 * 1);
                        using (Graphics g = Graphics.FromImage(resizedImg1))
                        {
                            g.SmoothingMode = SmoothingMode.AntiAlias;
                            g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                            g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                            g.DrawImage(orgImg1, new Rectangle(0, 0, newWidth1, newHeight1), CropArea1, GraphicsUnit.Pixel);
                            resizedImg1.SetResolution(96, 96);
                        }
                        string usrId = Session["userId"].ToString();
                        string adaharText = txtAadharNo.Text.Trim();
                        string imgFront, imgback, msg;
                        insFunc.insertAddressProof(fileName1, fileName2, usrId, adaharText, out imgFront, out imgback, out msg);
                        if (msg == "1")
                        {
                            cropFilePath1 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Front/"), imgFront);
                            resizedImg.Save(cropFilePath1);
                            imgUpload2.ImageUrl = "~/images/KYC/AadharImage/Front/" + imgFront;
                            cropFilePath2 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Back/"), imgback);
                            resizedImg1.Save(cropFilePath2);
                            imgUpload3.ImageUrl = "~/images/KYC/AadharImage/Back/" + imgback;
                            string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Address proof uploaded</div>");
                            CheckStatus();
                        }

                    }

                }
                catch (Exception ex)
                {
                    //throw ex;
                }
                finally
                {
                    con.Close();
                    con.Dispose();

                }
            }
            else
            {
                utility.MessageBox(this, "Please insert both front And back Address image.");
                imgUpload3.Focus();
            }

        }
    }



    protected void Button5_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txt_GSTNo.Text.Trim()))
        {
            string Random = "GST_" + Guid.NewGuid().ToString();
            string fileName = Path.GetFileName(Random + Path.GetExtension(FU_GST.FileName));
            if (!string.IsNullOrEmpty(fileName))
            {
                string filePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), Guid.NewGuid().ToString() + fileName);
                if (System.IO.File.Exists(filePath))
                    System.IO.File.Delete(filePath);

                FU_GST.PostedFile.SaveAs(filePath);
                string cropFilePath = "";
                if (!string.IsNullOrEmpty(filePath))
                {
                    System.Drawing.Image orgImg = System.Drawing.Image.FromFile(filePath);
                    Rectangle CropArea = new Rectangle(
                        Convert.ToInt32(X_gst.Value),
                        Convert.ToInt32(Y_gst.Value),
                        Convert.ToInt32(W_gst.Value),
                        Convert.ToInt32(H_gst.Value));
                    try
                    {
                        int filesize = FU_GST.PostedFile.ContentLength;
                        string GSTNo = txt_GSTNo.Text.Trim();
                        string UserId = Session["userId"].ToString();
                        if (filesize < 500000)
                        {
                            Bitmap resizedImg = new Bitmap(CropArea.Width, CropArea.Height);
                            using (Graphics g = Graphics.FromImage(resizedImg))
                            {
                                g.DrawImage(orgImg, new Rectangle(0, 0, resizedImg.Width, resizedImg.Height), CropArea, GraphicsUnit.Pixel);
                                resizedImg.SetResolution(96, 96);
                            }
                            insFunc.GST_Detail(GSTNo, UserId, fileName, UserId);
                            cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), fileName);
                            resizedImg.Save(cropFilePath);

                            imgUpload.ImageUrl = "~/images/KYC/PanImage/" + fileName;
                            txt_GSTNo.ReadOnly = true;
                            FU_GST.Enabled = false;
                            CheckStatus();
                        }
                        else
                        {
                            Bitmap resizedImg = new Bitmap(200, 200);
                            double ratioX = (float)resizedImg.Width / (float)orgImg.Width;
                            double ratioY = (float)resizedImg.Height / (float)orgImg.Height;
                            double ratio = ratioX < ratioY ? ratioX : ratioY;
                            int newHeight = Convert.ToInt32(CropArea.Height * ratio * 1);
                            int newWidth = Convert.ToInt32(CropArea.Width * ratio * 1);
                            using (Graphics g = Graphics.FromImage(resizedImg))
                            {
                                g.SmoothingMode = SmoothingMode.AntiAlias;
                                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                                g.PixelOffsetMode = PixelOffsetMode.HighQuality;
                                g.DrawImage(orgImg, new Rectangle(0, 0, newWidth, newHeight), CropArea, GraphicsUnit.Pixel);
                                resizedImg.SetResolution(96, 96);
                            }

                            insFunc.GST_Detail(GSTNo, UserId, fileName, UserId);
                            cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), fileName);
                            resizedImg.Save(cropFilePath);
                            imgUpload.ImageUrl = "~/images/KYC/PanImage/" + fileName;
                            txt_GSTNo.ReadOnly = true;
                            FU_GST.Enabled = false;
                            CheckStatus();
                        }
                    }
                    catch (Exception ex)
                    {
                        //  throw ex;
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
        else
        {
            utility.MessageBox(this, "Please Enter valid GST Number.");
            return;
        }
    }



    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        if (Regex.Match(str1, @"^[a-zA-Z0-9]*$").Success)
        {
            if (ddlState.SelectedIndex != 0 && ddlDistrict.SelectedIndex != 0)
            {
                if (!string.IsNullOrEmpty(txtMobile.Text.Trim()) && Regex.IsMatch(txtMobile.Text.Trim(), @"^[6-9][0-9]{9}$"))
                {
                    updatedata();
                    //SqlConnection con = new SqlConnection(method.str);
                    //SqlCommand com = new SqlCommand("VerifyOTP", con);
                    //com.CommandType = CommandType.StoredProcedure;
                    //com.Parameters.AddWithValue("@RegNo", str1);
                    //com.Parameters.AddWithValue("@OTP",txtotp.Text.Trim());
                    //com.Parameters.Add("@IsValid", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    //con.Open();
                    //com.ExecuteNonQuery();
                    //string Result = com.Parameters["@IsValid"].Value.ToString();
                    //if (Result == "0")
                    //{
                    //    //btn.Text = "Generate OTP";
                    //    txtotp.Visible = false;
                    //    txtotp.Text = "";
                    //    btnSubmit.Visible = true;
                    //    updatedata();
                    //}
                    //else
                    //{
                    //    utility.MessageBox(this, Result);
                    //}

                }
                else
                {
                    utility.MessageBox(this, "Please Enter 10 Digits Valid Mobile Number !");
                    txtMobile.Focus();
                    return;
                }

            }
            else
            {
                utility.MessageBox(this, "Please Select State !");
                ddlState.Focus();
                return;
            }
        }

        else
        {
            utility.MessageBox(this, "Invalid Id !!!");
            return;
        }
    }
    private void updatedata()
    {

        try
        {
            confirm.Visible = true;
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime dob = new DateTime();
            int i = 0;

            try
            {
                dob = Convert.ToDateTime(txtDOB.Text.Trim(), dateInfo);
                i = 1;
            }
            catch
            {
                lblMessage.Text = "Invalid Date Of Birth !";
                i = 0;
            }
            if (i == 1)
            {
                lblMessage.Text = "";
                com = new SqlCommand("GetUserImg", con);
                com.CommandType = CommandType.StoredProcedure;
                con.Open();
                com.Parameters.AddWithValue("@id", str1);
                da = new SqlDataAdapter(com);
                dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count >= 0)
                {

                    Validation obj = new Validation();
                    if (!obj.IsAlphaNumeric_and_SpecialChar(ddlState.SelectedItem.Text.Trim()))
                    {
                        utility.MessageBox(this, "Please select valid state.!!");
                        ddlState.Focus();
                        return;
                    }
                    if (!obj.IsAlphaNumeric_and_SpecialChar(ddlDistrict.SelectedItem.Text.Trim()))
                    {
                        utility.MessageBox(this, "Please select valid district.!!");
                        ddlDistrict.Focus();
                        return;
                    }



                    con.Close();
                    com = new SqlCommand("updateuserprofile", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@address", txtAddress.Text);
                    try
                    {
                        com.Parameters.AddWithValue("@distt", ddlDistrict.SelectedItem.Text.Trim());
                        com.Parameters.AddWithValue("@dob", dob);
                        com.Parameters.AddWithValue("@state", ddlState.SelectedItem.Text.Trim());
                        com.Parameters.AddWithValue("@city", txtCity.Text.Trim());
                        com.Parameters.AddWithValue("@pincode", txtpincode.Text);
                        com.Parameters.AddWithValue("@mobile", txtMobile.Text);
                        //com.Parameters.AddWithValue("@bankname", ddlBankName.SelectedItem.Text.Trim());
                        //com.Parameters.AddWithValue("@branch", branch.Text);

                        //com.Parameters.AddWithValue("@type", ddlAccountType.SelectedItem.Text);
                        //com.Parameters.AddWithValue("@panno", panno.Text);
                        com.Parameters.AddWithValue("@emailid", txtEmail.Text);
                        com.Parameters.AddWithValue("@nomname", txtnomniName.Text);
                        com.Parameters.AddWithValue("@nomrela", txtrelation.Text);
                        com.Parameters.AddWithValue("@Appmsttitle", title.SelectedValue);
                        com.Parameters.AddWithValue("@Gtitle", ddlGtitle.SelectedItem.Text.Trim().ToString());
                        com.Parameters.AddWithValue("@gname", txtGName.Text.Trim().ToString());
                        com.Parameters.AddWithValue("@mname", "");
                        com.Parameters.AddWithValue("@gender", RdoGenderNew.SelectedValue);
                        //com.Parameters.AddWithValue("@IFSCode", txtIFSCode.Text.Trim().ToString());
                        //com.Parameters.AddWithValue("@panstatus", rbpanlist.SelectedValue);
                        com.Parameters.AddWithValue("@regno", str1);
                        com.Parameters.AddWithValue("@pwd", txtpassword.Text.Trim());
                        com.Parameters.AddWithValue("@epassword", txtepassword.Text.Trim());
                        com.Parameters.AddWithValue("@isProup", 0);
                        con.Open();
                        int UP = com.ExecuteNonQuery();
                        if (UP == 0)
                        {
                            utility.MessageBox(this, "Profile has been Updated !!!");
                            con.Close();
                            go();
                            // btn.Text = "Generate OTP";
                            // btn.Visible = true;
                            btnSubmit.Visible = false;
                            txtotp.Visible = false;
                            ddlGtitle.Enabled = false;
                            //branch.Enabled = true;
                            //txtAadharNo.Enabled = true;
                            //ddlBankName.Enabled = true;
                            //ddlAccountType.Enabled = true;
                            //acno.Enabled = true;
                            title.Enabled = false;
                            txtFirstName.Enabled = false;
                            txtGName.Enabled = false;
                            txtpincode.Enabled = false;
                            ddlState.Enabled = false;
                            ddlDistrict.Enabled = false;
                            txtOccupation.Enabled = false;
                            //flup.Enabled = true;
                            rbtnGender.Enabled = false;
                            RdoMarital.Enabled = false;
                            txtAddress.Enabled = false;
                            txtMobile.Enabled = false;
                            txtEmail.Enabled = false;
                            txtnomniName.Enabled = false;
                            txtrelation.Enabled = false;
                            txtCity.Enabled = false;
                            txtDOB.Enabled = false;
                            RdoGenderNew.Enabled = false;
                            //txtIFSCode.Enabled = true;
                            //panno.Enabled = true;
                            //btnSubmit.Enabled = false;
                            ottp.Visible = false;
                        }
                        else
                        {
                            // btn.Text = "Re-Generate OTP";
                            btnSubmit.Visible = true;
                            // btn.Visible = true;
                            txtotp.Visible = true;
                        }

                    }
                    catch (Exception ex)
                    {

                        /// throw ex;
                    }




                    try
                    {

                        com.Parameters.AddWithValue("@distt", ddlDistrict.SelectedItem.Text.Trim());
                        com.Parameters.AddWithValue("@dob", dob);
                        com.Parameters.AddWithValue("@state", ddlState.SelectedItem.Text.Trim());
                        com.Parameters.AddWithValue("@city", txtCity.Text.Trim());
                        com.Parameters.AddWithValue("@pincode", txtpincode.Text);
                        com.Parameters.AddWithValue("@mobile", txtMobile.Text);
                        //com.Parameters.AddWithValue("@bankname", ddlBankName.SelectedItem.Text.Trim());
                        //com.Parameters.AddWithValue("@branch", branch.Text);
                        //com.Parameters.AddWithValue("@type", ddlAccountType.SelectedItem.Text);
                        //com.Parameters.AddWithValue("@panno", panno.Text);
                        com.Parameters.AddWithValue("@emailid", txtEmail.Text);
                        com.Parameters.AddWithValue("@nomname", txtnomniName.Text);
                        com.Parameters.AddWithValue("@nomrela", txtrelation.Text);
                        com.Parameters.AddWithValue("@Appmsttitle", title.SelectedValue);
                        com.Parameters.AddWithValue("@Gtitle", ddlGtitle.SelectedItem.Text.Trim().ToString());
                        com.Parameters.AddWithValue("@gname", txtGName.Text.Trim().ToString());
                        com.Parameters.AddWithValue("@mname", "");
                        com.Parameters.AddWithValue("@gender", RdoGenderNew.SelectedValue);
                        //com.Parameters.AddWithValue("@IFSCode", txtIFSCode.Text.Trim().ToString());
                        //com.Parameters.AddWithValue("@panstatus", rbpanlist.SelectedValue);
                        com.Parameters.AddWithValue("@aadharno", txtAadharNo.Text.Trim());
                        com.Parameters.AddWithValue("@regno", str1);
                        com.Parameters.AddWithValue("@pwd", txtpassword.Text.Trim());
                        com.Parameters.AddWithValue("@epassword", txtepassword.Text.Trim());
                        com.Parameters.AddWithValue("@isProup", 0);
                        con.Open();
                        int UP = com.ExecuteNonQuery();
                        if (UP != 0)
                        {
                            utility.MessageBox(this, "Profile has been Updated !!!");
                            con.Close();
                            go();
                            // btn.Text = "Generate OTP";
                            // btn.Visible = true;
                            btnSubmit.Visible = false;
                            txtotp.Visible = false;
                            ddlGtitle.Enabled = false;
                            //branch.Enabled = true;
                            //txtAadharNo.Enabled = true;
                            //ddlBankName.Enabled = true;
                            //ddlAccountType.Enabled = true;
                            //acno.Enabled = true;
                            title.Enabled = false;
                            txtFirstName.Enabled = false;
                            txtGName.Enabled = false;
                            txtpincode.Enabled = false;
                            //ddlState.Enabled = true;
                            //ddlDistrict.Enabled = true;
                            txtOccupation.Enabled = false;
                            // flup.Enabled = true;
                            rbtnGender.Enabled = false;
                            RdoMarital.Enabled = false;
                            txtAddress.Enabled = false;
                            txtMobile.Enabled = false;
                            txtEmail.Enabled = false;
                            txtnomniName.Enabled = false;
                            txtrelation.Enabled = false;
                            txtCity.Enabled = false;
                            txtDOB.Enabled = false;
                            //txtIFSCode.Enabled = true;
                            //panno.Enabled = true;
                            //btnSubmit.Enabled = true;
                            ottp.Visible = false;
                        }
                        else
                        {
                            // btn.Text = "Re-Generate OTP";
                            btnSubmit.Visible = true;
                            // btn.Visible = true;
                            txtotp.Visible = true;
                        }

                    }
                    catch (Exception ex)
                    {
                        //  throw ex;
                    }


                }
                //if (flup.HasFile)
                //{
                //    com.Parameters.AddWithValue("@image", str1 + flup.FileName);
                //    string path = Server.MapPath("~/images/KYC/ProfileImage/" + str1 + flup.FileName);
                //    flup.SaveAs(path);
                //    string FileName = Path.GetFileName(flup.PostedFile.FileName);
                //    this.imgPreview.ImageUrl = "~/images/KYC/ProfileImage/" + FileName;
                //}
                //else
                //{
                //    com.Parameters.AddWithValue("@image", dt.Rows[0]["imagename"].ToString());
                //}

            }

        }

        catch (Exception ex)
        {
            utility.MessageBox(this, ex.Message.ToString());
        }


    }

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BindDistrict(ddlState.SelectedItem.Value.ToString());
        }
        catch
        {

        }
    }

    public void BindState()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetState", con);
            com.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddlState.DataSource = dt;
                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "SId";
                ddlState.DataBind();
                ddlState.Items.Insert(0, new ListItem("Select State", ""));
            }
        }
        catch
        {

        }
    }


    public void BindDistrict(string value)
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("GetStateDistrict", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@state", value);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddlDistrict.DataSource = dt;
                ddlDistrict.Items.Clear();
                ddlDistrict.DataTextField = "DistrictName";
                ddlDistrict.DataValueField = "Id";
                ddlDistrict.DataBind();
                ddlDistrict.Items.Insert(0, new ListItem("Select District", ""));
            }
            else
            {
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, new ListItem("Select District", ""));
            }
        }
        catch
        {
        }
    }


    //otp use 01/08/2019
    [WebMethod]
    public static string generateOTP()
    {
        if (HttpContext.Current.Session["userId"] == null)
        {
            return "Session expire.";
        }

        string result = "0";
        DataTable dt = new DataTable();
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        da = new SqlDataAdapter("GenerateOTP", con);
        da.SelectCommand.Parameters.AddWithValue("@RegNo", HttpContext.Current.Session["userId"].ToString());
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            utility objUtil = new utility();
            //string msg = "Dear " + "sir/madam" + " from your  User Id." + HttpContext.Current.Session["userId"] + " Change profile OTP is " + dt.Rows[0]["OTP"].ToString().Trim() + ". Don't share with anyone.";
            // string msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 30 min";
            String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 15 min from:toptimenet.com Jai Toptime";

            objUtil.sendSMSByBilling(dt.Rows[0]["AppMstMobile"].ToString().Trim(), msg, "OTP");
        }
        return result;


    }

    //deleteKYC
    #region KYCDelete
    [WebMethod]
    public static string btnRejectKYC_Click(string kycid)
    {
        SqlConnection con = new SqlConnection(method.str);

        DataUtility objDu = new DataUtility();
        SqlParameter[] prm = new SqlParameter[] { new SqlParameter("@Userid1", HttpContext.Current.Session["userId"].ToString()) };

        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Userid", HttpContext.Current.Session["userId"].ToString()) };


        if (kycid == "1")
        {
            try
            {

                SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@modifiedby", HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@Remark", "Reject Pan")
                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");



                string OldImgName = objDu.GetScaler(prm, "Select PanImage from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();

                string upStatus = "Update Appmst set verified=0, panno='' where AppMstRegNo =@Userid; Update scandocs set PStatus=0, PanImage=null from scandocs s inner join AppMst a on s.Appmstid=a.AppMstID where  a.AppMstRegNo =@Userid";
                objDu.ExecuteSql(param, upStatus);

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/PanImage/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }


                //con = new SqlConnection(method.str);
                //string queryr = "select PanImage from scandocs inner join AppMst on Appmst.AppMstID=scandocs.Appmstid where Appmst.AppMstRegNo='" + HttpContext.Current.Session["userId"] + "'";
                //SqlCommand cmd1 = new SqlCommand(queryr, con);
                //con.Open();
                //cmd1.ExecuteScalar();
                //using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
                //{
                //    while (reader.Read())
                //    {
                //        string panimage = reader["panImage"].ToString();
                //        if (panimage != "")
                //        {
                //            string imgPath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/PanImage/"), panimage);
                //            System.IO.File.Delete(imgPath);

                //        }
                //    }
                //}
                //string upStatus = "Update scandocs set PStatus=0,PanImage=null from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + HttpContext.Current.Session["userId"] + "'";
                //SqlCommand cmd = new SqlCommand(upStatus, con);
                //con.Open();
                //cmd.ExecuteNonQuery();


                //DataUtility objDu = new DataUtility();


                //txtPANDetails.ReadOnly = false;
                //FU1.Enabled = true;
                //imgUpload.Visible = false;
                //btnreject.Visible = false;
                //Response.Redirect(Request.Url.AbsoluteUri);
                string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Address proof uploaded</div>");
                //confirm.InnerHtml = strHtml1;
                return "Pan Deleted";
            }
            catch (Exception ex)
            {
                //throw ex;
            }
        }

        if (kycid == "2")
        {
            try
            {

                SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@modifiedby", HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@Remark", "Reject Bank")
                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");



                string OldImgName = objDu.GetScaler(prm, "select BankImage from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();

                string upStatus = "Update Appmst set verified=0, BankName='', Branch='', AcountNo='', Type='', IFSCode='' where AppMstRegNo =@Userid; Update scandocs set bankstatus=0, BankImage=null from scandocs s inner join AppMst a on s.Appmstid=a.AppMstID where a.AppMstRegNo =@Userid";
                objDu.ExecuteSql(param, upStatus);

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/BankImage/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }

                //con = new SqlConnection(method.str);
                //string queryr = "select BankImage from scandocs inner join AppMst on Appmst.AppMstID=scandocs.Appmstid where Appmst.AppMstRegNo='" + HttpContext.Current.Session["userId"] + "'";
                //SqlCommand cmd1 = new SqlCommand(queryr, con);
                //con.Open();
                //cmd1.ExecuteScalar();
                //using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
                //{
                //    while (reader.Read())
                //    {
                //        string bankImage = reader["BankImage"].ToString();
                //        if (bankImage != "")
                //        {
                //            string imgPath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/BankImage/"), bankImage);
                //            System.IO.File.Delete(imgPath);

                //        }
                //    }
                //}
                //string upStatus = "Update scandocs set bankstatus=0,BankImage=null from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + HttpContext.Current.Session["userId"] + "'";
                //SqlCommand cmd = new SqlCommand(upStatus, con);
                //con.Open();
                //cmd.ExecuteNonQuery();

                //DataUtility objDu = new DataUtility();



                //txtPANDetails.ReadOnly = false;
                //fileCancelCq.Enabled = true;
                //btnInsert.Visible = true;
                //imgUpload1.Visible = false;
                //btnreject.Visible = false;
                //Response.Redirect(Request.Url.AbsoluteUri);
                return "Bank Deleted";
            }
            catch (Exception ex)
            {
                //throw ex;
            }
        }
        if (kycid == "3")
        {
            try
            {

                SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@modifiedby", HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@Remark", "Reject Aadhar")
                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");


                string Aadhar_F_img = objDu.GetScaler(prm, "select AadharFront from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();
                string Aadhar_B_img = objDu.GetScaler(prm, "select AadharBack from AppMst a Left join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();

                string upStatus = "Update Appmst set verified=0, Aadharno='' where AppMstRegNo =@Userid; Update scandocs set AaStatus=0, AadharFront=null, AadharBack=null from scandocs s inner join AppMst a on s.Appmstid=a.AppMstID where a.AppMstRegNo=@Userid";
                objDu.ExecuteSql(param, upStatus);

                string filePath1 = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/AadharImage/Front/"), Aadhar_F_img);
                if (System.IO.File.Exists(filePath1))
                {
                    System.IO.File.Delete(filePath1);
                }

                string filePath2 = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/AadharImage/Back/"), Aadhar_B_img);
                if (System.IO.File.Exists(filePath2))
                {
                    System.IO.File.Delete(filePath2);
                }


                //con = new SqlConnection(method.str);
                //string querry = "select AadharFront, AadharBack from scandocs inner join AppMst on scandocs.Appmstid=Appmst.AppMstID where AppMst.AppMstRegNo='" + HttpContext.Current.Session["userId"] + "'";
                //SqlCommand cmd1 = new SqlCommand(querry, con);
                //con.Open();
                //cmd1.ExecuteScalar();
                //using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
                //{
                //    while (reader.Read())
                //    {
                //        string AadharFrontImg = reader["AadharFront"].ToString();
                //        string AadharBackImg = reader["AadharBack"].ToString();
                //        if (AadharFrontImg != "" && AadharBackImg != "")
                //        {
                //            string imgPath1 = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/AadharImage/Front/"), AadharFrontImg);
                //            System.IO.File.Delete(imgPath1);
                //            string imgPath2 = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/AadharImage/Back/"), AadharBackImg);
                //            System.IO.File.Delete(imgPath2);

                //        }
                //    }
                //}
                //string upstatus = "Update scandocs set AaStatus=0,AadharFront=null,AadharBack=null from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + HttpContext.Current.Session["userId"] + "'";
                //SqlCommand cmd = new SqlCommand(upstatus, con);
                //con.Open();
                //cmd.ExecuteNonQuery();
                ////btnSubmit.Visible = true;


                //DataUtility objDu = new DataUtility();



            }
            catch (Exception ex)
            {

            }
        }

        if (kycid == "4")
        {
            try
            {
                SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;
                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@modifiedby", HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@Remark", "Reject GST")
                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");

                string OldImgName = objDu.GetScaler(prm, "Select s.GST_Img from AppMst a inner join scandocs s on a.AppMstID=s.Appmstid where a.AppMstRegNo=@Userid1").ToString();

                string upStatus = "Update Appmst Set GST='' where AppMstRegNo=@Userid; Update scandocs set GST_Status=0, GST_Img=null, GST_DateApproved=null from scandocs s inner join AppMst a on s.Appmstid=a.AppMstID where  a.AppMstRegNo =@Userid";
                objDu.ExecuteSql(param, upStatus);

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/PanImage/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                    System.IO.File.Delete(filePath);

                return "GST Deleted";
            }
            catch (Exception ex)
            {
            }
        }


        return "there is an issue";


    }
    #endregion

    [WebMethod]
    public static string verifyOTP(string telno, string txtotp)
    {
        string chktelno = telno;


        if (HttpContext.Current.Session["userId"] == null)
        {
            return "Session Expire";
        }
        if (chktelno != "" && Regex.IsMatch(chktelno, "@^[6-9][0-9]{9}$"))
        {
            return "Enter 10 digit mobile number";
        }
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("VerifyOTP", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@RegNo", HttpContext.Current.Session["userId"].ToString());
        com.Parameters.AddWithValue("@OTP", txtotp.Trim());
        com.Parameters.Add("@IsValid", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        return com.Parameters["@IsValid"].Value.ToString();

    }


    public void BindBank()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetBank", con);
            com.CommandType = CommandType.StoredProcedure;

            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlBankName.DataSource = dt;
            ddlBankName.DataTextField = "BankName";
            ddlBankName.DataValueField = "BankName";
            ddlBankName.DataBind();
            ddlBankName.Items.Insert(0, new ListItem("Select Bank", ""));
        }
        catch
        {

        }
    }


    public void bankdetail()
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("select bankname,acountno,branch,ifscode,type from appmst where appmstregno='" + Session["userId"].ToString() + "' ", con);
            SqlDataReader sdr;
            con.Open();
            sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {

                txtAccNo.Text = sdr["acountno"].ToString();
                txtbranch.Text = sdr["branch"].ToString();
                txtifs.Text = sdr["ifscode"].ToString();
                ddlAcType.SelectedValue = sdr["type"].ToString();

                try
                {
                    ddlBankName.SelectedValue = sdr["BankName"].ToString();

                    //  ddlBankName.Items.FindByText(sdr["BankName"].ToString()).Selected = true;
                    //ddlBankName.SelectedIndex = ddlBankName.Items.IndexOf(ddlBankName.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["bankname"].ToString(), true) == 0).FirstOrDefault());

                }
                catch (Exception ex)
                {

                }
            }

            sdr.Close();
            con.Close();
        }
        catch
        {

        }
    }

    public void BindData()
    {
        try
        {
            cmd = new SqlCommand("GetProfileData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@regno", Session["userId"].ToString());
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                if (!string.IsNullOrEmpty(dt.Rows[0]["imagename"].ToString()))
                {
                    MobProfileImg.ImageUrl = "~/images/KYC/ProfileImage/" + dt.Rows[0]["imagename"].ToString();
                }
                else
                {
                    MobProfileImg.ImageUrl = "~/images/KYC/ProfileImage/noimage.png";
                }
                //moblblUserName.Text  = dt.Rows[0]["UserName"].ToString() + "  (" + Session["userId"].ToString() + ")";

            }

        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
            con.Dispose();
            cmd.Dispose();
        }
    }

}