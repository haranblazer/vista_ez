using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class secretadmin_SMS_RemCat : System.Web.UI.Page
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
        if (!Page.IsPostBack)
        { 
            binddata();
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
            SqlDataReader dr = objDu.GetDataReader(@"Select rc.RCID, rc.RemId, rt.ReminderName, rc.Category, Isactive=isnull(rc.Isactive,0) from SMS_RemCat rc left join SMS_ReminderType rt on rc.RemId=rt.RemId order by rc.Category");
            while (dr.Read()) 
            {
                UserDetails data = new UserDetails();
                data.RCID = dr["RCID"].ToString();
                data.RemId = dr["RemId"].ToString();
                data.ReminderName = dr["ReminderName"].ToString();
                data.Category = dr["Category"].ToString();
                data.Isactive = dr["Isactive"].ToString(); 
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string RCID { get; set; }
        public string RemId { get; set; }
        public string Category { get; set; }
        public string ReminderName { get; set; }
        public string Isactive { get; set; }
        
    }


    [System.Web.Services.WebMethod]
    public static UserDetails[] GetDetail(string RCID)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@RCID", RCID) };
            SqlDataReader dr = objDu.GetDataReader(param, "Select rc.RemId, rt.ReminderName, rc.Category from SMS_RemCat rc left join SMS_ReminderType rt on rc.RemId=rt.RemId where rc.RCID=@RCID");
            while (dr.Read()) 
            {
                UserDetails data = new UserDetails();
                data.RemId = dr["RemId"].ToString();
                data.ReminderName = dr["ReminderName"].ToString();
                data.Category = dr["Category"].ToString();
                details.Add(data);
            } 
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static string Save(string RCID, string RemId, string Category)
    {
        string Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {   new SqlParameter("@RCID", RCID),
                new SqlParameter("@RemId", RemId), 
                new SqlParameter("@Category", Category) 
            };
            if (RCID == "")
                Result = objDu.ExecuteSql(param, "Insert SMS_RemCat (RemId, Category, Isactive) Values(@RemId, @Category, 1)").ToString();
            else
                Result = objDu.ExecuteSql(param, "Update SMS_RemCat Set Category=@Category, RemId=@RemId where RCID=@RCID").ToString();
             
        }
        catch (Exception er) { }
        return Result;
    }


    [System.Web.Services.WebMethod]
    public static string Delete(string RCID)
    {
        string Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@RCID", RCID) };
            Result = objDu.ExecuteSql(param, "Delete SMS_RemCat where RCID=@RCID").ToString();
        }
        catch (Exception er) { }
        return Result;
    }

    private void binddata()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("select RemId, ReminderName from SMS_ReminderType where Isactive=1");
        if (dt.Rows.Count > 0)
        {
            ddl_ReminderType.Items.Clear();
            ddl_ReminderType.DataSource = dt;
            ddl_ReminderType.DataTextField = "ReminderName";
            ddl_ReminderType.DataValueField = "RemId";
            ddl_ReminderType.DataBind();
            ddl_ReminderType.Items.Insert(0, new ListItem("Select", "0"));
        }

    }

    #endregion
}