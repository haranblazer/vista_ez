using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;

public partial class User_UserServices : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    #region HeaderData


    [System.Web.Services.WebMethod]
    public static LeaderBoard[] GetLeaderBoard(string mstkey)
    {
        List<LeaderBoard> details = new List<LeaderBoard>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@mstkey", mstkey)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetLeaderBoard");
            while (dr.Read())
            {
                LeaderBoard data = new LeaderBoard();
                data.RNO = dr["RNO"].ToString();
                data.Gender = dr["Gender"].ToString();
                data.Appmstregno = dr["Appmstregno"].ToString();
                data.Appmstfname = dr["Appmstfname"].ToString();
                data.imagename = dr["imagename"].ToString();
                data.TotalBV = dr["TotalBV"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }




    [System.Web.Services.WebMethod]
    public static string NotificationUpdate()
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param = new SqlParameter[]
        {
             new SqlParameter("@UserId", HttpContext.Current.Session["userId"].ToString())
        };
        objDu.ExecuteSql(param, "update AppMst set NOTIF=0 where AppmstRegno=@UserId");
        return "1";
    }

    [System.Web.Services.WebMethod]
    public static Notification[] ReadNotification()
    {
        List<Notification> details = new List<Notification>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
           {
             new SqlParameter("@UserId", HttpContext.Current.Session["userId"].ToString())
           };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetUserNotification");
            while (dr.Read())
            {
                Notification data = new Notification();
                data.NId = dr["NId"].ToString();
                data.Msg = dr["Msg"].ToString();
                data.NOTIF = dr["NOTIF"].ToString();
                data.AppMstRegNo = dr["AppMstRegNo"].ToString();
                data.AppMstFName = dr["AppMstFName"].ToString();
                data.RankName = dr["RankName"].ToString();
                data.Doe = dr["Doe"].ToString();
                data.imagename = dr["imagename"].ToString();
                details.Add(data);

            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }




    [System.Web.Services.WebMethod]
    public static SalesDetails[] GetSalesData()
    {
        List<SalesDetails> details = new List<SalesDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
           {
             new SqlParameter("@Regno", HttpContext.Current.Session["userId"].ToString())
           };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_highcharts_User");
            while (dr.Read())
            {
                SalesDetails data = new SalesDetails();
                data.MonthName = dr["MonthName"].ToString();
                data.JoiningSales = dr["JoiningSales"].ToString();
                data.PackageSales = dr["PackageSales"].ToString();
                data.RepurchaseSales = dr["RepurchaseSales"].ToString();
                data.TotalSales = dr["TotalSales"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class LeaderBoard
    {
        public String RNO { get; set; }
        public String Gender { get; set; }
        public String Appmstregno { get; set; }
        public String Appmstfname { get; set; }
        public String imagename { get; set; }
        public String TotalBV { get; set; }
    }


    public class Notification
    {
        public String NId { get; set; }
        public String Msg { get; set; }
        public String NOTIF { get; set; }
        public String AppMstRegNo { get; set; }
        public String AppMstFName { get; set; }
        public String RankName { get; set; }
        public String Doe { get; set; }
        public String imagename { get; set; }
    }


    public class SalesDetails
    {
        private string _monthName; // field 
        public string MonthName { get { return _monthName; } set { _monthName = value; } }

        private string _joiningSales; // field 
        public string JoiningSales { get { return _joiningSales; } set { _joiningSales = value; } }

        private string _packageSales; // field 
        public string PackageSales { get { return _packageSales; } set { _packageSales = value; } }

        private string _repurchaseSales; // field 
        public string RepurchaseSales { get { return _repurchaseSales; } set { _repurchaseSales = value; } }

        private string _totalSales; // field 
        public string TotalSales { get { return _totalSales; } set { _totalSales = value; } }

    }
    #endregion

}