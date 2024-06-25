using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Data;
using System.Web.UI.WebControls;

public partial class secretadmin_WhatsAppSentLog : System.Web.UI.Page
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
            txtFromDate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");
            BindType();
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string Mobile, string searchType)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@search", Mobile),
                new SqlParameter("@searchType", searchType),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "sp_whatsAppLog");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.date = dr["date"].ToString();
                data.UserId = dr["UserId"].ToString();
                data.Mobile = dr["Mobile"].ToString();
                data.SendType = dr["Methord"].ToString();
                data.Message = dr["TextMsg"].ToString();
                data.Response = dr["Response"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string date { get; set; }
        public string UserId { get; set; }
        public string Mobile { get; set; }
        public string SendType { get; set; }
        public string Message { get; set; }
        public string Response { get; set; }

    }

    private void BindType()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("select distinct Methord from WhatsApp_Log");
        ddl_searchType.Items.Clear();
        ddl_searchType.DataSource = dt;
        ddl_searchType.DataTextField = "Methord";
        ddl_searchType.DataValueField = "Methord";
        ddl_searchType.DataBind();
        ddl_searchType.Items.Insert(0, new ListItem("Select All", ""));
    }
    #endregion

}