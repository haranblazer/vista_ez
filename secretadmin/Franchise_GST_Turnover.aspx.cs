using System;
using System.Collections.Generic; 
using System.Data.SqlClient;

public partial class secretadmin_Franchise_GST_Turnover : System.Web.UI.Page
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
            DateTime CurrentDate = DateTime.Now.AddYears(-1);
            if (CurrentDate.Month >= 4)//4 is the first month of the financial year.
            {
                txtFromDate.Text = new DateTime(CurrentDate.Year, 4, 1).ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = new DateTime(CurrentDate.Year + 1, 4, 1).AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            }
            else
            {
                txtFromDate.Text = new DateTime(CurrentDate.Year - 1, 4, 1).ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = new DateTime(CurrentDate.Year, 4, 1).AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            }
            //txtFromDate.Text = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            //txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");
        }
    }




    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string Userid)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@From", min),
                new SqlParameter("@To", max),
                new SqlParameter("@Franchiseid", Userid) 
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "sp_Franchise_GST_Turnover_Report");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
               
                data.FranchiseID = dr["FranchiseID"].ToString();
                data.FName = dr["FName"].ToString();
                data.Month = dr["Month"].ToString();
                data.PurchaseAmount = dr["PurchaseAmount"].ToString();
                data.CommissionAmount = dr["CommissionAmount"].ToString();
                data.GSTTurnover = dr["GSTTurnover"].ToString();
                
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string FranchiseID { get; set; }
        public string FName { get; set; }
        public string Month { get; set; }
        public string PurchaseAmount { get; set; }
        public string CommissionAmount { get; set; }
        public string GSTTurnover { get; set; } 
    }
     
    #endregion
}