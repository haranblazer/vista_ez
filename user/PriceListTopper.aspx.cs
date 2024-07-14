using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class User_PriceListTopper : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                BindUserProduct();
                getCategory(); 
            }
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string CatId, string ProductName)
    {
        String Productcode = "";
        String[] strProduct = ProductName.Split(new String[] { "=" }, StringSplitOptions.RemoveEmptyEntries);
        try
        {
            if (strProduct[0] != null)
                Productcode = strProduct[0];
        }
        catch { }

        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@CatId", CatId),
                   new SqlParameter("@ProductName", Productcode)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetUser_PriceList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.CatName = dr["CatName"].ToString();
                data.ProductCode = dr["ProductCode"].ToString();
                data.ProductName = dr["ProductName"].ToString();
                data.MRP = dr["MRP"].ToString();
                data.AP = dr["AP"].ToString();
                data.RPV = dr["RPV"].ToString();
                data.TPV = dr["TPV"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string CatName { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string MRP { get; set; }
        public string AP { get; set; }
        public string RPV { get; set; }
        public string TPV { get; set; }
    }

    #endregion



    public void getCategory()
    {
        try
        {
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable("Select CatId, CatName from Categorymst where isDeleted=0 order by PriorityDispaly");
            if (dt.Rows.Count > 0)
            {
                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = dt.Columns["CatName"].ToString();
                ddlCategory.DataValueField = dt.Columns["CatId"].ToString();
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("All", "0"));
            }
            else
            {
                ddlCategory.Items.Insert(0, new ListItem("All", "0"));
            }
        }
        catch
        {
        }
    }

    public void BindUserProduct()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(
            @"Select s.ProductCode, ProductName=s.ProductName +SPACE(1)+ s.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)) from ShopProductMst s left join PackSizemst ps on s.PackSizeUnitId=ps.srno where s.isDeleted=0 ");
        foreach (DataRow dr in dt.Rows)
        {
            divProductcode.InnerText += dr["productCode"].ToString() + "= " + dr["ProductName"].ToString() + ",";
        }
    }

}