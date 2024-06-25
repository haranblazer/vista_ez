using CCA.Util;
using System;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Xml;

public partial class CCAvenue_Response : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string REPONSE = "", failure_message = "", response_code = "", payment_mode = "";
        string order_id = "", tracking_id = "", order_status = "", status_message = "", amount = "";
        if (Request.Form["encResp"] != null)
        {
            try
            {
                CCACrypto ccaCrypto = new CCACrypto();
                string encResponse = ccaCrypto.Decrypt(Request.Form["encResp"], method.CCA_workingKey);
                NameValueCollection Params = new NameValueCollection();
                string[] segments = encResponse.Split('&');
                foreach (string seg in segments)
                {
                    string[] parts = seg.Split('=');
                    if (parts.Length > 0)
                    {
                        string Key = parts[0].Trim();
                        string Value = parts[1].Trim();

                        REPONSE += Key + ":" + Value + "^ ";
                        Params.Add(Key, Value);

                        if (Key == "order_id")
                            order_id = Value;

                        if (Key == "tracking_id")
                            tracking_id = Value;

                        if (Key == "order_status")
                            order_status = Value;

                        if (Key == "status_message")
                            status_message = Value;

                        if (Key == "amount")
                            amount = Value;

                        if (Key == "failure_message")
                            failure_message = Value;

                        if (Key == "response_code")
                            response_code = Value;

                        if (Key == "payment_mode")
                            payment_mode = Value;
                    }
                }

                //for (int i = 0; i < Params.Count; i++)
                //{
                //    Response.Write(Params.Keys[i] + " = " + Params[i] + "<br>");
                //}
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }


            try
            {
                XmlDocument XmlDocObj = new XmlDocument();
                XmlDocObj.Load(Server.MapPath("Payment.xml"));
                XmlNode RootNode = XmlDocObj.SelectSingleNode("data");
                XmlNode bookNode = RootNode.AppendChild(XmlDocObj.CreateNode(XmlNodeType.Element, "Paydetails", ""));
                bookNode.AppendChild(XmlDocObj.CreateNode(XmlNodeType.Element, "Date", "")).InnerText = DateTime.Now.ToString();
                bookNode.AppendChild(XmlDocObj.CreateNode(XmlNodeType.Element, "Payment", "")).InnerText = REPONSE;
                XmlDocObj.Save(Server.MapPath("Payment.xml"));
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }


            try
            {


                DataUtility objDUT = new DataUtility();
                SqlParameter[] sqlparam = new SqlParameter[] {
                   new SqlParameter("@TYPE", order_status.ToUpper()),
                   new SqlParameter("@ORDERID",order_id),
                   new SqlParameter("@tracking_id",tracking_id),
                   new SqlParameter("@TXNAMOUNT", amount),
                   new SqlParameter("@STATUS", order_status),
                   new SqlParameter("@RESPMSG", status_message),
                   new SqlParameter("@REPONSE", REPONSE),
                   new SqlParameter("@OnlineRemark", failure_message),
                   new SqlParameter("@LogId", response_code),
                   new SqlParameter("@IP", HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null ? HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] : HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]),
                };
                DataTable dt = objDUT.GetDataTableSP(sqlparam, "Usp_OnlineSucessProcess");
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["Status"].ToString() == "1")
                    {
                        div_Success.Visible = true;
                        div_Error.Visible = false;

                        lbls_status_message.Text = status_message;
                        lbls_order_status.Text = order_status;
                        lbls_order_id.Text = order_id;
                        lbls_amount.Text = amount;
                        lbls_payment_mode.Text = payment_mode;
                    }
                    else
                    {
                        div_Success.Visible = false;
                        div_Error.Visible = true;

                        if (dt.Rows[0]["Status"].ToString() == "0")
                            lble_order_status.Text = order_status;
                        else
                            lble_order_status.Text = dt.Rows[0]["Status"].ToString();

                        lble_order_id.Text = order_id;
                        lble_amount.Text = amount;
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        else
        {
            Response.Redirect("Default.aspx");
        }
    } 
}
