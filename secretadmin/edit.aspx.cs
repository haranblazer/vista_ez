using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Drawing;
using System.IO;
using System.Drawing.Drawing2D;
using System.Web;
using System.Web.Services;

public partial class admin_edit : System.Web.UI.Page
{
    InsertFunction insFunc = new InsertFunction();
    Validation val = new Validation();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("logout.aspx");
            }
            else
            {
                if (Request.QueryString.Count != 0 && Request.QueryString["n"] != null)
                {
                    if (!IsPostBack)
                    {
                        txtDOB.Text = DateTime.Now.AddYears(-18).ToString("dd/MM/yyyy").Replace("-", "/");

                        BindBank();
                        BindState();
                        BindUserDetails();
                    }
                }
                else
                {
                    Response.Redirect("adchangeprofile.aspx");
                }
            }
        }
        catch
        {

        }

    }

    #region CheckProfileEdit
    private void BindUserDetails()
    {
        try
        {
            DataUtility objDu = new DataUtility();
            utility objDut = new utility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@AppMstRegNo", Request.QueryString["n"].ToString()) };
            string Query = @"select a.AppMstRegNo, a.AppMstTitle, a.AppMstFName, sponsorid=(Select Appmstregno from Appmst where Appmstid=a.sponsorid), a.Gtitle, a.GName, a.MName, a.Gender, a.gtitle, a.AppMstAddress1,
            a.AppMstCity, a.AppMstState, a.AppMstMobile, a.AppMstPinCode, a.BankName, a.branch, a.acountno, a.[type], a.panno, a.Aadharno, 
            a.email, a.nom_name, a.nom_rela, a.distt, CONVERT(VARCHAR(10), a.userdob, 103) as userdob, a.appmstactivate,                        
            a.IFSCode, a.MICRCode, a. panstatus, (case when a.imagename!='' then a.imagename else 'noimage.png' end)as imagename,  Verified, a.isProUp, 
            s.pstatus, a.panno, s.panImage, s.bankstatus, s.BankImage, Aadharfront, AadharBack, s.aastatus, a.AppMstPassword
            from scandocs s, AppMst a where s.Appmstid=a.AppMstID and a.AppMstRegNo=@AppMstRegNo";
            SqlDataReader dr = objDu.GetDataReader(param, Query);
            while (dr.Read())
            {
                string bkstatus = dr["bankstatus"].ToString();
                string bankImg = dr["BankImage"].ToString();
                string pstatus = dr["pstatus"].ToString();
                string aastatus = dr["aastatus"].ToString();
                if (pstatus == "2")
                {
                    btn_Pan_A.Style.Add("display", "none");
                    string panimage = dr["panImage"].ToString();
                    txtPANDetails.ReadOnly = true;
                    FU1.Enabled = false;
                    btnreject.Visible = false;
                    if (panimage != "")
                    {
                        imgUpload.ImageUrl = "~/images/KYC/PanImage/" + panimage;
                        imgUpload.Style.Add("display", "block");
                        approveRejectimg.Src = "~/images/ApproveGreen.png";
                    }
                }
                else if (pstatus == "0")
                {
                    btn_Pan_A.Style.Add("display", "none");
                    imgUpload.Style.Add("display", "none");
                    Button1.Style.Add("display", "none");
                    txtPANDetails.ReadOnly = false;
                    btnreject.Style.Add("display", "none");
                    approveRejectimg.Src = "~/images/rejectStamp.png";
                }
                else if (pstatus == "1")
                {
                    btn_Pan_A.Style.Add("display", "block");
                    btnreject.Style.Add("display", "block");
                    txtPANDetails.ReadOnly = true;
                    FU1.Enabled = false;
                    imgUpload.Style.Add("display", "block");
                    imgUpload.ImageUrl = "~/images/KYC/PanImage/" + dr["panimage"].ToString();
                    Button1.Style.Add("display", "none");
                    btnreject.Style.Add("display", "block");
                    approveRejectimg.Src = "~/images/pendingStamp.png";
                }

                if (bkstatus == "0")
                {
                    btn_BANK_A.Style.Add("display", "none");
                    imgUpload1.Style.Add("display", "none");
                    btnreject1.Style.Add("display", "none");
                    approveRejectImg1.Src = "~/images/rejectStamp.png";
                }
                else if (bkstatus == "1")
                {
                    btn_BANK_A.Style.Add("display", "block");
                    ddlBankName.Enabled = false;
                    ddlAcType.Enabled = false;
                    txtAccNo.Enabled = false;
                    txtbranch.Enabled = false;
                    txtifs.Enabled = false;
                    fileCancelCq.Enabled = false;
                    imgUpload1.Style.Add("display", "block");
                    imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + bankImg;
                    btnreject1.Style.Add("display", "block");
                    approveRejectImg1.Src = "~/images/pendingStamp.png";
                }
                else if (bkstatus == "2")
                {
                    btn_BANK_A.Style.Add("display", "none");
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


                if (aastatus == "0")
                {
                    imgUpload2.Style.Add("display", "none");
                    imgUpload3.Style.Add("display", "none");
                    btn_AADHAR_A.Style.Add("display", "none");
                    Button6.Style.Add("display", "none");
                    btnreject2.Style.Add("display", "none");
                    FU2.Enabled = true;
                    FU3.Enabled = true;
                    approveRejectImg2.Src = "~/images/rejectStamp.png";
                }
                else if (aastatus == "1")
                {
                    btn_AADHAR_A.Style.Add("display", "block");
                    txtAadharNo.Enabled = false;
                    imgUpload2.Style.Add("display", "block");
                    imgUpload3.Style.Add("display", "block");

                    imgUpload2.ImageUrl = "~/images/KYC/AadharImage/Front/" + dr["AadharFront"].ToString();
                    imgUpload3.ImageUrl = "~/images/KYC/AadharImage/Back/" + dr["AadharBack"].ToString();
                    Button6.Style.Add("display", "none");
                    btnreject2.Style.Add("display", "block");
                    FU2.Enabled = false;
                    FU3.Enabled = false;
                    approveRejectImg2.Src = "~/images/pendingStamp.png";
                }
                else if (aastatus == "2")
                {
                    btn_AADHAR_A.Style.Add("display", "none");
                    txtAadharNo.Enabled = false;
                    approveRejectImg2.Src = "~/images/ApproveGreen.png";
                    imgUpload2.ImageUrl = "~/images/KYC/AadharImage/Front/" + dr["AadharFront"].ToString();
                    imgUpload3.ImageUrl = "~/images/KYC/AadharImage/Back/" + dr["AadharBack"].ToString();
                    FU2.Enabled = false;
                    FU3.Enabled = false;
                }


                if (pstatus == "2" && bkstatus == "2" && aastatus == "2")
                {
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
                    btnreject.Visible = false;
                    approveRejectimg.Src = "~/images/ApproveGreen.png";
                    FU2.Enabled = false;
                    FU3.Enabled = false;
                }


                
                ddlGtitle.SelectedValue = dr["gtitle"].ToString();
                try
                {
                    txtDOB.Text = dr["userdob"].ToString();
                }
                catch (Exception ex)
                { }

                DropDownList1.SelectedValue = dr["AppMstTitle"].ToString();
                lbl_username.Text= txtfname.Text = dr["AppMstFName"].ToString();
                txtSPID.Text = dr["sponsorid"].ToString();
                lblid.Text = dr["AppMstRegNo"].ToString();
                rbtnlstActivate.SelectedValue = dr["appmstactivate"].ToString();
                if (dr["appmstactivate"].ToString() == "0")
                {
                    lblIndicator.BackColor = Color.Red;
                }
                else if (dr["appmstactivate"].ToString() == "1")
                {
                    lblIndicator.BackColor = Color.Green;
                }
                else if (dr["appmstactivate"].ToString() == "2")
                {
                    lblIndicator.BackColor = Color.Blue;
                }

                txtGName.Text = dr["GName"].ToString();
                RdoGenderNew.SelectedValue = dr["Gender"].ToString();
                txtAddress.Text = dr["AppMstAddress1"].ToString();
                txtMobile.Text = dr["AppMstMobile"].ToString();
                txtpincode.Text = dr["AppMstPinCode"].ToString();

                txtPANDetails.Text = dr["panno"].ToString();

                txtAadharNo.Text = dr["Aadharno"].ToString();

                txtEmail.Text = dr["email"].ToString();
                txtnomniName.Text = dr["nom_name"].ToString();
                txtrelation.Text = dr["nom_rela"].ToString();
                txtCity.Text = dr["appmstcity"].ToString();
                txt_Pswrd.Text = objDut.base64Decode(dr["AppMstPassword"].ToString());

                System.Web.UI.WebControls.Image imgOnMasterPage = (System.Web.UI.WebControls.Image)(this.Master.FindControl("ProfileImage"));
                System.Web.UI.WebControls.Image mobimg = (System.Web.UI.WebControls.Image)(this.Master.FindControl("MobProfileImg"));
                if (imgOnMasterPage != null)
                {
                    imgOnMasterPage.ImageUrl = mobimg.ImageUrl = "~/images/KYC/ProfileImage/" + dr["imagename"].ToString();
                }

                if (dr["appmststate"].ToString() != "")
                {
                    ddlState.Items.FindByText(dr["appmststate"].ToString()).Selected = true;
                }
                BindDistrict(ddlState.SelectedItem.Value.ToString());
                if (dr["distt"].ToString() != "")
                {
                    if (!string.IsNullOrEmpty(dr["distt"].ToString()))
                        ddlDistrict.Items.FindByText(dr["distt"].ToString()).Selected = true;
                }
                try
                {
                    txtAccNo.Text = dr["acountno"].ToString();
                    txtbranch.Text = dr["branch"].ToString();
                    txtifs.Text = dr["IFSCode"].ToString();

                    ddlBankName.SelectedValue = dr["BankName"].ToString();
                    ddlAcType.SelectedValue = dr["type"].ToString();
                }
                catch (Exception ex) { }

            }
        }
        catch (Exception er) { }
    }
    #endregion

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string str1 = Request.QueryString["n"].ToString();
        if (Regex.Match(str1, @"^[a-zA-Z0-9]*$").Success)
        {
            if (ddlState.SelectedIndex != 0 && ddlDistrict.SelectedIndex != 0)
            {
                if (!string.IsNullOrEmpty(txtMobile.Text.Trim()) && Regex.IsMatch(txtMobile.Text.Trim(), @"^[6-9][0-9]{9}$"))
                {
                    if (!string.IsNullOrEmpty(txtEmail.Text.Trim()) && val.IsValidEmail(txtEmail.Text.Trim()))
                    {
                        if (!string.IsNullOrEmpty(txtpincode.Text.Trim()) && val.IsValidPINCode(txtpincode.Text.Trim()))
                        {
                            updatedata();
                        }
                        else
                        {
                            utility.MessageBox(this, "Please Enter Valid PinCode !");
                            txtMobile.Focus();
                            return;
                        }
                    }

                    else
                    {
                        utility.MessageBox(this, "Please Enter Valid Email Id !");
                        txtMobile.Focus();
                        return;
                    }
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
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime dob = new DateTime();
            try
            {
                dob = Convert.ToDateTime(txtDOB.Text.Trim(), dateInfo);
            }
            catch
            {
                lblMessage.Text = "Invalid Date Of Birth !";
            }
            utility objU = new utility();
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("insertmodifyprofile", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@modifiedby ", Session["admin"].ToString());
            com.Parameters.AddWithValue("@appmstregno", Request.QueryString["n"].ToString());
            com.Parameters.AddWithValue("@title1", DropDownList1.SelectedValue);
            com.Parameters.AddWithValue("@fname1", txtfname.Text);
            com.Parameters.AddWithValue("@Mname1", "");
            com.Parameters.AddWithValue("@Gender", RdoGenderNew.SelectedValue);
            com.Parameters.AddWithValue("@Address1", txtAddress.Text);
            com.Parameters.AddWithValue("@City1", txtCity.Text.Trim());
            com.Parameters.AddWithValue("@State1", ddlState.SelectedItem.Text.Trim());
            com.Parameters.AddWithValue("@distt1", ddlDistrict.SelectedItem.Text.Trim());
            com.Parameters.AddWithValue("@PinCode1", txtpincode.Text.Trim());
            com.Parameters.AddWithValue("@Mobile1", txtMobile.Text.Trim());
            com.Parameters.AddWithValue("@nomname1", txtnomniName.Text.Trim());
            com.Parameters.AddWithValue("@nomrela1", txtrelation.Text);
            com.Parameters.AddWithValue("@userdob1", dob);
            com.Parameters.AddWithValue("@activate1", rbtnlstActivate.SelectedValue.ToString());
            com.Parameters.AddWithValue("@GName1", txtGName.Text.Trim());
            com.Parameters.AddWithValue("@GTitle1", ddlGtitle.SelectedItem.Text);
            com.Parameters.AddWithValue("@email1", txtEmail.Text.Trim());
            com.Parameters.AddWithValue("@pswrd", objU.base64Encode(txt_Pswrd.Text.Trim()));
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            string result = com.Parameters["@flag"].Value.ToString();
            if (result == "1")
            {
                con.Close();
                utility.MessageBox(this, "Profile edited successfully!");
            }
            else
            {
                utility.MessageBox(this, result);
            }
            BindUserDetails();
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.Message.ToString());
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
                            string usrId = Request.QueryString["n"].ToString();
                            string imagename = insFunc.insertPanDetail(panText, usrId, fileName);
                            cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), imagename);
                            resizedImg.Save(cropFilePath);
                            imgUpload.ImageUrl = "~/images/KYC/PanImage/" + imagename;
                            txtPANDetails.ReadOnly = true;
                            FU1.Enabled = false;
                            btnreject.Style.Add("display", "block");
                            BindUserDetails();
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
                            string usrId = Request.QueryString["n"].ToString();
                            string imagename = insFunc.insertPanDetail(panText, usrId, fileName);
                            cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), imagename);
                            resizedImg.Save(cropFilePath);
                            imgUpload.ImageUrl = "~/images/KYC/PanImage/" + imagename;
                            txtPANDetails.ReadOnly = true;
                            FU1.Enabled = false;
                            btnreject.Style.Add("display", "block");
                            BindUserDetails();
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
                            string usrId = Request.QueryString["n"].ToString();
                            string txtBranch = txtbranch.Text.Trim();
                            string imagename = insFunc.insertBankDetail(fileName, ddlBkName, ddlActype, txtacno, txtIfsc, txtBranch, usrId);
                            cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), imagename);
                            resizedImg.Save(cropFilePath);
                            imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + imagename;
                            string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong>Your Bank details uploaded successfully</div>");
                            BindUserDetails();
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
                            string usrId = Request.QueryString["n"].ToString();
                            string txtBranch = txtbranch.Text.Trim();
                            string imagename = insFunc.insertBankDetail(fileName, ddlBkName, ddlActype, txtAccno, txtIfsc, txtBranch, usrId);
                            cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), imagename);
                            resizedImg.Save(cropFilePath);
                            imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + imagename;
                            string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong>Your Bank details uploaded successfully</div>");
                            BindUserDetails();
                        }
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
            try
            {
                string Random = Guid.NewGuid().ToString();
                string Random1 = Guid.NewGuid().ToString();

                string fileName1 = Path.GetFileName(Random + Path.GetExtension(FU2.FileName));  //Path.GetFileName(FU2.PostedFile.FileName);
                string fileName2 = Path.GetFileName(Random1 + Path.GetExtension(FU3.FileName)); // Path.GetFileName(FU3.PostedFile.FileName);
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
                            string usrId = Request.QueryString["n"].ToString();
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
                            }
                            BindUserDetails();
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
                            string usrId = Request.QueryString["n"].ToString();
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
                                BindUserDetails();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        utility.MessageBox(this, ex.Message);
                    }
                    finally
                    { }
                }
                else
                {
                    utility.MessageBox(this, "Please insert both front And back Address image.");
                    imgUpload3.Focus();
                }
            }
            catch (Exception ex)
            {
                utility.MessageBox(this, ex.Message);
            }
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
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP("GetState");
            if (dt.Rows.Count > 0)
            {
                ddlState.DataSource = dt;
                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "SId";
                ddlState.DataBind();
                ddlState.Items.Insert(0, new ListItem("Select Bank", ""));
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
            SqlParameter[] param = new SqlParameter[]
           { new SqlParameter("@state", value) };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "GetStateDistrict");

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

    public void BindBank()
    {
        try
        {
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP("GetBank");
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


    #region Delete Indivisual and All KYC

    protected void AllKYC_Reject(object sender, EventArgs e)
    {
        if (HttpContext.Current.Request.QueryString.Count == 0 || HttpContext.Current.Request.QueryString["n"] == null)
        {
            return;
        }

        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("Del_KYC_Detail", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@regno", HttpContext.Current.Request.QueryString["n"].ToString());
        cmd.Parameters.AddWithValue("@modifiedby", HttpContext.Current.Session["admin"].ToString());
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        con.Open();
        cmd.ExecuteNonQuery();
        string flag = cmd.Parameters["@flag"].Value.ToString();
        utility.MessageBox(this, flag);
        Response.Redirect(Request.RawUrl);
    }


    [WebMethod]
    public static string UpdateReject(string kycid, string Userid)
    {
        SqlConnection con = new SqlConnection(method.str);

        string admin = "";
        if (HttpContext.Current.Session["admin"] != null)
            admin = HttpContext.Current.Session["admin"].ToString();

        DataUtility objDu = new DataUtility();
        SqlParameter[] prm = new SqlParameter[] { new SqlParameter("@Userid1", Userid) };

        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Userid", Userid) };

        if (kycid == "1")
        {
            try
            {

                SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", Userid),
                    new SqlParameter("@modifiedby", admin),
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
                string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Address proof uploaded</div>");
                return "Pan Deleted";
            }
            catch (Exception ex)
            {
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
                    new SqlParameter("@regno", Userid),
                    new SqlParameter("@modifiedby", admin),
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
                    new SqlParameter("@regno", Userid),
                    new SqlParameter("@modifiedby", admin),
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

            }
            catch (Exception ex)
            {

            }
        }
        return "there is an issue";
    }
    #endregion


    #region KYCApprove
    [WebMethod]
    public static string btnApproveKYC_Click(string kycid, string regno, string name, string mobile)
    {
        SqlConnection con = new SqlConnection(method.str);
        if (string.IsNullOrEmpty(regno))
        {
            return "SessionOut";
        }

        if (kycid == "1")
        {
            try
            {
                con = new SqlConnection(method.str);
                string querry = "select appmstmobile from AppMst where AppMstRegNo='" + regno + "'";
                SqlCommand cmd1 = new SqlCommand(querry, con);
                con.Open();
                cmd1.ExecuteScalar();
                using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    while (reader.Read())
                    {
                        mobile = reader["appmstmobile"].ToString();
                    }
                }
                string upStatus = "Update scandocs set PStatus=2, panDateApproved=getdate() from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + regno + "'";
                SqlCommand cmd = new SqlCommand(upStatus, con);
                con.Open();
                cmd.ExecuteNonQuery();
                string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Address proof uploaded</div>");
                string UserName = name;
                string subUserName, text = "";
                if (UserName.Length > 20)
                {
                    subUserName = UserName.Substring(0, 20).ToString();
                    text = "Dear " + subUserName + " ID No :" + regno + " KYC for Pan Approved ";
                }
                else
                {
                    text = "Dear " + UserName + " ID No :" + regno + " KYC for Pan Approved ";
                }


                DataUtility objDu = new DataUtility();
                SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", regno),
                    new SqlParameter("@modifiedby", HttpContext.Current.Session["admin"].ToString()),
                    new SqlParameter("@Remark", "Approved Pan")

                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");

                utility objUt = new utility();
                objUt.sendSMSByBilling(mobile, text, "KYC");
                return "Pan Approved";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        if (kycid == "2")
        {
            try
            {
                con = new SqlConnection(method.str);
                string querry = "select appmstmobile from  AppMst where AppMstRegNo='" + regno + "'";
                SqlCommand cmd1 = new SqlCommand(querry, con);
                con.Open();
                cmd1.ExecuteScalar();
                using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    while (reader.Read())
                    {
                        mobile = reader["appmstmobile"].ToString();
                    }
                }
                string upStatus = "Update scandocs set bankstatus=2, bankDateApproved=getdate() from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + regno + "'";
                SqlCommand cmd = new SqlCommand(upStatus, con);
                con.Open();
                cmd.ExecuteNonQuery();
                string UserName = name;
                string subUserName, text = "";
                if (UserName.Length > 20)
                {
                    subUserName = UserName.Substring(0, 20).ToString();
                    text = "Dear " + subUserName + " ID No :" + regno + " KYC for Bank Approved ";
                }
                else
                {
                    text = "Dear " + UserName + " ID No :" + regno + " KYC for Bank Approved ";
                }

                DataUtility objDu = new DataUtility(); SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", regno),
                    new SqlParameter("@modifiedby", HttpContext.Current.Session["admin"].ToString()),
                    new SqlParameter("@Remark", "Approved Bank")
                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");

                utility objUt = new utility();
                objUt.sendSMSByBilling(mobile, text, "KYC");
                return "Bank approved";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        if (kycid == "3")
        {
            try
            {
                con = new SqlConnection(method.str);
                string querry = "select appmstmobile from  AppMst where AppMstRegNo='" + regno + "'";
                SqlCommand cmd1 = new SqlCommand(querry, con);
                con.Open();
                cmd1.ExecuteScalar();
                using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    while (reader.Read())
                    {
                        mobile = reader["appmstmobile"].ToString();
                    }
                }
                string upstatus = "Update scandocs set AaStatus=2, docDateApproved=getdate() from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + regno + "'";
                SqlCommand cmd = new SqlCommand(upstatus, con);
                con.Open();
                cmd.ExecuteNonQuery();
                string UserName = name;
                string subUserName, text = "";
                if (UserName.Length > 20)
                {
                    subUserName = UserName.Substring(0, 20).ToString();
                    text = "Dear " + subUserName + " ID No :" + regno + " KYC for Address Approved ";
                }
                else
                {
                    text = "Dear " + UserName + " ID No :" + regno + " KYC for Address Approved ";
                }


                DataUtility objDu = new DataUtility(); SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                SqlParameter[] param1 = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@regno", regno),
                    new SqlParameter("@modifiedby", HttpContext.Current.Session["admin"].ToString()),
                    new SqlParameter("@Remark", "Approved Aadhar")
                };
                int result = objDu.ExecuteSqlSP(param1, "AddLogForUserProfile");


                utility objUt = new utility();
                objUt.sendSMSByBilling(mobile, text, "KYC");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        return "there is an issue";


    }
    #endregion

}
