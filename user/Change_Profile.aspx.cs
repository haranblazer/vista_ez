using System; 
using System.Data.SqlClient;
using System.Data; 
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Collections;
using System.IO;
using System.Drawing;
using System.Security.Cryptography;

public partial class user_Change_Profile : System.Web.UI.Page
{
    //SqlDataReader sdr;
    //string str1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //str1 = Convert.ToString(Session["userId"]);
           // go();
            BindState();
            BindBank();
        }

    }


    //private void go()
    //{
    //    try
    //    {
    //        SqlConnection con = new SqlConnection(method.str);
    //        SqlCommand com = new SqlCommand("CheckSponsor1", con);
    //        com.CommandType = CommandType.StoredProcedure;
    //        com.Parameters.AddWithValue("@sid", str1);
    //        con.Open();
    //        sdr = com.ExecuteReader();
    //        if (sdr.Read())
    //        {

    //            if (sdr["Verified"].ToString() == "1")
    //            {
    //               // txtotp.Visible = false;
    //                ddlGtitle.Enabled = false;
    //                //branch.Enabled = false;
    //                txtAadharNo.Enabled = false;
    //                // ddlBankName.Enabled = false;
    //                // ddlAccountType.Enabled = false;
    //                //acno.Enabled = false;
    //                title.Enabled = false;
    //                txtFirstName.Enabled = false;
    //                txtGName.Enabled = false;
    //                txtpincode.Enabled = false;
    //                ddlState.Enabled = false;
    //                ddlDistrict.Enabled = false;
    //                //txtOccupation.Enabled = false;
    //                //flup.Enabled = false;
    //               // rbtnGender.Enabled = false;
    //               // RdoMarital.Enabled = false;
    //                txtAddress.Enabled = false;
    //                txtMobile.Enabled = false;
    //                txtEmail.Enabled = false;
    //                txtnomniName.Enabled = false;
    //                txtrelation.Enabled = false;
    //                txtCity.Enabled = false;
    //                txtDOB.Enabled = false;
    //                //txtIFSCode.Enabled = false;
    //                // panno.Enabled = false;
    //                //btnSubmit.Enabled = false;
    //                //txtpassword.Enabled = false;
    //                //txtepassword.Enabled = false;
    //                txtAadharNo.Enabled = false;
    //                approveRejectImg2.Src = "~/images/ApproveGreen.png";
    //                ddlBankName.Enabled = false;
    //                ddlAcType.Enabled = false;
    //                txtAccNo.Enabled = false;
    //                txtbranch.Enabled = false;
    //                txtifs.Enabled = false;
    //                fileCancelCq.Enabled = false;
    //                ddlAcType.Enabled = false;
    //                //btnreject1.Visible = false;
    //                approveRejectImg1.Src = "~/images/ApproveGreen.png";
    //                txtPANDetails.ReadOnly = true;
    //                FU1.Enabled = false;
    //                //btnSubmit.Visible = false;
    //                //btnreject.Visible = false;
    //                approveRejectimg.Src = "~/images/ApproveGreen.png";
    //                FU2.Enabled = false;
    //                FU3.Enabled = false;
    //            }



    //            if (sdr["isProUp"].ToString() == "1")
    //            {
    //                // btn.Text = "Generate OTP";
    //                // btn.Visible = true;
    //                //btnSubmit.Visible = false;
    //                //txtotp.Visible = false;
    //                ddlGtitle.Enabled = false;
    //                //branch.Enabled = true;
    //                //txtAadharNo.Enabled = true;
    //                //ddlBankName.Enabled = true;
    //                //ddlAccountType.Enabled = true;
    //                //acno.Enabled = true;
    //                title.Enabled = false;
    //                txtFirstName.Enabled = false;
    //                txtGName.Enabled = false;
    //                txtpincode.Enabled = false;
    //                ddlState.Enabled = false;
    //                ddlDistrict.Enabled = false;
    //               // txtOccupation.Enabled = false;
    //                //flup.Enabled = true;
    //                //rbtnGender.Enabled = false;
    //                //RdoMarital.Enabled = false;
    //                txtAddress.Enabled = false;
    //                txtMobile.Enabled = false;
    //                txtEmail.Enabled = false;
    //                txtnomniName.Enabled = false;
    //                txtrelation.Enabled = false;
    //                txtCity.Enabled = false;
    //                txtDOB.Enabled = false;
    //                RdoGenderNew.Enabled = false;
    //                //txtIFSCode.Enabled = true;
    //                //panno.Enabled = true;ddlGtitle
    //                //btnSubmit.Enabled = false;
    //                //ottp.Visible = false;
    //            }
    //            title.SelectedValue = sdr["AppMstTitle"].ToString();
    //            //title.SelectedIndex = title.Items.IndexOf(title.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["AppMstTitle"].ToString(), true) == 0).FirstOrDefault());
    //            // ddlGtitle.SelectedIndex = ddlGtitle.Items.IndexOf(ddlGtitle.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["gtitle"].ToString(), true) == 0).FirstOrDefault());
    //            //ddlMtitle.SelectedIndex = ddlMtitle.Items.IndexOf(ddlMtitle.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["gtitle"].ToString(), true) == 0).FirstOrDefault());
    //            //ddlAccountType.SelectedIndex = ddlAccountType.Items.IndexOf(ddlAccountType.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["type"].ToString(), true) == 0).FirstOrDefault());
    //            //ddlProof.SelectedIndex = ddlProof.Items.IndexOf(ddlProof.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["proofType"].ToString(), true) == 0).FirstOrDefault());
    //            //ddlProof.Enabled = false;
    //            ddlGtitle.SelectedValue = sdr["gtitle"].ToString();
    //            try
    //            {
    //                txtDOB.Text = sdr["userdob"].ToString();
    //            }
    //            catch (Exception ex)
    //            {
    //            }
    //            lblid.Text = Session["userId"].ToString();
    //            lbl_username.Text = sdr["AppMstFName"].ToString();
    //            //txtpassword.Text = sdr["appmstpassword"].ToString();
    //            //txtIFSCode.Text = sdr["IFSCode"].ToString();
    //            txtFirstName.Text = sdr["AppMstFName"].ToString();
    //            ddlState.SelectedValue = sdr["Id"].ToString();
    //            ddlDistrict.SelectedValue = sdr["statename"].ToString();
    //            txtGName.Text = sdr["GName"].ToString();
    //            //txtMName.Text = sdr["MName"].ToString();
    //            //txtOccupation.Text = sdr["Occupation"].ToString();
    //            //rbtnGender.SelectedIndex = rbtnGender.Items.IndexOf(rbtnGender.Items.FindByValue(sdr["Gender"].ToString()));
    //            //RdoMarital.SelectedIndex = RdoMarital.Items.IndexOf(RdoMarital.Items.FindByValue(sdr["MStatus"].ToString()));
    //            RdoGenderNew.SelectedValue = sdr["Gender"].ToString();
    //            txtAddress.Text = sdr["AppMstAddress1"].ToString();
    //            txtMobile.Text = sdr["AppMstMobile"].ToString();
    //            txtpincode.Text = sdr["AppMstPinCode"].ToString();
    //            //branch.Text = sdr["branch"].ToString();

    //            //acno.Text = sdr["acountno"].ToString();

    //            //panno.Text = sdr["panno"].ToString();
    //            txtPANDetails.Text = sdr["panno"].ToString();

    //            txtAadharNo.Text = sdr["Aadharno"].ToString();

    //            txtEmail.Text = sdr["email"].ToString();
    //            txtnomniName.Text = sdr["nom_name"].ToString();
    //            txtrelation.Text = sdr["nom_rela"].ToString();
    //            txtCity.Text = sdr["appmstcity"].ToString();
    //            ///txtepassword.Text = sdr["ePassword"].ToString();
    //            //rbpanlist.SelectedIndex = rbpanlist.Items.IndexOf(rbpanlist.Items.FindByValue(sdr["panstatus"].ToString()));

    //            System.Web.UI.WebControls.Image imgOnMasterPage = (System.Web.UI.WebControls.Image)(this.Master.FindControl("ProfileImage"));
    //            System.Web.UI.WebControls.Image mobimg = (System.Web.UI.WebControls.Image)(this.Master.FindControl("MobProfileImg"));
    //            if (imgOnMasterPage != null)
    //            {
    //                imgOnMasterPage.ImageUrl = mobimg.ImageUrl = "~/images/KYC/ProfileImage/" + sdr["imagename"].ToString();
    //            }

    //            try
    //            {
    //                //if (sdr["appmststate"].ToString() != "")
    //                //{
    //                //    ddlState.Items.FindByText(sdr["appmststate"].ToString()).Selected = true;
    //                //}
    //                //BindDistrict(ddlState.SelectedItem.Value.ToString());
    //                //if (sdr["distt"].ToString() != "")
    //                //{
    //                //    if (!string.IsNullOrEmpty(sdr["distt"].ToString()))
    //                //        ddlDistrict.Items.FindByText(sdr["distt"].ToString()).Selected = true;
    //                //}

    //                ddlBankName.SelectedValue = sdr["BankName"].ToString();
    //            }
    //            catch (Exception ex) { }
    //            con.Close();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        utility.MessageBox(this, ex.Message);
    //    }
    //}
   

    [System.Web.Services.WebMethod]

    public static string UpdatePersonal(string Title, string GTitle, string GName, string Gender, string DOB, 
        string Email, string Address, string State, string City, string District, string PinCode, string Nom_Name, 
        string Relation, string PSWRD, string Mobile, string Indiv_Comp)
    {
        string result = "";
        try
        {
            utility utility = new utility();
            if (DOB.Trim().Length > 0)

            {

                String[] Date = DOB.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);

                DOB = Date[2] + "/" + Date[1] + "/" + Date[0];

            }

            //if (txtToDate.Text.Trim().Length > 0)

            //{

            //    String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);

            //    toDate = Date[1] + "/" + Date[0] + "/" + Date[2];

            //}

            {
                SqlParameter outparam = new SqlParameter("@strResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;

                DataUtility objDu = new DataUtility();
                SqlParameter[] param = new SqlParameter[]
                {
                    outparam,
                    new SqlParameter("@Appmsttitle", Title),
                    new SqlParameter("@Gtitle", GTitle),
                    new SqlParameter("@gname", GName),
                    new SqlParameter("@gender", Gender),
                    new SqlParameter("@dob", DOB),
                    new SqlParameter("@mobile", Mobile),
                    new SqlParameter("@emailid", Email),
                    new SqlParameter("@address", Address),
                    new SqlParameter("@state", State),
                    new SqlParameter("@city", City),
                    new SqlParameter("@distt", District),
                    new SqlParameter("@pincode", PinCode),
                    new SqlParameter("@nomname", Nom_Name),
                    new SqlParameter("@nomrela", Relation),
                    new SqlParameter("@isProup", 1),
                    new SqlParameter("@mname", ""),
                    new SqlParameter("@regno",HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@pwd", utility.base64Encode(PSWRD)),
                    new SqlParameter("@epassword", ""),
                    new SqlParameter("@Indiv_Comp", Indiv_Comp),
                    

              //  new SqlParameter("@DisplayName", DisplayName),
                };
                result= objDu.ExecuteSqlSPS(param, "updateuserprofile").ToString();
            }
        }
        catch (Exception er)
        {
            result = er.Message;
        }
      return result;
    }

    public void BindBank()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("GetBank", con);
            com.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter da = new SqlDataAdapter(com);
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

    [WebMethod]
    public static string Upload_Pan(string PANNo, string ImgName_Pan)
    {
        string result = "0";
        try
        {
            SqlParameter[] param = new SqlParameter[]
        {
             new SqlParameter("@Regno", HttpContext.Current.Session["userId"].ToString())
        };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "Select sd.PanImage from AppMst a inner join scandocs sd on a.appmstid=sd.appmstid where a.appmstregno=@regno");
            foreach (DataRow dr in dt.Rows)
            {

                
                string IMG = dr["PanImage"].ToString();
                
                string path = HttpContext.Current.Server.MapPath("~/images/KYC/PanImage/" + IMG);

                FileInfo file = new FileInfo(path);
                if (file.Exists)
                {
                    file.Delete();
                }
            }
            if (HttpContext.Current.Session["userId"].ToString() !=null)
            {
                InsertFunction insFunc = new InsertFunction();
                string imagename = insFunc.insertPanDetail(PANNo, HttpContext.Current.Session["userId"].ToString(), ImgName_Pan);
                result = "1";
            }
        }
        catch (Exception er) { result = er.Message; }
        return result;
    }

    // public string insertBankDetail(string Cropfilename, string ddlBkName, string ddlActype, string txtAccno, string txtIfsc, string txtBranch, string usrid)
    //data: '{ ImgName_Bank: "' + ImgName_Bank + '",Bank_Name: "' + Bank_Name + '", Acc_Type: "' + Acc_Type + '", Acc_No: "' + Acc_No + '",IFSC: "' + IFSC + '", Branch: "' + Branch + '" }',
    [WebMethod]
    public static string Upload_Bank(string ImgName_Bank, string Bank_Name,string Acc_Type, string Acc_No, string IFSC, string Branch)
    {
        string result = "0";
        try
        {
            SqlParameter[] param = new SqlParameter[]
        {
             new SqlParameter("@Regno", HttpContext.Current.Session["userId"].ToString())
        };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "Select sd.BankImage from AppMst a inner join scandocs sd on a.appmstid=sd.appmstid where a.appmstregno=@regno");
            foreach (DataRow dr in dt.Rows)
            {

              //HttpContext.Current.Server.MapPath("~/images/KYC/BankImage/"+ dr["BankImage"].ToString());
                string IMG = dr["BankImage"].ToString();
                //string path = "~/images/KYC/BankImage/" + IMG + "";
                string path =HttpContext.Current.Server.MapPath("~/images/KYC/BankImage/" + IMG);

                FileInfo file = new FileInfo(path);
                if (file.Exists)
                {
                    file.Delete();
                }
            }
            //    string ID = HttpContext.Current.Session["userId"].ToString();
            //SqlConnection con = new SqlConnection(method.str);
            //SqlCommand cmd = new SqlCommand(@"Select sd.BankImage from AppMst a inner join scandocs sd on a.appmstid=sd.appmstid where a.appmstregno="+ID+" ", con);
            //cmd.CommandType = CommandType.Text;
            //con.Open();
            //cmd.Parameters.AddWithValue("@action", "B");
            //SqlDataAdapter sda = new SqlDataAdapter(cmd);
            
            //    Directory.GetFiles("");
            //File.Delete("");

            //string Random = Guid.NewGuid().ToString();

            //string fileName =HttpContext.Current.Path.GetFileName(Random + Path.GetExtension(fileCancelCq.FileName));
            //string filePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), Guid.NewGuid().ToString() + fileName);
            //if (System.IO.File.Exists(filePath))
            //{
            //    System.IO.File.Delete(filePath);

            //}
            if (HttpContext.Current.Session["userId"].ToString() != null)
            {
                InsertFunction insFunc = new InsertFunction();
                string imagename = insFunc.insertBankDetail(ImgName_Bank, Bank_Name, Acc_Type, Acc_No, IFSC, Branch, HttpContext.Current.Session["userId"].ToString());
                result = "1";
            }
        }
        catch (Exception er) { result = er.Message; }
        return result;
    }
    [WebMethod]
    public static string Upload_Aadhar(string ImgName_Aadhar_Front, string ImgName_Aadhar_Back, string AdhaarNo)
    {
        string msg = "0";
        try
        {
            SqlParameter[] param = new SqlParameter[]
       {
             new SqlParameter("@Regno", HttpContext.Current.Session["userId"].ToString())
       };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "Select sd.AadharFront, sd.AadharBack from AppMst a inner join scandocs sd on a.appmstid=sd.appmstid where a.appmstregno=@regno");
            foreach (DataRow dr in dt.Rows)
            {

                //HttpContext.Current.Server.MapPath("~/images/KYC/BankImage/"+ dr["BankImage"].ToString());
                string IMG_F = dr["AadharFront"].ToString();
                string IMG_B = dr["AadharBack"].ToString();
                //string path = "~/images/KYC/BankImage/" + IMG + "";
                string pathF = HttpContext.Current.Server.MapPath("~/images/KYC/AadharImage/Front/" + IMG_F);
                string pathB = HttpContext.Current.Server.MapPath("~/images/KYC/AadharImage/Back/" + IMG_B);

                FileInfo fileF = new FileInfo(pathF);
                if (fileF.Exists)
                {
                    fileF.Delete();
                }
                FileInfo fileB = new FileInfo(pathB);
                if (fileB.Exists)
                {
                    fileB.Delete();
                }
            }
            if (HttpContext.Current.Session["userId"].ToString() != null)
            {
                string imgFront, imgback, Userid = HttpContext.Current.Session["userId"].ToString();
                InsertFunction insFunc = new InsertFunction();
                insFunc.insertAddressProof(ImgName_Aadhar_Front, ImgName_Aadhar_Back, Userid, AdhaarNo, out imgFront, out imgback,out msg);
            }
        }
        catch (Exception er) { msg = er.Message; }
        return msg;
    }

    [WebMethod]
    public static string Upload_GST(string GST_No, string GST)
    {
        string result = "0";
        try
        {
            SqlParameter[] param = new SqlParameter[]
        {
             new SqlParameter("@Regno", HttpContext.Current.Session["userId"].ToString())
        };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "Select sd.GST_Img from AppMst a inner join scandocs sd on a.appmstid=sd.appmstid where a.appmstregno=@regno");
            foreach (DataRow dr in dt.Rows)
            {

                //HttpContext.Current.Server.MapPath("~/images/KYC/BankImage/"+ dr["BankImage"].ToString());
                string IMG = dr["GST_Img"].ToString();
                //string path = "~/images/KYC/BankImage/" + IMG + "";
                string path = HttpContext.Current.Server.MapPath("~/images/KYC/PanImage/" + IMG);

                FileInfo file = new FileInfo(path);
                if (file.Exists)
                {
                    file.Delete();
                }
            }
            if (HttpContext.Current.Session["userId"].ToString() != null)
            {
                string UserId = HttpContext.Current.Session["userId"].ToString();
                InsertFunction insFunc = new InsertFunction();
                string imagename = insFunc.GST_Detail(GST_No, UserId, GST, UserId);
                result = "1";
            }
        }
        catch (Exception er) { result = er.Message; }
        return result;
    }



    [WebMethod]
    public static UserDetails GetUser()
    {
        utility utility = new utility();
        UserDetails objUser = new UserDetails();
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("CheckSponsor1", con);
            SqlDataReader dr;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@sid", HttpContext.Current.Session["userId"].ToString());
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                //select AppMstRegNo, AppMstTitle, appmstpassword, AppMstFName, sponsorid, Gtitle, GName, MName, Gender,
                //gtitle, AppMstAddress1, AppMstCity, AppMstState,
                // AppMstMobile, AppMstPinCode, BankName, branch, acountno,[type], panno, Aadharno, email, nom_name, nom_rela, distt = ISNULL(distt, 0), CONVERT(VARCHAR(10), userdob, 103) as userdob,                            
                //IFSCode,MICRCode,panstatus,case when imagename!= '' then imagename else 'noimage.png' end imagename, ePassword, Verified, isProUp, s.statename,s.Id
                objUser.Id = HttpContext.Current.Session["userId"].ToString();
                objUser.UName = dr["AppMstFName"].ToString();
                objUser.Title = dr["AppMstTitle"].ToString();
                objUser.Name = dr["AppMstFName"].ToString();
                objUser.GTitle = dr["Gtitle"].ToString();
                objUser.GName = dr["GName"].ToString();
                objUser.Gender = dr["Gender"].ToString();
                objUser.DOB = dr["userdob"].ToString();
                objUser.Mobile = dr["AppMstMobile"].ToString();
                objUser.Email = dr["email"].ToString();
                objUser.Address = dr["AppMstAddress1"].ToString();
                objUser.State = dr["ID"].ToString();
                objUser.City = dr["AppMstCity"].ToString();
                objUser.District = dr["distt"].ToString();
                objUser.PinCode = dr["AppMstPinCode"].ToString();
                objUser.Nominee = dr["nom_name"].ToString();
                objUser.Relation = dr["nom_rela"].ToString();
                objUser.PAN = dr["panno"].ToString();
                objUser.Bank = dr["BankName"].ToString();
                objUser.AccType = dr["type"].ToString();
                objUser.AccNo = dr["acountno"].ToString();
                objUser.Branch = dr["branch"].ToString();
                objUser.IFSC = dr["IFSCode"].ToString();
                objUser.AadhaarNo = dr["Aadharno"].ToString();
                objUser.did = dr["did"].ToString();
                objUser.isProUp = dr["isProUp"].ToString();

                objUser.PanImage = dr["PanImage"].ToString();
                objUser.PStatus = dr["PStatus"].ToString();
                objUser.bankstatus = dr["bankstatus"].ToString();
                objUser.BankImage = dr["BankImage"].ToString();
                objUser.AadharFront = dr["AadharFront"].ToString();
                objUser.AadharBack = dr["AadharBack"].ToString();
                objUser.AaStatus = dr["AaStatus"].ToString(); 
                //objUser.OnlineAadharVerify = dr["OnlineAadharVerify"].ToString();
                objUser.GST = dr["GST"].ToString();
                objUser.GST_Img = dr["GST_Img"].ToString();
                objUser.GST_Status = dr["GST_Status"].ToString();
                objUser.PSWRD = utility.base64Decode(dr["AppMstPassword"].ToString());

                objUser.Indiv_Comp = dr["Indiv_Comp"].ToString();


            }
            else
            {
                
            }
            dr.Close();
            con.Close();
        }
        catch (Exception er) { }
        return objUser;
    }


    public class UserDetails
    { 
        public String Id { get; set; }
        public String UName { get; set; }
        public String Title { get; set; }
        public String Name { get; set; }
        public String GTitle { get; set; }
        public String GName { get; set; }
        public String Gender { get; set; }
        public String DOB { get; set; }
        public String Mobile { get; set; }
        public String Email { get; set; }
        public String Address { get; set; }
        public String State { get; set; }
        public String City { get; set; }
        public String District { get; set; }
         public String did { get; set; }
 
        public String PinCode { get; set; }
        public String Nominee { get; set; }
        public String Relation { get; set; }
        public String OTP { get; set; }
        public String PAN { get; set; }
        public String Bank { get; set; }
        public String AccType { get; set; }
        public String AccNo { get; set; }
        public String Branch { get; set; }
        public String IFSC { get; set; }
        public String AadhaarNo { get; set; }
        public String isProUp { get; set; }

        public String PanImage { get; set; }
        public String PStatus { get; set; }
        public String bankstatus { get; set; }
        public String BankImage { get; set; }
        public String AadharFront { get; set; }
        public String AadharBack { get; set; }
        public String AaStatus { get; set; }
        public String OnlineAadharVerify { get; set; }
        public String GST { get; set; }
        public String GST_Img { get; set; }
        public String GST_Status { get; set; }
        public String PSWRD { get; set; }
        public String Indiv_Comp { get; set; }
        
    }


    public void BindState()
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[] { };
        DataTable dt = objDu.GetDataTableSP(param1, "GetState");
        ddlState.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddlState.DataSource = dt;
            ddlState.DataTextField = "StateName";
            ddlState.DataValueField = "SId";
            ddlState.DataBind();
            ddlState.Items.Insert(0, new ListItem("Select State", ""));
        }
        else
        {
            ddlState.Items.Insert(0, new ListItem("Select State", ""));
        }
        ddlDistrict.Items.Clear();
        ddlDistrict.Items.Insert(0, new ListItem("Select District", ""));
    }


    [WebMethod]
    public static ArrayList GetDistrict(string StateId)
    {
        ArrayList list = new ArrayList();
        try
        {
            DataUtility objDUT = new DataUtility();
            SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@state", StateId) };
            DataTable dt = objDUT.GetDataTableSP(sqlparam, "GetStateDistrict");
            foreach (DataRow dr in dt.Rows)
            { list.Add(new ListItem(dr["DistrictName"].ToString(), dr["id"].ToString())); }
        }
        catch (Exception er) { }
        return list;
    }


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
            String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 15 min from:toptimenet.com Jai Toptime";
            objUtil.sendSMSByBilling(dt.Rows[0]["AppMstMobile"].ToString().Trim(), msg, "OTP");
        }
        return result;


    }

}