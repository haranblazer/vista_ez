using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;

public partial class secretadmin_ScanCode : System.Web.UI.Page
{
    public string UpdateBy = "";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
        {
            Response.Redirect("logout.aspx");
        }
        else
        { 
            UpdateBy = Session["admin"].ToString();
        }

        if (!Page.IsPostBack)
        {
           // BindQRCode();
            txt_ScanCode.Attributes.Add("onchange", "javascript:GetDetails()");

           // txt_ScanCode.Attributes.Add("onchange", "return false;");
        }
    }

    #region Bind Table

    [System.Web.Services.WebMethod]
    public static UserDetails GetDetails(string ScanCode)
    {
        UserDetails details = new UserDetails();
        try
        {
            SqlParameter[] param = new SqlParameter[]
           {
                new SqlParameter("@Min", ""),
                new SqlParameter("@Max", "") ,
                new SqlParameter("@Userid", ""),
                new SqlParameter("@Tid", 0),
                new SqlParameter("@QRCode", ScanCode),
                new SqlParameter("@IsScaned", -1)
           };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetTourProductWiseList");
            details.Error = "Error";
            while (dr.Read())
            {
                details.Error = "";
                details.AppMstRegNo = dr["AppMstRegNo"].ToString();
                details.AppMstFName = dr["AppMstFName"].ToString();
                details.TourName = dr["TourName"].ToString();
                details.QRCode = dr["QRCode"].ToString();
                details.Qualify_date = dr["Qualify_date"].ToString();
                details.Scan_date = dr["Scan_date"].ToString();
                details.IsScaned = dr["IsScaned"].ToString();
                details.Remark = dr["Remark"].ToString();
                details.UpdateBy = dr["UpdateBy"].ToString();

                details.imagename = dr["imagename"].ToString();
                details.PanImage = dr["PanImage"].ToString();
                details.AadharFront = dr["AadharFront"].ToString();
                details.AadharBack = dr["AadharBack"].ToString();

            }
        }
        catch (Exception er) { }
        return details;
    }


    [System.Web.Services.WebMethod]
    public static string Save(string ScanCode, string Remark)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@ScanCode", ScanCode),
                new SqlParameter("@Remark", Remark),
                new SqlParameter("@UpdateBy", HttpContext.Current.Session["admin"].ToString())
            };
            int result = objDu.ExecuteSql(param, @"update tbl_tourmst set Scan_date=Getdate(), IsScaned=1, Remark=@Remark, UpdateBy=@UpdateBy 
            where isnull(IsScaned,0)=0 and QRCode=@ScanCode");
            objResult = result.ToString();
        }
        catch (Exception er) { objResult = er.Message; }
        return objResult;
    }



    public class UserDetails
    {
        public String Error { get; set; }
        public String AppMstRegNo { get; set; }
        public String AppMstFName { get; set; }
        public String TourName { get; set; }
        public String QRCode { get; set; }
        public String Qualify_date { get; set; }
        public String Scan_date { get; set; }
        public String IsScaned { get; set; }
        public String Remark { get; set; }
        public String UpdateBy { get; set; }

        public String imagename { get; set; }
        public String PanImage { get; set; }
        public String AadharFront { get; set; }
        public String AadharBack { get; set; }
    }


    //public void BindQRCode()
    //{
    //    DataUtility objDu = new DataUtility();
    //    DataTable dt = objDu.GetDataTable("Select QRCode from tbl_tourmst where QRCode is not null");
    //    foreach (DataRow dr in dt.Rows)
    //        divProductcode.InnerText += dr["QRCode"].ToString() + ",";
    //}



    #endregion
}