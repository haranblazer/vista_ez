using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class franchise_FranchisePurchaseList : System.Web.UI.Page
{
    //DataTable dt = null;
    //SqlConnection con = null;
    //SqlCommand com = null;
    //string regno = string.Empty;
    //XmlDocument xmldoc = new XmlDocument();
    //DataUtility objDUT = null;
    //string franchiseid = "";
    //string invoiceno = "";
    //int status = 0;
    //string returnvalue;
    //string strajax = "";
    //string xmlfile = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("Logout.aspx");


        if (!IsPostBack)
        {
            DateTime now = DateTime.Now;
            var startDate = new DateTime(now.Year, now.Month, 1);

            txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");

            // BindGrid();

        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string SalesRepId, string invoiceno, string status, string Del_Status)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@soldto", HttpContext.Current.Session["franchiseid"].ToString()),
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@SalesRepId", SalesRepId),
                new SqlParameter("@invoiceno", invoiceno),
                new SqlParameter("@status", status),
                new SqlParameter("@Del_Status", Del_Status),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "stockbillsearch");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.srno_Encode = objutil.base64Encode(dr["srno"].ToString());

                data.Date = dr["Date"].ToString();
                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.SellerUserId = dr["SellerUserId"].ToString();
                data.SellerName = dr["SellerName"].ToString();
                data.SellerDistrict = dr["SellerDistrict"].ToString();
                data.SellerState = dr["SellerState"].ToString();
                data.NoOFProduct = dr["NoOFProduct"].ToString();
                data.grossAmt = dr["grossAmt"].ToString();
                data.SGST = dr["SGST"].ToString();
                data.CGST = dr["CGST"].ToString();


                data.IGST = dr["IGST"].ToString();
                data.Cess = dr["Cess"].ToString();
                data.netAmt = dr["netAmt"].ToString();
                data.CourierCharges = dr["CourierCharges"].ToString();
                data.Discount = dr["Discount"].ToString();

                data.Amount = dr["Amount"].ToString();
                data.TotalFPV = dr["TotalFPV"].ToString();
                data.status = dr["status"].ToString();
                data.Del_Status = dr["Del_Status"].ToString();
                data.DeleveryText = dr["DeleveryText"].ToString();

                data.EwayNo = dr["EwayNo"].ToString();
                data.DispatchDate = dr["DispatchDate"].ToString();
                data.Tracking = dr["Tracking"].ToString();
                data.Transport = dr["Transport"].ToString();
                data.DeliveryDate = dr["DeliveryDate"].ToString();

                data.DurationDays = dr["DurationDays"].ToString();
                data.Del_Remarks = dr["Del_Remarks"].ToString();
                data.ConfirmWith = dr["ConfirmWith"].ToString();
                data.TransportMode = dr["TransportMode"].ToString();
                data.No_Boxes = dr["No_Boxes"].ToString();

                data.Weight_KG = dr["Weight_KG"].ToString();
                data.Slip = dr["DispatchFileName"].ToString();
                data.Img2 = dr["Img2"].ToString(); 
                data.TotalBV = dr["TotalBV"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string srno_Encode { get; set; }

        public string Date { get; set; }
        public string InvoiceNo { get; set; }
        public string SellerUserId { get; set; }
        public string SellerName { get; set; }
        public string SellerDistrict { get; set; }
        public string SellerState { get; set; }
        public string NoOFProduct { get; set; }
        public string grossAmt { get; set; }
        public string SGST { get; set; }
        public string CGST { get; set; }

        public string IGST { get; set; }
        public string Cess { get; set; }
        public string netAmt { get; set; }
        public string CourierCharges { get; set; }
        public string Discount { get; set; }

        public string Amount { get; set; }
        public string TotalFPV { get; set; }
        public string status { get; set; }
        public string Del_Status { get; set; }
        public string DeleveryText { get; set; }

        public string EwayNo { get; set; }
        public string DispatchDate { get; set; }
        public string Tracking { get; set; }
        public string Transport { get; set; }
        public string DeliveryDate { get; set; }
        public string DurationDays { get; set; }
        public string Del_Remarks { get; set; }
        public string ConfirmWith { get; set; }
        public string TransportMode { get; set; }
        public string No_Boxes { get; set; }
        public string Weight_KG { get; set; }
        public string Slip { get; set; } 
        public string Img2 { get; set; }
        public string TotalBV { get; set; }
    }

    #endregion





    //private void BindGrid()
    //{
    //    try
    //    {
    //        String fromDate = "", toDate = "";
    //        try
    //        {
    //            if (txtFromDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //            if (txtToDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid date entry.");
    //            return;
    //        }

    //        con = new SqlConnection(method.str);
    //        SqlDataAdapter ad = new SqlDataAdapter("stockbillsearch", con);
    //        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        ad.SelectCommand.Parameters.AddWithValue("@min", fromDate);
    //        ad.SelectCommand.Parameters.AddWithValue("@max", toDate);
    //        ad.SelectCommand.Parameters.AddWithValue("@SalesRepId", txt_SalesRepId.Text.Trim());
    //        ad.SelectCommand.Parameters.AddWithValue("@soldto", Session["franchiseid"].ToString());
    //        ad.SelectCommand.Parameters.AddWithValue("@invoiceno", Txt_InvoiceNo.Text == "" ? "" : Txt_InvoiceNo.Text.Trim());
    //        ad.SelectCommand.Parameters.AddWithValue("@status", ddl_Status.SelectedValue.ToString());
    //        ad.SelectCommand.Parameters.AddWithValue("@Del_Status", ddl_Del_Status.SelectedValue.ToString());
    //        dt = new DataTable();
    //        ad.Fill(dt);
    //        DataColumn dcDtl = new DataColumn("tbl", typeof(string));
    //        dt.Columns.Add(dcDtl);
    //        DataColumn srno_Encript = new DataColumn("srno_Encript", typeof(string));
    //        dt.Columns.Add(srno_Encript);

    //        foreach (DataRow row in dt.Rows)
    //        {
    //            utility objutil = new utility();

    //            row.SetField("srno_Encript", objutil.base64Encode(row["srno"].ToString()));
    //            //XElement objXml = XElement.Parse(row["dtl"].ToString());
    //            //string strDtl = "<table rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
    //            //strDtl += "<tr><th>Name</th><th>Quantity</th><th>MRP</th><th>Total</th></tr>";
    //            //foreach (XElement p in objXml.Elements("P"))
    //            //{
    //            //    strDtl += "<tr>";
    //            //    strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
    //            //    strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
    //            //    strDtl += "<td>" + p.Elements("MRP").FirstOrDefault().Value + "</td>";
    //            //    strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
    //            //    strDtl += "</tr>";
    //            //}
    //            //strDtl += "</table>";
    //            //row["tbl"] = strDtl;
    //        }
    //        GridView1.Columns[13].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(grossAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(grossAmt)", "true").ToString());
    //        GridView1.Columns[14].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(SGST)", "true").ToString()) ? "0.00" : dt.Compute("sum(SGST)", "true").ToString());
    //        GridView1.Columns[15].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(CGST)", "true").ToString()) ? "0.00" : dt.Compute("sum(CGST)", "true").ToString());
    //        GridView1.Columns[16].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(IGST)", "true").ToString()) ? "0.00" : dt.Compute("sum(IGST)", "true").ToString());
    //        GridView1.Columns[17].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(Cess)", "true").ToString()) ? "0.00" : dt.Compute("sum(Cess)", "true").ToString());
    //        GridView1.Columns[18].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(netAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(netAmt)", "true").ToString());

    //        GridView1.Columns[19].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(CourierCharges)", "true").ToString()) ? "0.00" : dt.Compute("sum(CourierCharges)", "true").ToString());
    //        GridView1.Columns[20].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(Discount)", "true").ToString()) ? "0.00" : dt.Compute("sum(Discount)", "true").ToString());
    //        GridView1.Columns[21].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(Amount)", "true").ToString()) ? "0.00" : dt.Compute("sum(Amount)", "true").ToString());

    //        GridView1.Columns[22].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(TotalFPV)", "true").ToString()) ? "0.00" : dt.Compute("sum(TotalFPV)", "true").ToString());


    //        GridView1.DataSource = dt;
    //        GridView1.DataBind();


    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}
    ///// <summary>
    ///// //By <S>
    ///// </summary>
    ///// <param name="sender"></param>
    ///// <param name="e"></param>
    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindGrid();
    //}
    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    BindGrid();
    //}
    //protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    //{

    //}

    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    try
    //    {
    //        string Result = string.Empty;
    //        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //        invoiceno = GridView1.DataKeys[row.RowIndex].Values[0].ToString();

    //        if (e.CommandName.Equals("update"))
    //        {
    //            TextBox txtTransport = (TextBox)row.FindControl("txtTransport");
    //            TextBox txtTracking = (TextBox)row.FindControl("txtTracking");
    //            TextBox txt_EWayBill = (TextBox)row.FindControl("txt_EWayBill");
    //            TextBox txtcmt = (TextBox)row.FindControl("txtcom");
    //            con = new SqlConnection(method.str);
    //            SqlCommand cmd = new SqlCommand("Update_StockDelivery", con);
    //            cmd.CommandType = CommandType.StoredProcedure;

    //            cmd.Parameters.AddWithValue("@invoiceno", invoiceno);
    //            cmd.Parameters.AddWithValue("@Transport", txtTransport.Text);
    //            cmd.Parameters.AddWithValue("@Tracking", txtTracking.Text);
    //            cmd.Parameters.AddWithValue("@EwayNo", txt_EWayBill.Text);
    //            cmd.Parameters.AddWithValue("@Del_Remarks", txtcmt.Text);
    //            cmd.Parameters.AddWithValue("@Del_by", Session["admin"].ToString());
    //            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
    //            con.Open();
    //            cmd.ExecuteNonQuery();
    //            Result = cmd.Parameters["@flag"].Value.ToString();
    //            if (Result == "1")
    //            {
    //                utility.MessageBox(this, "Deliver Updated Successfully");
    //            }
    //            else
    //            {
    //                utility.MessageBox(this, Result);
    //            }
    //        }
    //        BindGrid();
    //    }
    //    catch (Exception ex)
    //    {
    //        utility.MessageBox(this, ex.ToString());
    //    }
    //    finally
    //    {

    //    }
    //}
    //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {

    //        HiddenField hnd_Status = (HiddenField)e.Row.FindControl("hnd_status");
    //        HiddenField hnd_Del_Status = (HiddenField)e.Row.FindControl("hnd_Del_Status");
    //        Label lbl_status = (Label)e.Row.FindControl("lbl_cancelled");
    //        Label lbl_DelStatus = (Label)e.Row.FindControl("lbl_DelStatus");

    //        if (hnd_Status.Value.ToString() == "0")
    //        {
    //            lbl_status.Text = "Submit";
    //            lbl_status.ForeColor = Color.Green;
    //        }
    //        if (hnd_Status.Value.ToString() == "1")
    //        {
    //            lbl_status.ForeColor = Color.Green;
    //            lbl_status.Text = "Submit";
    //        }
    //        if (hnd_Status.Value.ToString() == "2")
    //        {
    //            lbl_status.ForeColor = Color.Red;

    //            lbl_status.Text = "Cancelled";
    //            e.Row.ForeColor = System.Drawing.Color.Red;
    //            e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#ffdadc");
    //        }

    //        if (hnd_Del_Status.Value == "1")
    //        {
    //            lbl_DelStatus.Text = "Delivered";
    //            lbl_DelStatus.ForeColor = Color.Green;
    //        }
    //        else
    //        {
    //            lbl_DelStatus.Text = "Pending";
    //            lbl_DelStatus.ForeColor = Color.Red;
    //        }

    //    }
    //}
    //protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    //{ }
    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}


    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        BindGrid();
    //        GridView1.Columns[39].Visible = false;
    //        Response.Clear();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stocktranlist.xls");
    //        Response.Charset = "";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        this.GridView1.RenderControl(htmlWrite);
    //        Response.Write(stringWrite.ToString());
    //        Response.End();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Can't export as no data found.");
    //    }
    //}
    //protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        BindGrid();
    //        GridView1.Columns[38].Visible = false;
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stockinhand.doc");
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        this.GridView1.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}
}