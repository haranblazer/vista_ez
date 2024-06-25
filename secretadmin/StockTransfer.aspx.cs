using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Xml.Linq;
using System.Xml;
using System.Globalization;
using System.Threading;

public partial class secretadmin_StockTransfer : System.Web.UI.Page
{
    DataUtility objDUT;
    SqlConnection con = null;
    SqlDataAdapter DaProduct;
    SqlCommand com = null;
    utility objUtil = null;
    string strajax = string.Empty;
    DataTable dt = null, dt1 = null;
    double grosstotal = 0;
    double Total = 0;
    double DelCharge = 0;
    double Discount = 0;
    double NetAmt = 0;
    double amt = 0;
    int TotalQnty = 0;
    double TotalTaxPer = 0;
    double TotalTaxRs = 0;
    double TotalDP = 0;
    double TotalBV = 0;
    string invoiceDate = string.Empty, strOffer;
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        { 

             Response.Redirect("adminLog.aspx");


        string str;
            str = Session["admin"].ToString();
            if (str == "")
            {
            Response.Redirect("adminLog.aspx");
 

            if (str != "secretadmin")
            {
                Response.Redirect("adminLog.aspx");
            }


            lblMsg.Text = string.Empty;

            checkpage();
            if (!Page.IsPostBack)
            {
                ddlcst.Visible = false;
                lblcst.Visible = false;
                ViewState["offerno"] = "";
                txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                CheckBillStartDate();
                // InsertFunction.CheckAdminlogin();
                if (Request.QueryString["id"] != null)
                {
                    BindForPrint(Request.QueryString["id"] == null ? "" : Request.QueryString["id"].ToString());
                    lbltype.Visible = false;
                    ddldistributor.Visible = false;

                }
                else
                {

                    //binddistributor();
                    //BindProducts();
                    BindUserID();
                    BindGrid();
                    // BindOffer();


                    Session["CheckRefresh"] = System.DateTime.Now.ToString();
                    txtUserDisp.Text = Request.QueryString["i"] == null ? "" : Request.QueryString["i"].ToString();
                    txtUserId.Text = txtUserDisp.Text;
                    txtUserName.Text = Request.QueryString["n"] == null ? "" : Request.QueryString["n"].ToString();
                    lblOrderNO.Text = Request.QueryString["s"] == null ? "" : "Order No: " + Request.QueryString["s"].ToString();
                    lblp.Text = " ( " + Session["admin"].ToString().ToUpper() + " )";
                }
                int orderNo = Convert.ToInt32(Request.QueryString["s"] == null ? "0" : Request.QueryString["s"].ToString());
                BindCompanyDetail(orderNo);
                nextbill.Visible = false;
            }


            string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
            StringBuilder newFunction = new StringBuilder("function ServerSendValue(arg,ctx){" + js + "}");
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);
        }
        catch
        {
        }
    }
}