using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;

public partial class franchise_StockSummaryReport : System.Web.UI.Page
{
    public string IsCompany = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("~/Login.aspx");

        if (!IsPostBack)
        {
            DateTime now = DateTime.Now;
            var startDate = new DateTime(now.Year, now.Month, 1);

            txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            GetCompany();
        }
    }

    private void GetCompany()
    {
        SqlParameter[] param = new SqlParameter[]
        {  new SqlParameter("@FranchiseId", Session["franchiseid"].ToString()) };
        DataUtility objDu = new DataUtility();
        IsCompany = objDu.GetScaler(param, "Select Frantype from FranchiseMst where FranchiseId =@FranchiseId").ToString();
    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@regno", HttpContext.Current.Session["franchiseid"].ToString()),
                new SqlParameter("@Min", min),
                new SqlParameter("@Max", max),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "StockSummaryReport");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Pid_Encode = objutil.base64Encode(dr["Pid"].ToString());
                data.Mode12_Encode = objutil.base64Encode("12");
                data.Mode15_Encode = objutil.base64Encode("15");
                data.Mode19_Encode = objutil.base64Encode("19");
                data.Mode20_Encode = objutil.base64Encode("20");
                data.From_Encode = objutil.base64Encode(min);
                data.To_Encode = objutil.base64Encode(max);

                data.ProductCode = dr["ProductCode"].ToString();
                data.ProductName = dr["ProductName"].ToString();
                data.Opening_Qty = dr["Opening_Qty"].ToString();
                data.Purchase_Qty = dr["Purchase_Qty"].ToString();
                data.Purchase_Return = dr["Purchase_Return"].ToString();
                data.Sales_Qty = dr["Sales_Qty"].ToString();
                data.Sales_Return = dr["Sales_Return"].ToString();
                data.Closing_Qty = dr["Closing_Qty"].ToString();
                data.Redeem = dr["Redeem"].ToString();
                data.Replenish = dr["Replenish"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Pid_Encode { get; set; }
        public string Mode12_Encode { get; set; }
        public string Mode15_Encode { get; set; }
        public string Mode19_Encode { get; set; }
        public string Mode20_Encode { get; set; }
        public string From_Encode { get; set; }
        public string To_Encode { get; set; }

        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string Opening_Qty { get; set; }
        public string Purchase_Qty { get; set; }
        public string Purchase_Return { get; set; }
        public string Sales_Qty { get; set; }
        public string Sales_Return { get; set; }
        public string Closing_Qty { get; set; }
        public string Redeem { get; set; }
        public string Replenish { get; set; }
    }

    #endregion

}