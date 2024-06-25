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

public partial class d2000admin_BillingFrom : System.Web.UI.Page, ICallbackEventHandler
{
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
    string invoiceDate, CheckRes = string.Empty, strOffer;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string str;
            str = Session["admin"].ToString();
            if (str == "")
                Response.Redirect("adminLog.aspx");
            lblMsg.Text = string.Empty;
            if (!Page.IsPostBack)
            {
                lblscheme.Text = " The scheme products at Rs. "+1+" in the Invoice cannot be returned or exchanged.";
                lblp.Text = " " + Session["admin"].ToString().ToUpper();
                ViewState["offerno"] = 0;
                txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                CheckBillStartDate();
                // InsertFunction.CheckAdminlogin();
                if (Request.QueryString["id"] != null)
                {
                    BindForPrint(Request.QueryString["id"] == null ? "" : Request.QueryString["id"].ToString());
                }
                else
                {
                    BindProducts();
                    BindUserID();
                    BindGrid();
                    BindOffer();
                    Session["CheckRefresh"] = System.DateTime.Now.ToString();
                    txtUserDisp.Text = Request.QueryString["i"] == null ? "" : Request.QueryString["i"].ToString();
                    txtUserId.Text = txtUserDisp.Text;
                    txtUserName.Text = Request.QueryString["n"] == null ? "" : Request.QueryString["n"].ToString();
                    lblOrderNO.Text = Request.QueryString["s"] == null ? "" : "Order No: " + Request.QueryString["s"].ToString();
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
    float findprice(int id,float price)
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("select dpAmt,tax from shopproductmst where productid=@id", con);
        com.Parameters.AddWithValue("@id",id);
        con.Open();
        SqlDataReader rd = com.ExecuteReader();
        if(rd.Read())
        {
            float dtax = Convert.ToSingle(rd["tax"].ToString());
            float tax = price * 100 / (dtax + 100);
            tax =Convert.ToSingle(Math.Round(tax, 2));
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
    private void BindForPrint(string billId)
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlDataAdapter adapter = new SqlDataAdapter("select (select name from controlmst where srno=b.SalesRepId) as Name,(select city from controlmst where srno=b.SalesRepId) as City, b.Quantity,b.srno as invoice,b.orderno,b.SalesRep,a.AppMstRegNo,a.AppMstFName,b.Amount as total,b.TaxRs,TotalDp,TotalBV,b.DelCharge,b.Discount,b.ToAddress as address1," +
                    "CONVERT(varchar,b.Doe,103) as bildate,b.GrossAmt as gross,b.NetAmt,b.detail from BillMst b inner join appmst a on b.appmstid=a.AppMstID where b.srno =@id ", con);
            adapter.SelectCommand.Parameters.AddWithValue("@id", billId);
            dt = new DataTable();
            adapter.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                invoiceDate = dt.Rows[0]["bildate"].ToString();
                txtUserId.Text = dt.Rows[0]["AppMstRegNo"].ToString();
                txtUserDisp.Text = dt.Rows[0]["AppMstRegNo"].ToString();
                txtUserName.Text = dt.Rows[0]["AppMstFName"].ToString();
               lblTotalPy.Text= lblAmt.Text= txtNetAmt.Text =Math.Round(double.Parse(dt.Rows[0]["NetAmt"].ToString())).ToString("#0.00");
                Label1.Text =txtTax.Text = double.Parse(dt.Rows[0]["TaxRs"].ToString()).ToString("#0.00");
                CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
                TextInfo textInfo = cultureInfo.TextInfo;
                lblAmtWord.Text = textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(double.Parse(txtNetAmt.Text.Trim())))) + " Only";
                lblDelChrg.Text =  Convert.ToDouble(dt.Rows[0]["DelCharge"].ToString()) .ToString("#0.00");
                lblDiscount.Text = (double.Parse(dt.Rows[0]["total"].ToString()) * Convert.ToDouble(dt.Rows[0]["Discount"].ToString()) / 100).ToString("#0.00");
                lblGrossTotal.Text = double.Parse(dt.Rows[0]["gross"].ToString()).ToString("#0.00");
                lblInvoiceNo.Text =  dt.Rows[0]["invoice"].ToString();
                lblOrderNO.Text = dt.Rows[0]["orderno"].ToString();



                txtDAddress.Text = lblToAdd.Text = dt.Rows[0]["address1"].ToString();
               
                lblTotalBV.Text = double.Parse(dt.Rows[0]["TotalBV"].ToString()).ToString("#0.00");
                DataTable dt_temp = new DataTable();
                dt_temp = CreateStructure().Clone();
                //Start of creating datatable for the products
                XElement objXml = XElement.Parse(dt.Rows[0]["detail"].ToString());
                //add 10 default row
                DataRow row = null;
                double tt = 0, dd = 0, tot = 0, rr = 0, TotalWeight=0;
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
                    TotalWeight += (Convert.ToInt32(row["quantity"].ToString()) * findWeight(Convert.ToInt32(row["cd"].ToString())));
                    row["val"] = tt;
                    dt_temp.Rows.Add(row);
                    tot += tt;
                    dd += Convert.ToDouble(row["dis"].ToString());
                    rr += Convert.ToDouble(row["TaxRs"].ToString());
                }
                //End of creating datatable for the products
                lblWeight.Text = TotalWeight.ToString();
                GridView1.DataSource = dt_temp;
                GridView1.DataBind();
                ((Label)GridView1.FooterRow.FindControl("lblTaxRsTtotal")).Text = Math.Round(rr).ToString("#0.00");
                ((Label)GridView1.FooterRow.FindControl("lblDistotal")).Text = Math.Round(dd).ToString("#0.00");
                ((Label)GridView1.FooterRow.FindControl("lblValtotal")).Text = Math.Round(tot).ToString("#0.00");
                ((Label)GridView1.FooterRow.FindControl("lblQtotal")).Text = double.Parse(dt.Rows[0]["Quantity"].ToString()).ToString("#0.00");
                ((Label)GridView1.FooterRow.FindControl("lblTotal")).Text =Math.Round(double.Parse(dt.Rows[0]["total"].ToString())).ToString("#0.00");
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

    private void BindProducts()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        //ViewState["Count"] = null;
        try
        {
            DataTable dt = new DataTable();
            da = new SqlDataAdapter("select ProductName,DPWithTax,Tax,DPAmt,BVAmt as BV,MaxAllowed,productid,QTY from ShopProductMst where isdeleted=0 order by productId ", con);
            da.Fill(dt);
            if (!IsPostBack)
            {
                List<string> objProductList = new List<string>(); ;
                String strPrdPrice = string.Empty;
                strPrdPrice += "<table id='tblMRP'>";
                divMRP.InnerHtml = string.Empty;
                foreach (DataRow drw in dt.Rows)
                {
                   
                    divProduct.InnerText += drw["ProductName"].ToString() + ",";
                    strPrdPrice += "<tr><td>" + drw["ProductName"].ToString() + "</td><td>" + drw["DPWithTax"].ToString() + "</td><td>" + drw["Tax"].ToString() + "</td>" +
                        "<td>" + drw["DPAmt"].ToString() + "</td><td>" + drw["BV"].ToString() + "</td><td>" + drw["MaxAllowed"].ToString() + "</td></td><td>" + drw["productid"].ToString() + "</td><td>" + drw["QTY"].ToString() + "</td></tr>";
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
    private void BindUserID()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        //ViewState["Count"] = null;
        try
        {
            DataTable dtt = new DataTable();
            da = new SqlDataAdapter("select appmstregno,appmstfname from appmst", con);
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
        finally
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

        int orderNo = Convert.ToInt32(Request.QueryString["s"] == null ? "0" : Request.QueryString["s"].ToString());
        BindCompanyDetail(orderNo);

        if (string.IsNullOrEmpty(txtUserId.Text.Trim()))
        {
            lblMsg.Text = "Enter user ID.";
            return;
        }
        else if (string.IsNullOrEmpty(lblToAdd.Text.Trim()))
        {
            lblMsg.Text = "Delivery address not found.";
            return;
        }

        if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();

            dt = (DataTable)ViewState["product"];
            if (updateQuantity(string.Empty))
            {
                //BindGrid();
                //call method to save to database
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
            TextBox txtValue = (TextBox)row.Cells[5].FindControl("txtval");
            TextBox txtProduct = (TextBox)row.Cells[2].FindControl("txtProductNAme");
            TextBox txtQuantity = (TextBox)row.Cells[4].FindControl("txtQuantity");
            txtQuantity.ReadOnly = true;
            txtQuantity.Enabled = false;
            txtQuantity.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
            txtQuantity.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");
            txtQuantity.Attributes.Add("onchange", "javascript:void");

            txtProduct.ReadOnly = true;
            txtProduct.Enabled = false;
            txtProduct.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
            txtProduct.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");
            txtProduct.Attributes.Add("onblur", "javascript:void");


            txtDis.ReadOnly = true;
            txtDis.Enabled = false;
            txtDis.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
            txtDis.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");
            txtDis.Attributes.Add("onchange", "javascript:void");


            txtValue.ReadOnly = true;
            txtValue.Enabled = false;
            txtValue.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
            txtValue.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");
        }

        trbank.Attributes["display"] = "none";

        txtDAddress.Enabled = false;
        txtDAddress.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        txtDAddress.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        txtDelChrg.ReadOnly = true;
        txtDelChrg.Enabled = false;
        txtDelChrg.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        txtDelChrg.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        ddlpaytype.Enabled = false;
        ddlpaytype.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        ddlpaytype.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        txtDiscount.ReadOnly = true;
        txtDiscount.Enabled = false;
        txtDiscount.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        txtDiscount.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        txtNetAmt.ReadOnly = true;
        txtNetAmt.Enabled = false;
        txtNetAmt.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        txtNetAmt.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        txtUserId.ReadOnly = true;
        txtUserId.Enabled = false;
        txtUserId.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        txtUserId.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        txtUserDisp.ReadOnly = true;
        txtUserDisp.Enabled = false;
        txtUserDisp.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        txtUserDisp.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        txtUserName.ReadOnly = true;
        txtUserName.Enabled = false;
        txtUserName.Style.Add(HtmlTextWriterStyle.BorderStyle, "none");
        txtUserName.Style.Add(HtmlTextWriterStyle.BackgroundColor, "transparent");

        //objUtil =new utility();

        txtDelChrg.Visible = false;
        txtDiscount.Visible = false;
        nextbill.Visible = true;
    }

    private string SaveDetail()
    {
        double disc=0;
        string status = string.Empty;
        dt = (DataTable)ViewState["product"];
        DataTable tempDt = new DataTable();
        DateTime fromDate = new DateTime();
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

                        XElement prdXml = new XElement("P",
                           new XElement("pname", row["pname"].ToString()),
                           new XElement("cd",row["cd"].ToString()),
                           new XElement("dis",row["dis"].ToString()),
                           new XElement("Qnt", row["quantity"].ToString()),
                            new XElement("MRP", row["DPWT"].ToString()),
                            new XElement("TAX", row["Tax"].ToString()),
                            new XElement("TAXRS", row["TaxRs"].ToString()),
                            new XElement("DP", row["DP"].ToString()),
                             new XElement("BV", row["BV"].ToString()),
                              new XElement("total", row["total"].ToString()));
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
                utility.MessageBox(this, "First Bill can't Less than 1200.");
                return "First Bill can't Less than 1200.";
            }
            if (element == null || amt == 0)
            {
                BindGrid();
                return "Please eneter the product and quantity properly.";
            }
            var xmlObject = new XmlDocument();
            xmlObject.LoadXml(element.ToString());
            con = new SqlConnection(method.str);
            com = new SqlCommand("AddBill", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regno", txtUserId.Text.Trim());
            com.Parameters.AddWithValue("@count", tempDt.Rows.Count);
            com.Parameters.AddWithValue("@amt", amt);
            com.Parameters.AddWithValue("@gross", grosstotal);

            com.Parameters.AddWithValue("@Qnty", TotalQnty);
            com.Parameters.AddWithValue("@ToalTaxPer", TotalTaxPer);
            com.Parameters.AddWithValue("@TotalTaxRs", TotalTaxRs);
            com.Parameters.AddWithValue("@TotalDP", TotalDP);
            com.Parameters.AddWithValue("@TotalBV", TotalBV);

            com.Parameters.AddWithValue("@delChrg", DelCharge);
            com.Parameters.AddWithValue("@disAmt", disc);
            com.Parameters.AddWithValue("@NetAmt", NetAmt);
            com.Parameters.AddWithValue("@soldTo", txtUserId.Text.Trim());
            com.Parameters.AddWithValue("@saleRep", Session["admin"].ToString());
            com.Parameters.AddWithValue("@toAdd",String.IsNullOrEmpty(txtDAddress.Text)?lblToAdd.Text:txtDAddress.Text);
            com.Parameters.AddWithValue("@offId",string.IsNullOrEmpty(ViewState["offerno"].ToString()) ? 0 :Convert.ToInt32(ViewState["offerno"].ToString()));
            com.Parameters.AddWithValue("@bankname",txtbname.Text);
            com.Parameters.AddWithValue("@checkdate", fromDate);
            com.Parameters.AddWithValue("@checkno", txtDD.Text);
            com.Parameters.AddWithValue("@paymode",ddlpaytype.SelectedItem.Text);
            com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
            com.Parameters.AddWithValue("@orderno", lblOrderNO.Text.Trim());
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            status = com.Parameters["@flag"].Value.ToString();
            string invoiceNo = com.Parameters["@InvNo"].Value.ToString();
            if (status == "1")
            {
                objUtil = new utility();
                UpdateStock(tempDt);
                Response.Redirect("PrintBill.aspx?id=" + objUtil.base64Encode(invoiceNo));
                ViewState["product"] = tempDt;
                lblInvoiceNo.Text = invoiceNo;
                BindGrid();
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
            com = new SqlCommand("select (select top 1 logoimg from BillSetting) as logoURL, city, companyname,[address] as caddress,(case when @ordId>0 then (select ToAddress  from OrderMst where srno=@ordId) else (select appmstaddress1+space(1)+appmstcity+'<br/>'+appmststate+space(1)+appmstpincode+'<br/>'+'Contact No-'+Appmstmobile from AppMst where AppMstRegNo=@regno) end) as orAddress,phone,11 as InvNo,convert(varchar,DATEADD(MINUTE,330,GETUTCDATE()),103) as cdate," +
             "(select name from controlmst  where username=@uname) as SalesRep,(select city from controlmst  where username=@uname) as Scity,(select top 1 tax from BillSetting) as tax, (select top 1 cinno from paymentmst) as cinno,  (select top 1 panno from paymentmst) as panno," +
             "(select top 1 delivery from BillSetting) as delivery,(select top 1 Discount from BillSetting) as Discount,website,emailid,TinNo from PaymentMst ", con);
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
                lbltinno.Text = reader["TinNo"].ToString();
                lblcinno.Text = reader["cinno"].ToString();
                lblpan.Text = reader["panno"].ToString();
                lblCompName.Text = lblComName.Text;
                lblCity.Text = reader["city"].ToString();
                lblCity2.Text = reader["city"].ToString();
                if (Request.QueryString["id"] == null)
                lblToAdd.Text = reader["orAddress"].ToString();
                imgLogo.ImageUrl = "../images/" + reader["logoURL"].ToString();
                lblLeftHead.Text = string.Empty;
                int i = 0;
                lblCompanyAdd.Text = "<b>Registerd Office</b>:" + reader["caddress"].ToString().Replace("<br/>"," ");
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
            cmd.CommandText = "select appmsttitle+space(1)+appmstfname as name from appmst where appmstregno=@regno";
            cmd.Parameters.AddWithValue("@regno", eventArguments.Trim());
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                strajax = Convert.ToString(dr["name"]);
                Session["sname"] = Convert.ToString(dr["name"]);

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
                        { int MaxA=0;
                            MaxA=Convert.ToInt32(reader["MaxAllowed"].ToString());
                            if (Convert.ToInt32(txtQuantity.Text)>MaxA )
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
                        double taxRs=0.0;
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
                            drow["val"] = (mrp * Convert.ToInt32(text)-Convert.ToDouble(dis.Text)).ToString();
                            drow["Tax"] = float.Parse(string.IsNullOrEmpty(Tax.Text.Trim()) ? "0" : Tax.Text.Trim());
                            drow["TaxRs"] = taxRs.ToString("#0.00");
                            //drow["DP"] = float.Parse(string.IsNullOrEmpty(DP.Text.Trim()) ? "0" : DP.Text.Trim());
                            drow["BV"] = float.Parse(string.IsNullOrEmpty(BV.Text.Trim()) ? "0" : BV.Text.Trim());
                            drow["pname"] = strProduct;
                            drow.EndEdit();
                        }
                        //Recalculate total column
                        drow["gtotal"] = Convert.ToDouble(string.IsNullOrEmpty(drow["quantity"].ToString()) ? "0" : drow["quantity"].ToString()) * Convert.ToDouble(string.IsNullOrEmpty(drow["DPWT"].ToString()) ? "0" : drow["DPWT"].ToString()) - Convert.ToDouble(dis.Text);
                        drow["total"] =Math.Round(taxRs + Convert.ToDouble(string.IsNullOrEmpty(drow["DPWT"].ToString()) ? "0" : drow["DPWT"].ToString()) * Convert.ToDouble(string.IsNullOrEmpty(drow["quantity"].ToString()) ? "0" : drow["quantity"].ToString()) - Convert.ToDouble(dis.Text));
                    }
                }
            }
            offerProduct();
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
        com = new SqlCommand("select tax,dpamt from shopproductmst where productid=@pid",con);
        com.Parameters.AddWithValue("@pid",id);
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
       DataTable ppp=productoffer(Convert.ToInt32(selectedGender));
        for (int i = 0; i < ppp.Rows.Count; i++)
        {

               ViewState["offerno"] = ppp.Rows[i]["offerno"].ToString();
               DataRow dr = offerP.NewRow();
               DataTable ftax = findtax(Convert.ToInt32(ppp.Rows[i]["productid"].ToString()));
               float dtax = Convert.ToSingle(ftax.Rows[0]["tax"].ToString());
               float tax = ((Convert.ToSingle(ppp.Rows[i]["pamount"].ToString())) * 100 / (dtax+100));//* Convert.ToInt32(ppp.Rows[i]["quantity"].ToString());
               dr["pname"] = ppp.Rows[i]["productname"].ToString();
               //dr["DPWT"] = Convert.ToSingle(ppp.Rows[i]["pamount"].ToString());
               dr["DPWT"] = Convert.ToSingle(ftax.Rows[0]["dpamt"].ToString());
               dr["cd"] = ppp.Rows[i]["productid"].ToString();
               dr["val"] = tax.ToString();
               tax = Convert.ToSingle(Math.Round(tax,2));
               dr["dis"] = Convert.ToSingle(ftax.Rows[0]["dpamt"].ToString())-tax;
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

    /// <summary>
    /// 
    /// </summary>
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
            dt.Rows.Add(dt.NewRow());
            ViewState["product"] = dt;
        }
        GridView1.DataSource = dt;
        GridView1.DataBind();
        CalculateTotal(dt);
    }
    private double findWeight(int id)
    {
        con = new SqlConnection(method.str);
        DaProduct = new SqlDataAdapter("select weight from shopproductmst where productid=@id", con);
        DaProduct.SelectCommand.Parameters.AddWithValue("@id",id);
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
            double TotalWeight = 0;
            ((Label)GridView1.FooterRow.FindControl("lblQtotal")).Text = double.Parse(dtt.Compute("sum(quantity)", "true").ToString().Trim()).ToString("#0.00");
            Total =Math.Round(double.Parse(dt.Compute("sum(val)", "true").ToString().Trim()));
            
            ((Label)GridView1.FooterRow.FindControl("lblTotal")).Text =Math.Round(Total).ToString("#0.00");
            grosstotal =Math.Round (double.Parse(dtt.Compute("sum(gtotal)", "true").ToString().Trim()));
            lblGrossTotal.Text = grosstotal.ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblDistotal")).Text =double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim()).ToString("#0.00");
            txtDiscount.Text = double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim()).ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblValtotal")).Text =Math.Round(double.Parse(dtt.Compute("sum(val)", "true").ToString().Trim())).ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblTaxRsTtotal")).Text =Math.Round(double.Parse(dtt.Compute("sum(TaxRs)", "true").ToString().Trim())).ToString("#0.00");
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

                TotalBV += (qnt * BV);
                TotalDP += (qnt * price);
            }
            TotalDP =TotalDP-double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim());
            lblWeight.Text = TotalWeight.ToString();
            CheckPiad();
            Total += TotalTaxRs;
            Label1.Text =Math.Round(TotalTaxRs).ToString();
            ((Label)GridView1.FooterRow.FindControl("lblTotal")).Text =Math.Round(Total).ToString("#0.00");
            lblTotalBV.Text = TotalBV.ToString();
            txtTax.Text =Math.Round(TotalTaxRs).ToString("#0.00");
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
            lblAmtWord.Text ="(Rupees "+ textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(Math.Round(NetAmt)))) + " Only)";
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
                if (Convert.ToInt32(reader["cnt"].ToString()) ==0)
                {
                    CheckRes = "0";
                    if (TotalDP < 1200)
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
               if (PId !="0" && qnt !=0)
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
}



