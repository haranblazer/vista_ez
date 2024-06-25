using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class secretadmin_SMS_Reminder : System.Web.UI.Page
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



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReader("Select RemId, ReminderName, Isactive=isnull(Isactive,0) from SMS_ReminderType order by ReminderName");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.RemId = dr["RemId"].ToString();
                data.ReminderName = dr["ReminderName"].ToString();
                data.Isactive = dr["Isactive"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string RemId { get; set; }
        public string ReminderName { get; set; }
        public string Isactive { get; set; }
    }


    [System.Web.Services.WebMethod]
    public static UserDetails[] GetDetail(string RemId)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@RemId", RemId) };
            SqlDataReader dr = objDu.GetDataReader(param, "Select ReminderName from SMS_ReminderType where RemId=@RemId");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.ReminderName = dr["ReminderName"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static string Save(string RemId, string ReminderName)
    {
        string Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@RemId", RemId), new SqlParameter("@ReminderName", ReminderName) };
            if (RemId == "")
                Result = objDu.ExecuteSql(param, "Insert SMS_ReminderType (ReminderName, Isactive) Values(@ReminderName, 1)").ToString();
            else
                Result = objDu.ExecuteSql(param, "Update SMS_ReminderType Set ReminderName=@ReminderName where RemId=@RemId").ToString();
        }
        catch (Exception er) { }
        return Result;
    }


    [System.Web.Services.WebMethod]
    public static string Delete(string RemId)
    {
        string Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@RemId", RemId) };
            Result = objDu.ExecuteSql(param, "Delete SMS_ReminderType where RemId=@RemId").ToString();
        }
        catch (Exception er) { }
        return Result;
    }
    #endregion
}