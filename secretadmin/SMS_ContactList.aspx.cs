using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class secretadmin_SMS_ContactList : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
    }



    #region BindTable
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string UserName, string Email, string MobileNo)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility(); 
            SqlParameter[] param = new SqlParameter[]
            {  
                new SqlParameter("@UserName", UserName),
                new SqlParameter("@Email", Email),
                new SqlParameter("@MobileNo", MobileNo) 
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_SMS_ContactList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.S_UserId = dr["S_UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.Email = dr["Email"].ToString();
                data.MobileNo = dr["MobileNo"].ToString();
                data.Isactive = dr["Isactive"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string S_UserId { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }
        public string MobileNo { get; set; }
        public string Isactive { get; set; }

    }


    [System.Web.Services.WebMethod]
    public static UserDetails[] GetDetail(string S_UserId)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@S_UserId", S_UserId) };
            SqlDataReader dr = objDu.GetDataReader(param, "Select S_UserId, UserName, Email, MobileNo, Isactive=isnull(Isactive,0) from SMS_ContactList where S_UserId=@S_UserId");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.S_UserId = dr["S_UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.Email = dr["Email"].ToString();
                data.MobileNo = dr["MobileNo"].ToString();
                data.Isactive = dr["Isactive"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static string Save(string S_UserId, string UserName, string Email, string MobileNo)
    {
        string Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter outparam = new SqlParameter("@intResult", System.Data.SqlDbType.VarChar, 100);
            outparam.Direction = System.Data.ParameterDirection.Output;
            SqlParameter[] param = new SqlParameter[]
            {   new SqlParameter("@S_UserId", S_UserId),
                new SqlParameter("@UserName", UserName),
                new SqlParameter("@Email", Email),
                new SqlParameter("@MobileNo", MobileNo),
                outparam
            };
            Result = objDu.ExecuteSqlSP(param, "Add_SMS_ContactList").ToString();
        }
        catch (Exception er) { }
        return Result;
    }


    [System.Web.Services.WebMethod]
    public static string Delete(string S_UserId)
    {
        string Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@S_UserId", S_UserId) };
            Result = objDu.ExecuteSql(param, "Delete SMS_ContactList where S_UserId=@S_UserId").ToString();
        }
        catch (Exception er) { }
        return Result;
    }

    [System.Web.Services.WebMethod]
    public static string UpdateStatus(string S_UserId)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@S_UserId", S_UserId) };
            objDu.ExecuteSql(param, "update SMS_ContactList set Isactive=(Case isnull(Isactive,0) when 0 then 1 else 0 End) where S_UserId=@S_UserId");
            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }


    #endregion
}