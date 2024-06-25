using System;
using System.Collections.Generic; 
using System.Data.SqlClient; 
using System.Web; 

public partial class franchise_ClosingStock : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("Logout.aspx");

    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    { 
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
              new SqlParameter("@regno", HttpContext.Current.Session["franchiseid"].ToString())
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "ClosingStock");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.ProductCode = dr["ProductCode"].ToString();
                data.ProductName = dr["ProductName"].ToString();
                data.BatchNo = dr["BatchNo"].ToString();
                data.Mfg = dr["Mfg"].ToString();
                data.Expiry = dr["Expiry"].ToString();
                data.Qty = dr["Qty"].ToString();
                data.Total_DP = dr["Total_DP"].ToString();
                data.Total_DPWithTax = dr["Total_DPWithTax"].ToString();
                data.Tax = dr["Tax"].ToString();
                data.TPV = dr["TPV"].ToString();
                data.RPV = dr["RPV"].ToString();
                data.IsExpired = dr["IsExpired"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string BatchNo { get; set; }
        public string Mfg { get; set; }
        public string Expiry { get; set; }
        public string Qty { get; set; }
        public string Total_DP { get; set; }
        public string Total_DPWithTax { get; set; }
        public string Tax { get; set; }
        public string TPV { get; set; }
        public string RPV { get; set; }
        public string IsExpired { get; set; }
    }

    #endregion



    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    show();
    //}


    //public void show()
    //{
    //    if (Session["franchiseid"] == null)
    //        Response.Redirect("~/Login.aspx");

    //    System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();

    //    SqlParameter[] param = new SqlParameter[]
    //    { 
    //        new SqlParameter("@regno", Session["franchiseid"].ToString())
    //    };
    //    DataUtility obj_du = new DataUtility();
    //    DataTable dt = obj_du.GetDataTableSP(param, "ClosingStock");
    //    Session["dt"] = dt;
    //    if (dt.Rows.Count > 0)
    //    {
    //        dglst.Columns[2].FooterText = "Total :";
    //        dglst.Columns[6].FooterText = dt.AsEnumerable().Select(x => x.Field<int>("Qty")).Sum().ToString();
    //        dglst.Columns[7].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("Total_DP")).Sum().ToString();
    //        dglst.Columns[8].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("Total_DPWithTax")).Sum().ToString();
    //        dglst.Columns[9].FooterText = "0";
    //        dglst.Columns[10].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("TPV")).Sum().ToString();
    //        dglst.Columns[11].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("RPV")).Sum().ToString();

    //        dglst.DataSource = dt;
    //        dglst.DataBind();
    //    }
    //    else
    //    {
    //        dglst.DataSource = null;
    //        dglst.DataBind();
    //    }
    //}


    //protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    dglst.PageIndex = e.NewPageIndex;
    //    show();
    //}


    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        dt = (DataTable)Session["dt"];

    //        if (dt.Rows.Count > 0)
    //        {
    //            Response.ClearContent();
    //            Response.Buffer = true;
    //            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "ClosingStockReport.xls"));
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