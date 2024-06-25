using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

public partial class secretadmin_TourProductList : System.Web.UI.Page
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
            txtFromDate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");
            BindRank();
            BindTour(); 
        }
    }




    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string Userid, string Tid, string RankId, string Pack_rep)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@Userid", Userid),
                new SqlParameter("@Tid", Tid),
                new SqlParameter("@Pack_rep", Pack_rep),
                new SqlParameter("@RankId", RankId),
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetUserTourList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.BackGroundImg = dr["BackGroundImg"].ToString();
                data.Date = dr["Date"].ToString();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.MobileNumber = dr["MobileNumber"].ToString();
                data.GenerationPIN = dr["GenerationPIN"].ToString();
                data.District = dr["District"].ToString();
                data.Satate = dr["Satate"].ToString();
                data.ProductCondition = dr["ProductCondition"].ToString();
                data.GPV = dr["GPV"].ToString();
                data.TourName = dr["TourName"].ToString();
                data.imagename = dr["imagename"].ToString();
                data.TourType = dr["TourType"].ToString();
                data.Month = dr["Month"].ToString();
                data.DisplayName = dr["DisplayName"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
         public string DisplayName { get; set; }
        public string BackGroundImg { get; set; }
        public string Date { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string MobileNumber { get; set; }
        public string GenerationPIN { get; set; }
        public string District { get; set; }
        public string Satate { get; set; }
        public string ProductCondition { get; set; }
        public string GPV { get; set; }
        public string TourName { get; set; }
        public string imagename { get; set; }

        public string TourType { get; set; }
        public string Month { get; set; }

    }


    public void BindTour()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Tid, TourName=TourName +' '+ Convert(nvarchar(10), StartDate, 103)+' To '+ Convert(nvarchar(10), ExpDate, 103)+' (REQD: '+Cast(Cast(Condition as int) as nvarchar(10))+') ' from Tourmst Where Pack_Rep in(5,6)");
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

    public void BindRank()
    {

        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Rankid, RankName from RePurchase_Slab order by Rankid");
        if (dt.Rows.Count > 0)
        {
            ddl_Rank.Items.Clear();
            ddl_Rank.DataSource = dt;
            ddl_Rank.DataTextField = "RankName";
            ddl_Rank.DataValueField = "Rankid";
            ddl_Rank.DataBind();
            ddl_Rank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
        else
        {
            ddl_Rank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
    }

    #endregion
 
}