using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.IO;
using System.Text;
using paytm;

public partial class User_paytmresponse : System.Web.UI.Page
{

    static string InvNo = "";
    DataTable dt = new DataTable();

    String MerchantKEY = "z@CcIaTCWyJjdice"; //8e0W9%dCRYhJQw9Q
    String MID = "TOPTIM11688472896980"; //   Eksbdv29511832079211
    String WEBSITE = "WEBPROD";

    protected void Page_Load(object sender, EventArgs e)
    {
        string strFormat = string.Empty;
        string Respons = string.Empty;

        try
        {

            Dictionary<string, string> parameters = new Dictionary<string, string>();
            string paytmChecksum = "";
            foreach (string key in Request.Form.Keys)
            {
                parameters.Add(key.Trim(), Request.Form[key].Trim());
            }

            if (Request.Form["MID"] == null)
            {
                utility.WriteErrorLog("MID Is Null ");
                Response.Redirect("payment-cancel.aspx?tid=" + Request.Form["ORDERID"].ToString() + "&msg=1 MID Is Null");
            }

            if (parameters.ContainsKey("CHECKSUMHASH"))
            {
                paytmChecksum = parameters["CHECKSUMHASH"];
                parameters.Remove("CHECKSUMHASH");
            }

            if (CheckSum.verifyCheckSum(MerchantKEY, parameters, paytmChecksum)) ///"Checksum Matched"
            {
                try
                {
                    Respons += "<ORDERID>" + Request.Form["ORDERID"] + "</ORDERID>";
                    Respons += "<ResponseType>Paytm Response</ResponseType>";
                    Respons += "<MID>" + Request.Form["MID"] + "</MID>";
                    Respons += "<TXNID>" + Request.Form["TXNID"] + "</TXNID>";
                    Respons += "<BANKTXNID>" + Request.Form["BANKTXNID"] + "</BANKTXNID>";
                    Respons += "<TXNAMOUNT>" + Request.Form["TXNAMOUNT"] + "</TXNAMOUNT>";
                    Respons += "<CURRENCY>" + Request.Form["CURRENCY"] + "</CURRENCY>";
                    Respons += "<STATUS>" + Request.Form["STATUS"] + "</STATUS>";
                    Respons += "<RESPCODE>" + Request.Form["RESPCODE"] + "</RESPCODE>";
                    Respons += "<RESPMSG>" + Request.Form["RESPMSG"] + "</RESPMSG>";
                    Respons += "<TXNDATE>" + Request.Form["TXNDATE"] + "</TXNDATE>";
                    Respons += "<GATEWAYNAME>" + Request.Form["GATEWAYNAME"] + "</GATEWAYNAME>";
                    Respons += "<BANKNAME>" + Request.Form["BANKNAME"] + "</BANKNAME>";
                    Respons += "<PAYMENTMODE>" + Request.Form["PAYMENTMODE"] + "</PAYMENTMODE>";
                    Respons += "<CHECKSUMHASH>" + Request.Form["CHECKSUMHASH"] + "</CHECKSUMHASH>";
                    utility.WriteErrorLog(Respons);

                }
                catch (Exception err)
                {
                    utility.WriteErrorLog("Invalid input data from paytm " + Respons);
                    Response.Redirect("payment-cancel.aspx?tid=" + Request.Form["ORDERID"].ToString() + "&msg=2" + Request.Form["RESPMSG"].ToString());
                }

                DataUtility objDUT = new DataUtility();
                if (Request.Form["STATUS"].ToString().ToUpper().Contains("SUCCESS"))
                {

                    SqlParameter[] sqlparam = new SqlParameter[] {
                        new SqlParameter("@TYPE", "SUCCESS"),
                        new SqlParameter("@ORDERID", Convert.ToInt32(Request.Form["ORDERID"].ToString())),
                        new SqlParameter("@TXNAMOUNT",Convert.ToDecimal(Request.Form["TXNAMOUNT"].ToString())),
                        new SqlParameter("@STATUS", Request.Form["STATUS"].ToString()),
                        new SqlParameter("@RESPMSG", Request.Form["RESPMSG"].ToString()),
                        new SqlParameter("@REPONSE", Respons),
                    };

                    dt = objDUT.GetDataTableSP(sqlparam, "Usp_OnlineSucessProcess");
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Rows[0]["Status"].ToString() == "1")
                        {
                            InvNo = dt.Rows[0]["InvNo"].ToString();

                            VerificationPayment(Request.Form["ORDERID"].ToString(), Request.Form["TXNAMOUNT"].ToString());

                            utility objUtil = new utility();

                            Response.Redirect("GSTBill.aspx?id=" + InvNo + "&st=1");
                            //Response.Redirect("purchaseorderbill.aspx?id=" + objUtil.base64Encode(InvNo), false);
                        }
                        else
                        {
                            Response.Redirect("payment-cancel.aspx?tid=" + Request.Form["ORDERID"].ToString() + "&msg=3" + Request.Form["RESPMSG"].ToString());
                        }
                    }
                }
                else
                {
                    SqlParameter[] sqlparam = new SqlParameter[] {
                        new SqlParameter("@TYPE", "ERROR"),
                         new SqlParameter("@ORDERID", Convert.ToInt32(Request.Form["ORDERID"].ToString())),
                        new SqlParameter("@TXNAMOUNT",Convert.ToDecimal(Request.Form["TXNAMOUNT"].ToString())),
                        new SqlParameter("@STATUS", Request.Form["STATUS"].ToString()),
                        new SqlParameter("@RESPMSG", Request.Form["RESPMSG"].ToString()),
                        new SqlParameter("@REPONSE", Respons),
                    };

                    DataTable dt = objDUT.GetDataTableSP(sqlparam, "Usp_OnlineSucessProcess");
                    if (dt.Rows.Count > 0)
                    {
                        try
                        {
                            Response.Redirect("payment-cancel.aspx?tid=" + Request.Form["ORDERID"].ToString() + "&msg=4" + Request.Form["RESPMSG"].ToString());
                        }
                        catch (Exception er) { }
                    }
                }
            }
            else
            {
                utility.WriteErrorLog("Checksum MisMatch " + Respons);
                Response.Redirect("payment-cancel.aspx?tid=" + Request.Form["ORDERID"].ToString() + "&msg=5" + Request.Form["RESPMSG"].ToString());
            }

        }
        catch (Exception er)
        {
            //utility.WriteErrorLog("catch block : " + er);
            //if (Request.Form["STATUS"].ToString().ToUpper().Contains("SUCCESS"))
            //{
            //        VerificationPayment(Request.Form["ORDERID"].ToString(), Request.Form["TXNAMOUNT"].ToString());

            //        utility objUtil = new utility();
            //        Response.Redirect("purchaseorderbill.aspx?id=" + objUtil.base64Encode(InvNo), false);
            //}
            //else
            //{
            //    Response.Redirect("payment-cancel.aspx?tid=" + Request.Form["ORDERID"].ToString() + "&msg=6" + Request.Form["RESPMSG"].ToString());
            //}
        }

    }



    internal void VerificationPayment(string ORDER_ID, string Amount)
    {

        Dictionary<String, String> parameters = new Dictionary<string, string>();


        String CALLBACK_URL = "http://eksbd.com/user/paytmresponse.aspx";

        parameters.Add("MID", MID);
        parameters.Add("REQUEST_TYPE", "DEFAULT");
        parameters.Add("CHANNEL_ID", "WEB");
        parameters.Add("INDUSTRY_TYPE_ID", "Retail");
        parameters.Add("WEBSITE", WEBSITE);
        parameters.Add("CALLBACK_URL", CALLBACK_URL);
        parameters.Add("ORDER_ID", ORDER_ID);
        parameters.Add("CUST_ID", ORDER_ID);
        parameters.Add("TXN_AMOUNT", Amount);

        try
        {
            string checksum = paytm.CheckSum.generateCheckSum(MerchantKEY, parameters);

            string result = "";
            try
            {
                String url = "https://securegw-stage.paytm.in/merchant-status/getTxnStatus?JsonData={'MID':'" + MID + "','ORDERID':'" + ORDER_ID + "','CHECKSUMHASH':'" + checksum + "'}'";
                WebRequest request = WebRequest.Create(url);

                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                Stream stream = response.GetResponseStream();
                Encoding ec = System.Text.Encoding.GetEncoding("utf-8");
                StreamReader reader = new
                System.IO.StreamReader(stream, ec);
                result = reader.ReadToEnd();
                utility.WriteErrorLog("<ResponseType>Paytm verifivation </ResponseType> " + result);

            }
            catch (Exception er)
            {
                result = er.Message;
            }

        }
        catch (Exception ex)
        {

        }
    }
}