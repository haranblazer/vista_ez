using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
 

public partial class franchise_Recieved_PO_List : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
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
                DateTime now = DateTime.Now;
                var startDate = new DateTime(now.Year, now.Month, 1);

                txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");
            }
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string Vendor, string orderno, string min, string max)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SessionId", HttpContext.Current.Session["franchiseid"].ToString()),
                new SqlParameter("@Vendor", Vendor),
                 new SqlParameter("@orderno", orderno),
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Fran_Receive_PO_List");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
               
                data.srno = dr["srno"].ToString();
                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.OrderNo = dr["OrderNo"].ToString();
                data.VendorInvNo = dr["VendorInvNo"].ToString();
                data.VenderName = dr["VenderName"].ToString();
                data.VendorCode = dr["VendorCode"].ToString();
                data.Gross = dr["Gross"].ToString();
                data.GST = dr["TaxRs"].ToString();
                data.NetAmt = dr["NetAmt"].ToString();
                data.BillDate = dr["BillDate"].ToString();
                data.VendorInv_Date = dr["VendorInv_Date"].ToString();
                data.SourceOfSupply = dr["SourceOfSupply"].ToString();
                data.DestinationOfSupply = dr["DestinationOfSupply"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Status { get; set; }
        public string srno { get; set; }
        public string InvoiceNo { get; set; }
        public string OrderNo { get; set; }
        public string VendorInvNo { get; set; }
        public string VenderName { get; set; }
        public string VendorCode { get; set; }
        public string Gross { get; set; }
        public string GST { get; set; }
        public string NetAmt { get; set; }
        public string BillDate { get; set; }
        public string VendorInv_Date { get; set; }
        public string SourceOfSupply { get; set; }
        public string DestinationOfSupply { get; set; }
    }

    #endregion



    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindGrid();
    //}


    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    BindGrid();
    //}


    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //    if (e.CommandName.Equals("GRN"))
    //    {
    //        String Inv = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
    //        Response.Redirect("Stock-GIT.aspx?Inv=" + Inv);
    //    }
    //}


    //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        LinkButton lnk_GRN = (LinkButton)e.Row.FindControl("lnk_GRN");
    //        Label lbl_GRN = (Label)e.Row.FindControl("lbl_GRN");
    //        HiddenField hd_Status = (HiddenField)e.Row.FindControl("hd_Status");


    //    }
    //}


    //private void BindGrid()
    //{
    //    try
    //    {
    //        String fromDate = "", toDate = "";
    //        try
    //        {
    //            if (txtFromDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtFromDate.Text.Split(new String[] { "-" }, StringSplitOptions.RemoveEmptyEntries);
    //                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //            if (txtToDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtToDate.Text.Split(new String[] { "-" }, StringSplitOptions.RemoveEmptyEntries);
    //                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid date entry.");
    //            return;
    //        }

    //        con = new SqlConnection(method.str);
    //        SqlDataAdapter ad = new SqlDataAdapter("Fran_Receive_PO_List", con);
    //        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        ad.SelectCommand.Parameters.AddWithValue("@min", fromDate);
    //        ad.SelectCommand.Parameters.AddWithValue("@max", toDate);
    //        ad.SelectCommand.Parameters.AddWithValue("@orderno", txt_orderno.Text.Trim());
    //        ad.SelectCommand.Parameters.AddWithValue("@Vendor", txt_Vendor.Text.Trim());
    //        ad.SelectCommand.Parameters.AddWithValue("@SessionId", Session["franchiseid"].ToString());
    //        dt = new DataTable();
    //        ad.Fill(dt);
    //        DataColumn dcDtl = new DataColumn("tbl", typeof(string));
    //        dt.Columns.Add(dcDtl);

    //        foreach (DataRow row in dt.Rows)
    //        {

    //            XElement objXml = XElement.Parse(row["detail"].ToString());
    //            string strDtl = "<table rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
    //            strDtl += "<tr><th>Name</th><th>Quantity</th><th>Price</th><th>Gross</th><th>Total</th></tr>";
    //            foreach (XElement p in objXml.Elements("P"))
    //            {
    //                strDtl += "<tr>";
    //                strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
    //                strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
    //                strDtl += "<td>" + p.Elements("Price").FirstOrDefault().Value + "</td>";
    //                strDtl += "<td>" + p.Elements("Gross").FirstOrDefault().Value + "</td>";
    //                strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
    //                strDtl += "</tr>";
    //            }
    //            strDtl += "</table>";
    //            row["tbl"] = strDtl;
    //        }
    //        GridView1.Columns[5].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(Gross)", "true").ToString()) ? "0.00" : dt.Compute("sum(Gross)", "true").ToString());
    //        GridView1.Columns[6].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(TaxRs)", "true").ToString()) ? "0.00" : dt.Compute("sum(TaxRs)", "true").ToString());
    //        GridView1.Columns[7].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(NetAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(NetAmt)", "true").ToString());

    //        GridView1.DataSource = dt;
    //        GridView1.DataBind();
    //        //if (dt.Rows.Count > 0)
    //        //{
    //        //    lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
    //        //    lblTotal.Text += ", Gross: " + (string.IsNullOrEmpty(dt.Compute("sum(Gross)", "true").ToString()) ? "0.00" : dt.Compute("sum(Gross)", "true").ToString());
    //        //    lblTotal.Text += ", GST: " + (string.IsNullOrEmpty(dt.Compute("sum(TaxRs)", "true").ToString()) ? "0.00" : dt.Compute("sum(TaxRs)", "true").ToString());
    //        //    lblTotal.Text += ", Net Amt: " + (string.IsNullOrEmpty(dt.Compute("sum(NetAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(NetAmt)", "true").ToString());



    //        //}
    //        //else
    //        //{

    //        //    lblTotal.Text = "No record";
    //        //}
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}


    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}

    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{

    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        BindGrid();
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ViewSalesBills.xls");
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        GridView1.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}


}