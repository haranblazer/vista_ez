using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;

public partial class ProductwisePendingPO : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("Logout.aspx");

    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string Status)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            { new SqlParameter("@franchiseid", HttpContext.Current.Session["franchiseid"].ToString()),
            new SqlParameter("@Status", Status)};

            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "sp_Productwise_Pending_PO");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.ProductName = dr["ProductName"].ToString();
                data.ProductCode = dr["ProductCode"].ToString();
                data.QtyOrdered = dr["QtyOrdered"].ToString();
                data.QtyReced = dr["QtyReced"].ToString();
                data.QtyPending = dr["QtyPending"].ToString();
                data.PONumber = dr["PONumber"].ToString();
                data.PODate = dr["PODate"].ToString();
                data.V_regno = dr["V_regno"].ToString();
                data.VendorName = dr["VendorName"].ToString();
                data.Status = dr["Status"].ToString();
                data.Srno = dr["Srno"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }

    
    public class UserDetails
    {
        public string ProductName { get; set; }
        public string ProductCode { get; set; }
        public string QtyOrdered { get; set; }
        public string QtyReced { get; set; }
        public string QtyPending { get; set; }
        public string PONumber { get; set; }
        public string PODate { get; set; }
        public string V_regno { get; set; }
        public string VendorName { get; set; }
        public string Status { get; set; }
        public string Srno { get; set; }

    }




    [System.Web.Services.WebMethod]
    public static string UpdateStatus(string srno)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@srno", srno) };
            objDu.ExecuteSql(param, "update FranPurchaseOrder set Status=(Case when isnull(Status,0)=0 then 1 else 0 end) where srno=@srno");
            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }



    #endregion
}