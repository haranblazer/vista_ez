using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.Services;
using System.Drawing;
using System.IO;

public partial class admin_edit : System.Web.UI.Page
{
    int chk = 0;
    string strajax = "";
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    DataTable dt;
    utility obj = new utility();
    InsertFunction insFunc = new InsertFunction();
    static string strid, strname, stradmin;
    protected void Page_Load(object sender, EventArgs e)
    {
        obj = new utility();
        //stradmin = Convert.ToString(Session["UserName"]);
        strid = Convert.ToString(Session["FranchiseId"]);
        //strid = objUtil.base64Decode(Request.QueryString["n"].ToString());
        //strname = Convert.ToString(Request.QueryString["n1"]);
        if (Session["FranchiseId"] == null)
        {
            Response.Redirect("Logout.aspx");
        }

        if (!IsPostBack)
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();
            if (strid != null)
            {
                BindState();
                BindBank();
                ShowCreateFran();
                Bind_FranchiseType();
                editFranchise(strid);
                //CheckStatus();
            }
            //else if (strname != null)
            //{
            //    Bind_FranchiseType();

            //    BindState();
            //    BindBank();
            //    ShowCreateFran();


            //    editFranchise(strname);
            //}
            else
            {
                Response.Redirect("expire.aspx");
            }

            //finddata();
        }
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }


    #region CheckProfileEdit
    //private void CheckStatus()
    //{
    //    con = new SqlConnection(method.str);
    //    string quer = "select frandocs.bankstatus as bkstatus,panno,frandocs.pstatus as pkstatus,frandocs.Gstatus as Gstatus,frandocs.gstFileName as gstFilename,panImage,frandocs.BankImage,Aadharfront,AadharBack,frandocs.aastatus as aastatus from frandocs inner join FranchiseMst on frandocs.FranchiseId=FranchiseMst.FranchiseId where FranchiseMst.FranchiseId='" + Session["FranchiseId"] + "'";
    //    SqlCommand cmd1 = new SqlCommand(quer, con);
    //    con.Open();
    //    cmd1.ExecuteScalar();
    //    using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
    //    {
    //        while (reader.Read())
    //        {
    //            string bkstatus = reader["bkstatus"].ToString();
    //            string bankImg = reader["BankImage"].ToString();
    //            string pstatus = reader["pkstatus"].ToString();
    //            string Gstatus = reader["Gstatus"].ToString();
    //            if (bkstatus == "0")
    //            {
    //                fileCancelCq.Enabled = true;
    //                imgUpload1.Style.Add("display", "none");
    //                btnreject1.Style.Add("display", "none");
    //               
    //            }
    //            if (bkstatus == "1")
    //            {
    //                fileCancelCq.Enabled = false;
    //                imgUpload1.Style.Add("display", "block");
    //                imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + bankImg;
    //                btnreject1.Style.Add("display", "block");
    //               
    //            }

    //            if (bkstatus == "2")
    //            {

    //                btnreject1.Visible = false;
    //                if (bankImg != "")
    //                {
    //                    fileCancelCq.Enabled = false;
    //                    imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + bankImg;
    //                    approveRejectImg1.Src = "~/images/ApproveGreen.png";
    //                }
    //            }

    //            if (pstatus == "2")
    //            {
    //                string panimage = reader["panImage"].ToString();
    //                txtPanNo.ReadOnly = true;
    //                FileUpload1.Enabled = false;
    //                //btnSubmit.Visible = false;
    //                btnreject.Visible = false;
    //                if (panimage != "")
    //                {
    //                    imgUpload.ImageUrl = "~/images/KYC/PanImage/" + panimage;
    //                    imgUpload.Style.Add("display", "block");
    //                    approveRejectimg.Src = "~/images/ApproveGreen.png";
    //                }
    //            }

    //            if (pstatus == "0")
    //            {
    //                string strHtml = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Good! </strong> to upload</div>");

    //                Button1.Style.Add("display", "none");
    //                txtPanNo.ReadOnly = false;
    //                btnreject.Style.Add("display", "none");
    //                approveRejectimg.Src = "~/images/rejectStamp.png";
    //            }

    //            else if (pstatus == "1")
    //            {
    //                btnreject.Style.Add("display", "block");
    //                txtPanNo.ReadOnly = true;
    //                FileUpload1.Enabled = false;
    //                imgUpload.Style.Add("display", "block");
    //                hiddenpanimg.Value = reader["panimage"].ToString();
    //                imgUpload.ImageUrl = "~/images/KYC/PanImage/" + reader["panimage"].ToString();
    //                Button1.Style.Add("display", "none");
    //                btnreject.Style.Add("display", "block");
    //                approveRejectimg.Src = "~/images/pendingStamp.png";
    //                //rotateImg.Style.Add("display", "block");
    //            }

    //            if (Gstatus == "2")
    //            {
    //                string gstname = reader["gstFilename"].ToString();
    //                txtPanNo.ReadOnly = true;
    //                FileUpload1.Enabled = false;
    //                //btnSubmit.Visible = false;
    //                btnreject.Visible = false;
    //                if (gstname != "")
    //                {
    //                    FileUploadDoc.Enabled = false;
    //                    approveRejectImage2.Src = "~/images/ApproveGreen.png";
    //                    string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"100%\" height=\"400px\">";
    //                    embed += "If you are unable to view file, you can download from <a href = \"{0}\">here</a>";
    //                    embed += " or download <a target = \"_blank\" href = \"http://get.adobe.com/reader/\">Adobe PDF Reader</a> to view the file.";
    //                    embed += "</object>";
    //                    ltEmbed.Text = string.Format(embed, ResolveUrl("~/images/GSTpdf/" + gstname));
    //                    approveRejectImage2.Src = "~/images/pendingStamp.png";
    //                }
    //            }

    //            if (Gstatus == "0")
    //            {
    //                string gstname = reader["gstFilename"].ToString();

    //                approveRejectImage2.Src = "~/images/rejectStamp.png";
    //            }

    //            else if (Gstatus == "1")
    //            {
    //                string gstname = reader["gstFilename"].ToString();
    //                string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"100%\" height=\"400px\">";
    //                embed += "If you are unable to view file, you can download from <a href = \"{0}\">here</a>";
    //                embed += " or download <a target = \"_blank\" href = \"http://get.adobe.com/reader/\">Adobe PDF Reader</a> to view the file.";
    //                embed += "</object>";
    //                FileUploadDoc.Enabled = false;

    //                btnrejectPdf.Style.Add("display", "block");
    //                ltEmbed.Text = string.Format(embed, ResolveUrl("~/images/GSTpdf/" + gstname));
    //                approveRejectImage2.Src = "~/images/pendingStamp.png";
    //                //rotateImg.Style.Add("display", "block");
    //            }


    //        }
    //    }
    //}
    #endregion

    public void editFranchise(string fid)
    {
        try
        {

            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@fid", fid) };
            DataUtility objDu = new DataUtility();
            DataTable dt = new DataTable();
            dt = objDu.GetDataTable(param, @"select DeclDate=(Case when GST_DeclDate is null then '' else convert(varchar(12), GST_DeclDate ,106) End) ,
            GSTDateLoad=convert(varchar(12), GSTDateLoad ,106), GSTDateApproved=convert(varchar(12), GSTDateApproved ,106),
            COMPANYNAME=(Select UserVal from SettingMst where Caption='COMPANYNAME'),
            COM_CINNO=(Select UserVal from SettingMst where Caption='COM_CINNO'),
            COM_ADDRESS=(Select UserVal from SettingMst where Caption='COM_ADDRESS'),

            * from FranchiseMst where FranchiseId=@fid");
            if (dt.Rows.Count > 0)
            {

                if (dt.Rows[0]["ProfileUpdated"].ToString() == "1")
                {
                    btnSubmit.Attributes.Add("style", "display:none");
                    lbl_Msg.Text = "Profile Updated.!!";
                }

                lbl_CompanyAddress.InnerHtml = dt.Rows[0]["COM_ADDRESS"].ToString();
                lbl_CompanyName1.InnerHtml = lbl_CompanyName.InnerHtml = dt.Rows[0]["COMPANYNAME"].ToString();
                lbl_CompanyCIN.InnerHtml = dt.Rows[0]["COM_CINNO"].ToString();

                lbl_GST_upload_date.InnerHtml = dt.Rows[0]["GSTDateLoad"].ToString();
                lbl_GST_approve_date.InnerHtml = dt.Rows[0]["GSTDateApproved"].ToString();


                //Bank
                if (dt.Rows[0]["Bank_VFYD"].ToString() == "0")
                {
                    div_Bank_Appv_Reject.InnerHtml = "<a href='../images/pendingStamp.png' data-fancybox='gallery'> <img src='../images/pendingStamp.png' width='60px' height='70px'> </a>";
                }
                else if (dt.Rows[0]["Bank_VFYD"].ToString() == "1")
                {
                    uploadimg_Bank.Attributes.Add("style", "display:none");
                    btn_BANK_R.Attributes.Add("style", "display:none");
                    div_Bank_Appv_Reject.InnerHtml = "<a href='../images/ApproveGreen.png' data-fancybox='gallery'> <img src='../images/ApproveGreen.png' width='60px' height='70px'> </a>";
                }
                else if (dt.Rows[0]["Bank_VFYD"].ToString() == "2")
                {
                    btn_BANK_R.Attributes.Add("style", "display:none");
                    div_Bank_Appv_Reject.InnerHtml = "<a href='../images/rejectStamp.png' data-fancybox='gallery'> <img src='../images/rejectStamp.png' width='60px' height='70px'> </a>";
                }

                if (!string.IsNullOrEmpty(dt.Rows[0]["Bank_img"].ToString()))
                {
                    lbl_BankImg.InnerHtml = "<a href='../images/KYC/" + dt.Rows[0]["Bank_img"].ToString() + "' data-fancybox='gallery'> <img src='../images/KYC/" + dt.Rows[0]["Bank_img"].ToString() + "' width='150px' height='100px'> </a>";
                }
                else
                {
                    btn_BANK_R.Attributes.Add("style", "display:none");
                }


                //Pan

                if (dt.Rows[0]["Pan_VFYD"].ToString() == "0")
                {
                    div_Pan_Appv_Reject.InnerHtml = "<a href='../images/pendingStamp.png' data-fancybox='gallery'> <img src='../images/pendingStamp.png' width='60px' height='70px'> </a>";
                }
                else if (dt.Rows[0]["Pan_VFYD"].ToString() == "1")
                {
                    uploadimg_Pan.Attributes.Add("style", "display:none");
                    btn_Pan_R.Attributes.Add("style", "display:none");
                    div_Pan_Appv_Reject.InnerHtml = "<a href='../images/ApproveGreen.png' data-fancybox='gallery'> <img src='../images/ApproveGreen.png' width='60px' height='70px'> </a>";
                }
                else if (dt.Rows[0]["Pan_VFYD"].ToString() == "2")
                {
                    btn_Pan_R.Attributes.Add("style", "display:none");
                    div_Pan_Appv_Reject.InnerHtml = "<a href='../images/rejectStamp.png' data-fancybox='gallery'> <img src='../images/rejectStamp.png' width='60px' height='70px'> </a>";
                }


                if (!string.IsNullOrEmpty(dt.Rows[0]["Pan_img"].ToString()))
                {
                    lbl_PanImg.InnerHtml = "<a href='../images/KYC/" + dt.Rows[0]["Pan_img"].ToString() + "' data-fancybox='gallery'> <img src='../images/KYC/" + dt.Rows[0]["Pan_img"].ToString() + "' width='150px' height='100px'> </a>";
                }
                else
                {
                    btn_Pan_R.Attributes.Add("style", "display:none");
                }


                //Aadhar

                if (dt.Rows[0]["AADHAR_VFYD"].ToString() == "0")
                {
                    div_Aadhar_Appv_Reject.InnerHtml = "<a href='../images/pendingStamp.png' data-fancybox='gallery'> <img src='../images/pendingStamp.png' width='60px' height='70px'> </a>";
                }
                else if (dt.Rows[0]["AADHAR_VFYD"].ToString() == "1")
                {
                    uploadimg_Aadhar.Attributes.Add("style", "display:none");
                    btn_AADHAR_R.Attributes.Add("style", "display:none");
                    div_Aadhar_Appv_Reject.InnerHtml = "<a href='../images/ApproveGreen.png' data-fancybox='gallery'> <img src='../images/ApproveGreen.png' width='60px' height='70px'> </a>";
                }
                else if (dt.Rows[0]["AADHAR_VFYD"].ToString() == "2")
                {
                    btn_AADHAR_R.Attributes.Add("style", "display:none");
                    div_Aadhar_Appv_Reject.InnerHtml = "<a href='../images/rejectStamp.png' data-fancybox='gallery'> <img src='../images/rejectStamp.png' width='60px' height='70px'> </a>";
                }




                if (!string.IsNullOrEmpty(dt.Rows[0]["Aadhar_F_img"].ToString()))
                {
                    lbl_AadharFrontImg.InnerHtml = "<a href='../images/KYC/" + dt.Rows[0]["Aadhar_F_img"].ToString() + "' data-fancybox='gallery'> <img src='../images/KYC/" + dt.Rows[0]["Aadhar_F_img"].ToString() + "' width='150px' height='100px'> </a>";
                }
                else
                {
                    btn_AADHAR_R.Attributes.Add("style", "display:none");
                }
                if (!string.IsNullOrEmpty(dt.Rows[0]["Aadhar_B_img"].ToString()))
                {
                    lbl_AadharBackImg.InnerHtml = "<a href='../images/KYC/" + dt.Rows[0]["Aadhar_B_img"].ToString() + "' data-fancybox='gallery'> <img src='../images/KYC/" + dt.Rows[0]["Aadhar_B_img"].ToString() + "' width='150px' height='100px'> </a>";
                }


                //GST  
                if (dt.Rows[0]["GST_VFYD"].ToString() == "0")
                {
                    div_Gst_Appv_Reject.InnerHtml = "<a href='../images/pendingStamp.png' data-fancybox='gallery'> <img src='../images/pendingStamp.png' width='60px' height='70px'> </a>";
                }
                else if (dt.Rows[0]["GST_VFYD"].ToString() == "1")
                {
                    uploadimg_GST.Attributes.Add("style", "display:none");
                    btn_GST_R.Attributes.Add("style", "display:none");
                    div_Gst_Appv_Reject.InnerHtml = "<a href='../images/ApproveGreen.png' data-fancybox='gallery'> <img src='../images/ApproveGreen.png' width='60px' height='70px'> </a>";
                }
                else if (dt.Rows[0]["GST_VFYD"].ToString() == "2")
                {
                    btn_AADHAR_R.Attributes.Add("style", "display:none");
                    div_Gst_Appv_Reject.InnerHtml = "<a href='../images/rejectStamp.png' data-fancybox='gallery'> <img src='../images/rejectStamp.png' width='60px' height='70px'> </a>";
                }



                if (!string.IsNullOrEmpty(dt.Rows[0]["GST_img"].ToString()))
                {
                    lbl_GSTImg.InnerHtml = "<a href='../images/KYC/" + dt.Rows[0]["GST_img"].ToString() + "' data-fancybox='gallery'>  <i class='fa fa-eye btn btn-success'></i>   </a>"; 
                }
                else
                {
                    btn_GST_R.Attributes.Add("style", "display:none");  
                }


                if (!string.IsNullOrEmpty(dt.Rows[0]["Slip"].ToString()))
                {
                    lbl_Slipimg.InnerHtml = "<a href='../images/KYC/" + dt.Rows[0]["Slip"].ToString() + "' data-fancybox='gallery'> <img src='../images/KYC/" + dt.Rows[0]["Slip"].ToString() + "' width='150px' height='100px'> </a>";
                }




                txtAadharNo.Text = dt.Rows[0]["AadharNo"].ToString();

                lbl_GST_FranName.InnerHtml = dt.Rows[0]["FName"].ToString();

                if (!string.IsNullOrEmpty(dt.Rows[0]["DeclDate"].ToString()))
                {
                    div_gst_decl.Visible = true;

                    lbl_GST_Datetime.InnerHtml = dt.Rows[0]["DeclDate"].ToString();
                    btn_gst_decl_Accept.Visible = false;

                }





                txtName.Text = dt.Rows[0]["FName"].ToString();
                txtAddress.Text = dt.Rows[0]["Address"].ToString();
                txtCity.Text = dt.Rows[0]["City"].ToString();
                txtPinCode.Text = dt.Rows[0]["PinCode"].ToString();
                txtMobileNo.Text = dt.Rows[0]["Mobile"].ToString();
                txtContactPerson.Text = dt.Rows[0]["ContactPerson"].ToString();
                txtEMailId.Text = dt.Rows[0]["email"].ToString();
                txt_fMappingId.Text = dt.Rows[0]["MappingId"].ToString();
                txtCinNo.Text = dt.Rows[0]["CinNo"].ToString();
                txtPanNo.Text = dt.Rows[0]["PanNo"].ToString();
                txtGSTNo.Text = dt.Rows[0]["GST"].ToString();
                hnd_OTPVFYD.Value = dt.Rows[0]["OTP_Verify"].ToString() == "1" ? "1" : "0";
                txtaccountno.Text = dt.Rows[0]["AccountNo"].ToString();
                txtifsc.Text = dt.Rows[0]["IFSCCode"].ToString();
                txtbranch.Text = dt.Rows[0]["Branch"].ToString();
                txtPassword.Text = obj.base64Decode(dt.Rows[0]["Password"].ToString());
                txtConfirmPassword.Text = obj.base64Decode(dt.Rows[0]["Password"].ToString());
                lblpassword.Text = txtConfirmPassword.Text.Trim();
                lblFID.Text = dt.Rows[0]["FranchiseId"].ToString();
                txtPassword.Attributes["value"] = obj.base64Decode(dt.Rows[0]["Password"].ToString());
                txtConfirmPassword.Attributes["value"] = obj.base64Decode(dt.Rows[0]["Password"].ToString());
                try
                {
                    ddlactype.SelectedValue = dt.Rows[0]["AccountType"].ToString();

                    ddltype.SelectedValue = dt.Rows[0]["Frantype"].ToString();

                    ddlState.Items.FindByValue("0").Selected = false;
                    ddlState.Items.FindByText(dt.Rows[0]["State"].ToString()).Selected = true;
                    BindDistrict(ddlState.SelectedValue.ToString());
                    ListItem item = new ListItem("Select District", "0");
                    ddlDistrict.Items.Add(item);

                    // Assuming dt.Rows[0]["distt"].ToString() contains the name of the district
                    ListItem districtItem = ddlDistrict.Items.FindByText(dt.Rows[0]["distt"].ToString());
                    if (districtItem != null)
                    {
                        item.Selected = false;
                        districtItem.Selected = true;
                    }
                    //ddlDistrict.Items.FindByValue("0").Selected = false;
                    //ddlDistrict.Items.FindByText(dt.Rows[0]["distt"].ToString()).Selected = true;

                    //rblsampleal.Items.FindByValue("1").Selected = false;
                    //rblsampleal.Items.FindByText(dt.Rows[0]["SampleAllowed"].ToString()).Selected = true;
                    ListItem item1 = new ListItem("Select District", "0");
                    ddlDistrict.Items.Add(item1);

                    // Assuming dt.Rows[0]["distt"].ToString() contains the name of the district
                    ListItem districtItem1 = ddlbankname.Items.FindByText(dt.Rows[0]["distt"].ToString());
                    if (districtItem1 != null)
                    {
                        item1.Selected = false;
                        districtItem1.Selected = true;
                    }
                    ddlbankname.Items.FindByValue("0").Selected = false;
                    //ddlbankname.Items.FindByText(dt.Rows[0]["BankName"].ToString()).Selected = true;

                    // ddltype.Items.FindByText("0").Selected = false;

                }
                catch (Exception er) { }
                ddltype.Enabled = false;
                ddlState.Enabled = false;
                txt_fMappingId.Enabled = false;
                txtName.Enabled = false;
                txtMobileNo.Enabled = false;
                //txtPassword.Enabled = false;
                //txtConfirmPassword.Enabled = false;

            }
        }
        catch (Exception er) { }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            //if (!string.IsNullOrEmpty(txtsponsorid.Text.Trim()))
            //{

            if (!string.IsNullOrEmpty(txtName.Text.Trim()))
            {
                if (!string.IsNullOrEmpty(txtAddress.Text.Trim()))
                {
                    if (!string.IsNullOrEmpty(txtCity.Text.Trim()))
                    {
                        if (ddlDistrict.SelectedIndex > 0)
                        {
                            if (ddlState.SelectedIndex > 0)
                            {
                                if (!string.IsNullOrEmpty(txtPinCode.Text.Trim()))
                                {
                                    if (Regex.Match(txtPinCode.Text.Trim().ToString(), @"^[0-9]*$").Success)
                                    {
                                        if (!string.IsNullOrEmpty(txtMobileNo.Text.Trim()))
                                        {
                                            if (Regex.Match(txtMobileNo.Text.Trim().ToString(), @"^[6789][0-9]{9}$").Success)
                                            {

                                                if (!string.IsNullOrEmpty(txtEMailId.Text.Trim()))
                                                {
                                                    if (Regex.Match(txtEMailId.Text.Trim().ToString(), @"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$").Success)
                                                    {

                                                        if (!string.IsNullOrEmpty(txtPanNo.Text.Trim()) && !obj.IsValidatePAN(txtPanNo.Text.Trim()))
                                                        {
                                                            utility.MessageBox(this, "Invalid PAN No.");
                                                            return;
                                                        }

                                                        if (Request.QueryString["n"] != null)
                                                        {
                                                            create();
                                                        }


                                                        if (Validation.IsValidPassword(txtPassword.Text.Trim()) == false)
                                                        {
                                                            utility.MessageBox(this, "Password contains [A-Za-z0-9!@#$%^&*()] value.!");
                                                            return;
                                                        }


                                                        if (lblFranSpon.Text == "User Does Not Exist!")
                                                        {
                                                            utility.MessageBox(this, "User Does Not Exist.");
                                                            txtsponsorid.Focus();
                                                            return;
                                                        }
                                                        string Password = txtConfirmPassword.Text.Trim();
                                                        txtPassword.Attributes.Add("value", Password);
                                                        txtConfirmPassword.Attributes.Add("value", Password);
                                                        HideCreateFran();
                                                        BindPanelData();


                                                    }
                                                    else
                                                        utility.MessageBox(this, "Email should be like abc@xyz.com !");
                                                }
                                                else
                                                    utility.MessageBox(this, "Please enter e mail id!");

                                            }
                                            else
                                                utility.MessageBox(this, "Please enter valid mobile number!");

                                        }
                                        else
                                            utility.MessageBox(this, "Please enter mobile number!");

                                    }
                                    else
                                        utility.MessageBox(this, "Please enter 6 digits pin code!");

                                }
                                else
                                    utility.MessageBox(this, "Please enter pin code!");

                            }
                            else
                                utility.MessageBox(this, "Please select state !");

                        }
                        else
                            utility.MessageBox(this, "Please select district !");
                    }
                    else
                        utility.MessageBox(this, "Please enter city !");

                }
                else
                    utility.MessageBox(this, "Please enter Address !");

            }
            else
                utility.MessageBox(this, "Please enter name !");
            //}
            //else
            //    utility.MessageBox(this, "Please Enter Franchise SponsorId !");
        }
        catch
        {

        }
    }


    public void create()
    {
        try
        {
            if (strid != null)
            {
                lblpassword.Text = txtConfirmPassword.Text.Trim();
                SqlCommand cmd = new SqlCommand("changefranchiseprofile", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fid", strid);
                cmd.Parameters.AddWithValue("@action", "update");
                cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("email", txtEMailId.Text.Trim());
                cmd.Parameters.AddWithValue("@distt", ddlDistrict.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@city", txtCity.Text.Trim());
                cmd.Parameters.AddWithValue("@address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@pincode", txtPinCode.Text.Trim());
                cmd.Parameters.AddWithValue("@mobile", txtMobileNo.Text.Trim());
                cmd.Parameters.AddWithValue("@pwd", obj.base64Encode(lblpassword.Text.Trim()));
                cmd.Parameters.AddWithValue("@panno", txtPanNo.Text.Trim());
                cmd.Parameters.AddWithValue("@AadharNo", txtAadharNo.Text.Trim());

                cmd.Parameters.AddWithValue("@GST", txtGSTNo.Text.Trim());
                cmd.Parameters.AddWithValue("@cinno", txtCinNo.Text.Trim());
                cmd.Parameters.AddWithValue("@primaryphone", txtContactPerson.Text.Trim());
                cmd.Parameters.AddWithValue("@username", "");
                cmd.Parameters.AddWithValue("@state", ddlState.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@SampleAllowed", rblsampleal.SelectedValue);
                cmd.Parameters.AddWithValue("@BankName", ddlbankname.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@Branch", txtbranch.Text.Trim());
                cmd.Parameters.AddWithValue("@AccountNo", txtaccountno.Text.Trim());
                cmd.Parameters.AddWithValue("@AccountType", ddlactype.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@IfscCode", txtifsc.Text.Trim());
                cmd.Parameters.AddWithValue("@Frantype", ddltype.SelectedValue);
                cmd.Parameters.AddWithValue("@FCom", txtfcom.Text.Trim());
                cmd.Parameters.AddWithValue("@FLimit", txtflimit.Text.Trim());

                cmd.Parameters.AddWithValue("@MappingId", txt_fMappingId.Text.Trim());
                cmd.Parameters.AddWithValue("@ContactPerson", txtContactPerson.Text.Trim());

                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                string msg = cmd.Parameters["@flag"].Value.ToString();
                if (msg == "1")
                {
                    con.Close();
                    utility.MessageBox(this, "Franchise Data Updated Successfully");
                }
            }
            //else
            //{
            //    utility objUt = new utility();

            //    com = new SqlCommand("CreateFranchise", con);
            //    com.CommandType = CommandType.StoredProcedure;
            //    com.Parameters.AddWithValue("@txtsponsorid", "12345");
            //    com.Parameters.AddWithValue("@FranchiseName", txtName.Text.Trim());
            //    com.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
            //    com.Parameters.AddWithValue("@City", txtCity.Text.Trim());
            //    com.Parameters.AddWithValue("@District", ddlDistrict.SelectedItem.Text.Trim());
            //    com.Parameters.AddWithValue("@State", ddlState.SelectedItem.Text.Trim());
            //    com.Parameters.AddWithValue("@PinCode", txtPinCode.Text.Trim());
            //    com.Parameters.AddWithValue("@EMailId", txtEMailId.Text.Trim());
            //    com.Parameters.AddWithValue("@MobileNo", txtMobileNo.Text.Trim());
            //    com.Parameters.AddWithValue("@ContactPerson", txtContactPerson.Text.Trim());
            //    com.Parameters.AddWithValue("@MappingId", txt_fMappingId.Text);
            //    com.Parameters.AddWithValue("@IP", "");
            //    com.Parameters.AddWithValue("@UserName", "");
            //    com.Parameters.AddWithValue("@Password", obj.base64Encode(lblpassword.Text.Trim()));
            //    com.Parameters.AddWithValue("@pan", txtPanNo.Text);
            //    com.Parameters.AddWithValue("@GST", txtGSTNo.Text.Trim());
            //    com.Parameters.AddWithValue("@cin", txtCinNo.Text);
            //    com.Parameters.AddWithValue("@createdBy", Session["FranchiseId"].ToString());
            //    com.Parameters.AddWithValue("@frantype", ddltype.SelectedValue.ToString());
            //    com.Parameters.AddWithValue("@SampleAllowed", rblsampleal.SelectedValue);
            //    com.Parameters.AddWithValue("@BankName", ddlbankname.SelectedItem.Text.Trim());
            //    com.Parameters.AddWithValue("@Branch", txtbranch.Text.Trim());
            //    com.Parameters.AddWithValue("@AccountNo", txtaccountno.Text.Trim());
            //    com.Parameters.AddWithValue("@AccountType", ddlactype.SelectedItem.Text.Trim());
            //    com.Parameters.AddWithValue("@IfscCode", txtifsc.Text.Trim());
            //    com.Parameters.AddWithValue("@flimit", txtflimit.Text.Trim());
            //    com.Parameters.AddWithValue("@fcom", txtfcom.Text.Trim());
            //    com.Parameters.Add("@FranchiseId", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            //    com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            //    con.Open();
            //    com.ExecuteNonQuery();
            //    if (com.Parameters["@flag"].Value.ToString() == "1")
            //    {
            //        utility.MessageBox(this, "Franchise created successfully ! Franchise Id is : " + com.Parameters["@FranchiseId"].Value.ToString());
            //        // string msg = "Dear, " + txtName.Text.Trim() + " Franchise Id: " + com.Parameters["@FranchiseId"].Value.ToString().ToUpper()+" Type: " + ddltype.SelectedItem.Text.ToString() + " and " + "Password: " + lblpassword.Text.Trim();
            //        // obj.sendSMSByPage(txtMobileNo.Text.Trim(), msg);
            //        string msg = "Dear, " + txtName.Text.Trim() + " Welcome to Toptime, Franchise Id: " + com.Parameters["@FranchiseId"].Value.ToString().ToUpper() + " Type: " + ddltype.SelectedItem.Text.ToString() + " and " + "Password: " + lblpassword.Text.Trim();
            //        obj.sendSMSCjstore(txtMobileNo.Text.Trim(), msg);
            //        ShowCreateFran();
            //        resetControls();
            //    }
            //    else
            //    {
            //        utility.MessageBox(this, com.Parameters["@flag"].Value.ToString());
            //    }
            //}
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }
        finally
        {
            con.Dispose();
            //com.Dispose();
        }
    }

    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    if (!string.IsNullOrEmpty(txtPanNo.Text.Trim()) && !obj.IsValidatePAN(txtPanNo.Text.Trim()))
    //    {
    //        utility.MessageBox(this, "Invalid PAN No.");
    //        return;
    //    }

    //    else if (!string.IsNullOrEmpty(txtPanNo.Text.Trim()))
    //    {
    //        string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
    //        string fileExtension = Path.GetExtension(fileName).ToLower();
    //        string filePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), Guid.NewGuid().ToString() + fileName);
    //        if (System.IO.File.Exists(filePath))
    //        {
    //            System.IO.File.Delete(filePath);

    //        }
    //        FileUpload1.PostedFile.SaveAs(filePath);
    //        string cropFilePath = "";
    //        if (!string.IsNullOrEmpty(filePath))
    //        {
    //            System.Drawing.Image orgImg = System.Drawing.Image.FromFile(filePath);
    //            Rectangle CropArea = new Rectangle(
    //                Convert.ToInt32(X.Value),
    //                Convert.ToInt32(Y.Value),
    //                Convert.ToInt32(W.Value),
    //                Convert.ToInt32(H.Value));
    //            try
    //            {


    //                int filesize = FileUpload1.PostedFile.ContentLength;
    //                if (filesize < 500000)
    //                {
    //                    Bitmap resizedImg = new Bitmap(CropArea.Width, CropArea.Height);
    //                    using (Graphics g = Graphics.FromImage(resizedImg))
    //                    {
    //                        g.DrawImage(orgImg, new Rectangle(0, 0, resizedImg.Width, resizedImg.Height), CropArea, GraphicsUnit.Pixel);
    //                        resizedImg.SetResolution(96, 96);
    //                    }
    //                    string panText = txtPanNo.Text.Trim();
    //                    string usrId = Session["userId"].ToString();
    //                    string imagename = insFunc.insertFranPanDetail(panText, usrId, fileName);
    //                    cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), imagename);
    //                    resizedImg.Save(cropFilePath);
    //                    imgUpload.ImageUrl = "~/images/KYC/PanImage/" + imagename;
    //                    txtPanNo.ReadOnly = true;
    //                    FileUpload1.Enabled = false;
    //                    btnreject.Style.Add("display", "block");
    //                    CheckStatus();
    //                }
    //                else
    //                {
    //                    Bitmap resizedImg = new Bitmap(300, 300);
    //                    double ratioX = (double)resizedImg.Width / (double)orgImg.Width;
    //                    double ratioY = (double)resizedImg.Height / (double)orgImg.Height;
    //                    double ratio = ratioX < ratioY ? ratioX : ratioY;
    //                    int newHeight = Convert.ToInt32(CropArea.Height * ratio * 1);
    //                    int newWidth = Convert.ToInt32(CropArea.Width * ratio * 1);
    //                    using (Graphics g = Graphics.FromImage(resizedImg))
    //                    {
    //                        g.DrawImage(orgImg, new Rectangle(0, 0, newWidth, newHeight), CropArea, GraphicsUnit.Pixel);
    //                        resizedImg.SetResolution(96, 96);
    //                    }
    //                    string panText = txtPanNo.Text.Trim();
    //                    string usrId = Session["userId"].ToString();
    //                    string imagename = insFunc.insertFranPanDetail(panText, usrId, fileName);
    //                    cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/PanImage/"), imagename);
    //                    resizedImg.Save(cropFilePath);
    //                    imgUpload.ImageUrl = "~/images/KYC/PanImage/" + imagename;
    //                    txtPanNo.ReadOnly = true;
    //                    FileUpload1.Enabled = false;
    //                    btnreject.Style.Add("display", "block");

    //                }


    //            }
    //            catch (Exception ex)
    //            {
    //                throw ex;
    //            }
    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "Please select a file or click on upload");
    //            return;
    //        }


    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Please Enter valid PAN Number.");
    //        return;
    //    }
    //}


    //protected void btnInsert_Click(object sender, EventArgs e)
    //{
    //    string fileName = Path.GetFileName(fileCancelCq.PostedFile.FileName);
    //    string fileExtension = Path.GetExtension(fileName).ToLower();
    //    string filePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), Guid.NewGuid().ToString() + fileName);
    //    if (System.IO.File.Exists(filePath))
    //    {
    //        System.IO.File.Delete(filePath);

    //    }
    //    fileCancelCq.PostedFile.SaveAs(filePath);
    //    string cropFilePath = "";
    //    if (!string.IsNullOrEmpty(filePath))
    //    {
    //        System.Drawing.Image orgImg = System.Drawing.Image.FromFile(filePath);
    //        Rectangle CropArea = new Rectangle(
    //            Convert.ToInt32(X1.Value),
    //            Convert.ToInt32(Y1.Value),
    //            Convert.ToInt32(W1.Value),
    //            Convert.ToInt32(H1.Value));

    //        try
    //        {

    //            int filesize = fileCancelCq.PostedFile.ContentLength;
    //            if (filesize < 500000)
    //            {
    //                Bitmap resizedImg = new Bitmap(CropArea.Width, CropArea.Height);
    //                using (Graphics g = Graphics.FromImage(resizedImg))
    //                {
    //                    g.DrawImage(orgImg, new Rectangle(0, 0, resizedImg.Width, resizedImg.Height), CropArea, GraphicsUnit.Pixel);
    //                    resizedImg.SetResolution(96, 96);
    //                }
    //                string ddlBkName = ddlbankname.SelectedItem.Text.Trim();
    //                string ddlActype = ddlactype.SelectedItem.Text.Trim();
    //                string txtAccno = "";
    //                txtAccno = txtaccountno.Text.Trim();
    //                if (!string.IsNullOrEmpty(txtAccno))
    //                {
    //                    int index = txtAccno.IndexOf("#");
    //                    if (index == 0)
    //                    {
    //                        txtAccno = txtaccountno.Text.Trim();
    //                    }
    //                    else
    //                    {
    //                        txtAccno = "#" + txtaccountno.Text.Trim();
    //                    }

    //                }
    //                string txtIfsc = txtifsc.Text.Trim();
    //                string usrId = Session["userId"].ToString();
    //                string txtBranch = txtbranch.Text.Trim();
    //                string imagename = insFunc.insertFranBankDetail(fileName, ddlBkName, ddlActype, txtAccno, txtIfsc, txtBranch, strid);
    //                cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), imagename);
    //                resizedImg.Save(cropFilePath);
    //                imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + imagename;
    //            }
    //            else
    //            {
    //                Bitmap resizedImg = new Bitmap(300, 300);
    //                double ratioX = (double)resizedImg.Width / (double)orgImg.Width;
    //                double ratioY = (double)resizedImg.Height / (double)orgImg.Height;
    //                double ratio = ratioX < ratioY ? ratioX : ratioY;
    //                int newHeight = Convert.ToInt32(CropArea.Height * ratio * 1);
    //                int newWidth = Convert.ToInt32(CropArea.Width * ratio * 1);
    //                using (Graphics g = Graphics.FromImage(resizedImg))
    //                {
    //                    g.DrawImage(orgImg, new Rectangle(0, 0, newWidth, newHeight), CropArea, GraphicsUnit.Pixel);
    //                    resizedImg.SetResolution(96, 96);
    //                }


    //                string ddlBkName = ddlbankname.SelectedItem.Text.Trim();
    //                string ddlActype = ddlactype.SelectedItem.Text.Trim();
    //                string txtAccno = "";
    //                txtAccno = txtaccountno.Text.Trim();
    //                if (!string.IsNullOrEmpty(txtAccno))
    //                {
    //                    int index = txtAccno.IndexOf("#");
    //                    if (index == 0)
    //                    {
    //                        txtAccno = txtaccountno.Text.Trim();
    //                    }
    //                    else
    //                    {
    //                        txtAccno = "#" + txtaccountno.Text.Trim();
    //                    }

    //                }
    //                string txtIfsc = txtifsc.Text.Trim();
    //                string usrId = Session["userId"].ToString();
    //                string txtBranch = txtbranch.Text.Trim();
    //                string imagename = insFunc.insertFranBankDetail(fileName, ddlBkName, ddlActype, txtAccno, txtIfsc, txtBranch, strid);
    //                cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), imagename);
    //                resizedImg.Save(cropFilePath);
    //                imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + imagename;


    //            }

    //        }
    //        catch (Exception ex)
    //        {
    //            throw ex;
    //        }


    //    }
    //}

    //deleteKYC
    #region KYCDelete
    [WebMethod]
    public static string btnRejectKYC_Click(string kycid)
    {
        SqlConnection con = new SqlConnection(method.str);
        if (kycid == "1")
        {
            try
            {
                con = new SqlConnection(method.str);
                string queryr = "select PanImage from frandocs inner join franchisemst on franchisemst.franchiseid=frandocs.franchiseid where franchisemst.franchiseid='" + HttpContext.Current.Session["FranchiseId"] + "'";
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
                            string imgPath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/PanImage/"), panimage);
                            System.IO.File.Delete(imgPath);
                        }
                    }

                }
                string upStatus = "Update frandocs set PStatus=null,PanImage=null from frandocs inner join franchisemst on frandocs.franchiseid=franchisemst.franchiseid where  franchisemst.franchiseid ='" + HttpContext.Current.Session["FranchiseId"] + "'";
                SqlCommand cmd = new SqlCommand(upStatus, con);
                con.Open();
                cmd.ExecuteNonQuery();
                string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Address proof uploaded</div>");
                return "Pan Deleted";
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
                string queryr = "select BankImage from frandocs inner join franchisemst on franchisemst.franchiseid=frandocs.franchiseid where franchisemst.franchiseid='" + HttpContext.Current.Session["FranchiseId"] + "'";
                SqlCommand cmd1 = new SqlCommand(queryr, con);
                con.Open();
                cmd1.ExecuteScalar();
                using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    while (reader.Read())
                    {
                        string bankImage = reader["BankImage"].ToString();
                        if (bankImage != "")
                        {
                            string imgPath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/BankImage/"), bankImage);
                            System.IO.File.Delete(imgPath);
                        }
                    }
                }
                string upStatus = "Update frandocs set bankstatus=null,BankImage=null from frandocs inner join franchisemst on frandocs.franchiseid=franchisemst.franchiseid where  franchisemst.franchiseid ='" + HttpContext.Current.Session["FranchiseId"] + "'";
                SqlCommand cmd = new SqlCommand(upStatus, con);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                return "Bank Deleted";
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
                string queryr = "select gstFileName from frandocs inner join franchisemst on franchisemst.franchiseid=frandocs.franchiseid where franchisemst.franchiseid='" + HttpContext.Current.Session["FranchiseId"] + "'";
                SqlCommand cmd1 = new SqlCommand(queryr, con);
                con.Open();
                cmd1.ExecuteScalar();
                using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    while (reader.Read())
                    {
                        string gstname = reader["gstFileName"].ToString();
                        if (gstname != "")
                        {
                            string imgPath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/GSTpdf/"), gstname);
                            System.IO.File.Delete(imgPath);
                        }
                    }
                }
                string upStatus = "Update frandocs set Gstatus=0,gstFileName=null from frandocs inner join franchisemst on frandocs.franchiseid=franchisemst.franchiseid where  franchisemst.franchiseid ='" + HttpContext.Current.Session["FranchiseId"] + "'";
                SqlCommand cmd = new SqlCommand(upStatus, con);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                return "file Deleted";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        return "there is an issue";
    }
    #endregion


    //public void CheckExist()
    //{
    //    string fileNamePdf = Path.GetFileName(FileUploadDoc.FileName);

    //    string uploadPdfPath = Server.MapPath(string.Format("~/images/GSTpdf/{0}", strid + fileNamePdf));
    //    con = new SqlConnection(method.str);
    //    com = new SqlCommand("gstDetails", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    dt = new DataTable();
    //    da = new SqlDataAdapter(com);
    //    da.Fill(dt);
    //    if (dt.Rows.Count > 0)
    //    {
    //        for (int i = 0; i < dt.Rows.Count; i++)
    //        {
    //            if (FileUploadDoc.FileName == dt.Rows[i]["gstFileName"].ToString())
    //            {
    //                utility.MessageBox(this, "file name already exists!");
    //                return;
    //            }
    //        }
    //    }

    //    if (!File.Exists(uploadPdfPath))
    //    {
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("InsertGstDocs", con);
    //        com.CommandType = CommandType.StoredProcedure;
    //        con.Open();
    //        com.Parameters.AddWithValue("@value", txtGSTNo.Text);
    //        com.Parameters.AddWithValue("@regno", strid);
    //        com.Parameters.AddWithValue("@action", "G");
    //        com.Parameters.AddWithValue("@file", fileNamePdf);
    //        com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
    //        com.Parameters.Add("@FileName", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
    //        com.ExecuteNonQuery();
    //        con.Close();
    //        string msg = com.Parameters["@flag"].Value.ToString();
    //        if (FileUploadDoc.HasFile)
    //        {
    //            if (FileUploadDoc.PostedFile.ContentLength < 30971520)
    //            {
    //                FileUploadDoc.SaveAs(uploadPdfPath);
    //            }
    //            else
    //            {
    //                lbl_Msg.Visible = true;
    //                //ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
    //                return;
    //            }
    //        }

    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "file name already exists!");
    //        return;
    //    }

    //}

    private void resetControls()
    {
        txtsponsorid.Text = txtName.Text = txtAddress.Text = txtCity.Text = txtPinCode.Text = txtMobileNo.Text = txtContactPerson.Text = txtEMailId.Text = txtCinNo.Text = txtPanNo.Text = txtGSTNo.Text = txtaccountno.Text = txtbranch.Text = txtifsc.Text = txtPassword.Text = txtConfirmPassword.Text = string.Empty;
        txtPassword.Text = "";
        txtConfirmPassword.Text = "";
        txtfcom.Text = "";
        txtflimit.Text = "";
        ddltype.SelectedIndex = 0;
        ddlState.SelectedIndex = 0;
        BindDistrict(ddlState.SelectedValue.ToString());
        rblsampleal.SelectedIndex = 0;
        ddlbankname.SelectedIndex = 0;
        ddlactype.SelectedItem.Text = "SAVING A/C";
        lblFranSpon.Text = "";

    }


    private string GetSponsorName(string regno)
    {
        string name = string.Empty;
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("select appmstfname from AppMst where AppMstRegNo=@regno", con);
            com.Parameters.AddWithValue("@regno", regno.Trim());
            con.Open();
            name = com.ExecuteScalar().ToString();
            con.Close();
        }
        catch
        {
        }
        return name;
    }

    #region (ICallbackEventHandlar Methods..)
    public string GetCallbackResult()
    {
        return strajax;
    }
    public void RaiseCallbackEvent(string eventArguments)
    {
        if (eventArguments != "")
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand();
            SqlDataReader dr;
            com.CommandText = "select appmsttitle+space(1)+appmstfname as name from appmst where appmstregno=@regno";
            com.Parameters.AddWithValue("@regno", eventArguments.Trim());
            com.Connection = con;
            con.Open();
            dr = com.ExecuteReader();

            if (dr.Read())
            {
                strajax = Convert.ToString(dr["name"]);
                //Session["sname"] = Convert.ToString(dr["name"]);
            }
            else
            {
                strajax = "User Does Not Exist!";

            }
            dr.Close();
            con.Close();
        }
        else
        {
            strajax = "Required field cannot be blank !";
        }
    }
    #endregion

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

    protected void txtsponsorid_TextChanged(object sender, EventArgs e)
    {
        string name = string.Empty;
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("select appmsttitle+space(1)+appmstfname as name from AppMst where AppMstRegNo=@regno", con);
            com.Parameters.AddWithValue("@regno", txtsponsorid.Text.Trim());
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                lblFranSpon.ForeColor = Color.Blue;
                lblFranSpon.Text = dt.Rows[0]["name"].ToString();
            }


            else
            {
                lblFranSpon.ForeColor = Color.Red;
                lblFranSpon.Text = "User Does Not Exist!";
                txtsponsorid.Focus();
            }

        }
        catch
        {

        }

    }

    private void ShowCreateFran()
    {
        CreateFran.Visible = true;
        CreateFran.Enabled = true;
        btnSubmit.Visible = true;
        PnlConfirmation.Visible = false;
    }
    private void HideCreateFran()
    {
        CreateFran.Enabled = false;
        CreateFran.Visible = false;
        PnlConfirmation.Visible = true;
        btnSubmit.Visible = false;


    }
    private void BindPanelData()
    {
        try
        {

            lblFranType.Text = ddltype.SelectedItem.Text;
            lblFranSponId.Text = txtsponsorid.Text.Trim();
            lblFranSponName.Text = lblFranSpon.Text;
            lblFranName.Text = txtName.Text.Trim();
            lblMobileNo.Text = txtMobileNo.Text.Trim();
            lblEmail.Text = txtEMailId.Text.Trim();
            lblpassword.Text = txtConfirmPassword.Text.Trim();
            lblUserID.Text = lblFID.Text.Trim();

        }
        catch
        {

        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        ShowCreateFran();
    }
    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        create();
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
                ddlState.DataValueField = "Id";
                ddlState.DataBind();
                ddlState.Items.Insert(0, new ListItem("--Select--", "0"));
                ddlDistrict.Items.Insert(0, new ListItem("--Select--", "0"));
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
                ddlDistrict.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, new ListItem("--Select--", "0"));
            }
        }
        catch
        {
        }
    }
    //Developed By Raghwendra 06/07/2019
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
            ddlbankname.DataSource = dt;
            ddlbankname.DataTextField = "BankName";
            ddlbankname.DataValueField = "SrNo";
            ddlbankname.DataBind();
            ddlbankname.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch
        {

        }
    }

    //protected void btnGst_Click(object sender, EventArgs e)
    //{
    //    if (txtGSTNo.Text.Trim() != "")
    //    {
    //        if (FileUploadDoc.HasFile)
    //        {
    //            CheckExist();
    //            CheckStatus();
    //        }
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Please Enter valid gst no!!");
    //    }
    //}

    private string GetUserId()
    {
        string name = string.Empty;
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("SELECT  max(FranchiseId)+1 as FranchiseId FROM  FranchiseMst", con);
            con.Open();
            name = com.ExecuteScalar().ToString();
            con.Close();
        }
        catch
        {
        }
        return name;
    }

    private void Bind_FranchiseType()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4 and UserVal not in (1, 7, 8, 9, 10)");
        if (dt.Rows.Count > 0)
        {
            ddltype.DataSource = dt;
            ddltype.DataTextField = "Item_Desc";
            ddltype.DataValueField = "Frantype";
            ddltype.DataBind();
            ddltype.Items.Insert(0, new ListItem("Select", "0"));
        }
        else
        {
            ddltype.Items.Clear();
            ddltype.Items.Insert(0, new ListItem("Select", "0"));
        }
    }

    private void Bind_FranchiseTypeEdit()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4");
        if (dt.Rows.Count > 0)
        {
            ddltype.DataSource = dt;
            ddltype.DataTextField = "Item_Desc";
            ddltype.DataValueField = "Frantype";
            ddltype.DataBind();
            ddltype.Items.Insert(0, new ListItem("Select", "0"));
        }
        else
        {
            ddltype.Items.Clear();
            ddltype.Items.Insert(0, new ListItem("Select", "0"));
        }
    }


    [WebMethod]
    public static UserDetails GetUser(string fMappingId, string FranType)
    {
        UserDetails objUser = new UserDetails();
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("CheckFranMapping", con);
            SqlDataReader dr;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@fMappingId", fMappingId);
            cmd.Parameters.AddWithValue("@FranType", FranType);
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                if (Convert.ToInt32(FranType) < Convert.ToInt32(dr["FranType"].ToString()))
                {
                    objUser.Error = "Cannot map to lower Franchise";
                }
                else
                {
                    objUser.Error = "";
                    objUser.UserName = dr["FName"].ToString();
                }
            }
            else
            {
                objUser.Error = "User Does Not Exists!";
            }
            dr.Close();
            con.Close();
        }
        catch (Exception er) { objUser.Error = "Server error. Time out.!!"; }
        return objUser;
    }

    public class UserDetails
    {
        public String Error { get; set; }
        public String UserName { get; set; }

    }

    [WebMethod]
    public static string generateOTP()
    {
        if (HttpContext.Current.Session["FranchiseId"] == null)
        {
            return "Session expire.";
        }

        string result = "0";
        DataTable dt = new DataTable();
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        da = new SqlDataAdapter("GenerateOTP", con);
        da.SelectCommand.Parameters.AddWithValue("@RegNo", HttpContext.Current.Session["FranchiseId"].ToString());
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            utility objUtil = new utility();
            //String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 30 min ";
            String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 15 min from:toptimenet.com Jai Toptime";

            objUtil.sendSMSByBilling(dt.Rows[0]["AppMstMobile"].ToString().Trim(), msg, "OTP");
        }
        return result;
    }


    [WebMethod]
    public static string verifyOTP(string telno, string txtotp)
    {
        string chktelno = telno;
        string Result = "";

        if (HttpContext.Current.Session["FranchiseId"] == null)
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
        com.Parameters.AddWithValue("@RegNo", HttpContext.Current.Session["FranchiseId"].ToString());
        com.Parameters.AddWithValue("@OTP", txtotp.Trim());
        com.Parameters.Add("@IsValid", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();

        Result = com.Parameters["@IsValid"].Value.ToString();
        if (Result == "0")
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FranchiseID", HttpContext.Current.Session["FranchiseId"].ToString())
            };
            DataUtility objDu = new DataUtility();
            objDu.ExecuteSql(param, "update FranchiseMst set OTP_Verify=1 where FranchiseID=@FranchiseID");
        }
        return Result;
    }



    protected void btn_gst_decl_Accept_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@FranchiseID", HttpContext.Current.Session["FranchiseId"].ToString())
                };
            DataUtility objDu = new DataUtility();
            objDu.ExecuteSql(param, "update FranchiseMst set GST_DeclDate=Getdate() where FranchiseID=@FranchiseID");

            editFranchise(strid);
        }
        catch (Exception er) { }
    }



    //protected void Button6_click(object sender, EventArgs e)
    //{
    //    string AadharNo = txtAadharNo.Text.Trim();
    //    if (string.IsNullOrEmpty(txtAadharNo.Text.Trim()))
    //    {
    //        utility.MessageBox(this, "Please enter Valid Address ID!");
    //        txtAadharNo.Focus();
    //        return;
    //    }
    //    else
    //    {
    //        string fileName1 = Path.GetFileName(FU_AadharFront.PostedFile.FileName);
    //        string fileName2 = Path.GetFileName(FU_AadharBack.PostedFile.FileName);
    //        string filePath1 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Front/"), Guid.NewGuid().ToString() + fileName1);
    //        string filePath2 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Back/"), Guid.NewGuid().ToString() + fileName2);
    //        FU_AadharFront.PostedFile.SaveAs(filePath1);
    //        FU_AadharBack.PostedFile.SaveAs(filePath2);
    //        string cropFilePath1 = "";
    //        string cropFilePath2 = "";
    //        if (!string.IsNullOrEmpty(fileName1) && !string.IsNullOrEmpty(fileName2))
    //        {
    //            System.Drawing.Image orgImg = System.Drawing.Image.FromFile(filePath1);
    //            Rectangle CropArea = new Rectangle(
    //                Convert.ToInt32(AF1.Value),
    //                Convert.ToInt32(AF2.Value),
    //                Convert.ToInt32(AF3.Value),
    //                Convert.ToInt32(AF4.Value));
    //            System.Drawing.Image orgImg1 = System.Drawing.Image.FromFile(filePath2);
    //            Rectangle CropArea1 = new Rectangle(
    //                Convert.ToInt32(AB1.Value),
    //                Convert.ToInt32(AB2.Value),
    //                Convert.ToInt32(AB3.Value),
    //                Convert.ToInt32(AB4.Value)); 
    //            try
    //            {


    //                int filesize = FU_AadharFront.PostedFile.ContentLength;
    //                int filesize1 = FU_AadharBack.PostedFile.ContentLength;
    //                if (filesize < 500000 && filesize1 < 500000)
    //                {
    //                    Bitmap resizedImg = new Bitmap(CropArea.Width, CropArea.Height);
    //                    using (Graphics g = Graphics.FromImage(resizedImg))
    //                    {
    //                        g.DrawImage(orgImg, new Rectangle(0, 0, resizedImg.Width, resizedImg.Height), CropArea, GraphicsUnit.Pixel);
    //                    }
    //                    Bitmap resizedImg1 = new Bitmap(CropArea1.Width, CropArea1.Height);
    //                    using (Graphics g = Graphics.FromImage(resizedImg1))
    //                    {
    //                        g.DrawImage(orgImg1, new Rectangle(0, 0, resizedImg1.Width, resizedImg1.Height), CropArea1, GraphicsUnit.Pixel);
    //                    }
    //                    string usrId = Session["userId"].ToString();
    //                    string adaharText = txtAadharNo.Text.Trim();
    //                    string imgFront, imgback, msg;
    //                    insFunc.insertAddressProof(fileName1, fileName2, usrId, adaharText, out imgFront, out imgback, out msg);
    //                    if (msg == "1")
    //                    {
    //                        cropFilePath1 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Front/"), imgFront);
    //                        resizedImg.Save(cropFilePath1);
    //                        imgUploadAadharFront.ImageUrl = "~/images/KYC/AadharImage/Front/" + imgFront;
    //                        cropFilePath2 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Back/"), imgback);
    //                        resizedImg1.Save(cropFilePath2);
    //                        imgUploadAadharBack.ImageUrl = "~/images/KYC/AadharImage/Back/" + imgback;
    //                        string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Address proof uploaded</div>");
    //                        CheckStatus();
    //                    }
    //                }
    //                else
    //                {
    //                    Bitmap resizedImg = new Bitmap(200, 200);
    //                    double ratioX = (float)resizedImg.Width / (float)orgImg.Width;
    //                    double ratioY = (float)resizedImg.Height / (float)orgImg.Height;
    //                    double ratio = ratioX < ratioY ? ratioX : ratioY;
    //                    int newHeight = Convert.ToInt32(CropArea.Height * ratio * 1);
    //                    int newWidth = Convert.ToInt32(CropArea.Width * ratio * 1);
    //                    using (Graphics g = Graphics.FromImage(resizedImg))
    //                    {
    //                        g.SmoothingMode = SmoothingMode.AntiAlias;
    //                        g.InterpolationMode = InterpolationMode.HighQualityBicubic;
    //                        g.PixelOffsetMode = PixelOffsetMode.HighQuality;
    //                        g.DrawImage(orgImg, new Rectangle(0, 0, newWidth, newHeight), CropArea, GraphicsUnit.Pixel);
    //                        resizedImg.SetResolution(96, 96);
    //                    }

    //                    Bitmap resizedImg1 = new Bitmap(200, 200);
    //                    double ratioX1 = (float)resizedImg1.Width / (float)orgImg.Width;
    //                    double ratioY1 = (float)resizedImg1.Height / (float)orgImg.Height;
    //                    double ratio1 = ratioX1 < ratioY1 ? ratioX1 : ratioY1;
    //                    int newHeight1 = Convert.ToInt32(CropArea.Height * ratio1 * 1);
    //                    int newWidth1 = Convert.ToInt32(CropArea.Width * ratio1 * 1);
    //                    using (Graphics g = Graphics.FromImage(resizedImg1))
    //                    {
    //                        g.SmoothingMode = SmoothingMode.AntiAlias;
    //                        g.InterpolationMode = InterpolationMode.HighQualityBicubic;
    //                        g.PixelOffsetMode = PixelOffsetMode.HighQuality;
    //                        g.DrawImage(orgImg1, new Rectangle(0, 0, newWidth1, newHeight1), CropArea1, GraphicsUnit.Pixel);
    //                        resizedImg1.SetResolution(96, 96);
    //                    }
    //                    string usrId = Session["userId"].ToString();
    //                    string adaharText = txtAadharNo.Text.Trim();
    //                    string imgFront, imgback, msg;
    //                    insFunc.insertAddressProof(fileName1, fileName2, usrId, adaharText, out imgFront, out imgback, out msg);
    //                    if (msg == "1")
    //                    {
    //                        cropFilePath1 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Front/"), imgFront);
    //                        resizedImg.Save(cropFilePath1);
    //                        imgUploadAadharFront.ImageUrl = "~/images/KYC/AadharImage/Front/" + imgFront;
    //                        cropFilePath2 = Path.Combine(Server.MapPath("~/images/KYC/AadharImage/Back/"), imgback);
    //                        resizedImg1.Save(cropFilePath2);
    //                        imgUploadAadharBack.ImageUrl = "~/images/KYC/AadharImage/Back/" + imgback;
    //                        string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong> Address proof uploaded</div>");
    //                        CheckStatus();
    //                    }
    //                }

    //            }
    //            catch (Exception ex)
    //            {
    //                throw ex;
    //            }
    //            finally
    //            {
    //                con.Close();
    //                con.Dispose();

    //            }
    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "Please insert both front And back Address image.");
    //            imgUploadAadharFront.Focus();
    //        }

    //    }
    //}




    [System.Web.Services.WebMethod]
    public static string UpdateReject(string flag)
    {
        string objResult = "", FranchiseID = "";

        if (HttpContext.Current.Session["FranchiseId"] == null)
        {
            objResult = "SessionOut";
        }
        else
        {
            FranchiseID = HttpContext.Current.Session["FranchiseId"].ToString();
        }
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] prm = new SqlParameter[] { new SqlParameter("@FID", FranchiseID) };

            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@FranchiseID", FranchiseID) };

            if (flag == "PAN")
            {
                string OldImgName = objDu.GetScaler(prm, "Select Pan_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set Pan_img=null, Pan_VFYD=2 where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }

            if (flag == "BANK")
            {
                string OldImgName = objDu.GetScaler(prm, "Select Bank_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set Bank_img=null, Bank_VFYD=2 where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }

            if (flag == "GST")
            {
                string OldImgName = objDu.GetScaler(prm, "Select GST_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set GST_img=null, GST_VFYD=2 where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }

            if (flag == "AADHAR")
            {
                string Aadhar_F_img = objDu.GetScaler(prm, "Select Aadhar_F_img from FranchiseMst where FranchiseID=@FID").ToString();
                string Aadhar_B_img = objDu.GetScaler(prm, "Select Aadhar_B_img from FranchiseMst where FranchiseID=@FID").ToString();


                objDu.ExecuteSql(param, "update FranchiseMst set Aadhar_F_img=null, Aadhar_B_img=null, AADHAR_VFYD=2 where FranchiseID=@FranchiseID");

                string filePath1 = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/"), Aadhar_F_img);
                if (System.IO.File.Exists(filePath1))
                {
                    System.IO.File.Delete(filePath1);
                }

                string filePath2 = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/"), Aadhar_B_img);
                if (System.IO.File.Exists(filePath2))
                {
                    System.IO.File.Delete(filePath2);
                }

            }

            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }



    [System.Web.Services.WebMethod]
    public static string UpdateImage(string flag, string ImgName)
    {
        string Result = "1", FranchiseID = "";

        if (HttpContext.Current.Session["FranchiseId"] == null)
        {
            return "SessionOut";
        }
        else
        {
            FranchiseID = HttpContext.Current.Session["FranchiseId"].ToString();
        }


        try
        {
            DataUtility objDu = new DataUtility();

            SqlParameter[] prm = new SqlParameter[] { new SqlParameter("@FID", FranchiseID) };

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FranchiseID", FranchiseID),
                new SqlParameter("@ImgName", ImgName)
            };

            if (flag == "PAN")
            {
                string OldImgName = objDu.GetScaler(prm, "Select Pan_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set Pan_img=@ImgName, PanDateLoad=Getdate() where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }


            if (flag == "BANK")
            {
                string OldImgName = objDu.GetScaler(prm, "Select Bank_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set Bank_img=@ImgName, BankDateLoad=Getdate() where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }


            if (flag == "GST")
            {
                string OldImgName = objDu.GetScaler(prm, "Select GST_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set GST_img=@ImgName, GSTDateApproved=Getdate() where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }


            if (flag == "AADHARFRONT")
            {
                string OldImgName = objDu.GetScaler(prm, "Select Aadhar_F_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set Aadhar_F_img=@ImgName, AadharDateApproved=Getdate() where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }


            if (flag == "AADHARBACK")
            {
                string OldImgName = objDu.GetScaler(prm, "Select Aadhar_B_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set Aadhar_B_img=@ImgName, AadharDateApproved=Getdate() where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }

        }
        catch (Exception er)
        {
            Result = er.Message;
        }
        return Result;
    }





}








/////////////////////////////////////////////////////
//    int chk = 0;
//    SqlConnection con = null;
//    SqlCommand com = null;
//    SqlDataReader sdr;
//    utility objUtil = null;
//    string strid, strname, stradmin;

//    protected void Page_Load(object sender, EventArgs e)
//    {
//        objUtil = new utility();
//        stradmin = Convert.ToString(Session["UserName"]);
//        strid = Convert.ToString(Session["FranchiseId"]);
//        //strid = objUtil.base64Decode(Request.QueryString["n"].ToString());
//        //strname = Convert.ToString(Request.QueryString["n1"]);
//        if (Session["UserName"] == null)
//        {
//            Response.Redirect("Default.aspx");
//        }


//        if (!IsPostBack)
//        {

//            if (strid != null)
//            {
//                go(strid);
//            }
//            else if (strname != null)
//            {
//                go(strname);
//            }
//            else
//            {
//                Response.Redirect("expire.aspx");
//            }
//            finddata();
//        }
//    }

//    private void finddata()
//    {
//        try
//        {
//            objUtil = new utility();
//            con = new SqlConnection(method.str);
//            com = new SqlCommand("CheckUserId2 ", con);
//            com.CommandType = CommandType.StoredProcedure;
//            com.Parameters.AddWithValue("@idno ", strid);
//            SqlDataAdapter da = new SqlDataAdapter(com);
//            DataTable dt = new DataTable();
//            da.Fill(dt);

//            DataColumn epno = new DataColumn("epno", typeof(string));
//            DataColumn eid = new DataColumn("eid", typeof(string));
//            dt.Columns.Add(epno);
//            dt.Columns.Add(eid);

//            foreach (DataRow drow in dt.Rows)
//            {
//                drow["eid"] = objUtil.base64Encode(drow["appmstid"].ToString());
//                drow["epno"] = objUtil.base64Encode(drow["payoutno"].ToString());
//            }

//            GridView1.DataSource = dt;
//            GridView1.DataBind();

//            if (dt.Rows.Count > 0)
//            {

//                lblTotalTotalEarned.Text = dt.Compute("sum(totalearning)", "true").ToString();
//                lblTotalTdsAmount.Text = dt.Compute("sum(tds)", "true").ToString();
//                lblTotalhandlibgCharges.Text = dt.Compute("sum(handlingcharges)", "true").ToString();
//                lblTotalDispatchedAmount.Text = dt.Compute("sum(dispachedamt)", "true").ToString();
//            }
//            else
//            {
//                lblTotalTotalEarned.Text = "0";
//                lblTotalTdsAmount.Text = "0";
//                lblTotalhandlibgCharges.Text = "0";
//                lblTotalDispatchedAmount.Text = "0";
//                EarningDetails.Visible = false;
//            }
//        }
//        catch
//        {
//        }
//    }

//    public void go(string str)
//    {
//        try
//        {
//            //getModifications(str);
//            con = new SqlConnection(method.str);
//            com = new SqlCommand("select  convert(varchar(10),userdob,103) As dobDate,convert(varchar(10),appmstdoj,103) As doj,appmstactivate,IFSCode,type,AppMstTitle," +
//            "SponsorID,nom_name,nom_rela,panno,AcountNo,BankName,Branch,AppMstLeftTotal,AppMstRightTotal," +
//            "email,AppMstregno,AppMstFName,GName,AppMstAddress1,AppMstCity,AppMstState,Gtitle,distt,AppMstPinCode,AppMstPrimaryPhone,AppMstMobile,AppMstPassword,proofType from AppMst where (case when AppMstregno=@regno then 1 when appmstlogin=@regno then 1 else 0 end)=1", con);
//            com.Parameters.AddWithValue("@regno", str);
//            con.Open();
//            sdr = com.ExecuteReader();
//            if (sdr.Read())
//            {
//                rbtnlstActivate.SelectedIndex = rbtnlstActivate.Items.IndexOf(rbtnlstActivate.Items.FindByValue(sdr["appmstactivate"].ToString()));
//                lblIndicator.BackColor = sdr["appmstactivate"].ToString() == "1" ? System.Drawing.Color.Green : System.Drawing.Color.Red;
//                DropDownList1.SelectedIndex = DropDownList1.Items.IndexOf(DropDownList1.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["AppMstTitle"].ToString(), true) == 0).FirstOrDefault());

//                txtSPID.Text = sdr["SponsorID"].ToString().ToUpper();
//                txtnominame.Text = sdr["nom_name"].ToString().ToUpper();
//                txtnomineerelation.Text = sdr["nom_rela"].ToString().ToUpper();
//                txtPanNo.Text = sdr["panno"].ToString().ToUpper() == "0" ? string.Empty : sdr["panno"].ToString().ToUpper();                
//                TxtIFSCODE.Text = sdr["IFSCode"].ToString().ToUpper();
//                txtaccountno.Text = sdr["AcountNo"].ToString().ToUpper();
//                ddlAccType.SelectedIndex = ddlAccType.Items.IndexOf(ddlAccType.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["type"].ToString(), true) == 0).FirstOrDefault());
//                ddlBankName.SelectedIndex = ddlBankName.Items.IndexOf(ddlBankName.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["BankName"].ToString(), true) == 0).FirstOrDefault());
//                txtbranch.Text = sdr["Branch"].ToString().ToUpper();
//                lbltleft.Text = sdr["AppMstLeftTotal"].ToString();
//                lbltright.Text = sdr["AppMstRightTotal"].ToString();
//                txtemail.Text = sdr["email"].ToString().ToUpper();
//                lblid.Text = sdr["AppMstregno"].ToString().ToUpper();
//                txtfname.Text = sdr["AppMstFName"].ToString().ToUpper();
//                txtGName.Text = sdr["GName"].ToString().ToUpper();
//                txtaddress1.Text = sdr["AppMstAddress1"].ToString().ToUpper();
//                txtcity.Text = sdr["AppMstCity"].ToString().ToUpper();
//                DdlState.SelectedIndex = DdlState.Items.IndexOf(DdlState.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["AppMstState"].ToString(), true) == 0).FirstOrDefault());
//                ddlProof.SelectedIndex = ddlProof.Items.IndexOf(ddlProof.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["proofType"].ToString(), true) == 0).FirstOrDefault());
//                ddlGtitle.SelectedIndex = ddlGtitle.Items.IndexOf(ddlGtitle.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["Gtitle"].ToString(), true) == 0).FirstOrDefault());
//                txtdistrict.Text = sdr["distt"].ToString().ToUpper();
//                txtpocode.Text = sdr["AppMstPinCode"].ToString().ToUpper();
//                txtphone.Text = sdr["AppMstPrimaryPhone"].ToString().ToUpper();
//                txtMobNo.Text = sdr["AppMstMobile"].ToString().ToUpper();
//                txtDOB.Text = sdr["dobDate"].ToString();
//                txtpassword.Text = sdr["AppMstPassword"].ToString().ToUpper();               
//                con.Close();
//            }
//        }
//        catch
//        {
//        }
//    }

//    protected void modifydata()
//    {
//        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
//        dateInfo.ShortDatePattern = "dd/MM/yyyy";
//        DateTime dob2;
//        try
//        {
//            dob2 = Convert.ToDateTime(txtDOB.Text.Trim(), dateInfo);
//        }
//        catch
//        {
//           utility.MessageBox(this,"-Sorry :- INVALID DATE OF Registration !");
//            return;
//        }

//        string sBankup = string.Compare(ddlBankName.SelectedItem.Text, "--SELECT BANK--", true) != 0 ? ddlBankName.SelectedItem.Text : "";
//        con = new SqlConnection(method.str);
//        com = new SqlCommand("insertmodifyprofile", con);
//        com.CommandType = CommandType.StoredProcedure;       
//        com.Parameters.AddWithValue("@modifiedby ", stradmin);
//        com .Parameters.AddWithValue("@appmstregno", lblid.Text);
//        com.Parameters.AddWithValue("@title1", DropDownList1.SelectedItem.Text);

//        com.Parameters.AddWithValue("@fname1", txtfname.Text);

//        com.Parameters.AddWithValue("@panno1", txtPanNo.Text.Trim());

//        com.Parameters.AddWithValue("@AccountNo1 ", txtaccountno.Text);

//        com.Parameters.AddWithValue("@type1 ", ddlAccType.SelectedItem.Text);

//        com.Parameters.AddWithValue("@bankname1", sBankup);

//        com.Parameters.AddWithValue("@Branch1", txtbranch.Text);

//        com.Parameters.AddWithValue("@ifs1", TxtIFSCODE.Text);       

//        com.Parameters.AddWithValue("@Address1", txtaddress1.Text);

//        com.Parameters.AddWithValue("@City1", txtcity.Text);

//        com.Parameters.AddWithValue("@State1", DdlState.SelectedItem.Text);

//        com.Parameters.AddWithValue("@distt1", txtdistrict.Text);

//        com.Parameters.AddWithValue("@PinCode1", txtpocode.Text.Trim());

//        com.Parameters.AddWithValue("@PrimaryPhone1", txtphone.Text.Trim());

//        com.Parameters.AddWithValue("@Mobile1", txtMobNo.Text.Trim());

//        com.Parameters.AddWithValue("@nomname1", txtnominame.Text.Trim());

//        com.Parameters.AddWithValue("@nomrela1", txtnomineerelation.Text);

//        com.Parameters.AddWithValue("@userdob1", dob2);

//        com.Parameters.AddWithValue("@password1", txtpassword.Text);      

//        com.Parameters.AddWithValue("@activate1", rbtnlstActivate.SelectedValue.ToString());
//        com.Parameters.AddWithValue("@reason", TxtReason.Text.Trim());

//        com.Parameters.AddWithValue("@GName1", txtGName.Text.Trim());

//        com.Parameters.AddWithValue("@Mname1", "");
//        com.Parameters.AddWithValue("@Gender", 0);
//        com.Parameters.AddWithValue("@Marital", 0);
//        com.Parameters.AddWithValue("@Occupation", "");

//        com.Parameters.AddWithValue("@GTitle1", ddlGtitle.SelectedItem.Text);

//        com.Parameters.AddWithValue("@email1", txtemail.Text.Trim());
//        com.Parameters.AddWithValue("@flag", SqlDbType.VarChar).Direction = ParameterDirection.Output;
//        con.Open();
//        com.ExecuteNonQuery();
//        con.Close();
//        string result = com.Parameters["@flag"].Value.ToString();
//        if (result == "1")
//        {
//            utility.MessageBox(this, "Profile edited successfully!");
//        }
//        else
//        {
//            utility.MessageBox(this, result);
//        }
//        if (strid != null)
//        {
//            go(strid);
//        }
//        else if (strname != null)
//        {
//            go(strname);
//        }
//        else
//        {
//            Response.Redirect("expire.aspx");
//        }
//    }

//    protected void btnSave_Click(object sender, EventArgs e)
//    {            
//        modifydata();        
//    }

//    protected void btnCancel_Click(object sender, EventArgs e)
//    {
//        Response.Redirect("adchangeprofile.aspx");
//    }

//    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
//    {
//        if (string.Compare(e.CommandName,"Page",true)!=0)
//        {
//            objUtil = new utility();
//            GridViewRow row = (GridViewRow)GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
//            string id = GridView1.DataKeys[Convert.ToInt32(e.CommandArgument)].Values[0].ToString();
//            string pno = GridView1.DataKeys[Convert.ToInt32(e.CommandArgument)].Values[1].ToString();
//            if (string.Compare(e.CommandName,"EarnedAmount",true)==0)
//            {
//                Response.Redirect("TotalEranedAmount.aspx?id=" + objUtil.base64Encode(id));
//            }
//            else if (string.Compare(e.CommandName,"AccountStatement",true)==0)
//            {
//                Response.Redirect("adminpaymentreport.aspx?id=" + objUtil.base64Encode(id) + "&n=" + objUtil.base64Encode(pno));
//            }
//        }
//    }
//}
