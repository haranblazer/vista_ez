using System;
using System.Data; 
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections.Generic;

public partial class user_GroupSales : System.Web.UI.Page
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
            GetRank();
        }

    }




    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string MemberType, string Rank, string Userid, string UpDown)
    { 
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@regno", Userid),
                 new SqlParameter("@rank", Rank),
                 new SqlParameter("@paid", MemberType),
                 new SqlParameter("@UpDown", UpDown)
            };
            DataUtility objDu = new DataUtility(); 
            DataTable dt = objDu.GetDataTableSP(param, "groupline");
            foreach (DataRow dr in dt.Rows)
            {
                UserDetails data = new UserDetails();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.SponsorId = dr["SponsorId"].ToString();
                data.SponsorName = dr["SponsorName"].ToString();
                data.User_Mobile = dr["User_Mobile"].ToString();
                data.District = dr["District"].ToString();
                data.State = dr["State"].ToString();
                data.IsPaid = dr["IsPaid"].ToString();
                data.TopperStatus = dr["TopperStatus"].ToString();
                data.IDStatus = dr["IDStatus"].ToString();
                data.PBV = dr["PBV"].ToString();

                data.GBV = dr["GBV"].ToString();
                data.TPV = dr["TPV"].ToString();
                data.CumulativeGBVPV = dr["CumulativeGBVPV"].ToString();
                data.RankPer = dr["RankPer"].ToString();
                data.RankName = dr["RankName"].ToString();

                details.Add(data);
            }

            //SqlDataReader dr = objDu.GetDataReaderSP(param, "groupline");
            //int i = 0;
            //while (dr.Read())
            //{
            //    UserDetails data = new UserDetails();
            //    data.UserId = dr["UserId"].ToString();
            //    data.UserName = dr["UserName"].ToString();
            //    data.SponsorId = dr["SponsorId"].ToString();
            //    data.SponsorName = dr["SponsorName"].ToString();
            //    data.User_Mobile = dr["User_Mobile"].ToString();
            //    data.District = dr["District"].ToString();
            //    data.State = dr["State"].ToString();
            //    data.IsPaid = dr["IsPaid"].ToString();
            //    data.TopperStatus = dr["TopperStatus"].ToString();
            //    data.IDStatus = dr["IDStatus"].ToString();
            //    data.PBV = dr["PBV"].ToString();

            //    data.GBV = dr["GBV"].ToString();
            //    data.TPV = dr["TPV"].ToString();
            //    data.CumulativeGBVPV = dr["CumulativeGBVPV"].ToString();
            //    data.RankPer = dr["RankPer"].ToString();
            //    data.RankName = dr["RankName"].ToString();
            //    i= i+1;
            //    if(i >= 500)
            //    {
            //        string rr = "";
            //    }
            //    details.Add(data);
            //}
             
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string UserId { get; set; } = "";
        public string UserName { get; set; } = "";
        public string SponsorId { get; set; } = "";
        public string SponsorName { get; set; } = "";
        public string User_Mobile { get; set; } = "";
        public string District { get; set; } = "";
        public string State { get; set; } = "";
        public string IsPaid { get; set; } = "";
        public string TopperStatus { get; set; } = "";
        public string IDStatus { get; set; } = "";
        public string PBV { get; set; } = "";

        public string GBV { get; set; } = "";
        public string TPV { get; set; } = "";
        public string CumulativeGBVPV { get; set; } = "";
        public string RankPer { get; set; } = "";
        public string RankName { get; set; } = "";

    }

    private void GetRank()
    {
        DataUtility objDu = new DataUtility();

        DataTable dt = objDu.GetDataTable("Select Rankid, RankName=RankName +' - '+ Cast(UserPercent as varchar(50))+' %' from RePurchase_Slab where Rankid>=5");
        ddl_Rank.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddl_Rank.DataSource = dt;
            ddl_Rank.DataTextField = "RankName";
            ddl_Rank.DataValueField = "Rankid";
            ddl_Rank.DataBind();
            ddl_Rank.Items.Insert(0, new ListItem("Direct", "0"));
        }
        else
        {
            ddl_Rank.Items.Insert(0, new ListItem("Direct", "0"));
        }
    }
    #endregion

     

}
