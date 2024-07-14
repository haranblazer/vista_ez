using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI; 
public partial class User_NotificationList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["userId"] == null)
                Response.Redirect("~/Login.aspx");
            else
            {
                txtFromDate.Text = DateTime.Now.Date.AddDays(-7).ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            }
            
        }
    }


    #region DataTable

    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string fromDate, string toDate, string AdminAPRVD)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", fromDate),
                new SqlParameter("@max", toDate),
                new SqlParameter("@UserId", HttpContext.Current.Session["userId"].ToString()),
                new SqlParameter("@AdminAPRVD", AdminAPRVD)
             };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetNotification");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.NId = dr["NId"].ToString();
                data.UserId = dr["UserId"].ToString();
                data.Appmstfname = dr["Appmstfname"].ToString();
                data.AppMstMobile = dr["AppMstMobile"].ToString();
                data.AppMstState = dr["AppMstState"].ToString();
                data.Distt = dr["Distt"].ToString();

                data.ImgName = dr["ImgName"].ToString();
                data.Msg = dr["Msg"].ToString();
                data.AdminAPRVD = dr["AdminAPRVD"].ToString();
                data.GenRank = dr["GenRank"].ToString();
                data.Isactive = dr["Isactive"].ToString();
                data.Doe = dr["Doe"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string NId { get; set; }
        public string UserId { get; set; }
        public string Appmstfname { get; set; }
        public string AppMstMobile { get; set; }
        public string AppMstState { get; set; }
        public string Distt { get; set; }
        public string ImgName { get; set; }
        public string Msg { get; set; }
        public string AdminAPRVD { get; set; }
        public string GenRank { get; set; }
        public string Isactive { get; set; }
        public string Doe { get; set; }
    }


    [System.Web.Services.WebMethod]
    public static string UpdateApprove(string NId)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@NId", NId)
            };
            objDu.ExecuteSql(param, "update NotificationMst set AdminAPRVD=(Case when AdminAPRVD=0 then 1 else 0 end) where NId=@NId");
            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }


    [System.Web.Services.WebMethod]
    public static string DeleteNotification(string NId)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@NId", NId)
            };
            objDu.ExecuteSql(param, "Delete NotificationMst where NId=@NId");
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