using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient; 

public partial class secretadmin_BatchList : System.Web.UI.Page
{

    SqlConnection con = null;
    DataTable dt = null;
    SqlCommand cmd = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
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
                bindproduct();
            }
        }
        catch
        {

        }


    }




    #region Bind Table

    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string pid, string Expired)
    {

        List<UserDetails> details = new List<UserDetails>();
        try
        {

            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@pid", pid),
                 new SqlParameter("@IsExpired", Expired)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_BatchList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Batchid = dr["Batchid"].ToString();
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
                data.CompRate = dr["CompRate"].ToString();
                data.CompWithTax = dr["CompWithTax"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }

    public class UserDetails
    {
        public String Batchid { get; set; }
        public String ProductCode { get; set; }
        public String productname { get; set; }
        public String BatchNo { get; set; }
        public String Batchdate { get; set; }
        public String ExpiryDate { get; set; }

        public String MRP { get; set; }
        public String Total_DP { get; set; }
        public String Total_DPWithTax { get; set; }
        public String DpStock { get; set; }
        public String DpStockWithTax { get; set; }

        public String PORate { get; set; }
        public String POWithTax { get; set; }
        public String Tax { get; set; }
        public String BVAmt { get; set; }
        public String pbvamt { get; set; }
        public String FPV { get; set; }
        public String APV { get; set; }
        public String CompRate { get; set; }
        public String CompWithTax { get; set; }

    }
     
    public void bindproduct()
    {
        con = new SqlConnection(method.str);
        cmd = new SqlCommand("UpdateProductQty", con);
        cmd.Parameters.AddWithValue("@action", "bindproduct");
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        ddlproductname.Items.Clear();
        ddlproductname.DataTextField = "productname";
        ddlproductname.DataValueField = "productid";
        ddlproductname.DataSource = cmd.ExecuteReader();
        ddlproductname.DataBind();

        ddlproductname.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Product", "0"));
        con.Close();

    }





    #endregion





    //public void gridbind()
    //{
    //    try
    //    {

    //        DataUtility objDu = new DataUtility();
    //        SqlParameter[] param = new SqlParameter[]
    //        {
    //             new SqlParameter("@pid", ddlproductname.SelectedValue),
    //             new SqlParameter("@IsExpired", ddl_Expired.SelectedValue) 
    //        };
    //        DataTable dt = objDu.GetDataTableSP("Get_BatchList");

    //        ViewState["dt"] = dt;

    //        dglst.DataSource = dt;
    //        dglst.DataBind();
    //        con.Close();
    //    }
    //    catch (Exception er)
    //    {
    //        dglst.DataSource = null;
    //        dglst.DataBind();
    //    }
    //}




    //protected void btn_Search_Click(object sender, EventArgs e)
    //{
    //    gridbind();

    //}

    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        if (ViewState["dt"] != null)
    //            dt = (DataTable)ViewState["dt"];


    //        if (dt.Rows.Count > 0)
    //        {
    //            Response.ClearContent();
    //            Response.Buffer = true;
    //            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "BatcListProd.xls"));
    //            Response.ContentType = "application/ms-excel";
    //            string str = string.Empty;
    //            foreach (DataColumn dtcol in dt.Columns)
    //            {
    //                Response.Write(str + dtcol.ColumnName);
    //                str = "\t";
    //            }
    //            Response.Write("\n");
    //            foreach (DataRow dr in dt.Rows)
    //            {
    //                str = "";
    //                for (int j = 0; j < dt.Columns.Count; j++)
    //                {
    //                    Response.Write(str + Convert.ToString(dr[j]));
    //                    str = "\t";
    //                }
    //                Response.Write("\n");
    //            }
    //            Response.End();
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found.');", true);
    //        }
    //    }
    //    catch (Exception er) { }

    //}
}