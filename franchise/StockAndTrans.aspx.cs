using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;

public partial class admin_StockAndTrans : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter sda;
    protected void Page_Load(object sender, EventArgs e)
    {http://localhost:22739/franchise/StockAndTrans.aspx.cs
        if (Session["username"] == null || Session["name"] == null || Session["franchiseid"] == null)
            Response.Redirect("Default.aspx", false);
        if (!IsPostBack)
        {
            try
            {
                BindGrid();
            }
            catch { }
        }
    }
   
  
    public void BindGrid()
    {
        sda = new SqlDataAdapter("select S.ProductName,S.MRP,ROUND(s.DPAmt,2) as dpamt,S.BVAmt,F.QTY,S.MaxAllowed from ShopProductMst S inner Join franchisestock F on F.productid=S.productid where F.FranchiseId=" + Session["franchiseid"].ToString() + " order by s.productname", con);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            GrdProduct.DataSource = dt;
            GrdProduct.DataBind();
        }
        else
        {
            GrdProduct.DataSource = null;
            GrdProduct.DataBind();
        }
    }
   
}