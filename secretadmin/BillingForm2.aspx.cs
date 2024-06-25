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

public partial class BillingFrom : System.Web.UI.Page, ICallbackEventHandler
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
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (payoutdate() == false)
            {
                Response.Redirect("Maintainance.aspx", false);
                return;
            }
            checkpage();
            string str;
            str = Session["admin"].ToString();
            if (str == "")
            {
                Response.Redirect("adminLog.aspx");
            }
            lblMsg.Text = string.Empty;
            if (!Page.IsPostBack)
            {
                BindState(ddl_state);
                BindState(ddlplaceofsupply);
                btnGenerateBill.Enabled = false;
                lblscheme.Text = " The scheme products at Rs. " + 1 + " in the Invoice cannot be returned or exchanged.";
                lblp.Text = " " + Session["admin"].ToString().ToUpper();
                ViewState["offerno"] = 0;
                txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                txtbilldate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                CheckBillStartDate();
                divbind.Visible = false;
                //divbind.Visible = false;
                //BindState();
                //BindProducts();                  
                // BindUserID();
                // BindGrid();
                BindOffer();
                Session["CheckRefresh"] = System.DateTime.Now.ToString();
                //  txtUserDisp.Text = Request.QueryString["i"] == null ? "" : Request.QueryString["i"].ToString();
                // txtUserId.Text = txtUserDisp.Text;
                // txtUserName.Text = Request.QueryString["n"] == null ? "" : Request.QueryString["n"].ToString();
                //lblOrderNO.Text = Request.QueryString["s"] == null ? "" : "Order No: " + Request.QueryString["s"].ToString();
                int orderNo = 0;
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
    private void CheckBillStartDate()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("CheckBillStartdate", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        int flag = Convert.ToInt32(com.Parameters["@flag"].Value);
        if (flag == 0)
            Response.Redirect("~/maintenance.aspx", false);
        con.Close();
    }
    float findprice(int id, float price)
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("select dpAmt,tax from shopproductmst where productid=@id", con);
        com.Parameters.AddWithValue("@id", id);
        con.Open();
        SqlDataReader rd = com.ExecuteReader();
        if (rd.Read())
        {
            float dtax = Convert.ToSingle(rd["tax"].ToString());
            float tax = price * 100 / (dtax + 100);
            tax = Convert.ToSingle(Math.Round(tax, 2));
            tax = Convert.ToSingle(rd["dpAmt"].ToString());
            tax = Convert.ToSingle(tax);
            con.Close();
            return (tax);
        }
        con.Close();
        return (0);
    }
    string tid = "tblOffer";
    private void BindOffer()
    {
        int c = 1;
        string r = string.Empty, t = string.Empty, l = string.Empty, p = string.Empty, o = string.Empty;
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {

            DataTable dt = new DataTable();
            //da = new SqlDataAdapter("select offertype,id,case when offertype=1 then (select ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then(select Convert(varchar(10),OfferCriteria) as pf from offermst where offertype=2) when offerType=3 then(select convert(varchar(10),OfferCriteria) as pf1 from offermst where offertype=3)  end as offeron,o.cquantity from offermst o where active=1 and vdata>=cast(cast(@vdata as float) as datetime) order by id", con);
            da = new SqlDataAdapter("select offertype,id,case when offertype=1 then (select ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) else Convert(varchar,o.offercriteria)  end as offeron,o.cquantity from offermst o where active=1  and vdata>=cast(cast(@vdata as float) as datetime) order by offercriteria", con);
            da.SelectCommand.Parameters.AddWithValue("@vdata", DateTime.UtcNow);
            da.Fill(dt);
            if (!IsPostBack)
            {
                divOffer.InnerHtml = string.Empty;
                List<string> objofferlsit = new List<string>();
                String strPrdPrice = string.Empty;
                strOffer = "<table class='' id='" + tid + "' style='border:solid 5px #ddd;'>";
                foreach (DataRow drw in dt.Rows)
                {
                    ViewState["total"] = c;
                    t = r = "";
                    r += "r" + c;
                    t += "t" + c;
                    p = "p" + c;
                    o = "o" + 1;
                    c++;
                    RadioButton rbtn = new RadioButton();

                    rbtn.ID = "rbtch" + r;
                    Label lbl = new Label();
                    lbl.ID = "l" + r;
                    lbl.Text = drw["id"].ToString();
                    //this.Form.Controls.Add(rbtn)+
                    DataTable odta = productoffer(Convert.ToInt32(drw["id"].ToString()));
                    strOffer += "<tr  id='" + r + "' style='display:none'><td>";
                    strOffer += "<table id='" + t + "' >";
                    strOffer += "<tr style='border-bottom: solid 1px #b52821;'  id='" + p + "'><td style='display:none'>" + drw["offeron"].ToString() + "</td><td style='display:none'>" + drw["cquantity"].ToString() + "</td><td style='display:none'>" + drw["offertype"].ToString() + "<td style='display:none'> Offer" + lbl.Text + " </td><td  ><input id='" + o + "' type='radio' name='G1' runat='server'  value='" + lbl.Text + "'>Qualify</input></td></tr>";
                    foreach (DataRow drw1 in odta.Rows)
                    {
                        float pa = 0.0f;
                        if (Convert.ToSingle(drw1["pamount"].ToString()) > 0)
                        {
                            pa = findprice(Convert.ToInt32(drw1["productid"].ToString()), Convert.ToSingle(drw1["pamount"].ToString()));
                            lblscheme.Text = " The scheme products at Rs. " + drw1["pamount"].ToString() + " in the Invoice cannot be returned or exchanged.";
                        }
                        strOffer += "<tr><td style=' width:300px; font-size: 12px; font-weight: bold;text-align:left;'>" + drw1["productname"].ToString() + "</td><td style='font-size: 12px; font-weight: bold;'>" + drw1["quantity"].ToString() + "</td><td style='font-size: 12px; font-weight: bold;'>" + pa + "</td><td style='font-size: 12px; font-weight: bold;'>" + drw1["pamount"].ToString() + "</td></tr>";
                    }
                    strOffer += "</table>";
                    //strOffer += "<tr id='" + r + "' style='display:none'><td style='display:none'>" + drw["offeron"].ToString() + "</td><td style='display:none'>" + drw["cquantity"].ToString() + "</td><td style='display:none'>" + drw["offertype"].ToString() + "</td><td style='width:410px;font-size: 12px; font-weight: bold;left-align:100px'>" + drw["Productname"].ToString() + "</td><td style='width:100px;font-size: 12px; font-weight: bold;'>" + drw["quantity"].ToString() + "</td><td style='width:100px;font-size: 12px; font-weight: bold;'>" + drw["pamount"].ToString() + "</td><td style='width:100px;font-size: 12px; font-weight: bold;'>0.00</td><td style='width:100px;font-size: 12px; font-weight: bold;'>0.00</td><td style='width:50px;font-size: 12px; font-weight: bold;'>0.00</td><td style='width:50px;font-size: 12px; font-weight: bold;'>0.00</td><td style='width:50px;font-size: 12px; font-weight: bold;'>" + drw["pamount"].ToString() + "</td></tr>";
                }

                strOffer += "</td></tr></table>";
                divOffer.InnerHtml = strOffer;
            }
        }
        catch
        {
        }
        finally
        {
        }
    }
    private DataTable productoffer(int id)
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        //da = new SqlDataAdapter("select p.productname,p.quantity,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then(select 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria) as pf from offermst where offertype=2) when offerType=3 then(select 'BV on Rs-'+Convert(varchar(10),OfferCriteria) as pf1 from offermst where offertype=3)  end as offeron,convert(varchar(10),vdata,103) as vdata,pamount,id,p.productid from offermst o inner join offerproduct p on o.id=p.offerno where o.id=@id and o.active=1 and o.vdata>=cast(cast(@vdata as float) as datetime)", con);
        da = new SqlDataAdapter("select p.offerno,p.productname,p.quantity,p.productid,case when offertype=1 then (select 'Purchasing on '+Convert(varchar(10),o.cquantity)+' pcs-'+ProductName as p from  ShopProductMst  where o.offertype=1 and ShopProductMst.productid=o.offercriteria ) when offerType=2 then 'Purchasing on Rs-'+Convert(varchar(10),OfferCriteria) when offerType=3 then 'BV on Rs-'+Convert(varchar(10),OfferCriteria)   end as offeron,convert(varchar(10),vdata,103) as vdata,pamount,id,p.productid from offermst o inner join offerproduct p on o.id=p.offerno where o.id=@id and o.active=1 and o.vdata>=cast(cast(@vdata as float) as datetime)", con);
        da.SelectCommand.Parameters.AddWithValue("@vdata", DateTime.UtcNow);
        da.SelectCommand.Parameters.AddWithValue("@id", id);
        DataTable dt = new DataTable();
        da.Fill(dt);
        return (dt);
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
        DataColumn code = new DataColumn("cd", typeof(float));
        code.DefaultValue = 0;
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
        //ViewState["Count"] = null;
        try
        {
            DataTable dtt = new DataTable();
            da = new SqlDataAdapter("select  appmstregno from appmst union all select franchiseid from franchisemst", con);
            da.Fill(dtt);

            List<string> objProductList = new List<string>(); ;
            String strPrdPrice = string.Empty;
            divUserID.InnerText = string.Empty;
            foreach (DataRow drw in dtt.Rows)
            {
                divUserID.InnerText += drw["appmstregno"].ToString() + ",";
            }
        }
        catch
        {
        }
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //lblUser.Text = lblUser.Text;
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
        if (ViewState["billstatus"] != null)
        {
            utility.MessageBox(this, "Your Bill Has Been made It Please Check IT");
            return;
        }

        foreach (GridViewRow row in GridView1.Rows)
        {

            TextBox txtpackageid = (TextBox)row.FindControl("txtcode");
            TextBox txtquantity = (TextBox)row.FindControl("txtQuantity");
            ViewState["productid"] = txtpackageid.Text;
            ViewState["quantity"] = txtquantity.Text;

            if (Convert.ToInt32(txtquantity.Text) > 0)
            {
                if (checkquantity() == false)
                {
                    utility.MessageBox(this, ViewState["msg"].ToString());
                    return;
                }
            }

        }

        checkuser();

        if (ViewState["checkuser"].ToString() == "1")
        {
            int orderNo = Convert.ToInt32(Request.QueryString["s"] == null ? "0" : Request.QueryString["s"].ToString());
            // BindCompanyDetail(orderNo);

            if (string.IsNullOrEmpty(txtUserId.Text.Trim()))
            {
                lblMsg.Text = "Enter user ID.";
                return;
            }

            //else if (string.IsNullOrEmpty(lblToAdd.Text.Trim()))
            //{
            //    lblMsg.Text = "Delivery address not found.";
            //    return;
            //}
            string txt1 = Session["CheckRefresh"].ToString();
            string txt2 = ViewState["CheckRefresh"].ToString();

            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();

                dt = (DataTable)ViewState["product"];
                if (updateQuantity(string.Empty))
                {

                    string strReturn = SaveDetail();
                    if (strReturn == "1")
                    {


                    }
                    else
                        lblMsg.Text = strReturn;


                }
            }
        }

        else
        {
            utility.MessageBox(this, ViewState["checkuser"].ToString());
        }



    }
    private string SaveDetail()
    {

        string batchno = "";
        double disc = 0;
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
        catch { }


        if (tempDt != null)
        {
            XElement element = null;
            //make xml node and calculate amount
            //
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
                        new XElement("batchid", batchid)

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
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime BillDate = Convert.ToDateTime(txtbilldate.Text.Trim(), dateInfo);

            var xmlObject = new XmlDocument();
            xmlObject.LoadXml(element.ToString());
            con = new SqlConnection(method.str);
            com = new SqlCommand("AddBill", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regno", txtUserId.Text.Trim());
            com.Parameters.AddWithValue("@count", tempDt.Rows.Count);
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
            //   com.Parameters.AddWithValue("@DeliveryName", txtName.Text.Trim());
            // com.Parameters.AddWithValue("@DeliveryState", ddl_state.SelectedItem.Text);
            //  com.Parameters.AddWithValue("@DeliveryCity", txtCity.Text.Trim());
            //   com.Parameters.AddWithValue("@DeliveryPin", txtPincode.Text.Trim());
            com.Parameters.AddWithValue("@offId", string.IsNullOrEmpty(ViewState["offerno"].ToString()) ? 0 : Convert.ToInt32(ViewState["offerno"].ToString()));
            com.Parameters.AddWithValue("@bankname", txtbname.Text);
            com.Parameters.AddWithValue("@checkdate", fromDate);
            com.Parameters.AddWithValue("@checkno", txtDD.Text);
            com.Parameters.AddWithValue("@paymode", ddlpaytype.SelectedItem.Text);
            com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
            com.Parameters.AddWithValue("@orderno", "");
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            com.Parameters.AddWithValue("@Counponapplied", hfCouponapplied.Value);
            com.Parameters.AddWithValue("@Counpon", txt_Coupon.Text.Trim());
            com.Parameters.AddWithValue("@PartyGSTNo", txtpartgstno.Text.Trim());
            com.Parameters.AddWithValue("@PlaceOfSupply", ddlplaceofsupply.SelectedItem.Text);
            com.Parameters.AddWithValue("@BillingDate", BillDate);
            
            con.Open();
            com.CommandTimeout = 1900;
            com.ExecuteNonQuery();
            status = com.Parameters["@flag"].Value.ToString();
            string invoiceNo = com.Parameters["@InvNo"].Value.ToString();

            if (status == "1")
            {
                Session["appmstpaid1"] = null;

                ViewState["billstatus"] = "1";

                objUtil = new utility();
                Response.Redirect("GSTBill.aspx?id=" + invoiceNo + "&st=" + status);
                //UpdateStock(tempDt);
                //Response.Redirect("PrintBill.aspx?id=" + invoiceNo + "&st=" + status);
                //ViewState["product"] = tempDt;
                //lblInvoiceNo.Text = invoiceNo;
                //BindGrid();
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
    /// <summary>
    /// 
    /// </summary>
    private void BindCompanyDetail(int orderNo)
    {
        con = new SqlConnection(method.str);
        try
        {
            com = new SqlCommand("bindbillsetting", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@uname", Session["admin"].ToString());
            com.Parameters.AddWithValue("@ordId", orderNo);
            com.Parameters.AddWithValue("@regno", txtUserId.Text.Trim());
            con.Open();
            SqlDataReader reader = com.ExecuteReader();
            while (reader.Read())
            {

                //lblComName.Text = reader["companyname"].ToString();
                //lbltinno.Text = reader["TinNo"].ToString();
                //lblcinno.Text = reader["cinno"].ToString();
                //lblpan.Text = reader["panno"].ToString();
                //lblCompName.Text = lblComName.Text;
                // lblCity2.Text= reader["city"].ToString();
                // lblCity.Text = reader["city"].ToString();
                lbladminadress.Text = reader["city"].ToString();

                // if (Request.QueryString["id"] == null)
                //     lblToAdd.Text = reader["orAddress"].ToString();
                //// imgLogo.ImageUrl = "../images/" + reader["logoURL"].ToString();
                //// lblLeftHead.Text = string.Empty;
                // int i = 0;
                // lblCompanyAdd.Text = "<b>Registerd Office</b>:" + reader["caddress"].ToString().Replace("<br/>", " ");
                // foreach (string add in reader["caddress"].ToString().Split(','))
                // {
                //     lblLeftHead.Text += add + ",";
                //     if (i == 1)
                //         lblLeftHead.Text += "";
                //     i++;
                // }
                // lblLeftHead.Text += "</br>Tel : " + reader["phone"].ToString();
                // lblLeftHead.Text += "</br> Email : " + reader["emailid"].ToString();
                // //right heade
                // //lblRightHead.Text = reader["InvNo"].ToString();
                // lblRightHead.Text = string.Empty;
                // lblRightHead.Text += "" + (Request.QueryString["id"] != null ? invoiceDate : reader["cdate"].ToString());
                // lblBillFooter.Text = "THANKS FOR YOUR BUSINESS!";
                // if (!IsPostBack && Request.QueryString["id"] == null)
                // {
                //     txtDelChrg.Text = reader["delivery"].ToString().Trim();
                //     txtDiscount.Text = reader["Discount"].ToString().Trim();
                // }
            }

            reader.Close();

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
            SqlCommand cmd = new SqlCommand("checkuserdetail", con);
            SqlDataReader dr;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", eventArguments.Trim());
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                strajax = Convert.ToString(dr["name"]);
                Session["sname"] = Convert.ToString(dr["name"]);
                Session["appmstpaid1"] = Convert.ToString(dr["appmstpaid"]);

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
            offerP = dt.Clone();
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

                try
                {
                    con = new SqlConnection(method.str);
                    com = new SqlCommand("select MaxAllowed from ShopProductMst where ProductName=@Pname", con);
                    com.Parameters.AddWithValue("@Pname", strProduct.Trim());
                    con.Open();
                    SqlDataReader reader = com.ExecuteReader();
                    if (reader.Read())
                    {
                        if (reader["MaxAllowed"].ToString() == "0")
                        { }
                        else
                        {
                            int MaxA = 0;
                            MaxA = Convert.ToInt32(reader["MaxAllowed"].ToString());
                            if (Convert.ToInt32(txtQuantity.Text) > MaxA)
                            {
                                utility.MessageBox(this, "Product :" + strProduct + " Maximum Allowed  " + MaxA.ToString() + "");
                                return false;
                            }
                        }
                    }
                }
                catch (Exception ex)
                { }
                finally
                {
                    con.Close();
                    con.Dispose();
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
            //offerProduct();
            foreach (DataRow or in offerP.Rows)
            {
                dt.Rows.Add(or.ItemArray);
            }
            ViewState["product"] = dt;

        }
        return status;
    }
    private DataTable findtax(int id)
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("select tax,dpamt from shopproductmst where productid=@pid", con);
        com.Parameters.AddWithValue("@pid", id);
        con.Open();
        SqlDataReader trd = com.ExecuteReader();
        DataTable ftax = new DataTable();
        ftax.Load(trd);
        con.Close();
        return (ftax);
    }
    DataTable offerP;
    static int x = 0, y = 0;
    void offerProduct()
    {

        string selectedGender;
        if (Request.Form["G1"] == null)
        {
            //utility.MessageBox(this, "Please Choose Offer Items");
            //return;
            selectedGender = "0";
        }
        else
        {
            selectedGender = Request.Form["G1"].ToString();
        }
        DataTable ppp = productoffer(Convert.ToInt32(selectedGender));
        for (int i = 0; i < ppp.Rows.Count; i++)
        {

            ViewState["offerno"] = ppp.Rows[i]["offerno"].ToString();
            DataRow dr = offerP.NewRow();
            DataTable ftax = findtax(Convert.ToInt32(ppp.Rows[i]["productid"].ToString()));
            float dtax = Convert.ToSingle(ftax.Rows[0]["tax"].ToString());
            float tax = ((Convert.ToSingle(ppp.Rows[i]["pamount"].ToString())) * 100 / (dtax + 100));//* Convert.ToInt32(ppp.Rows[i]["quantity"].ToString());
            dr["pname"] = ppp.Rows[i]["productname"].ToString();
            //dr["DPWT"] = Convert.ToSingle(ppp.Rows[i]["pamount"].ToString());
            dr["DPWT"] = Convert.ToSingle(ftax.Rows[0]["dpamt"].ToString());
            dr["cd"] = ppp.Rows[i]["productid"].ToString();
            dr["val"] = tax.ToString();
            tax = Convert.ToSingle(Math.Round(tax, 2));
            dr["dis"] = Convert.ToSingle(ftax.Rows[0]["dpamt"].ToString()) - tax;
            dr["Tax"] = dtax;
            dr["TaxRs"] = (Convert.ToSingle(ppp.Rows[i]["pamount"].ToString())) - tax;
            dr["DP"] = tax;
            dr["BV"] = 0.0f;
            dr["quantity"] = Convert.ToInt32(ppp.Rows[i]["quantity"].ToString());
            dr["total"] = Convert.ToSingle(ppp.Rows[i]["pamount"].ToString());
            dr["MaxAllowed"] = 0.0f;
            dr["gtotal"] = Convert.ToSingle(ppp.Rows[i]["pamount"].ToString());
            dr["QTY"] = 0.0f;
            offerP.Rows.Add(dr);


        }
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
    protected void txtUserId_TextChanged(object sender, EventArgs e)
    {
        if (checkuser() == "1")
        {
            BindProducts();
            BindGrid();
            divbind.Visible = true;
            bindCoupon();
            BindWallet(txtUserId.Text.Trim());
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
        //ViewState["Count"] = null;
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
                divProduct.InnerText = string.Empty;
                foreach (DataRow drw in dt.Rows)
                {

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
    private double findWeight(int id)
    {
        con = new SqlConnection(method.str);
        DaProduct = new SqlDataAdapter("select weight from shopproductmst where productid=@id", con);
        DaProduct.SelectCommand.Parameters.AddWithValue("@id", id);
        DataTable dtweight = new DataTable();
        DaProduct.Fill(dtweight);
        if (dtweight.Rows.Count > 0)
        {
            return (Convert.ToDouble(dtweight.Rows[0]["weight"].ToString()));
        }
        else
            return (0);
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

                TotalWeight += (qnt * findWeight(pid));

                //TotalBV += (qnt * BV);
                TotalBV += BV;
                TotalDP += (qnt * price);
            }
            TotalDP = TotalDP - double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim());
            lblWeight.Text = TotalWeight.ToString();
            CheckPiad();
            Total += TotalTaxRs;
            //Label1.Text =Math.Round(TotalTaxRs).ToString();
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

            lblAmt.Text = txtNetAmt.Text;
            lblTotalPy.Text = txtNetAmt.Text;

            CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
            TextInfo textInfo = cultureInfo.TextInfo;
            lblAmtWord.Text = "(Rupees " + textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(Math.Round(NetAmt)))) + " Only)";
            //txtDelChrg.Text = DelCharge;
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex >= 0)
        {
            ((TextBox)e.Row.Cells[4].FindControl("txtQuantity")).Attributes.Add("onchange", "javascript:calculate(" + (e.Row.RowIndex + 2).ToString() + ",this)");
            //onblur="ShowMRP();"
            ((TextBox)e.Row.Cells[2].FindControl("txtProductNAme")).Attributes.Add("onblur", "javascript:ShowMRP(" + (e.Row.RowIndex + 2).ToString() + ",this)");
            ((TextBox)e.Row.Cells[5].FindControl("txtDis")).Attributes.Add("onchange", "javascript:calculate(" + (e.Row.RowIndex + 2).ToString() + ",this)");
        }
        //if (ViewState["product"] != null)
        //{
        //    DataTable dt = (DataTable)ViewState["product"];
        //    CalculateTotal(dt);
        //}
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
        Response.Redirect("Billingform.aspx", false);
    }
    public void CheckPiad()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("select COUNT(*) as cnt from BillMst where Soldto=@uname", con);
            com.Parameters.AddWithValue("@uname", txtUserId.Text.Trim());
            con.Open();
            SqlDataReader reader = com.ExecuteReader();
            if (reader.Read())
            {
                if (Convert.ToInt32(reader["cnt"].ToString()) == 0)
                {
                    CheckRes = "0";
                    if (TotalDP < 1)
                    {
                        CheckRes = "1";
                    }
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
    protected void ddlpaytype_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    private void UpdateStock(DataTable dtt)
    {
        if (dtt != null && dtt.Rows.Count > 0)
        {
            foreach (DataRow row in dtt.Rows)
            {
                int qnt = Convert.ToInt32(string.IsNullOrEmpty(row["quantity"].ToString()) ? "0" : row["quantity"].ToString());
                string PId = string.IsNullOrEmpty(row["cd"].ToString()) ? "0" : row["cd"].ToString();
                if (PId != "0" && qnt != 0)
                {
                    con = new SqlConnection(method.str);
                    com = new SqlCommand("update ShopProductMst set qty=Qty-" + qnt + " where ProductId=@pid", con);
                    com.Parameters.AddWithValue("@pid", PId);
                    con.Open();
                    com.ExecuteNonQuery();
                }
            }

        }
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
        else {
            txtUserName.Text = status1;
        }
        ViewState["checkuser"] = status1;
        con.Close();
        return status1;

        //ViewState["checkuser"]=status1;
        //if (status1 != "1")
        //{

        // utility.MessageBox(this, status1);            
        //}

        //if (status1 == "1")
        //{
        //    con.Close();


        //}



    }
    public void checkpage()
    {
        SqlDataReader dr;
        con = new SqlConnection(method.str);
        com = new SqlCommand("pageprocess", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@action", "1");
        con.Open();
        dr = com.ExecuteReader();
        while (dr.Read())
        {
            if (dr["billing"].ToString() == "OFF")
            {

                Response.Redirect("~/error.aspx");
            }
        }
    }
    public Boolean checkquantity()
    {

        con = new SqlConnection(method.str);
        com = new SqlCommand("checkAdminquantity", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@productid", Convert.ToInt32(ViewState["productid"].ToString()));
        com.Parameters.AddWithValue("@qty", Convert.ToInt32(ViewState["quantity"].ToString()));

        com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        string status = com.Parameters["@flag"].Value.ToString();
        ViewState["msg"] = status;
        if (status != "1")
        {
            con.Close();

            return false;

        }
        else
        {
            con.Close();
        }

        return true;
    }
    protected void btncheck_Click(object sender, EventArgs e)
    {
        if (checkuser() == "1")
        {
            BindProducts();

            //  BindUserID();
            BindGrid();
            divbind.Visible = true;
            // divbind.Visible = true;

        }

        else
        {

            GridView1.DataSource = null;
            GridView1.DataBind();
            divbind.Visible = false;
            // txtUserDisp.Text = "";
            txtUserId.Text = "";
            utility.MessageBox(this, "Invalid User");

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
    void bindCoupon()
    {
        DataUtility Objdu = new DataUtility();
        DataTable dt = Objdu.GetDataTable("Select Couponid, Coupon, CouponAmount, ExpiryDate=Convert(varchar, ExpiryDate, 103), UsedDate=Convert(varchar, UsedDate, 103), Status=Case when IsUsed=1 then 'Used' when CAST(ExpiryDate as DATE) < CAST(Getdate() as DATE) then 'Expired' else 'Unused' end from CouponMst Where IsUsed=0 and AppMstid=(Select AppMstid from AppMst where AppMstRegNo='" + txtUserId.Text.Trim() + "') ");
        StringBuilder sb = new StringBuilder();

        if (dt.Rows.Count > 0)
        {

            sb.Append("<table class='mygrd table table-striped table-hover' style='width: 100%; border: dashed 1px #000;'>");
            sb.Append("<thead> <td>Sno. </td><td> Coupon</td><td> Amount </td> <td> Status </td> <td>Expiry date </td> <td>Used date </td> </thead>");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sb.Append("<tr> <td>" + (Convert.ToInt32(i) + Convert.ToInt32(1)) + "</td><td>" + dt.Rows[i]["Coupon"].ToString() + "</td><td> " + dt.Rows[i]["CouponAmount"].ToString() + " </td> <td> " + dt.Rows[i]["Status"].ToString() + " </td> <td>" + dt.Rows[i]["ExpiryDate"].ToString() + "</td> <td>" + dt.Rows[i]["UsedDate"].ToString() + "</td></tr>");
            }//Couponid				
            sb.Append(" </table>");
        }

        CouponDiv.InnerHtml = sb.ToString();
    }
    //void SelectedIndexState()
    //{
    //    DataUtility Objdu = new DataUtility();
    //    DataTable dt = Objdu.GetDataTable(" Select s.ID from AppMst a inner join stategstmst s on a.AppMstState=s.Statename  where Appmstregno='" + txtUserId.Text.Trim() + "'");
    //    if (dt.Rows.Count > 0)
    //    {
    //        DdlState.SelectedValue = dt.Rows[0]["ID"].ToString();
    //    }
    //}

    //public void BindState()
    //{

    //    DataUtility objDu = new DataUtility();
    //    SqlParameter[] sqlparam = new SqlParameter[] {
    //        };
    //    DataTable dt = objDu.GetDataTableSP(sqlparam, "GetState");

    //    if (dt.Rows.Count > 0)
    //    {
    //        DdlState.DataSource = dt;
    //        DdlState.DataTextField = "StateName";
    //        DdlState.DataValueField = "SId";
    //        DdlState.DataBind();
    //        DdlState.Items.Insert(0, new ListItem("Select", "0"));
    //    }
    //}
    public Boolean payoutdate()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("checkbillpayout", con);
        com.CommandType = CommandType.StoredProcedure;
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
                " from your CJ Wallet use OTP. OTP is " + dt.Rows[0]["OTP"].ToString().Trim() +
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
        string Result = com.Parameters["@IsValid"].Value.ToString();
        if (Result == "0")
        {

            //divbind.Enabled = false;
        }
        else
        {
        }
        return Result;
    }
    [WebMethod]
    public static string couponapply(string CouponCode, string userid, string ConditionAmount)
    {
        string Result = "";
        DataUtility Objdu = new DataUtility();
        DataTable dt = Objdu.GetDataTable(@"Select CouponAmount from CouponMst where isused=0 and CAST(ExpiryDate as DATE)>=CAST(Getdate() as DATE) and Coupon='" + CouponCode
        + "' and " + ConditionAmount + ">=ConditionAmount and Appmstid=(Select Appmstid from AppMst where appmstregno='" + userid + "')");

        if (dt.Rows.Count > 0)
        {
            Result = dt.Rows[0]["CouponAmount"].ToString();
        }
        else
        {
            Result = "0";
        }
        return Result;
    }
    //Ragh code
    public void BindState(DropDownList ddl)
    {
        objDUT = new DataUtility();
        DataTable dt = new DataTable();
        SqlParameter[] sqlparam = new SqlParameter[] {
            };
        dt = objDUT.GetDataTable(sqlparam, "GetState");
        ddl.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddl.DataSource = dt;
            ddl.DataTextField = "StateName";
            ddl.DataValueField = "SId";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("Select", "0"));
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
                com.Parameters.AddWithValue("@distype",ddltype.SelectedValue);
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
}


