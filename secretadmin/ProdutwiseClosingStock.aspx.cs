using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class secretadmin_ProdutwiseClosingStock : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!IsPostBack)
        {
            BindUserProduct();
        }

    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string product)
    {

        String Result = "";
        String[] strProduct = product.Split(new String[] { "=" }, StringSplitOptions.RemoveEmptyEntries);
        try
        {
            if (strProduct[0] != null)
                product = strProduct[0];
        }
        catch { }


        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Productcode", product) };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "sp_ProdutwiseClosingStock");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.FranchiseID = dr["FranchiseID"].ToString();
                data.FranchiseName = dr["FranchiseName"].ToString();
                data.BatchNo = dr["BatchNo"].ToString();
                data.MFg = dr["MFg"].ToString();
                data.Exp = dr["Exp"].ToString();
                data.Qty = dr["Qty"].ToString(); 
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string FranchiseID { get; set; }
        public string FranchiseName { get; set; }
        public string BatchNo { get; set; }
        public string MFg { get; set; }
        public string Exp { get; set; }
        public string Qty { get; set; }
    }


    public void BindUserProduct()
    {
        //SqlDataReader dr;
        //SqlConnection con = new SqlConnection(method.str);
        //SqlCommand com = new SqlCommand("select p.ProductCode, ProductName=p.ProductName+'='+SPACE(1)+ p.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)) from shopproductmst p inner join PackSizemst ps on p.PackSizeUnitId = ps.srno and p.isDeleted = 0", con);
        //com.CommandType = CommandType.Text;
        //con.Open();
        //dr = com.ExecuteReader();
        divProductcode.InnerText = string.Empty;
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReader("select p.ProductCode, ProductName=p.ProductName+'='+SPACE(1)+ p.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)) from shopproductmst p inner join PackSizemst ps on p.PackSizeUnitId = ps.srno and p.isDeleted = 0");
        while (dr.Read())
        {
            divProductcode.InnerText += dr["ProductCode"].ToString() + "= " + dr["ProductName"].ToString() + ",";
        }
        // con.Close();
    }


    #endregion
}