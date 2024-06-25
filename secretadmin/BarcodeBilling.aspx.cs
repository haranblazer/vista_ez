using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.Data.SqlClient;
using System.Xml;
using System.Xml.Linq;

public partial class secretadmin_BarcodeBilling : System.Web.UI.Page
{
    static string Adminid="-111",  ITEMLISTID = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["admin"] == null)
                Response.Redirect("~/Login.aspx");
           

            txtbilldate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

            payoutdate();
            checkpage();
            BindState();
            BindUserProduct();
           
            //HttpContext.Current.Session["AdminCart"] = null;
        }
    }


    #region Genearate Invoice
    [WebMethod]
    public static Results GenerateInv(string BillType, string distype, string UserId, string Discount, string DelCharge, string User_State, string Admin_State, string paymode, string bankname, string checkno, string CheDate,
    string toAdd, string GSTNo, string PlaseOfSuply, string BillDate, string SchemeItemIdStr)
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
        if (HttpContext.Current.Session["admin"] == null)
        {
            objResult.Error = "Session logout. Please try agian.";
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


            DataTable Cartdt = (DataTable)HttpContext.Current.Session["AdminCart"];
            if (Cartdt == null)
            {
                objResult.Error = "Your cart is empty.";
                return objResult;
            }
            if (Cartdt != null)
            {

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
                                new XElement("dis_type", row["DiscounType"].ToString()),
                                new XElement("hsncode", row["hsncode"].ToString()),
                                new XElement("Qnt", row["qty"].ToString()),
                                new XElement("MRP", row["DPAmt"].ToString()),
                                new XElement("TAX", row["Tax"].ToString()),
                                new XElement("TAXRS", row["Totaltaxamt"].ToString()),
                                new XElement("DP", row["DPAmt"].ToString()),
                                new XElement("BV", row["totalbvamt"].ToString()),
                                new XElement("total", row["totalamt"].ToString()),
                                new XElement("batchid", 0),
                                new XElement("OFFERID", 0),
                                new XElement("IGST", IGST),
                                new XElement("IGSTRS", Math.Round(IGSTRS,2)),
                                new XElement("CGST", CGST),
                                new XElement("CGSTRS", Math.Round(CGSTRS,2)),
                                new XElement("SGST", SGST),
                                new XElement("SGSTRS", Math.Round(SGSTRS,2))
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
                        double IGST = 0, IGSTRS = 0, CGST = 0, CGSTRS = 0, SGST = 0, SGSTRS = 0, Qty=0;
                        Qty = Convert.ToDouble(row["quantity"].ToString());
                        double MRP = Math.Round((Convert.ToDouble(row["Rs"].ToString()) * 100 / (100 + Convert.ToDouble(row["Tax"].ToString())) / Qty), 5);
                        double TAXRS = Math.Round((MRP * Convert.ToDouble(row["Tax"].ToString()) / 100), 5);

                        if (User_State == Admin_State)
                        {
                            CGST = Convert.ToDouble(row["tax"].ToString()) / 2;
                            CGSTRS = (Convert.ToSingle(MRP) * Convert.ToSingle(Qty)) * (CGST / 100);
                            SGST = Convert.ToDouble(row["tax"].ToString()) / 2;
                            SGSTRS = (Convert.ToSingle(MRP) * Convert.ToSingle(Qty)) * (SGST / 100);
                        }
                        else
                        {
                            IGST = Convert.ToDouble(row["tax"].ToString());
                            IGSTRS = (Convert.ToSingle(MRP) * Convert.ToSingle(Qty)) * (IGST / 100);
                        }

                        SchemeAmt += (MRP*Qty);
                        SchemeTaxRs += TAXRS;

                        XElement prdXml = new XElement("P",
                            new XElement("pname", row["pname"].ToString()),
                            new XElement("cd", row["Pid"].ToString()),
                            new XElement("dis", 0),
                            new XElement("Qnt", Qty),
                            new XElement("MRP", MRP),
                            new XElement("TAX", row["Tax"].ToString()),
                            new XElement("TAXRS", TAXRS),
                            new XElement("DP", 0),
                            new XElement("BV", 0),
                            new XElement("total", (MRP + TAXRS) * Convert.ToDouble(Qty)),
                            new XElement("batchid", 0),
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
                    SqlCommand com = new SqlCommand(BillType == "1" ?"AddBill" : "StockTransfer", con);
                    com.CommandType = CommandType.StoredProcedure;
                    
                    if (BillType == "1")
                    {
                        com.Parameters.AddWithValue("@regno", UserId);
                        com.Parameters.AddWithValue("@count", Convert.ToInt32(Cartdt.Rows.Count));
                        com.Parameters.AddWithValue("@amt", Convert.ToInt32(Math.Round(Convert.ToDouble(NetAmt) + (SchemeAmt + SchemeTaxRs))).ToString("#0.00"));
                        com.Parameters.AddWithValue("@gross", Convert.ToDouble(GrossAmt) + SchemeAmt);
                        com.Parameters.AddWithValue("@Qnty", TotalQnty);
                        com.Parameters.AddWithValue("@ToalTaxPer", 0);
                        com.Parameters.AddWithValue("@TotalTaxRs", Convert.ToDouble(TaxRs) + SchemeTaxRs);
                        com.Parameters.AddWithValue("@TotalDP", Convert.ToDouble(GrossAmt) + SchemeAmt);
                        com.Parameters.AddWithValue("@TotalBV", totalBV);
                        com.Parameters.AddWithValue("@distype", distype);
                        com.Parameters.AddWithValue("@delChrg", DelCharge);
                        com.Parameters.AddWithValue("@disAmt", Discount);
                        com.Parameters.AddWithValue("@NetAmt", Convert.ToDouble(NetAmt) + (SchemeAmt + SchemeTaxRs));
                        com.Parameters.AddWithValue("@soldTo", UserId);
                        com.Parameters.AddWithValue("@saleRep", HttpContext.Current.Session["admin"].ToString());
                        com.Parameters.AddWithValue("@toAdd", toAdd);
                       // com.Parameters.AddWithValue("@offId", "0");
                        com.Parameters.AddWithValue("@bankname", bankname);
                        com.Parameters.AddWithValue("@checkdate", CheDate_New);
                        com.Parameters.AddWithValue("@checkno", checkno);
                        com.Parameters.AddWithValue("@paymode", paymode);
                        com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
                        com.Parameters.AddWithValue("@orderno", "");
                        com.Parameters.AddWithValue("@PartyGSTNo", GSTNo);
                        com.Parameters.AddWithValue("@PlaceOfSupply", PlaseOfSuply);
                        com.Parameters.AddWithValue("@BillingDate", BillDate_New);
                       // com.Parameters.AddWithValue("@Counponapplied", "0");
                       // com.Parameters.AddWithValue("@Counpon", "");
                        com.Parameters.AddWithValue("@Banktype", "");
                      //  com.Parameters.AddWithValue("@PoitSide", PointType);
                       // com.Parameters.AddWithValue("@usertype", BillBy);
                       // com.Parameters.AddWithValue("@DC_DistId", distributor);
                        com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                        com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                        
                    }
                    else if (BillType == "2")
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
                        com.Parameters.AddWithValue("@saleRep", HttpContext.Current.Session["admin"].ToString());
                        com.Parameters.AddWithValue("@toAdd", toAdd);
                        com.Parameters.AddWithValue("@bankname", bankname);
                        com.Parameters.AddWithValue("@checkdate", CheDate_New);
                        com.Parameters.AddWithValue("@checkno", checkno);
                        com.Parameters.AddWithValue("@paymode", paymode);
                        com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
                        com.Parameters.AddWithValue("@orderno", "");
                        com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                        com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    }

                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                   string status = com.Parameters["@flag"].Value.ToString();
                    string invoiceNo = com.Parameters["@InvNo"].Value.ToString();
                    if (status == "1")
                    {
                        if (BillType == "1")
                            sendSMS(invoiceNo, totalBV.ToString(), totalamt.ToString());

                        HttpContext.Current.Session["AdminCart"] = null;
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


    [WebMethod]
    public static string GetBarcode(string Pid, string DiscounType, string BillType)
            {
        Pid = Pid.Trim();
        String Result = "";

        if (HttpContext.Current.Session["admin"] == null)
        {
            return "Session logout. Please try agian.";
        }

        try
        {
            if (HttpContext.Current.Session["AdminCart"] == null)
                CreateStucture();

            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            { 
                new SqlParameter("@Pid",Pid)
            };

            DataTable DTNew = objDu.GetDataTable(param1, "Select Top 1 ProductId from ShopProductMst where productName=@Pid");
            if (DTNew.Rows.Count > 0)
                Pid = DTNew.Rows[0]["ProductId"].ToString();


            utility obju = new utility();
            if (obju.IsNumeric(Pid) == true)
            {


                DataTable Cartdt = (DataTable)HttpContext.Current.Session["AdminCart"];
                if (Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault() == null)
                {
                    SqlParameter[] param = new SqlParameter[]
                    { 
                        new SqlParameter("@Pid",Pid), 
                        new SqlParameter("@UserId", Adminid),
                        new SqlParameter("@BillType", BillType),
                    };

                    DataTable dt = objDu.GetDataTableSP(param, "Get_Detail_for_Barcode");
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Rows[0]["Error"].ToString() == "0")
                        {
                            if (dt.Rows[0]["Qty"].ToString() != "0")
                            {

                                Double DPAmt = Convert.ToDouble(dt.Rows[0]["DPAmt"].ToString());
                                Double Tax = Convert.ToDouble(dt.Rows[0]["Tax"].ToString());
                                Double GSTAMT = Convert.ToDouble(dt.Rows[0]["GSTAMT"].ToString());

                                DataRow dr = Cartdt.NewRow();
                                dr["pid"] = dt.Rows[0]["pid"].ToString();
                                dr["pname"] = dt.Rows[0]["pname"].ToString();
                                
                                dr["hsncode"] = dt.Rows[0]["HSNCode"].ToString();
                                dr["BVAmt"] = dt.Rows[0]["BVAmt"].ToString();
                                dr["totalbvamt"] = Math.Round(Convert.ToDouble(dt.Rows[0]["BVAmt"].ToString()), 2);
                                dr["MaxQty"] = dt.Rows[0]["Qty"].ToString();

                                dr["qty"] = 1;
                                dr["tax"] = Tax;
                                dr["GSTAMT"] = GSTAMT;
                                dr["DPAmt"] = DPAmt;
                                dr["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                                dr["Gross"] = Math.Round(DPAmt, 2);
                                dr["TaxableAmt"] = Math.Round(DPAmt, 2);
                                


                                dr["totalamt"] = Math.Round((DPAmt + GSTAMT), 2);
                                dr["DiscounType"] = DiscounType;
                                dr["Discount"] = 0;
                                Cartdt.Rows.Add(dr);
                                HttpContext.Current.Session["AdminCart"] = Cartdt;
                            }
                            else
                            {
                                Result = Pid + " Product Quanity is (Zero) : 0  ";
                            }
                        }
                        else
                        {
                            Result = dt.Rows[0]["Error"].ToString();
                        }
                    }
                }
                else
                {
                    DataRow findrow = Cartdt.Select("Pid='" + int.Parse(Pid) + "'").FirstOrDefault();
                    int Qty = findrow == null ? 0 : findrow.Field<int>("Qty");
                    Result = UpdateQty(int.Parse(Pid), (Qty + 1));
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

    [WebMethod]
    public static string UpdateDiscount(int Pid, double Discount, string DiscounType)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["AdminCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault();
                int Qty = findrow == null ? 0 : findrow.Field<int>("qty");
                double tax = findrow == null ? 0 : findrow.Field<double>("tax");
                double GSTAMT = 0, Gross=0;
                double DPAmt = findrow == null ? 0 : findrow.Field<double>("DPAmt");
                if (DiscounType == "%")
                {
                    if (Discount > 100)
                    {
                        return "Discount value less than 100%.!!";
                    }
                    Gross = (DPAmt * Qty);
                    findrow["Gross"] = Math.Round(Gross, 2);

                    Gross = (Gross - (Gross * Discount / 100));
                    GSTAMT = Math.Round((Gross * tax / 100), 2);

                    findrow["GSTAMT"] = Math.Round(GSTAMT / Qty, 2);
                    findrow["TaxableAmt"] = Math.Round(Gross, 2);
                    findrow["totalamt"] = Math.Round(Gross + GSTAMT, 2);
                    findrow["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                }
                else
                {
                    Gross = (DPAmt * Qty);
                    if (Discount > Gross)
                        return "Discount value less than Amount.!!";
                    
                    findrow["Gross"] = Math.Round(Gross, 2);
                    Gross = (Gross - Discount);
                    GSTAMT = Math.Round((Gross * tax / 100), 2);

                    findrow["GSTAMT"] = Math.Round(GSTAMT * Qty, 2);
                    findrow["TaxableAmt"] = Math.Round(Gross, 2);
                    findrow["totalamt"] = Math.Round(Gross + GSTAMT, 2);
                    findrow["Totaltaxamt"] = Math.Round(GSTAMT, 2); 
                }
                findrow["Discount"] = Discount.ToString();
                findrow["qty"] = Qty.ToString();
                findrow["DiscounType"] = DiscounType;
                HttpContext.Current.Session["AdminCart"] = Cartdt;
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    [WebMethod]
    public static string UpdateGST(int Pid, int GST)
    {
        String Result = "";
        DataTable Cartdt = (DataTable)HttpContext.Current.Session["AdminCart"];
        if (Cartdt.Rows.Count > 0)
        {
            DataRow findrow = Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault();
            int Qty = findrow == null ? 0 : findrow.Field<int>("Qty");
            double tax = findrow == null ? 0 : findrow.Field<double>("tax");
            findrow["tax"] = GST;
            HttpContext.Current.Session["AdminCart"] = Cartdt;
            Result = UpdateDataTable(Pid, Qty);
        }
        return Result;
    }


    [WebMethod]
    public static string UpdateQty(int Pid, int Qty)
    {
        return UpdateDataTable(Pid, Qty);
    }


    private static string UpdateDataTable(int Pid, int Qty)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["AdminCart"];
            if (Cartdt.Rows.Count > 0)
            {

                DataRow findrow = Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault();
                if (Qty <= 0)
                {
                    Cartdt = (DataTable)HttpContext.Current.Session["AdminCart"];
                    findrow.Delete();
                    HttpContext.Current.Session["AdminCart"] = Cartdt;
                    return "";
                }

                string DiscounType = findrow == null ? "Rs" : findrow.Field<string>("DiscounType");
                double Discount = findrow == null ? 0 : findrow.Field<double>("Discount");

                int MaxQty = findrow == null ? 0 : findrow.Field<int>("MaxQty");
                double GSTAMT = findrow == null ? 0 : findrow.Field<double>("GSTAMT");
                double BV = findrow == null ? 0 : findrow.Field<double>("BVAmt");
                double DPAmt = findrow == null ? 0 : findrow.Field<double>("DPAmt");
                double tax = findrow == null ? 0 : findrow.Field<double>("tax");
                double Gross = 0;
                if (Qty <= MaxQty)
                {
                    if (DiscounType == "%")
                    {
                        if (Discount > 100)
                        {
                            return "Discount value less than 100%.!!";
                        }
                        Gross = (DPAmt * Qty);
                        findrow["Gross"] = Math.Round(Gross, 2);
                        Gross = Gross - (Gross * Discount / 100);
                        GSTAMT = Math.Round((Gross * tax / 100), 2);

                        findrow["GSTAMT"] = Math.Round(GSTAMT / Qty, 2);
                        findrow["TaxableAmt"] = Math.Round(Gross, 2);
                        findrow["totalamt"] = Math.Round(Gross + GSTAMT, 2);
                        findrow["Totaltaxamt"] = Math.Round(GSTAMT, 2); 
                    }
                    else
                    {
                        Gross = (DPAmt * Qty); 
                        if (Discount > Gross)
                            return "Discount value less than Amount.!!";

                        findrow["Gross"] = Math.Round(Gross, 2);
                        Gross = (Gross - Discount);
                        GSTAMT = Math.Round((Gross * tax / 100), 2);

                        findrow["GSTAMT"] = Math.Round(GSTAMT / Qty, 2);
                        findrow["TaxableAmt"] = Math.Round(Gross, 2);
                        findrow["totalamt"] = Math.Round(Gross + GSTAMT, 2);
                        findrow["Totaltaxamt"] = Math.Round(GSTAMT, 2); 
                    }
                    findrow["qty"] = Qty.ToString();
                    findrow["totalbvamt"] = Qty * BV;
                }
                else
                {
                    Result = "Stock in hand : " + MaxQty.ToString();
                }
                HttpContext.Current.Session["AdminCart"] = Cartdt;
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    [WebMethod]
    public static string DeleteProd(int Pid)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["AdminCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault();
                Cartdt = (DataTable)HttpContext.Current.Session["AdminCart"];
                findrow.Delete();
                HttpContext.Current.Session["AdminCart"] = Cartdt;
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }

    [WebMethod]
    public static ProdDetails[] GetCartData()
    {
        List<ProdDetails> details = new List<ProdDetails>();
        if (HttpContext.Current.Session["AdminCart"] != null)
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["AdminCart"];
            ITEMLISTID = "";
            foreach (DataRow dr in Cartdt.Rows)
            {
                ITEMLISTID += dr["pid"].ToString() + "^" + dr["qty"].ToString() + ",";

                ProdDetails data = new ProdDetails();
                data.Pid = Convert.ToInt32(dr["pid"].ToString().Trim());
                data.DiscounType = dr["DiscounType"].ToString();
                data.pname = dr["pname"].ToString();
               
                data.hsncode = dr["hsncode"].ToString();
                data.qty = Convert.ToInt32(dr["qty"].ToString());
                data.MaxQty = Convert.ToInt32(dr["MaxQty"].ToString());

                data.TaxableAmt =Convert.ToDouble( dr["TaxableAmt"].ToString());
                data.Discount = Convert.ToDouble(dr["Discount"].ToString());

                data.GSTAMT = Convert.ToDouble(dr["GSTAMT"].ToString());
                data.DPAmt = Convert.ToDouble(dr["DPAmt"].ToString());
                data.Gross = Convert.ToDouble(dr["Gross"].ToString());
                data.BVAmt = Convert.ToDouble(dr["BVAmt"].ToString());
                data.totalbvamt = Convert.ToDouble(dr["totalbvamt"].ToString());
                data.tax = Convert.ToDouble(dr["tax"].ToString());
                data.Totaltaxamt = Convert.ToDouble(dr["Totaltaxamt"].ToString());
                data.totalamt = Convert.ToDouble(dr["totalamt"].ToString());
                // data.netamt = Convert.ToDouble(dr["netamt"].ToString());
                details.Add(data);
            }

            HttpContext.Current.Session["ITEMLISTID"] = ITEMLISTID;
        }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static commanProp[] GetOfferProduct(string TotalAmt)
    {
        List<commanProp> details = new List<commanProp>();
        if (HttpContext.Current.Session["ITEMLISTID"] != null)
        {
            ITEMLISTID = HttpContext.Current.Session["ITEMLISTID"].ToString();
            DataTable dt = Offer_Product_List(ITEMLISTID, TotalAmt);
            foreach (DataRow row in dt.Rows)
            {
                commanProp obj = new commanProp();
                obj.Scheme = row["Scheme"].ToString();
                obj.Item_Qty = Convert.ToInt32(row["Item_Qty"]);
                obj.ITEMID = Convert.ToInt32(row["ITEMID"]);
                obj.ItemName = row["ItemName"].ToString();
                obj.ProdOffer = row["ProdOffer"].ToString();
                obj.RS = Convert.ToDouble(row["RS"].ToString());
                obj.NoofItem = Convert.ToInt32(row["NoofItem"]);
                obj.Offer_Type = row["Offer_Type"].ToString();
                details.Add(obj);
            }
        }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static DataTable Offer_Product_List(String ITEMLISTID, String TotalAmt)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter("Get_OfferProduct_Details", con);
        da.SelectCommand.Parameters.AddWithValue("@soldby", HttpContext.Current.Session["admin"].ToString());
        da.SelectCommand.Parameters.AddWithValue("@Productlist", ITEMLISTID);
        da.SelectCommand.Parameters.AddWithValue("@TotalAmt", TotalAmt);
        da.SelectCommand.Parameters.AddWithValue("@OfferOn", 0);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        da.Fill(dt);
        return (dt);
    }


    [System.Web.Services.WebMethod]
    public static DataTable GetSchemeItemId(string SchemeItemId)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter("Get_SchemeItem", con);
        da.SelectCommand.Parameters.AddWithValue("@SchemeItemId", SchemeItemId);
        da.SelectCommand.Parameters.AddWithValue("@soldby", "-111");
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        da.Fill(dt);
        return (dt);
    }


    private static void sendSMS(string invoiceno, string BV, string NetAmt)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter adapter = new SqlDataAdapter("SELECT A.AppMstRegNo,AppMstFName,A.AppMstMobile,B.InvoiceNo FROM AppMst A INNER JOIN BillMst B ON  A.AppMstRegNo=B.SoldTo WHERE B.srno=@srno", con);
        adapter.SelectCommand.CommandType = CommandType.Text;
        adapter.SelectCommand.Parameters.AddWithValue("@srno", invoiceno);
        DataTable dt = new DataTable();
        adapter.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            utility objUtil = new utility();
            string text = "Dear " + dt.Rows[0]["AppMstRegNo"].ToString() + "(" + dt.Rows[0]["AppMstFName"].ToString() + "), purchase invoice No: " + dt.Rows[0]["InvoiceNo"].ToString() + ",BV.:" + BV + ", Amt.:" + NetAmt + ".";
            objUtil.sendSMSByPage(dt.Rows[0]["AppMstMobile"].ToString().Trim(), text);
        }
    }


    [WebMethod]
    public static UserDetails GetUser(string Userid, string BillType)
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
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                objUser.Error = "";
                objUser.UserName = dr["name"].ToString();
                objUser.Address = dr["AppMstAddress1"].ToString();
                objUser.State = dr["AppMstState"].ToString();
                objUser.City = dr["AppMstCity"].ToString();
                objUser.Pincode = dr["AppMstPinCode"].ToString();
                objUser.AdminState = dr["AdminState"].ToString();
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

            ddlplaceofsupply.Items.Clear();
            ddlplaceofsupply.DataSource = dt;
            ddlplaceofsupply.DataTextField = "StateName";
            ddlplaceofsupply.DataValueField = "Id";
            ddlplaceofsupply.DataBind();
            ddlplaceofsupply.Items.Insert(0, new ListItem("Place of Supply", "0"));

        }

    }


    public void BindUserProduct()
    {
        SqlDataReader dr;
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("bindadminproduct", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@adminid", Adminid);
        com.Parameters.AddWithValue("@distype", "0");
        com.Parameters.AddWithValue("@type", "1");
        con.Open();
        dr = com.ExecuteReader();
        divProductcode.InnerText = string.Empty;
        while (dr.Read())
        {
            divProductcode.InnerText += dr["productid"].ToString() + "," + dr["ProductName"].ToString() + ",";
        }
        con.Close();
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
    public static string GetDistName(string UserId)
    {
        string Result = "";
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("Select fname from franchisemst WHERE franchiseid=@UserId and frantype=4", con);
        com.CommandType = CommandType.Text;
        com.CommandTimeout = 999999;
        com.Parameters.AddWithValue("@UserId", UserId);
        con.Open();
        SqlDataReader dr = com.ExecuteReader();
        if (dr.HasRows == true)
        {
            while (dr.Read())
            {
                Result = dr["fname"].ToString();
            }
        }
        return Result;
    }

  

    [WebMethod]
    public static string ResetCart()
    {
        HttpContext.Current.Session["AdminCart"] = null;
        return "";
    }


    #region Stucture

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
        dtStuc.Columns.Add(new DataColumn("MaxQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("DPAmt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Gross", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("TaxableAmt", typeof(double)));

        dtStuc.Columns.Add(new DataColumn("BVAmt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("totalbvamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("tax", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Totaltaxamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("totalamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("GSTAMT", typeof(double)));

        HttpContext.Current.Session["AdminCart"] = dtStuc;
    }

    #endregion


    #region ClassProperty

    public class ProdDetails
    {

        public int Pid { get; set; }
        public String pname { get; set; }
       
        public String hsncode { get; set; }
        public int qty { get; set; }
        public int MaxQty { get; set; }
        public String DiscounType { get; set; }
        public double Discount { get; set; }
        public double DPAmt { get; set; }
        public double Gross { get; set; }
        public double TaxableAmt { get; set; }
        public double BVAmt { get; set; }
        public double totalbvamt { get; set; }
        public double tax { get; set; }
        public double Totaltaxamt { get; set; }
        public double totalamt { get; set; }
        public double GSTAMT { get; set; }

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
    }

    public class commanProp
    {
        public string Scheme { get; set; }
        public int Item_Qty { get; set; }
        public int ITEMID { get; set; }
        public string ItemName { get; set; }
        public string ProdOffer { get; set; }
        public double RS { get; set; }
        public int NoofItem { get; set; }
        public string Offer_Type { get; set; }
    }

    #endregion

}