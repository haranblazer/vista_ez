using System;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.Web;
using System.Collections;
using System.Collections.Generic;

public partial class AddFranchise : System.Web.UI.Page
{
    public string DigilockerrequestId = "", DigilockeMsg = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {

                if (Request.QueryString["status"] != null)
                {
                    if (Request.QueryString["status"].ToString().ToLower() == "success")
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
            Bind_FranchiseType();
            BindState();
            BindBank();
        }
    }
    private void Bind_FranchiseType()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4 and UserVal not in (1,2,3, 7, 8, 9, 10)");
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

    #region User Registration
    [WebMethod]
    public static Results AddFran(string SponsorId, string ContactPerson, string Name, string Mobile, string Email, string state, string District, string City, string Pincode, string Address, string GSTNo, string CinNo, string PAN, string Bank, string ACType, string ACNo, string Branch, string IFSC, string Whats_Notify, string Password,
       string PanVerify, string PanDetails, string Aadhaar, string EPassword, string FranType)
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
        //if (Validation.IsValidPassword(Password) == false)
        //{
        //    objResult.Error = "Password contains [A-Za-z0-9!@#$%^&*()] value.!";
        //    return objResult;
        //}

        if (Mobile.Length != 10)
        {
            objResult.Error = "Enter 10 digits Mobile No.!!";
            return objResult;
        }

        try
        {
            utility objUtil = new utility();

            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("AddFranchise", con);
            com.CommandType = CommandType.StoredProcedure;

            com.Parameters.AddWithValue("@txtsponsorid", SponsorId);
            com.Parameters.AddWithValue("@FranchiseName", Name);
            com.Parameters.AddWithValue("@Address", Address);
            com.Parameters.AddWithValue("@City", City);
            com.Parameters.AddWithValue("@District", District);
            com.Parameters.AddWithValue("@State", state);
            com.Parameters.AddWithValue("@PinCode", Pincode);
            com.Parameters.AddWithValue("@EMailId", Email);
            com.Parameters.AddWithValue("@MobileNo", Mobile);
            com.Parameters.AddWithValue("@ContactPerson", ContactPerson);
            com.Parameters.AddWithValue("@IP", HttpContext.Current.Request.ServerVariables["REMOTE_HOST"].ToString());
            com.Parameters.AddWithValue("@UserName", "");
            com.Parameters.AddWithValue("@Password", objUtil.base64Encode(Password));
            com.Parameters.AddWithValue("@EPassword", objUtil.base64Encode(EPassword));
            com.Parameters.AddWithValue("@pan", PAN);
            com.Parameters.AddWithValue("@GST", GSTNo);
            com.Parameters.AddWithValue("@cin", CinNo);
            com.Parameters.AddWithValue("@FranType", FranType);

            com.Parameters.AddWithValue("@BankName", Bank);
            com.Parameters.AddWithValue("@Branch", Branch);
            com.Parameters.AddWithValue("@AccountNo", ACNo);
            com.Parameters.AddWithValue("@AccountType", ACType);
            com.Parameters.AddWithValue("@IfscCode", IFSC);
            com.Parameters.AddWithValue("@Whats_Notify", Whats_Notify);

            com.Parameters.AddWithValue("@PanVerify", PanVerify);
            com.Parameters.AddWithValue("@PanDetails", PanDetails);
            com.Parameters.AddWithValue("@AdhaarNo", Aadhaar);
            
            com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            com.Parameters.Add("@franchiseid", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;

            con.Open();
            com.CommandTimeout = 1900;
            com.ExecuteNonQuery();
            string flag = com.Parameters["@flag"].Value.ToString();
            string franchiseid = com.Parameters["@franchiseid"].Value.ToString();
            if (flag == "1")
            {
 
                var Msg = "Franchises Application Received From *" + SponsorId + "* *" + Name + "* *" + state + "* For Latest Update & News Join us Telegram Link *https://t.me/Toptime_Offical*";

                WhatsApp.Send_WhatsApp_With_Header_Text("8419969894", Msg, "Franchises Application");
                WhatsApp.Send_WhatsApp_With_Header_Text("8698123451", Msg, "Franchises Application");
               

                objResult.franchiseid = franchiseid;
                objResult.status = "1";
                objResult.Error = "";
            }
            else
            {
                objResult.franchiseid = "";
                objResult.status = "0";
                objResult.Error = flag;
            }

        }
        catch (Exception er) { objResult.Error = er.Message.ToString(); }
        return objResult;
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
        DataTable dt = objDu.GetDataTable(param1, "select appmstfname from AppMst where AppMstRegNo=@SponsorId");
        if (dt.Rows.Count > 0)
            name = dt.Rows[0]["appmstfname"].ToString();

        return name;

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



    [WebMethod]
    public static string UpdateImg(string franchiseid, string ImgName_Pan, string ImgName_Bank, string ImgName_Aadhar_Front, string ImgName_Aadhar_Back, string GST_img, string Slip)
    {
        try
        {

            string Result = "1";
            try
            {
                DataUtility objDu = new DataUtility();
                SqlParameter[] param = new SqlParameter[]
                {
                new SqlParameter("@franchiseid", franchiseid),
                new SqlParameter("@ImgName_Pan", ImgName_Pan),
                new SqlParameter("@ImgName_Bank", ImgName_Bank),
                new SqlParameter("@ImgName_Aadhar_Front", ImgName_Aadhar_Front),
                new SqlParameter("@ImgName_Aadhar_Back", ImgName_Aadhar_Back), 
                new SqlParameter("@GST_img", GST_img), 
                new SqlParameter("@Slip", Slip),
                };

                objDu.ExecuteSql(param, @"Update FranchiseMst set Pan_img=@ImgName_Pan, Bank_img=@ImgName_Bank, Aadhar_F_img=@ImgName_Aadhar_Front, 
                Aadhar_B_img=@ImgName_Aadhar_Back, GST_img=@GST_img, Slip=@Slip,
                PanDateLoad=(Case when @ImgName_Pan<>'' then getdate() else null End), 
                BankDateLoad=(Case when @ImgName_Bank<>'' then getdate() else null End),
                AadharDateLoad=(Case when @ImgName_Aadhar_Front<>'' then getdate() else null End), 
                GSTDateLoad=(Case when @GST_img<>'' then getdate() else null End) 
                where Franchiseid=@franchiseid");

            }
            catch (Exception er) { }
            return Result;
        }
        catch (Exception er) { }
        return "";
    }



    #endregion



    #region Validation property

    public class Results
    {
        public String Error { get; set; }
        public String franchiseid { get; set; }
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
        if (Regex.Match(str, @"^[6789]\d{9}$").Success)
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

    public void BindBank()
    {
        try
        {
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP("GetBank");

            ddlBankName.DataSource = dt;
            ddlBankName.DataTextField = "BankName";
            ddlBankName.DataValueField = "SrNo";
            ddlBankName.DataBind();
            ddlBankName.Items.Insert(0, new ListItem("Select Bank", ""));
        }
        catch
        {

        }
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
        DataTable dt = objDu.GetDataTable(param1, "Select Mobile from FranchiseMst Where Mobile=@Mobile");
        if (dt.Rows.Count > 0)
        {
            Result = "Mobile Number already exists.";
        }
        else
        {
            Result = "1";
        }
        return Result;
    }



    [WebMethod]
    public static Credentials[] LoginCredentials(string Flag, string PanNo)
    {
        List<Credentials> details = new List<Credentials>();
        Credentials obj = new Credentials();
        //if (Flag == "PAN")
        //{
        //    DataUtility objDu = new DataUtility();
        //    SqlParameter[] param1 = new SqlParameter[]
        //    {  new SqlParameter("@panno", PanNo.Trim()) };
        //    DataTable dt = objDu.GetDataTable(param1, "Select panno from AppMst where panno=@panno");
        //    if (dt.Rows.Count > 0)
        //        obj.IsExist = "1";
        //    else
        //        obj.IsExist = "0";
        //}
        obj.username = method.Signzyusername;
        obj.password = method.Signzypassword;
        details.Add(obj);

        return details.ToArray();
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


    public class Credentials
    {
        public string IsExist { get; set; }
        public string username { get; set; }
        public string password { get; set; }
    }
    public class Token
    {
        public string Token_id { get; set; }
        public string Token_userId { get; set; }
    }


}


