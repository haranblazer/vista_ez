using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Xml;
using System.Drawing;
using System.Web.Services;
using System.IO;
using System.Collections.Generic;

public partial class admin_StockTranList : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Logout.aspx");
        }
        else
        {

            if (!IsPostBack)
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();

                // BindDispatchStatus();

                DateTime now = DateTime.Now;
                var startDate = new DateTime(now.Year, now.Month, 1);

                txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");

                //BindGrid();
            }
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string soldto, string invoiceno, string status, string Del_Status)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@soldto", soldto),
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@SalesRepId", HttpContext.Current.Session["franchiseid"].ToString()),
                new SqlParameter("@invoiceno", invoiceno),
                new SqlParameter("@status", status),
                new SqlParameter("@Del_Status", Del_Status),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "stockbillsearch");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.srno_Encode = objutil.base64Encode(dr["srno"].ToString());
                data.srno = dr["srno"].ToString();
                data.Date = dr["Date"].ToString();
                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.BuyerUserId = dr["BuyerUserId"].ToString();
                data.BuyerName = dr["BuyerName"].ToString();
                data.BuyerDistrict = dr["BuyerDistrict"].ToString();
                data.BuyerState = dr["BuyerState"].ToString();
                data.BuyerMobileNo = dr["BuyerMobileNo"].ToString();
                data.NoOFProduct = dr["NoOFProduct"].ToString();
                data.grossAmt = dr["grossAmt"].ToString();
                data.SGST = dr["SGST"].ToString();
                data.CGST = dr["CGST"].ToString();

                data.Actual_Qty = dr["Actual_Qty"].ToString();

                data.IGST = dr["IGST"].ToString();
                data.Cess = dr["Cess"].ToString();
                data.netAmt = dr["netAmt"].ToString();
                data.CourierCharges = dr["CourierCharges"].ToString();
                data.Discount = dr["Discount"].ToString();

                data.Amount = dr["Amount"].ToString();
                data.TotalFPV = dr["TotalFPV"].ToString();
                data.status = dr["status"].ToString();
                data.Del_Status = dr["Del_Status"].ToString();
                data.DeleveryText = dr["DeleveryText"].ToString();

                data.EwayNo = dr["EwayNo"].ToString();
                data.DispatchDate = dr["DispatchDate"].ToString();
                data.Tracking = dr["Tracking"].ToString();
                data.Transport = dr["Transport"].ToString();
                data.DeliveryDate = dr["DeliveryDate"].ToString();

                data.DurationDays = dr["DurationDays"].ToString();
                data.Del_Remarks = dr["Del_Remarks"].ToString();
                data.ConfirmWith = dr["ConfirmWith"].ToString();
                data.TransportMode = dr["TransportMode"].ToString();
                data.No_Boxes = dr["No_Boxes"].ToString();

                data.Weight_KG = dr["Weight_KG"].ToString();
                data.Slip = dr["DispatchFileName"].ToString();

                data.Img2 = dr["Img2"].ToString();
                data.SendMsg = dr["SendMsg"].ToString();
                data.SendWhatsApp = dr["SendWhatsApp"].ToString();
                data.IS_OPTIN = dr["IS_OPTIN"].ToString();
                data.TotalBV = dr["TotalBV"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string srno_Encode { get; set; }
        public string srno { get; set; }
        public string Date { get; set; }
        public string InvoiceNo { get; set; }
        public string BuyerUserId { get; set; }
        public string BuyerName { get; set; }
        public string BuyerDistrict { get; set; }
        public string BuyerState { get; set; }
        public string BuyerMobileNo { get; set; }
        public string NoOFProduct { get; set; }
        public string grossAmt { get; set; }
        public string SGST { get; set; }
        public string CGST { get; set; }

        public string IGST { get; set; }
        public string Cess { get; set; }
        public string netAmt { get; set; }
        public string CourierCharges { get; set; }
        public string Discount { get; set; }

        public string Amount { get; set; }
        public string TotalFPV { get; set; }
        public string status { get; set; }
        public string Del_Status { get; set; }
        public string DeleveryText { get; set; }
        public string Actual_Qty { get; set; }

        public string EwayNo { get; set; }
        public string DispatchDate { get; set; }
        public string Tracking { get; set; }
        public string Transport { get; set; }
        public string DeliveryDate { get; set; }
        public string DurationDays { get; set; }
        public string Del_Remarks { get; set; }
        public string ConfirmWith { get; set; }
        public string TransportMode { get; set; }
        public string No_Boxes { get; set; }
        public string Weight_KG { get; set; }
        public string Slip { get; set; }
        public string Img2 { get; set; }
        public string SendMsg { get; set; }
        public string SendWhatsApp { get; set; }
        public string IS_OPTIN { get; set; }
        public string TotalBV { get; set; }

    }


    [System.Web.Services.WebMethod]
    public static string Dispatch_Inv(string Invoice, string srno, string Transport, string Tracking, string EWay, string Remarks, string Weight, string Boxes, string ImgName1, string ImgName2, string DispatchedDate)
    {
        string Result = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@srno", srno),
                new SqlParameter("@DispatchedDate", DispatchedDate),
                new SqlParameter("@Transport", Transport),
                new SqlParameter("@Tracking", Tracking),
                new SqlParameter("@EWay", EWay),
                new SqlParameter("@Remarks", Remarks),
                new SqlParameter("@Weight", Weight),
                new SqlParameter("@Boxes", Boxes),
                new SqlParameter("@ImgName1", ImgName1),
                new SqlParameter("@ImgName2", ImgName2),
            };

            objDu.ExecuteSql(param, @"Update StockTranReport Set DeliveryStatus=7, Transport=@Transport,
            Tracking=@Tracking, EwayNo=@EWay, DeliveryRemark=@Remarks, WeightKG=@Weight, Boxes=@Boxes,
            DispatchDate=@DispatchedDate, DispatchFileName=(Case when @ImgName1='' then DispatchFileName else @ImgName1 End), 
            Img2=(Case when @ImgName2='' then Img2 else @ImgName2 End) Where Srno=@Srno");
            Result = "1";
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
                objDu.ExecuteSql(param, "update StockTranReport set SendMsg=isnull(SendMsg,0) +1 where srno=@srno");

                Result = "1";
            }
            if (SMSTYPE == "WHATSAPP")
            {
                var url = method.WEB_URL;
                if (Img_Lr1 != "")
                    url = url + "/images/Slip/" + Img_Lr1;

                var Msg = "Dear *" + Name + "* your *" + UserId + "* Invoice No. *" + Inv + "*  Date *" + Date + "* has been Dispatched vide Docket No. *" + Docket + " " + Transport + "* is successfully, To view Docket please click link " + url;
                WhatsApp.Send_WhatsApp_With_Header(Mobile, Msg, "Dispatced");


                objDu.ExecuteSql(param, "update StockTranReport set SendWhatsApp=isnull(SendWhatsApp,0) +1 where srno=@srno");

                Result = "1";
            }

        }
        catch (Exception er) { }
        return Result;
    }




    //private void BindDispatchStatus()
    //{
    //    DataUtility objDu = new DataUtility();
    //    DataTable dt = objDu.GetDataTable("Select UserVal, Item_Desc from Item_Collection where ItemId=9");
    //    if (dt.Rows.Count > 0)
    //    {
    //        ddl_DispatchStatus.Items.Clear();
    //        ddl_DispatchStatus.DataSource = dt;
    //        ddl_DispatchStatus.DataTextField = "Item_Desc";
    //        ddl_DispatchStatus.DataValueField = "UserVal";
    //        ddl_DispatchStatus.DataBind();
    //        ddl_DispatchStatus.Items.Insert(0, new ListItem("Select Dispatch Status", "0"));
    //    }
    //}


    #endregion


}
