using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class secretadmin_SMS_ReminderList : System.Web.UI.Page
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
            txt_Start_Date.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            txt_Expiry_Date.Text = DateTime.Now.AddYears(1).ToString("dd/MM/yyyy").Replace("-", "/");
            binddata(); 
        }
    }

     


    #region BindTable
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string S_UserId)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@S_UserId", S_UserId) 
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_SMS_ReminderList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.SId = dr["SId"].ToString();
               
                data.DocId = dr["DocId"].ToString();
                data.RemId = dr["RemId"].ToString();

                 data.RCID = dr["RCID"].ToString();
                
                data.Category = dr["Category"].ToString();

                data.Start_Date = dr["Start_Date"].ToString();
                 data.Remark = dr["Remarks"].ToString();
                 data.SendSMS = dr["SendSMS"].ToString();
                 data.SendWhatsapp = dr["SendWhats"].ToString();
                 data.SendEmail = dr["SendEmail"].ToString();
                 
                data.ReminderName = dr["ReminderName"].ToString();
                data.DocName = dr["DocName"].ToString();
                data.Expiry_Date = dr["Expiry_Date"].ToString();
                data.FileName = dr["FileName"].ToString();
                data.Duration = dr["Duration"].ToString();
                data.Duration_type = dr["Duration_type"].ToString();
                data.After_Before = dr["After_Before"].ToString();
                data.IsSMS = dr["IsSMS"].ToString();
                data.IsWhatsapp = dr["IsWhatsapp"].ToString();
                data.IsEmail = dr["IsEmail"].ToString();
                data.Isactive = dr["Isactive"].ToString();
                data.UserList = dr["UserList"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string SId { get; set; } 
        public string DocId { get; set; }
        public string RemId { get; set; }
        public string RCID { get; set; }
        public string Category { get; set; } 
        public string ReminderName { get; set; }
        public string DocName { get; set; }
        public string Expiry_Date { get; set; }
        public string FileName { get; set; }
        public string Duration { get; set; }
        public string Duration_type { get; set; }
        public string After_Before { get; set; }
        public string IsSMS { get; set; }
        public string IsWhatsapp { get; set; }
        public string IsEmail { get; set; } 
        public string Isactive { get; set; }
        public string UserList { get; set; } 
        public string Start_Date { get; set; }
        public string Remark { get; set; }
        public string SendSMS { get; set; }
        public string SendWhatsapp { get; set; }
        public string SendEmail { get; set; }
         
    }


    [System.Web.Services.WebMethod]
    public static UserDetails[] GetDetail(string SId)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@SId", SId) };
            SqlDataReader dr = objDu.GetDataReader(param, @"Select sch.SId, d.DocId, r.RemId, sch.RCID, r.ReminderName, d.DocName, Expiry_Date=convert(varchar(10), sch.Expiry_Date, 103), sch.FileName,
            sch.Duration, sch.Duration_type, sch.After_Before, IsSMS = isnull(sch.IsSMS, 0), IsWhatsapp = isnull(sch.IsWhatsapp, 0), sch.IsEmail, Isactive = isnull(sch.Isactive, 0),
            UserList=(Select stuff((select Cast(S_UserId as varchar(50)) +',' from SMS_Schedule_User where Isactive=1 and SId=sch.SId for xml path(''), type).value('.', 'varchar(max)'), 1, 0, '') ),
            Start_Date=convert(varchar(10), sch.Start_Date, 103), sch.Remarks, SendSMS=isnull(sch.SendSMS,0), SendWhats=isnull(sch.SendWhats,0), SendEmail=isnull(sch.SendEmail,0) 
            from SMS_Schedule sch left join SMS_DocumentType d on sch.DocId = d.DocId 
            left join SMS_ReminderType r on sch.RemId = r.RemId 
            where sch.SId =@SId");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.SId = dr["SId"].ToString(); 
                data.DocId = dr["DocId"].ToString();
                data.RemId = dr["RemId"].ToString(); 

                data.RCID = dr["RCID"].ToString();
                data.Start_Date = dr["Start_Date"].ToString();
                data.Remark = dr["Remarks"].ToString();
                data.SendSMS = dr["SendSMS"].ToString();
                data.SendWhatsapp = dr["SendWhats"].ToString();
                data.SendEmail = dr["SendEmail"].ToString(); 

                data.ReminderName = dr["ReminderName"].ToString();
                data.DocName = dr["DocName"].ToString();
                data.Expiry_Date = dr["Expiry_Date"].ToString();
                data.FileName = dr["FileName"].ToString();
                data.Duration = dr["Duration"].ToString();
                data.Duration_type = dr["Duration_type"].ToString();
                data.After_Before = dr["After_Before"].ToString();
                data.IsSMS = dr["IsSMS"].ToString();
                data.IsWhatsapp = dr["IsWhatsapp"].ToString();
                data.IsEmail = dr["IsEmail"].ToString(); 
                data.Isactive = dr["Isactive"].ToString();
                data.UserList = dr["UserList"].ToString(); 
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static string Save(string SId, string DocId, string RemId, string RCID, string Expiry_Date, string FileName,
    string Duration_type, string After_Before, string IsSMS, string IsWhatsapp, string IsEmail, string UserList,
    string Start_Date, string Remark, string SendSMS, string SendWhatsapp, string SendEmail)
    {
        string Result = "0";
        try
        { 
            DataUtility objDu = new DataUtility();
            SqlParameter outparam = new SqlParameter("@intResult", System.Data.SqlDbType.VarChar, 100);
            outparam.Direction = System.Data.ParameterDirection.Output;
            SqlParameter[] param = new SqlParameter[]
            {   
                new SqlParameter("@SId", SId), 
                new SqlParameter("@DocId", DocId),
                new SqlParameter("@RemId", RemId),
                new SqlParameter("@RCID", RCID),
                new SqlParameter("@Expiry_Date", Expiry_Date),
                new SqlParameter("@FileName", FileName), 
                new SqlParameter("@Duration_type", Duration_type),
                new SqlParameter("@After_Before", After_Before),
                new SqlParameter("@IsSMS", IsSMS),
                new SqlParameter("@IsWhatsapp", IsWhatsapp),
                new SqlParameter("@IsEmail", IsEmail),  
                new SqlParameter("@UserList", UserList), 
                new SqlParameter("@Start_Date", Start_Date),
                new SqlParameter("@Remarks", Remark),
                new SqlParameter("@SendSMS", SendSMS), 
                new SqlParameter("@SendWhats", SendWhatsapp),
                new SqlParameter("@SendEmail", SendEmail), 
                outparam
            };
            Result = objDu.ExecuteSqlSP(param, "Add_SMS_ReminderSchedule").ToString();
        }
        catch (Exception er) { Result = er.Message; }
        return Result;
    }


    [System.Web.Services.WebMethod]
    public static string UpdateStatus(string SId)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@SId", SId) };
            objDu.ExecuteSql(param, "update SMS_Schedule set Isactive=(Case isnull(Isactive,0) when 0 then 1 else 0 End) where SId=@SId");
            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }


    [System.Web.Services.WebMethod]
    public static string Delete(string SId)
    {
        string Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@SId", SId) };
            Result = objDu.ExecuteSql(param, "Delete SMS_Schedule where SId=@SId").ToString();
        }
        catch (Exception er) { }
        return Result;
    }

    private void binddata()
    {
        DataUtility objDu = new DataUtility(); 
        DataTable dt = objDu.GetDataTable("select DocId, DocName from SMS_DocumentType where Isactive=1");
        if (dt.Rows.Count > 0)
        { 
            ddl_DocumentType.Items.Clear();
            ddl_DocumentType.DataSource = dt;
            ddl_DocumentType.DataTextField = "DocName";
            ddl_DocumentType.DataValueField = "DocId";
            ddl_DocumentType.DataBind();
            ddl_DocumentType.Items.Insert(0, new ListItem("Select", "0"));
           
        }

        dt = null;
        dt = objDu.GetDataTable("select RemId, ReminderName from SMS_ReminderType where Isactive=1");
        if (dt.Rows.Count > 0)
        { 
            ddl_ReminderType.Items.Clear();
            ddl_ReminderType.DataSource = dt;
            ddl_ReminderType.DataTextField = "ReminderName";
            ddl_ReminderType.DataValueField = "RemId";
            ddl_ReminderType.DataBind();
            ddl_ReminderType.Items.Insert(0, new ListItem("Select", "0"));
        }


        dt = null;
        dt = objDu.GetDataTable("Select S_UserId, UserName from SMS_ContactList where Isactive=1 order by UserName");
        if (dt.Rows.Count > 0)
        {
            chk_Userlist.Items.Clear();
            chk_Userlist.DataSource = dt;
            chk_Userlist.DataTextField = "UserName";
            chk_Userlist.DataValueField = "S_UserId";
            chk_Userlist.DataBind();
        } 
    }

    [System.Web.Services.WebMethod]
    public static ArrayList GetReminderCategory(string RemId)
    {
        ArrayList list = new ArrayList();
        try
        {
            DataUtility objDUT = new DataUtility();
            SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@RemId", RemId) };
            DataTable dt = objDUT.GetDataTable(sqlparam, "Select RCID, Category from SMS_RemCat where Isactive=1 and RemId=@RemId");
            foreach (DataRow dr in dt.Rows)
            { list.Add(new ListItem(dr["Category"].ToString(), dr["RCID"].ToString())); }
        }
        catch (Exception er) { }
        return list;
    }

    #endregion
}