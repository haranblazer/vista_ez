using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class newjoin : System.Web.UI.Page 
{
    utility objUtil = new utility();
    public string company, website, address;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            checkpage();
            BindState();
            getCompAddrWeb();
            if (Request.QueryString["id"] != null)
            {
                Boolean detect = ISValidUserID(Request.QueryString["id"]);
                if (detect == false)
                {
                    Response.Redirect("~/Default.aspx", true);
                }
                else
                {
                    txt_SponsorId.Text = Request.QueryString["id"].ToString();
                    ddlposition.SelectedItem.Text = Request.QueryString["pos"].ToString();
                }
            }

            lbl_sponsorname.InnerHtml = GetSponsorName(txt_SponsorId.Text.Trim());
        }
    }


    #region User Registration
    [WebMethod]
    public static Results UserRegistration(string SponsorId, string Position, string Title, string Name, string state, string Gtitle, string GName, string Mobile,
    string Email, string Password, string epassword)
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
        try
        {
            utility objUt = new utility();
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            string date = "";
            date = Convert.ToDateTime("01/01/1900", dateInfo).ToString();

            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("Insertdata5", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@sponserID", SponsorId);
            com.Parameters.AddWithValue("@AppMstLeftRight", Position);
            com.Parameters.AddWithValue("@AppMstTitle", Title);
            com.Parameters.AddWithValue("@AppMstFName", Name);
            com.Parameters.AddWithValue("@DOB", date);
            com.Parameters.AddWithValue("@AppMstState", state);
            com.Parameters.AddWithValue("@District", "0");
            com.Parameters.AddWithValue("@AppMstCity", "");
            com.Parameters.AddWithValue("@AppMstAddress1", "");
            com.Parameters.AddWithValue("@AppMstPinCode", "");
            com.Parameters.AddWithValue("@panno", "");
            com.Parameters.AddWithValue("@AadharNo", "");
            com.Parameters.AddWithValue("@mobile", Mobile);
            com.Parameters.AddWithValue("@emailid", Email);
            com.Parameters.AddWithValue("@BankName", "");
            com.Parameters.AddWithValue("@Branch", "");
            com.Parameters.AddWithValue("@AccountNo", "");
            com.Parameters.AddWithValue("@AccountType", "");
            com.Parameters.AddWithValue("@IFS", "");
            com.Parameters.AddWithValue("@Gtitle", Gtitle);
            com.Parameters.AddWithValue("@NomineeName", "");
            com.Parameters.AddWithValue("@NomineeRelation", "");
            com.Parameters.AddWithValue("@AppMstPassword", objUt.base64Encode(Password));
            com.Parameters.AddWithValue("@epassword", objUt.base64Encode(epassword) );
            com.Parameters.AddWithValue("@IPAddress", HttpContext.Current.Request.ServerVariables["REMOTE_HOST"].ToString());
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
               // Dear %% Sign Up Successful ID no %% Password %% E Password %% From %% Thanks.
                string Text_Msg = "Dear " + Name + " Sign Up Successful ID no " + AppMstRegNo + " Password " + Password +" From toptimenet.com Thanks.";
                //string Text_Msg = "Dear " + Name + " Welcome to Toptime, Your account is successfully created and username is " + AppMstRegNo + " and password is " + Password + ". Thanks for choosing us.";
                objUtil.sendSMSCjstore(Mobile, Text_Msg);

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
            DdlState.Items.Insert(0, new ListItem("Select", ""));
        }
        else
            DdlState.Items.Insert(0, new ListItem("Select", ""));
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
        SqlParameter[] param1 = new SqlParameter[] {};
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
        public String Error { get; set; }
        public String Regno { get; set; }
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
        if (Regex.Match(str, @"^[6789]\d{9}$").Success)
            return true;
        else
            return false;
    }
    #endregion
}
