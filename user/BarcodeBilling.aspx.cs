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
    static string ITEMLISTID = "", SalesRep = method.DEFAULT_SELLER;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                if (Session["userId"] == null)
                    Response.Redirect("~/Login.aspx");
                else
                    txt_Userid.Text = Session["userId"].ToString();

                txtbilldate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

                payoutdate();
                checkpage();
                BindState();
                BindUserProduct();
                HttpContext.Current.Session["UserCart"] = null;

            }
        }
        catch (Exception er) { }
    }


    #region Genearate Invoice
    [WebMethod]
    public static Results GenerateInv(string PackStockType, string BillType, string UserId, string Discount, string DISC_Perc, string DelCharge, string User_State, string Admin_State, string paymode, string bankname, string checkno, string CheDate,
    string toAdd, string GSTNo, string PlaseOfSuply, string SellerState, string BillDate, string SchemeItemIdStr, string EwayNo, string paymodeVal, string UserRemark, string Ref_User, string Adjustment)
    {

        double SchemeAmt = 0, SchemeTaxRs = 0;
        int TotalQnty = 0;
        Results objResult = new Results();
        UserId = UserId.Trim();
        if (UserId == "")
        {
            objResult.Error = "Please Enter User Id.";
            return objResult;
        }
        if (HttpContext.Current.Session["userId"] == null)
        {
            objResult.Error = "Sessionlogout";
            return objResult;
        }
        XElement element = null;
        try
        {
            DateTime BillDate_New = new DateTime();
            DateTime CheDate_New = new DateTime();
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            try
            {
                if (BillDate != null)
                    BillDate_New = Convert.ToDateTime(BillDate.Trim(), dateInfo);
                else
                    BillDate_New = DateTime.Now;

                if (paymode != "Cash")
                    CheDate_New = Convert.ToDateTime(CheDate.Trim(), dateInfo);
                else
                    CheDate_New = DateTime.Now;
            }
            catch (Exception er)
            {
                objResult.Error = er.Message;
                return objResult;
            }

            string OFFERID = "0";
            if (BillType == "4" || BillType == "6")
            {
                OFFERID = "-111";
            }

            DataTable Cartdt = (DataTable)HttpContext.Current.Session["UserCart"];
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
                                new XElement("dis_type", row["DiscounType"].ToString()),
                                new XElement("hsncode", row["hsncode"].ToString()),
                                new XElement("Qnt", row["qty"].ToString()),
                                new XElement("MRP", row["MRP"].ToString()),
                                new XElement("TAX", row["Tax"].ToString()),
                                new XElement("TAXRS", row["Totaltaxamt"].ToString()),
                                new XElement("DP", row["DPAmt"].ToString()),
                                new XElement("DPWithTax", row["DPWithTax"].ToString()),
                                new XElement("BV", row["totalbvamt"].ToString()),
                                new XElement("gross", row["gross"].ToString()),
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

                        double TAXRS = Math.Round((MRP * (Convert.ToDouble(row["Tax"].ToString()) / 2) / 100), 4, MidpointRounding.ToEven);
                        TAXRS = TAXRS + Math.Round((MRP * (Convert.ToDouble(row["Tax"].ToString()) / 2) / 100), 4, MidpointRounding.ToEven);

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
                            new XElement("dis_type", "Rs"),
                            new XElement("hsncode", row["HSNCode"].ToString()),
                            new XElement("Qnt", row["quantity"].ToString()),
                            new XElement("MRP", MRP),
                            new XElement("TAX", row["Tax"].ToString()),
                            new XElement("TAXRS", TAXRS),
                            new XElement("DP", MRP),
                            new XElement("DPWithTax", DPWithTax),
                            new XElement("BV", 0),
                            new XElement("gross", DPWithTax),
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
                    object sumqty, totalamt, GrossAmt, totalBV, TaxRs, NetAmt;
                    sumqty = Cartdt.Compute("Sum(qty)", "");
                    totalamt = Cartdt.Compute("Sum(totalamt)", "");
                    GrossAmt = Cartdt.Compute("Sum(Gross)", "");
                    totalBV = Cartdt.Compute("Sum(totalbvamt)", "");
                    TaxRs = Cartdt.Compute("Sum(Totaltaxamt)", "");
                    NetAmt = (Convert.ToDouble(totalamt) + Convert.ToDouble(DelCharge) - Convert.ToDouble(Discount));

                    SqlConnection con = new SqlConnection(method.str);
                    string ProcedureName = "";
                    if (paymodeVal == "5" || paymodeVal == "13") // 5= Paytm 13= Razorpay 14=OpenMoney removed code || paymodeVal == "14"
                        ProcedureName = "AddOrder";
                    else
                        ProcedureName = "AddBill";


                    string ExtraPV = "0";


                    SqlCommand com = new SqlCommand(ProcedureName, con);
                    com.CommandType = CommandType.StoredProcedure;
                    if (paymodeVal == "5" || paymodeVal == "13") // removed code || paymodeVal == "14"
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
                        com.Parameters.AddWithValue("@saleRep", SalesRep);
                        com.Parameters.AddWithValue("@toAdd", toAdd);
                        com.Parameters.AddWithValue("@bankname", bankname);
                        com.Parameters.AddWithValue("@checkdate", CheDate_New);
                        com.Parameters.AddWithValue("@checkno", checkno);
                        com.Parameters.AddWithValue("@paymode", paymode);
                        com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
                        com.Parameters.AddWithValue("@PartyGSTNo", GSTNo);
                        com.Parameters.AddWithValue("@PlaceOfSupply", PlaseOfSuply);
                        com.Parameters.AddWithValue("@sellerstate", SellerState);
                        com.Parameters.AddWithValue("@BillingDate", BillDate_New);
                        com.Parameters.AddWithValue("@UserRemark", UserRemark);
                        com.Parameters.AddWithValue("@Ref_User", Ref_User);
                        com.Parameters.AddWithValue("@ExtraPV", ExtraPV);
                        com.Parameters.AddWithValue("@DISC_Perc", DISC_Perc);

                        com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                        com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                        com.Parameters.AddWithValue("@AdjustmentAmt", Adjustment);
                    }
                    else
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
                        com.Parameters.AddWithValue("@saleRep", SalesRep);
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
                        com.Parameters.AddWithValue("@UserRemark", UserRemark);
                        com.Parameters.AddWithValue("@Ref_User", Ref_User);
                        com.Parameters.AddWithValue("@ExtraPV", ExtraPV);
                        com.Parameters.AddWithValue("@DISC_Perc", DISC_Perc);
                        com.Parameters.AddWithValue("@IsOnline", 0);
                        
                        com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                        com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                        com.Parameters.AddWithValue("@AdjustmentAmt", Adjustment);
                    }
                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    string status = com.Parameters["@flag"].Value.ToString();
                    string invoiceNo = com.Parameters["@InvNo"].Value.ToString();
                    if (status == "1")
                    {

                        string typeText = "TPV", UserName = "", Txt_Sms = "";
                        DataUtility objDu = new DataUtility();
                        if (paymodeVal == "5" || paymodeVal == "13") // removed code || paymodeVal == "14"
                        {
                            objResult.InvoiceNo = secure.Encrypt(invoiceNo);
                        }
                        else
                        {
                            DataTable dt = objDu.GetDataTable("Select A.AppMstRegNo, AppMstFName, A.AppMstMobile, B.InvoiceNo, b.TotalBV, Doe=convert(nvarchar(10), b.doe, 103), IS_OPTIN=isnull(A.IS_OPTIN,0) FROM AppMst A INNER JOIN BillMst B ON  A.AppMstRegNo=B.SoldTo WHERE B.srno=" + invoiceNo);
                            if (dt.Rows.Count > 0)
                            {
                                objResult.InvoiceNo = dt.Rows[0]["InvoiceNo"].ToString();
                                UserName = dt.Rows[0]["AppmstFName"].ToString();

                                if (UserName.Length > 20)
                                    UserName = UserName.Substring(0, 20).ToString();

                                Txt_Sms = "Dear " + UserName + " ID No " + dt.Rows[0]["AppMstRegNo"].ToString() + " Invoice No: " + dt.Rows[0]["InvoiceNo"].ToString() + " Invoice Amt : " + NetAmt + "generated successfully from Toptimenet.com Jai Toptime";

                                utility objUtil = new utility();
                                objUtil.sendSMSByBilling(dt.Rows[0]["AppMstMobile"].ToString().Trim(), Txt_Sms, "INVOICE");

                                if (dt.Rows[0]["IS_OPTIN"].ToString() == "1")
                                {

                                    if (BillType == "3")
                                        typeText = "RPV";

                                    var Whatsappmsg = "Dear *" + dt.Rows[0]["AppmstFName"].ToString() + "* your id *" + dt.Rows[0]["AppMstRegNo"].ToString() + "* Invoice No. *" + dt.Rows[0]["InvoiceNo"].ToString() + "* Date *" + dt.Rows[0]["doe"].ToString() + "* has been generated for Rs *" + NetAmt + "/-* and *" + typeText + "*: *" + dt.Rows[0]["TotalBV"].ToString() + "* successfully. To view Invoice please click here https://toptimenet.com/?" + dt.Rows[0]["InvoiceNo"].ToString().Replace("/", "-");
                                    if (BillType == "1")
                                        WhatsApp.Send_WhatsApp_With_Header(dt.Rows[0]["AppMstMobile"].ToString().Trim(), Whatsappmsg, "TPV INVOICE");
                                    else if (BillType == "3")
                                        WhatsApp.Send_WhatsApp_With_Header(dt.Rows[0]["AppMstMobile"].ToString().Trim(), Whatsappmsg, "Repurchase INVOICE");

                                }
                            }
                            //   sendSMS(invoiceNo, totalBV.ToString(), totalamt.ToString());
                            //DataTable dt = objDu.GetDataTable("Select InvoiceNo from billmst where srno=" + invoiceNo);
                            // if (dt.Rows.Count > 0)
                            //objResult.InvoiceNo = dt.Rows[0]["InvoiceNo"].ToString();
                        }
                        HttpContext.Current.Session["ITEMLISTID"] = null;
                        HttpContext.Current.Session["UserCart"] = null;

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
    public static string GetBarcode(string Productcode, string DiscounType, string BillType, string Pack_Rep)
    {

        String[] strProduct = Productcode.Split(new String[] { "=" }, StringSplitOptions.RemoveEmptyEntries);
        try
        {
            if (strProduct[0] != null)
                Productcode = strProduct[0];
        }
        catch { }


        String Result = "";

        if (HttpContext.Current.Session["userId"] == null)
        {
            return "Sessionlogout";
        }

        try
        {
            if (HttpContext.Current.Session["UserCart"] == null)
                CreateStucture();

            SqlParameter[] param1 = new SqlParameter[]
            {
                new SqlParameter("@Productcode", Productcode)
            };

            string Pid = "0", IsComboPack = "0";
            DataUtility objDu = new DataUtility();
            DataTable DTNew = objDu.GetDataTable(param1, "Select Top 1 ProductId, IsComboPack=isnull(IsComboPack,0) from ShopProductMst where (productName=@Productcode or Productcode=@Productcode)");
            if (DTNew.Rows.Count > 0)
            {
                Pid = DTNew.Rows[0]["ProductId"].ToString();
                IsComboPack = DTNew.Rows[0]["IsComboPack"].ToString();
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
                    DataTable Cartdt = (DataTable)HttpContext.Current.Session["UserCart"];
                    if (Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault() == null)
                    {
                        int Output = AddRow(Pid, BillType, Pack_Rep, "", 1, IsComboPack);
                        if (Output == 0)
                            Result = "0";
                    }
                    else
                    {
                        Result = "1";
                    }
                }
                else
                {
                    Result = "This : " + Pid + " Product not found.!!";
                }
            }
            else
            {
                Result = "This : " + Pid + " Product not found.!!";
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    private static int AddRow(string Pid, string BillType, string Pack_Rep, string BatchList, int AddQty, string IsComboPack)
    {
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@Pid", Pid),
                 new SqlParameter("@UserId", SalesRep),
                 new SqlParameter("@BillType", BillType),
                 new SqlParameter("@Pack_Rep", Pack_Rep),
                 new SqlParameter("@BatchList", BatchList)
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "Get_Detail_for_Barcode");
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Error"].ToString() == "0")
                {
                    if (dt.Rows[0]["Qty"].ToString() != "0")
                    {
                        DataTable Cartdt = (DataTable)HttpContext.Current.Session["UserCart"];
                        Double DPWithTax = Convert.ToDouble(dt.Rows[0]["DPWithTax"].ToString());
                        Double MRP = Convert.ToDouble(dt.Rows[0]["MRP"].ToString());

                        Double DPAmt = Convert.ToDouble(dt.Rows[0]["DPAmt"].ToString());
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
                        dr["BVAmt"] = dt.Rows[0]["BVAmt"].ToString();
                        dr["totalbvamt"] = Math.Round(Convert.ToDouble(dt.Rows[0]["BVAmt"].ToString()), 2);
                        dr["MaxQty"] = dt.Rows[0]["MaxQty"].ToString();
                        dr["BatchQty"] = Convert.ToInt32(dt.Rows[0]["Qty"]);
                        dr["qty"] = AddQty;
                        dr["tax"] = Tax;
                        dr["BatchNo"] = dt.Rows[0]["BatchNo"].ToString();
                        dr["BatchDate"] = dt.Rows[0]["BatchDate"].ToString();
                        dr["ExpiryDate"] = dt.Rows[0]["ExpiryDate"].ToString();

                        dr["GSTAMT"] = GSTAMT;
                        dr["DPAmt"] = DPAmt;
                        dr["DPWithTax"] = DPWithTax;
                        dr["MRP"] = MRP;

                        dr["Weight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString());
                        dr["TotalWeight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString()) * AddQty;

                        dr["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                        dr["Gross"] = Math.Round(DPAmt, 2);
                        dr["TaxableAmt"] = Math.Round(DPAmt, 2);

                        dr["totalamt"] = Math.Round((DPAmt + GSTAMT), 2);
                        dr["DiscounType"] = "%";

   
                        dr["Discount"] = (MRP * Disc_Perc_Val / 100) * AddQty;
                        dr["Disc_Perc_Val"] = dt.Rows[0]["Disc_Perc_Val"].ToString();



                        dr["IsComboPack"] = IsComboPack;
                        Cartdt.Rows.Add(dr);
                        HttpContext.Current.Session["UserCart"] = Cartdt;

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
        }
        catch (Exception er) { }
        return AddQty;
    }



    [WebMethod]
    public static string UpdateQty(int batchid, int Qty, string BillType, string Pack_Rep)
    {
        String Result = "";
        try
        {
            if (Qty <= 0)
                DeleteRecord(batchid);

            DataTable Cartdt = (DataTable)HttpContext.Current.Session["UserCart"];
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
                    HttpContext.Current.Session["UserCart"] = Cartdt;
                    Calculater(batchid);

                    while (BalQty > 0)
                    {
                        int AddedQty = AddRow(Pid.ToString(), BillType, Pack_Rep, GetBatchList(Pid), BalQty, "0");
                        BalQty = BalQty - AddedQty;
                        if (AddedQty == 0)
                            BalQty = 0;
                    }
                }
                else
                {
                    findrow["qty"] = Qty.ToString();
                    HttpContext.Current.Session["UserCart"] = Cartdt;
                    Calculater(batchid);
                }
                /* else
                     Result = "Maximum Allowed : " + MaxQty.ToString();*/

            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    private static string GetBatchList(int Pid)
    {
        string BatchList = "";
        DataTable dt = (DataTable)HttpContext.Current.Session["UserCart"];
        foreach (DataRow dr in dt.Rows)
        {
            if (dr["Pid"].ToString() == Pid.ToString())
                BatchList += dr["batchid"].ToString() + ",";
        }
        return BatchList;
    }

    private static void Calculater(int batchid)
    {
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["UserCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();

                int Qty = findrow == null ? 0 : findrow.Field<int>("qty");
                double tax = findrow == null ? 0 : findrow.Field<double>("tax");
                double DPAmt = findrow == null ? 0 : findrow.Field<double>("DPAmt");
                double BV = findrow == null ? 0 : findrow.Field<double>("BVAmt");
                double Discount = findrow == null ? 0 : findrow.Field<double>("Discount");
                string DiscounType = findrow == null ? "Rs" : findrow.Field<string>("DiscounType");
                double Weight = findrow == null ? 0 : findrow.Field<double>("Weight");
                double DPWithTax = findrow == null ? 0 : findrow.Field<double>("DPWithTax");
                double MRP = findrow == null ? 0 : findrow.Field<double>("MRP");
                double Disc_Perc_Val = findrow == null ? 0 : findrow.Field<double>("Disc_Perc_Val");

                double GSTAMT = 0, Gross = 0;

                if (DiscounType == "%")
                {
                    Gross = (DPAmt * Qty);
                    findrow["Gross"] = Math.Round(Gross, 2);
                    //Discount = (MRP - DPWithTax) * Qty;
                    Discount = (MRP * Disc_Perc_Val / 100) * Qty;
                    //Gross = (Gross - (Gross * Discount / 100));

                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 4, MidpointRounding.ToEven);
                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 4, MidpointRounding.ToEven);

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
                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 4, MidpointRounding.ToEven);
                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 4, MidpointRounding.ToEven);
                    findrow["GSTAMT"] = Math.Round(GSTAMT * Qty, 2);
                    findrow["TaxableAmt"] = Math.Round(Gross, 2);
                    findrow["totalamt"] = Math.Round(Gross + GSTAMT, 2);
                    findrow["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                }

                findrow["TotalWeight"] = (Weight * Qty);
                findrow["Discount"] = Math.Round(Discount, 2);
                findrow["totalbvamt"] = Qty * BV;
                HttpContext.Current.Session["UserCart"] = Cartdt;
            }
        }
        catch (Exception er) { }
    }



    [WebMethod]
    public static string UpdateDiscount(int batchid, double Discount, string DiscounType)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["UserCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();
                int Qty = findrow == null ? 0 : findrow.Field<int>("qty");
                double Gross = 0;
                double DPAmt = findrow == null ? 0 : findrow.Field<double>("DPAmt");
                if (DiscounType == "%")
                {
                    if (Discount > 100)
                        return "Discount value less than 100%.!!";
                }
                else
                {
                    Gross = (DPAmt * Qty);
                    if (Discount > Gross)
                        return "Discount value less than Amount.!!";
                }
                findrow["Discount"] = Discount.ToString();
                findrow["DiscounType"] = DiscounType;
                HttpContext.Current.Session["UserCart"] = Cartdt;
                Calculater(batchid);
            }

        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    [WebMethod]
    public static string UpdateGST(int batchid, int GST)
    {
        DataTable Cartdt = (DataTable)HttpContext.Current.Session["UserCart"];
        if (Cartdt.Rows.Count > 0)
        {
            DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();
            int Qty = findrow == null ? 0 : findrow.Field<int>("Qty");
            double tax = findrow == null ? 0 : findrow.Field<double>("tax");
            findrow["tax"] = GST;
            HttpContext.Current.Session["UserCart"] = Cartdt;
            Calculater(batchid);
        }
        return "";
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
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["UserCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();
                Cartdt = (DataTable)HttpContext.Current.Session["UserCart"];
                findrow.Delete();
                HttpContext.Current.Session["UserCart"] = Cartdt;
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    [WebMethod]
    public static ProdDetails[] GetCartData()
    {
        List<ProdDetails> details = new List<ProdDetails>();
        if (HttpContext.Current.Session["UserCart"] != null)
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["UserCart"];
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
                data.pname = dr["pname"].ToString();
                data.Pcode = dr["Pcode"].ToString();
                data.hsncode = dr["hsncode"].ToString();
                data.qty = Convert.ToInt32(dr["qty"].ToString());
                data.MaxQty = Convert.ToInt32(dr["MaxQty"].ToString());

                data.TaxableAmt = Convert.ToDouble(dr["TaxableAmt"].ToString());
                data.Discount = Convert.ToDouble(dr["Discount"].ToString());
                data.Disc_Perc_Val = dr["Disc_Perc_Val"].ToString();

                data.BatchNo = dr["BatchNo"].ToString();
                data.BatchDate = dr["BatchDate"].ToString();
                data.ExpiryDate = dr["ExpiryDate"].ToString();

                data.GSTAMT = Convert.ToDouble(dr["GSTAMT"].ToString());
                data.DPAmt = Convert.ToDouble(dr["DPAmt"].ToString());
                data.DPWithTax = Convert.ToDouble(dr["DPWithTax"].ToString());
                data.MRP = Convert.ToDouble(dr["MRP"].ToString());

                data.Gross = Convert.ToDouble(dr["Gross"].ToString());
                data.BVAmt = Convert.ToDouble(dr["BVAmt"].ToString());
                data.totalbvamt = Convert.ToDouble(dr["totalbvamt"].ToString());
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
    public static TradeProp Get_Trade_Values(string InvAmt, string OldAmt)
    {
        return common.Trade_Income_slabs(InvAmt, OldAmt);
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
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter("Get_SchemeItem", con);
        da.SelectCommand.Parameters.AddWithValue("@SchemeItemId", SchemeItemId);
        da.SelectCommand.Parameters.AddWithValue("@soldby", SalesRep);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        da.Fill(dt);
        return (dt);

    }


    //private static void sendSMS(string invoiceno, string BV, string NetAmt)
    //{
    //    SqlConnection con = new SqlConnection(method.str);
    //    SqlDataAdapter adapter = new SqlDataAdapter("SELECT A.AppMstRegNo,AppMstFName,A.AppMstMobile,B.InvoiceNo FROM AppMst A INNER JOIN BillMst B ON  A.AppMstRegNo=B.SoldTo WHERE B.srno=@srno", con);
    //    adapter.SelectCommand.CommandType = CommandType.Text;
    //    adapter.SelectCommand.Parameters.AddWithValue("@srno", invoiceno);
    //    DataTable dt = new DataTable();
    //    adapter.Fill(dt);
    //    if (dt.Rows.Count > 0)
    //    {
    //        utility objUtil = new utility();
    //        string UserName = dt.Rows[0]["AppmstFName"].ToString();
    //        string subUserName, text = "";
    //        if (UserName.Length > 20)
    //        {
    //            subUserName = UserName.Substring(0, 20).ToString();
    //            text = "Dear " + subUserName + " ID No " + dt.Rows[0]["AppMstRegNo"].ToString() + " Invoice No: " + dt.Rows[0]["InvoiceNo"].ToString() + " Invoice Amt : " + NetAmt + "generated successfully";
    //        }
    //        else //Dear {#var#} ID No {#var#} Invoice No: {#var#} Invoice Amt : {#var#} generated successfully
    //        {
    //            text = "Dear " + UserName + " ID No " + dt.Rows[0]["AppMstRegNo"].ToString() + " Invoice No: " + dt.Rows[0]["InvoiceNo"].ToString() + " Invoice Amt : " + NetAmt + "generated successfully";
    //        }
    //        //string text = "Dear " + dt.Rows[0]["AppMstRegNo"].ToString() + "(" + dt.Rows[0]["AppMstFName"].ToString() + ") Inv. No " + dt.Rows[0]["InvoiceNo"].ToString() + " for " + NetAmt + " generated From toptimenet.com Thanks";

    //        objUtil.sendSMSByBilling(dt.Rows[0]["AppMstMobile"].ToString().Trim(), text, "INVOICE");
    //    }
    //}


    [WebMethod]
    public static UserDetails GetUser(string Userid, string Self_Validate, string BillType)
    {
        UserDetails objUser = new UserDetails();

        Userid = Userid.Trim();
        // String Result = "";
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("checkuserdetail", con);
            SqlDataReader dr;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", Userid.Trim());
            cmd.Parameters.AddWithValue("@BillType", BillType);
            cmd.Parameters.AddWithValue("@SessionId", SalesRep);
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                if (dr["Error"].ToString() == "")
                {
                    objUser.Error = "";
                    objUser.UserName = dr["name"].ToString();
                    objUser.Address = dr["AppMstAddress1"].ToString();
                    objUser.State = dr["AppMstState"].ToString();
                    objUser.City = dr["AppMstCity"].ToString();
                    objUser.Pincode = dr["AppMstPinCode"].ToString();
                    objUser.AdminState = dr["AdminState"].ToString();
                    objUser.JoinFor = dr["JoinFor"].ToString();
                    objUser.Mobile = dr["AppMstMobile"].ToString();
                    objUser.distt = dr["distt"].ToString();
                    objUser.jamount = dr["jamount"].ToString();

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


    [WebMethod]
    public static string GetReferenceUserProduct(string BillType)
    {
        string Result = "0";
        try
        {

            if (HttpContext.Current.Session["UserCart"] != null)
            {
                DataTable Cartdt = (DataTable)HttpContext.Current.Session["UserCart"];
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




    public void BindAdminState()
    {
        DataUtility objDUT = new DataUtility();
        DataTable dt = new DataTable();
        SqlParameter[] sqlparam = new SqlParameter[] {
             new SqlParameter("@regno", SalesRep)
        };
        dt = objDUT.GetDataTableSP(sqlparam, "GetAdminState");
        if (dt.Rows.Count > 0)
        {
            ddlSellerState.SelectedValue = dt.Rows[0]["AdminState"].ToString();
        }
    }



    public void BindUserProduct()
    {
        string BillType = "", PackType = "0";
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




        SqlParameter[] param = new SqlParameter[] {
            new SqlParameter("@PackType", PackType),
            new SqlParameter("@BillType", "0"),
            new SqlParameter("@Userid", SalesRep)
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetShopProduct_Billing");
        foreach (DataRow dr in dt.Rows)
        {
            if (dr["Qty"].ToString() != "0")
                divProductcode.InnerText += dr["productCode"].ToString() + "= " + dr["ProductName"].ToString() + " (" + dr["PackSize"].ToString() + ") Qty: " + dr["Qty"].ToString() + ",";
            //divProductcode.InnerText += dr["productCode"].ToString() + "= " + dr["ProductName"].ToString() + " (" + dr["PackSize"].ToString() + ") Qty: " + dr["Qty"].ToString() + "," + dr["ProductName"].ToString() + "= " + dr["productCode"].ToString() + " (" + dr["PackSize"].ToString() + ") Qty: " + dr["Qty"].ToString() + ",";

        }
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
            Result = dt.Rows[0]["OTP"].ToString().Trim();
            String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 15 min from:toptimenet.com Jai Toptime";
            objUtil.sendSMSByBilling(dt.Rows[0]["AppMstMobile"].ToString().Trim(), msg, "OTP");

            if (dt.Rows[0]["IS_OPTIN"].ToString() == "1")
            {
                String Whatsappmsg = "OTP is {{" + dt.Rows[0]["OTP"].ToString().Trim() + "}} for transaction and is valid for 15 minutes. From www.toptimenet.com. *Jai Toptime*";
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
        HttpContext.Current.Session["UserCart"] = null;
        return "";
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
        dtStuc.Columns.Add(new DataColumn("tax", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Totaltaxamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Weight", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("TotalWeight", typeof(double)));


        dtStuc.Columns.Add(new DataColumn("totalamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("GSTAMT", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("IsComboPack", typeof(string)));

        HttpContext.Current.Session["UserCart"] = dtStuc;
    }

    #endregion


    #region ClassProperty

    public class ProdDetails
    {
        public int Sno { get; set; }
        public int Pid { get; set; }
        public String pname { get; set; }
        public String hsncode { get; set; }
        public String Pcode { get; set; }
        public int qty { get; set; }
        public int batchid { get; set; }
        public String BatchNo { get; set; }
        public String BatchDate { get; set; }
        public String ExpiryDate { get; set; }

        public int BatchQty { get; set; }
        public int MaxQty { get; set; }
        public String DiscounType { get; set; }
        public String Disc_Perc_Val { get; set; }
        public double Discount { get; set; }
        public double DPAmt { get; set; }
        public double DPWithTax { get; set; }
        public double MRP { get; set; }
        public double Gross { get; set; }
        public double TaxableAmt { get; set; }
        public double BVAmt { get; set; }
        public double totalbvamt { get; set; }
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
        public String jamount { get; set; }

        public String Mobile { get; set; }
        public String distt { get; set; }
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