using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
public partial class user_welcome : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("Logout.aspx");
        else
        {
            if (!IsPostBack)
            {
                BindData();


                DateTime now = DateTime.Now;
                var startDate = new DateTime(now.Year, now.Month, 1);

                txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");
                BindDashboard();
                BindNew();
                HttpContext.Current.Session["POCart"] = null;
            }
        }
    }


    private void BindData()
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[]
        {  new SqlParameter("@franchiseid",  Session["franchiseid"].ToString()) };
        DataTable dt = objDu.GetDataTable(param1, @"select TC_Accept=isnull(TC_Accept,0), FranType, OpeningAmount=isnull(OpeningAmount,0) 
        from FranchiseMst where FranchiseId=@franchiseid");
        if (dt.Rows.Count > 0)
        {
            //top Circle
            if (dt.Rows[0]["TC_Accept"].ToString() == "0" && dt.Rows[0]["FranType"].ToString() == "4" && Convert.ToDecimal(dt.Rows[0]["OpeningAmount"]) >= 2000000)
            {
                Response.Redirect("terms-and-condition.aspx");
            }
            else if (dt.Rows[0]["TC_Accept"].ToString() == "0" && dt.Rows[0]["FranType"].ToString() == "5" && Convert.ToDecimal(dt.Rows[0]["OpeningAmount"]) >= 500000) //top Point
            {
                Response.Redirect("terms-and-condition.aspx");
            }
        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        BindDashboard();
    }


    private void BindDashboard()
    {
        String fromDate = "", toDate = "";
        try
        {

            if (txtFromDate.Text.Trim().Length > 0)
            {
                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
            if (txtToDate.Text.Trim().Length > 0)
            {
                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
        }
        catch
        {
            utility.MessageBox(this, "Invalid date entry.!!");
            return;
        }

        SqlParameter[] param = new SqlParameter[] {
            new SqlParameter("@Franchiseid", Session["franchiseid"].ToString()),
            new SqlParameter("@From", fromDate),
            new SqlParameter("@To", toDate)
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetFranchiseDashboardData");
        if (dt.Rows.Count > 0)
        {
            lbl_Purchases_Curr.InnerText = common.RS_Formate(dt.Rows[0]["Purchases_Curr"].ToString());
            lbl_Purchases_Prev.InnerText = common.RS_Formate(dt.Rows[0]["Purchases_Prev"].ToString());

           // lbl_FranchiseSales.InnerText = common.RS_Formate(dt.Rows[0]["FranchiseSales"].ToString());
            //lbl_AssociateSales.InnerText = common.RS_Formate(dt.Rows[0]["TotalInvoiceSales"].ToString());
            lbl_TotalSales.InnerText = "Sales: " + common.RS_Formate((Math.Round(Convert.ToDecimal(dt.Rows[0]["FranchiseSales"]) + Convert.ToDecimal(dt.Rows[0]["TotalInvoiceSales"]), 2)).ToString());

            lbl_StockMNT.InnerText = common.RS_Formate(dt.Rows[0]["MinStkAmt"].ToString());
            lbl_StockValue.InnerText = common.RS_Formate(dt.Rows[0]["StockValue"].ToString());
            if (Convert.ToDecimal(dt.Rows[0]["StockValue"].ToString()) > Convert.ToDecimal(dt.Rows[0]["MinStkAmt"].ToString()))
                lbl_StockRefile.InnerText = "0";
            else
                lbl_StockRefile.InnerText = common.RS_Formate(Math.Round(( Convert.ToDecimal(dt.Rows[0]["MinStkAmt"].ToString()) - Convert.ToDecimal(dt.Rows[0]["StockValue"].ToString())), 2).ToString());

            lbl_RPVValue.InnerText = common.CurrencyFormate(Math.Round(Convert.ToDecimal(dt.Rows[0]["RPVValue"]), 0).ToString());
            //lbl_TPVValue.InnerText = common.CurrencyFormate(Math.Round(Convert.ToDecimal(dt.Rows[0]["TPVValue"]), 0).ToString());
            //lbl_APV.InnerText = dt.Rows[0]["APV"].ToString();
            // lbl_FPV.InnerText = dt.Rows[0]["FPV"].ToString();
        }
    }


    [WebMethod]
    public static ProdDetails[] GetCartData()
    {
        List<ProdDetails> details = new List<ProdDetails>();
        DataTable Cartdt = null;
        if (HttpContext.Current.Session["POCart"] == null)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@FranchiseId", HttpContext.Current.Session["franchiseid"].ToString()),
            };
            DataUtility objDu = new DataUtility();
            Cartdt = objDu.GetDataTableSP(param, "GetTopSelling");
            HttpContext.Current.Session["POCart"] = Cartdt;
        }
        else
        {
            Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
        }

        foreach (DataRow dr in Cartdt.Rows)
        {
            ProdDetails data = new ProdDetails();
            data.Pid = Convert.ToInt32(dr["Pid"].ToString());
            data.ProductName = dr["ProductName"].ToString();
            data.AssoSalesQty = Convert.ToInt32(dr["AssoSalesQty"].ToString());
            data.FranSalesQty = Convert.ToInt32(dr["FranSalesQty"].ToString());
            data.TotalSalesQty = Convert.ToInt32(dr["TotalSalesQty"].ToString());
            data.ClosingStock = Convert.ToInt32(dr["ClosingStock"].ToString());
            data.Requirement = Convert.ToInt32(dr["Requirement"].ToString());
            details.Add(data);
        }
        return details.ToArray();
    }


    [WebMethod]
    public static string UpdateQty(int Pid, int Qty)
    {
        String Result = "";
        try
        {
            if (Qty < 0)
                Qty = 0;

            DataTable Cartdt = (DataTable)HttpContext.Current.Session["POCart"];
            if (Cartdt.Rows.Count > 0)
            {
                DataRow findrow = Cartdt.Select("Pid='" + Pid + "'").FirstOrDefault();
                int Requirement = findrow == null ? 0 : findrow.Field<int>("Requirement");
                findrow["Requirement"] = Qty.ToString();
                HttpContext.Current.Session["POCart"] = Cartdt;

            }
        }
        catch (Exception er) { Result = er.Message.ToString(); }
        return Result;
    }


    private void BindNew()
    {
        try
        {
            string Str = "";

            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MstKsy", "DASHBOARD") };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "GetFNews");
            foreach (DataRow dr in dt.Rows)
            {
                Str += "<div class='col-md-10 col-xs-12'>";
                Str += "<a href='javascript:void(0)' class='text-body'> <h5><strong class='mr-2'><span style='font-weight: bold;'>" + dr["NewsMstTitle"].ToString() + "</span></strong></h5></a>";
                Str += "<p> <span>" + dr["newsmstdiscription"].ToString() + " </p>";
                Str += "</div>";
                div_newdisplay.Visible = true;
            }
            div_NewsId.InnerHtml = Str;
        }
        catch { }
    }


    [WebMethod]
    public static TansitItem[] BindTransitItem()
    {
        List<TansitItem> details = new List<TansitItem>();

        DataUtility objDu = new DataUtility();
        SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@FranchiseId", HttpContext.Current.Session["franchiseid"].ToString()),
        };
        DataTable dt = objDu.GetDataTable(param, @"Select srno, Doe=convert(varchar(20),doe, 106), InvoiceNo, 
        Amount, DispatchDate=convert(varchar(20),DispatchDate, 106), DispatchFileName, DeliveryRemark, DeliveryDate=convert(varchar(20),DeliveryDate, 103) 
        from StockTranReport where DeliveryStatus=7 and SoldTo=@FranchiseId and 
        Cast(DATEADD(month, 1, DispatchDate) as date) < Cast(Getdate() as date) ");
        foreach (DataRow dr in dt.Rows)
        {
            TansitItem data = new TansitItem();
            data.srno = Convert.ToInt32(dr["srno"].ToString());
            data.Doe = dr["Doe"].ToString();
            data.InvoiceNo =  dr["InvoiceNo"].ToString();
            data.Amount = dr["Amount"].ToString();
            data.DispatchDate = dr["DispatchDate"].ToString();
            data.DispatchFileName = dr["DispatchFileName"].ToString();
            data.DeliveryRemark = dr["DeliveryRemark"].ToString();
            data.DeliveryDate = dr["DeliveryDate"].ToString(); 
            details.Add(data);
        }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static string Deliver_Inv(string srno)
    {
        string Result = "";
        try
        { 
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@srno", srno) 
            };

            objDu.ExecuteSql(param, @"Update StockTranReport Set DeliveryStatus=1, DeliveryDate=getdate() Where Srno=@Srno");
            Result = "1";
        }
        catch (Exception er) { }
        return Result;
    }


    public class TansitItem
    {
        public int srno { get; set; }
        public String Doe { get; set; }
        public String InvoiceNo { get; set; }
        public String Amount { get; set; }
        public String DispatchDate { get; set; }
        public String DispatchFileName { get; set; }
        public String DeliveryRemark { get; set; }
        public String DeliveryDate { get; set; } 
    }


    public class ProdDetails
    {
        public int Pid { get; set; }
        public String ProductName { get; set; }
        public int AssoSalesQty { get; set; }
        public int FranSalesQty { get; set; }
        public int TotalSalesQty { get; set; }
        public int ClosingStock { get; set; }
        public int Requirement { get; set; }
    }

    private static void CreateStucture()
    {
        DataTable dtStuc = new DataTable();
        dtStuc.Columns.Add(new DataColumn("Sno", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("Pid", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("ProductName", typeof(string)));
        dtStuc.Columns.Add(new DataColumn("AssoSalesQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("FranSalesQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("TotalSalesQty", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("ClosingStock", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("Requirement", typeof(int)));
        HttpContext.Current.Session["POCart"] = dtStuc;
    }
}
