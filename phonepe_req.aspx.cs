using System;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Net;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Data;

public partial class phonepe_req : System.Web.UI.Page
{
    protected async void Page_Load(object sender, EventArgs e)
    {
        string orderId = "", OrderNo = "";
        string returnUrl =method.WEB_URL+ "/phonepe_resp?";
        string merchantId = method.PhonePe_merchantId;
        string saltKey = method.PhonePe_Saltkey;
        string amount = "";
        string phoneNumber = "";
        string url = method.PhonePe_Base_Url + "/pg/v1/pay";

        if (!IsPostBack)
        {
             if (Request.QueryString["id"] != null)
           {
                try
                {
                    OrderNo = secure.Decrypt(Request.QueryString["id"].ToString());

                    SqlParameter[] param = new SqlParameter[]
                    { new SqlParameter("@OrderNo", OrderNo) };

                    DataUtility Dutil = new DataUtility();
                    DataTable dt = Dutil.GetDataTable(param, @"Select o.Amount, o.Srno, a.AppMstMobile, a.appmstregno 
                    from OrderMst o, Appmst a where o.Appmstid=a.Appmstid and o.OrderNo=@OrderNo");
                    if (dt.Rows.Count > 0)
                    {
                        orderId = dt.Rows[0]["Srno"].ToString();
                        amount = dt.Rows[0]["Amount"].ToString();
                        phoneNumber = dt.Rows[0]["AppMstMobile"].ToString();
                       // if (dt.Rows[0]["AppMstMobile"].ToString() == "9650443548")
                           // amount = "1";

                        returnUrl = returnUrl + orderId;
                        dynamic payload = new System.Dynamic.ExpandoObject();
                        payload.merchantId = merchantId;
                        payload.merchantTransactionId = orderId;
                        payload.merchantUserId = "MUID" + DateTime.Now.Ticks;
                        payload.amount = Int32.Parse(amount) * 100;
                        payload.redirectUrl = returnUrl;
                        payload.callbackUrl = returnUrl;
                        payload.redirectMode = "REDIRECT";
                        payload.mobileNumber = phoneNumber;
                        dynamic paymentInstrument = new System.Dynamic.ExpandoObject();
                        paymentInstrument.type = "PAY_PAGE";
                        payload.paymentInstrument = paymentInstrument;
                        string jsonPayload = JsonConvert.SerializeObject(payload);
                        string base64Payload = Convert.ToBase64String(Encoding.UTF8.GetBytes(jsonPayload));

                        string sign = base64Payload + "/pg/v1/pay" + saltKey;
                        string hashedSign = ComputeSha256Hash(sign);
                        string xVerify = hashedSign + "###1";
                        var paymentUrl = "";
                        using (var client = new WebClient())
                        {
                            client.Headers.Add("x-verify", xVerify);
                            client.Headers[HttpRequestHeader.ContentType] = "application/json";
                            var requestData = "{\"request\":\"" + base64Payload + "\"}";

                            System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
                            var response = client.UploadString(url, requestData);
                            var responsePayload = JsonConvert.DeserializeObject<PhonePeResponse>(response);
                            paymentUrl = responsePayload.data.instrumentResponse.redirectInfo.url;
                            Response.Redirect(paymentUrl, false);
                        }
                    }
                }
                catch (Exception ex) { utility.MessageBox(this, ex.Message); }

             }
        }
    }


    public static string ComputeSha256Hash(string payload)
    {
        // Convert the input string to a byte array and compute the hash.
        using (SHA256 sha256Hash = SHA256.Create())
        {
            byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(payload));

            // Convert the byte array to a hexadecimal string.
            StringBuilder builder = new StringBuilder();
            for (int i = 0; i < bytes.Length; i++)
            {
                builder.Append(bytes[i].ToString("x2"));
            }
            return builder.ToString();
        }
    }


    public class PhonePeResponse
    {
        public data data { get; set; }
    }
    public class data
    {
        public instrumentResponse instrumentResponse { get; set; }
    }

    public class instrumentResponse
    {
        public redirectInfo redirectInfo { get; set; }
    }

    public class redirectInfo
    {
        public string url { get; set; }
    }


}