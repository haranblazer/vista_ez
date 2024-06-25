using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_StockScheme : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("Logout.aspx");
        if (!IsPostBack)
        {
            DateTime now = DateTime.Now;
            var startDate = new DateTime(now.Year, now.Month, 1);

            txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            //show();
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FranchiseId", HttpContext.Current.Session["franchiseid"].ToString()),
                new SqlParameter("@MinDate", min),
                new SqlParameter("@MaxDate", max),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetSchemeStock");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails(); 
                data.productid = dr["productid"].ToString(); 
                data.Productcode = dr["Productcode"].ToString();
                data.ProductName = dr["ProductName"].ToString(); 
                data.Sold_Free_Prod = dr["Sold-Free-Prod"].ToString();
                data.Sold_Prod = dr["Sold-Prod"].ToString();
                data.Sold_Amount = dr["Sold-Amount"].ToString();
                data.Free_Stock_In = dr["Free-Stock-In"].ToString();
                data.Stock_In = dr["Stock-In"].ToString();
                data.Stock_In_With_Amount = dr["Stock-In-With-Amount"].ToString(); 
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        
        public string productid { get; set; }
        public string Productcode { get; set; }
        public string ProductName { get; set; }
        public string Sold_Free_Prod { get; set; }
        public string Sold_Prod { get; set; }
        public string Sold_Amount { get; set; }
        public string Free_Stock_In { get; set; }
        public string Stock_In { get; set; }
        public string Stock_In_With_Amount { get; set; }
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
    //    dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //    DateTime fromDate = new DateTime();
    //    DateTime toDate = new DateTime();
    //    try
    //    {
    //        fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
    //        toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
    //    }
    //    catch
    //    {
    //        utility.MessageBox(this, "Invalid date entry.");
    //        return;
    //    }

    //    SqlParameter[] param = new SqlParameter[]
    //    {
    //        new SqlParameter("@MinDate", fromDate),
    //        new SqlParameter("@MaxDate", toDate),
    //        new SqlParameter("@FranchiseId", Session["franchiseid"].ToString())
    //    };
    //    DataUtility obj_du = new DataUtility();
    //    DataTable dt = obj_du.GetDataTableSP(param, "GetSchemeStock");
    //    Session["dt"] = dt;
    //    if (dt.Rows.Count > 0)
    //    {
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
    //            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}","StockScheme.xls"));
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