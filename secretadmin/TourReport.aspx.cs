using System.Web.UI;
using System.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;
using System.Web;

public partial class secretadmin_TourReport : Page
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
            Response.Redirect("logout.aspx");
        }

        if (!Page.IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddMonths(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            BindTour();
        }
    }


    #region Bind Table

    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string Regno, string Tid, string QRCode, string IsScaned)
    {

        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
           {
                new SqlParameter("@Min", min),
                new SqlParameter("@Max", max) ,
                new SqlParameter("@Userid", Regno),
                new SqlParameter("@Tid", Tid),
                new SqlParameter("@QRCode", QRCode),
                new SqlParameter("@IsScaned", IsScaned)
           };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetTourProductWiseList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                data.AppMstRegNo = dr["AppMstRegNo"].ToString();
                data.AppMstFName = dr["AppMstFName"].ToString();
                data.TourName = dr["TourName"].ToString();
                data.QRCode = dr["QRCode"].ToString();
                data.Qualify_date = dr["Qualify_date"].ToString();
                data.Scan_date = dr["Scan_date"].ToString();
                data.IsScaned = dr["IsScaned"].ToString();
                data.Remark = dr["Remark"].ToString();
                data.UpdateBy = dr["UpdateBy"].ToString();
                data.Id = dr["Id"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }

    public class UserDetails
    {
        public String AppMstRegNo { get; set; }
        public String AppMstFName { get; set; }
        public String TourName { get; set; }
        public String QRCode { get; set; }
        public String Qualify_date { get; set; }
        public String Scan_date { get; set; }
        public String IsScaned { get; set; }
        public String Remark { get; set; }
        public String UpdateBy { get; set; }
        public String Id { get; set; }
    }

    public void BindTour()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Tid, TourName=DisplayName +' '+ Convert(nvarchar(10), StartDate, 103)+' To '+ Convert(nvarchar(10), ExpDate, 103)+' (REQD: '+Cast(Cast(Condition as int) as nvarchar(10))+') ' from Tourmst Where Pack_Rep in(5,6)");
        if (dt.Rows.Count > 0)
        {
            ddl_Tour.Items.Clear();
            ddl_Tour.DataSource = dt;
            ddl_Tour.DataTextField = "TourName";
            ddl_Tour.DataValueField = "Tid";
            ddl_Tour.DataBind();
            ddl_Tour.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
        else
        {
            ddl_Tour.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
    }


    [WebMethod]
    public static string Reset(string Id)
    {
        String Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Id", Id), new SqlParameter("@UpdateBy", HttpContext.Current.Session["admin"].ToString()) };
            objDu.ExecuteSql(param, "update tbl_tourmst set Scan_date=null, IsScaned=null, Remark=null, UpdateBy=@UpdateBy where Id=@Id");
            Result = "1";
        }
        catch (Exception er) { Result = "0"; }
        return Result;
    }


    #endregion

}