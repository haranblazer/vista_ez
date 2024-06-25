using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;

public partial class secretadmin_RunTour : System.Web.UI.Page
{
    public static string MasterKey = "", From = "", To = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("logout.aspx");
            }
            if (!IsPostBack)
            {
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["Key"] != null)
                    {
                        MasterKey = Request.QueryString["Key"].ToString();
                        try
                        {
                            if (Request.QueryString["From"].ToString().Length > 0)
                            {
                                String[] Date = Request.QueryString["From"].ToString().Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                                From = Date[1] + "/" + Date[0] + "/" + Date[2];
                            }
                            if (Request.QueryString["To"].ToString().Length > 0)
                            {
                                String[] Date = Request.QueryString["To"].ToString().Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                                To = Date[1] + "/" + Date[0] + "/" + Date[2];
                            }
                        }
                        catch
                        {
                            utility.MessageBox(this, "Invalid date entry.!!");
                            return;
                        }


                        if (MasterKey == "SEC_INVWISE")
                        {
                            lbl_ReportName.Text = "Invoice Wise ";
                        }
                        if (MasterKey == "SEC_DEPOWISE")
                        {
                            lbl_ReportName.Text = "Depo Wise ";
                            txt_InvNo.Visible = false;
                            txt_UserId.Visible = false;
                            txt_UserName.Visible = false;
                            Button1.Visible = false;
                        }
                        if (MasterKey == "SEC_BUYERWISE")
                        {
                            txt_InvNo.Visible = false;
                            lbl_ReportName.Text = "Buyer Wise ";
                        }
                    }
                }
            }
        }
        catch (Exception er)
        {

        }

    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string InvNo, string UserId, string UserName)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
            new SqlParameter("@MasterKey", MasterKey),
            new SqlParameter("@Adminid", HttpContext.Current.Session["admin"].ToString()),
            new SqlParameter("@From", From),
            new SqlParameter("@To", To),
            new SqlParameter("@invoiceno", InvNo),
            new SqlParameter("@Userid", UserId),
            new SqlParameter("@UserName", UserName)
            };
            DataUtility obj_du = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetDashboardDetails");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                if (MasterKey == "SEC_INVWISE")
                {
                    data.Invoice_No = dr["Invoice No"].ToString();
                    data.Invoice_Date = dr["Invoice Date"].ToString();
                    data.Seller_UserId = dr["Seller UserId"].ToString();
                    data.Seller_Name = dr["Seller Name"].ToString();
                    data.Buyer_UserId = dr["Buyer UserId"].ToString();
                    data.Buyer_Name = dr["Buyer Name"].ToString();
                    data.Buyer_District = dr["Buyer District"].ToString();
                    data.Buyer_State = dr["Buyer State"].ToString();
                    data.NoOFProduct = dr["NoOFProduct"].ToString();
                    data.Billed_Qty = dr["Billed_Qty"].ToString();
                    data.DP_Value = dr["DP Value"].ToString();
                    data.Total_Amount = dr["Total Amount"].ToString();
                    data.RPV = dr["RPV"].ToString();
                    data.TPV = dr["TPV"].ToString();
                    data.PayMode = dr["PayMode"].ToString();
                }
                if (MasterKey == "SEC_DEPOWISE")
                {
                    data.Seller_UserId = dr["Seller UserId"].ToString();
                    data.Seller_Name = dr["Seller Name"].ToString();
                    data.Seller_District = dr["Seller District"].ToString();
                    data.Seller_State = dr["Seller State"].ToString();
                    data.Total_Amount = dr["Total Amount"].ToString();
                }
                if (MasterKey == "SEC_BUYERWISE")
                {
                    data.Buyer_UserId = dr["Buyer UserId"].ToString();
                    data.Buyer_Name = dr["Buyer Name"].ToString();
                    data.Buyer_District = dr["Buyer District"].ToString();
                    data.Buyer_State = dr["Buyer State"].ToString();
                    data.Total_Amount = dr["Total Amount"].ToString();
                }

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Invoice_No { get; set; }
        public string Invoice_Date { get; set; }
        public string Seller_UserId { get; set; }
        public string Seller_Name { get; set; }
        public string Seller_District { get; set; }
        public string Seller_State { get; set; }
        public string Buyer_UserId { get; set; }
        public string Buyer_Name { get; set; }
        public string Buyer_District { get; set; }
        public string Buyer_State { get; set; }
        public string NoOFProduct { get; set; }
        public string Billed_Qty { get; set; }
        public string DP_Value { get; set; }
        public string Total_Amount { get; set; }
        public string RPV { get; set; }
        public string TPV { get; set; }
        public string PayMode { get; set; }

    }
    #endregion

}