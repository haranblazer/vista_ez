using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class secretadmin_UserLog : System.Web.UI.Page
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
        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-6).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/"); 
        }
    }
     

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string txt_Userid, string txt_ModifyBy, string ddl_reason)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@Appmstregno", txt_Userid),
                new SqlParameter("@modifiedby", txt_ModifyBy),
                new SqlParameter("@reasontomodify", ddl_reason) 
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetUserList_Edited");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Userid = dr["Userid"].ToString();
                data.Username = dr["Username"].ToString();
                data.Date = dr["Date"].ToString();
                data.modifiedby = dr["modifiedby"].ToString();
                data.Remarks = dr["Remarks"].ToString();
                
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }
     
    public class UserDetails
    {
        public string Userid { get; set; }
        public string Username { get; set; }
        public string Date { get; set; }
        public string modifiedby { get; set; }
        public string Remarks { get; set; } 
    }
    #endregion


}