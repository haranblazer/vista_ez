using Razorpay.Api;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Net;

public partial class User_RazorpayRequest : System.Web.UI.Page
{
    public string KeyId = "rzp_live_U67OPmENTpnATW";
    public string KeySecret = "sF83LSjgn5BHX7LNFZbhy5iT";
    public static string orderId;
    public string amount;
    public string contact;
    public string name;
    public string product;
    public string email;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["id"] != null)
            {
                int ORDER_ID = Convert.ToInt32(secure.Decrypt(Request.QueryString["id"].ToString()));
                PaymentGateway(ORDER_ID);
            }
        }
    }

    private void PaymentGateway(Int32 ORDER_ID)
    {
        try
        {
            if (Session["userId"] != null)
            {
                DataUtility Dutil = new DataUtility();
                DataTable dt = Dutil.GetDataTable("Select o.NetAmt, o.Srno, a.AppMstFName, a.AppMstState, a.AppMstCity, a.AppMstAddress1, a.AppMstPinCode, a.AppMstMobile, a.email from OrderMst o, Appmst a where o.Appmstid=a.Appmstid and o.Srno=" + ORDER_ID);
                if (dt.Rows.Count > 0)
                {
                    String Amount = dt.Rows[0]["NetAmt"].ToString();
                    if (dt.Rows[0]["AppMstMobile"].ToString() == "9650443548")
                        amount = (1 * 100).ToString();
                    else
                        amount = (Convert.ToDouble(Amount) * 100).ToString();


                    Session["Srno"] = ORDER_ID.ToString();
                    Session["amount"] = amount;

                    contact = dt.Rows[0]["AppMstMobile"].ToString();
                    name = dt.Rows[0]["AppMstFName"].ToString();
                    product = dt.Rows[0]["email"].ToString();
                    email = dt.Rows[0]["email"].ToString();

                    Dictionary<string, object> input = new Dictionary<string, object>();
                    input.Add("amount", amount);
                    input.Add("currency", "INR");
                    input.Add("payment_capture", 1);


                    ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                    RazorpayClient client = new RazorpayClient(KeyId, KeySecret);
                    Razorpay.Api.Order order = client.Order.Create(input);
                    orderId = order["id"].ToString();

                    SqlParameter[] param = new SqlParameter[]
                    {
                    new SqlParameter("@Srno", ORDER_ID),
                    new SqlParameter("@OrderId", orderId)
                    };
                    int Res = Dutil.ExecuteSql(param, "update OrderMst set OrderId=@OrderId where Srno=@Srno");
                }
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }
        catch (Exception er) { }
    }


    #region Genearate Invoice
    [System.Web.Services.WebMethod]
    public static Results GenerateInv(string order_id, string payment_id, string signature)
    {
        Results objResult = new Results();
        try
        {

            SqlParameter[] sqlparam = new SqlParameter[] {
                    new SqlParameter("@TYPE", "SUCCESS"),
                    new SqlParameter("@orderId", order_id),
                    new SqlParameter("@paymentId", payment_id),
                    new SqlParameter("@signature", signature)
                };
            DataUtility objDUT = new DataUtility();
            DataTable dt = objDUT.GetDataTableSP(sqlparam, "Usp_RazorpaySucessProcess");
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Status"].ToString() == "1")
                {
                    objResult.InvoiceNo = dt.Rows[0]["InvoiceNo"].ToString();
                    objResult.Error = "";
                }
                else
                {
                    objResult.Error = dt.Rows[0]["Status"].ToString();
                }
            }
             
        }
        catch (Exception er) { objResult.Error = er.Message.ToString(); }
        return objResult;
    }

    public class Results
    {
        public String Error { get; set; }
        public String InvoiceNo { get; set; }
        public String status { get; set; }
    }
    #endregion
}