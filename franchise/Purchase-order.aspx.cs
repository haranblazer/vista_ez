using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.Xml.Linq;
using System.Xml;

public partial class secretadmin_Purchase_order : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if (Session["franchiseid"] == null)
                    Response.Redirect("Logout.aspx");

                txtbilldate.Text = DateTime.Now.Date.ToString("dd-MM-yyyy");
                Bind_Vendor();
                Bind_State();
                Bind_PaymentTerms();
                BindUserProduct();
                // HttpContext.Current.Session["FranStock"] = null;
            }
            catch (Exception er) { }
        }
    }


    #region Genearate PO
    [WebMethod]
    public static Results GenerateInv(string VendorId, string DeliverTo, string SourceOfSupply, string DestinationOfSupply, string Reference, string BillDate, string DeliveryDate,
    string PaymentTerm, string TC, string Note, string DiscountVal, string DisType, string Adjustment)
    {

        Results objResult = new Results();
        
        if (HttpContext.Current.Session["franchiseid"] == null)
        {
            objResult.Error = "-1";
            return objResult;
        }
        if (VendorId == "0")
        {
            objResult.Error = "Please Select Vender Id.!!";
            return objResult;
        }
        XElement element = null;
        try
        {
            String BillDate_New = "", DeliveryDate_New = "";
            try
            {
                if (BillDate.Length > 0)
                {
                    String[] Date = BillDate.Split(new String[] { "-" }, StringSplitOptions.RemoveEmptyEntries);
                    BillDate_New = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
                if (DeliveryDate.Length > 0)
                {
                    String[] Date = DeliveryDate.Split(new String[] { "-" }, StringSplitOptions.RemoveEmptyEntries);
                    DeliveryDate_New = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
            }
            catch
            {
                objResult.Error = "Invalid date entry.";
                return objResult;
            }
           
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranStock"];
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
                        if (SourceOfSupply == DestinationOfSupply)
                        {
                            CGST = Convert.ToDouble(row["tax"].ToString()) / 2;
                            CGSTRS = Convert.ToDouble(row["GSTAMT"].ToString()) / 2;
                            SGST = Convert.ToDouble(row["tax"].ToString()) / 2;
                            SGSTRS = Convert.ToDouble(row["GSTAMT"].ToString()) / 2;
                        }
                        else
                        {
                            IGST = Convert.ToDouble(row["tax"].ToString());
                            IGSTRS = Convert.ToDouble(row["GSTAMT"].ToString());
                        }

                        XElement prdXml = new XElement("P",
                            new XElement("pname", row["pname"].ToString()),
                            new XElement("cd", row["Pid"].ToString()),
                             new XElement("pcode", row["Pcode"].ToString()),
                            new XElement("hsncode", row["hsncode"].ToString()),
                            new XElement("Qnt", row["qty"].ToString()),
                            new XElement("TAX", row["tax"].ToString()),
                            new XElement("TAXRS", row["GSTAMT"].ToString()),
                            new XElement("Price", row["Price"].ToString()),
                            new XElement("Gross", row["Gross"].ToString()),
                            new XElement("total", row["totalamt"].ToString()),
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

                    object TotalQnty, totalamt, GrossAmt, TotalTax, NetAmt, Discount=0;
                    TotalQnty = Cartdt.Compute("Sum(qty)", "");
                    TotalTax = Cartdt.Compute("Sum(GSTAMT)", "");

                    GrossAmt = Cartdt.Compute("Sum(Gross)", "");
                    totalamt = Cartdt.Compute("Sum(totalamt)", "");
                    if (DisType == "%")
                        Discount = (Convert.ToDouble(totalamt) * Convert.ToDouble(DiscountVal) / 100).ToString();
                    else
                        Discount = DiscountVal;

                    NetAmt = (Convert.ToDouble(totalamt) - Convert.ToDouble(Discount));


                    SqlConnection con = new SqlConnection(method.str);
                    SqlCommand com = new SqlCommand("Fran_PO", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@VendorId", VendorId);
                    com.Parameters.AddWithValue("@SessionId", HttpContext.Current.Session["franchiseid"].ToString());
                    com.Parameters.AddWithValue("@DeliverTo", HttpContext.Current.Session["franchiseid"].ToString());
                    com.Parameters.AddWithValue("@SourceOfSupply", SourceOfSupply);
                    com.Parameters.AddWithValue("@DestinationOfSupply", DestinationOfSupply);
                    com.Parameters.AddWithValue("@Reference", Reference);
                    com.Parameters.AddWithValue("@BillDate", BillDate_New);
                    com.Parameters.AddWithValue("@DeliveryDate", DeliveryDate_New);
                    com.Parameters.AddWithValue("@PaymentTerm", PaymentTerm);
                    com.Parameters.AddWithValue("@TC", TC);
                    com.Parameters.AddWithValue("@Note", Note);
                    com.Parameters.AddWithValue("@TotalTax", TotalTax);
                    com.Parameters.AddWithValue("@Discount", Math.Round(Convert.ToDouble(Discount), 2));
                    com.Parameters.AddWithValue("@DisType", DisType);
                    com.Parameters.AddWithValue("@DiscountVal", DiscountVal);
                    com.Parameters.AddWithValue("@Adjustment", Adjustment);
                    com.Parameters.AddWithValue("@gross", Math.Round(Convert.ToDouble(GrossAmt), 2));
                    com.Parameters.AddWithValue("@NetAmt", Math.Round(Convert.ToDouble(NetAmt), 2));
                    com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
                    com.Parameters.AddWithValue("@ImgFile", "");
                    com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    string status = com.Parameters["@flag"].Value.ToString();
                    string invoiceNo = com.Parameters["@InvNo"].Value.ToString();
                    if (status == "1")
                    {
                        HttpContext.Current.Session["FranStock"] = null;

                        utility obj = new utility();
                        objResult.InvoiceNo = obj.base64Encode(invoiceNo);
 
                        //objResult.InvoiceNo = invoiceNo;
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



    #region Selector

    private void Bind_Vendor()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MasterKey", "GET-VENDOR-LIST") };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetMasterList");
        if (dt.Rows.Count > 0)
        {
            ddl_Vendor.DataSource = dt;
            ddl_Vendor.DataTextField = "DisplayName";
            ddl_Vendor.DataValueField = "VID";
            ddl_Vendor.DataBind();
            ddl_Vendor.Items.Insert(0, new ListItem("Select a vendor", "0"));
        }
        else
        {
            ddl_Vendor.Items.Clear();
            ddl_Vendor.Items.Insert(0, new ListItem("Select", "0"));
        }
    }


    private void Bind_State()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MasterKey", "GET-STATE-LIST") };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetMasterList");
        if (dt.Rows.Count > 0)
        {
            ddl_SourceOfSupply.DataSource = dt;
            ddl_SourceOfSupply.DataTextField = "Statename";
            ddl_SourceOfSupply.DataValueField = "StateCode";
            ddl_SourceOfSupply.DataBind();
            ddl_SourceOfSupply.Items.Insert(0, new ListItem("Select", "0"));

            ddl_DestinationOfSupply.DataSource = dt;
            ddl_DestinationOfSupply.DataTextField = "Statename";
            ddl_DestinationOfSupply.DataValueField = "StateCode";
            ddl_DestinationOfSupply.DataBind();
            ddl_DestinationOfSupply.Items.Insert(0, new ListItem("Select", "0"));
        }
        else
        {
            ddl_SourceOfSupply.Items.Clear();
            ddl_SourceOfSupply.Items.Insert(0, new ListItem("Select", "0"));

            ddl_DestinationOfSupply.Items.Clear();
            ddl_DestinationOfSupply.Items.Insert(0, new ListItem("Select", "0"));
        }
    }


    private void Bind_PaymentTerms()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MasterKey", "GET-PAYMENT-TERMS") };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetMasterList");
        if (dt.Rows.Count > 0)
        {
            ddl_PaymentTerm.DataSource = dt;
            ddl_PaymentTerm.DataTextField = "Pname";
            ddl_PaymentTerm.DataValueField = "PayId";
            ddl_PaymentTerm.DataBind();
            ddl_PaymentTerm.SelectedValue = "7";
        }
        else
        {
            ddl_PaymentTerm.Items.Clear();
            ddl_PaymentTerm.Items.Insert(0, new ListItem("Select", "0"));
        }
    }

    [WebMethod]
    public static VenderProp GetVenderDetail(string Vid)
    {
        SqlParameter[] param = new SqlParameter[] {
             new SqlParameter("@MasterKey","GET-VENDER-DETAIL"),
            new SqlParameter("@VID", Vid),
            new SqlParameter("@Franchiseid", HttpContext.Current.Session["franchiseid"].ToString())
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetVendorLsit");
        VenderProp obj = new VenderProp();
        foreach (DataRow row in dt.Rows)
        {
            if (HttpContext.Current.Session["franchiseid"] == null)
            {
                obj.Error = "Session logout. Please try agian.";
                return obj;
            }
            else
            {
                obj.Error = "";
            }

            obj.ComName = row["ComName"].ToString();
            obj.DisplayName = row["DisplayName"].ToString();
            obj.Currency = row["Currency"].ToString();
            obj.B_Address = row["B_Address"].ToString();
            obj.B_State = row["B_State"].ToString();
            obj.B_City = row["B_City"].ToString();
            obj.B_ZipCode = row["B_ZipCode"].ToString();
            obj.CountryName = row["CountryName"].ToString();
            obj.Source_Supply = row["Source_Supply"].ToString();
            obj.GSTNAME = row["GSTNAME"].ToString();
            obj.GSTIN = row["GSTIN"].ToString();
            obj.PurchaseOrder = row["PurchaseOrder"].ToString();
            obj.V_regno = row["V_regno"].ToString();
            obj.Org_State = row["Org_State"].ToString();
            obj.Org_Add = row["Org_Add"].ToString();

        }

        return obj;
    }
    #endregion




    [WebMethod]
    public static string GetBarcode(string Pid)
    {
        String[] strProduct = Pid.Split(new String[] { "=" }, StringSplitOptions.RemoveEmptyEntries);
        try
        {
            if (strProduct[0] != null)
                Pid = strProduct[0];
        }
        catch { }

        //Pid = Pid.Trim();
        String Result = "";

        if (HttpContext.Current.Session["franchiseid"] == null)
        {
            return "Session logout. Please try agian.";
        }

        try
        {
            if (HttpContext.Current.Session["FranStock"] == null)
                CreateStucture();

            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {
                new SqlParameter("@Pid",Pid)
            };

            DataTable DTNew = objDu.GetDataTable(param1, "Select Top 1 ProductId from ShopProductMst where (productName=@Pid or productCode=@Pid)");
            if (DTNew.Rows.Count > 0)
                Pid = DTNew.Rows[0]["ProductId"].ToString();


            utility obju = new utility();
            if (obju.IsNumeric(Pid) == true)
            {
                DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranStock"];
                if (Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault() == null)
                {
                    SqlParameter[] param = new SqlParameter[]
                    {
                        new SqlParameter("@Pid",Pid)
                    };

                    DataTable dt = objDu.GetDataTableSP(param, "Get_Prod_Detail");
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Rows[0]["Error"].ToString() == "0")
                        {
                            Double Price = Math.Round(Convert.ToDouble(dt.Rows[0]["Price"].ToString()), 2);
                            Double Tax = Convert.ToDouble(dt.Rows[0]["Tax"].ToString());
                            DataRow dr = Cartdt.NewRow();
                            dr["pid"] = dt.Rows[0]["pid"].ToString(); 
                             dr["pname"] = dt.Rows[0]["pname"].ToString();
                            dr["Pcode"] = dt.Rows[0]["Pcode"].ToString();
                            dr["hsncode"] = dt.Rows[0]["HSNCode"].ToString();
                            dr["qty"] = 1;
                            dr["tax"] = Tax;
                            dr["GSTAMT"] = (Price * Tax / 100);
                            dr["Price"] = Price;
                            dr["Gross"] = Price;
                            dr["totalamt"] = Price + (Price * Tax / 100);
                            Cartdt.Rows.Add(dr);
                            HttpContext.Current.Session["FranStock"] = Cartdt;
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
                Result = "This Item: " + Pid + " not found.!!";
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }



    [WebMethod]
    public static string UpdateGST(int Pid, int GST)
    {
        String Result = "";
        DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranStock"];
        if (Cartdt.Rows.Count > 0)
        {
            DataRow findrow = Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault();
            int Qty = findrow == null ? 0 : findrow.Field<int>("Qty");
            double tax = findrow == null ? 0 : findrow.Field<double>("tax");
            findrow["tax"] = GST;
            HttpContext.Current.Session["FranStock"] = Cartdt;
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
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranStock"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault();
                
                findrow["qty"] = Qty.ToString();

                HttpContext.Current.Session["FranStock"] = Cartdt;
            }
            Calculator(Pid);
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }

    [WebMethod]
    public static string UpdateRate(int Pid, double Rate)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranStock"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault();
                findrow["Price"] = Rate.ToString();
                HttpContext.Current.Session["FranStock"] = Cartdt;
            }
            Calculator(Pid);
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    private static void Calculator(int Pid)
    {
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranStock"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault();
               
                double Gross = 0, GSTAMT = 0;
                double tax = findrow == null ? 0 : findrow.Field<double>("tax");
                double Price = findrow == null ? 0 : findrow.Field<double>("Price");
                int Qty = findrow == null ? 0 : findrow.Field<int>("qty");

                if (Qty <= 0)
                {
                    findrow.Delete();
                }
                else
                {
                    Gross = (Price * Qty);
                    findrow["Gross"] = Math.Round(Gross, 2);
                    GSTAMT = Math.Round((Gross * tax / 100), 2);
                    findrow["GSTAMT"] = Math.Round(GSTAMT, 2);
                    findrow["totalamt"] = Math.Round((Gross + GSTAMT), 2);
                }
                HttpContext.Current.Session["FranStock"] = Cartdt;
            }
        }
        catch (Exception er) {}
        
    }


    [WebMethod]
    public static string DeleteProd(int Pid)
    {
        String Result = "";
        try
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranStock"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault();
                Cartdt = (DataTable)HttpContext.Current.Session["FranStock"];
                findrow.Delete();
                HttpContext.Current.Session["FranStock"] = Cartdt;
            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }

    [WebMethod]
    public static ProdDetails[] GetCartData()
    {
        List<ProdDetails> details = new List<ProdDetails>();
        if (HttpContext.Current.Session["FranStock"] != null)
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["FranStock"];

            foreach (DataRow dr in Cartdt.Rows)
            {
                ProdDetails data = new ProdDetails();
                data.Pid = Convert.ToInt32(dr["pid"].ToString().Trim());
                data.Pcode = dr["Pcode"].ToString();
                data.pname = dr["pname"].ToString();
                data.hsncode = dr["hsncode"].ToString();
                data.qty = Convert.ToInt32(dr["qty"].ToString());
                data.tax = Convert.ToDouble(dr["tax"].ToString());
                data.GSTAMT = Convert.ToDouble(dr["GSTAMT"].ToString());

                data.Price = Convert.ToDouble(dr["Price"].ToString());
                data.Gross = Convert.ToDouble(dr["Gross"].ToString());
                data.totalamt = Convert.ToDouble(dr["totalamt"].ToString());

                details.Add(data);
            }


        }
        return details.ToArray();
    }


    public void BindUserProduct()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@PackType", "0") };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetShopProduct_Billing");
        foreach (DataRow dr in dt.Rows)
        {
            divProductcode.InnerText += dr["productCode"].ToString() + "= " + dr["ProductName"].ToString() + " (" + dr["PackSize"].ToString() + "),";
        }

        //DataUtility objDu = new DataUtility();
        //SqlParameter[] param = new SqlParameter[] {};
        //DataTable dt = objDu.GetDataTable(param, "select productcode, ProductName from shopproductmst where isDeleted = 0");
        //foreach (DataRow dr in dt.Rows)
        //{
        //    divProductcode.InnerText += dr["productcode"].ToString() + "," + dr["ProductName"].ToString() + ",";
        //}
    }



    #region Stucture

    private static void CreateStucture()
    {
        DataTable dtStuc = new DataTable();
        dtStuc.Columns.Add(new DataColumn("Pid", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("Pcode", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("pname", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("hsncode", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("qty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("tax", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("GSTAMT", typeof(double)));

        dtStuc.Columns.Add(new DataColumn("Price", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("Gross", typeof(double)));
        dtStuc.Columns.Add(new DataColumn("totalamt", typeof(double)));

        HttpContext.Current.Session["FranStock"] = dtStuc;
    }

    #endregion


    #region ClassProperty

    public class ProdDetails
    {
        
        public int Pid { get; set; }
        public String Pcode { get; set; }
        public String pname { get; set; }
        public String hsncode { get; set; }
        public int qty { get; set; }
        public double tax { get; set; }
        public double GSTAMT { get; set; }
        public double Price { get; set; }
        public double Gross { get; set; }
        public double totalamt { get; set; }
    }

    public class Results
    {
        public String Error { get; set; }
        public String InvoiceNo { get; set; }
        public String status { get; set; }
    }


    public class VenderProp
    {
        public string Error { get; set; }
        public string ComName { get; set; }
        public string DisplayName { get; set; }
        public string Currency { get; set; }
        public string B_Address { get; set; }
        public string B_State { get; set; }
        public string B_City { get; set; }
        public string B_ZipCode { get; set; }
        public string CountryName { get; set; }
        public string GSTNAME { get; set; }
        public string GSTIN { get; set; }
        public string PurchaseOrder { get; set; }
        public string Source_Supply { get; set; }
        public string V_regno { get; set;}
        public string Org_State { get; set; }
        public string Org_Add { get; set; }

    }

    #endregion


}


