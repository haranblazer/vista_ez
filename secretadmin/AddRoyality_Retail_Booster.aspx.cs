using System;
using System.Collections.Generic; 
using System.Data.SqlClient; 

public partial class AddRoyality_Retail_Booster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
            Response.Redirect("adminLog.aspx", false);

    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReader(@"Select MId, StartDate = convert(nvarchar, StartDate, 103), EndDate = convert(nvarchar, EndDate, 103),
            BV_Point, MaxRoyalty, RoyaltyType = isnull(RoyaltyType, 0), IsActive from LoyaltyMonthly_Retail_Booster_Slab order by MId desc");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.MId = dr["MId"].ToString();
                data.StartDate = dr["StartDate"].ToString();
                data.EndDate = dr["EndDate"].ToString();
                data.BV_Point = dr["BV_Point"].ToString();
                data.MaxRoyalty = dr["MaxRoyalty"].ToString();
                data.RoyaltyType = dr["RoyaltyType"].ToString();
                data.IsActive = dr["IsActive"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string MId { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string BV_Point { get; set; }
        public string MaxRoyalty { get; set; }
        public string RoyaltyType { get; set; }
        public string IsActive { get; set; }

    }


    [System.Web.Services.WebMethod]
    public static string ACTV_DEACT(string MId)
    {
        String Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MId", MId) };
            objDu.ExecuteSql(param, "Update LoyaltyMonthly_Retail_Booster_Slab set IsActive=(Case when isnull(IsActive,0)=0 then 1 else 0 end) where Mid=@MId");

            Result = "1";
        }
        catch (Exception er) { Result = "0"; }
        return Result;
    }
    #endregion
}
