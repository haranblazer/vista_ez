using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Xml.Linq;
using System.Xml;
using System.Globalization;
using System.Threading;
using System.Web.Services;

public partial class TranStock : System.Web.UI.Page, ICallbackEventHandler
{
    DataUtility objDUT;
    SqlConnection con = null;
    SqlDataAdapter DaProduct;
    SqlCommand com = null;
    utility objUtil = null;
    string strajax = string.Empty;
    DataTable dt = null, dt1 = null;
    double grosstotal = 0;
    double Total = 0;
    double DelCharge = 0;
    double Discount = 0;
    double NetAmt = 0;
    double amt = 0;
    int TotalQnty = 0;
    double TotalTaxPer = 0;
    double TotalTaxRs = 0;
    double TotalDP = 0;
    double TotalBV = 0;
    string invoiceDate = string.Empty, strOffer;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (payoutdate() == false)
            {
                Response.Redirect("Maintainance.aspx", false);
                return;
            }
            if (checkowner() == false)
            {
                Response.Redirect("welcome.aspx", false);
                return;
            }
            string str;
            str = Session["admin"].ToString();
            if (str == "")
            {
                Response.Redirect("adminLog.aspx");
            }
            lblMsg.Text = string.Empty;

            if (!Page.IsPostBack)
            {
                divbind.Visible = false;

                txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

                if (Request.QueryString["id"] != null)
                {
                    BindForPrint(Request.QueryString["id"] == null ? "" : Request.QueryString["id"].ToString());
                }
                else
                {
                    Session["CheckRefresh"] = System.DateTime.Now.ToString();
                    txtUserDisp.Text = Request.QueryString["i"] == null ? "" : Request.QueryString["i"].ToString();
                    txtUserId.Text = txtUserDisp.Text;
                    txtUserName.Text = Request.QueryString["n"] == null ? "" : Request.QueryString["n"].ToString();
                    lblOrderNO.Text = Request.QueryString["s"] == null ? "" : "Order No: " + Request.QueryString["s"].ToString();
                    lblp.Text = " ( " + Session["admin"].ToString().ToUpper() + " )";
                }
                int orderNo = Convert.ToInt32(Request.QueryString["s"] == null ? "0" : Request.QueryString["s"].ToString());
                BindCompanyDetail(orderNo);
                nextbill.Visible = false;
            }
            string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
            StringBuilder newFunction = new StringBuilder("function ServerSendValue(arg,ctx){" + js + "}");
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);
        }
        catch
        {
        }
    }

    private void BindForPrint(string billId)
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlDataAdapter adapter = new SqlDataAdapter("select (select name from controlmst where srno=b.SalesRepId) as Name,(select city from controlmst where srno=b.SalesRepId) as City, b.Quantity,b.srno as invoice,b.orderno,b.SalesRep,a.UserName,a.FName,b.Amount as total,b.TaxRs,TotalDp,TotalBV,b.DelCharge,b.Discount,a.tinno,a.panno,b.ToAddress as address1," +
                    "CONVERT(varchar,b.Doe,103) as bildate,b.GrossAmt as gross,b.NetAmt,b.detail from StockMst b inner join Franchisemst a on b.appmstid=a.FranchiseID where b.srno =@id ", con);
            adapter.SelectCommand.Parameters.AddWithValue("@id", billId);
            dt = new DataTable();
            adapter.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                invoiceDate = dt.Rows[0]["bildate"].ToString();
                txtUserId.Text = dt.Rows[0]["UserName"].ToString();
                txtUserDisp.Text = dt.Rows[0]["UserName"].ToString();
                txtUserName.Text = dt.Rows[0]["FName"].ToString();
                lblTotalPy.Text = lblAmt.Text = txtNetAmt.Text = double.Parse(dt.Rows[0]["NetAmt"].ToString()).ToString("#0.00");
                Label1.Text = txtTax.Text = double.Parse(dt.Rows[0]["TaxRs"].ToString()).ToString("#0.00");
                CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
                TextInfo textInfo = cultureInfo.TextInfo;
                lblAmtWord.Text = textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(double.Parse(txtNetAmt.Text.Trim())))) + " Only";
                lblDelChrg.Text = (double.Parse(dt.Rows[0]["total"].ToString()) * Convert.ToDouble(dt.Rows[0]["DelCharge"].ToString()) / 100).ToString("#0.00");
                lblDiscount.Text = (double.Parse(dt.Rows[0]["total"].ToString()) * Convert.ToDouble(dt.Rows[0]["Discount"].ToString()) / 100).ToString("#0.00");
                lblGrossTotal.Text = double.Parse(dt.Rows[0]["gross"].ToString()).ToString("#0.00");
                lblInvoiceNo.Text = dt.Rows[0]["invoice"].ToString();
                lblOrderNO.Text = dt.Rows[0]["orderno"].ToString();



                //lblPanNoF.Text = dt.Rows[0]["panno"].ToString();
                //lblTinNoF.Text = dt.Rows[0]["tinno"].ToString();
                lblToAdd.Text = dt.Rows[0]["address1"].ToString();
                lblTotalBV.Text = double.Parse(dt.Rows[0]["TotalBV"].ToString()).ToString("#0.00");
                DataTable dt_temp = new DataTable();
                dt_temp = CreateStructure().Clone();
                //Start of creating datatable for the products
                XElement objXml = XElement.Parse(dt.Rows[0]["detail"].ToString());
                //add 10 default row
                DataRow row = null;
                double tt = 0, dd = 0, tot = 0, rr = 0;
                foreach (XElement p in objXml.Elements("P"))
                {
                    //TAX
                    row = dt_temp.NewRow();
                    //row["code"]
                    row["dis"] = p.Elements("dis").FirstOrDefault() != null ? p.Elements("dis").FirstOrDefault().Value : string.Empty;
                    row["cd"] = p.Elements("cd").FirstOrDefault() != null ? p.Elements("cd").FirstOrDefault().Value : string.Empty;
                    row["pname"] = p.Elements("pname").FirstOrDefault() != null ? p.Elements("pname").FirstOrDefault().Value : string.Empty;
                    row["quantity"] = p.Elements("Qnt").FirstOrDefault() != null ? p.Elements("Qnt").FirstOrDefault().Value : string.Empty;
                    row["DPWT"] = p.Elements("MRP").FirstOrDefault() != null ? p.Elements("MRP").FirstOrDefault().Value : string.Empty;
                    row["BV"] = p.Elements("BV").FirstOrDefault() != null ? p.Elements("BV").FirstOrDefault().Value : string.Empty;
                    row["total"] = p.Elements("total").FirstOrDefault() != null ? p.Elements("total").FirstOrDefault().Value : string.Empty;
                    row["Tax"] = p.Elements("TAX").FirstOrDefault() != null ? p.Elements("TAX").FirstOrDefault().Value : string.Empty;
                    row["TaxRs"] = p.Elements("TAXRS").FirstOrDefault() != null ? p.Elements("TAXRS").FirstOrDefault().Value : string.Empty;
                    row["DP"] = p.Elements("DP").FirstOrDefault() != null ? p.Elements("DP").FirstOrDefault().Value : string.Empty;
                    tt = Convert.ToDouble(row["DPWT"].ToString()) * Convert.ToDouble(row["quantity"].ToString()) - Convert.ToDouble(row["dis"].ToString());
                    row["val"] = tt;
                    dt_temp.Rows.Add(row);
                    tot += tt;
                    dd += Convert.ToDouble(row["dis"].ToString());
                    rr += Convert.ToDouble(row["TaxRs"].ToString());
                }
                //End of creating datatable for the products
                GridView1.DataSource = dt_temp;
                GridView1.DataBind();
                ((Label)GridView1.FooterRow.FindControl("lblTaxRsTtotal")).Text = Math.Round(rr).ToString("#0.00");
                ((Label)GridView1.FooterRow.FindControl("lblDistotal")).Text = Math.Round(dd).ToString("#0.00");
                ((Label)GridView1.FooterRow.FindControl("lblValtotal")).Text = Math.Round(tot).ToString("#0.00");
                ((Label)GridView1.FooterRow.FindControl("lblQtotal")).Text = double.Parse(dt.Rows[0]["Quantity"].ToString()).ToString("#0.00");
                ((Label)GridView1.FooterRow.FindControl("lblTotal")).Text = double.Parse(dt.Rows[0]["total"].ToString()).ToString("#0.00");
            }
            //make the textBoxes read only to get print out
            MakeReadOnly();
        }
        catch (Exception ex)
        {
        }
    }
    private DataTable CreateStructure()
    {
        DataTable dt_temp = new DataTable();
        //dt.Load(reader);
        DataColumn column = new DataColumn("id", typeof(Int32));
        column.DataType = System.Type.GetType("System.Int32");
        column.AutoIncrement = true;
        column.AutoIncrementSeed = 1;
        column.AutoIncrementStep = 1;
        dt_temp.Columns.Add(column);
        DataColumn dcpnmae = new DataColumn("pname", typeof(string));
        dcpnmae.DefaultValue = string.Empty;
        dt_temp.Columns.Add(dcpnmae);
        DataColumn dcMRP = new DataColumn("DPWT", typeof(float));
        dcMRP.DefaultValue = 0;
        dt_temp.Columns.Add(dcMRP);
        DataColumn code = new DataColumn("cd", typeof(string));
        code.DefaultValue = "";
        dt_temp.Columns.Add(code);
        DataColumn val = new DataColumn("val", typeof(float));
        val.DefaultValue = 0;
        dt_temp.Columns.Add(val);
        DataColumn discount = new DataColumn("Dis", typeof(float));
        discount.DefaultValue = 0;
        dt_temp.Columns.Add(discount);
        DataColumn dcTax = new DataColumn("Tax", typeof(float));
        dcTax.DefaultValue = 0;
        dt_temp.Columns.Add(dcTax);
        DataColumn dcTaxRs = new DataColumn("TaxRs", typeof(float));
        dcTaxRs.DefaultValue = 0;
        dt_temp.Columns.Add(dcTaxRs);
        DataColumn dcDP = new DataColumn("DP", typeof(float));
        dcDP.DefaultValue = 0;
        dt_temp.Columns.Add(dcDP);
        DataColumn dcBV = new DataColumn("BV", typeof(float));
        dcBV.DefaultValue = 0;
        dt_temp.Columns.Add(dcBV);
        DataColumn dc = new DataColumn("quantity", typeof(int));
        dc.DefaultValue = 0;
        dt_temp.Columns.Add(dc);
        DataColumn total = new DataColumn("total", typeof(double));
        total.DefaultValue = 0;
        dt_temp.Columns.Add(total);
        DataColumn MaxAllowed = new DataColumn("MaxAllowed", typeof(double));
        MaxAllowed.DefaultValue = 0;
        dt_temp.Columns.Add(MaxAllowed);
        DataColumn Qty = new DataColumn("Qty", typeof(double));
        Qty.DefaultValue = 0;
        dt_temp.Columns.Add(Qty);
        DataColumn gross = new DataColumn("gtotal", typeof(double));
        gross.DefaultValue = 0;
        dt_temp.Columns.Add(gross);
        return dt_temp;
    }
    private void BindUserID()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {
            DataTable dtt = new DataTable();
            da = new SqlDataAdapter("select franchiseid as UserName from Franchisemst", con);
            da.Fill(dtt);

            List<string> objProductList = new List<string>(); ;
            String strPrdPrice = string.Empty;
            divUserID.InnerText = string.Empty;
            foreach (DataRow drw in dtt.Rows)
            {
                divUserID.InnerText += drw["UserName"].ToString() + ",";
            }
        }
        catch
        {
        }
        finally
        {
        }
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (updateQuantity(string.Empty))
            {
                int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
                DataTable dt = null;
                if (ViewState["product"] != null)
                    dt = (DataTable)ViewState["product"];
                if (dt != null)
                {
                    dt.Rows.Remove(dt.Select().Where(o => o.Field<int>("id") == id).FirstOrDefault());
                    dt.AcceptChanges();
                }
                ViewState["product"] = dt;
                BindGrid();
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
        }
    }

    /// <summary>
    /// This method is used to generate the bill.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnGenerateBill_Click(object sender, EventArgs e)
    {
        btnGenerateBill.Enabled = false;
        
        int orderNo = Convert.ToInt32(Request.QueryString["s"] == null ? "0" : Request.QueryString["s"].ToString());
        BindCompanyDetail(orderNo);
        if (string.IsNullOrEmpty(txtUserId.Text.Trim()))
        {
            lblMsg.Text = "Enter Franchise ID.";
            return;
        }
        if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();

            dt = (DataTable)ViewState["product"];
            if (updateQuantity(string.Empty))
            {
                string strReturn = SaveDetail();
                if (strReturn == "1")
                {
                    MakeReadOnly();
                }
                else
                    lblMsg.Text = strReturn;
            }
        }
    }



    private void MakeReadOnly()
    {
        //Disable textBox of quantity
        //set visible false of delete column
        GridView1.Columns[11].Visible = false;
        GridView1.Columns[12].Visible = false;
        divOffer.Visible = false;
        ((ImageButton)GridView1.FooterRow.FindControl("btnNewRow")).Visible = false;
        btnGenerateBill.Visible = false;

        foreach (GridViewRow row in GridView1.Rows)
        {

            TextBox txtDis = (TextBox)row.Cells[5].FindControl("txtDis");
            TextBox txtProduct = (TextBox)row.Cells[2].FindControl("txtProductNAme");
            TextBox txtQuantity = (TextBox)row.Cells[4].FindControl("txtQuantity");
            txtQuantity.ReadOnly = true;
            txtQuantity.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
            txtQuantity.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");
            txtQuantity.Attributes.Add("onchange", "javascript:void");

            txtProduct.ReadOnly = true;
            txtProduct.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
            txtProduct.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");
            txtProduct.Attributes.Add("onblur", "javascript:void");


            txtDis.ReadOnly = true;
            txtDis.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
            txtDis.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");
            txtDis.Attributes.Add("onblur", "javascript:void");
        }

        trbank.Attributes["display"] = "none";

        txtDelChrg.ReadOnly = true;
        txtDelChrg.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        txtDelChrg.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        ddlpaytype.Enabled = false;
        ddlpaytype.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        ddlpaytype.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        txtDiscount.ReadOnly = true;
        txtDiscount.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        txtDiscount.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        txtNetAmt.ReadOnly = true;
        txtNetAmt.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        txtNetAmt.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        txtUserId.ReadOnly = true;
        txtUserId.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        txtUserId.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");
        //objUtil =new utility();

        txtDelChrg.Visible = false;
        txtDiscount.Visible = false;
        nextbill.Visible = true;
    }


    private string SaveDetail()
    {
        string status = string.Empty;
        dt = (DataTable)ViewState["product"];
        DataTable tempDt = new DataTable();
        DateTime fromDate = new DateTime();
        DataTable Pbatch = null;
        tempDt = dt.Copy();
        try
        {
            if (ddlpaytype.SelectedIndex > 0)
            {
                System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
                dateInfo.ShortDatePattern = "dd/MM/yyyy";
                fromDate = Convert.ToDateTime(txtDate.Text.Trim(), dateInfo);
            }
            else
            {
                fromDate = DateTime.Now;
                txtbname.Text = "";
                txtDD.Text = "";
            }
        }
        catch
        {
        }
        if (tempDt != null)
        {

            //make xml node and calculate amount
            string ss = "SELECT city, State=(select State from FranchiseMst WHERE FranchiseId ='" + txtUserId.Text.Trim() + "') from controlmst WHERE username ='" + Session["admin"].ToString() + "'";
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand(ss, con);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dtc = new DataTable();
            adp.Fill(dtc);
            //string ss1 = "select State from FranchiseMst WHERE FranchiseId ='" + txtUserId.Text.Trim() + "'";
            //con = new SqlConnection(method.str);
            //SqlCommand cmd1 = new SqlCommand(ss1, con);
            //SqlDataAdapter adp1 = new SqlDataAdapter(cmd1);
            //DataTable dta = new DataTable();
            //adp1.Fill(dta);


            XElement element = null;
            List<DataRow> objRows = tempDt.AsEnumerable().Where(o => string.IsNullOrEmpty(o.Field<string>("pname")) || o.Field<int>("quantity") == 0).ToList();
            foreach (DataRow row in objRows)
            {
                tempDt.Rows.Remove(row);
                tempDt.AcceptChanges();
            }
            if (tempDt.Rows.Count > 0)
            {
                element = new XElement("Bill");
                foreach (DataRow row in tempDt.AsEnumerable().Where(o => !string.IsNullOrEmpty(o.Field<string>("pname")) && o.Field<int>("quantity") > 0).CopyToDataTable().Rows)
                {

                    if (row["pname"].ToString().Trim().Length > 0 && Convert.ToInt32(string.IsNullOrEmpty(row["quantity"].ToString().Trim()) ? "0" : row["quantity"].ToString().Trim()) > 0)
                    {
                        Pbatch = (DataTable)ViewState["adminproduct"];
                        string batchid = (Pbatch.AsEnumerable().Where(p => p["ProductName"].ToString() == row["pname"].ToString()).Select(p => p["batchid"].ToString())).FirstOrDefault();
                        var taxval = (double.Parse(row["Val"].ToString()) * double.Parse(row["Tax"].ToString()) / 100);
                        //GST BY RAGH START 16/07/2019 

                        float itax = 0, taxi = 0, ctax = 0, taxc = 0, stax = 0, taxs = 0;
                        string buyerstate = dtc.Rows[0]["State"].ToString().ToUpper();
                        string sellerstate = dtc.Rows[0]["city"].ToString().ToUpper();

                        if (sellerstate.ToUpper().Trim() == sellerstate.ToUpper().Trim())
                        {
                            itax = Convert.ToSingle(row["Tax"].ToString());
                            taxi = 0;
                            ctax = Convert.ToSingle(row["Tax"].ToString()) / 2;
                            taxc = (Convert.ToSingle(row["DPWT"].ToString()) * Convert.ToSingle(row["quantity"].ToString())) * (ctax / 100);
                            taxc = Convert.ToSingle(Math.Round(taxc, 2));
                            stax = Convert.ToSingle(row["Tax"].ToString()) / 2;
                            taxs = (Convert.ToSingle(row["DPWT"].ToString()) * Convert.ToSingle(row["quantity"].ToString())) * (stax / 100);
                            taxs = Convert.ToSingle(Math.Round(taxs, 2));
                        }
                        else
                        {
                            itax = Convert.ToSingle(row["Tax"].ToString());
                            taxi = (Convert.ToSingle(row["DPWT"].ToString()) * Convert.ToSingle(row["quantity"].ToString())) * (itax / 100);
                            taxi = Convert.ToSingle(Math.Round(taxi, 2));
                            ctax = Convert.ToSingle(row["Tax"].ToString()) / 2;
                            taxc = 0;
                            stax = Convert.ToSingle(row["Tax"].ToString()) / 2;
                            taxs = 0;
                        }
                        XElement prdXml = new XElement("P",
                      new XElement("pname", row["pname"].ToString()),
                      new XElement("cd", row["cd"].ToString()),
                      new XElement("dis", row["dis"].ToString()),
                      new XElement("Qnt", row["quantity"].ToString()),
                       new XElement("MRP", row["DPWT"].ToString()),
                       new XElement("TAX", row["Tax"].ToString()),
                       new XElement("TAXRS", row["TaxRs"].ToString()),
                       new XElement("DP", row["DP"].ToString()),
                        new XElement("BV", row["BV"].ToString()),

                           new XElement("total", Math.Round(Convert.ToDouble(row["total"]), 2)),
                        new XElement("batchid", batchid),
                            new XElement("IGST", itax),
                            new XElement("IGSTRS", taxi),
                            new XElement("CGST", ctax),
                            new XElement("CGSTRS", taxc),
                            new XElement("SGST", stax),
                            new XElement("SGSTRS", taxs)
                            );
                        element.Add(prdXml);
                    }
                }
                amt = double.Parse(dt.Compute("sum(total)", "true").ToString().Trim());
                grosstotal = double.Parse(dt.Compute("sum(gtotal)", "true").ToString().Trim());
                CalculateTotal(tempDt);
                CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
                TextInfo textInfo = cultureInfo.TextInfo;
                lblAmtWord.Text = textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(NetAmt)).ToUpperInvariant()) + " Only";
            }
            if (ddldistrimode.SelectedValue == "2")
            {
            }
            //other
            else
            {
                if (element == null || amt == 0)
                {
                    BindGrid();
                    return "Please eneter the product and quantity properly.";
                }
            }
            var xmlObject = new XmlDocument();
            xmlObject.LoadXml(element.ToString());
            con = new SqlConnection(method.str);
            com = new SqlCommand("StockTransfer", con);
            com.CommandType = CommandType.StoredProcedure;
            //com.Parameters.AddWithValue("@regno", txtUserId.Text.Trim());
            com.Parameters.AddWithValue("@count", tempDt.Rows.Count);
            com.Parameters.AddWithValue("@amt", amt);
            com.Parameters.AddWithValue("@gross", grosstotal);
            com.Parameters.AddWithValue("@Qnty", TotalQnty);
            //com.Parameters.AddWithValue("@ToalTaxPer", TotalTaxPer);
            com.Parameters.AddWithValue("@TotalTaxRs", TotalTaxRs);
            com.Parameters.AddWithValue("@TotalDP", TotalDP);
            com.Parameters.AddWithValue("@TotalBV", TotalBV);
            com.Parameters.AddWithValue("@delChrg", DelCharge);
            com.Parameters.AddWithValue("@disAmt", Discount);
            com.Parameters.AddWithValue("@NetAmt", NetAmt);
            com.Parameters.AddWithValue("@soldTo", txtUserId.Text.Trim());
            com.Parameters.AddWithValue("@saleRep", Session["admin"].ToString());
            com.Parameters.AddWithValue("@toAdd", lblToAdd.Text);
            //com.Parameters.AddWithValue("@offId", 0);
            com.Parameters.AddWithValue("@bankname", txtbname.Text);
            com.Parameters.AddWithValue("@checkdate", fromDate);
            com.Parameters.AddWithValue("@checkno", txtDD.Text);
            com.Parameters.AddWithValue("@paymode", ddlpaytype.SelectedItem.Text);
           // com.Parameters.AddWithValue("@taxtype", 1);
            com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
            com.Parameters.AddWithValue("@orderno", lblOrderNO.Text.Trim());
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.CommandTimeout = 1900;
            com.ExecuteNonQuery();
            status = com.Parameters["@flag"].Value.ToString();
            string invoiceNo = com.Parameters["@InvNo"].Value.ToString();
            if (status == "1")
            {
                //UpdateStock(tempDt);
                //ViewState["product"] = tempDt;
               // ViewState["billstatus"] = "1";
               // lblInvoiceNo.Text = invoiceNo;
                Response.Redirect("StockTranBill.aspx?inv=" + invoiceNo);
                //Response.Redirect("StockPrintBill.aspx?id=" + invoiceNo + "&st=" + 1 + "&ttype=" + ddldistributor.SelectedValue.ToString());
            }
            else
            {
                utility.MessageBox(this, status);
            }

        }
        else
            lblMsg.Text = "Please enter some product names.";
        return status;
    }
    private void BindCompanyDetail(int orderNo)
    {
        con = new SqlConnection(method.str);
        try
        {
            com = new SqlCommand("select (select top 1 logoimg from BillSetting) as logoURL, city, companyname,[address] as caddress,(case when @ordId>0 then (select ToAddress  from OrderMst where srno=@ordId) else (select address from franchisemst where FranchiseId=@regno) end) as orAddress,phone,11 as InvNo,convert(varchar,DATEADD(MINUTE,330,GETUTCDATE()),103) as cdate,(select panno from franchisemst where FranchiseId=@regno) as FPanNo,(select tinno from franchisemst where FranchiseId=@regno) as FTinNo," +
            "(select name from controlmst  where username=@uname) as SalesRep,(select city from controlmst  where username=@uname) as Scity,(select top 1 tax from BillSetting) as tax, (select top 1 cinno from paymentmst) as cinno,  (select top 1 panno from paymentmst) as panno," +
            "(select top 1 delivery from BillSetting) as delivery,(select top 1 Discount from BillSetting) as Discount,website,emailid,TinNo,GST from PaymentMst ", con);
            //pass session id
            com.Parameters.AddWithValue("@uname", Session["admin"].ToString());
            com.Parameters.AddWithValue("@ordId", orderNo);
            com.Parameters.AddWithValue("@regno", txtUserId.Text.Trim());
            con.Open();
            SqlDataReader reader = com.ExecuteReader();
            if (reader.HasRows)
            {
                reader.Read();
                lblComName.Text = reader["companyname"].ToString();
                lblCityDisplay.Text = reader["city"].ToString();
                lblGST.Text = reader["GST"].ToString();
                lblcinno.Text = reader["cinno"].ToString();
                lblpan.Text = reader["panno"].ToString();
                lblCompName.Text = lblComName.Text;
                lblCity.Text = reader["city"].ToString();
                lblCity2.Text = reader["city"].ToString();
                if (Request.QueryString["id"] == null)
                    lblToAdd.Text = reader["orAddress"].ToString();
                //lblPanNoF.Text =  reader["Fpanno"].ToString();
                //lblTinNoF.Text =  reader["Ftinno"].ToString();
                imgLogo.ImageUrl = "../images/" + reader["logoURL"].ToString();
                lblLeftHead.Text = string.Empty;
                int i = 0;
                foreach (string add in reader["caddress"].ToString().Split(','))
                {
                    lblLeftHead.Text += add + ",";
                    if (i == 1)
                        lblLeftHead.Text += "";
                    i++;
                }
                lblLeftHead.Text += "</br>Tel : " + reader["phone"].ToString();
                lblLeftHead.Text += "</br> Email : " + reader["emailid"].ToString();
                //right heade
                //lblRightHead.Text = reader["InvNo"].ToString();
                lblRightHead.Text = string.Empty;
                lblRightHead.Text += "" + (Request.QueryString["id"] != null ? invoiceDate : reader["cdate"].ToString());
                lblBillFooter.Text = "THANKS FOR YOUR BUSINESS!";
                if (!IsPostBack && Request.QueryString["id"] == null)
                {
                    txtDelChrg.Text = reader["delivery"].ToString().Trim();
                    txtDiscount.Text = reader["Discount"].ToString().Trim();
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Try again.";
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
    #region (ICallbackEventHandlar Methods..)
    public string GetCallbackResult()
    {
        return strajax;
    }
    public void RaiseCallbackEvent(string eventArguments)
    {
        if (eventArguments != "")
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand();
            SqlDataReader dr;
            cmd.CommandText = "select FName as name, frantype, SampleAllowed from franchiseMst  where franchiseid=@regno";
            cmd.Parameters.AddWithValue("@regno", eventArguments.Trim());
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                strajax = Convert.ToString(dr["name"]);
                Session["sname"] = Convert.ToString(dr["name"]);
              //  Session["frantype"] = Convert.ToString(dr["frantype"]);
                // Session["SampleAllowed"] = Convert.ToString(dr["SampleAllowed"]);

            }
            else
            {
                strajax = "User Does Not Exists!";
            }

            dr.Close();
            con.Close();
        }
        else
        {
            strajax = "Required field cannot be blank !";
        }
    }
    #endregion
    private bool updateQuantity(string ProductName)
    {
        bool status = true;
        List<string> objlist = new List<string>();
        if (ViewState["product"] != null)
        {
            dt = (DataTable)ViewState["product"];
        }
        if (dt != null)
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                TextBox txtQuantity = (TextBox)row.Cells[2].FindControl("txtQuantity");
                string strProduct = ((TextBox)row.Cells[1].FindControl("txtProductNAme")).Text;
                string text = string.IsNullOrEmpty(txtQuantity.Text.Trim()) ? "0" : txtQuantity.Text.Trim();
                objUtil = new utility();
                if (!objUtil.IsNumeric(text))
                {
                    lblMsg.Text = "Invalid Quantity value: '" + txtQuantity.Text + "' entered. for the product: '" + strProduct + "'";
                    status = false;
                    return status;
                }
                else if (!string.IsNullOrEmpty(strProduct) && !IsProductExists(strProduct))
                {
                    lblMsg.Text = "Product named: '" + strProduct + "' not exists";
                    status = false;
                    return status;
                }
                else if (!string.IsNullOrEmpty(strProduct) && IsProductExists(strProduct))
                {
                    if (objlist.Where(o => o == strProduct).FirstOrDefault() != null && objlist.Where(o => o == strProduct).FirstOrDefault().Length > 0)
                    {
                        lblMsg.Text = "Product named: '" + strProduct + "' exists multiple times";
                        status = false;
                        return status;
                    }
                    else
                        objlist.Add(strProduct);
                }
                //{
                //    con.Close();
                //    con.Dispose();
                //}

                foreach (DataRow drow in dt.Rows)
                {
                    if (drow["id"].ToString() == GridView1.DataKeys[row.DataItemIndex].Values[0].ToString())
                    {
                        TextBox MRP = (TextBox)row.Cells[3].FindControl("txtDPWT");
                        TextBox Tax = (TextBox)row.Cells[7].FindControl("txtTax");

                        TextBox BV = (TextBox)row.Cells[9].FindControl("txtBV");
                        TextBox cd = (TextBox)row.Cells[1].FindControl("txtcode");
                        TextBox val = (TextBox)row.Cells[6].FindControl("txtval");
                        TextBox dis = (TextBox)row.Cells[9].FindControl("txtDis");
                        float mrp = float.Parse(string.IsNullOrEmpty(MRP.Text.Trim()) ? "0" : MRP.Text.Trim());
                        double taxRs = 0.0;
                        if (!string.IsNullOrEmpty(text))
                        {
                            double taxValue = double.Parse(string.IsNullOrEmpty(Tax.Text.Trim()) ? "0" : Tax.Text.Trim());
                            taxRs = (mrp * taxValue / 100) * Convert.ToInt32(text);
                            //if Same product is added then increment the quantity value txtMRP
                            drow.BeginEdit();
                            drow["Dis"] = dis.Text;
                            drow["quantity"] = Convert.ToInt32(text);
                            drow["DPWT"] = mrp;
                            drow["cd"] = cd.Text;
                            drow["val"] = (mrp * Convert.ToInt32(text) - Convert.ToDouble(dis.Text)).ToString();
                            drow["Tax"] = float.Parse(string.IsNullOrEmpty(Tax.Text.Trim()) ? "0" : Tax.Text.Trim());
                            drow["TaxRs"] = taxRs.ToString("#0.00");
                            //drow["DP"] = float.Parse(string.IsNullOrEmpty(DP.Text.Trim()) ? "0" : DP.Text.Trim());
                            drow["BV"] = float.Parse(string.IsNullOrEmpty(BV.Text.Trim()) ? "0" : BV.Text.Trim());
                            drow["pname"] = strProduct;
                            drow.EndEdit();
                        }
                        //Recalculate total column
                        drow["gtotal"] = Convert.ToDouble(string.IsNullOrEmpty(drow["quantity"].ToString()) ? "0" : drow["quantity"].ToString()) * Convert.ToDouble(string.IsNullOrEmpty(drow["DPWT"].ToString()) ? "0" : drow["DPWT"].ToString()) - Convert.ToDouble(dis.Text);
                        drow["total"] = taxRs + Convert.ToDouble(string.IsNullOrEmpty(drow["DPWT"].ToString()) ? "0" : drow["DPWT"].ToString()) * Convert.ToDouble(string.IsNullOrEmpty(drow["quantity"].ToString()) ? "0" : drow["quantity"].ToString()) - Convert.ToDouble(dis.Text);
                    }
                }
            }

            ViewState["product"] = dt;

        }
        return status;
    }
    private bool IsProductExists(string pname)
    {
        bool Status = false;
        List<string> objList = (List<string>)ViewState["pname"];
        if (objList.Where(o => o == pname).FirstOrDefault() != null && objList.Where(o => o == pname).FirstOrDefault().Length > 0)
            Status = true;
        else
            Status = false;
        return Status;
    }
    private void BindGrid()
    {
        if (ViewState["product"] != null)
            dt = (DataTable)ViewState["product"];
        if (dt == null)
        {
            dt = CreateStructure().Clone();
            //add 10 default row
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            ViewState["product"] = dt;
        }
        GridView1.DataSource = dt;
        GridView1.DataBind();
        CalculateTotal(dt);
    }
    private void CalculateTotal(DataTable dtt)
    {
        if (dtt != null && dtt.Rows.Count > 0)
        {
            TotalBV = 0;
            TotalDP = 0;
            TotalTaxRs = 0;
            TotalTaxPer = 0;
            ((Label)GridView1.FooterRow.FindControl("lblQtotal")).Text = double.Parse(dtt.Compute("sum(quantity)", "true").ToString().Trim()).ToString("#0.00");
            Total = double.Parse(dt.Compute("sum(val)", "true").ToString().Trim());

            ((Label)GridView1.FooterRow.FindControl("lblTotal")).Text = Math.Round(Total).ToString("#0.00");
            grosstotal = double.Parse(dtt.Compute("sum(gtotal)", "true").ToString().Trim());
            lblGrossTotal.Text = grosstotal.ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblDistotal")).Text = double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim()).ToString("#0.00");
            txtDiscount.Text = double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim()).ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblValtotal")).Text = double.Parse(dtt.Compute("sum(val)", "true").ToString().Trim()).ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblTaxRsTtotal")).Text = double.Parse(dtt.Compute("sum(TaxRs)", "true").ToString().Trim()).ToString("#0.00");
            int qnt = 0;
            foreach (DataRow row in dtt.Rows)
            {
                qnt = Convert.ToInt32(string.IsNullOrEmpty(row["quantity"].ToString()) ? "0" : row["quantity"].ToString());
                TotalQnty += qnt;
                TotalTaxPer += Convert.ToDouble(string.IsNullOrEmpty(row["Tax"].ToString()) ? "0" : row["Tax"].ToString());
                TotalTaxRs += Convert.ToDouble(string.IsNullOrEmpty(row["TaxRs"].ToString()) ? "0" : row["TaxRs"].ToString());
                double DP = Convert.ToDouble(string.IsNullOrEmpty(row["DP"].ToString()) ? "0" : row["DP"].ToString());
                double BV = Convert.ToDouble(string.IsNullOrEmpty(row["BV"].ToString()) ? "0" : row["BV"].ToString());
                double price = Convert.ToDouble(string.IsNullOrEmpty(row["DPWT"].ToString()) ? "0" : row["DPWT"].ToString());

                TotalBV += (qnt * BV);
                TotalDP += (qnt * price);
            }
            Total += TotalTaxRs;
            Label1.Text = TotalTaxRs.ToString();
            ((Label)GridView1.FooterRow.FindControl("lblTotal")).Text = Total.ToString("#0.00");
            lblTotalBV.Text = TotalBV.ToString();
            txtTax.Text = TotalTaxRs.ToString("#0.00");
            DelCharge = double.Parse(string.IsNullOrEmpty(txtDelChrg.Text.Trim()) ? "0" : txtDelChrg.Text.Trim());
            Discount = double.Parse(string.IsNullOrEmpty(txtDiscount.Text.Trim()) ? "0" : txtDiscount.Text.Trim());
            lblDelChrg.Text = (Total * DelCharge / 100).ToString("#0.00");
            lblDiscount.Text = Discount.ToString();
            lblDiscount.Text = "0";
            Discount = 0;
            NetAmt = grosstotal + (grosstotal * DelCharge / 100) - (grosstotal * Discount / 100);
            NetAmt += TotalTaxRs;
            txtNetAmt.Text = Convert.ToInt32(Math.Round(NetAmt)).ToString("#0.00");
            lblAmt.Text = txtNetAmt.Text;
            lblTotalPy.Text = txtNetAmt.Text;

            CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
            TextInfo textInfo = cultureInfo.TextInfo;
            lblAmtWord.Text = textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(Math.Round(NetAmt)))) + " Only";
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex >= 0)
        {
            ((TextBox)e.Row.Cells[4].FindControl("txtQuantity")).Attributes.Add("onchange", "javascript:calculate(" + (e.Row.RowIndex + 2).ToString() + ",this)");
            ((TextBox)e.Row.Cells[2].FindControl("txtProductNAme")).Attributes.Add("onblur", "javascript:ShowMRP(" + (e.Row.RowIndex + 2).ToString() + ",this)");
            ((TextBox)e.Row.Cells[2].FindControl("txtcode")).Attributes.Add("onblur", "javascript:ShowMRPonPCode(" + (e.Row.RowIndex + 2).ToString() + ",this)");
            ((TextBox)e.Row.Cells[5].FindControl("txtDis")).Attributes.Add("onchange", "javascript:calculate(" + (e.Row.RowIndex + 2).ToString() + ",this)");
        }
    }
    protected void btnAddMore_Click(object sender, ImageClickEventArgs e)
    {
        //bind if grid view has valid entries
        if (updateQuantity(string.Empty))
        {
            if (ViewState["product"] != null)
            {
                dt = (DataTable)ViewState["product"];
                DataRow NewRow = dt.NewRow();
                NewRow["id"] = dt.Rows.Count + 1;
                dt.Rows.Add(NewRow);
                ViewState["product"] = dt;
            }
            BindGrid();
        }
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    protected void nextbill_Click(object sender, EventArgs e)
    {
        Response.Redirect("TranStock.aspx", false);
    }
    private void BindProduct(int type)
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        //ViewState["Count"] = null;
        try
        {
            DataTable dt = new DataTable();
            da = new SqlDataAdapter("bindadminproduct", con);
            da.SelectCommand.Parameters.AddWithValue("@adminid", Session["admin"].ToString());
            da.SelectCommand.Parameters.AddWithValue("@distype", 1);
            da.SelectCommand.Parameters.AddWithValue("@type", 1);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ViewState["adminproduct"] = dt;
                List<string> objProductList = new List<string>();
                String strPrdPrice = string.Empty;
                strPrdPrice += "<table id='tblMRP'>";
                divMRP.InnerHtml = string.Empty;
                divProduct.InnerText = string.Empty;
                divProductCode.InnerText = string.Empty;

                foreach (DataRow drw in dt.Rows)
                {

                    divProductCode.InnerText += drw["productid"].ToString() + ",";
                    divProduct.InnerText += drw["ProductName"].ToString() + ",";
                    strPrdPrice += "<tr><td>" + drw["ProductName"].ToString() + "</td><td>" + drw["DPWithTax"].ToString() + "</td><td>" + drw["Tax"].ToString() + "</td>" +
                        "<td>" + drw["DPAmt"].ToString() + "</td><td>" + drw["BV"].ToString() + "</td><td>" + drw["MaxAllowed"].ToString() + "</td></td><td>" + drw["productid"].ToString() + "</td><td>" + drw["QTY"].ToString() + "</td><td>" + drw["batchid"].ToString() + "</td></tr>";
                    objProductList.Add(drw["ProductName"].ToString());

                }
                strPrdPrice += "</table>";
                divMRP.InnerHtml = strPrdPrice;
                ViewState["pname"] = objProductList;
            }

        }
        catch
        {
        }
        finally
        {
        }
    }

    //public Boolean checkquantity()
    //{
    //    con = new SqlConnection(method.str);
    //    com = new SqlCommand("checkAdminquantity", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.Parameters.AddWithValue("@productid", Convert.ToInt32(ViewState["productid"].ToString()));
    //    com.Parameters.AddWithValue("@qty", Convert.ToInt32(ViewState["quantity"].ToString()));
    //    com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
    //    con.Open();
    //    com.ExecuteNonQuery();
    //    string status = com.Parameters["@flag"].Value.ToString();
    //    ViewState["msg"] = status;
    //    if (status != "1")
    //    {
    //        con.Close();
    //        return false;
    //    }
    //    else
    //    {
    //        con.Close();
    //    }
    //    return true;
    //}
    public string checkuser()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("checkfranchise", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@soldTo", txtUserId.Text.Trim());
        com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        com.Parameters.Add("@username", SqlDbType.VarChar, 300).Direction = ParameterDirection.Output;
        //  com.Parameters.Add("@mobile", SqlDbType.VarChar, 300).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        string status1 = com.Parameters["@flag"].Value.ToString();

        if (com.Parameters["@username"].Value.ToString() != "")
        {
            txtUserName.Text = com.Parameters["@username"].Value.ToString();
        }

        ViewState["checkuser"] = status1;
        con.Close();
        return status1;

    }
    protected void txtUserId_TextChanged(object sender, EventArgs e)
    {
        if (txtUserId.Text != "")
        {
            lblToAdd.Text = "";
            if (checkuser() == "1")
            {
                divbind.Visible = true;
                //BindDistributor("0");
                BindProduct(3);
                BindGrid();
                BindWallet(txtUserId.Text.Trim());
            }
            else
            {
                divbind.Visible = false;
                lblToAdd.Text = "";
                txtUserId.Text = "";
                txtUserDisp.Text = "";
                txtUserName.Text = "";
                GridView1.DataSource = null;
                GridView1.DataBind();
                utility.MessageBox(this, "Franchise ID is Not Valid");
            }
        }
        else
        {
            utility.MessageBox(this, "Plz Enter Franchise ID is Not Valid");
        }
    }
    public Boolean checkowner()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("checkowner", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", Session["admin"].ToString());
        com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        string status = com.Parameters["@flag"].Value.ToString();

        if (status == "0")
        {
            con.Close();

            return false;

        }

        else if (status == "1")
        {
            con.Close();

            return true;
        }

        else
        {
            con.Close();

        }
        return false;
    }
    public Boolean payoutdate()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("checkbillpayout", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@Master", "BILLSTATUS");
        com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        string status = com.Parameters["@flag"].Value.ToString();
        if (status == "0")
        {
            con.Close();
            return false;
        }
        else if (status == "1")
        {
            con.Close();
            return true;
        }
        else
        {
            con.Close();
        }
        return false;
    }

    //start 24/07/2019 ragh code
    private void BindWallet(string RegNo)
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("getwalletBalanceFran", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@appmstid", RegNo);
            com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            string Balance = com.Parameters["@Bal"].Value.ToString();
            lbl_UserWalletBalance.Text = Balance;
        }
        catch (Exception ex)
        {
        }
    }
    //[WebMethod]
    //public static string GenerateOTP(string UserName, string Amount)
    //{
    //    string Result = "0";
    //    DataTable dt = new DataTable();
    //    SqlConnection con = new SqlConnection(method.str);
    //    SqlDataAdapter da = new SqlDataAdapter();
    //    da = new SqlDataAdapter("GenerateOTP", con);
    //    da.SelectCommand.Parameters.AddWithValue("@RegNo", UserName);
    //    da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    da.Fill(dt);
    //    if (dt.Rows.Count > 0)
    //    {
    //        utility objUtil = new utility();
    //        string msg = "Dear User " + UserName.Trim() + " To Pay Rs. " + Amount.Trim() +
    //            " from your CJ Wallet use OTP. OTP is " + dt.Rows[0]["OTP"].ToString().Trim() +
    //            ". Don't share with anyone.";
    //        objUtil.SENDOTP(dt.Rows[0]["AppMstMobile"].ToString().Trim(), msg);

    //    }

    //    return Result;
    //}
    //[WebMethod]
    //public static string VerifyOTP(string UserName, string OTP)
    //{

    //    SqlConnection con = new SqlConnection(method.str);
    //    SqlCommand com = new SqlCommand("VerifyOTP", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.Parameters.AddWithValue("@RegNo", UserName);
    //    com.Parameters.AddWithValue("@OTP", OTP);
    //    com.Parameters.Add("@IsValid", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
    //    con.Open();
    //    com.ExecuteNonQuery();
    //    string Result = com.Parameters["@IsValid"].Value.ToString();
    //    return Result;
    //}
    public void BindPayType(string mode)
    {

        DataTable dt = new DataTable();
        dt.Columns.Add("Id", typeof(Int32));
        dt.Columns.Add("PAYTYPE", typeof(string));
        ddlpaytype.Items.Clear();
        if (mode.Trim() == "2")
        {
            dt.Rows.Add(1, "Free Sample");

            lblwallettxt.Visible = false;
            lbl_UserWalletBalance.Visible = false;
            divcoupon.Visible = false;

        }
        else
        {

            divcoupon.Visible = true;
            lblwallettxt.Visible = true;
            lbl_UserWalletBalance.Visible = true;

            dt.Rows.Add(2, "Cash");
            dt.Rows.Add(3, "Cheque");
            dt.Rows.Add(4, "Net Banking");
            dt.Rows.Add(5, "DD");
            dt.Rows.Add(1, "Wallet");
        }
        ddlpaytype.DataSource = dt;
        ddlpaytype.DataTextField = "PAYTYPE";
        ddlpaytype.DataValueField = "PAYTYPE";
        ddlpaytype.DataBind();

    }
    //public void BindDistributor(string SampleAllow)
    //{

    //    DataTable dt = new DataTable();
    //    dt.Columns.Add("Id", typeof(Int32));
    //    dt.Columns.Add("Distributor", typeof(string));
    //    ddldistrimode.Items.Clear();
    //    if (SampleAllow.Trim() == "1")
    //    {
    //        ddldistrimode.Items.Clear();
    //        dt.Rows.Add(1, "Stock Transfer");
    //        dt.Rows.Add(2, "Free Sample");

    //    }
    //    else
    //    {
    //        ddldistrimode.Items.Clear();
    //        dt.Rows.Add(1, "Stock Transfer");
    //    }
    //    ddldistrimode.DataSource = dt;
    //    ddldistrimode.DataTextField = "Distributor";
    //    ddldistrimode.DataValueField = "Id";
    //    ddldistrimode.DataBind();
    //    BindPayType(ddldistrimode.SelectedValue);

    //}
    protected void ddldistrimode_SelectedIndexChanged(object sender, EventArgs e)
    {

        BindPayType(ddldistrimode.SelectedValue);
        ViewState["product"] = null;
        if (ddldistrimode.SelectedValue == "2")
        {
            BindProduct(4);
            BindGrid();
        }
        else
        {
            BindProduct(3);
            BindGrid();
        }

    }
}