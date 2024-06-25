﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class member_Invoicelist : System.Web.UI.Page
{
    string strsessionid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        strsessionid = Convert.ToString(Session["MemberId"]);
        if (strsessionid == "")
        {
            Response.Redirect("~/login.aspx");
        }
        if (!IsPostBack)
        {
            DateTime now = DateTime.Now;
            txtFromDate.Text = new DateTime(now.Year, now.Month, 1).ToString("dd/MM/yyyy").Replace("-", "/");

            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");
        }
    }


    #region Binary Downline
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindInvoice(string SponsorId, string min, string max, string status, string Del_Status)
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
                   new SqlParameter("@salesrepid", ""),
                   new SqlParameter("@SoldTo", HttpContext.Current.Session["MemberId"].ToString()),
                   new SqlParameter("@Del_Status", Del_Status),
                   new SqlParameter("@status", status),
                   new SqlParameter("@IsCustomer", 1),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "billdetail");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.srno = dr["srno"].ToString();
                data.srno_Encript = objutil.base64Encode(dr["srno"].ToString());
                data.Del_Status = dr["Del_Status"].ToString();
                data.status = dr["status"].ToString();
                data.Date = dr["Doe"].ToString();
                data.Billtype = dr["Billtype"].ToString();
                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.BuyerUserId = dr["BuyerUserId"].ToString();
                data.BuyerName = dr["BuyerName"].ToString();
                data.BuyerState = dr["BuyerState"].ToString();
                data.BuyerState = dr["BuyerDistrict"].ToString();
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
                data.Subdistype = dr["Subdistype"].ToString();
                data.InvoiceType = dr["InvoiceType"].ToString();

                data.PayMode = dr["PayMode"].ToString();
                data.DispatchDate = dr["DispatchDate"].ToString();
                data.Transport = dr["Transport"].ToString();
                data.Tracking = dr["Tracking"].ToString();
                data.EWayBill = dr["EWayBill"].ToString();
                data.UseWallet = dr["UseWallet"].ToString();
                data.WalletAmount = dr["WalletAmount"].ToString();
                data.secondaryAmount = dr["secondaryAmount"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string srno { get; set; }
        public string srno_Encript { get; set; }
        public string Del_Status { get; set; }
        public string status { get; set; }
        public string Date { get; set; }
        public string Billtype { get; set; }
        public string InvoiceNo { get; set; }
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
        public string Subdistype { get; set; }
        public string InvoiceType { get; set; }
        public string PayMode { get; set; }
        public string DispatchDate { get; set; }
        public string Transport { get; set; }
        public string Tracking { get; set; }
        public string EWayBill { get; set; }
        public string UseWallet { get; set; }
        public string WalletAmount { get; set; }
        public string secondaryAmount { get; set; }
    }

    #endregion

}