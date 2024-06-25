using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class franchise_OfferProdReporta : System.Web.UI.Page
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
            // BindGrid();
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string SoldTo)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SalesRepId", HttpContext.Current.Session["franchiseid"].ToString()),
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@SoldTo", SoldTo),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_Offer_Loyalty_Prod");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.OFFERID = dr["OFFERID"].ToString();
                data.srno = dr["srno"].ToString();
                data.Date = dr["Date"].ToString();
                data.InvoiceNumber = dr["InvoiceNumber"].ToString();
                data.InvoiceAmount = dr["InvoiceAmount"].ToString();
                data.SellerID = dr["SellerID"].ToString();
                data.SellerName = dr["SellerName"].ToString();
                data.BuyerID = dr["BuyerID"].ToString();

                data.BuyerName = dr["BuyerName"].ToString();
                data.BillingType = dr["BillingType"].ToString();
                data.Productcode = dr["Productcode"].ToString();
                data.ProductName = dr["ProductName"].ToString();
                data.ProductQty = dr["ProductQty"].ToString();
                data.DispatchStatus = dr["DispatchStatus"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string srno { get; set; }
        public string OFFERID { get; set; }

        public string Date { get; set; }
        public string InvoiceNumber { get; set; }
        public string InvoiceAmount { get; set; }
        public string SellerID { get; set; }
        public string SellerName { get; set; }
        public string BuyerID { get; set; }
        public string BuyerName { get; set; }
        public string BillingType { get; set; }
        public string Productcode { get; set; }
        public string ProductName { get; set; }
        public string ProductQty { get; set; }
        public string DispatchStatus { get; set; }
    }


    [System.Web.Services.WebMethod]
    public static string Dispatched(string srno, string OFFERID)
    {
        string Result = "";
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
            new SqlParameter("@Srno", srno),
            new SqlParameter("@OFFERID", OFFERID),
            new SqlParameter("@OFFER_STR", OFFERID+",")
            };
            DataUtility objDu = new DataUtility();
            int res = objDu.ExecuteSql(param, @"Update BillMst Set 
                Dispatch_Offerid=(Case [dbo].GetDispatchStatus(@OFFERID, isnull(Dispatch_Offerid,'')) when 0 then (isnull(Dispatch_Offerid,'') + @OFFER_STR) else isnull(Dispatch_Offerid,'') End)
                Where Srno=@Srno"); 
            if (res > 0)
            {
                Result="1";
            }
            else
            {
                Result = "This user not in your downline.!!"; 
            }
        }
        catch (Exception er) { Result = er.Message; }
        return Result;
    }
    #endregion



    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    BindGrid();
    //}


    //public void BindGrid()
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
    //        new SqlParameter("@min", fromDate),
    //        new SqlParameter("@max", toDate),
    //        new SqlParameter("@SalesRepId", Session["franchiseid"].ToString()),
    //        new SqlParameter("@SoldTo", txt_BuyerId.Text.Trim()),
    //    };
    //    DataUtility obj_du = new DataUtility();
    //    DataTable dt = obj_du.GetDataTableSP(param, "Get_Offer_Loyalty_Prod");
    //    Session["dt"] = dt;
    //    if (dt.Rows.Count > 0)
    //    {
    //        GridView1.DataSource = dt;
    //        GridView1.DataBind();
    //    }
    //    else
    //    {
    //        GridView1.DataSource = null;
    //        GridView1.DataBind();
    //    }
    //}


    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindGrid();
    //}

    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    try
    //    {
    //        if (e.CommandName == "Dispatch")
    //        {
    //            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //            string Srno = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
    //            string OFFERID = GridView1.DataKeys[row.RowIndex].Values[1].ToString();

    //            SqlParameter[] param = new SqlParameter[]
    //            {
    //                new SqlParameter("@Srno", Srno),
    //                new SqlParameter("@OFFERID", OFFERID),
    //                new SqlParameter("@OFFER_STR", OFFERID+",")
    //            };
    //            DataUtility objDu = new DataUtility();
    //            int Result = objDu.ExecuteSql(param, @"Update BillMst Set 
    //            Dispatch_Offerid=(Case [dbo].GetDispatchStatus(@OFFERID, isnull(Dispatch_Offerid,'')) when 0 then (isnull(Dispatch_Offerid,'') + @OFFER_STR) else isnull(Dispatch_Offerid,'') End)
    //            Where Srno=@Srno");

    //            if (Result > 0)
    //            {
    //                utility.MessageBox(this, "Offer dispatch save successfully.!!");
    //                BindGrid();
    //            }
    //            else
    //            {
    //                utility.MessageBox(this, "This user not in your downline.!!");
    //            }


    //        }
    //    }
    //    catch (Exception er) { }
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
    //            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "OfferProductReport.xls"));
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