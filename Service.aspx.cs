using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

public partial class Service : System.Web.UI.Page
{
    static string ITEMLISTID = "", SalesRep = method.DEFAULT_SELLER;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [System.Web.Services.WebMethod]
    public static TradeProp Get_Trade_Values(string InvAmt, string OldAmt)
    {
        return common.Trade_Income_slabs(InvAmt, OldAmt);
    }



    [WebMethod]
    public static string SessionExpired()
    {
        string Result = "0";
        if (HttpContext.Current.Session["userId"] == null)
            Result = "1";
        return Result;
    }



    #region Genearate Invoice
    [WebMethod]
    public static Results GenerateInv(string PackStockType, string BillType, string UserId, string Discount, string DelCharge, string User_State, string Admin_State, string paymode, string bankname, string checkno, string CheDate,
    string toAdd, string GSTNo, string PlaseOfSuply, string SellerState, string SchemeItemIdStr, string Ref_User,
    string Name, string address, string state, string district, string City, string Pincode, string DISC_Perc, string Mobile, string Adjustment, string PaymodeVal)
    {
        double SchemeAmt = 0, SchemeTaxRs = 0;
        int TotalQnty = 0;
        Results objResult = new Results();

        UserId = UserId.Trim();
        if (Mobile == "")
        {
            objResult.Error = "Please Enter Mobile No.";
            return objResult;
        }
        if (Mobile.Length != 10)
        {
            objResult.Error = "Please Enter 10 Digit Mobile No.";
            return objResult;
        }
        DataUtility objDu = new DataUtility();


        XElement element = null;
        try
        {
            DateTime BillDate_New = new DateTime();
            DateTime CheDate_New = new DateTime();
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            try
            {
                BillDate_New = DateTime.Now;
                CheDate_New = DateTime.Now;
            }
            catch (Exception er)
            {
                objResult.Error = er.Message;
                return objResult;
            }


            DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
            if (Cartdt == null)
            {
                objResult.Error = "Your cart is empty.";
                return objResult;
            }
            if (Cartdt != null)
            {

                SqlParameter[] param111 = new SqlParameter[]
               {
                    new SqlParameter("@Userid", SalesRep)
               };
                DataTable dt11 = objDu.GetDataTable(param111, " Select Adminstate=State from FranchiseMst Where FranchiseId=@Userid");
                if (dt11.Rows.Count > 0)
                {
                    Admin_State = dt11.Rows[0]["Adminstate"].ToString();
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


                        XElement prdXml = new XElement("P",
                                new XElement("pname", row["pname"].ToString()),
                                new XElement("cd", row["Pid"].ToString()),
                                new XElement("dis", row["Discount"].ToString()),
                                 new XElement("Disc_Perc_Val", row["Disc_Perc_Val"].ToString()),
                                new XElement("dis_type", row["DiscounType"].ToString()),
                                new XElement("hsncode", row["hsncode"].ToString()),
                                new XElement("Qnt", row["qty"].ToString()),
                                new XElement("MRP", row["MRP"].ToString()),
                                new XElement("TAX", row["Tax"].ToString()),
                                new XElement("TAXRS", row["Totaltaxamt"].ToString()),

                                new XElement("DP", row["DPAmt"].ToString()),
                                new XElement("DPWithTax", row["DPWithTax"].ToString()),
                                new XElement("BV", row["totalbvamt"].ToString()),
                                new XElement("Gross", row["Gross"].ToString()),
                                new XElement("total", row["totalamt"].ToString()),
                                new XElement("batchid", row["batchid"].ToString()),
                                new XElement("OFFERID", BillType == "4" ? "-111" : "0"),
                                new XElement("IGST", IGST),
                                new XElement("IGSTRS", Math.Round(IGSTRS, 2)),
                                new XElement("CGST", CGST),
                                new XElement("CGSTRS", Math.Round(CGSTRS, 2)),
                                new XElement("SGST", SGST),
                                new XElement("SGSTRS", Math.Round(SGSTRS, 2))
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
                            new XElement("dis_type", "%"),
                            new XElement("hsncode", row["HSNCode"].ToString()),
                            new XElement("Qnt", row["quantity"].ToString()),
                            new XElement("MRP", MRP),
                            new XElement("TAX", row["Tax"].ToString()),
                            new XElement("TAXRS", TAXRS),
                            new XElement("DP", MRP),
                            new XElement("DPWithTax", DPWithTax),
                            new XElement("BV", 0),
                            new XElement("Gross", DPWithTax),
                            new XElement("total", (MRP + TAXRS) * Convert.ToDouble(row["quantity"].ToString())),
                            new XElement("batchid", row["batchid"].ToString()),
                            new XElement("OFFERID", row["OFFERID"].ToString()),
                            new XElement("IGST", IGST),
                            new XElement("IGSTRS", Math.Round(IGSTRS, 2)),
                            new XElement("CGST", CGST),
                            new XElement("CGSTRS", Math.Round(CGSTRS, 2)),
                            new XElement("SGST", SGST),
                            new XElement("SGSTRS", Math.Round(SGSTRS, 2))
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
                    SqlCommand com = new SqlCommand("AddOrder", con);
                    com.CommandType = CommandType.StoredProcedure;

                    com.Parameters.AddWithValue("@regno", UserId);
                    com.Parameters.AddWithValue("@count", Convert.ToInt32(Cartdt.Rows.Count));
                    com.Parameters.AddWithValue("@amt", Convert.ToInt32(Math.Round(Convert.ToDouble(NetAmt) + (SchemeAmt + SchemeTaxRs))).ToString("#0.00"));
                    com.Parameters.AddWithValue("@gross", Convert.ToDouble(GrossAmt) + SchemeAmt);
                    com.Parameters.AddWithValue("@Qnty", TotalQnty);
                    com.Parameters.AddWithValue("@ToalTaxPer", 0);
                    com.Parameters.AddWithValue("@TotalTaxRs", Convert.ToDouble(TaxRs) + SchemeTaxRs);
                    com.Parameters.AddWithValue("@TotalDP", Convert.ToDouble(GrossAmt) + SchemeAmt);
                    com.Parameters.AddWithValue("@TotalBV", totalBV);
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
                    com.Parameters.AddWithValue("@PlaceOfSupply", User_State);
                    com.Parameters.AddWithValue("@sellerstate", Admin_State);
                    com.Parameters.AddWithValue("@BillingDate", BillDate_New);
                    com.Parameters.AddWithValue("@Ref_User", Ref_User);

                    com.Parameters.AddWithValue("@Name", Name);
                    com.Parameters.AddWithValue("@address", address);
                    com.Parameters.AddWithValue("@state", state);
                    com.Parameters.AddWithValue("@district", district);
                    com.Parameters.AddWithValue("@City", City);
                    com.Parameters.AddWithValue("@Pincode", Pincode);
                    com.Parameters.AddWithValue("@DISC_Perc", DISC_Perc);
                    com.Parameters.AddWithValue("@Mobile", Mobile);
                    com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    com.Parameters.AddWithValue("@AdjustmentAmt", Adjustment);
                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    string status = com.Parameters["@flag"].Value.ToString();
                    string invoiceNo = com.Parameters["@InvNo"].Value.ToString();
                    if (status == "1")
                    {
                        
                        if(PaymodeVal=="17")
                            objResult.InvoiceNo = secure.Encrypt(invoiceNo);
                        else
                            objResult.InvoiceNo = invoiceNo;

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




    private static int AddRow(string Pid, string BillType, string Pack_Rep, string BatchList, int AddQty)
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
                        DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
                        Double DPAmt = Convert.ToDouble(dt.Rows[0]["DPAmt"].ToString());
                        Double MRP = Convert.ToDouble(dt.Rows[0]["MRP"].ToString());
                        Double DPWithTax = Convert.ToDouble(dt.Rows[0]["DPWithTax"].ToString());
                        Double Tax = Convert.ToDouble(dt.Rows[0]["Tax"].ToString());
                        Double GSTAMT = Convert.ToDouble(dt.Rows[0]["GSTAMT"].ToString());
                        Double Disc_Perc_Val = Convert.ToDouble(dt.Rows[0]["Disc_Perc_Val"].ToString());
                        if (AddQty > Convert.ToInt32(dt.Rows[0]["Qty"]))
                            AddQty = Convert.ToInt32(dt.Rows[0]["Qty"]);

                        
                        double Discount = (MRP * Disc_Perc_Val / 100) * AddQty;

                        if (HttpContext.Current.Session["userId"] == null)
                        {
                            DPAmt = (MRP * 100 / (100 + Tax));
                            GSTAMT = (MRP - DPAmt);
                            Disc_Perc_Val = 0;
                            Discount = 0;
                        }
                        DPAmt = Math.Round(DPAmt, 4);
                        GSTAMT = Math.Round(GSTAMT, 4);
                         

                        DataRow dr = Cartdt.NewRow();
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
                        dr["GSTAMT"] = GSTAMT;

                        dr["DPAmt"] = DPAmt;
                        dr["DPWithTax"] = MRP;
                        dr["MRP"] = MRP;

                        dr["Weight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString());
                        dr["TotalWeight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString()) * AddQty;
                        dr["image"] = dt.Rows[0]["ImageName"].ToString();
                        dr["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                        dr["Gross"] = Math.Round(DPAmt, 2);
                        dr["TaxableAmt"] = Math.Round(DPAmt, 2);

                        dr["totalamt"] = Math.Round((DPAmt + GSTAMT), 2);
                        dr["DiscounType"] = "%";
                        dr["Discount"] = Discount;
                        dr["Disc_Perc_Val"] = Disc_Perc_Val;

                        Cartdt.Rows.Add(dr);
                        HttpContext.Current.Session["RootCart"] = Cartdt;

                        Calculater(Convert.ToInt32(dt.Rows[0]["batchid"]));
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
    public static string AddProduct(string Batchid)
    {
        String Result = "";
        try
        {
            if (HttpContext.Current.Session["RootCart"] == null)
                CreateStucture();

            DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
            if (Cartdt.Select("batchid='" + Batchid + "'").FirstOrDefault() == null)
            {
                SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Batchid", Batchid) };
                DataUtility objDu = new DataUtility();
                DataTable dt = objDu.GetDataTableSP(param, "AddRootProd");
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["Error"].ToString() == "0")
                    {
                        if (dt.Rows[0]["Qty"].ToString() != "0")
                        {

                            Double MRP = Convert.ToDouble(dt.Rows[0]["MRP"].ToString());

                            Double DPWithTax = Convert.ToDouble(dt.Rows[0]["DPWithTax"].ToString());
                            Double DPAmt = Convert.ToDouble(dt.Rows[0]["DPAmt"].ToString());

                            Double Tax = Convert.ToDouble(dt.Rows[0]["Tax"].ToString());
                            Double GSTAMT = Convert.ToDouble(dt.Rows[0]["GSTAMT"].ToString());
                            Double Disc_Perc_Val = Convert.ToDouble(dt.Rows[0]["Disc_Perc_Val"].ToString());
                            int qty = 1;
                           
                            Double Discount = (MRP * Disc_Perc_Val / 100) * qty;

                            if (HttpContext.Current.Session["userId"] == null)
                            {
                                DPAmt = (MRP * 100 / (100 + Tax));
                                GSTAMT = (MRP - DPAmt);
                                Disc_Perc_Val = 0;
                                Discount = 0;
                            }
                            DPAmt = Math.Round(DPAmt, 4);
                            GSTAMT = Math.Round(GSTAMT, 4);
                            Discount = Math.Round(Discount, 2);

                            DataRow dr = Cartdt.NewRow();
                            dr["pid"] = dt.Rows[0]["pid"].ToString();
                            dr["batchid"] = dt.Rows[0]["batchid"].ToString();
                            dr["Pcode"] = dt.Rows[0]["Pcode"].ToString();
                            dr["pname"] = dt.Rows[0]["pname"].ToString();
                            dr["hsncode"] = dt.Rows[0]["HSNCode"].ToString();
                            dr["BVAmt"] = dt.Rows[0]["BVAmt"].ToString();
                            dr["totalbvamt"] = Math.Round(Convert.ToDouble(dt.Rows[0]["BVAmt"].ToString()), 2);
                            dr["MaxQty"] = dt.Rows[0]["MaxQty"].ToString();
                            dr["BatchQty"] = Convert.ToInt32(dt.Rows[0]["Qty"]);
                            dr["qty"] = qty;
                            dr["tax"] = Tax;
                            dr["BatchNo"] = dt.Rows[0]["BatchNo"].ToString();
                            dr["GSTAMT"] = GSTAMT;

                            dr["MRP"] = MRP;
                            dr["DPAmt"] = DPAmt;
                            dr["DPWithTax"] = MRP;

                            dr["Weight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString());
                            dr["TotalWeight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString()) * qty;
                            dr["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                            dr["Gross"] = Math.Round(DPAmt, 2);
                            dr["TaxableAmt"] = Math.Round(DPAmt, 2);
                            dr["totalamt"] = Math.Round((DPAmt + GSTAMT), 2);
                            dr["DiscounType"] = "%";
                            dr["Discount"] = Discount;
                            dr["Disc_Perc_Val"] = Disc_Perc_Val;
                            dr["image"] = dt.Rows[0]["ImageName"].ToString();
                            Cartdt.Rows.Add(dr);
                            HttpContext.Current.Session["RootCart"] = Cartdt;
                        }

                    }
                }
            }
            else
            {
                Result = "This product already added.!!";
            }


        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }



    private static string GetBatchList(int Pid)
    {
        string BatchList = "";
        DataTable dt = (DataTable)HttpContext.Current.Session["RootCart"];
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
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();

                int Qty = findrow == null ? 0 : findrow.Field<int>("qty");
                double tax = findrow == null ? 0 : findrow.Field<double>("tax");

                double MRP = findrow == null ? 0 : findrow.Field<double>("MRP");
                double DPWithTax = findrow == null ? 0 : findrow.Field<double>("DPWithTax");
                double DPAmt = findrow == null ? 0 : findrow.Field<double>("DPAmt");

                double BV = findrow == null ? 0 : findrow.Field<double>("BVAmt");
                // double FPV = findrow == null ? 0 : findrow.Field<double>("FPV");
                double Discount = 0;
                double Disc_Perc_Val = findrow == null ? 0 : findrow.Field<double>("Disc_Perc_Val");

                string DiscounType = findrow == null ? "%" : findrow.Field<string>("DiscounType");
                double Weight = findrow == null ? 0 : findrow.Field<double>("Weight");
   
                double GSTAMT = 0, Gross = 0;

                if (DiscounType == "%")
                {
                    Gross = (DPAmt * Qty);
                    findrow["Gross"] = Math.Round(Gross, 2);
                    if (HttpContext.Current.Session["userId"] != null)
                    {
                        Discount = (MRP * Disc_Perc_Val/ 100) * Qty;
                    }
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
                    Gross = (Gross * 100 / (100 + tax));

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
                //findrow["TotalFPV"] = Qty * FPV;

                Discount = 0;
                HttpContext.Current.Session["RootCart"] = Cartdt;
            }
        }
        catch (Exception er) { }
    }


    private static string DeleteRecord(int batchid)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();
                Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
                findrow.Delete();
                HttpContext.Current.Session["RootCart"] = Cartdt;
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }

    [WebMethod]
    public static string UpdateQty(int batchid, int Qty, string BillType, string Pack_Rep)
    {
        String Result = "";
        try
        {
            if (Qty <= 0)
                DeleteRecord(batchid);

            DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
            if (Cartdt.Rows.Count > 0 && Qty > 0)
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
                    HttpContext.Current.Session["RootCart"] = Cartdt;
                    Calculater(batchid);

                    while (BalQty > 0)
                    {
                        int AddedQty = AddRow(Pid.ToString(), BillType, Pack_Rep, GetBatchList(Pid), BalQty);
                        BalQty = BalQty - AddedQty;
                    }
                }
                else
                {
                    findrow["qty"] = Qty.ToString();
                    HttpContext.Current.Session["RootCart"] = Cartdt;
                    Calculater(batchid);
                }

            }
            // Calculat_Discount();

        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    //private static void Calculat_Discount()
    //{
    //    if (HttpContext.Current.Session["IsCustomer"] != null)
    //    {
    //        if (HttpContext.Current.Session["IsCustomer"].ToString() == "False")
    //        {

    //            decimal OldAmt = 0;
    //            DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
    //            object TaxableAmt = Cartdt.Compute("Sum(Gross)", "");


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
    //                    HttpContext.Current.Session["RootCart"] = Cartdt;

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
    //                    HttpContext.Current.Session["RootCart"] = Cartdt;
    //                }
    //            }
    //        }
    //    }

    //}




    [WebMethod]
    public static string UpdateDiscount(int batchid, double Discount, string DiscounType)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
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
                HttpContext.Current.Session["RootCart"] = Cartdt;
                Calculater(batchid);
            }

        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
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


    [WebMethod]
    public static ProdDetails[] GetCartData()
    {
        List<ProdDetails> details = new List<ProdDetails>();
        if (HttpContext.Current.Session["RootCart"] != null)
        {
            //Calculat_Discount();
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
            ITEMLISTID = "";
            foreach (DataRow dr in Cartdt.Rows)
            {
                ITEMLISTID += dr["pid"].ToString() + "^" + dr["qty"].ToString() + ",";  // GSTAMT

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
                data.image = dr["image"].ToString();

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
            { list.Add(new ListItem(dr["DistrictName"].ToString(), dr["Id"].ToString())); }
        }
        catch (Exception er) { }
        return list;
    }


    [WebMethod]
    public static UserDetails GetUser(string Userid, string Self_Validate, string BillType)
    {
        UserDetails objUser = new UserDetails();
        Userid = Userid.Trim();
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
        new SqlParameter("@soldby", SalesRep),
        };
        DataUtility objDu = new DataUtility();
        return objDu.GetDataTableSP(param, "Get_SchemeItem");

    }


    [WebMethod]
    public static string GetCount()
    {
        String Result = "0";
        try
        {
            if (HttpContext.Current.Session["RootCart"] != null)
            {
                DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
                Result = Cartdt.Rows.Count.ToString();
            }
        }
        catch (Exception er) { }
        return Result;
    }




    [System.Web.Services.WebMethod]
    public static BestSeller[] GetBestSellerProduct(string flag)
    {
        List<BestSeller> details = new List<BestSeller>();
        if (HttpContext.Current.Session["BestSeller"] == null)
        {
            DataUtility objDu = new DataUtility();
            DataTable dt = null;

            dt = objDu.GetDataTable(@"Select Product=t.x.value('pname[1]','varchar(max)'), UserName=a.Appmstfname + ' ('+ a.AppMstState +')', 
            CurrentDate= datediff(hour,CurrentDate, getdate()), 
	        ImageName=(Case when (i.ImageName='' or i.ImageName is null) then 'noimage.jpg' else i.ImageName End)
	        from BillMst b cross apply detail.nodes ('/Bill/P') t(x) inner join appmst a on b.Appmstid=a.Appmstid
	        inner join ShopProductmst s on s.Productid=t.x.value('cd[1]','int')
            Inner join CategoryMst c on c.Catid=s.Catid and c.CatId in (7, 12, 13)
            left join ShopproductImagemst i on i.Productid=t.x.value('cd[1]','int') and i.ImageDefault=1
	        where b.BillType=3 and b.Status=1 and Cast(CurrentDate as date) Between Cast(Getdate() as date) and Cast(Getdate() as date)");
            if (dt.Rows.Count <= 5)
            {
                dt = objDu.GetDataTable(@"Select Product=t.x.value('pname[1]','varchar(max)'), UserName=a.Appmstfname + ' ('+ a.AppMstState +')', 
                CurrentDate= datediff(hour,CurrentDate, getdate()), 
	            ImageName=(Case when (i.ImageName='' or i.ImageName is null) then 'noimage.jpg' else i.ImageName End)
	            from BillMst b cross apply detail.nodes ('/Bill/P') t(x) inner join appmst a on b.Appmstid=a.Appmstid
	            inner join ShopProductmst s on s.Productid=t.x.value('cd[1]','int')
                Inner join CategoryMst c on c.Catid=s.Catid and c.CatId in (7, 12, 13)
                left join ShopproductImagemst i on i.Productid=t.x.value('cd[1]','int') and i.ImageDefault=1
	            where b.BillType=3 and b.Status=1 and Cast(CurrentDate as date) Between Cast(Getdate()-1 as date) and Cast(Getdate() as date)");
            }
            HttpContext.Current.Session["BestSeller"] = dt;

        }

        if (HttpContext.Current.Session["BestSeller"] != null)
        {
            DataTable dt = (DataTable)HttpContext.Current.Session["BestSeller"];
            foreach (DataRow row in dt.Rows)
            {
                BestSeller obj = new BestSeller();
                obj.Product = row["Product"].ToString();
                obj.UserName = row["UserName"].ToString();
                obj.CurrentDate = row["CurrentDate"].ToString();
                obj.ImageName = row["ImageName"].ToString();
                details.Add(obj);
            }
        }
        return details.ToArray();
    }




    [WebMethod]
    public static string Addwishlist(int Batchid)
    {
        String Result = "";
        try
        {
            if (HttpContext.Current.Session["userId"] == null)
            {
                return "LOGOUT";
            }
            else
            {
                SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
                outparam.Direction = ParameterDirection.Output;
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@Batchid", Batchid),
                    new SqlParameter("@userId", HttpContext.Current.Session["userId"].ToString()),
                    outparam
                };
                DataUtility objDu = new DataUtility();
                Result = objDu.ExecuteSqlSP(param, "sp_AddWishlist").ToString();
            }
            return Result;
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    [WebMethod]
    public static string GetCountWishList()
    {
        String Result = "0";
        try
        {
            if (HttpContext.Current.Session["userId"] != null)
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@Regno", HttpContext.Current.Session["userId"].ToString())
                };
                DataUtility objDu = new DataUtility();
                Result = objDu.GetScaler(param, "Select count(*) from WishList where Regno=@Regno").ToString();
            }
        }
        catch (Exception er) { }
        return Result;
    }


    #region GetSearchResults
    [WebMethod]
    public static ArrayList GetSearchResults(string searchText)
    {
        ArrayList list = new ArrayList();
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@SearchText", searchText)};
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "Get_Product_SearchResults");
        foreach(DataRow dr in dt.Rows)
        {
            list.Add(new ListItem("ProductName", dr["ProductName"].ToString()));
        }
        return list;
    }
    #endregion



    #region ClassProperty

    private static void CreateStucture()
    {
        DataTable dtStuc = new DataTable();
        dtStuc.Columns.Add(new DataColumn("Pid", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("DiscounType", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("Pcode", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("pname", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("hsncode", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("Discount", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("qty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("batchid", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("BatchNo", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("BatchQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("MaxQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("DPAmt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("DPWithTax", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("MRP", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Gross", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("TaxableAmt", typeof(double)));

        dtStuc.Columns.Add(new DataColumn("Disc_Perc_Val", typeof(double)));

        dtStuc.Columns.Add(new DataColumn("BVAmt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("totalbvamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("tax", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Totaltaxamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Weight", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("TotalWeight", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("totalamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("GSTAMT", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("image", typeof(string)));

        HttpContext.Current.Session["RootCart"] = dtStuc;
    }

    public class ProdDetails
    {
        public int Pid { get; set; }
        public String pname { get; set; }
        public String hsncode { get; set; }
        public String Pcode { get; set; }
        public int qty { get; set; }
        public int batchid { get; set; }
        public String BatchNo { get; set; }
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
        public String image { get; set; }

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
        public String distt { get; set; }
        public String Mobile { get; set; }
        public String jamount { get; set; }
        public String IsCustomer { get; set; }
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

    public class BestSeller
    {
        public String Product { get; set; }
        public String UserName { get; set; }
        public String CurrentDate { get; set; }
        public String ImageName { get; set; }
    }

    #endregion

}