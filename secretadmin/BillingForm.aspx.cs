﻿using System;
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

public partial class BillingFrom : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlDataAdapter DaProduct;
    SqlCommand com = null;
    utility objUtil = null;
    DataUtility objDUT;
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
    int ypin, paid;
    string invoiceDate, CheckRes = string.Empty, strOffer;
    static string str = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            str = Session["admin"].ToString();
            if (str == "")
                Response.Redirect("adminLog.aspx");

            if (payoutdate() == false)
            {
                Response.Redirect("Maintainance.aspx", false);
                return;
            }



            lblMsg.Text = string.Empty;
            if (!Page.IsPostBack)
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();
                BindMaster();
                BindState();
                divbind.Visible = false;
               
                nextbill.Visible = false;

                txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                txtbilldate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

               
                lblp.Text = " " + Session["admin"].ToString().ToUpper();

            }
        }
        catch
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

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (updateQuantity())
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
        if (ddl_PointType.SelectedValue =="0")
        {
            lblMsg.Text = "Please Select Self Point.";
            return;
        }
         
        if (string.IsNullOrEmpty(txtUserId.Text.Trim()))
        {
            lblMsg.Text = "Enter user ID.";
            return;
        }
        btnGenerateBill.Enabled = false;
        int orderNo = Convert.ToInt32(Request.QueryString["s"] == null ? "0" : Request.QueryString["s"].ToString());
        if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();
            if (updateQuantity())
            {
                string strReturn = SaveDetail();
                if (strReturn != "1")
                    lblMsg.Text = strReturn;
            }
        }
        else
        {
            utility.MessageBox(this, ViewState["checkuser"].ToString());
        }
    }

    private string SaveDetail()
    {
        int Pcount = 0;
        double disc = 0;
        string status = string.Empty;
        dt = (DataTable)ViewState["product"];
        DataTable tempDt = new DataTable();
        DateTime fromDate = new DateTime();
        DataTable Pbatch = (DataTable)ViewState["adminproduct"];

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

            if (tempDt != null)
            {
                string ss = "Select city=UserVal, State=(Select appmststate from appmst WHERE appmstregno ='" + txtUserId.Text.Trim() + "') from Settingmst where IsActive=1 and Caption='COM_STATE'";
                con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand(ss, con);
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                DataTable dtc = new DataTable();
                adp.Fill(dtc);


                XElement element = null;
                if (tempDt.Rows.Count > 0)
                {
                    element = new XElement("Bill");
                    foreach (DataRow row in tempDt.AsEnumerable().Where(o => !string.IsNullOrEmpty(o.Field<string>("pname")) && o.Field<int>("quantity") > 0).CopyToDataTable().Rows)
                    {
                        Pcount = Pcount + 1;
                        if (row["pname"].ToString().Trim().Length > 0 && Convert.ToInt32(string.IsNullOrEmpty(row["quantity"].ToString().Trim()) ? "0" : row["quantity"].ToString().Trim()) > 0)
                        {

                            string batchid = (Pbatch.AsEnumerable().Where(p => p["ProductName"].ToString() == row["pname"].ToString()).Select(p => p["batchid"].ToString())).FirstOrDefault();
                            var taxval = (double.Parse(row["Val"].ToString()) * double.Parse(row["Tax"].ToString()) / 100);


                            float itax = 0, taxi = 0, ctax = 0, taxc = 0, stax = 0, taxs = 0;
                            string buyerstate = dtc.Rows[0]["State"].ToString().ToUpper();
                            string sellerstate = dtc.Rows[0]["city"].ToString().ToUpper();
                            if (ddlplaceofsupply.SelectedItem.Text == "Select")
                            {
                                if (buyerstate == sellerstate)
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
                            }
                            else
                            {
                                if (ddlplaceofsupply.SelectedItem.Text.ToUpper() == sellerstate)
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
                            }

                            XElement prdXml = new XElement("P",
                            new XElement("pname", row["pname"].ToString()),
                            new XElement("cd", row["cd"].ToString()),
                            new XElement("dis", row["dis"].ToString()),
                            new XElement("Qnt", row["quantity"].ToString()),
                            new XElement("MRP", row["DPWT"].ToString()),
                            new XElement("TAX", row["Tax"].ToString()),
                            new XElement("TAXRS", taxval),
                            new XElement("DP", row["DP"].ToString()),
                            new XElement("BV", row["BV"].ToString()),
                            new XElement("total", double.Parse(row["gtotal"].ToString()) + taxval),
                            new XElement("batchid", batchid),
                            new XElement("OFFERID", 0),
                            new XElement("IGST", itax),
                            new XElement("IGSTRS", taxi),
                            new XElement("CGST", ctax),
                            new XElement("CGSTRS", taxc),
                            new XElement("SGST", stax),
                            new XElement("SGSTRS", taxs)
                            );
                            element.Add(prdXml);
                            disc += Convert.ToSingle(row["dis"].ToString());
                        }
                        //else
                        //    row.Delete();
                    }

                    amt = double.Parse(dt.Compute("sum(total)", "true").ToString().Trim());
                    grosstotal = double.Parse(dt.Compute("sum(gtotal)", "true").ToString().Trim());
                    CalculateTotal(tempDt);
                    CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
                    TextInfo textInfo = cultureInfo.TextInfo;
                    lblAmtWord.Text = textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(NetAmt)).ToUpperInvariant()) + " Only";
                }
                //Free Sample 
                if (ddltype.SelectedValue != "4")
                {
                    if (CheckRes == "1")
                    {
                        utility.MessageBox(this, "First Bill can't Less than 1");
                        return "First Bill can't Less than 1";
                    }
                    if (element == null || amt == 0)
                    {
                        BindGrid();
                        return "Please eneter the product and quantity properly.";
                    }
                }
                 
                System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
                dateInfo.ShortDatePattern = "dd/MM/yyyy";
                DateTime BillDate = Convert.ToDateTime(txtbilldate.Text.Trim(), dateInfo);
                var xmlObject = new XmlDocument();
                xmlObject.LoadXml(element.ToString());
                con = new SqlConnection(method.str);
                com = new SqlCommand("AddBill", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@regno", txtUserId.Text.Trim());
                com.Parameters.AddWithValue("@count", Pcount);
                com.Parameters.AddWithValue("@amt", Convert.ToInt32(Math.Round(NetAmt)).ToString("#0.00"));
                com.Parameters.AddWithValue("@gross", grosstotal);
                com.Parameters.AddWithValue("@Qnty", TotalQnty);
                com.Parameters.AddWithValue("@ToalTaxPer", TotalTaxPer);
                com.Parameters.AddWithValue("@TotalTaxRs", TotalTaxRs);
                com.Parameters.AddWithValue("@TotalDP", TotalDP);
                com.Parameters.AddWithValue("@TotalBV", TotalBV);
                com.Parameters.AddWithValue("@distype", ddltype.SelectedValue.ToString());
                com.Parameters.AddWithValue("@delChrg", DelCharge);
                com.Parameters.AddWithValue("@disAmt", Discount);
                com.Parameters.AddWithValue("@NetAmt", NetAmt);
                com.Parameters.AddWithValue("@soldTo", txtUserId.Text.Trim());
                com.Parameters.AddWithValue("@saleRep", Session["admin"].ToString());
                if (txtaddress.Text == "")
                {
                    com.Parameters.AddWithValue("@toAdd", txtaddress.Text == "" ? "" : txtaddress.Text);
                }
                else
                {
                    com.Parameters.AddWithValue("@toAdd", "Name: " + txtName.Text.Trim() + "<br/> Address: " + txtaddress.Text.Trim() + "<br/> State: " + ddl_state.SelectedItem.Text + "<br/> City: " + txtCity.Text.Trim() + "<br/> Pincode: " + txtPincode.Text.Trim());
                }
                com.Parameters.AddWithValue("@offId", "0");
                com.Parameters.AddWithValue("@bankname", txtbname.Text);
                com.Parameters.AddWithValue("@checkdate", fromDate);
                com.Parameters.AddWithValue("@checkno", txtDD.Text);
                com.Parameters.AddWithValue("@paymode", ddlpaytype.SelectedItem.Text);
                com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
                com.Parameters.AddWithValue("@orderno", "");
                com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                com.Parameters.AddWithValue("@Counponapplied", hfCouponapplied.Value);
                com.Parameters.AddWithValue("@Counpon", 0);
                com.Parameters.AddWithValue("@PartyGSTNo", txtpartgstno.Text.Trim());
                com.Parameters.AddWithValue("@PlaceOfSupply", ddlplaceofsupply.SelectedItem.Text);
                com.Parameters.AddWithValue("@BillingDate", BillDate);
                com.Parameters.AddWithValue("@Banktype", ddlpaytype.SelectedItem.Text == "Wallet" ? ddlWalletType.SelectedValue.ToString() : "");
                com.Parameters.AddWithValue("@PoitSide", ddl_PointType.SelectedValue);
                con.Open();
                com.CommandTimeout = 1900;
                com.ExecuteNonQuery();
                status = com.Parameters["@flag"].Value.ToString();
                string invoiceNo = com.Parameters["@InvNo"].Value.ToString();
                if (status == "1")
                {
                    Response.Redirect("GSTBill.aspx?id=" + invoiceNo + "&st=" + status);
                }
                else
                {
                    utility.MessageBox(this, status);
                }
            }
            else
                lblMsg.Text = "Please enter some product names.";
        }
        catch { }
        return status;
    }


    private bool updateQuantity()
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
                if (text == "0")
                    break;

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
                        drow["total"] = Math.Round(taxRs + Convert.ToDouble(string.IsNullOrEmpty(drow["DPWT"].ToString()) ? "0" : drow["DPWT"].ToString()) * Convert.ToDouble(string.IsNullOrEmpty(drow["quantity"].ToString()) ? "0" : drow["quantity"].ToString()) - Convert.ToDouble(dis.Text));
                    }
                }
            }
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
    private void placesupply(string regno)
    {
        try
        {
            con = new SqlConnection(method.str);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter();
            da = new SqlDataAdapter("checkplacesupply", con);
            da.SelectCommand.Parameters.AddWithValue("@regno", regno.Trim());
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddlplaceofsupply.SelectedValue = dt.Rows[0]["StateCode"].ToString();
                txtpartgstno.Text = dt.Rows[0]["GSTNo"].ToString();
            }
        }
        catch
        {
        }
    }


    protected void BindMaster()
    {
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("Select UserVal from SettingMst  where IsActive=1 and Caption='SELFPOINTSIDE'", con);
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataTable dt_Mst = new DataTable();
        adp.Fill(dt_Mst);
        if (dt_Mst.Rows.Count > 0)
        {
            ddl_PointType.SelectedValue = dt_Mst.Rows[0]["UserVal"].ToString();
        }
    }


    protected void txtUserId_TextChanged(object sender, EventArgs e)
    {
        if (checkuser() == "1")
        {
            BindPayType();
            BindProducts();
            BindGrid();
            divbind.Visible = true;

            if (ddlWalletType.SelectedValue.ToString() == "BankTran")
                BindWallet(txtUserId.Text.Trim());
            else if (ddlWalletType.SelectedValue.ToString() == "PTran80")
                PayoutBal(txtUserId.Text.Trim());

            placesupply(txtUserId.Text.Trim());
        }

        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
            divbind.Visible = false;
            txtUserId.Text = "";
            utility.MessageBox(this, "Invalid User");
        }
    }

    protected void ddlWalletType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (txtUserId.Text.Trim() != "")
        {
            if (checkuser() == "1")
            {
                //BindPayType();
                //BindProducts();
                //BindGrid();
                //divbind.Visible = true;

                if (ddlWalletType.SelectedValue.ToString() == "BankTran")
                    BindWallet(txtUserId.Text.Trim());
                else if (ddlWalletType.SelectedValue.ToString() == "PTran80")
                    PayoutBal(txtUserId.Text.Trim());

                //placesupply(txtUserId.Text.Trim());
            }

            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                divbind.Visible = false;
                txtUserId.Text = "";
                utility.MessageBox(this, "Invalid User");
            }
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
            divbind.Visible = false;
            txtUserId.Text = "";

        }
    }



    private void BindGrid()
    {
        if (ViewState["product"] != null)
            dt = (DataTable)ViewState["product"];
        if (dt == null)
        {
            dt = CreateStructure().Clone();
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
            dt.Rows.Add(dt.NewRow());
            dt.Rows.Add(dt.NewRow());
            ViewState["product"] = dt;
        }
        GridView1.DataSource = dt;
        GridView1.DataBind();
        CalculateTotal(dt);
    }
    private void BindProducts()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {
            DataTable dt = new DataTable();
            da = new SqlDataAdapter("bindadminproduct", con);
            da.SelectCommand.Parameters.AddWithValue("@adminid", Session["admin"].ToString());
            da.SelectCommand.Parameters.AddWithValue("@distype", 0);
            da.SelectCommand.Parameters.AddWithValue("@type", ddltype.SelectedValue.ToString());
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ViewState["adminproduct"] = dt;
                List<string> objProductList = new List<string>(); ;
                String strPrdPrice = string.Empty;
                strPrdPrice += "<table id='tblMRP'>";
                divMRP.InnerHtml = string.Empty;
                divProductCode.InnerText = string.Empty;
                divProduct.InnerText = string.Empty;
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
    }

    private void CalculateTotal(DataTable dtt)
    {
        if (dtt != null && dtt.Rows.Count > 0)
        {
            TotalBV = 0;
            TotalDP = 0;
            TotalTaxRs = 0;
            TotalTaxPer = 0;
            TotalBV = 0;
            double TotalWeight = 0;
            ((Label)GridView1.FooterRow.FindControl("lblQtotal")).Text = double.Parse(dtt.Compute("sum(quantity)", "true").ToString().Trim()).ToString("#0.00");
            Total = Math.Round(double.Parse(dt.Compute("sum(val)", "true").ToString().Trim()));

            ((Label)GridView1.FooterRow.FindControl("lblTotal")).Text = Math.Round(Total).ToString("#0.00");
            grosstotal = Math.Round(double.Parse(dtt.Compute("sum(gtotal)", "true").ToString().Trim()));
            lblGrossTotal.Text = grosstotal.ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblDistotal")).Text = double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim()).ToString("#0.00");
            txtDiscount.Text = double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim()).ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblValtotal")).Text = Math.Round(double.Parse(dtt.Compute("sum(val)", "true").ToString().Trim())).ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblTaxRsTtotal")).Text = Math.Round(double.Parse(dtt.Compute("sum(TaxRs)", "true").ToString().Trim())).ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblBVtotal")).Text = Math.Round(double.Parse(dtt.Compute("sum(BV)", "true").ToString().Trim())).ToString("#0.00");
            int qnt = 0;
            foreach (DataRow row in dtt.Rows)
            {
                int pid = Convert.ToInt32(string.IsNullOrEmpty(row["cd"].ToString()) ? "0" : row["cd"].ToString());
                qnt = Convert.ToInt32(string.IsNullOrEmpty(row["quantity"].ToString()) ? "0" : row["quantity"].ToString());
                TotalQnty += qnt;
                TotalTaxPer += Convert.ToDouble(string.IsNullOrEmpty(row["Tax"].ToString()) ? "0" : row["Tax"].ToString());
                TotalTaxRs += Convert.ToDouble(string.IsNullOrEmpty(row["TaxRs"].ToString()) ? "0" : row["TaxRs"].ToString());
                double DP = Convert.ToDouble(string.IsNullOrEmpty(row["DP"].ToString()) ? "0" : row["DP"].ToString());
                double BV = Convert.ToDouble(string.IsNullOrEmpty(row["BV"].ToString()) ? "0" : row["BV"].ToString());
                double price = Convert.ToDouble(string.IsNullOrEmpty(row["DPWT"].ToString()) ? "0" : row["DPWT"].ToString());
                TotalBV += BV;
                TotalDP += (qnt * price);
            }
            TotalDP = TotalDP - double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim());
            lblWeight.Text = TotalWeight.ToString();
            Total += TotalTaxRs;
            ((Label)GridView1.FooterRow.FindControl("lblTotal")).Text = Math.Round(Total).ToString("#0.00");
            lblTotalBV.Text = TotalBV.ToString();
            txtTax.Text = Math.Round(TotalTaxRs).ToString("#0.00");
            DelCharge = double.Parse(string.IsNullOrEmpty(txtDelChrg.Text.Trim()) ? "0" : txtDelChrg.Text.Trim());
            Discount = double.Parse(string.IsNullOrEmpty(txtDiscount.Text.Trim()) ? "0" : txtDiscount.Text.Trim());
            lblDelChrg.Text = DelCharge.ToString("#0.00");
            lblDiscount.Text = Discount.ToString();
            lblDiscount.Text = "0";
            Discount = 0;
            NetAmt = grosstotal + DelCharge;// -(grosstotal * Discount / 100);
            NetAmt += TotalTaxRs;
            txtNetAmt.Text = Convert.ToInt32(Math.Round(NetAmt)).ToString("#0.00");
 
            

            CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
            TextInfo textInfo = cultureInfo.TextInfo;
            lblAmtWord.Text = "(Rupees " + textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(Math.Round(NetAmt)))) + " Only)";
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
        if (updateQuantity())
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
        Response.Redirect("Billingform.aspx", false);
    }

    public string checkuser()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("checkbilluser", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@soldTo", txtUserId.Text.Trim());
        com.Parameters.AddWithValue("@distype", 0);
        com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        com.Parameters.Add("@username", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        string status1 = com.Parameters["@flag"].Value.ToString();

        if (com.Parameters["@username"].Value.ToString() != "")
        {
            txtUserName.Text = com.Parameters["@username"].Value.ToString();
        }
        else
        {
            txtUserName.Text = status1;
        }
        ViewState["checkuser"] = status1;
        con.Close();
        return status1;

    }

   
    public Boolean payoutdate()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("checkbillpayout", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        com.Parameters.AddWithValue("@Master", "BILLSTATUS");
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
    [WebMethod]
    public static string GenerateOTP(string UserName, string Amount)
    {
        string Result = "0";
        DataTable dt = new DataTable();
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        da = new SqlDataAdapter("GenerateOTP", con);
        da.SelectCommand.Parameters.AddWithValue("@RegNo", UserName);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            utility objUtil = new utility();
            string msg = "Dear " + dt.Rows[0]["UserName"].ToString().Trim() + " To Pay Rs. " + Amount.Trim() +
                " from your User Wallet use OTP. OTP is " + dt.Rows[0]["OTP"].ToString().Trim() +
                ". Don't share with anyone.";
            objUtil.SENDOTP(dt.Rows[0]["AppMstMobile"].ToString().Trim(), msg);
        }

        return Result;
    }
    [WebMethod]
    public static string VerifyOTP(string UserName, string OTP)
    {

        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("VerifyOTP", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@RegNo", UserName);
        com.Parameters.AddWithValue("@OTP", OTP);
        com.Parameters.Add("@IsValid", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        return com.Parameters["@IsValid"].Value.ToString();

    }

    public void BindState()
    {
        objDUT = new DataUtility();
        DataTable dt = new DataTable();
        SqlParameter[] sqlparam = new SqlParameter[] {
            };
        dt = objDUT.GetDataTable(sqlparam, "GetState");
        ddl_state.Items.Clear();
        ddlplaceofsupply.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddl_state.DataSource = dt;
            ddl_state.DataTextField = "StateName";
            ddl_state.DataValueField = "Id";
            ddl_state.DataBind();
            ddl_state.Items.Insert(0, new ListItem("Select", "0"));

            ddlplaceofsupply.DataSource = dt;
            ddlplaceofsupply.DataTextField = "StateName";
            ddlplaceofsupply.DataValueField = "Id";
            ddlplaceofsupply.DataBind();
            ddlplaceofsupply.Items.Insert(0, new ListItem("Select", "0"));
        }

    }
    private void BindWallet(string RegNo)
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("getwalletBalanceUser", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@AppMstRegNo", RegNo);
            com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            string Balance = com.Parameters["@Bal"].Value.ToString();
            lbl_UserWalletBalance.Text = Balance;
            txtBal.Text = "Balance: " + Balance;
            lblwallettext.Text = "User wallet Balance : ";
        }
        catch (Exception ex)
        { }
    }

    private void PayoutBal(string RegNo)
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("getPayoutBalanceUser", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@AppMstRegNo", RegNo);
            com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            string Balance = com.Parameters["@Bal"].Value.ToString();
            lbl_UserWalletBalance.Text = Balance;
            txtBal.Text ="Balance: "+ Balance;
            lblwallettext.Text = "Payout wallet Balance : ";  
        }
        catch (Exception ex)
        { }
    }


    protected void txtbilldate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            //if (txtbilldate.Text != "")
            {
                System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
                dateInfo.ShortDatePattern = "dd/MM/yyyy";
                DateTime Date = Convert.ToDateTime(txtbilldate.Text.Trim(), dateInfo);
                con = new SqlConnection(method.str);
                com = new SqlCommand("GETCHECKDATE", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@DATE", Date);
                com.Parameters.AddWithValue("@distype", ddltype.SelectedValue);
                com.Parameters.Add("@FLAG", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string MSG = com.Parameters["@FLAG"].Value.ToString();
                if (MSG == "0")
                {

                }
                else
                {
                    utility.MessageBox(this, MSG);
                    txtbilldate.Text = "";
                }
            }
        }
        catch (Exception ex)
        {
        }
    }

    public void BindPayType()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Id", typeof(Int32));
        dt.Columns.Add("PAYTYPE", typeof(string));
        ddlpaytype.Items.Clear();
        if (ddltype.SelectedValue == "4")
        {
            dt.Rows.Add(1, "Free Sample");
            lblwallettext.Visible = false;
            lbl_UserWalletBalance.Visible = false;
        }
        else
        {
            lblwallettext.Visible = true;
            lbl_UserWalletBalance.Visible = true;
             dt.Rows.Add(2, "Cash");
            dt.Rows.Add(1, "Wallet");
           
            dt.Rows.Add(3, "Cheque");
            dt.Rows.Add(4, "Net Banking");
            dt.Rows.Add(5, "DD");
        }
        ddlpaytype.DataSource = dt;
        ddlpaytype.DataTextField = "PAYTYPE";
        ddlpaytype.DataValueField = "PAYTYPE";
        ddlpaytype.DataBind();
    }

    protected void ddltype_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtUserId.Text = "";
        txtUserName.Text = "";
        txtbilldate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
        txtpartgstno.Text = "";
        ddl_state.SelectedValue = "0";
        ddlplaceofsupply.SelectedValue = "0";
        txtName.Text = "";
        txtaddress.Text = "";
        txtCity.Text = "";
        txtPincode.Text = "";
        divbind.Visible = false;
        GridView1.DataSource = null;
        GridView1.DataBind();
    }

}


