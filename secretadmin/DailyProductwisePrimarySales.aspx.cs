using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class secretadmin_DailyProductwisePrimarySales : System.Web.UI.Page
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
            ddl_UserType.Items.Insert(0, new ListItem(method.Associate, "ASSO"));

            txtFromDate.Text = DateTime.Now.AddDays(-0).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string From, string To, string UserType)
    { 
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[] { 
                new SqlParameter("@From", From), 
                new SqlParameter("@To", To) ,
                 new SqlParameter("@UserType", UserType),
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "sp_DailyProductwisePrimarySales");
            while (dr.Read())
            {
                
                   UserDetails data = new UserDetails();
                data.UserType = dr["UserType"].ToString();
                data.InvoiceNo = dr["InvoiceNo"].ToString(); 
                data.InvoiceDate = dr["InvoiceDate"].ToString();
                data.SellerID = dr["SellerID"].ToString();
                data.SellerName = dr["SellerName"].ToString();
                data.BuyerID = dr["BuyerID"].ToString();
                data.BuyerName = dr["BuyerName"].ToString();
                data.ProductCode = dr["ProductCode"].ToString();
                data.ProductName = dr["ProductName"].ToString();
                data.HSNCode = dr["HSNCode"].ToString();
                data.Qty = dr["Qty"].ToString();
                data.DPValue = dr["DPValue"].ToString();
                data.SGST = dr["SGST"].ToString();
                data.CGST = dr["CGST"].ToString();
                data.IGST = dr["IGST"].ToString();
                data.DPwithTax = dr["DPwithTax"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
         public string UserType { get; set; }
        public string InvoiceNo { get; set; }
        public string InvoiceDate { get; set; }
        public string SellerID { get; set; }
        public string SellerName { get; set; }
        public string BuyerID { get; set; }
        public string BuyerName { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string HSNCode { get; set; }
        public string Qty { get; set; }
        public string DPValue { get; set; }
        public string SGST { get; set; }
        public string CGST { get; set; }
        public string IGST { get; set; }
        public string DPwithTax { get; set; }
    }
     
    #endregion
}