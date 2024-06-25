using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class newjoin : System.Web.UI.Page
{
    public string DigilockerrequestId = "", DigilockeMsg = "";
 
    public string CallBackUrl =method.WEB_URL+ "/newjoin.aspx"; 

    utility objUtil = new utility();
    public string company, website, address;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


            txt_Pan.Attributes.Add("autocomplete", "off");

            txt_Aadhar.Attributes.Add("autocomplete", "off"); 
            TxtName.Attributes.Add("autocomplete", "off");


            txtDOB.Text = DateTime.Now.AddYears(-18).ToString("dd/MM/yyyy").Replace("-", "/");
            checkpage();
            BindState();
            getCompAddrWeb();
            BindBank();

           
            if (Request.QueryString.Count>0)
            {
                
                if (Request.QueryString["status"] != null)
                {
                    if (Request.QueryString["status"].ToString().ToLower() =="success")
                    {
                        if (Request.QueryString["requestId"] != null)
                            DigilockerrequestId = Request.QueryString["requestId"];
                    }
                    else
                    {
                        DigilockeMsg = Request.QueryString["status"];
                    }
                }
                
            }

            if (Request.QueryString["id"] != null)
            {
                Boolean detect = ISValidUserID(Request.QueryString["id"]);
                if (detect == false)
                {
                    Response.Redirect("~/Default.aspx", true);
                }
                else
                {
                    txt_Sponsor.Text = Request.QueryString["id"].ToString();
                    //if (Request.QueryString["pos"].ToString() == "Right")
                    //    ddlposition.SelectedValue = "1";
                    //else
                        ddlposition.SelectedValue = "0";
                }
            }

            lbl_sponsorname.InnerHtml = GetSponsorName(txt_Sponsor.Text.Trim());
        }
    }


    #region User Registration
    [WebMethod]
    public static Results UserRegistration(string SponsorId, string Position, string Title, string Name, string state, string Gtitle, string GName, string Mobile,
    string Email, string Password, string epassword, string District, string City, string Pincode, string Address,
    string Gender, string DOB, string Relation, string NomineeName, string Bank, string ACType, string ACNo, string Branch, string IFSC, string PAN, string Aadhar, string Whats_Notify,
    string PanVerify, string AadharVerify, string PanDetails, string AadharDetails, string DigilockerVerify, string DigilockerDetails)
    {
         
        Results objResult = new Results();
        SponsorId = SponsorId.ToString().Trim();
        if (SponsorId == "")
        {
            objResult.Error = "Please Enter Sponsor Id.";
            return objResult;
        }
        if (IsValidMobile(Mobile) == false)
        {
            objResult.Error = "Please Enter Valid Mobile No.";
            return objResult;
        }
        //if (!string.IsNullOrEmpty(IFSC))
        //{
        //    if (isValidIFSCode(IFSC) == false)
        //    {
        //        objResult.Error = "Please Enter Valid IFSC Code.";
        //        return objResult;
        //    }
        //}
        if (Validation.IsValidPassword(Password) == false)
        {
            objResult.Error = "Password contains [A-Za-z0-9!@#$%^&*()] value.!";
            return objResult;
        }
        if (Validation.IsValidPassword(epassword) == false)
        {
            objResult.Error = "Password contains [A-Za-z0-9!@#$%^&*()] value.!";
            return objResult;
        }
        if (Mobile.Length != 10)
        {
            objResult.Error = "Enter 10 digits Mobile No.!!";
            return objResult;
        }

        try
        {
            utility objUt = new utility();
            try
            {
                if (DOB.Length > 0)
                {
                    String[] Date = DOB.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    DOB = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
                else
                {
                    DOB = "01/01/1900";
                }
            }
            catch (Exception er)
            {
                objResult.Error = er.Message;
                return objResult;
            }


            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("Insertdata5", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@sponserID", SponsorId);
            com.Parameters.AddWithValue("@AppMstLeftRight", Position);
            com.Parameters.AddWithValue("@AppMstTitle", Title);
            com.Parameters.AddWithValue("@AppMstFName", Name);
            com.Parameters.AddWithValue("@DOB", DOB);
            com.Parameters.AddWithValue("@AppMstState", state);
            com.Parameters.AddWithValue("@District", District);
            com.Parameters.AddWithValue("@AppMstCity", City);
            com.Parameters.AddWithValue("@Gender", Gender);
            com.Parameters.AddWithValue("@AppMstAddress1", Address);
            com.Parameters.AddWithValue("@AppMstPinCode", Pincode);
            com.Parameters.AddWithValue("@panno", PAN);
            com.Parameters.AddWithValue("@AadharNo", Aadhar);
            com.Parameters.AddWithValue("@mobile", Mobile);
            com.Parameters.AddWithValue("@emailid", Email);
            com.Parameters.AddWithValue("@BankName", Bank);
            com.Parameters.AddWithValue("@Branch", Branch);
            com.Parameters.AddWithValue("@AccountNo", ACNo);
            com.Parameters.AddWithValue("@AccountType", ACType);
            com.Parameters.AddWithValue("@IFS", IFSC);
            com.Parameters.AddWithValue("@Gtitle", Gtitle);
            com.Parameters.AddWithValue("@GName", GName);
            com.Parameters.AddWithValue("@NomineeName", NomineeName);
            com.Parameters.AddWithValue("@NomineeRelation", Relation);
            com.Parameters.AddWithValue("@T_Pwd", Password);
            com.Parameters.AddWithValue("@AppMstPassword", objUt.base64Encode(Password));
            com.Parameters.AddWithValue("@epassword", objUt.base64Encode(epassword));
            com.Parameters.AddWithValue("@IPAddress", HttpContext.Current.Request.ServerVariables["REMOTE_HOST"].ToString());
            com.Parameters.AddWithValue("@PanVerify", PanVerify);
            com.Parameters.AddWithValue("@AadharVerify", AadharVerify);
            com.Parameters.AddWithValue("@PanDetails", PanDetails);
            com.Parameters.AddWithValue("@AadharDetails", AadharDetails);
            com.Parameters.AddWithValue("@DigilockerVerify", DigilockerVerify);
            com.Parameters.AddWithValue("@DigilockerDetails", DigilockerDetails);
              
            com.Parameters.Add("@regDisplay", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.CommandTimeout = 1900;
            com.ExecuteNonQuery();
            string status = com.Parameters["@flag"].Value.ToString();
            string AppMstRegNo = com.Parameters["@regDisplay"].Value.ToString();
            if (status == "1")
            {
                utility objUtil = new utility();
                string subUserName, Text_Msg = "";
                if (Name.Length > 20)
                {
                    subUserName = Name.Substring(0, 20).ToString();
                    //Text_Msg = "Dear " + subUserName + " Sign Up Successful ID No: " + AppMstRegNo + " Password: " + Password;
                    Text_Msg = "Dear " + subUserName + " Sign Up Successful ID No:" + AppMstRegNo + " Password:" + Password+" from {#address#} Jai Toptime";
                }
                else
                {
                    Text_Msg = "Dear " + Name + " Sign Up Successful ID No:" + AppMstRegNo + " Password:" + Password + " from {#address#} Jai Toptime";
                    //Text_Msg = "Dear " + Name + " Sign Up Successful ID No: " + AppMstRegNo + " Password: " + Password;
                }
                 
                if (Whats_Notify == "1")
                {
                    WhatsApp.Send_WhatsApp_OPT_IN(Mobile);
                    SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Mobileno", Mobile) };
                    DataUtility objDu = new DataUtility();
                    objDu.ExecuteSql(param, " update AppMst set IS_OPTIN=1, OPTIN_Date=getdate() where AppMstMobile=@Mobileno");

                    // var Msg = "Dear *"+ Name + "* you have signed up successfully and your ID No. is *" + AppMstRegNo + "* and Mobile is *" + Mobile + "*. From www.toptimenet.com. *Jai Toptime*";
                    //var Msg = "Dear *" + Name + "* you have signed up successfully and your Id No. *" + AppMstRegNo + "* and Mobile is *" + Mobile + "*";
                    var Msg = "Dear *" + Name + "* You have Signed Up Successfully. And your ID No. *" + AppMstRegNo + "* Password " + Password+" Mobile No is "+ Mobile+" For latest News & updates please join us on Telegram by clicking the link ";
                    Msg= Msg+"https://t.me/Toptime_Offical";

                    WhatsApp.Send_WhatsApp_With_Header(Mobile, Msg, "Welcome to Toptime");
                }

                //Dear {#var#} Sign Up Successful ID No:{#var#} Password:{#var#} from {#var#} Jai Toptime
                objUtil.sendSMSByBilling(Mobile, Text_Msg, "SIGNUP");

                if (HttpContext.Current.Session["RootCart"] != null)
                {
                    objResult.IsCart = "1";
                }
                objResult.AppmstRegno =  AppMstRegNo;
                objResult.Regno = objUtil.base64Encode(AppMstRegNo);
                objResult.Name = objUtil.base64Encode(Name);
                objResult.Sponsorid = objUtil.base64Encode(SponsorId);
                objResult.Mobile = objUtil.base64Encode(Mobile);
                objResult.Email = objUtil.base64Encode(Email);
                objResult.Password = objUtil.base64Encode(Password);
                objResult.status = status;
                objResult.Error = "";
            }
            else
            {
                objResult.Error = status;
            }

        }
        catch (Exception er) { objResult.Error = er.Message.ToString(); }
        return objResult;
    }



    [WebMethod]
    public static string UpdateImg(string Regno, string ImgName_Pan, string ImgName_Bank, string ImgName_Aadhar_Front, string ImgName_Aadhar_Back)
    { 
        try {

            string Result = "1";
            try
            {
                DataUtility objDu = new DataUtility();
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@Regno", Regno),
                new SqlParameter("@ImgName_Pan", ImgName_Pan),
                new SqlParameter("@ImgName_Bank", ImgName_Bank),
                new SqlParameter("@ImgName_Aadhar_Front", ImgName_Aadhar_Front),
                new SqlParameter("@ImgName_Aadhar_Back", ImgName_Aadhar_Back)
                };
                
                objDu.ExecuteSql(param, @"update scandocs set 
                PanImage=@ImgName_Pan, BankImage=@ImgName_Bank, AadharFront=@ImgName_Aadhar_Front, AadharBack=@ImgName_Aadhar_Back,
                PanDateLoaded=(Case when @ImgName_Pan<>'' then getdate() else null End), 
                bankDateLoaded=(Case when @ImgName_Bank<>'' then getdate() else null End),
                docDateLoaded=(Case when @ImgName_Aadhar_Front<>'' then getdate() else null End) 

                where AppMstID=(Select Appmstid from Appmst where Appmstregno=@Regno)");
                 
            }
            catch (Exception er) { }
            return Result;
        }
        catch (Exception er) { }
        return "";
    }


    #endregion



    #region Bind Selector
    [WebMethod]
    public static string GetSponsorName(string SponsorId)
    {
        string name = string.Empty;

        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[]
        {  new SqlParameter("@SponsorId", SponsorId.Trim()) };
        DataTable dt = objDu.GetDataTable(param1, "select appmstfname,appmsttitle from AppMst where AppMstRegNo=@SponsorId");
        if (dt.Rows.Count > 0)
            name = dt.Rows[0]["appmsttitle"].ToString() + " " + dt.Rows[0]["appmstfname"].ToString();

        return name;

    }


    [WebMethod]
    public static Credentials[] LoginCredentials(string Flag, string PanNo)
    {
        List<Credentials> details = new List<Credentials>();
        Credentials obj = new Credentials();
        if(Flag== "PAN")
        { 
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {  new SqlParameter("@panno", PanNo.Trim()) };
            DataTable dt = objDu.GetDataTable(param1, "Select panno from AppMst where panno=@panno");
            if (dt.Rows.Count > 0)
                obj.IsExist = "1";
            else
                obj.IsExist = "0";
        }
        obj.username = method.Signzyusername;
        obj.password = method.Signzypassword;
        details.Add(obj);

        return details.ToArray();
    }

    [WebMethod]
    public static string GetStateId(string statename)
    {
        string id ="";
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[]
        {  new SqlParameter("@statename", statename.Trim()) };
        id = objDu.GetScaler(param1, "Select top 1 id from stategstmst where statename=@statename").ToString();
        return id;
    }

    [WebMethod]
    public static string GetDistrictId(string district)
    {
        string districtname = "";
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[]
        {  new SqlParameter("@district", district.Trim()) };
        return districtname = objDu.GetScaler(param1, "Select top 1 districtname from districtmst where districtname=@district").ToString();
    }



    public class Credentials
    {
        public string IsExist { get; set; }
        public string username { get; set; }
        public string password { get; set; }
    }


    [WebMethod]
    public static Token[] ToketDetails(string Flag, string Token_id, string Token_userId)
    {
        List<Token> details = new List<Token>();
        Token obj = new Token();
        if (Flag == "SET")
        {
            if (HttpContext.Current.Session["Token_id"] == null)
                obj.Token_id = Token_id;

            if (HttpContext.Current.Session["Token_userId"] == null)
                obj.Token_userId = Token_userId;
        }
        if (Flag == "GET")
        {
            if (HttpContext.Current.Session["Token_id"] != null)
                obj.Token_id = HttpContext.Current.Session["Token_id"].ToString();

            if (HttpContext.Current.Session["Token_userId"] != null)
                obj.Token_userId = HttpContext.Current.Session["Token_userId"].ToString();
        }
        return details.ToArray();
    }


    public class Token
    {
        public string Token_id { get; set; }
        public string Token_userId { get; set; }
    }



    [WebMethod]
    public static string GetDefaultSponsorId()
    {
        string SponsorId = "";
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select UserVal from SettingMst where Caption='DEFAULT_SPONSORID'");
        if (dt.Rows.Count > 0)
            SponsorId = dt.Rows[0]["UserVal"].ToString();
        return SponsorId;
    }


    public void BindState()
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[] { };
        DataTable dt = objDu.GetDataTableSP(param1, "GetState");
        DdlState.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            DdlState.DataSource = dt;
            DdlState.DataTextField = "StateName";
            DdlState.DataValueField = "SId";
            DdlState.DataBind();
            DdlState.Items.Insert(0, new ListItem("Select State", ""));
        }
        else
        {
            DdlState.Items.Insert(0, new ListItem("Select State", ""));
        }
        ddlDistrict.Items.Clear();
        ddlDistrict.Items.Insert(0, new ListItem("Select District", ""));
    }


    public void checkpage()
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[] {
             new SqlParameter("@action", "1")
        };
        SqlDataReader dr = objDu.GetDataReaderSP(param1, "pageprocess");
        while (dr.Read())
        {
            if (dr["signup"].ToString() == "OFF")
                Response.Redirect("~/Login.aspx");
        }
    }

    public void getCompAddrWeb()
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[] { };
        DataTable dt = objDu.GetDataTableSP(param1, "companydetails");
        if (dt.Rows.Count > 0)
        {
            company = dt.Rows[0]["companyname"].ToString();
            address = dt.Rows[0]["address"].ToString();
            website = dt.Rows[0]["website"].ToString();
        }
    }


    #endregion



    #region Validation property

    public class Results
    {
        public String IsCart { get; set; }
        public String Error { get; set; }
        public String Regno { get; set; }
        public String AppmstRegno { get; set; }
        public String Name { get; set; }
        public String Sponsorid { get; set; }
        public String Mobile { get; set; }
        public String Email { get; set; }
        public String Password { get; set; }
        public String status { get; set; }
    }


    public static Boolean ISValidUserID(string no)
    {
        string name = string.Empty;
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[] { new SqlParameter("@SponsorId", no) };
        DataTable dt = objDu.GetDataTable(param1, "select appmstid from AppMst where AppMstRegNo=@SponsorId");
        if (dt.Rows.Count > 0)
            return true;
        else
            return false;
    }
    public static Boolean IsValidMobile(string str)
    {
        if (Regex.Match(str, @"^([0-9]{10})$").Success)
            return true;
        else
            return false;
    }
    public static Boolean isValidIFSCode(string str)
    {
        if (Regex.Match(str, @"^[A-Z]{4}0[A-Z0-9]{6}$").Success)
            return true;
        else
            return false;
    }

    #endregion

     

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
            { list.Add(new ListItem(dr["DistrictName"].ToString(), dr["DistrictName"].ToString())); }
        }
        catch (Exception er) { }
        return list;
    }



    [WebMethod]
    public static string GenerateOTP(string Mobile)
    {
        string Result = "0";
        if (Mobile.Length != 10)
        {
            return "Please Enter Valid Mobile No.!!";
        }
        DataTable dt = new DataTable();
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        da = new SqlDataAdapter("GenerateOTP_ByMobile", con);
        da.SelectCommand.Parameters.AddWithValue("@Mobile", Mobile);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["Error"].ToString() == "")
            {
                utility objUtil = new utility();
                //String msg = "OTP: " + dt.Rows[0]["OTP"].ToString().Trim() + " For New Member. Don't share with anyone.";
                String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 15 min from:toptimenet.com Jai Toptime";
                objUtil.sendSMSByBilling(Mobile, msg, "OTP");
            }
            else
            {
                Result = dt.Rows[0]["Error"].ToString();
            }
        }
        return Result;
    }


    [WebMethod]
    public static string VerifyOTP(string Mobile, string OTP)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("VerifyOTP_ByMobile", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@Mobile", Mobile);
        com.Parameters.AddWithValue("@OTP", OTP);
        com.Parameters.Add("@IsValid", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        return com.Parameters["@IsValid"].Value.ToString();
    }

    [WebMethod]
    public static string MobileVerify(string Mobile)
    {
        string Result = "0";
        if (Mobile.Length != 10)
        {
            return "Enter 10 digits Mobile No.!!";
        }
        if (IsValidMobile(Mobile) == false)
        {
            return "Please Enter Valid Mobile No."; 
        }

        SqlParameter[] param1 = new SqlParameter[]
          { new SqlParameter("@Mobile", Mobile) };

        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param1, "Select AppMstid from AppMst Where AppMstMobile=@Mobile");
        if (dt.Rows.Count > 0)
        {
            Result = "Your: " + Mobile  + " Mobile Number already exists.";
        }
        else
        {
            Result = "1";
        }
        return Result;
    }

    public void BindBank()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("GetBank", con);
        com.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddlBankName.DataSource = dt;
        ddlBankName.DataTextField = "BankName";
        ddlBankName.DataValueField = "SrNo";
        ddlBankName.DataBind();
        ddlBankName.Items.Insert(0, new ListItem("Select Bank", ""));
    }

   
}
