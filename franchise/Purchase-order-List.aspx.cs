using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;

public partial class franchise_Purchase_order_List : System.Web.UI.Page
{
    //DataTable dt = null;
    //SqlConnection con = null;
    //SqlCommand com = null;
    //string regno = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("Logout.aspx");


        if (!IsPostBack)
        {
            DateTime now = DateTime.Now;
            var startDate = new DateTime(now.Year, now.Month, 1);

            txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");

        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string orderno, string min, string max)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SessionId", HttpContext.Current.Session["franchiseid"].ToString()),
                new SqlParameter("@orderno", orderno),
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Fran_PO_List");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.srno = dr["srno"].ToString();
                data.Status = dr["Status"].ToString();
                data.srno_Encript = objutil.base64Encode(dr["srno"].ToString());
                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.VenderName = dr["VenderName"].ToString();
                data.SessionId = dr["SessionId"].ToString();

                data.UserName = dr["UserName"].ToString();
                data.DeliverTo = dr["DeliverTo"].ToString();
                data.Gross = dr["Gross"].ToString();
                data.Discount = dr["Discount"].ToString();
                data.GST = dr["TotalTax"].ToString();
                data.NetAmt = dr["NetAmt"].ToString();
                data.BillDate = dr["BillDate"].ToString();
                data.DeliveryDate = dr["DeliveryDate"].ToString();
                data.SourceOfSupply = dr["SourceOfSupply"].ToString();
                data.DestinationOfSupply = dr["DestinationOfSupply"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string srno { get; set; }
        public string Status { get; set; }
        public string srno_Encript { get; set; }
        public string InvoiceNo { get; set; }
        public string VenderName { get; set; }
        public string SessionId { get; set; }
        public string UserName { get; set; }
        public string DeliverTo { get; set; }
        public string Gross { get; set; }
        public string GST { get; set; }
        public string Discount { get; set; }
        public string NetAmt { get; set; }
        public string BillDate { get; set; }
        public string DeliveryDate { get; set; }
        public string SourceOfSupply { get; set; }
        public string DestinationOfSupply { get; set; }
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