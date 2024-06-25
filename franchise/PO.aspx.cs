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

public partial class franchise_OP : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            
            if (!IsPostBack)
            {
                if (Session["franchiseid"] == null)
                    Response.Redirect("Logout.aspx");


                txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["id"] != null)
                    {
                        HttpContext.Current.Session["POCart"] = null;
                        BindPO(Request.QueryString["id"].ToString());

                        BindState();
                        BindUserProduct();

                        txt_Barcode.Attributes.Add("onblur", "javascript:GetProduct()");
                    }
                }


            }
        }
        catch (Exception er) { }
    }



    #region Genearate Invoice
    [WebMethod]
    public static Results GenerateInv(string PONo, string UserId, string Discount, string DelCharge, string User_State, string Admin_State, string paymode, string bankname, string checkno, string CheDate,
    string toAdd, string GSTNo, string PlaseOfSuply, string SellerState, string ClosePO, string UserRemark)
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
        if (HttpContext.Current.Session["franchiseid"] == null)
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


            DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
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
                                new XElement("Received", row["qty"].ToString()),
                                new XElement("Damage", "0"),
                                new XElement("MRP", row["DPAmt"].ToString()),
                                new XElement("TAX", row["Tax"].ToString()),
                                new XElement("TAXRS", row["Totaltaxamt"].ToString()),
                                new XElement("DP", row["DPAmt"].ToString()),
                                new XElement("DPWithTax", row["DPWithTax"].ToString()),
                                new XElement("BV", row["totalbvamt"].ToString()),
                                new XElement("FPV", row["FPV"].ToString()),
                                new XElement("TotalFPV", row["TotalFPV"].ToString()),

                                new XElement("total", row["totalamt"].ToString()),
                                new XElement("batchid", row["batchid"].ToString()),
                                new XElement("OFFERID", row["OFFERID"].ToString()),
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




                var xmlObject = new XmlDocument();
                xmlObject.LoadXml(element.ToString());
                if (element != null)
                {
                    object sumqty, totalamt, GrossAmt, totalBV, TaxRs, NetAmt, TotalFPV;
                    sumqty = Cartdt.Compute("Sum(qty)", "");
                    totalamt = Cartdt.Compute("Sum(totalamt)", "");
                    GrossAmt = Cartdt.Compute("Sum(Gross)", "");
                    TotalFPV = Cartdt.Compute("Sum(TotalFPV)", "");
                    totalBV = Cartdt.Compute("Sum(totalbvamt)", "");
                    TaxRs = Cartdt.Compute("Sum(Totaltaxamt)", "");
                    NetAmt = (Convert.ToDouble(totalamt) + Convert.ToDouble(DelCharge) - Convert.ToDouble(Discount));

                    SqlConnection con = new SqlConnection(method.str);
                    SqlCommand com = new SqlCommand("StockTransfer", con);
                    com.CommandType = CommandType.StoredProcedure;
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
                    com.Parameters.AddWithValue("@orderno", PONo);
                    com.Parameters.AddWithValue("@ClosePO", ClosePO);
                    com.Parameters.AddWithValue("@LogId", HttpContext.Current.Session["LogId"].ToString());
                    com.Parameters.AddWithValue("@IP", HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null ? HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] : HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"]);

                    com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    com.Parameters.AddWithValue("@TotalFPV", TotalFPV);
                    com.Parameters.AddWithValue("@UserRemark", UserRemark);

                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    string status = com.Parameters["@flag"].Value.ToString();
                    string invoiceNo = com.Parameters["@InvNo"].Value.ToString();
                    if (status == "1")
                    {
                        DataUtility objDu = new DataUtility();
                        utility objutil = new utility();

                        DataTable dt = objDu.GetDataTable("Select InvoiceNo from StockTranReport where srno=" + invoiceNo);
                        if (dt.Rows.Count > 0)
                            objResult.InvoiceNo = dt.Rows[0]["InvoiceNo"].ToString();

                        HttpContext.Current.Session["POCart"] = null;
                        objResult.Url = method.WEB_URL + "/Common/StockTranBill.aspx?id=" + objutil.base64Encode(invoiceNo);
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

    private void BindPO(string srno)
    {
        //lblMsg.Text = "";
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@srno", srno),
                 new SqlParameter("@UserId", HttpContext.Current.Session["franchiseid"].ToString())
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "Select InvoiceNo, NetAmt, SoldTo, SalesRep, Detail, Doe, PayMode, SellerState, UserRemark, PlaceOfSupply=(Select Id FROM stategstmst where StateName=PO_Mst.PlaceOfSupply), S_Dist=(Select id from districtmst Where districtname=PO_Mst.S_Dist), status, S_Name , S_Mobile ,  S_Address , S_City , S_Pincod from PO_Mst where SalesRep=@UserId and srno=@srno");

            if (dt.Rows.Count > 0)
            {
                txt_PONo.Text = dt.Rows[0]["InvoiceNo"].ToString();
                txt_Userid.Text = dt.Rows[0]["SoldTo"].ToString();

                txt_UserRemark.Text = dt.Rows[0]["UserRemark"].ToString();
                txtUserName.Text = dt.Rows[0]["S_Name"].ToString();
                txt_Mobile.Text = dt.Rows[0]["S_Mobile"].ToString();
                txtaddress.Text = dt.Rows[0]["S_Address"].ToString();
                ddl_state.SelectedValue = dt.Rows[0]["PlaceOfSupply"].ToString();
                hnd_Dist.Value = dt.Rows[0]["S_Dist"].ToString();
                txtCity.Text = dt.Rows[0]["S_City"].ToString();
                txtPincode.Text = dt.Rows[0]["S_Pincod"].ToString();

                if (dt.Rows[0]["status"].ToString() == "1")
                {
                    hnd_ClosePO.Value = "1";
                    chk_Status.Checked = true;
                    chk_Status.Enabled = false;
                    txt_Barcode.Enabled = false;
                }
            }
            else
            {
                txt_PONo.Text = "";
                txt_Userid.Text = "";
            }

            SqlParameter[] param1 = new SqlParameter[]
            {
                 new SqlParameter("@srno", srno),
                 new SqlParameter("@SalesRep", HttpContext.Current.Session["franchiseid"].ToString())
            };

            DataTable dt1 = objDu.GetDataTableSP(param1, "Get_PO_XML");
            if (HttpContext.Current.Session["POCart"] == null)
                CreateStucture();

            DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
            foreach (DataRow drTbl in dt1.Rows)
            {
                DataRow dr = Cartdt.NewRow();

                int Sno = 1;
                if (Cartdt.Rows.Count > 0)
                    Sno = 1 + Convert.ToInt32(Cartdt.AsEnumerable().Max(row => row["Sno"]));

                dr["Sno"] = Sno;
                dr["pid"] = drTbl["Pid"].ToString();
                dr["batchid"] = drTbl["BatchId"].ToString();
                dr["Pcode"] = drTbl["Pcode"].ToString();
                dr["pname"] = drTbl["PName"].ToString();
                dr["hsncode"] = drTbl["HSN"].ToString();
                dr["BVAmt"] = drTbl["BV"].ToString();
                dr["totalbvamt"] = (Convert.ToInt32(drTbl["Qnt"].ToString()) * Convert.ToDouble(drTbl["BV"].ToString()));
                dr["FPV"] = drTbl["FPV"].ToString();
                dr["TotalFPV"] = (Convert.ToInt32(drTbl["ReqQnt"].ToString()) * Convert.ToDouble(drTbl["FPV"].ToString()));
                dr["MaxQty"] = drTbl["MaxQty"].ToString();
                dr["ReqQnt"] = drTbl["ReqQnt"].ToString();
                dr["OFFERID"] = drTbl["OFFERID"].ToString();
                dr["Received"] = Convert.ToInt32(drTbl["Received"]);
                dr["BatchQty"] = Convert.ToInt32(drTbl["BatchQty"]);
                dr["qty"] = Convert.ToInt32(drTbl["Qnt"]);
                dr["tax"] = drTbl["TAX"].ToString();
                dr["BatchNo"] = drTbl["BatchNo"].ToString();
                dr["GSTAMT"] = drTbl["GstAmt"].ToString();
                dr["DPAmt"] = drTbl["DP"].ToString();
                dr["DPWithTax"] = drTbl["DPWithTax"].ToString();

                dr["Totaltaxamt"] = drTbl["GstAmt"].ToString();
                dr["Gross"] = drTbl["Gross"].ToString();
                dr["TaxableAmt"] = drTbl["Gross"].ToString();

                dr["totalamt"] = drTbl["TotalAmt"].ToString();
                dr["DiscounType"] = "Rs";
                dr["Discount"] = 0;
                dr["IsComboPack"] = drTbl["IsComboPack"].ToString();

                Cartdt.Rows.Add(dr);
                HttpContext.Current.Session["POCart"] = Cartdt;

                Calculater(Convert.ToInt32(drTbl["BatchId"].ToString()));

            }
            HttpContext.Current.Session["POCart"] = Cartdt;
        }
        catch (Exception ex)
        {
        }
    }


    [WebMethod]
    public static string GetBarcode(string Productcode)
    {

        String[] strProduct = Productcode.Split(new String[] { "=" }, StringSplitOptions.RemoveEmptyEntries);
        try
        {
            if (strProduct[0] != null)
                Productcode = strProduct[0];
        }
        catch { }


        String Result = "";

        if (HttpContext.Current.Session["franchiseid"] == null)
        {
            return "Session logout. Please try agian.";
        }

        try
        {
            if (HttpContext.Current.Session["POCart"] == null)
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
                    DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
                    if (Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault() == null)
                    {
                        int Output = AddRow(Pid, "", "", "", 1, IsComboPack);
                        if (Output == 0)
                            Result = "0";
                    }
                    else
                    {
                        Result = "This product already added.!!";
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
                 new SqlParameter("@UserId", HttpContext.Current.Session["franchiseid"].ToString()),
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
                        DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
                        Double DPAmt = Convert.ToDouble(dt.Rows[0]["DPAmt"].ToString());
                        Double Tax = Convert.ToDouble(dt.Rows[0]["Tax"].ToString());
                        Double GSTAMT = Convert.ToDouble(dt.Rows[0]["GSTAMT"].ToString());

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

                        dr["FPV"] = dt.Rows[0]["FPV"].ToString();
                        dr["TotalFPV"] = dt.Rows[0]["FPV"].ToString();


                        dr["totalbvamt"] = Math.Round(Convert.ToDouble(dt.Rows[0]["BVAmt"].ToString()), 2);
                        dr["MaxQty"] = dt.Rows[0]["MaxQty"].ToString();
                        dr["OFFERID"] = "0";
                        dr["ReqQnt"] = "0";
                        dr["Received"] = "0";
                        dr["BatchQty"] = Convert.ToInt32(dt.Rows[0]["Qty"]);
                        dr["qty"] = AddQty;
                        dr["tax"] = Tax;
                        dr["BatchNo"] = dt.Rows[0]["BatchNo"].ToString();
                        dr["GSTAMT"] = GSTAMT;
                        dr["DPAmt"] = DPAmt;
                        dr["DPWithTax"] = dt.Rows[0]["DPWithTax"].ToString(); ;

                        dr["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                        dr["Gross"] = Math.Round(DPAmt, 2);
                        dr["TaxableAmt"] = Math.Round(DPAmt, 2);

                        dr["totalamt"] = Math.Round((DPAmt + GSTAMT), 2);
                        dr["DiscounType"] = "Rs";
                        dr["Discount"] = 0;
                        dr["IsComboPack"] = IsComboPack;

                        Cartdt.Rows.Add(dr);
                        HttpContext.Current.Session["POCart"] = Cartdt;

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
    public static string UpdateQty(int batchid, int Qty)
    {
        String Result = "";
        try
        {
            if (Qty <= 0)
            {
                DeleteRecord(batchid);
                return Result;
            }

            DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
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
                    HttpContext.Current.Session["POCart"] = Cartdt;
                    Calculater(batchid);

                    while (BalQty > 0)
                    {
                        int AddedQty = AddRow(Pid.ToString(), "", "", GetBatchList(Pid), BalQty, "0");
                        BalQty = BalQty - AddedQty;
                        if (AddedQty == 0)
                            BalQty = 0;
                    }
                }
                else
                {
                    findrow["qty"] = Qty.ToString();
                    HttpContext.Current.Session["POCart"] = Cartdt;
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
        DataTable dt = (DataTable)HttpContext.Current.Session["POCart"];
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
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();

                int Qty = findrow == null ? 0 : findrow.Field<int>("qty");
                double tax = findrow == null ? 0 : findrow.Field<double>("tax");
                double DPAmt = findrow == null ? 0 : findrow.Field<double>("DPAmt");
                double FPV = findrow == null ? 0 : findrow.Field<double>("FPV");
                double BV = findrow == null ? 0 : findrow.Field<double>("BVAmt");
                double Discount = findrow == null ? 0 : findrow.Field<double>("Discount");
                string DiscounType = findrow == null ? "Rs" : findrow.Field<string>("DiscounType");
                double GSTAMT = 0, Gross = 0;

                if (DiscounType == "%")
                {
                    Gross = (DPAmt * Qty);
                    findrow["Gross"] = Math.Round(Gross, 2);

                    Gross = (Gross - (Gross * Discount / 100));


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

                    findrow["Gross"] = Gross;
                    Gross = (Gross - Discount);
                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 4, MidpointRounding.ToEven);
                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 4, MidpointRounding.ToEven);

                    findrow["GSTAMT"] = Math.Round(GSTAMT * Qty, 2);
                    findrow["TaxableAmt"] = Math.Round(Gross, 2);
                    findrow["totalamt"] = Math.Round(Gross + GSTAMT, 2);
                    findrow["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                }
                findrow["totalbvamt"] = Qty * (Discount == 0 ? BV : 0);
                findrow["TotalFPV"] = Qty * (Discount == 0 ? FPV : 0);

                HttpContext.Current.Session["POCart"] = Cartdt;
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
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
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
                HttpContext.Current.Session["POCart"] = Cartdt;
                Calculater(batchid);
            }

        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    [WebMethod]
    public static string UpdateGST(int batchid, int GST)
    {
        DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
        if (Cartdt.Rows.Count > 0)
        {
            DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();
            int Qty = findrow == null ? 0 : findrow.Field<int>("Qty");
            double tax = findrow == null ? 0 : findrow.Field<double>("tax");
            findrow["tax"] = GST;
            HttpContext.Current.Session["POCart"] = Cartdt;
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

            //DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
            //if (Cartdt != null)
            //{
            //    foreach (DataRow dr in Cartdt.Rows)
            //        Calculater(Convert.ToInt32(dr["batchid"].ToString()));
            //}
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    private static string DeleteRecord(int batchid)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault();
                Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
                findrow.Delete();
                HttpContext.Current.Session["POCart"] = Cartdt;
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    [WebMethod]
    public static ProdDetails[] GetCartData()
    {
        List<ProdDetails> details = new List<ProdDetails>();
        if (HttpContext.Current.Session["POCart"] != null)
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];

            DataView view = Cartdt.DefaultView;
            view.Sort = "Sno Desc";
            DataTable dt_Sorted = view.ToTable();

            foreach (DataRow dr in dt_Sorted.Rows)
            {


                ProdDetails data = new ProdDetails();
                data.Pid = Convert.ToInt32(dr["pid"].ToString().Trim());
                data.batchid = Convert.ToInt32(dr["batchid"].ToString().Trim());
                data.DiscounType = dr["DiscounType"].ToString();
                data.pname = dr["pname"].ToString();
                data.Pcode = dr["Pcode"].ToString();
                data.hsncode = dr["hsncode"].ToString();
                data.qty = Convert.ToInt32(dr["qty"].ToString());
                data.MaxQty = Convert.ToInt32(dr["MaxQty"].ToString());


                data.OFFERID = Convert.ToInt32(dr["OFFERID"].ToString());
                data.ReqQnt = Convert.ToInt32(dr["ReqQnt"].ToString());
                data.Received = Convert.ToInt32(dr["Received"].ToString());

                data.TaxableAmt = Convert.ToDouble(dr["TaxableAmt"].ToString());
                data.Discount = Convert.ToDouble(dr["Discount"].ToString());
                data.BatchNo = dr["BatchNo"].ToString();
                data.GSTAMT = Convert.ToDouble(dr["GSTAMT"].ToString());
                data.DPAmt = Convert.ToDouble(dr["DPAmt"].ToString());
                data.Gross = Convert.ToDouble(dr["Gross"].ToString());
                data.BVAmt = Convert.ToDouble(dr["BVAmt"].ToString());
                data.totalbvamt = Convert.ToDouble(dr["totalbvamt"].ToString());
                data.FPV = Convert.ToDouble(dr["FPV"].ToString());
                data.TotalFPV = Convert.ToDouble(dr["TotalFPV"].ToString());

                data.tax = Convert.ToDouble(dr["tax"].ToString());
                data.Totaltaxamt = Convert.ToDouble(dr["Totaltaxamt"].ToString());
                data.totalamt = Convert.ToDouble(dr["totalamt"].ToString());
                data.IsComboPack = dr["IsComboPack"].ToString();
                // data.netamt = Convert.ToDouble(dr["netamt"].ToString());
                details.Add(data);
            }

        }
        return details.ToArray();
    }



    [WebMethod]
    public static UserDetails GetUser(string Userid)
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
            cmd.Parameters.AddWithValue("@BillType", "2");
            cmd.Parameters.AddWithValue("@SessionId", HttpContext.Current.Session["franchiseid"].ToString());
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


    public void BindAdminState()
    {
        DataUtility objDUT = new DataUtility();
        DataTable dt = new DataTable();
        SqlParameter[] sqlparam = new SqlParameter[] {
             new SqlParameter("@regno", Session["franchiseid"].ToString())
        };
        dt = objDUT.GetDataTableSP(sqlparam, "GetAdminState");
        if (dt.Rows.Count > 0)
            ddlSellerState.SelectedValue = dt.Rows[0]["AdminState"].ToString();
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


    public void BindUserProduct()
    {

        SqlParameter[] param = new SqlParameter[] {
             new SqlParameter("@PackType", "0"),
                new SqlParameter("@BillType", "0"),
                new SqlParameter("@Userid", HttpContext.Current.Session["franchiseid"].ToString())
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetShopProduct_Billing");
        foreach (DataRow dr in dt.Rows)
        {
            if (dr["Qty"].ToString() != "0")
                divProductcode.InnerText += dr["productCode"].ToString() + "= " + dr["ProductName"].ToString() + " (" + dr["PackSize"].ToString() + ") Qty: " + dr["Qty"].ToString() + ",";
            //divProductcode.InnerText += dr["productCode"].ToString() + "= " + dr["ProductName"].ToString() + " (" + dr["PackSize"].ToString() + ") Qty: " + dr["Qty"].ToString() + "," + dr["ProductName"].ToString() + "= " + dr["productCode"].ToString() + " (" + dr["PackSize"].ToString() + ") Qty: " + dr["Qty"].ToString() + ",";
            // divProductcode.InnerText += dr["productCode"].ToString() + "= " + dr["ProductName"].ToString() + " (" + dr["PackSize"].ToString() + ")," + dr["ProductName"].ToString() + "= " + dr["productCode"].ToString() + " (" + dr["PackSize"].ToString() + "),";
        }
    }



    [WebMethod]
    public static string GetBalanceUser(string RegNo)
    {
        String Balance = "0";
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("getwalletBalanceFran", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@appmstid", RegNo);
            com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            Balance = com.Parameters["@Bal"].Value.ToString();
        }
        catch (Exception ex) { }
        return Balance;

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



    [WebMethod]
    public static string ResetCart()
    {
        HttpContext.Current.Session["POCart"] = null;
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
        dtStuc.Columns.Add(new DataColumn("qty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("Received", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("batchid", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("BatchNo", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("BatchQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("MaxQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("ReqQnt", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("OFFERID", typeof(int)));

        dtStuc.Columns.Add(new DataColumn("DPAmt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("DPWithTax", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Gross", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("TaxableAmt", typeof(double)));

        dtStuc.Columns.Add(new DataColumn("FPV", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("TotalFPV", typeof(double)));

        dtStuc.Columns.Add(new DataColumn("BVAmt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("totalbvamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("tax", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Totaltaxamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("totalamt", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("GSTAMT", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("IsComboPack", typeof(string)));

        HttpContext.Current.Session["POCart"] = dtStuc;
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

        public int Received { get; set; }
        public int batchid { get; set; }
        public String BatchNo { get; set; }
        public int BatchQty { get; set; }
        public int MaxQty { get; set; }
        public int ReqQnt { get; set; }
        public int OFFERID { get; set; }

        public double FPV { get; set; }
        public double TotalFPV { get; set; }

        public String DiscounType { get; set; }
        public double Discount { get; set; }
        public double DPAmt { get; set; }
        public double DPWithTax { get; set; }
        public double Gross { get; set; }
        public double TaxableAmt { get; set; }
        public double BVAmt { get; set; }
        public double totalbvamt { get; set; }
        public double tax { get; set; }
        public double Totaltaxamt { get; set; }
        public double totalamt { get; set; }
        public double GSTAMT { get; set; }

        public String IsComboPack { get; set; }
    }

    public class Results
    {
        public String Error { get; set; }
        public String InvoiceNo { get; set; }
        public String status { get; set; }
        public String Url { get; set; }
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
    }

    private DataTable CreateStructure()
    {
        DataTable dt_temp = new DataTable();
        //dt.Load(reader);
        DataColumn column = new DataColumn("id", typeof(Int32));
        column.DataType = System.Type.GetType("System.Int32");
        column.AutoIncrement = true;
        column.AutoIncrementSeed = 1;
        column.AutoIncrementStep = 1;
        dt_temp.Columns.Add(column);

        DataColumn srno = new DataColumn("srno", typeof(Int32));
        srno.DefaultValue = 0;
        dt_temp.Columns.Add(srno);

        DataColumn Received = new DataColumn("Received", typeof(Int32));
        Received.DefaultValue = 0;
        dt_temp.Columns.Add(Received);

        DataColumn RMNG = new DataColumn("RMNG", typeof(Int32));
        RMNG.DefaultValue = 0;
        dt_temp.Columns.Add(RMNG);

        DataColumn Damage = new DataColumn("Damage", typeof(Int32));
        Damage.DefaultValue = 0;
        dt_temp.Columns.Add(Damage);

        DataColumn batchid = new DataColumn("batchid", typeof(Int32));
        batchid.DefaultValue = 0;
        dt_temp.Columns.Add(batchid);

        DataColumn dcpnmae = new DataColumn("pname", typeof(string));
        dcpnmae.DefaultValue = string.Empty;
        dt_temp.Columns.Add(dcpnmae);

        DataColumn hsncode = new DataColumn("hsncode", typeof(string));
        hsncode.DefaultValue = string.Empty;
        dt_temp.Columns.Add(hsncode);

        DataColumn dcMRP = new DataColumn("Price", typeof(float));
        dcMRP.DefaultValue = 0;
        dt_temp.Columns.Add(dcMRP);

        DataColumn code = new DataColumn("cd", typeof(float));
        code.DefaultValue = 0;
        dt_temp.Columns.Add(code);

        DataColumn pcode = new DataColumn("pcode", typeof(string));
        pcode.DefaultValue = string.Empty;
        dt_temp.Columns.Add(pcode);


        DataColumn dcTax = new DataColumn("Tax", typeof(float));
        dcTax.DefaultValue = 0;
        dt_temp.Columns.Add(dcTax);
        DataColumn dcTaxRs = new DataColumn("TaxRs", typeof(float));
        dcTaxRs.DefaultValue = 0;
        dt_temp.Columns.Add(dcTaxRs);

        DataColumn dc = new DataColumn("quantity", typeof(int));
        dc.DefaultValue = 0;
        dt_temp.Columns.Add(dc);


        DataColumn total = new DataColumn("total", typeof(double));
        total.DefaultValue = 0;
        dt_temp.Columns.Add(total);

        DataColumn Qty = new DataColumn("Qty", typeof(double));
        Qty.DefaultValue = 0;
        dt_temp.Columns.Add(Qty);
        DataColumn gross = new DataColumn("gross", typeof(double));
        gross.DefaultValue = 0;
        dt_temp.Columns.Add(gross);


        DataColumn IGST = new DataColumn("IGST", typeof(double));
        IGST.DefaultValue = 0;
        dt_temp.Columns.Add(IGST);
        DataColumn IGSTRS = new DataColumn("IGSTRS", typeof(double));
        IGSTRS.DefaultValue = 0;
        dt_temp.Columns.Add(IGSTRS);


        DataColumn CGST = new DataColumn("CGST", typeof(double));
        CGST.DefaultValue = 0;
        dt_temp.Columns.Add(CGST);
        DataColumn CGSTRS = new DataColumn("CGSTRS", typeof(double));
        CGSTRS.DefaultValue = 0;
        dt_temp.Columns.Add(CGSTRS);

        DataColumn SGST = new DataColumn("SGST", typeof(double));
        SGST.DefaultValue = 0;
        dt_temp.Columns.Add(SGST);
        DataColumn SGSTRS = new DataColumn("SGSTRS", typeof(double));
        SGSTRS.DefaultValue = 0;
        dt_temp.Columns.Add(SGSTRS);

        return dt_temp;
    }



    #endregion



    //[System.Web.Services.WebMethod]
    //public static DataTable RedeemProd()
    //{
    //    SqlConnection con = new SqlConnection(method.str);
    //    SqlDataAdapter da = new SqlDataAdapter("GetRedeemProd", con);
    //    da.SelectCommand.Parameters.AddWithValue("@Userid", HttpContext.Current.Session["franchiseid"].ToString());
    //    da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    DataTable dt = new DataTable();
    //    da.Fill(dt);
    //    return (dt);
    //}

}