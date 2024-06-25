using System;
using System.Data; 
using System.Data.SqlClient;
using System.Collections.Generic;

public partial class LegWiseGeneration : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Convert.ToString(Session["admintype"]) == "sa")
            utility.CheckSuperAdminLogin();
        else if (Convert.ToString(Session["admintype"]) == "a")
            utility.CheckAdminLogin();
        else
            Response.Redirect("logout.aspx");

        if (!IsPostBack)
        {
            Bind_Month();
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string Userid, string Months, string Typ)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {

            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@Userid", Userid),
                   new SqlParameter("@Months", Months),
                   new SqlParameter("@Typ", Typ)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetLegWiseGeneration");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Userid = dr["Userid"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.RPV_Count1 = dr["RPV_Count1"].ToString();
                data.PBVAmt = dr["PBVAmt"].ToString();
                data.AppMstState = dr["AppMstState"].ToString();
                data.AppMstMobile = dr["AppMstMobile"].ToString();
                data.distt = dr["distt"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Userid { get; set; }
        public string UserName { get; set; }
        public string AppMstState { get; set; }
        public string AppMstMobile { get; set; }
        public string distt { get; set; }
        public string RPV_Count1 { get; set; }
        public string PBVAmt { get; set; }

    }



    private void Bind_Month()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(@"Select [Month] From(Select SN=999999, [Month]=Cast(DateName(Month, getdate()) as nvarchar(3)) + '-' + RIGHT(DateName(Year, getdate()),2) Union All Select SN=PayoutNo, [Month]=Cast(DateName(Month, PayToDate) as nvarchar(3)) + '-' + RIGHT(DateName(Year, PayToDate),2)  from RePayoutdate )t order by SN desc");
        ddl_Month.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddl_Month.DataSource = dt;
            ddl_Month.DataTextField = "Month";
            ddl_Month.DataValueField = "Month";
            ddl_Month.DataBind();
        }
    }


    #endregion

}
