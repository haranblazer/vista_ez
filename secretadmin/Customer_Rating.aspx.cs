using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data; 
using System.Web.UI.WebControls; 

public partial class secretadmin_Customer_Rating : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            getCategory();
            BindUserProduct();
        }
    }

    public void getCategory()
    {
        try
        { 
            DataUtility dataUtility = new DataUtility(); 
            DataTable dt = dataUtility.GetDataTable("select CatId,CatName from Categorymst");
            ddlCategory.Items.Clear();
            if (dt.Rows.Count > 0)
            {
                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "CatName";
                ddlCategory.DataValueField = "CatId";
                ddlCategory.DataBind(); 
            }
            ddlCategory.Items.Insert(0, new ListItem("All", "0"));
        }
        catch
        {
        }
    }

    public void BindUserProduct()
    { 
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select productcode,ProductName,PackSize from  Shopproductmst");
        foreach (DataRow dr in dt.Rows)
        { 
            divProductcode.InnerText += dr["productcode"].ToString().Trim() + "= " + dr["ProductName"].ToString().Trim() + " (" + dr["PackSize"].ToString().Trim() + ")" + ",";
        }
    }
    [System.Web.Services.WebMethod]
    public static void UpdateComments(string Fid,string Comment,string Approve_Reject)
    {
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@fid", Fid),
                new SqlParameter("@Comments", Comment),
                new SqlParameter("@Status", Approve_Reject)
            };
            objDu.ExecuteSql(param, "update  ProdFeedbackMst set Comments=@Comments,status=@status where fid=@fid");
        }
        catch (Exception er)
        { }
    }

    [System.Web.Services.WebMethod]

    public static Detail[] bindtable(string Category, string Product, string Min_Rate,string Max_Rate,string Status)
    {
        String[] strProduct = Product.Split(new String[] { "=" }, StringSplitOptions.RemoveEmptyEntries);
        try
        {
            if (strProduct.Length > 0 && strProduct[0] != null)
                Product = strProduct[0];
        }
        catch { }
        List<Detail> details = new List<Detail>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            { 
                new SqlParameter("@CatId", Category),
                new SqlParameter("@ProductCode", Product),
                new SqlParameter("@MinRate", Min_Rate==""?"0":Min_Rate),
                new SqlParameter("@MaxRate", Max_Rate==""?"0":Max_Rate),
                new SqlParameter("@status", Status), 
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetCustomerRating");
            utility objUtil = new utility();
            while (dr.Read())
            {
                Detail data = new Detail();
                data.ProductCode = dr["ProductCode"].ToString();
                data.ProductName = dr["ProductName"].ToString();
                data.Rate = dr["Rate"].ToString();
                data.Comments = dr["Comments"].ToString();
                data.Doe = dr["Doe"].ToString();
                data.Status = dr["Status"].ToString();
                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.Userid = dr["Userid"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.Fid = dr["FId"].ToString(); 
                    data.Img1 = dr["Img1"].ToString();
                details.Add(data);
            }; 
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class Detail 
    { 
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string Rate { get; set; }
        public string Comments { get; set; }
        public string Doe { get; set; }
        public string Status { get; set; }
        public string InvoiceNo { get; set; }
        public string Userid { get; set; }
        public string Fid { get; set; } 
        public string UserName { get; set; }
        public string Img1 { get; set; }

    }

}