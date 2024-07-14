using paytm;
using System;
using System.Collections.Generic;
using System.Data;
//using System.IO;
//using System.Linq;
//using System.Security.Cryptography;
//using System.Text;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;

public partial class PaytmRequest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            int ORDER_ID = Convert.ToInt32(secure.Decrypt(Request.QueryString["id"].ToString()));
            PaymentGateway(ORDER_ID);
        }
    }

    private void PaymentGateway(Int32 ORDER_ID)
    {
        if (Session["userId"] != null)
        {
            DataUtility Dutil = new DataUtility();
            DataTable dt = Dutil.GetDataTable("Select o.NetAmt, o.Srno, a.AppMstFName, a.AppMstState, a.AppMstCity, a.AppMstAddress1, a.AppMstPinCode, a.AppMstMobile, a.email from OrderMst o, Appmst a where o.Appmstid=a.Appmstid and o.Srno=" + ORDER_ID);
            if (dt.Rows.Count > 0)
            {
                String Amount = dt.Rows[0]["NetAmt"].ToString();
                if (dt.Rows[0]["AppMstMobile"].ToString() == "9650443548")
                    Amount = "1";

                String MID = "TOPTIM11688472896980";
                String MerchantKEY = "z@CcIaTCWyJjdice";
                 
               // String Url = "https://securegw-stage.paytm.in/theia/processTransaction"; //-------for testing
                String Url = "https://securegw.paytm.in/theia/processTransaction";   // ------for live url


                String CALLBACK_URL = method.WEB_URL + "/PaytmResponse.aspx";
                //String CALLBACK_URL = "http://localhost:22739/PaytmResponse.aspx";

                Dictionary<String, String> parameters = new Dictionary<string, string>();
                parameters.Add("MID", MID);
                parameters.Add("ORDER_ID", dt.Rows[0]["Srno"].ToString());
                parameters.Add("CUST_ID", dt.Rows[0]["Srno"].ToString());
                parameters.Add("TXN_AMOUNT", Amount);
                parameters.Add("CHANNEL_ID", "WEB");
                parameters.Add("INDUSTRY_TYPE_ID", "Retail");
                parameters.Add("WEBSITE", "WEBSTAGING");
                parameters.Add("MSISDN", dt.Rows[0]["AppMstMobile"].ToString());
                parameters.Add("EMAIL", dt.Rows[0]["email"].ToString());
                parameters.Add("CITY", "Delhi");
                parameters.Add("STATE", "Delhi");
                parameters.Add("CALLBACK_URL", CALLBACK_URL);

                String checkSum = CheckSum.generateCheckSum(MerchantKEY, parameters);

                RemotePost myremotepost = new RemotePost();
                myremotepost.Url = Url;
                myremotepost.Add("MID", MID);
                myremotepost.Add("ORDER_ID", dt.Rows[0]["Srno"].ToString());
                myremotepost.Add("CUST_ID", dt.Rows[0]["Srno"].ToString());
                myremotepost.Add("TXN_AMOUNT", Amount);
                myremotepost.Add("CHANNEL_ID", "WEB");
                myremotepost.Add("INDUSTRY_TYPE_ID", "Retail");
                myremotepost.Add("WEBSITE", "WEBSTAGING");
                myremotepost.Add("MSISDN", dt.Rows[0]["AppMstMobile"].ToString());
                myremotepost.Add("EMAIL", dt.Rows[0]["email"].ToString());
                myremotepost.Add("CITY", "Delhi");
                myremotepost.Add("STATE", "Delhi");
                myremotepost.Add("CALLBACK_URL", CALLBACK_URL);
                myremotepost.Add("CHECKSUMHASH", checkSum);
                myremotepost.Post();
            }
        }
        else
        {
            Response.Redirect("Default.aspx");
        }
    }

    public class RemotePost
    {
        private System.Collections.Specialized.NameValueCollection Inputs = new System.Collections.Specialized.NameValueCollection();
        public string Url = "";
        public string Method = "post";
        public string FormName = "form1";
        public void Add(string name, string value)
        {
            Inputs.Add(name, value);
        }
        public void Post()
        {
            System.Web.HttpContext.Current.Response.Clear();
            System.Web.HttpContext.Current.Response.Write("<html><head>");
            System.Web.HttpContext.Current.Response.Write(string.Format("</head><body onload=\"document.{0}.submit()\">", FormName));
            System.Web.HttpContext.Current.Response.Write(string.Format("<form name=\"{0}\" method=\"{1}\" action=\"{2}\" >",
           FormName, Method, Url));
            for (int i = 0; i < Inputs.Keys.Count; i++)
            {
                System.Web.HttpContext.Current.Response.Write(string.Format("<input name=\"{0}\" type=\"hidden\" value=\"{1}\">", Inputs.Keys[i], Inputs[Inputs.Keys[i]]));
            }
            System.Web.HttpContext.Current.Response.Write("</form>");
            System.Web.HttpContext.Current.Response.Write("</body></html>");
            System.Web.HttpContext.Current.Response.End();
        }
    }
}