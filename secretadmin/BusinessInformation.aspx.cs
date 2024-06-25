using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

public partial class BusinessInformation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        else
        {
            Months();
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string Userid, string Month)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Userid", Userid),
                new SqlParameter("@Month", Month)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetBusinessInformationAdmin");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                data.Month_Encode = objutil.base64Encode(dr["Month"].ToString());
                data.BackGroundImg = dr["BackGroundImg"].ToString();
                data.appmstregno = dr["appmstregno"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.District = dr["District"].ToString();
                data.State = dr["State"].ToString();
                data.imagename = dr["imagename"].ToString();
                data.Month = dr["Month"].ToString();
                data.MatchingIncome = dr["MatchingIncome"].ToString();
                data.TopperFund = dr["TopperFund"].ToString();
                data.RepurchaseIncome = dr["RepurchaseIncome"].ToString();
                data.AnnualRoyalty = dr["AnnualRoyalty"].ToString();
                data.TotalAmount = dr["TotalAmount"].ToString();
                
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string BackGroundImg { get; set; }
        public string Month_Encode { get; set; }
        public string Month { get; set; }
        public string appmstregno { get; set; }
        public string UserName { get; set; }
        public string District { get; set; }
        public string State { get; set; }
        public string imagename { get; set; }
        
        public string MatchingIncome { get; set; }
        public string TopperFund { get; set; }
        public string RepurchaseIncome { get; set; }
        public string AnnualRoyalty { get; set; }
        public string TotalAmount { get; set; }

    }


    public void Months()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select payoutno, Dates=Cast(DateName(Month, paytodate) as nvarchar(3)) + '-' + RIGHT(DateName(Year, paytodate),2) from repayoutdate order by payoutno desc");
        if (dt.Rows.Count > 0)
        {
            ddlDateRange.Items.Clear();
            ddlDateRange.DataSource = dt;
            ddlDateRange.DataTextField = "Dates";
            ddlDateRange.DataValueField = "Dates";
            ddlDateRange.DataBind();
        }
        else
        {
            ddlDateRange.Items.Insert(0, new System.Web.UI.WebControls.ListItem("No Payout", "0"));
        }
    }

    #endregion

 
}