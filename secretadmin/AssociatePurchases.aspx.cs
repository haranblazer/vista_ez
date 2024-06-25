using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;

public partial class secretadmin_AssociatePurchases : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin"] == null)
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {
                ddl_RPV_Rs.Items.Insert(0, new ListItem(method.PV, "RPV"));

                Bind_Month();
            }
        }
        catch
        {
        }
    }


    #region Bind Table

    [System.Web.Services.WebMethod]  
    public static SponsorDetails[] GetData(string Months, string Userid, string RPV_Rs, string Values)
    {
        List<SponsorDetails> details = new List<SponsorDetails>();
        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@Months", Months),
            new SqlParameter("@Userid", Userid),
            new SqlParameter("@RPV_Rs", RPV_Rs), 
            new SqlParameter("@Values", Values),
            new SqlParameter("@Adminid", HttpContext.Current.Session["admin"].ToString()),
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetAssociatePrchase"); 
        foreach (DataRow dr in dt.Rows)
        {
            SponsorDetails data = new SponsorDetails();
            data.UserId = dr["Appmstregno"].ToString();
            data.UserName = dr["Appmstfname"].ToString();
            data.Mobile = dr["AppmstMobile"].ToString();
            data.UserState = dr["appmststate"].ToString();
            data.District = dr["distt"].ToString();
            data.RankName = dr["RankName"].ToString();
            data.Amount = dr["Amount"].ToString();
            data.DiamondID = dr["DiamondID"].ToString();
            data.DiamondName = dr["DiamondName"].ToString();
            data.TotalBV = dr["TotalBV"].ToString();
            data.DOB = dr["DOB"].ToString();
            data.Gender = dr["Gender"].ToString();
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
        public string RankName { get; set; }
        public string Amount { get; set; }
        public string TotalBV { get; set; }
        public string DiamondName { get; set; }
        public string DiamondID { get; set; }
        public string DOB { get; set; }
        public string Gender { get; set; }
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

     
    #endregion
}