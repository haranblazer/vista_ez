using System;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;
using System.Web; 

public partial class admin_ProductList : System.Web.UI.Page
{ 
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {
                getCategory();
            }
        }
        catch
        {

        }

    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string CatId, string isDeleted)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@ProductName", ""),
                new SqlParameter("@CatId", CatId),
                new SqlParameter("@isDeleted", isDeleted),
                new SqlParameter("@Adminid", HttpContext.Current.Session["admin"].ToString()),
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "plist");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Productid = dr["Productid"].ToString();
                data.IsProdImg = dr["IsProdImg"].ToString();
                data.IsComboPack = dr["IsComboPack"].ToString();
                data.isDeleted = dr["isDeleted"].ToString();
                data.IsRedeem = dr["IsRedeem"].ToString();
                data.IsPO = dr["IsPO"].ToString();
                data.IsWebDisplay = dr["IsWebDisplay"].ToString();
                //data.IsRefUser = dr["IsRefUser"].ToString();
                data.MaxLoyalty = dr["MaxLoyalty"].ToString();
                data.SaleType = dr["SaleType"].ToString();
                data.CatName = dr["CatName"].ToString();
                data.ProductCode = dr["ProductCode"].ToString();
                data.ProductName = dr["ProductName"].ToString();
                data.Prod_Display = dr["Prod_Display"].ToString();
                data.HSNCode = dr["HSNCode"].ToString();
                data.Tax = dr["Tax"].ToString();
                data.weight = dr["weight"].ToString();
                data.CaseSize = dr["CaseSize"].ToString();
                data.Price = dr["Price"].ToString();
                data.TagName = dr["TagName"].ToString();
                data.isFeatured = dr["isFeatured"].ToString();
                data.NewArrival = dr["NewArrival"].ToString();
                data.SubCat = dr["SubCatName"].ToString();
                data.IsVariant = dr["IsVariant"].ToString();
                data.Length = dr["Lengths"].ToString();
                data.Height = dr["Height"].ToString();
                data.Width = dr["Width"].ToString();
                data.BrandName = dr["BrandName"].ToString();

                details.Add(data);
            }
            
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Productid { get; set; }
        public string IsProdImg { get; set; }
        public string IsComboPack { get; set; }
        public string isDeleted { get; set; }
        public string IsRedeem { get; set; }
        public string IsPO { get; set; }
        public string IsWebDisplay { get; set; }
        public string IsRefUser { get; set; }
        public string MaxLoyalty { get; set; }
        public string SaleType { get; set; }

        public string CatName { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string Prod_Display { get; set; }

        public string HSNCode { get; set; }
        public string Tax { get; set; }
        public string weight { get; set; }
        public string CaseSize { get; set; }
        public string Price { get; set; }
        public string TagName { get; set; }
         public string isFeatured { get; set; }
        public string NewArrival { get; set; }
        public string SubCat { get; set; }
        public string IsVariant { get; set; }
       
        public string Length { get; set; }
        public string Height { get; set; }
        public string Width { get; set; }
        public string BrandName { get; set; }
        
    }


    [System.Web.Services.WebMethod]
    public static string UpdateStatus(string Pid, string flag)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Pid", Pid) };

            if (flag == "IsActive")
                objDu.ExecuteSql(param, "update ShopProductMst set isDeleted=(Case isnull(isDeleted,0) when 0 then 1 else 0 End) where Productid=@Pid");

            if (flag == "IsRedeem")
                objDu.ExecuteSql(param, "update ShopProductMst set IsRedeem=(Case isnull(IsRedeem,0) when 0 then 1 else 0 End) where Productid=@Pid");

            if (flag == "IsPO")
                objDu.ExecuteSql(param, "update ShopProductMst set IsPO=(Case isnull(IsPO,0) when 0 then 1 else 0 End) where Productid=@Pid");

            if (flag == "IsWebDisplay")
                objDu.ExecuteSql(param, "update ShopProductMst set IsWebDisplay=(Case isnull(IsWebDisplay,0) when 0 then 1 else 0 End) where Productid=@Pid");

            if (flag == "isFeatured")
                objDu.ExecuteSql(param, "update ShopProductMst set isFeatured=(Case isnull(isFeatured,0) when 0 then 1 else 0 End) where Productid=@Pid");

            if (flag == "NewArrival")
                objDu.ExecuteSql(param, "update ShopProductMst set NewArrival=(Case isnull(NewArrival,0) when 0 then 1 else 0 End) where Productid=@Pid");


            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }
    [System.Web.Services.WebMethod]
    public static string UpdateSaleType(string Pid, string SaleType)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Pid", Pid), new SqlParameter("@SaleType", SaleType) };
            objDu.ExecuteSql(param, "update ShopProductMst set SaleType=@SaleType where Productid=@Pid");
            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }
     
    public void getCategory()
    {

        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("select distinct CatId,CatName from Categorymst where isDeleted=0");
        if (dt.Rows.Count > 0)
        {
            ddlCategory.Items.Clear();
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CatName";
            ddlCategory.DataValueField = "CatId";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }
        else
        {
            //ddlCategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
        }

    }

    #endregion

     

}
