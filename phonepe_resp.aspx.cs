using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Linq;
using System.Web.Services;
using System.Web;
using System.Security.Policy;

public partial class phonepe_resp : System.Web.UI.Page
{
    public string transactionId = "";
    string merchantId = method.PhonePe_merchantId;
    string saltKey = method.PhonePe_Saltkey;

    int timeLeft = 0, Sec = 0, TotalSec = 0, API_CALL_CNT = 0, i = 0, CNT = 0;

    Dictionary<int, int> obj = new Dictionary<int, int>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AddTime();
            CallFunction();
        }
    }

    private void CallFunction()
    {
        if (Request.QueryString.Count > 0)
        {
            string Url = Page.Request.Url.ToString();
            //string Url = Page.Request.Url.AbsolutePath;
            string[] UrlVal = Url.Split(new String[] { "?" }, StringSplitOptions.RemoveEmptyEntries);
            if (UrlVal.Length > 0)
            {
                var exists = UrlVal.ElementAtOrDefault(1) != null;
                if (exists)
                {
                    transactionId = UrlVal[1];

                    string sign = "/pg/v1/status/" + merchantId + "/" + transactionId + saltKey;
                    string hashedSign = ComputeSha256Hash(sign);
                    string xVerify = hashedSign + "###1";
                    string url = method.PhonePe_Base_Url + "/pg/v1/status/" + merchantId + "/" + transactionId;

                    using (var client = new WebClient())
                    {
                        System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
                        client.Headers.Add("X-VERIFY", xVerify);
                        client.Headers.Add("X-MERCHANT-ID", merchantId);
                        client.Headers[HttpRequestHeader.ContentType] = "application/json";


                        var response = client.DownloadString(url);
                        var result = JsonConvert.DeserializeObject<PhonePeResp>(response);
                        if (result != null)
                        {
                            if (result.code.ToString() == "PAYMENT_SUCCESS" || result.code.ToString() == "PAYMENT_ERROR")
                            {
                                string TYPE = result.code.ToString() == "PAYMENT_SUCCESS" ? "SUCCESS" : "ERROR";

                                Results db_result = new Results();
                                string amount = (Convert.ToDecimal(result.data.amount) / 100).ToString();
                                db_result = GenerateInv(TYPE, result.data.merchantTransactionId,
                                    result.data.transactionId, result.data.state, amount);

                                if (db_result.Error == "")
                                {
                                    var msg = "";
                                    msg += "<br> Response Code : " + result.data.responseCode;
                                    msg += "<br> TransactionId : " + result.data.transactionId;
                                    msg += "<br> State : " + result.data.state;
                                    msg += "<br> Amount : " + amount;
                                    
                                    msg += "<br> <br>";
                                    msg += GetUserDetail(result.data.merchantTransactionId) + " to download the invoice";
                                    msg += "<br> <br>";
                                    div_paymentRequest.Visible = false;
                                    div_paymentSuccess.InnerHtml = msg;
                                    div_containtSuccess.Visible = true;
                                }
                                else if (db_result.Error == "0")
                                {
                                    div_paymentRequest.Visible = false;
                                    div_paymentError.InnerHtml = "Payment failed.";
                                    div_containtError.Visible = true;
                                }
                                else if (db_result.Error != "")
                                {
                                    if (result.code.ToString() == "PAYMENT_SUCCESS")
                                    {
                                        var msg = "";
                                        msg += "<br> Response Code : " + result.data.responseCode;
                                        msg += "<br> TransactionId : " + result.data.transactionId;
                                        msg += "<br> State : " + result.data.state;
                                        msg += "<br> Amount : " + amount;

                                        msg += "<br> <br>";
                                        msg +=  GetUserDetail(result.data.merchantTransactionId) + " to download the invoice" ;
                                        msg += "<br> <br>";
                                        //msg += " <br><center style='color:blue;'> This order already generated an invoice.!! <center>   ";

                                        div_paymentRequest.Visible = false;
                                        div_paymentSuccess.InnerHtml = msg;
                                        div_containtSuccess.Visible = true;
                                    }
                                    else
                                    {
                                        div_paymentRequest.Visible = false;
                                        div_paymentError.InnerHtml = db_result.Error;
                                        div_containtError.Visible = true;
                                    }
                                }
                            }
                            else if (result.code.ToString() == "PAYMENT_PENDING")
                            {
                                API_CALL_CNT = Convert.ToInt32(Session["API_CALL_CNT"]);
                                Dictionary<int, int> obj = (Dictionary<int, int>)Session["DateCollections"];
                                timeLeft = obj[API_CALL_CNT];
                                API_CALL_CNT = API_CALL_CNT + 1;
                                Session["API_CALL_CNT"] = API_CALL_CNT;
                                Session["Sec"] = timeLeft;
                                Session["timeLeft"] = timeLeft;

                                if (timeLeft == 0)
                                {
                                    div_paymentRequest.Visible = false;
                                    div_paymentError.InnerHtml = "Payment failed.";
                                    div_containtError.Visible = true;
                                }
                            }
                            else
                            {
                                div_paymentRequest.Visible = false;
                                div_paymentError.InnerHtml = result.code.ToString();
                                div_containtError.Visible = true;
                            }
                        }
                    }
                }
            }
        }
    }


    private string GetUserDetail(string orderId)
    {
        string result = "";

        SqlParameter[] sqlparam = new SqlParameter[] {
            new SqlParameter("@orderId", orderId)
        };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTable(sqlparam, @"Select b.srno, b.InvoiceNo
        from OrderMst o inner join AppMst a on o.appmstid=a.AppMstID
        inner join BillMst b on o.orderno=b.orderno where o.srno=@orderId"); 
        if (dt.Rows.Count > 0)
        {
            utility objU = new utility();
            result = @"<a href='"+ method.WEB_URL + "/Common/Invoice.aspx?id=" + objU.base64Encode(dt.Rows[0]["srno"].ToString()) + "' style='color:blue;' target='_blank'>[click here]</a>";
        }
        return result;
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        //Label1.Text = "Time: " + DateTime.Now.ToString();
        TotalSec = 0;
        if (Session["TotalSec"] != null)
            TotalSec = Convert.ToInt32(Session["TotalSec"].ToString());

        Session["TotalSec"] = (TotalSec + 1).ToString();


        timeLeft = 0;
        if (Session["timeLeft"] != null)
            timeLeft = Convert.ToInt32(Session["timeLeft"].ToString());

        Session["timeLeft"] = (timeLeft - 1).ToString();

        //utility.MessageBox(this, timeLeft.ToString());
        if (TotalSec < 1200)
        {
            if (timeLeft == 0)
            {
                CallFunction();
            }
        }
        else
        {
            div_paymentRequest.Visible = false;
            div_paymentError.InnerHtml = "Payment failed.";
            div_containtError.Visible = true;
        }
    }


    private void AddTime()
    {
        obj.Add(CNT, 20);

        i = 0;
        while (i < 10)
        {
            CNT = CNT + 1;
            obj.Add(CNT, 3);
            i++;
        }

        i = 0;
        while (i < 10)
        {
            CNT = CNT + 1;
            obj.Add(CNT, 6);
            i++;
        }

        i = 0;
        while (i < 6)
        {
            CNT = CNT + 1;
            obj.Add(CNT, 10);
            i++;
        }

        i = 0;
        while (i < 2)
        {
            CNT = CNT + 1;
            obj.Add(CNT, 30);
            i++;
        }

        i = 0;
        while (i < 16)
        {
            CNT = CNT + 1;
            obj.Add(CNT, 60);
            i++;
        }
        obj.Add(CNT + 1, 0);
        Session["DateCollections"] = obj;
        Session["timeLeft"] = 20;
        Session["Sec"] = 20;
        Session["TotalSec"] = 0;
        Session["API_CALL_CNT"] = 0;

    }


    private static Results GenerateInv(string TYPE, string orderId, string paymentId, string signature, string amount)
    {
        Results objResult = new Results();
        try
        {
            SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@TYPE", TYPE),
                new SqlParameter("@orderId", orderId),
                new SqlParameter("@paymentId", paymentId),
                new SqlParameter("@signature", signature),
                new SqlParameter("@amount", amount),
            };
            DataUtility objDUT = new DataUtility();
            DataTable dt = objDUT.GetDataTableSP(sqlparam, "sp_PhonePe");
            objResult.InvoiceNo = "Invoice Generated";
            objResult.Error = "";
            if (dt != null)
            {
                utility objutil = new utility();
                if (dt.Rows[0]["Status"].ToString() == "1")
                {
                    HttpContext.Current.Session["ITEMLISTID"] = null;
                    HttpContext.Current.Session["RootCart"] = null;


                    objResult.srno_Encript = objutil.base64Encode(dt.Rows[0]["InvNo"].ToString());
                    objResult.InvoiceNo = dt.Rows[0]["InvoiceNo"].ToString();
                    objResult.Error = "";


                    //Send SMS
                    //SqlParameter[] param = new SqlParameter[] {
                    //    new SqlParameter("@InvoiceNo", dt.Rows[0]["InvoiceNo"].ToString())
                    //}; 
                    //DataTable d1 = objDUT.GetDataTable(param, @"Select a.AppMstFName, a.AppMstMobile, b.srno, 
                    //b.InvoiceNo, b.Amount, Doe=convert(varchar(20), b.Doe, 106)
                    //from AppMst a inner join OrderMst o on o.appmstid=a.AppMstID 
                    //inner join BillMst b on o.orderno=b.orderno
                    //where b.InvoiceNo=@InvoiceNo");
                    //if (d1.Rows.Count > 0)
                    //{
                    //    utility objU = new utility();
                    //    string Name = d1.Rows[0]["AppMstFName"].ToString();
                    //    string InvoiceNo = d1.Rows[0]["InvoiceNo"].ToString().Replace(":", "%3A").Replace("/", "%2F").Replace("?", "%3F").Replace("=", "%3D");
                    //    string Doe = d1.Rows[0]["Doe"].ToString();
                    //    string Amount = d1.Rows[0]["Amount"].ToString();

                    //    string Link = method.URL + "/Common/Invoice.aspx?id=" + objU.base64Encode(d1.Rows[0]["srno"].ToString());
                    //    Link = Link.Replace(":", "%3A").Replace("/", "%2F").Replace("?", "%3F").Replace("=", "%3D");

                    //    string msg = "Dear+%2A" + Name + "%2A+Invoice+No.+%2A" + InvoiceNo + "%2A+Date+%2A" + Doe + "%2A+has+been+generated+for+%2ARs+" + Amount + "%2A+successfully.+To+view+the+invoice%2C+please+click+here.+%2A" + Link + "%2A+Dispatched+within+2+working+days%0A%0A%2ACustomer+Care+Number%3A%2A+%2B91+7700941890";
                    //    WhatsApp.Send_WhatsApp_Cust_Invoice(d1.Rows[0]["AppMstMobile"].ToString(), msg);
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


    [WebMethod]
    public static Timer GetTimer()
    {
        Timer objTimer = new Timer();
        objTimer.timeLeft = "0";
        objTimer.Sec = "0";

        if (HttpContext.Current.Session["timeLeft"] != null)
            objTimer.timeLeft = HttpContext.Current.Session["timeLeft"].ToString();
        if (HttpContext.Current.Session["Sec"] != null)
            objTimer.Sec = HttpContext.Current.Session["Sec"].ToString();
        return objTimer;
    }

    public class Timer
    {
        public String timeLeft { get; set; }
        public String Sec { get; set; }

    }

    public class Results
    {
        public String Error { get; set; }
        public String InvoiceNo { get; set; }
        public String srno_Encript { get; set; }
        public String status { get; set; }
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

    public class PhonePeResp
    {
        public string code { get; set; }
        public data data { get; set; }
    }

    public class data
    {
        public string merchantTransactionId { get; set; }
        public string transactionId { get; set; }
        public string amount { get; set; }
        public string state { get; set; }
        public string responseCode { get; set; }
        public paymentInstrument paymentInstrument { get; set; }
    }

    public class paymentInstrument
    {
        public string type { get; set; }
        public string utr { get; set; }
        public string upiTransactionId { get; set; }
        public string accountHolderName { get; set; }
        public string cardNetwork { get; set; }
        public string accountType { get; set; }
    }




}