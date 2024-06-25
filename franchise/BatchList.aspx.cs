using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_BatchList : System.Web.UI.Page
{

    SqlConnection con = null;
    DataTable dt = null;
    SqlCommand cmd = null;

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
                BindProduct();
               // gridbind();
            }
        }
    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string pid)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter outparam = new SqlParameter("@flag", SqlDbType.VarChar, 100);
            outparam.Direction = ParameterDirection.Output;
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@soldby", HttpContext.Current.Session["franchiseid"].ToString()),
                new SqlParameter("@pid", pid),
                new SqlParameter("@action", "show"),
                outparam
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "UpdateProductQty");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.ProductCode = dr["ProductCode"].ToString();
                data.productname = dr["productname"].ToString();
                data.BatchNo = dr["BatchNo"].ToString();
                data.Batchdate = dr["Batchdate"].ToString();
                data.ExpiryDate = dr["ExpiryDate"].ToString();

                data.MRP = dr["MRP"].ToString();
                data.Total_DP = dr["Total_DP"].ToString();
                data.Total_DPWithTax = dr["Total_DPWithTax"].ToString();
                data.DpStock = dr["DpStock"].ToString();
                data.DpStockWithTax = dr["DpStockWithTax"].ToString();

                data.PORate = dr["PORate"].ToString();
                data.POWithTax = dr["POWithTax"].ToString();
                data.Tax = dr["Tax"].ToString();
                data.BVAmt = dr["BVAmt"].ToString();
                data.pbvamt = dr["pbvamt"].ToString();
                data.FPV = dr["FPV"].ToString();
                data.APV = dr["APV"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string ProductCode { get; set; }
        public string productname { get; set; }
        public string BatchNo { get; set; }
        public string Batchdate { get; set; }
        public string ExpiryDate { get; set; }
        public string MRP { get; set; }
        public string Total_DP { get; set; }
        public string Total_DPWithTax { get; set; }
        public string DpStock { get; set; }
        public string DpStockWithTax { get; set; }
        public string PORate { get; set; }
        public string POWithTax { get; set; }
        public string Tax { get; set; }
        public string BVAmt { get; set; }
        public string pbvamt { get; set; }
        public string FPV { get; set; }
        public string APV { get; set; }

    }

    #endregion


    //protected void ddlproductname_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    gridbind();
    //}

    //public void gridbind()
    //{
    //    string pid = ddlproductname.SelectedValue.ToString();
    //    con = new SqlConnection(method.str);
    //    cmd = new SqlCommand("UpdateProductQty", con);
    //    cmd.Parameters.AddWithValue("@action", "show");
    //    cmd.Parameters.AddWithValue("@pid", pid);
    //    cmd.Parameters.AddWithValue("@soldby", HttpContext.Current.Session["franchiseid"].ToString());
    //    cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
    //    con.Open();
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    dglst.DataSource = cmd.ExecuteReader();
    //    dglst.DataBind();
    //    con.Close();
    //}

    //protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dglst.Rows.Count > 0)
    //    {
    //        dglst.AllowPaging = false;
    //        gridbind();
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Batchlist.doc");
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        dglst.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}


    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dglst.Rows.Count > 0)
    //    {
    //        dglst.AllowPaging = false;
    //        gridbind();
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Batchlist.xls");
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        dglst.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}

    private void BindProduct()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("select p.productid, ProductName=p.ProductName +SPACE(1)+ p.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)) from shopproductmst p inner join PackSizemst ps on p.PackSizeUnitId = ps.srno and p.isDeleted = 0 order by p.ProductName");
        if (dt.Rows.Count > 0)
        {
            ddlproductname.Items.Clear();
            ddlproductname.DataSource = dt;
            ddlproductname.DataTextField = "ProductName";
            ddlproductname.DataValueField = "productid";
            ddlproductname.DataBind();
            ddlproductname.Items.Insert(0, new ListItem("All Product", "0"));

        }
    }

}