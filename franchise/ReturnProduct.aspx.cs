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
public partial class franchise_ReturnProduct : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Session["franchiseid"] == null)
                    Response.Redirect("Logout.aspx");

                if (Session["FranchiseId"].ToString() == method.DEFAULT_SELLER)
                {
                    txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");

                    payoutdate();
                    checkpage();
                    BindState();

                    HttpContext.Current.Session["ReturnCart"] = null;
                }
                else
                {
                    Response.Redirect("Logout.aspx");
                }
            }
        }
        catch (Exception er) { }
    }


    #region Genearate Invoice
    [WebMethod]
    public static Results GenerateInv(string FromId, string ToId, string Discount, string DelCharge, string User_State, string Admin_State, string paymode,
    string bankname, string checkno, string CheDate, string toAdd, string BuyerState, string SellerState)
    {

        int TotalQnty = 0;
        Results objResult = new Results();
        FromId = FromId.Trim();
        if (FromId == "")
        {
            objResult.Error = "Please Enter FromId.";
            return objResult;
        }
        ToId = ToId.Trim();
        if (ToId == "")
        {
            objResult.Error = "Please Enter ToId.";
            return objResult;
        }
        if (ToId == FromId)
        {
            objResult.Error = "Both Ids are can not same.!!";
            return objResult;
        }

        if (HttpContext.Current.Session["franchiseid"] == null)
        {
            objResult.Error = "Sessionlogout";
            return objResult;
        }

        XElement element = null;
        try
        {
            String CheDate_New = "";
            try
            {
                if (CheDate.Length > 0)
                {
                    String[] Date = CheDate.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    CheDate_New = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
                else
                    CheDate_New = "01/01/1900";
            }
            catch (Exception er)
            {
                objResult.Error = er.Message;
                return objResult;
            }


            DataTable Cartdt = (DataTable)HttpContext.Current.Session["ReturnCart"];
            if (Cartdt == null)
            {
                objResult.Error = "Your cart is empty.";
                return objResult;
            }
            if (Cartdt != null)
            {
                foreach (DataRow dr in Cartdt.Rows)
                {
                    Calculater(Convert.ToInt32(dr["Sno"].ToString()));
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
                                new XElement("Gross", row["TaxableAmt"].ToString()),
                                new XElement("total", row["totalamt"].ToString()),
                                new XElement("batchid", row["batchid"].ToString()),
                                new XElement("OFFERID", "0"),
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


                var xmlObject = new XmlDocument();
                xmlObject.LoadXml(element.ToString());
                if (element != null)
                {
                    object sumqty, totalamt, TaxableAmt, totalBV, TaxRs, NetAmt, TotalFPV;
                    sumqty = Cartdt.Compute("Sum(qty)", "");
                    totalamt = Cartdt.Compute("Sum(totalamt)", "");
                    TaxableAmt = Cartdt.Compute("Sum(TaxableAmt)", "");
                    totalBV = Cartdt.Compute("Sum(totalbvamt)", "");
                    TotalFPV = Cartdt.Compute("Sum(TotalFPV)", "");
                    TaxRs = Cartdt.Compute("Sum(Totaltaxamt)", "");
                    NetAmt = (Convert.ToDouble(totalamt) + Convert.ToDouble(DelCharge) - Convert.ToDouble(Discount));



                    SqlConnection con = new SqlConnection(method.str);
                    SqlCommand com = new SqlCommand("AddReturnItemStock", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@SessionId", HttpContext.Current.Session["franchiseid"].ToString());
                    com.Parameters.AddWithValue("@FromId", FromId);
                    com.Parameters.AddWithValue("@ToId", ToId);

                    com.Parameters.AddWithValue("@ProdCount", Convert.ToInt32(Cartdt.Rows.Count));
                    com.Parameters.AddWithValue("@Amount", Convert.ToInt32(Convert.ToDouble(totalamt) + Convert.ToDouble(DelCharge)).ToString("#0.00"));
                    com.Parameters.AddWithValue("@Gross", Convert.ToDouble(TaxableAmt));
                    com.Parameters.AddWithValue("@ProdQnt", TotalQnty);
                    com.Parameters.AddWithValue("@TaxRs", Convert.ToDouble(TaxRs));
                    com.Parameters.AddWithValue("@TotalBV", totalBV);
                    com.Parameters.AddWithValue("@Discount", Discount);
                    com.Parameters.AddWithValue("@NetAmt", Convert.ToDouble(NetAmt));

                    com.Parameters.AddWithValue("@toAdd", toAdd);
                    com.Parameters.AddWithValue("@paymode", paymode);
                    com.Parameters.AddWithValue("@bankname", bankname);
                    com.Parameters.AddWithValue("@checkdate", CheDate_New);
                    com.Parameters.AddWithValue("@checkno", checkno);

                    com.Parameters.AddWithValue("@BuyerState", BuyerState);
                    com.Parameters.AddWithValue("@sellerstate", SellerState);

                    com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;

                    com.Parameters.Add("@flag", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    com.Parameters.Add("@InvNo", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;

                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    string status = com.Parameters["@flag"].Value.ToString();
                    string invoiceNo = com.Parameters["@InvNo"].Value.ToString();
                    if (status == "1")
                    {
                        HttpContext.Current.Session["ReturnCart"] = null;
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
    public static string GetBarcode(string Productcode, string Userid)
    {
        String Result = "";
        String[] strProduct = Productcode.Split(new String[] { "=" }, StringSplitOptions.RemoveEmptyEntries);
        try
        {
            if (strProduct[0] != null)
                Productcode = strProduct[0];
        }
        catch { }

        if (HttpContext.Current.Session["franchiseid"] == null)
            return "Sessionlogout";

        try
        {
            if (HttpContext.Current.Session["ReturnCart"] == null)
                CreateStucture();

            SqlParameter[] param1 = new SqlParameter[]
            {
                new SqlParameter("@Productcode", Productcode)
            };

            string Pid = "0";
            DataUtility objDu = new DataUtility();
            DataTable DTNew = objDu.GetDataTable(param1, "Select Top 1 ProductId, IsComboPack=isnull(IsComboPack,0) from ShopProductMst where (productName=@Productcode or Productcode=@Productcode)");
            if (DTNew.Rows.Count > 0)
                Pid = DTNew.Rows[0]["ProductId"].ToString();
            else
                Pid = "0";
            if(DTNew.Rows[0]["IsComboPack"].ToString()=="1")
            {
                return "Combo product not allowed.";
            }
            if (Pid != "0")
            {
                utility obju = new utility();
                if (obju.IsNumeric(Pid) == true)
                {
                    DataTable Cartdt = (DataTable)HttpContext.Current.Session["ReturnCart"];
                    //if (Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault() == null)
                    //{
                    int Output = AddRow(Pid, "", 1, Userid);
                    if (Output == 0)
                        Result = "0";
                    //}
                    //else
                    //{
                    // Result = "1";
                    // }
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


    private static int AddRow(string Pid, string BatchList, int AddQty, string Userid)
    {
        try
        {
            if (string.IsNullOrEmpty(BatchList))
                BatchList = GetBatchList(Pid);

            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@Pid", Pid),
                 new SqlParameter("@UserId", Userid),
                 new SqlParameter("@BatchList", BatchList)
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "Get_ReturnProduct");
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Error"].ToString() == "0")
                {
                    if (dt.Rows[0]["Qty"].ToString() != "0")
                    {

                        DataTable Cartdt = (DataTable)HttpContext.Current.Session["ReturnCart"];
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
                        dr["Batch"] = dt.Rows[0]["Batch"].ToString();

                        dr["BVAmt"] = dt.Rows[0]["BVAmt"].ToString();
                        dr["FPV"] = dt.Rows[0]["FPV"].ToString();
                        dr["totalbvamt"] = Math.Round(Convert.ToDouble(dt.Rows[0]["BVAmt"].ToString()), 2);
                        dr["TotalFPV"] = dt.Rows[0]["FPV"].ToString();

                        dr["MaxQty"] = dt.Rows[0]["MaxQty"].ToString();
                        dr["BatchQty"] = Convert.ToInt32(dt.Rows[0]["Qty"]);
                        dr["qty"] = AddQty;
                        dr["tax"] = Tax;
                        dr["BatchNo"] = dt.Rows[0]["BatchNo"].ToString();
                        dr["GSTAMT"] = GSTAMT;
                        dr["DPAmt"] = Math.Round(DPAmt, 4);


                        dr["DPWithTax"] = dt.Rows[0]["DPWithTax"].ToString();

                        dr["Weight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString());
                        dr["TotalWeight"] = Convert.ToDouble(dt.Rows[0]["Weight"].ToString()) * AddQty;

                        dr["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                        dr["Gross"] = Math.Round(DPAmt, 2);
                        dr["TaxableAmt"] = Math.Round(DPAmt, 2);

                        dr["totalamt"] = Math.Round((DPAmt + GSTAMT), 2);
                        dr["DiscounType"] = "%";
                        dr["Discount"] = 0;
                        Cartdt.Rows.Add(dr);
                        HttpContext.Current.Session["ReturnCart"] = Cartdt;

                        Calculater(Convert.ToInt32(dt.Rows[0]["Sno"]));
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
    public static string UpdateBatch(int Sno, int batchid, string FromId)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["ReturnCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Sno='" + Sno + "'").FirstOrDefault();
                int Pid = findrow == null ? 0 : findrow.Field<int>("Pid");

                string BatchList = GetBatchList(Pid.ToString());

                SqlParameter[] param = new SqlParameter[]
               {
                     new SqlParameter("@Pid", Pid),
                     new SqlParameter("@UserId", FromId),
                     new SqlParameter("@BatchList", BatchList)
               };
                DataUtility objDu = new DataUtility();
                DataTable dt = objDu.GetDataTableSP(param, "Get_ReturnProduct");
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["Error"].ToString() == "0")
                    {
                        if (dt.Rows[0]["Qty"].ToString() != "0")
                        {
                            int Qty = findrow == null ? 0 : findrow.Field<int>("qty");
                            if (Qty > Convert.ToInt32(dt.Rows[0]["Qty"]))
                                Qty = Convert.ToInt32(dt.Rows[0]["Qty"]);

                            Double DPAmt = Convert.ToDouble(dt.Rows[0]["DPAmt"].ToString());
                            Double Tax = Convert.ToDouble(dt.Rows[0]["Tax"].ToString());
                            Double GSTAMT = Convert.ToDouble(dt.Rows[0]["GSTAMT"].ToString());

                            findrow["batchid"] = dt.Rows[0]["batchid"].ToString();
                            findrow["MaxQty"] = dt.Rows[0]["MaxQty"].ToString();
                            findrow["Qty"] = Qty;
                            findrow["BatchQty"] = dt.Rows[0]["Qty"].ToString();
                            findrow["BVAmt"] = dt.Rows[0]["BVAmt"].ToString();
                            findrow["BatchNo"] = dt.Rows[0]["BatchNo"].ToString();
                            findrow["DPWithTax"] = dt.Rows[0]["DPWithTax"].ToString();
                            findrow["tax"] = Tax;
                            findrow["GSTAMT"] = GSTAMT;
                            findrow["DPAmt"] = Math.Round(DPAmt, 4);


                            findrow["Totaltaxamt"] = DPAmt;
                            findrow["Gross"] = Math.Round(DPAmt, 2);
                            findrow["TaxableAmt"] = Math.Round(DPAmt, 2);
                            findrow["totalamt"] = Math.Round((DPAmt + GSTAMT), 2);

                            HttpContext.Current.Session["ReturnCart"] = Cartdt;

                            Calculater(Sno);
                        }
                        else
                        {
                            Result = "Batch " + dt.Rows[0]["BatchNo"].ToString() + " Available Stock is: " + dt.Rows[0]["Qty"].ToString();
                        }
                    }
                    else
                    {
                        Result = dt.Rows[0]["Error"].ToString();
                    }
                }
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }





    [WebMethod]
    public static string UpdateQty(int Sno, int Qty, string Userid)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["ReturnCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Sno='" + Sno + "'").FirstOrDefault();
                int Pid = findrow == null ? 0 : findrow.Field<int>("Pid");
                if (Qty <= 0)
                    DeleteRecord(Sno);


                int BatchQty = findrow == null ? 0 : findrow.Field<int>("BatchQty");
                int MaxQty = findrow == null ? 0 : findrow.Field<int>("MaxQty");

                if (Qty > MaxQty)
                    Qty = MaxQty;

                if (Qty > BatchQty)
                {
                    /*Add multiple Rows*/

                    int BalQty = (Qty - BatchQty);
                    findrow["qty"] = BatchQty.ToString();
                    HttpContext.Current.Session["ReturnCart"] = Cartdt;
                    Calculater(Sno);

                    int AddedQty = AddRow(Pid.ToString(), GetBatchList(Pid.ToString()), BalQty, Userid);

                    //while (BalQty > 0)
                    //{
                    //    int AddedQty = AddRow(Pid.ToString(), GetBatchList(Pid), BalQty, Userid);
                    //    BalQty = BalQty - AddedQty;
                    //    if (AddedQty == 0)
                    //        BalQty = 0;
                    //}
                }
                else
                {
                    findrow["qty"] = Qty.ToString();
                    HttpContext.Current.Session["ReturnCart"] = Cartdt;
                    Calculater(Sno);
                }

            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    private static string GetBatchList(string Pid)
    {
        string BatchList = "";
        DataTable dt = (DataTable)HttpContext.Current.Session["ReturnCart"];
        foreach (DataRow dr in dt.Rows)
        {
            if (dr["Pid"].ToString() == Pid.ToString())
                BatchList += dr["batchid"].ToString() + ",";
        }
        return BatchList;
    }

    private static void Calculater(int Sno)
    {
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["ReturnCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Sno='" + Sno + "'").FirstOrDefault();
                int Qty = findrow == null ? 0 : findrow.Field<int>("qty");
                double tax = findrow == null ? 0 : findrow.Field<double>("tax");
                double DPAmt = findrow == null ? 0 : findrow.Field<double>("DPAmt");
                double BV = findrow == null ? 0 : findrow.Field<double>("BVAmt");
                double FPV = findrow == null ? 0 : findrow.Field<double>("FPV");
                double Discount = findrow == null ? 0 : findrow.Field<double>("Discount");
                string DiscounType = findrow == null ? "%" : findrow.Field<string>("DiscounType");
                double Weight = findrow == null ? 0 : findrow.Field<double>("Weight");
                double GSTAMT = 0, Gross = 0;

                if (DiscounType == "%")
                {
                    Gross = (DPAmt * Qty);
                    findrow["Gross"] = Math.Round(Gross, 2);

                    Gross = (Gross - (Gross * Discount / 100));

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
                    Gross = (Gross - Discount);
                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 2, MidpointRounding.ToEven);
                    GSTAMT = GSTAMT + Math.Round((Gross * (tax / 2) / 100), 2, MidpointRounding.ToEven);
                    findrow["GSTAMT"] = Math.Round(GSTAMT * Qty, 2);

                    findrow["TaxableAmt"] = Math.Round(Gross, 2);
                    findrow["totalamt"] = Math.Round(Gross + GSTAMT, 2);
                    findrow["Totaltaxamt"] = Math.Round(GSTAMT, 2);
                }

                findrow["TotalWeight"] = (Weight * Qty);

                findrow["totalbvamt"] = Qty * (Discount == 0 ? BV : 0);
                findrow["TotalFPV"] = Qty * (Discount == 0 ? FPV : 0);


                HttpContext.Current.Session["ReturnCart"] = Cartdt;
            }
        }
        catch (Exception er) { }
    }



    [WebMethod]
    public static string UpdateDiscount(int Sno, double Discount, string DiscounType)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["ReturnCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Sno='" + Sno + "'").FirstOrDefault();
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
                HttpContext.Current.Session["ReturnCart"] = Cartdt;
                Calculater(Sno);
            }

        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }




    [WebMethod]
    public static string DeleteProd(int Sno)
    {
        String Result = "";
        try
        {
            DeleteRecord(Sno);
            Calculater(Sno);
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    private static string DeleteRecord(int Sno)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["ReturnCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Sno='" + Sno + "'").FirstOrDefault();
                Cartdt = (DataTable)HttpContext.Current.Session["ReturnCart"];
                findrow.Delete();
                HttpContext.Current.Session["ReturnCart"] = Cartdt;
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    [WebMethod]
    public static ProdDetails[] GetCartData()
    {
        List<ProdDetails> details = new List<ProdDetails>();
        if (HttpContext.Current.Session["ReturnCart"] != null)
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["ReturnCart"];


            DataView view = Cartdt.DefaultView;
            view.Sort = "Sno Desc";
            DataTable dt_Sorted = view.ToTable();

            foreach (DataRow dr in dt_Sorted.Rows)
            {
                ProdDetails data = new ProdDetails();
                data.Sno = Convert.ToInt32(dr["Sno"].ToString().Trim());
                data.Pid = Convert.ToInt32(dr["pid"].ToString().Trim());
                data.batchid = Convert.ToInt32(dr["batchid"].ToString().Trim());
                data.DiscounType = dr["DiscounType"].ToString();
                data.pname = dr["pname"].ToString();
                data.Pcode = dr["Pcode"].ToString();
                data.hsncode = dr["hsncode"].ToString();
                data.Batch = dr["Batch"].ToString();

                data.qty = Convert.ToInt32(dr["qty"].ToString());
                data.MaxQty = Convert.ToInt32(dr["MaxQty"].ToString());

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
                data.TotalWeight = Convert.ToDouble(dr["TotalWeight"].ToString());
                details.Add(data);

            }

        }
        return details.ToArray();
    }

    [WebMethod]
    public static UserDetails GetUser(string regno)
    {
        UserDetails objUser = new UserDetails();
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("GetFranchiseDetails", con);
            SqlDataReader dr;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", regno.Trim());
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
                objUser.Mobile = dr["AppMstMobile"].ToString();
                objUser.distt = dr["distt"].ToString();
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
        SqlParameter[] sqlparam = new SqlParameter[] { };
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

    public void BindUserProduct(string FromId)
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Userid", FromId) };

        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetReturnProduct_Billing");
        foreach (DataRow dr in dt.Rows)
        {
            divProductcode.InnerText += dr["productCode"].ToString() + "= " + dr["ProductName"].ToString() + " (" + dr["PackSize"].ToString() + ") Qty: " + dr["Qty"].ToString() + ",";
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
            //String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 30 min ";
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
    public static string ResetCart()
    {
        HttpContext.Current.Session["ReturnCart"] = null;
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
        dtStuc.Columns.Add(new DataColumn("Batch", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("Discount", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("qty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("batchid", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("BatchNo", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("BatchQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("MaxQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("DPAmt", typeof(double)));


        dtStuc.Columns.Add(new DataColumn("DPWithTax", typeof(double)));
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

        HttpContext.Current.Session["ReturnCart"] = dtStuc;
    }

    #endregion


    #region ClassProperty

    public class ProdDetails
    {
        public int Sno { get; set; }
        public int Pid { get; set; }
        public String pname { get; set; }
        public String hsncode { get; set; }
        public String Batch { get; set; }
        public String Pcode { get; set; }
        public int qty { get; set; }
        public int batchid { get; set; }
        public String BatchNo { get; set; }
        public int BatchQty { get; set; }
        public int MaxQty { get; set; }
        public String DiscounType { get; set; }
        public double Discount { get; set; }
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
    }

    #endregion



    protected void txt_FromId_TextChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txt_FromId.Text))
        {
            BindUserProduct(txt_FromId.Text);
        }
        else
        {
            divProductcode.InnerText = "";
        }
    }
}




