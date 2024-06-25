using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;

public partial class secretadmin_Services : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    #region HeaderData


    [System.Web.Services.WebMethod]
    public static Chart_data_Comparison[] Get_ComparisonChart(string mstkey, string Type, string SalesType, string Top)
    {
        List<Chart_data_Comparison> details = new List<Chart_data_Comparison>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@mstkey", mstkey),
                new SqlParameter("@Top", Top),
                new SqlParameter("@Type", Type),
                new SqlParameter("@SalesType", SalesType)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_ComparisonChart");
            while (dr.Read())
            {
                Chart_data_Comparison data = new Chart_data_Comparison();
                data.CateWise = dr["CateWise"].ToString();
                data.M1 = Convert.ToDecimal(dr["M1"].ToString());
                data.M2 = Convert.ToDecimal(dr["M2"].ToString());
                data.M3 = Convert.ToDecimal(dr["M3"].ToString());

                data.Month1 = dr["Month1"].ToString();
                data.Month2 = dr["Month2"].ToString();
                data.Month3 = dr["Month3"].ToString();

                details.Add(data);
            }


        }
        catch (Exception er) { }
        return details.ToArray();
    }




    [System.Web.Services.WebMethod]
    public static Chart_data[] Get_Chart_Data_Admin_Fran_Wise(string mstkey, string FromDate, string ToDate, string Top, string Type, string SalesType)
    {
        List<Chart_data> details = new List<Chart_data>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@mstkey", mstkey),
                new SqlParameter("@FromDate", FromDate),
                new SqlParameter("@ToDate", ToDate),
                new SqlParameter("@Top", Top),
                new SqlParameter("@Type", Type),
                new SqlParameter("@SalesType", SalesType)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_Chart_Data");
            while (dr.Read())
            {
                Chart_data data = new Chart_data();
                data.Val = Convert.ToDecimal(dr["Val"].ToString());
                data.Perc = Convert.ToDecimal(dr["Perc"].ToString());
                data.ProductName = dr["ProductName"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static Chart_data[] Get_Chart_Data_Admin_State_Wise(string mstkey, string FromDate, string ToDate, string Top, string Type, string SalesType)
    {
        List<Chart_data> details = new List<Chart_data>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@mstkey", mstkey),
                new SqlParameter("@FromDate", FromDate),
                new SqlParameter("@ToDate", ToDate),
                new SqlParameter("@Top", Top),
                new SqlParameter("@Type", Type),
                new SqlParameter("@SalesType", SalesType)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_Chart_Data");
            while (dr.Read())
            {
                Chart_data data = new Chart_data();
                data.Val = Convert.ToDecimal(dr["Val"].ToString());
                data.Perc = Convert.ToDecimal(dr["Perc"].ToString());
                data.ProductName = dr["ProductName"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static ArrayList GetCategory()
    {
        ArrayList list = new ArrayList();
        try
        {
            DataUtility objDUT = new DataUtility();
            SqlDataReader dr = objDUT.GetDataReader("Select CatId, CatName from CategoryMst Where isDeleted=0");
            while (dr.Read())
            {
                list.Add(new ListItem(dr["CatName"].ToString(), dr["CatId"].ToString()));
            }
        }
        catch (Exception er) { }
        return list;
    }


    [System.Web.Services.WebMethod]
    public static Chart_data[] Get_Chart_Data_Report_Admin(string mstkey, string FromDate, string ToDate, string Top, string Type, string CatId)
    {
        List<Chart_data> details = new List<Chart_data>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@mstkey", mstkey),
                new SqlParameter("@FromDate", FromDate),
                new SqlParameter("@ToDate", ToDate),
                new SqlParameter("@Top", Top),
                new SqlParameter("@Type", Type),
                new SqlParameter("@CatId", CatId)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_Chart_Data");
            while (dr.Read())
            {
                Chart_data data = new Chart_data();
                data.Val = Convert.ToDecimal(dr["Val"].ToString());
                data.Perc = Convert.ToDecimal(dr["Perc"].ToString());
                data.ProductName = dr["ProductName"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }




    [System.Web.Services.WebMethod]
    public static Chart_Monthly[] Get_Monthwise_Chart_Report_Admin()
    {
        List<Chart_Monthly> details = new List<Chart_Monthly>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlDataReader dr = objDu.GetDataReaderSP("Get_Monthwise_Chart_Report_Admin");
            while (dr.Read())
            {
                Chart_Monthly data = new Chart_Monthly();
                data.MonthName = dr["MonthName"].ToString();

                data.New_Members = dr["New_Members"].ToString();
                data.New_Paid_Members = dr["New_Paid_Members"].ToString();
                data.New_Unpaid = dr["New_Unpaid"].ToString();
                data.Purchasing_Members = dr["Purchasing_Members"].ToString();
                data.Booster_Mem = dr["Booster_Mem"].ToString();

                data.New_Members_Per = Convert.ToDecimal(dr["New_Members_Per"].ToString());
                data.New_Paid_Members_Per = Convert.ToDecimal(dr["New_Paid_Members_Per"].ToString());
                data.New_Unpaid_Per = Convert.ToDecimal(dr["New_Unpaid_Per"].ToString());
                data.Purchasing_Members_Per = Convert.ToDecimal(dr["Purchasing_Members_Per"].ToString());
                data.Booster_Mem_Per = Convert.ToDecimal(dr["Booster_Mem_Per"].ToString());

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }





    [System.Web.Services.WebMethod]
    public static SalesDetails[] GetSalesData()
    {
        List<SalesDetails> details = new List<SalesDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@admin", HttpContext.Current.Session["admin"].ToString())
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_highcharts_Admin");
            while (dr.Read())
            {
                SalesDetails data = new SalesDetails();
                data.MonthName = dr["MonthName"].ToString();
                // data.Online_Sales = dr["Online_Sales"].ToString();
                //  data.Offline_Sales = dr["Offline_Sales"].ToString();

                data.TotalSales = dr["TotalSales"].ToString();
                data.TPV_GPV_Invoice_Amount = dr["TPV_GPV_Invoice_Amount"].ToString();
                data.Loyalty = dr["Loyalty"].ToString();
                data.GPV_TPV = dr["GPV_TPV"].ToString();

                data.TotalSales_Per = dr["TotalSales_Per"].ToString();
                data.TPV_GPV_Invoice_Amount_Per = dr["TPV_GPV_Invoice_Amount_Per"].ToString();
                data.Loyalty_Per = dr["Loyalty_Per"].ToString();
                data.GPV_TPV_Per = dr["GPV_TPV_Per"].ToString();


                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }

    public class SalesDetails
    {
        public String MonthName { get; set; }
        public String TotalSales_Per { get; set; }
        public String TPV_GPV_Invoice_Amount_Per { get; set; }
        public String Loyalty_Per { get; set; }
        public String GPV_TPV_Per { get; set; }

        public String TotalSales { get; set; }
        public String TPV_GPV_Invoice_Amount { get; set; }
        public String GPV_TPV { get; set; }
        public String Loyalty { get; set; }

    }

    public class Chart_Monthly
    {
        public String MonthName { get; set; }

        public String New_Members { get; set; }
        public String New_Paid_Members { get; set; }
        public String New_Unpaid { get; set; }
        public String Purchasing_Members { get; set; }
        public String Booster_Mem { get; set; }
        public decimal New_Members_Per { get; set; }
        public decimal New_Paid_Members_Per { get; set; }
        public decimal New_Unpaid_Per { get; set; }
        public decimal Purchasing_Members_Per { get; set; }
        public decimal Booster_Mem_Per { get; set; }

    }


    public class Chart_data
    {
        public decimal Val { get; set; }
        public decimal Perc { get; set; }
        public String ProductName { get; set; }
        public String CatName { get; set; }


    }

    public class Chart_data_Comparison
    {
        public decimal M3 { get; set; }
        public decimal M2 { get; set; }
        public decimal M1 { get; set; }
        public String CateWise { get; set; }
        public String Month1 { get; set; }
        public String Month2 { get; set; }
        public String Month3 { get; set; }

    }

    #endregion

}