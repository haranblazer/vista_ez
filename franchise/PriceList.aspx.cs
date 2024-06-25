using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class franchise_PriceList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Logout.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                BindUserProduct();
                getCategory();
                // BindProduct();
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
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetFran_PriceList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.CatName = dr["CatName"].ToString();
                data.ProductCode = dr["ProductCode"].ToString();
                data.ProductName = dr["ProductName"].ToString();
                data.Tax = dr["Tax"].ToString();
                data.HSNCode = dr["HSNCode"].ToString();
                data.MRP = dr["MRP"].ToString();
                data.DP_Rate = dr["DP Rate"].ToString();
                data.AP = dr["AP Rate"].ToString();
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
        public string Tax { get; set; }
        public string HSNCode { get; set; }
        public string MRP { get; set; }
        public string AP { get; set; }
        public string DP_Rate { get; set; }
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
        DataTable dt = objDu.GetDataTable("Select ProductName from ShopProductMst where isDeleted=0");
        foreach (DataRow dr in dt.Rows)
        {
            divProductcode.InnerText += dr["ProductName"].ToString() + ",";
        }
    }


}