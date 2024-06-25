using System;
using System.Collections.Generic;
using System.Data.SqlClient;


public partial class secretadmin_AdminLoginLog : System.Web.UI.Page
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
    public static UserDetails[] BindTable(string min, string max, string txt_Userid)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@Appmstregno", txt_Userid), 
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetAdminLogList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.UserName = dr["UserName"].ToString();
                data.IPAddress = dr["IPAddress"].ToString();
                data.Date = dr["Date"].ToString(); 
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string UserName { get; set; }
        public string IPAddress { get; set; }
        public string Date { get; set; } 
    }
    #endregion

}