using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;

public partial class secretadmin_FindSponsorRank : System.Web.UI.Page
{
    public string UserId = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["userId"] == null)
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {
                UserId = HttpContext.Current.Session["userId"].ToString();
                Bind_Month();
            }
        }
        catch
        {

        }

    }

 
    #region Bind Table

    [System.Web.Services.WebMethod]
    public static SponsorDetails[] GetSponsorData(string Months, string Sponsor, string SelfRPV, string GPV_RPV_Type, string D_GPV_RPV, string userid, string Typ)
    {
        List<SponsorDetails> details = new List<SponsorDetails>();

        DataTable dt = getdate(Months, Sponsor, SelfRPV, GPV_RPV_Type, D_GPV_RPV, userid, Typ);
        foreach (DataRow dr in dt.Rows)
        {
            SponsorDetails data = new SponsorDetails();
            data.UserId = dr["UserId"].ToString();
            data.UserName = dr["UserName"].ToString();
            data.Mobile = dr["Mobile"].ToString();
            data.UserState = dr["UserState"].ToString();
            data.District = dr["District"].ToString();
            data.SponsporId = dr["SponsporId"].ToString();
            data.SponsorName = dr["SponsorName"].ToString();
            data.RPV = dr["RPV"].ToString();
            data.GPV = dr["GPV"].ToString();
            data.RankName = dr["RankName"].ToString();
            data.NoOfSponsor = dr["NoOfSponsor"].ToString();
            data.DiamondID = dr["DiamondID"].ToString();
            data.DiamondName = dr["DiamondName"].ToString();
            details.Add(data);
        }
        return details.ToArray();
    }

    public class SponsorDetails
    {
        public String UserId { get; set; }
        public String UserName { get; set; }
        public String Mobile { get; set; }
        public String UserState { get; set; }
        public String District { get; set; }
        public String SponsporId { get; set; }
        public String SponsorName { get; set; }
        public String RPV { get; set; }
        public String GPV { get; set; }
        public String RankName { get; set; }
        public String NoOfSponsor { get; set; }
        public string DiamondID { get; set; }
        public string DiamondName { get; set; }
    }
    private void Bind_Month()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(@" Select Payoutno, [Month] From(
         Select Payoutno=99999, [Month]=Cast(DateName(Month, Getdate()) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Getdate()),2) 
         Union All 
         Select Payoutno, [Month]=Cast(DateName(Month, PayToDate-1) as nvarchar(3)) + '-' + RIGHT(DateName(Year, PayToDate-1),2)  from RePayoutDate
         ) t Order by t.Payoutno desc");
        if (dt.Rows.Count > 0)
        {
            ddl_Month.DataSource = dt;
            ddl_Month.DataTextField = "Month";
            ddl_Month.DataValueField = "Month";
            ddl_Month.DataBind();
        }
        else
        {
            ddl_Month.Items.Clear();
        }
    }


    static private DataTable getdate(string Months, string Sponsor, string SelfRPV, string GPV_RPV_Type, string D_GPV_RPV, string userid, string Typ)
    {
        SelfRPV = SelfRPV == "" ? "0" : SelfRPV;
        D_GPV_RPV = D_GPV_RPV == "" ? "0" : D_GPV_RPV;
        Sponsor = Sponsor == "" ? "0" : Sponsor;
        SqlParameter[] param = new SqlParameter[]
           {
          new SqlParameter("@Months", Months),
          new SqlParameter("@SelfRPV", SelfRPV),
          new SqlParameter("@GPV_RPV_Type", GPV_RPV_Type),
          new SqlParameter("@D_GPV_RPV", D_GPV_RPV),
          new SqlParameter("@NoOfSponsor", Sponsor),
          new SqlParameter("@Userid", userid),
          new SqlParameter("@Key", Typ)
           };
        DataUtility objDu = new DataUtility();
        return objDu.GetDataTableSP(param, "GetSponsorRank");
    }
    #endregion



}