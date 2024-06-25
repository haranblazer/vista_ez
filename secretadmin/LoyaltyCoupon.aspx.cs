using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class secretadmin_LoyaltyCoupon : System.Web.UI.Page
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
            DateTime now = DateTime.Now;
            txtFromDate.Text = new DateTime(now.Year, now.Month, 1).ToString("dd/MM/yyyy").Replace("-", "/");

            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindInvoice(string min, string max, string Userid, string Coupon, string Status)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@min", min),
                   new SqlParameter("@max", max),
                   new SqlParameter("@RegNo", Userid),
                   new SqlParameter("@L_Counpon", Coupon),
                   new SqlParameter("@Isactive", Status),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "sp_GetLoyaltyCoupon");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                data.L_Counpon = dr["L_Counpon"].ToString();
                data.RegNo = dr["RegNo"].ToString();
                data.appmstfname = dr["appmstfname"].ToString();
                data.AppMstState = dr["AppMstState"].ToString();
                data.AppMstCity = dr["AppMstCity"].ToString();
                data.AppMstMobile = dr["AppMstMobile"].ToString();
                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.Doe = dr["Doe"].ToString();
                data.Isactive = dr["Isactive"].ToString();

                data.Cid = dr["Cid"].ToString();
                data.WinningItem = dr["WinningItem"].ToString();
                data.Remark = dr["Remark"].ToString();
                data.DispatchedDate = dr["DispatchedDate"].ToString();
                data.DispatchRemark = dr["DispatchRemark"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }



    public class UserDetails
    {

        public string L_Counpon { get; set; }
        public string RegNo { get; set; }
        public string appmstfname { get; set; }
        public string AppMstState { get; set; }
        public string AppMstCity { get; set; }
        public string AppMstMobile { get; set; }
        public string InvoiceNo { get; set; }
        public string Doe { get; set; }
        public string Isactive { get; set; }

        public string Cid { get; set; }
        public string WinningItem { get; set; }
        public string Remark { get; set; }
        public string DispatchedDate { get; set; }
        public string DispatchRemark { get; set; }
    }


    [System.Web.Services.WebMethod]
    public static string UpdateLuckyDraw(string Cid)
    {
        string Result = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Cid", Cid) };

            objDu.ExecuteSql(param, @"Update LoyaltyCoupon Set Isactive=(Case Isactive when 1 then 2 else 1 end) Where Cid=@Cid");
            Result = "1";
        }
        catch (Exception er) { }
        return Result;
    }


    [System.Web.Services.WebMethod]
    public static string Save(string Cid, string WinningItem, string Remark, string DispatchedDate, string DispatchRemark)
    {
        string Result = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Cid", Cid),
                new SqlParameter("@WinningItem", WinningItem),
                new SqlParameter("@Remark", Remark),
                new SqlParameter("@DispatchedDate", DispatchedDate),
                new SqlParameter("@DispatchRemark", DispatchRemark),
            };

            objDu.ExecuteSql(param, @"Update LoyaltyCoupon Set WinningItem=@WinningItem, 
            Remark=@Remark, DispatchedDate=Getdate(), DispatchRemark=@DispatchRemark Where Cid=@Cid");
            Result = "1";
        }
        catch (Exception er) { }
        return Result;
    }


    #endregion
}