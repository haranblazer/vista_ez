using System;
using System.Collections.Generic;
//using System.Linq;
//using System.Web.UI;
//using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
//using System.Xml.Linq;
//using System.Drawing;
using System.Xml;
//using System.IO;


public partial class secretadmin_AssociatePackageBill : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    utility objutil;
    XmlDocument xmldoc = new XmlDocument();
    DataUtility objDUT = null;
    string userid = "";
    string invoiceno = "";
    int status = 0;
    string status2 = "";
    string monthname = "";
    int pbv;
    string salesrep = "";
    string xmlfile = "";
    string cvlimitindx;
    protected string Pv = "", bv = "", FranType = "0";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }


        if (!IsPostBack)
        {
            ddl_order.Items.Insert(0, new ListItem("All", "-1"));
            ddl_order.Items.Insert(1, new ListItem(method.Associate, "0"));
            ddl_order.Items.Insert(2, new ListItem(method.Customer, "1"));
            //InsertFunction.CheckAdminlogin();
            txtFromDate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");
            //BindFranchise();
            //  BindUserID();


            if (Request.QueryString.Count > 0)
            {
                if (Request.QueryString["Key"] != null)
                {
                    if (Request.QueryString["Key"] == "ONLINESALES")
                    {
                        ddl_paymode.SelectedValue = "Paytm";
                        if (Request.QueryString["From"].ToString().Length > 0)
                            txtFromDate.Text = Request.QueryString["From"].ToString();
                        if (Request.QueryString["To"].ToString().Length > 0)
                            txtToDate.Text = Request.QueryString["To"].ToString();
                    }
                    if (Request.QueryString["Key"] == "PENDING_PO")
                    {
                        ddl_Del_Status.SelectedValue = "0";
                        txtFromDate.Text = "";
                        txtToDate.Text = "";
                    }
                    if (Request.QueryString["Key"] == "PENDING_DISPATCH")
                    {
                        hnd_Fran.Value = "1";
                        FranType = "1";
                        ddl_Del_Status.SelectedValue = "0";
                        if (Request.QueryString["From"].ToString().Length > 0)
                            txtFromDate.Text = Request.QueryString["From"].ToString();
                        if (Request.QueryString["To"].ToString().Length > 0)
                            txtToDate.Text = Request.QueryString["To"].ToString();
                    }
                }
            }
            // BindGrid();
            objutil = new utility();
            Pv = objutil.getvalue()[1].ToString();
            bv = objutil.getvalue()[2].ToString();
        }
    }


    #region Binary Downline
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindInvoice(string SponsorId, string min, string max, string billtype, string status,
        string RoleWise, string PaymentMode, string cvtype, string cvlimit, string cvlimitval, string usertype, string Del_Status, string FranType,string Cust_Type)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@search", SponsorId),
                   new SqlParameter("@min", min),
                   new SqlParameter("@max", max),
                   new SqlParameter("@billtype", billtype),
                   new SqlParameter("@status", status),
                   new SqlParameter("@RoleWise", RoleWise),
                   new SqlParameter("@PaymentMode", PaymentMode),
                   new SqlParameter("@cvtype", cvtype),
                   new SqlParameter("@cvlimit", cvlimit),
                   new SqlParameter("@cvlimitval", cvlimitval),
                   new SqlParameter("@usertype", usertype),
                   new SqlParameter("@Del_Status", Del_Status),
                   new SqlParameter("@FranType", FranType),
                   new SqlParameter("@IsCustomer", Cust_Type)

            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "AssociateBill");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                utility objutil = new utility();
                data.srno = dr["srno"].ToString();
                data.srno_Encript = objutil.base64Encode(dr["srno"].ToString());
                data.Del_Status = dr["Del_Status"].ToString();
                data.status = dr["status"].ToString();
                data.Date = dr["Date"].ToString();
                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.SellerUserId = dr["SellerUserId"].ToString();
                data.SellerName = dr["SellerName"].ToString();
                data.SellerState = dr["SellerState"].ToString();
                data.SellerDistrict = dr["SellerDistrict"].ToString();
                data.BuyerUserId = dr["BuyerUserId"].ToString();
                data.BuyerName = dr["BuyerName"].ToString();
                data.BuyerState = dr["BuyerState"].ToString();
                data.BuyerDistrict = dr["BuyerDistrict"].ToString();
                data.BuyerMobileNo = dr["BuyerMobileNo"].ToString();
                data.NoOFProduct = dr["NoOFProduct"].ToString();

                data.Actual_Qty = dr["Actual_Qty"].ToString();
                data.grossAmt = dr["grossAmt"].ToString();
                data.SGST = dr["SGST"].ToString();
                data.CGST = dr["CGST"].ToString();
                data.IGST = dr["IGST"].ToString();
                data.Cess = dr["Cess"].ToString();
                data.Amt = dr["Amt"].ToString();
                data.Discount = dr["Discount"].ToString();
                data.CourierCharges = dr["CourierCharges"].ToString();
                data.NetAmt = dr["NetAmt"].ToString();
                data.BV = dr["BV"].ToString();
                data.PV = dr["PV"].ToString();
                data.TotalFPV = dr["TotalFPV"].ToString();
                data.Subdistype = dr["Subdistype"].ToString();
                data.PanNo = dr["PanNo"].ToString();
                data.GSTNo = dr["GSTNo"].ToString();

                data.PayMode = dr["PayMode"].ToString();
                data.DispatchDate = dr["DispatchDate"].ToString();
                data.Transport = dr["Transport"].ToString();
                data.Tracking = dr["Tracking"].ToString();
                data.EWayBill = dr["EWayBill"].ToString();
                data.Del_Remarks = dr["Del_Remarks"].ToString();
                data.Pack_Status = dr["Pack_Status"].ToString();

                data.Img1 = dr["Img1"].ToString();
                data.Img2 = dr["Img2"].ToString();
                data.SendMsg = dr["SendMsg"].ToString();
                data.SendWhatsApp = dr["SendWhatsApp"].ToString();
                data.IS_OPTIN = dr["IS_OPTIN"].ToString();

                data.RefUserid = dr["RefUserid"].ToString();
                data.RefUsername = dr["RefUsername"].ToString();
                data.Customer_Type = dr["IsCustomer"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static string Cancel_Invoice(string Invoice)
    {
        string Result = "";
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("Billcancel", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@invoiceno", Invoice);
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Result = cmd.Parameters["@flag"].Value.ToString();
        }
        catch (Exception er) { }
        return Result;
    }



    [System.Web.Services.WebMethod]
    public static string Dispatch_Inv(string Invoice, string Transport, string Tracking, string EWay, string Remarks, string D_Status)
    {
        string Result = "";
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("Update_Del_Invoice", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@invoiceno", Invoice);
            cmd.Parameters.AddWithValue("@Transport", Transport);
            cmd.Parameters.AddWithValue("@Tracking", Tracking);
            cmd.Parameters.AddWithValue("@EWayBill", EWay);
            cmd.Parameters.AddWithValue("@Del_Remarks", Remarks);
            cmd.Parameters.AddWithValue("@D_Status", D_Status);
            cmd.Parameters.AddWithValue("@Del_by", "-111");
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            Result = cmd.Parameters["@flag"].Value.ToString();

        }
        catch (Exception er) { }
        return Result;
    }



    [System.Web.Services.WebMethod]
    public static string UpdateImage(string IMGTYPE, string srno, string ImgName)
    {
        string Result = "1";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@srno", srno),
                new SqlParameter("@Image", ImgName),
                new SqlParameter("@IMGTYPE", IMGTYPE)
            };
            if (IMGTYPE == "1")
                objDu.ExecuteSql(param, "update BillMst set Img1=@Image where srno=@srno");
            if (IMGTYPE == "2")
                objDu.ExecuteSql(param, "update BillMst set Img2=@Image where srno=@srno");

        }
        catch (Exception er) { }
        return Result;
    }


    [System.Web.Services.WebMethod]
    public static string SendSms(string SMSTYPE, string srno, string UserId, string Name, string Inv, string Date, string Docket, string Transport, string Mobile, string Img_Lr1)
    {
        string Result = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@srno", srno) };
            if (SMSTYPE == "SMS")
            {
                string Msg = "";
                if (Name.Length > 20)
                    Name = Name.Substring(0, 20).ToString();

                //Msg = "Dear " + Name + " your " + UserId + " Invoice No. " + Inv + " Date " + Date + " has been Dispatched vide Docket No. " + Docket + " & " + Transport + " is successfully, To view Docket please click link {{6}} Jai Toptime";
                Msg = "Dear " + Name + " your " + UserId + " Invoice No. " + Inv + " Date " + Date + " has been Dispatched vide Docket No. " + Docket + " is successfully, To view Docket please click link Toptimenet.com Jai Toptime";

                utility objUtil = new utility();
                objUtil.sendSMSByBilling(Mobile, Msg, "DISPATCHED");
                objDu.ExecuteSql(param, "update BillMst set SendMsg=isnull(SendMsg,0) +1 where srno=@srno");

                Result = "1";
            }
            if (SMSTYPE == "WHATSAPP")
            {
                var url = method.WEB_URL;
                if (Img_Lr1 != "")
                    url = url + "/images/Slip/" + Img_Lr1;

                var Msg = "Dear *" + Name + "* your *" + UserId + "* Invoice No. *" + Inv + "*  Date *" + Date + "* has been Dispatched vide Docket No. *" + Docket + " " + Transport + "* is successfully, To view Docket please click link " + url;
                WhatsApp.Send_WhatsApp_With_Header(Mobile, Msg, "Dispatced");
                objDu.ExecuteSql(param, "update BillMst set SendWhatsApp=isnull(SendWhatsApp,0) +1 where srno=@srno");

                Result = "1";
            }

        }
        catch (Exception er) { }
        return Result;
    }




    //[System.Web.Services.WebMethod]
    //public static string Dispatch_Inv(string Invoice, string Transport, string Tracking, string EWay, string Remarks)
    //{
    //    string Result = "";
    //    try
    //    {
    //        SqlConnection con = new SqlConnection(method.str);
    //        SqlCommand cmd = new SqlCommand("Update_Del_Invoice", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@invoiceno", Invoice);
    //        cmd.Parameters.AddWithValue("@Transport", Transport);
    //        cmd.Parameters.AddWithValue("@Tracking", Tracking);
    //        cmd.Parameters.AddWithValue("@EWayBill", EWay);
    //        cmd.Parameters.AddWithValue("@Del_Remarks", Remarks);
    //        cmd.Parameters.AddWithValue("@Del_by", "-111");
    //        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
    //        con.Open();
    //        cmd.ExecuteNonQuery();
    //        Result = cmd.Parameters["@flag"].Value.ToString();

    //    }
    //    catch (Exception er) { }
    //    return Result;
    //}



    public class UserDetails
    {
        public string srno { get; set; }
        public string srno_Encript { get; set; }
        public string Del_Status { get; set; }
        public string status { get; set; }
        public string Date { get; set; }
        public string InvoiceNo { get; set; }
        public string SellerUserId { get; set; }
        public string SellerName { get; set; }
        public string SellerState { get; set; }
        public string SellerDistrict { get; set; }
        public string BuyerUserId { get; set; }
        public string BuyerName { get; set; }
        public string BuyerState { get; set; }
        public string BuyerDistrict { get; set; }
        public string BuyerMobileNo { get; set; }
        public string NoOFProduct { get; set; }
        public string Actual_Qty { get; set; }
        public string grossAmt { get; set; }
        public string SGST { get; set; }
        public string CGST { get; set; }
        public string IGST { get; set; }
        public string Cess { get; set; }
        public string Amt { get; set; }
        public string Discount { get; set; }
        public string CourierCharges { get; set; }
        public string NetAmt { get; set; }
        public string BV { get; set; }
        public string PV { get; set; }
        public string TotalFPV { get; set; }
        public string Subdistype { get; set; }
        public string PanNo { get; set; }
        public string GSTNo { get; set; }
        public string PayMode { get; set; }
        public string DispatchDate { get; set; }
        public string Transport { get; set; }
        public string Tracking { get; set; }
        public string EWayBill { get; set; }
        public string Del_Remarks { get; set; }
        public string Pack_Status { get; set; }
        public string Img1 { get; set; }
        public string Img2 { get; set; }
        public string SendMsg { get; set; }
        public string SendWhatsApp { get; set; }
        public string IS_OPTIN { get; set; }

        public string RefUserid { get; set; }
        public string RefUsername { get; set; }
        public string Customer_Type { get; set; }
    }

    #endregion

 
}

