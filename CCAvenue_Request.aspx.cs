using CCA.Util;
using System;
using System.Data;

public partial class CCAvenue_Request : System.Web.UI.Page
{
    public string strEncRequest = "";
    CCACrypto ccaCrypto = new CCACrypto();
    string ccaRequest = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if (Request.QueryString["id"] != null)
                {
                    int ORDER_ID = Convert.ToInt32(secure.Decrypt(Request.QueryString["id"].ToString()));
                    PaymentGateway(ORDER_ID);
                }
            }
            catch (Exception er) { }
        }
    }

    private void PaymentGateway(Int32 ORDER_ID)
    {
        DataUtility Dutil = new DataUtility();
        DataTable dt = null;

        if (Session["userId"] == null)
        {
            dt = Dutil.GetDataTable(@"Select o.Srno, o.OrderNo, o.NetAmt,  AppMstFName=c.CustomerName, AppMstState=c.state, 
            AppMstCity=c.city, AppMstAddress1=c.address1, AppMstPinCode=c.pincode, AppMstMobile=c.MobileNo, email=c.email
            from OrderMst o, CustomerMst c where o.Appmstid=c.Cid and o.Srno=" + ORDER_ID);
        }
        else
        {
            dt = Dutil.GetDataTable(@"Select o.Srno, o.OrderNo, o.NetAmt, a.AppMstFName, a.AppMstState, a.AppMstCity, 
            a.AppMstAddress1, a.AppMstPinCode, a.AppMstMobile, a.email 
            from OrderMst o, Appmst a where o.Appmstid=a.Appmstid and o.Srno=" + ORDER_ID);
        }
        if (dt.Rows.Count > 0)
        {
            string Amount = dt.Rows[0]["NetAmt"].ToString();
           // if (dt.Rows[0]["AppMstMobile"].ToString() == "9650443548") Amount = "1";

            ccaRequest += "tid=" + dt.Rows[0]["Srno"].ToString() + "&";
            ccaRequest += "merchant_id=" + method.CCA_merchant_id + "&";
            ccaRequest += "order_id=" + dt.Rows[0]["OrderNo"].ToString() + "&";
            ccaRequest += "amount=" + Amount + "&";
            ccaRequest += "currency=INR&";
            ccaRequest += "redirect_url=" + method.CCA_CallCabkUrl + "&";
            ccaRequest += "cancel_url=" + method.CCA_CallCabkUrl + "&";

            ccaRequest += "billing_name=&";
            ccaRequest += "billing_address=&";
            ccaRequest += "billing_city=&";
            ccaRequest += "billing_state=&";
            ccaRequest += "billing_zip=&";
            ccaRequest += "billing_country=&";
            ccaRequest += "billing_tel=&";
            ccaRequest += "billing_email=&";

            ccaRequest += "delivery_name=" + dt.Rows[0]["AppMstFName"].ToString() + "&";
            ccaRequest += "delivery_address=" + dt.Rows[0]["AppMstAddress1"].ToString() + "&";
            ccaRequest += "delivery_city=" + dt.Rows[0]["AppMstCity"].ToString() + "&";
            ccaRequest += "delivery_state=" + dt.Rows[0]["AppMstState"].ToString() + "&";
            ccaRequest += "delivery_zip=" + dt.Rows[0]["AppMstPinCode"].ToString() + "&";
            ccaRequest += "delivery_country=INDIA&";
            ccaRequest += "delivery_tel=" + dt.Rows[0]["AppMstMobile"].ToString() + "&";

            ccaRequest += "merchant_param1=&";
            ccaRequest += "merchant_param2=&";
            ccaRequest += "merchant_param3=&";
            ccaRequest += "merchant_param4=&";
            ccaRequest += "merchant_param5=&";
        }
        strEncRequest = ccaCrypto.Encrypt(ccaRequest, method.CCA_workingKey);

    }

}