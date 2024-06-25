using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.Data.SqlClient;
using System.Xml;
using System.Xml.Linq;
using System.Collections;

public partial class secretadmin_BarcodeBilling : System.Web.UI.Page
{
    static string ITEMLISTID = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Session["franchiseid"] == null)
                    Response.Redirect("Logout.aspx");

                txtbilldate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
                txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");

                payoutdate();
                checkpage();
                BindState();
                BindUserProduct();
                HttpContext.Current.Session["FranCart"] = null;
                BindPOCart();
            }
        }
        catch (Exception er) { }
    }


    #region Genearate Invoice
    [WebMethod]
    public static Results GenerateInv(string PackStockType, string BillType, string UserId, string Discount, string DISC_Perc, string DelCharge, string User_State, string Admin_State, string paymode, string bankname, string checkno, string CheDate,
    string toAdd, string GSTNo, string PlaseOfSuply, string SellerState, string BillDate, string SchemeItemIdStr, string EwayNo, string UserRemark, string Ref_User,
    string S_Name, string S_Mobile, string S_Address, string S_Dist, string S_City, string S_Pincod, string DLVR_Tax, string DLVR_Amount,
    string UseWallet, string WalletAmount, string secondaryAmount, string SECD_PayMode, string Adjustment)
    {
        if (PackStockType == "2")
        {
            SchemeItemIdStr = "";
        }
        if (PackStockType == "3")
        {
            SchemeItemIdStr = "";
            BillType = "0";
        }
        double SchemeAmt = 0, SchemeTaxRs = 0;
        int TotalQnty = 0;
        Results objResult = new Results();
        UserId = UserId.Trim();
        if (UserId == "")
        {
            objResult.Error = "Please Enter User Id.";
            return objResult;
        }
        if (HttpContext.Current.Session["franchiseid"] == null)
        {
            objResult.Error = "Sessionlogout";
            return objResult;
        }

        if (HttpContext.Current.Session["LogId"] == null)
        {
            objResult.Error = "Sessionlogout";
            return objResult;
        }

        string LogId = HttpContext.Current.Session["LogId"].ToString();
        string IP = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null ? HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] : HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

        XElement element = null;
        try
        {
            String BillDate_New = "", CheDate_New = "";
            try
            {
                if (BillDate.Length > 0)
                {
                    String[] Date = BillDate.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    BillDate_New = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
                if (CheDate.Length > 0)
                {
                    String[] Date = CheDate.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    CheDate_New = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
                else
                {
                    CheDate_New = "01/01/1900";
                }
            }
            catch (Exception er)
            {
                objResult.Error = er.Message;
                return objResult;
            }


            string OFFERID = "0";
            if (PackStockType == "1" && (BillType == "4" || BillType == "6"))
            {
                OFFERID = "-111";
            }


            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
            if (Cartdt == null)
            {
                objResult.Error = "Your cart is empty.";
                return objResult;
            }
            if (Cartdt != null)
            {
                foreach (DataRow dr in Cartdt.Rows)
                {
                    Calculater(Convert.ToInt32(dr["batchid"].ToString()));
                }
                element = new XElement("Bill");
                foreach (DataRow row in Cartdt.AsEnumerable().Where(o => o.Field<int>("pid") > 0 && o.Field<int>("qty") > 0).CopyToDataTable().Rows)
                {
                    if (row["pid"].ToString().Trim().Length > 0 && Convert.ToInt32(string.IsNullOrEmpty(row["qty"].ToString().Trim()) ? "0" : row["qty"].ToString().Trim()) > 0)
                    {
                        double IGST = 0, IGSTRS = 0, CGST = 0, CGSTRS = 0, SGST = 0, SGSTRS = 0;
                        if (User_State == Admin_State)
                        {
                            CGST = Convert.ToDouble(row["tax"].ToString()) / 2;
                            CGSTRS = Convert.ToDouble(row["Totaltaxamt"].ToString()) / 2;
                            SGST = Convert.ToDouble(row["tax"].ToString()) / 2;
                            SGSTRS = Convert.ToDouble(row["Totaltaxamt"].ToString()) / 2;
                        }
                        else
                        {
                            IGST = Convert.ToDouble(row["tax"].ToString());
                            IGSTRS = Convert.ToDouble(row["Totaltaxamt"].ToString());
                        }


                        XElement TotalComboXml = null;
                        TotalComboXml = new XElement("Combo");
                        if (row["IsComboPack"].ToString() == "1")
                        {
                            SqlParameter[] param = new SqlParameter[]
                            {
                                 new SqlParameter("@Pid", row["Pid"].ToString()),
                                 new SqlParameter("@UserId", HttpContext.Current.Session["franchiseid"].ToString()),
                                 new SqlParameter("@ReqQnt", row["qty"].ToString())
                            };
                            DataUtility objDu = new DataUtility();
                            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_Combo_Batch");
                            while (dr.Read())
                            {
                                if (dr["flag"].ToString() == "1")
                                {
                                    XElement ComboXml = new XElement("P",
                                    new XElement("C_Pid", dr["C_Pid"].ToString()),
                                    new XElement("C_Qty", dr["C_Qty"].ToString()),
                                    new XElement("Batchid", dr["Batchid"].ToString())
                                    );
                                    TotalComboXml.Add(ComboXml);
                                }
                                else
                                {
                                    objResult.Error = "Your combo product quantity is not available.";
                                    return objResult;
                                }
                            }
                        }



                        XElement prdXml = new XElement("P",
                                new XElement("pname", row["pname"].ToString()),
                                new XElement("cd", row["Pid"].ToString()),
                                new XElement("dis", row["Discount"].ToString()),
                                 new XElement("Disc_Perc_Val", row["Disc_Perc_Val"].ToString()),
                                new XElement("dis_type", row["DiscounType"].ToString()),
                                new XElement("hsncode", row["hsncode"].ToString()),
                                new XElement("Qnt", row["qty"].ToString()),
                                new XElement("Received", row["qty"].ToString()),
                                new XElement("Damage", "0"),

                                new XElement("MRP", row["MRP"].ToString()),
                                new XElement("TAX", row["Tax"].ToString()),
                                new XElement("TAXRS", row["Totaltaxamt"].ToString()),

                                new XElement("DP", row["DPAmt"].ToString()),
                                new XElement("DPWithTax", row["DPWithTax"].ToString()),
                                new XElement("BV", row["totalbvamt"].ToString()),

                                new XElement("FPV", row["FPV"].ToString()),
                                new XElement("TotalFPV", row["TotalFPV"].ToString()),
                                 new XElement("Gross", row["Gross"].ToString()),
                                new XElement("total", row["totalamt"].ToString()),
                                new XElement("batchid", row["batchid"].ToString()),
                                new XElement("OFFERID", OFFERID),
                                new XElement("IGST", IGST),
                                new XElement("IGSTRS", Math.Round(IGSTRS, 2)),
                                new XElement("CGST", CGST),
                                new XElement("CGSTRS", Math.Round(CGSTRS, 2)),
                                new XElement("SGST", SGST),
                                new XElement("SGSTRS", Math.Round(SGSTRS, 2)),
                                new XElement("IsComboPack", row["IsComboPack"].ToString()),
                                TotalComboXml
                           );
                        TotalComboXml = null;
                        element.Add(prdXml);
                        TotalQnty += int.Parse(row["qty"].ToString());
                    }
                }

                if (SchemeItemIdStr != "")
                {
                    DataTable dt_scheme = GetSchemeItemId(SchemeItemIdStr);
                    foreach (DataRow row in dt_scheme.Rows)
                    {
                        TotalQnty += int.Parse(row["quantity"].ToString());
                        double IGST = 0, IGSTRS = 0, CGST = 0, CGSTRS = 0, SGST = 0, SGSTRS = 0;
                        double MRP = Math.Round(Convert.ToDouble(row["Rs"].ToString()) * 100 / (100 + Convert.ToDouble(row["Tax"].ToString())), 4);

                        double TAXRS = Math.Round((MRP * (Convert.ToDouble(row["Tax"].ToString()) / 2) / 100), 2, MidpointRounding.ToEven);
                        TAXRS = TAXRS + Math.Round((MRP * (Convert.ToDouble(row["Tax"].ToString()) / 2) / 100), 2, MidpointRounding.ToEven);

                        double DPWithTax = Convert.ToDouble(row["Rs"].ToString());
                        if (User_State == Admin_State)
                        {
                            CGST = Convert.ToDouble(row["tax"].ToString()) / 2;
                            CGSTRS = TAXRS / 2; // (Convert.ToSingle(MRP) * Convert.ToSingle(row["quantity"].ToString())) * (CGST / 100);
                            SGST = Convert.ToDouble(row["tax"].ToString()) / 2;
                            SGSTRS = TAXRS / 2; //(Convert.ToSingle(MRP) * Convert.ToSingle(row["quantity"].ToString())) * (SGST / 100);
                        }
                        else
                        {
                            IGST = Convert.ToDouble(row["tax"].ToString());
                            IGSTRS = TAXRS; //(Convert.ToSingle(MRP) * Convert.ToSingle(row["quantity"].ToString())) * (IGST / 100);
                        }

                        SchemeAmt += MRP;
                        SchemeTaxRs += TAXRS;

                        XElement prdXml = new XElement("P",
                            new XElement("pname", row["pname"].ToString()),
                            new XElement("cd", row["Pid"].ToString()),
                            new XElement("dis", 0),
                            new XElement("dis_type", "%"),
                            new XElement("hsncode", row["HSNCode"].ToString()),
                            new XElement("Qnt", row["quantity"].ToString()),
                            new XElement("MRP", MRP),
                            new XElement("TAX", row["Tax"].ToString()),
                            new XElement("TAXRS", TAXRS),
                            new XElement("DP", MRP),
                             new XElement("Gross", MRP),
                            new XElement("DPWithTax", DPWithTax),
                            new XElement("BV", 0),
                            new XElement("FPV", 0),
                            new XElement("TotalFPV", 0),
                            new XElement("total", (MRP + TAXRS) * Convert.ToDouble(row["quantity"].ToString())),
                            new XElement("batchid", row["batchid"].ToString()),
                            new XElement("OFFERID", row["OFFERID"].ToString()),
                            new XElement("IGST", IGST),
                            new XElement("IGSTRS", Math.Round(IGSTRS, 2)),
                            new XElement("CGST", CGST),
                            new XElement("CGSTRS", Math.Round(CGSTRS, 2)),
                            new XElement("SGST", SGST),
                            new XElement("SGSTRS", Math.Round(SGSTRS, 2)),
                            new XElement("IsComboPack", "0"),
                            new XElement("Combo", "")

                       );
                        element.Add(prdXml);
                    }
                }




                var xmlObject = new XmlDocument();
                xmlObject.LoadXml(element.ToString());
                if (element != null)
                {
                    object sumqty, totalamt, GrossAmt, totalBV, TaxRs, NetAmt, TotalFPV;
                    sumqty = Cartdt.Compute("Sum(qty)", "");
                    totalamt = Cartdt.Compute("Sum(totalamt)", "");
                    GrossAmt = Cartdt.Compute("Sum(TaxableAmt)", "");
                    totalBV = Cartdt.Compute("Sum(totalbvamt)", "");
                    TotalFPV = Cartdt.Compute("Sum(TotalFPV)", "");
                    TaxRs = Cartdt.Compute("Sum(Totaltaxamt)", "");
                    NetAmt = (Convert.ToDouble(totalamt) + Convert.ToDouble(DelCharge) - Convert.ToDouble(Discount));

                    SqlConnection con = new SqlConnection(method.str);
                    string ProcedureName = "";
                    if (PackStockType == "1")
                        ProcedureName = "AddBill";
                    else if (PackStockType == "2")
                        ProcedureName = "StockTransfer";
                    else if (PackStockType == "3")
                        ProcedureName = "Generate_PO";


                    string ExtraPV = "0";
                    //if (PackStockType == "1" && BillType == "3")
                    //      ExtraPV = GetExtraPV(totalamt.ToString(), totalBV.ToString());
                    //ExtraPV = ExtraPV == "" ? "0" : ExtraPV;


                    SqlCommand com = new SqlCommand(ProcedureName, con);
                    com.CommandType = CommandType.StoredProcedure;

                    if (PackStockType == "1")
                    {
                        com.Parameters.AddWithValue("@regno", UserId);
                        com.Parameters.AddWithValue("@count", Convert.ToInt32(Cartdt.Rows.Count));
                        com.Parameters.AddWithValue("@amt", Convert.ToInt32(Math.Round(Convert.ToDouble(NetAmt) + (SchemeAmt + SchemeTaxRs))).ToString("#0.00"));
                        com.Parameters.AddWithValue("@gross", Convert.ToDouble(GrossAmt) + SchemeAmt);
                        com.Parameters.AddWithValue("@Qnty", TotalQnty);
                        com.Parameters.AddWithValue("@ToalTaxPer", 0);
                        com.Parameters.AddWithValue("@TotalTaxRs", Convert.ToDouble(TaxRs) + SchemeTaxRs);
                        com.Parameters.AddWithValue("@TotalDP", Convert.ToDouble(GrossAmt) + SchemeAmt);
                        com.Parameters.AddWithValue("@TotalBV", Convert.ToDouble(totalBV) + Convert.ToDouble(ExtraPV));
                        com.Parameters.AddWithValue("@distype", BillType);
                        com.Parameters.AddWithValue("@delChrg", DelCharge);
                        com.Parameters.AddWithValue("@disAmt", Discount);
                        com.Parameters.AddWithValue("@NetAmt", Convert.ToDouble(NetAmt) + (SchemeAmt + SchemeTaxRs));
                        com.Parameters.AddWithValue("@soldTo", UserId);
                        com.Parameters.AddWithValue("@saleRep", HttpContext.Current.Session["franchiseid"].ToString());
                        com.Parameters.AddWithValue("@toAdd", toAdd);

                        com.Parameters.AddWithValue("@bankname", bankname);
                        com.Parameters.AddWithValue("@checkdate", CheDate_New);
                        com.Parameters.AddWithValue("@checkno", checkno);
                        com.Parameters.AddWithValue("@paymode", paymode);
                        com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
                        com.Parameters.AddWithValue("@orderno", "");
                        com.Parameters.AddWithValue("@PartyGSTNo", GSTNo);

                        com.Parameters.AddWithValue("@PlaceOfSupply", PlaseOfSuply);
                        com.Parameters.AddWithValue("@sellerstate", SellerState);
                        com.Parameters.AddWithValue("@BillingDate", BillDate_New);
                        com.Parameters.AddWithValue("@Banktype", "");
                        com.Parameters.AddWithValue("@EwayNo", EwayNo);

                        com.Parameters.Add("@flag", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                        com.Parameters.Add("@InvNo", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                        com.Parameters.AddWithValue("@TotalFPV", TotalFPV);
                        com.Parameters.AddWithValue("@LogId", LogId);
                        com.Parameters.AddWithValue("@IP", IP);
                        com.Parameters.AddWithValue("@UserRemark", UserRemark);
                        com.Parameters.AddWithValue("@Ref_User", Ref_User);
                        com.Parameters.AddWithValue("@DLVR_Tax", DLVR_Tax == "" ? "0" : DLVR_Tax);
                        com.Parameters.AddWithValue("@DLVR_Amount", DLVR_Amount == "" ? "0" : DLVR_Amount);
                        com.Parameters.AddWithValue("@ExtraPV", ExtraPV);

                        com.Parameters.AddWithValue("@UseWallet", UseWallet == "" ? "0" : UseWallet);
                        com.Parameters.AddWithValue("@WalletAmount", WalletAmount == "" ? "0" : WalletAmount);
                        com.Parameters.AddWithValue("@secondaryAmount", secondaryAmount == "" ? "0" : secondaryAmount);
                        com.Parameters.AddWithValue("@SECD_PayMode", SECD_PayMode);
                        com.Parameters.AddWithValue("@DISC_Perc", DISC_Perc);
                        com.Parameters.AddWithValue("@IsOnline", 0);
                        com.Parameters.AddWithValue("@AdjustmentAmt", Adjustment);
                    }
                    else if (PackStockType == "2")
                    {
                        com.Parameters.AddWithValue("@count", Convert.ToInt32(Cartdt.Rows.Count));
                        com.Parameters.AddWithValue("@amt", Convert.ToInt32(Math.Round(Convert.ToDouble(NetAmt) + (SchemeAmt + SchemeTaxRs))).ToString("#0.00"));
                        com.Parameters.AddWithValue("@gross", Convert.ToDouble(GrossAmt) + SchemeAmt);
                        com.Parameters.AddWithValue("@Qnty", TotalQnty);
                        com.Parameters.AddWithValue("@TotalTaxRs", Convert.ToDouble(TaxRs) + SchemeTaxRs);
                        com.Parameters.AddWithValue("@TotalDP", Convert.ToDouble(GrossAmt) + SchemeAmt);
                        com.Parameters.AddWithValue("@TotalBV", totalBV);
                        com.Parameters.AddWithValue("@delChrg", DelCharge);
                        com.Parameters.AddWithValue("@disAmt", Discount);
                        com.Parameters.AddWithValue("@NetAmt", NetAmt);
                        com.Parameters.AddWithValue("@soldTo", UserId);
                        com.Parameters.AddWithValue("@saleRep", HttpContext.Current.Session["franchiseid"].ToString());
                        com.Parameters.AddWithValue("@toAdd", toAdd);
                        com.Parameters.AddWithValue("@bankname", bankname);
                        com.Parameters.AddWithValue("@checkdate", CheDate_New);
                        com.Parameters.AddWithValue("@checkno", checkno);
                        com.Parameters.AddWithValue("@paymode", paymode);
                        com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
                        com.Parameters.AddWithValue("@orderno", "");
                        com.Parameters.Add("@flag", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                        com.Parameters.Add("@InvNo", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                        com.Parameters.AddWithValue("@TotalFPV", TotalFPV);
                        com.Parameters.AddWithValue("@EwayNo", EwayNo);
                        com.Parameters.AddWithValue("@Billtype", BillType);
                        com.Parameters.AddWithValue("@LogId", LogId);
                        com.Parameters.AddWithValue("@IP", IP);
                        com.Parameters.AddWithValue("@UserRemark", UserRemark);
                        com.Parameters.AddWithValue("@DLVR_Tax", DLVR_Tax == "" ? "0" : DLVR_Tax);
                        com.Parameters.AddWithValue("@DLVR_Amount", DLVR_Amount == "" ? "0" : DLVR_Amount);
                        com.Parameters.AddWithValue("@AdjustmentAmt", Adjustment);
                    }
                    else if (PackStockType == "3")
                    {
                        com.Parameters.AddWithValue("@count", Convert.ToInt32(Cartdt.Rows.Count));
                        com.Parameters.AddWithValue("@amt", Convert.ToInt32(Math.Round(Convert.ToDouble(NetAmt) + (SchemeAmt + SchemeTaxRs))).ToString("#0.00"));
                        com.Parameters.AddWithValue("@gross", Convert.ToDouble(GrossAmt) + SchemeAmt);
                        com.Parameters.AddWithValue("@Qnty", TotalQnty);
                        com.Parameters.AddWithValue("@TotalTaxRs", Convert.ToDouble(TaxRs) + SchemeTaxRs);
                        com.Parameters.AddWithValue("@TotalDP", Convert.ToDouble(GrossAmt) + SchemeAmt);
                        com.Parameters.AddWithValue("@TotalBV", totalBV);
                        com.Parameters.AddWithValue("@delChrg", DelCharge);
                        com.Parameters.AddWithValue("@disAmt", Discount);
                        com.Parameters.AddWithValue("@NetAmt", NetAmt);
                        com.Parameters.AddWithValue("@soldTo", HttpContext.Current.Session["franchiseid"].ToString());
                        com.Parameters.AddWithValue("@saleRep", UserId);
                        com.Parameters.AddWithValue("@toAdd", toAdd);
                        com.Parameters.AddWithValue("@bankname", bankname);
                        com.Parameters.AddWithValue("@checkdate", CheDate_New);
                        com.Parameters.AddWithValue("@checkno", checkno);
                        com.Parameters.AddWithValue("@paymode", paymode);
                        com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
                        com.Parameters.AddWithValue("@orderno", "");
                        com.Parameters.AddWithValue("@EwayNo", EwayNo);
                        com.Parameters.Add("@flag", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                        com.Parameters.Add("@InvNo", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                        com.Parameters.AddWithValue("@LogId", LogId);
                        com.Parameters.AddWithValue("@IP", IP);
                        com.Parameters.AddWithValue("@UserRemark", UserRemark);

                        com.Parameters.AddWithValue("@S_Name", S_Name);
                        com.Parameters.AddWithValue("@S_Mobile", S_Mobile);
                        com.Parameters.AddWithValue("@S_Address", S_Address);
                        com.Parameters.AddWithValue("@S_Dist", S_Dist);
                        com.Parameters.AddWithValue("@S_City", S_City);
                        com.Parameters.AddWithValue("@S_Pincod", S_Pincod);
                        com.Parameters.AddWithValue("@DLVR_Tax", DLVR_Tax == "" ? "0" : DLVR_Tax);
                        com.Parameters.AddWithValue("@DLVR_Amount", DLVR_Amount == "" ? "0" : DLVR_Amount);
                        com.Parameters.AddWithValue("@AdjustmentAmt", Adjustment);
                    }
                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    string status = com.Parameters["@flag"].Value.ToString();
                    string invoiceNo = com.Parameters["@InvNo"].Value.ToString();
                    if (status == "1")
                    {
                        string Link = method.WEB_URL;
                        string typeText = "", UserName = "", Txt_Sms = "";
                        DataUtility objDu = new DataUtility();
                        utility objutil = new utility();

                        if (PackStockType == "1")
                        {
                            objResult.Url = Link + "/Common/Invoice.aspx?id=" + objutil.base64Encode(invoiceNo);
                        }
                        else if (PackStockType == "2")
                        {
                            objResult.Url = Link + "/Common/StockTranBill.aspx?id=" + objutil.base64Encode(invoiceNo);
                        }
                        else if (PackStockType == "3")
                        {
                            objResult.Url = Link + "/franchise/PO_BILL.aspx?id=" + objutil.base64Encode(invoiceNo);
                        }


                        if (PackStockType == "1")
                        {
                            if (BillType == "1")
                                typeText = method.BINARY_PV;
                            else if (BillType == "3")
                                typeText = method.PV;

                            // sendSMS(invoiceNo, totalBV.ToString(), typeText, totalamt.ToString());
                            DataTable dt = objDu.GetDataTable("Select A.AppMstRegNo, AppMstFName, A.AppMstMobile, B.InvoiceNo, b.TotalBV, Doe=convert(nvarchar(10), b.doe, 103), IS_OPTIN=isnull(A.IS_OPTIN,0) FROM AppMst A INNER JOIN BillMst B ON  A.AppMstRegNo=B.SoldTo WHERE B.srno=" + invoiceNo);
                            if (dt.Rows.Count > 0)
                            {
                                objResult.InvoiceNo = dt.Rows[0]["InvoiceNo"].ToString();
                                UserName = dt.Rows[0]["AppmstFName"].ToString();

                                if (UserName.Length > 20)
                                    UserName = UserName.Substring(0, 20).ToString();

                                Txt_Sms = "Dear " + UserName + " ID No " + dt.Rows[0]["AppMstRegNo"].ToString() + " Invoice No: " + dt.Rows[0]["InvoiceNo"].ToString() + " Invoice Amt : " + NetAmt + "generated successfully from Toptimenet.com Jai Toptime";
                                //Success=Dear Surya Narayan Wellne ID No 217272 Invoice No: FF7017/23/0144 Invoice Amt : 0generated successfully from Toptimenet.com Jai Toptime

                                utility objUtil = new utility();
                                objUtil.sendSMSByBilling(dt.Rows[0]["AppMstMobile"].ToString().Trim(), Txt_Sms, "INVOICE");

                                if (dt.Rows[0]["IS_OPTIN"].ToString() == "1")
                                {
                                    //String Whatsappmsg = "Dear " + dt.Rows[0]["AppMstRegNo"].ToString() + " " + dt.Rows[0]["AppmstFName"].ToString() + " your Invoice No " + dt.Rows[0]["InvoiceNo"].ToString() + " Dated *" + dt.Rows[0]["doe"].ToString() + "* for *" + NetAmt + "* has been generated Successfully. From www.toptimenet.com. *Jai Toptime*";
                                    //String Whatsappmsg = "Dear *" + dt.Rows[0]["AppmstFName"].ToString() + "* your *" + dt.Rows[0]["AppMstRegNo"].ToString() + "* Invoice *" + dt.Rows[0]["InvoiceNo"].ToString() + "* date *" + dt.Rows[0]["doe"].ToString() + "* has been generated for *" + NetAmt + "/-* and *" + typeText + "*: *" + dt.Rows[0]["TotalBV"].ToString() + "* successfully. For downloading Invoice please click the Link " + Link+". From www.toptimenet.com. *Jai Toptime*";
                                    // String Whatsappmsg = "Dear *" + dt.Rows[0]["AppmstFName"].ToString() + "* your Id *" + dt.Rows[0]["AppMstRegNo"].ToString() + "* Invoice No.*" + dt.Rows[0]["InvoiceNo"].ToString() + "* Date *" + dt.Rows[0]["doe"].ToString() + "* has been generated for *" + NetAmt + "/-* and *" + typeText + "*: *" + dt.Rows[0]["TotalBV"].ToString() + "* successfully For downloading Invoice Please click the Link " + Link + " www.toptimenet.com";
                                    // WhatsApp.Send_WhatsApp_MSG(dt.Rows[0]["AppMstMobile"].ToString().Trim(), Whatsappmsg);

                                    var Whatsappmsg = "Dear *" + dt.Rows[0]["AppmstFName"].ToString() + "* your id *" + dt.Rows[0]["AppMstRegNo"].ToString() + "* Invoice No. *" + dt.Rows[0]["InvoiceNo"].ToString() + "* Date *" + dt.Rows[0]["doe"].ToString() + "* has been generated for Rs *" + NetAmt + "/-* and *" + typeText + "*: *" + dt.Rows[0]["TotalBV"].ToString() + "* successfully. To view Invoice please click here https://toptimenet.com/?" + dt.Rows[0]["InvoiceNo"].ToString().Replace("/", "-");
                                    if (BillType == "1")
                                        WhatsApp.Send_WhatsApp_With_Header(dt.Rows[0]["AppMstMobile"].ToString().Trim(), Whatsappmsg, "TPV INVOICE");
                                    else if (BillType == "3")
                                        WhatsApp.Send_WhatsApp_With_Header(dt.Rows[0]["AppMstMobile"].ToString().Trim(), Whatsappmsg, "Repurchase INVOICE");
                                }
                            }

                        }
                        else if (PackStockType == "2")
                        {
                            // sendSMSFran(invoiceNo, totalamt.ToString());
                            DataTable dt = objDu.GetDataTable("Select F.FranchiseId, F.FName, F.Mobile, B.InvoiceNo, TotalFPV=isnull(B.TotalFPV,0), IS_OPTIN=isnull(F.IS_OPTIN,0), Doe=convert(nvarchar(10), B.doe, 103) FROM franchisemst F INNER JOIN StockTranReport B ON  F.FranchiseId=B.SoldTo WHERE B.srno=" + invoiceNo);
                            if (dt.Rows.Count > 0)
                            {
                                typeText = "FPV";
                                objResult.InvoiceNo = dt.Rows[0]["InvoiceNo"].ToString();
                                UserName = dt.Rows[0]["FName"].ToString();
                                if (UserName.Length > 20)
                                    UserName = UserName.Substring(0, 20).ToString();

                                Txt_Sms = "Dear " + UserName + " ID No " + dt.Rows[0]["FranchiseId"].ToString() + " Invoice No: " + dt.Rows[0]["InvoiceNo"].ToString() + " Invoice Amt : " + NetAmt + "generated successfully from Toptimenet.com Jai Toptime";


                                utility objUtil = new utility();
                                objUtil.sendSMSByBilling(dt.Rows[0]["Mobile"].ToString().Trim(), Txt_Sms, "INVOICE");

                                if (dt.Rows[0]["IS_OPTIN"].ToString() == "1")
                                {
                                    //String Whatsappmsg = "Dear " + dt.Rows[0]["AppMstRegNo"].ToString() + " " + dt.Rows[0]["AppmstFName"].ToString() + " your Invoice No " + dt.Rows[0]["InvoiceNo"].ToString() + " Dated *" + dt.Rows[0]["doe"].ToString() + "* for *" + NetAmt + "* has been generated Successfully. From www.toptimenet.com. *Jai Toptime*";
                                    //String Whatsappmsg = "Dear *" + dt.Rows[0]["FName"].ToString() + "* your *" + dt.Rows[0]["FranchiseId"].ToString() + "* Invoice " + dt.Rows[0]["InvoiceNo"].ToString() + "* date " + dt.Rows[0]["doe"].ToString() + "* has been generated for *" + NetAmt + "/-* and FPV: *" + dt.Rows[0]["TotalFPV"].ToString() + "* successfully. For downloading Invoice please click the Link " + Link + ". From www.toptimenet.com. *Jai Toptime*";
                                    //String Whatsappmsg = "Dear *" + dt.Rows[0]["FName"].ToString() + "* your Id *" + dt.Rows[0]["FranchiseId"].ToString() + "* Invoice No.*" + dt.Rows[0]["InvoiceNo"].ToString() + "* Date *" + dt.Rows[0]["doe"].ToString() + "* has been generated for *" + NetAmt + "/-* and *" + typeText + "*: *" + dt.Rows[0]["TotalFPV"].ToString() + "* successfully For downloading Invoice Please click the Link " + Link + " www.toptimenet.com";
                                    var Whatsappmsg = "Dear *" + dt.Rows[0]["FName"].ToString() + "* your id *" + dt.Rows[0]["FranchiseId"].ToString() + "* Invoice No. *" + dt.Rows[0]["InvoiceNo"].ToString() + "* Date *" + dt.Rows[0]["doe"].ToString() + "* has been generated for Rs *" + NetAmt + "/-* and *" + typeText + "*: *" + dt.Rows[0]["TotalFPV"].ToString() + "* successfully. To view Invoice please click here https://toptimenet.com/?" + dt.Rows[0]["InvoiceNo"].ToString().Replace("/", "-");


                                    //WhatsApp.Send_WhatsApp_MSG(dt.Rows[0]["Mobile"].ToString().Trim(), Whatsappmsg);
                                    WhatsApp.Send_WhatsApp_With_Header(dt.Rows[0]["Mobile"].ToString().Trim(), Whatsappmsg, "Franchise INVOICE");
                                }
                            }
                        }
                        else if (PackStockType == "3")
                        {
                            //sendSMSFranPO(invoiceNo, totalamt.ToString());
                            DataTable dt = objDu.GetDataTable("Select F.FranchiseId, F.FName, F.Mobile, B.InvoiceNo, IS_OPTIN=isnull(F.IS_OPTIN,0), Doe=convert(nvarchar(10), B.doe, 103)  FROM franchisemst F INNER JOIN PO_Mst B ON  F.FranchiseId=B.SoldTo WHERE B.srno=" + invoiceNo);
                            if (dt.Rows.Count > 0)
                            {
                                objResult.InvoiceNo = dt.Rows[0]["InvoiceNo"].ToString();
                                UserName = dt.Rows[0]["FName"].ToString();
                                if (UserName.Length > 20)
                                    UserName = UserName.Substring(0, 20).ToString();

                                Txt_Sms = "Dear " + UserName + " ID No " + dt.Rows[0]["FranchiseId"].ToString() + " Invoice No: " + dt.Rows[0]["InvoiceNo"].ToString() + " Invoice Amt : " + NetAmt + "generated successfully from Toptimenet.com Jai Toptime";


                                utility objUtil = new utility();
                                objUtil.sendSMSByBilling(dt.Rows[0]["Mobile"].ToString().Trim(), Txt_Sms, "INVOICE");

                                if (dt.Rows[0]["IS_OPTIN"].ToString() == "1")
                                {
                                    //String Whatsappmsg = "Dear " + dt.Rows[0]["AppMstRegNo"].ToString() + " " + dt.Rows[0]["AppmstFName"].ToString() + " your Invoice No " + dt.Rows[0]["InvoiceNo"].ToString() + " Dated *" + dt.Rows[0]["doe"].ToString() + "* for *" + NetAmt + "* has been generated Successfully. From www.toptimenet.com. *Jai Toptime*";
                                    //String Whatsappmsg = "Dear *" + dt.Rows[0]["FName"].ToString() + "* your *" + dt.Rows[0]["FranchiseId"].ToString() + "* Invoice " + dt.Rows[0]["InvoiceNo"].ToString() + "* date *" + dt.Rows[0]["doe"].ToString() + "* has been generated for *" + NetAmt + "/-* and 0 successfully. For downloading Invoice please click the Link " + Link + ". From www.toptimenet.com. *Jai Toptime*";
                                    //String Whatsappmsg = "Dear *" + dt.Rows[0]["FName"].ToString() + "* your Id *" + dt.Rows[0]["FranchiseId"].ToString() + "* Invoice No.*" + dt.Rows[0]["InvoiceNo"].ToString() + "* Date *" + dt.Rows[0]["doe"].ToString() + "* has been generated for *" + NetAmt + "/-* and *" + typeText + "*: *0* successfully For downloading Invoice Please click the Link " + Link + " www.toptimenet.com";
                                    var Whatsappmsg = "Dear *" + dt.Rows[0]["FName"].ToString() + "* your id *" + dt.Rows[0]["FranchiseId"].ToString() + "* Invoice No. *" + dt.Rows[0]["InvoiceNo"].ToString() + "* Date *" + dt.Rows[0]["doe"].ToString() + "* has been generated for Rs *" + NetAmt + "/-* and *" + typeText + "*: *0* successfully. To view Invoice please click here https://toptimenet.com/?" + dt.Rows[0]["InvoiceNo"].ToString().Replace("/", "-");

                                    WhatsApp.Send_WhatsApp_With_Header(dt.Rows[0]["Mobile"].ToString().Trim(), Whatsappmsg, "Purchase ORDER");

                                    //WhatsApp.Send_WhatsApp_MSG(dt.Rows[0]["Mobile"].ToString().Trim(), Whatsappmsg);

                                }
                            }
                        }

                        HttpContext.Current.Session["ITEMLISTID"] = null;
                        HttpContext.Current.Session["FranCart"] = null;

                        objResult.status = status;
                        objResult.Error = "";
                    }
                    else
                    {
                        objResult.Error = status;
                    }
                }
            }
        }
        catch (Exception er) { objResult.Error = er.Message.ToString(); }
        return objResult;
    }

    #endregion


    [WebMethod]
    public static string BindVariantProd(string batchid)
    {
        string Result = "";

        if (HttpContext.Current.Session["franchiseid"] == null)
        {
            return "Sessionlogout";
        }
        try
        {
            if (HttpContext.Current.Session["FranCart"] == null)
                CreateStucture();

            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
            if (Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault() != null)
            {
                return "1";
            }

            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@batchid", batchid), new SqlParameter("@SoldBy", HttpContext.Current.Session["franchiseid"].ToString()) };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "Get_Variant_Product_ForBilling");
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Error"].ToString() == "0")
                {
                    if (dt.Rows[0]["Qty"].ToString() != "0")
                    {

                        //DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
                        Double DPAmt = Convert.ToDouble(dt.Rows[0]["DPAmt"].ToString());
                        Double DPWithTax = Convert.ToDouble(dt.Rows[0]["DPWithTax"].ToString());
                        Double MRP = Convert.ToDouble(dt.Rows[0]["MRP"].ToString());

                        Double Tax = Convert.ToDouble(dt.Rows[0]["Tax"].ToString());
                        Double GSTAMT = Convert.ToDouble(dt.Rows[0]["GSTAMT"].ToString());
                        Double Disc_Perc_Val = Convert.ToDouble(dt.Rows[0]["Disc_Perc_Val"].ToString());


                        int Sno = 1;
                        if (Cartdt.Rows.Count > 0)
                            Sno = 1 + Convert.ToInt32(Cartdt.AsEnumerable().Max(row => row["Sno"]));

                        DataRow dr = Cartdt.NewRow();

                        dr["Sno"] = Sno;
                        dr["pid"] = dt.Rows[0]["pid"].ToString();
                        dr["batchid"] = dt.Rows[0]["batchid"].ToString();
                        dr["Pcode"] = dt.Rows[0]["Pcode"].ToString();
                        dr["pname"] = dt.Rows[0]["pname"].ToString();
                        dr["hsncode"] = dt.Rows[0]["HSNCode"].ToString();
                        dr["CaseSize"] = dt.Rows[0]["CaseSize"].ToString();

                        dr["BVAmt"] = dt.Rows[0]["BVAmt"].ToString();
                        dr["FPV"] = dt.Rows[0]["FPV"].ToString();
                        dr["totalbvamt"] = Math.Round(Convert.ToDouble(dt.Rows[0]["BVAmt"].ToString()), 2);
                        dr["TotalFPV"] = dt.Rows[0]["FPV"].ToString();



                        dr["MaxQty"] = dt.Rows[0]["MaxQty"].ToString();
                        dr["BatchQty"] = Convert.ToInt32(dt.Rows[0]["Qty"]);
                        dr["qty"] = 1;
                        dr["tax"] = Tax;
                        dr["BatchNo"] = dt.Rows[0]["BatchNo"].ToString();
                        dr["BatchDate"] = dt.Rows[0]["BatchDate"].ToString();
                        dr["ExpiryDate"] = dt.Rows[0]["ExpiryDate"].ToString();
                        dr["GSTAMT"] = GSTAMT;
                        dr["DPAmt"] = DPAmt;
                        dr["DPWithTax"] = dt.Rows[0]["DPWithTax"].ToString();
                        dr["Gross"] = dt.Rows[0]["DPWithTax"].ToString();
                        dr["MRP"] = MRP;
                        dr["Weight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString());
                        dr["TotalWeight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString()) * 1;
                        dr["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                        dr["TaxableAmt"] = Math.Round(DPWithTax, 2);

                        dr["totalamt"] = Math.Round((DPWithTax), 2);
                        dr["DiscounType"] = "%";
                        //dr["Discount"] = 0;
                        //dr["Disc_Perc_Val"] = 0;

                        dr["Discount"] = (MRP * Disc_Perc_Val / 100) * 1;
                        dr["Disc_Perc_Val"] = dt.Rows[0]["Disc_Perc_Val"].ToString();


                        dr["IsComboPack"] = "0";

                        Cartdt.Rows.Add(dr);
                        HttpContext.Current.Session["FranCart"] = Cartdt;

                        Calculater(Convert.ToInt32(dt.Rows[0]["batchid"]));

                    }
                }
            }
            // Calculat_Discount();
            Result = "";
        }
        catch (Exception er)
        {
            Result = er.Message.ToString();
        }
        return Result;
    }



    [WebMethod]
    public static ProdData GetBarcode(string Productcode, string DiscounType, string BillType, string Pack_Rep, string Userid)
    {
        ProdData objProd = new ProdData();
        objProd.Error = "";
        String[] strProduct = Productcode.Split(new String[] { "=" }, StringSplitOptions.RemoveEmptyEntries);
        try
        {
            if (strProduct[0] != null)
                Productcode = strProduct[0];
        }
        catch { }

        if (HttpContext.Current.Session["franchiseid"] == null)
        {
            objProd.Error = "Sessionlogout";
            return objProd;
        }


        try
        {
            if (HttpContext.Current.Session["FranCart"] == null)
                CreateStucture();

            SqlParameter[] param1 = new SqlParameter[]
            {
                new SqlParameter("@Productcode", Productcode)
            };

            string Pid = "0", IsComboPack = "0";
            DataUtility objDu = new DataUtility();
            DataTable DTNew = objDu.GetDataTable(param1, "Select Top 1 ProductId, IsVariant=isnull(IsVariant,0), IsComboPack=isnull(IsComboPack,0) from ShopProductMst where (productName=@Productcode or Productcode=@Productcode)");
            if (DTNew.Rows.Count > 0)
            {
                Pid = DTNew.Rows[0]["ProductId"].ToString();
                IsComboPack = DTNew.Rows[0]["IsComboPack"].ToString();
                if (DTNew.Rows[0]["IsVariant"].ToString().ToLower() == "true")
                {
                    SqlParameter[] param = new SqlParameter[]
                    {
                        new SqlParameter("@Pid", Pid),
                        new SqlParameter("@UserId", HttpContext.Current.Session["franchiseid"].ToString())
                    };
                    DataTable dt = objDu.GetDataTableSP(param, "GetVariantProduct");
                    foreach (DataRow dr in dt.Rows)
                    {
                        objProd.VeriantData += dr["batchid"].ToString() + "^" + dr["pname"].ToString() + " Qty: " + dr["Qty"].ToString() + "~";
                    }
                    objProd.Error = "VARIANT";
                    return objProd;
                }
            }
            else
            {
                Pid = "0";
                IsComboPack = "0";
            }

            if (Pid != "0")
            {
                utility obju = new utility();
                if (obju.IsNumeric(Pid) == true)
                {
                    DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
                    if (Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault() == null)
                    {
                        int Output = AddRow(Pid, BillType, Pack_Rep, "", 1, Userid, IsComboPack);
                        if (Output == 0)
                        {
                            objProd.Error = "0";
                            return objProd;
                        }

                    }
                    else
                    {
                        objProd.Error = "VARIANT";
                        return objProd;
                    }
                }
                else
                {
                    objProd.Error = "This : " + Pid + " Product not found.!!";
                    return objProd;
                }
            }
            else
            {
                objProd.Error = "This : " + Pid + " Product not found.!!";
                return objProd;
            }
        }
        catch (Exception er)
        {
            objProd.Error = er.Message.ToString();
        }
        return objProd;
    }



    [System.Web.Services.WebMethod]
    public static TradeProp Get_Trade_Values(string InvAmt, string OldAmt)
    {
        return common.Trade_Income_slabs(InvAmt, OldAmt);
    }


    private static int AddRow(string Pid, string BillType, string Pack_Rep, string BatchList, int AddQty, string Userid, string IsComboPack)
    {
        string SoldBy = "";
        try
        {
            if (BillType == "3")
                SoldBy = HttpContext.Current.Session["franchiseid"].ToString();
            else
                SoldBy = Userid;

            if (BillType != "3")
                Userid = HttpContext.Current.Session["franchiseid"].ToString();


            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@Pid", Pid),
                 new SqlParameter("@UserId", Userid),
                 new SqlParameter("@BillType", BillType),
                 new SqlParameter("@Pack_Rep", Pack_Rep),
                 new SqlParameter("@BatchList", BatchList),
                 new SqlParameter("@SoldBy", SoldBy),
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "Get_Detail_for_Barcode");
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Error"].ToString() == "0")
                {
                    if (dt.Rows[0]["Qty"].ToString() != "0")
                    {

                        DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
                        Double DPAmt = Convert.ToDouble(dt.Rows[0]["DPAmt"].ToString());
                        Double MRP = Convert.ToDouble(dt.Rows[0]["MRP"].ToString());
                        Double DPWithTax = Convert.ToDouble(dt.Rows[0]["DPWithTax"].ToString());
                        Double Tax = Convert.ToDouble(dt.Rows[0]["Tax"].ToString());
                        Double GSTAMT = Convert.ToDouble(dt.Rows[0]["GSTAMT"].ToString());
                        Double Disc_Perc_Val = Convert.ToDouble(dt.Rows[0]["Disc_Perc_Val"].ToString());

                        if (AddQty > Convert.ToInt32(dt.Rows[0]["Qty"]))
                            AddQty = Convert.ToInt32(dt.Rows[0]["Qty"]);


                        int Sno = 1;
                        if (Cartdt.Rows.Count > 0)
                            Sno = 1 + Convert.ToInt32(Cartdt.AsEnumerable().Max(row => row["Sno"]));

                        DataRow dr = Cartdt.NewRow();

                        dr["Sno"] = Sno;
                        dr["pid"] = dt.Rows[0]["pid"].ToString();
                        dr["batchid"] = dt.Rows[0]["batchid"].ToString();
                        dr["Pcode"] = dt.Rows[0]["Pcode"].ToString();
                        dr["pname"] = dt.Rows[0]["pname"].ToString();
                        dr["hsncode"] = dt.Rows[0]["HSNCode"].ToString();
                        dr["CaseSize"] = dt.Rows[0]["CaseSize"].ToString();

                        dr["BVAmt"] = dt.Rows[0]["BVAmt"].ToString();
                        dr["FPV"] = dt.Rows[0]["FPV"].ToString();
                        dr["totalbvamt"] = Math.Round(Convert.ToDouble(dt.Rows[0]["BVAmt"].ToString()), 2);
                        dr["TotalFPV"] = dt.Rows[0]["FPV"].ToString();



                        dr["MaxQty"] = dt.Rows[0]["MaxQty"].ToString();
                        dr["BatchQty"] = Convert.ToInt32(dt.Rows[0]["Qty"]);
                        dr["qty"] = AddQty;
                        dr["tax"] = Tax;
                        dr["BatchNo"] = dt.Rows[0]["BatchNo"].ToString();
                        dr["BatchDate"] = dt.Rows[0]["BatchDate"].ToString();
                        dr["ExpiryDate"] = dt.Rows[0]["ExpiryDate"].ToString();
                        dr["GSTAMT"] = GSTAMT;
                        dr["DPAmt"] = DPAmt;
                        dr["DPWithTax"] = dt.Rows[0]["DPWithTax"].ToString();
                        dr["Gross"] = Math.Round(DPAmt, 2);
                        dr["MRP"] = MRP;
                        dr["Weight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString());
                        dr["TotalWeight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString()) * AddQty;
                        dr["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                        dr["TaxableAmt"] = Math.Round(DPWithTax, 2);

                        dr["totalamt"] = Math.Round((DPWithTax), 2);
                        dr["DiscounType"] = "%";
                        //dr["Discount"] = 0;
                        //dr["Disc_Perc_Val"] = 0;


                        dr["Discount"] = (MRP * Disc_Perc_Val / 100) * AddQty;
                        dr["Disc_Perc_Val"] = Disc_Perc_Val;

                        dr["IsComboPack"] = IsComboPack;

                        Cartdt.Rows.Add(dr);
                        HttpContext.Current.Session["FranCart"] = Cartdt;

                        Calculater(Convert.ToInt32(dt.Rows[0]["batchid"]));
                    }
                    else
                    {
                        AddQty = 0;
                    }
                }

            }
            else
            {
                AddQty = 0;
            }
            //Calculat_Discount();
        }
        catch (Exception er) { }
        return AddQty;
    }



    [WebMethod]
    public static string UpdateQty(int batchid, int Qty, string BillType, string Pack_Rep, string Userid)
    {
        String Result = "";
        try
        {
            if (HttpContext.Current.Session["FranCart"] == null)
                return "Session";

            if (Qty <= 0)
                DeleteRecord(batchid);

            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();
                int Pid = findrow == null ? 0 : findrow.Field<int>("Pid");
                int BatchQty = findrow == null ? 0 : findrow.Field<int>("BatchQty");
                int MaxQty = findrow == null ? 0 : findrow.Field<int>("MaxQty");

                if (Qty > MaxQty)
                    Qty = MaxQty;

                if (Qty > BatchQty)
                {
                    /*Add multiple Rows*/

                    int BalQty = (Qty - BatchQty);
                    findrow["qty"] = BatchQty.ToString();
                    HttpContext.Current.Session["FranCart"] = Cartdt;
                    Calculater(batchid);

                    while (BalQty > 0)
                    {
                        int AddedQty = AddRow(Pid.ToString(), BillType, Pack_Rep, GetBatchList(Pid), BalQty, Userid, "0");
                        BalQty = BalQty - AddedQty;
                        if (AddedQty == 0)
                            BalQty = 0;
                    }
                }
                else
                {
                    findrow["qty"] = Qty.ToString();
                    HttpContext.Current.Session["FranCart"] = Cartdt;
                    Calculater(batchid);
                }
                /* else
                     Result = "Maximum Allowed : " + MaxQty.ToString();*/

            }
            // Calculat_Discount();
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    private static string GetBatchList(int Pid)
    {
        string BatchList = "";
        DataTable dt = (DataTable)HttpContext.Current.Session["FranCart"];
        foreach (DataRow dr in dt.Rows)
        {
            if (dr["Pid"].ToString() == Pid.ToString())
                BatchList += dr["batchid"].ToString() + ",";
        }
        return BatchList;
    }


    //private static void Calculat_Discount()
    //{
    //    if (HttpContext.Current.Session["IsCustomer"] != null)
    //    {
    //        if (HttpContext.Current.Session["IsCustomer"].ToString() == "False")
    //        {

    //            decimal OldAmt = 0;
    //            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
    //            object TaxableAmt = Cartdt.Compute("Sum(Gross)", "");

    //            if (HttpContext.Current.Session["OldAmt"] != null)
    //                OldAmt = Convert.ToDecimal(HttpContext.Current.Session["OldAmt"].ToString());

    //            TradeProp obj = common.Trade_Income_slabs(TaxableAmt.ToString(), OldAmt.ToString());
    //            if (Cartdt.Rows.Count > 0)
    //            {
    //                if (obj.DISC_Perc > 0)
    //                {
    //                    foreach (DataRow dr in Cartdt.Rows)
    //                    {
    //                        DataRow findrow = Cartdt.Select("batchid='" + dr["batchid"].ToString() + "'").FirstOrDefault();
    //                        findrow["Disc_Perc_Val"] = Math.Round(obj.DISC_Perc, 2);
    //                    }
    //                    HttpContext.Current.Session["FranCart"] = Cartdt;

    //                    foreach (DataRow dr in Cartdt.Rows)
    //                    {
    //                        Calculater(Convert.ToInt32(dr["batchid"].ToString()));
    //                    }
    //                }
    //                else
    //                {
    //                    foreach (DataRow dr in Cartdt.Rows)
    //                    {
    //                        DataRow findrow = Cartdt.Select("batchid='" + dr["batchid"].ToString() + "'").FirstOrDefault();
    //                        findrow["Disc_Perc_Val"] = 0;
    //                    }
    //                    HttpContext.Current.Session["FranCart"] = Cartdt;
    //                }
    //            }
    //        }
    //    }

    //}

    private static void Calculater(int batchid)
    {
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();

                int Qty = findrow == null ? 0 : findrow.Field<int>("qty");
                double tax = findrow == null ? 0 : findrow.Field<double>("tax");
                double DPWithTax = findrow == null ? 0 : findrow.Field<double>("DPWithTax");
                double DPAmt = findrow == null ? 0 : findrow.Field<double>("DPAmt");
                double MRP = findrow == null ? 0 : findrow.Field<double>("MRP");

                double BV = findrow == null ? 0 : findrow.Field<double>("BVAmt");
                double FPV = findrow == null ? 0 : findrow.Field<double>("FPV");
                double Discount = findrow == null ? 0 : findrow.Field<double>("Discount");
                double Disc_Perc_Val = findrow == null ? 0 : findrow.Field<double>("Disc_Perc_Val");

                string DiscounType = findrow == null ? "%" : findrow.Field<string>("DiscounType");
                double Weight = findrow == null ? 0 : findrow.Field<double>("Weight");
                double GSTAMT = 0, Gross = 0;

                if (DiscounType == "%")
                {
                    Gross = (DPAmt * Qty);
                    findrow["Gross"] = Math.Round(Gross, 2);

                    Discount = (MRP * Disc_Perc_Val / 100) * Qty;
                    //Discount = (MRP - DPWithTax) * Qty;
                    //Discount = (Gross * Disc_Perc_Val / 100);
                    //Gross = (Gross - Discount);
                    //Gross = (Gross * 100 / (100 + tax));
                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 2, MidpointRounding.ToEven);
                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 2, MidpointRounding.ToEven);

                    findrow["GSTAMT"] = Math.Round(GSTAMT / Qty, 2);
                    findrow["TaxableAmt"] = Math.Round(Gross, 2);
                    findrow["totalamt"] = Math.Round(Gross + GSTAMT, 2);
                    findrow["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                }
                else
                {
                    Gross = (DPAmt * Qty);
                    findrow["Gross"] = Math.Round(Gross, 2);
                    //Gross = (Gross - Discount);
                    //Gross = (Gross * 100 / (100 + tax));

                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 2, MidpointRounding.ToEven);
                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 2, MidpointRounding.ToEven);
                    findrow["GSTAMT"] = Math.Round(GSTAMT * Qty, 2);
                    findrow["TaxableAmt"] = Math.Round(Gross, 2);
                    findrow["totalamt"] = Math.Round(Gross + GSTAMT, 2);
                    findrow["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                }
                //findrow["DPAmt"] = Math.Round((Gross * 100 / (100 + tax)), 2);
                findrow["Discount"] = Math.Round(Discount, 2);
                findrow["TotalWeight"] = (Weight * Qty);
                findrow["totalbvamt"] = Qty * BV;
                findrow["TotalFPV"] = Qty * FPV;

                HttpContext.Current.Session["FranCart"] = Cartdt;
            }
        }
        catch (Exception er) { }
    }





    [WebMethod]
    public static string DeleteProd(int batchid)
    {
        String Result = "";
        try
        {
            DeleteRecord(batchid);
            //Calculater(batchid);
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    private static string DeleteRecord(int batchid)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();
                Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
                findrow.Delete();
                HttpContext.Current.Session["FranCart"] = Cartdt;
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    [WebMethod]
    public static ProdDetails[] GetCartData()
    {
        List<ProdDetails> details = new List<ProdDetails>();
        if (HttpContext.Current.Session["FranCart"] != null)
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
            ITEMLISTID = "";

            DataView view = Cartdt.DefaultView;
            view.Sort = "Sno Desc";
            DataTable dt_Sorted = view.ToTable();

            foreach (DataRow dr in dt_Sorted.Rows)
            {
                ITEMLISTID += dr["pid"].ToString() + "^" + dr["qty"].ToString() + ",";

                ProdDetails data = new ProdDetails();
                data.Pid = Convert.ToInt32(dr["pid"].ToString().Trim());
                data.batchid = Convert.ToInt32(dr["batchid"].ToString().Trim());
                data.DiscounType = dr["DiscounType"].ToString();
                data.Disc_Perc_Val = Convert.ToDouble(dr["Disc_Perc_Val"].ToString());

                data.pname = dr["pname"].ToString();
                data.Pcode = dr["Pcode"].ToString();
                data.hsncode = dr["hsncode"].ToString();
                data.CaseSize = dr["CaseSize"].ToString();
                data.qty = Convert.ToInt32(dr["qty"].ToString());
                data.MaxQty = Convert.ToInt32(dr["MaxQty"].ToString());

                data.TaxableAmt = Convert.ToDouble(dr["TaxableAmt"].ToString());
                data.Discount = Convert.ToDouble(dr["Discount"].ToString());
                data.BatchNo = dr["BatchNo"].ToString();
                data.BatchDate = dr["BatchDate"].ToString();
                data.ExpiryDate = dr["ExpiryDate"].ToString();

                data.GSTAMT = Convert.ToDouble(dr["GSTAMT"].ToString());
                data.DPAmt = Convert.ToDouble(dr["DPAmt"].ToString());
                data.MRP = Convert.ToDouble(dr["MRP"].ToString());
                data.DPWithTax = Convert.ToDouble(dr["DPWithTax"].ToString());

                data.Gross = Convert.ToDouble(dr["Gross"].ToString());
                data.BVAmt = Convert.ToDouble(dr["BVAmt"].ToString());
                data.totalbvamt = Convert.ToDouble(dr["totalbvamt"].ToString());

                data.FPV = Convert.ToDouble(dr["FPV"].ToString());
                data.TotalFPV = Convert.ToDouble(dr["TotalFPV"].ToString());



                data.tax = Convert.ToDouble(dr["tax"].ToString());
                data.Totaltaxamt = Convert.ToDouble(dr["Totaltaxamt"].ToString());
                data.totalamt = Convert.ToDouble(dr["totalamt"].ToString());
                data.TotalWeight = Convert.ToDouble(dr["TotalWeight"].ToString());
                data.IsComboPack = dr["IsComboPack"].ToString();

                details.Add(data);

            }

            HttpContext.Current.Session["ITEMLISTID"] = ITEMLISTID;
        }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static commanProp[] GetOfferProduct(string TotalAmt, string TotalBV, String BillType, String OfferOn)
    {
        List<commanProp> details = new List<commanProp>();
        if (HttpContext.Current.Session["ITEMLISTID"] != null)
        {
            ITEMLISTID = HttpContext.Current.Session["ITEMLISTID"].ToString();
            DataTable dt = Offer_Product_List(ITEMLISTID, TotalAmt, TotalBV, BillType, OfferOn);
            foreach (DataRow row in dt.Rows)
            {
                commanProp obj = new commanProp();
                obj.SID = row["SID"].ToString();
                obj.Scheme = row["Scheme"].ToString();
                obj.Item_Qty = Convert.ToInt32(row["Item_Qty"]);
                obj.ITEMID = Convert.ToInt32(row["ITEMID"]);
                obj.ItemName = row["ItemName"].ToString();
                obj.ProdOffer = row["ProdOffer"].ToString();
                obj.RS = Convert.ToDouble(row["RS"].ToString());
                obj.NoofItem = Convert.ToInt32(row["NoofItem"]);
                obj.Offer_Type = row["Offer_Type"].ToString();
                obj.PId = Convert.ToInt32(row["PId"]);
                obj.Category_wise_item = Convert.ToInt32(row["Category_wise_item"]);

                obj.MaxAmount = Convert.ToDouble(row["MaxAmount"].ToString());
                obj.flushed = Convert.ToInt32(row["flushed"]);

                details.Add(obj);
            }
        }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static DataTable Offer_Product_List(String ITEMLISTID, String TotalAmt, String TotalBV, String BillType, String OfferOn)
    {
        SqlParameter[] param = new SqlParameter[]
        {
         new SqlParameter("@Productlist", ITEMLISTID),
         new SqlParameter("@TotalAmt", TotalAmt),
         new SqlParameter("@TotalBV", TotalBV),
         new SqlParameter("@BillType", BillType),
         new SqlParameter("@OfferOn", OfferOn),
        };
        DataUtility objDu = new DataUtility();
        return objDu.GetDataTableSP(param, "Get_OfferProduct_Details");
    }






    [System.Web.Services.WebMethod]
    public static DataTable GetSchemeItemId(string SchemeItemId)
    {
        SqlParameter[] param = new SqlParameter[]
        {
        new SqlParameter("@SchemeItemId", SchemeItemId),
        new SqlParameter("@soldby", HttpContext.Current.Session["franchiseid"].ToString()),
        };
        DataUtility objDu = new DataUtility();
        return objDu.GetDataTableSP(param, "Get_SchemeItem");

    }



    [WebMethod]
    public static UserDetails GetUser(string Userid, string Self_Validate, string BillType)
    {
        UserDetails objUser = new UserDetails();
        if (Userid == HttpContext.Current.Session["franchiseid"].ToString() && Self_Validate != "1")
        {
            objUser.Error = "Can't generate to self-purchase order.!!";
            return objUser;
        }
        Userid = Userid.Trim();
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("checkuserdetail", con);
            SqlDataReader dr;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", Userid.Trim());
            cmd.Parameters.AddWithValue("@BillType", BillType);
            cmd.Parameters.AddWithValue("@SessionId", HttpContext.Current.Session["franchiseid"].ToString());
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                if (dr["Error"].ToString() == "")
                {
                    string UserName = dr["name"].ToString();
                    if (dr["IsCustomer"].ToString() == "True")
                        UserName += " (Customer)";
                    else
                        UserName += " (" + method.Associate + ")";

                    //UserName += "<br> Total Purchase:" + dr["jamount"].ToString();

                    objUser.Error = "";
                    objUser.UserName = UserName;
                    objUser.IsAWC = dr["IsAWC"].ToString();
                    objUser.Address = dr["AppMstAddress1"].ToString();
                    objUser.State = dr["AppMstState"].ToString();
                    objUser.City = dr["AppMstCity"].ToString();
                    objUser.Pincode = dr["AppMstPinCode"].ToString();
                    objUser.AdminState = dr["AdminState"].ToString();
                    objUser.JoinFor = dr["JoinFor"].ToString();
                    objUser.Mobile = dr["AppMstMobile"].ToString();
                    objUser.distt = dr["distt"].ToString();
                    objUser.jamount = dr["jamount"].ToString();
                    objUser.IsCustomer = dr["IsCustomer"].ToString();

                    HttpContext.Current.Session["OldAmt"] = dr["jamount"].ToString();
                    HttpContext.Current.Session["IsCustomer"] = dr["IsCustomer"].ToString();
                }
                else
                {
                    objUser.Error = dr["Error"].ToString();
                }
            }
            else
            {
                objUser.Error = "User Does Not Exists!";
            }
            dr.Close();
            con.Close();
        }
        catch (Exception er) { objUser.Error = "Server error. Time out.!!"; }
        return objUser;
    }


    public void BindState()
    {
        DataUtility objDUT = new DataUtility();
        DataTable dt = new DataTable();
        SqlParameter[] sqlparam = new SqlParameter[] {
            };
        dt = objDUT.GetDataTable(sqlparam, "GetState");

        if (dt.Rows.Count > 0)
        {
            ddl_state.Items.Clear();
            ddl_state.DataSource = dt;
            ddl_state.DataTextField = "StateName";
            ddl_state.DataValueField = "Id";
            ddl_state.DataBind();
            ddl_state.Items.Insert(0, new ListItem("Select State", "0"));

            ddlSellerState.Items.Clear();
            ddlSellerState.DataSource = dt;
            ddlSellerState.DataTextField = "StateName";
            ddlSellerState.DataValueField = "Id";
            ddlSellerState.DataBind();
            ddlSellerState.Items.Insert(0, new ListItem("Seller State", "0"));

            BindAdminState();
        }
    }


    [WebMethod]
    public static ArrayList GetDistrict(string StateId)
    {
        ArrayList list = new ArrayList();
        try
        {
            DataUtility objDUT = new DataUtility();
            SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@state", StateId) };
            DataTable dt = objDUT.GetDataTableSP(sqlparam, "GetStateDistrict");
            foreach (DataRow dr in dt.Rows)
            { list.Add(new ListItem(dr["DistrictName"].ToString(), dr["DistrictName"].ToString())); }
        }
        catch (Exception er) { }
        return list;
    }


    [WebMethod]
    public static string GetBalanceUser(string RegNo, string WalletType)
    {
        String Balance = "0";
        try
        {
            string ProcName = "";
            if (WalletType == "16")
                ProcName = "GetWalletProductBalance";
            else if (WalletType == "7")
                ProcName = "getPayoutBalanceUser";
            else if (WalletType == "8")
                ProcName = "getwalletBalanceUser";
            else if (WalletType == "9")
                ProcName = "getRedeemWalletBal";
            else if (WalletType == "10")
                ProcName = "getwalletBalanceFran";
            else if (WalletType == "11")
                ProcName = "getTopperBalanceUser";
            else if (WalletType == "12")
                ProcName = "getRewardBalanceUser";


            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand(ProcName, con);
            com.CommandType = CommandType.StoredProcedure;
            if (WalletType == "10")
                com.Parameters.AddWithValue("@appmstid", RegNo);
            else
                com.Parameters.AddWithValue("@AppMstRegNo", RegNo);

            com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            Balance = com.Parameters["@Bal"].Value.ToString();
        }
        catch (Exception ex) { }
        return Balance;
    }


    public void BindAdminState()
    {

        string BillType = "1", PackType = "0";
        if (Request.QueryString.Count > 0)
        {
            if (Request.QueryString["BT"] != null)
            {
                BillType = Request.QueryString["BT"].ToString();
                ddltype.SelectedValue = BillType;
            }
            if (Request.QueryString["PT"] != null)
            {
                PackType = Request.QueryString["PT"].ToString();
                ddl_BillType.SelectedValue = PackType;
            }
        }

        if (ddltype.SelectedValue == "1")
            PackType = ddl_BillType.SelectedValue;
        else
            PackType = "0";



        DataUtility objDUT = new DataUtility();
        DataTable dt = new DataTable();
        SqlParameter[] sqlparam = new SqlParameter[] {
             new SqlParameter("@regno", Session["franchiseid"].ToString())
        };
        dt = objDUT.GetDataTableSP(sqlparam, "GetAdminState");
        if (dt.Rows.Count > 0)
        {
            ddlSellerState.SelectedValue = dt.Rows[0]["AdminState"].ToString();

            if (BillType == "1")
            {
                if (dt.Rows[0]["SampleAllowed"].ToString() == "1")
                { ddl_BillType.Items.Insert(0, new ListItem("Free Sample", "5")); }

                // ddl_BillType.Items.Insert(0, new ListItem("Product Wallet", "6"));

                // ddl_BillType.Items.Insert(0, new ListItem("AWC Billing", "7"));

                //   ddl_BillType.Items.Insert(0, new ListItem("Loyalty Redeem", "4"));

                ddl_BillType.Items.Insert(0, new ListItem("Generation", "3"));

                // ddl_BillType.Items.Insert(0, new ListItem("First Billing", "1"));

            }
            if (BillType == "2")
            {
                if (dt.Rows[0]["SampleAllowed"].ToString() == "1")
                { ddl_BillType.Items.Insert(0, new ListItem("Free Sample", "5")); }

                ddl_BillType.Items.Insert(0, new ListItem("Normal Invoice", "0"));
            }
            if (BillType == "3")
            {
                ddl_BillType.Items.Insert(0, new ListItem("Normal Invoice", "0"));
            }
        }
    }



    public void BindUserProduct()
    {
        string BillType = "", PackType = "0", Userid = "";
        if (Request.QueryString.Count > 0)
        {
            if (Request.QueryString["BT"] != null)
            {
                BillType = Request.QueryString["BT"].ToString();
                ddltype.SelectedValue = BillType;
            }
            if (Request.QueryString["PT"] != null)
            {
                PackType = Request.QueryString["PT"].ToString();
                ddl_BillType.SelectedValue = PackType;
            }
        }

        if (ddltype.SelectedValue == "1")
            PackType = ddl_BillType.SelectedValue;
        else
            PackType = "0";

        if (ddltype.SelectedValue != "3")
            Userid = Session["franchiseid"].ToString();

        SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@PackType", PackType),
                new SqlParameter("@BillType", BillType),
                new SqlParameter("@Userid", Userid)
            };

        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetShopProduct_Billing");
        foreach (DataRow dr in dt.Rows)
        {
            if (ddltype.SelectedValue == "3")
            {
                divProductcode.InnerText += dr["productCode"].ToString() + "= " + dr["ProductName"].ToString() + " (" + dr["PackSize"].ToString() + ") Qty: " + dr["Qty"].ToString() + ",";
            }
            else
            {
                if (dr["Qty"].ToString() != "0")
                    divProductcode.InnerText += dr["productCode"].ToString() + "= " + dr["ProductName"].ToString() + " (" + dr["PackSize"].ToString() + ") Qty: " + dr["Qty"].ToString() + ",";

            }
        }
    }



    [WebMethod]
    public static string GetReferenceUserProduct(string BillType)
    {
        string Result = "0";
        try
        {

            if (HttpContext.Current.Session["FranCart"] != null)
            {
                DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
                foreach (DataRow dr in Cartdt.Rows)
                {
                    DataTable dt = null;
                    if (HttpContext.Current.Session["RefProd"] == null)
                    {
                        DataUtility objDu = new DataUtility();
                        dt = objDu.GetDataTable("Select Productid from Shopproductmst where IsRefUser=1");
                        HttpContext.Current.Session["RefProd"] = dt;
                    }
                    else
                    {
                        dt = (DataTable)HttpContext.Current.Session["RefProd"];
                    }
                    foreach (DataRow Ref_dr in dt.Rows)
                    {
                        if (dr["pid"].ToString() == Ref_dr["Productid"].ToString())
                            Result = "1";
                    }
                }
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }





    [WebMethod]
    public static string GenerateOTP(string UserName, string Amount)
    {
        string Result = "0";
        DataTable dt = new DataTable();
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        da = new SqlDataAdapter("GenerateOTP", con);
        da.SelectCommand.Parameters.AddWithValue("@RegNo", UserName);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            utility objUtil = new utility();
            //String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 30 min ";
            String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 15 min from:toptimenet.com Jai Toptime";

            objUtil.sendSMSByBilling(dt.Rows[0]["AppMstMobile"].ToString().Trim(), msg, "OTP");

            if (dt.Rows[0]["IS_OPTIN"].ToString() == "1")
            {
                String Whatsappmsg = "OTP is *" + dt.Rows[0]["OTP"].ToString().Trim() + "* for transaction and is valid for 15 minutes. From www.toptimenet.com. *Jai Toptime*";
                WhatsApp.Send_WhatsApp_MSG(dt.Rows[0]["AppMstMobile"].ToString().Trim(), Whatsappmsg);
            }
        }
        return Result;
    }


    [WebMethod]
    public static string VerifyOTP(string UserName, string OTP)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("VerifyOTP", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@RegNo", UserName);
        com.Parameters.AddWithValue("@OTP", OTP);
        com.Parameters.Add("@IsValid", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        return com.Parameters["@IsValid"].Value.ToString();
    }




    public void payoutdate()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("checkbillpayout", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        com.Parameters.AddWithValue("@Master", "BILLSTATUS");
        con.Open();
        com.ExecuteNonQuery();
        string status = com.Parameters["@flag"].Value.ToString();
        con.Close();
        if (status != "1")
            Response.Redirect("Maintainance.aspx", false);
    }


    public void checkpage()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("pageprocess", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@action", "1");
        con.Open();
        SqlDataReader dr = com.ExecuteReader();
        while (dr.Read())
        {
            hnd_Barcode.Value = dr["Barcode"].ToString();

            if (dr["Barcode"].ToString() == "1")
                txt_Barcode.Attributes.Add("onchange", "javascript:GetProduct()");
            else
                txt_Barcode.Attributes.Add("onblur", "javascript:GetProduct()");

            if (dr["billing"].ToString() == "OFF")
                Response.Redirect("Maintainance.aspx");
        }
    }


    [WebMethod]
    public static string ChkBarcode()
    {
        SqlParameter[] param = new SqlParameter[]
        {
          new SqlParameter("@action","5")
        };
        DataUtility Dutil = new DataUtility();
        object t = Dutil.GetScalerSP(param, "pageprocess");
        return "";
    }



    [WebMethod]
    public static string ResetCart()
    {
        HttpContext.Current.Session["FranCart"] = null;
        return "";
    }


    private static string BindPOCart()
    {
        String Result = "", Userid = method.DEFAULT_SELLER;
        try
        {
            if (HttpContext.Current.Request.QueryString.Count > 0)
            {
                if (HttpContext.Current.Request.QueryString["PO"] != null && HttpContext.Current.Request.QueryString["PO"].ToString() == "1" && HttpContext.Current.Request.QueryString["BT"].ToString() == "3" && HttpContext.Current.Request.QueryString["PT"].ToString() == "3")
                {
                    if (HttpContext.Current.Session["POCart"] != null)
                    {
                        if (HttpContext.Current.Session["FranCart"] == null)
                            CreateStucture();

                        DataTable POCartdt = (DataTable)HttpContext.Current.Session["POCart"];
                        foreach (DataRow dr in POCartdt.Rows)
                        {
                            int Qty = Convert.ToInt32(dr["Requirement"].ToString());
                            if (Qty > 0)
                            {
                                AddRow(dr["Pid"].ToString(), "3", "3", "", 1, Userid, "0");

                                DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranCart"];
                                if (Cartdt.Rows.Count > 0)
                                {
                                    DataRow findrow = Cartdt.Select("Pid='" + dr["Pid"].ToString() + "'").FirstOrDefault();
                                    int batchid = findrow == null ? 0 : findrow.Field<int>("batchid");

                                    UpdateQty(batchid, Qty, "3", "3", Userid);
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }

    #region Stucture

    private static void CreateStucture()
    {

        DataTable dtStuc = new DataTable();
        dtStuc.Columns.Add(new DataColumn("Sno", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("Pid", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("DiscounType", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("Pcode", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("pname", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("hsncode", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("CaseSize", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("Discount", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Disc_Perc_Val", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("qty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("batchid", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("BatchNo", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("BatchDate", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("ExpiryDate", typeof(string)));

        dtStuc.Columns.Add(new DataColumn("BatchQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("MaxQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("DPAmt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("DPWithTax", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("MRP", typeof(double)));

        dtStuc.Columns.Add(new DataColumn("Gross", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("TaxableAmt", typeof(double)));

        dtStuc.Columns.Add(new DataColumn("BVAmt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("totalbvamt", typeof(double)));

        dtStuc.Columns.Add(new DataColumn("FPV", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("TotalFPV", typeof(double)));

        dtStuc.Columns.Add(new DataColumn("tax", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Totaltaxamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Weight", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("TotalWeight", typeof(double)));


        dtStuc.Columns.Add(new DataColumn("totalamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("GSTAMT", typeof(double)));

        dtStuc.Columns.Add(new DataColumn("IsComboPack", typeof(string)));

        HttpContext.Current.Session["FranCart"] = dtStuc;
    }

    #endregion


    #region ClassProperty

    public class ProdDetails
    {
        public int Sno { get; set; }
        public int Pid { get; set; }
        public String pname { get; set; }
        public String hsncode { get; set; }
        public String CaseSize { get; set; }
        public String Pcode { get; set; }
        public int qty { get; set; }
        public int batchid { get; set; }
        public String BatchNo { get; set; }
        public String BatchDate { get; set; }
        public String ExpiryDate { get; set; }
        public int BatchQty { get; set; }
        public int MaxQty { get; set; }

        public String DiscounType { get; set; }
        public double Discount { get; set; }
        public double Disc_Perc_Val { get; set; }
        public double MRP { get; set; }
        public double DPAmt { get; set; }
        public double DPWithTax { get; set; }
        public double Gross { get; set; }
        public double TaxableAmt { get; set; }
        public double BVAmt { get; set; }
        public double totalbvamt { get; set; }
        public double FPV { get; set; }
        public double TotalFPV { get; set; }

        public double tax { get; set; }
        public double Totaltaxamt { get; set; }
        public double totalamt { get; set; }
        public double GSTAMT { get; set; }
        public double Weight { get; set; }
        public double TotalWeight { get; set; }
        public String IsComboPack { get; set; }

    }

    public class Results
    {
        public String Error { get; set; }
        public String InvoiceNo { get; set; }
        public String status { get; set; }
        public String Url { get; set; }

    }

    public class ProdData
    {
        public String Error { get; set; }
        public String VeriantData { get; set; }

    }


    public class UserDetails
    {
        public String Error { get; set; }
        public String UserName { get; set; }
        public String Address { get; set; }
        public String State { get; set; }
        public String AdminState { get; set; }
        public String City { get; set; }
        public String Pincode { get; set; }
        public String JoinFor { get; set; }
        public String Mobile { get; set; }
        public String distt { get; set; }
        public String IsAWC { get; set; }
        public String IsCustomer { get; set; }
        public String jamount { get; set; }

    }

    public class commanProp
    {
        public string SID { get; set; }
        public string Scheme { get; set; }
        public int Item_Qty { get; set; }
        public int ITEMID { get; set; }
        public string ItemName { get; set; }
        public string ProdOffer { get; set; }
        public double RS { get; set; }
        public int NoofItem { get; set; }
        public string Offer_Type { get; set; }
        public int PId { get; set; }
        public int Category_wise_item { get; set; }

        public double MaxAmount { get; set; }
        public int flushed { get; set; }

    }


    #endregion


    protected void ddltype_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("BarcodeBilling.aspx?BT=" + ddltype.SelectedValue + "&PT=" + ddl_BillType.SelectedValue);
    }


}