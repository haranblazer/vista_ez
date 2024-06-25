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

public partial class franchise_PurchaseOrderForm : System.Web.UI.Page
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
    int ypin, paid;
    DataUtility objDUT;
    string invoiceDate, CheckRes = string.Empty, strOffer;

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (Session["username"] == null)
            {
                Response.Redirect("../Default.aspx");
            }
            lblMsg.Text = string.Empty;
            if (!IsPostBack)
            {

                txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                bindfranchise();
                CheckBillStartDate();
                BindProducts();

                BindGrid();

                Session["CheckRefresh"] = System.DateTime.Now.ToString();

                int orderNo = 0;
                BindCompanyDetail(orderNo);

            }
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



    protected void btnGenerateBill_Click(object sender, EventArgs e)
    {
        int orderNo = Convert.ToInt32(Request.QueryString["s"] == null ? "0" : Request.QueryString["s"].ToString());
        BindCompanyDetail(orderNo);

        if (ddlbindfrantype.SelectedValue.ToString() == "0")
        {
            lblMsg.Text = "Enter user ID.";
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
                    //MakeReadOnly();
                }
                else
                    lblMsg.Text = strReturn;
            }
        }
    }

    private string SaveDetail()
    {
        string status = string.Empty;
        dt = (DataTable)ViewState["product"];

        DataTable tempDt = new DataTable();
        DataTable Pbatch = null;
        tempDt = dt.Copy();
        if (tempDt != null)
        {

            string ss = "SELECT city=State, State=(select State from FranchiseMst WHERE FranchiseId ='" + ddlbindfrantype.SelectedValue.ToString() + "') from FranchiseMst WHERE FranchiseId ='" + Session["franchiseid"].ToString() + "'";
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand(ss, con);
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dtc = new DataTable();
            adp.Fill(dtc);

            double amt = 0;//Convert.ToDouble(dt.Compute("sum(total)","1").ToString());
            XElement element = null;
            //  make xml node and calculate amount

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
                    int qnt = 0;
                    if (row["pname"].ToString().Trim().Length > 0 && Convert.ToInt32(string.IsNullOrEmpty(row["quantity"].ToString().Trim()) ? "0" : row["quantity"].ToString().Trim()) > 0)
                    {

                        float itax = 0, taxi = 0, ctax = 0, taxc = 0, stax = 0, taxs = 0;
                        string buyerstate = dtc.Rows[0]["State"].ToString().ToUpper();
                        string sellerstate = dtc.Rows[0]["city"].ToString().ToUpper();


                        Pbatch = (DataTable)ViewState["orderproduct"];
                        string batchid = (Pbatch.AsEnumerable().Where(p => p["ProductName"].ToString() == row["pname"].ToString()).Select(p => p["batchid"].ToString())).FirstOrDefault();

                        qnt = Convert.ToInt32(string.IsNullOrEmpty(row["quantity"].ToString()) ? "0" : row["quantity"].ToString());
                        amt += Convert.ToDouble(string.IsNullOrEmpty(row["DPWT"].ToString()) ? "0" : row["DPWT"].ToString()) * qnt;
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
                           new XElement("total", row["total"].ToString()),
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
                grosstotal = double.Parse(dt.Compute("sum(val)", "true").ToString().Trim());
                CalculateTotal(tempDt);

            }

            if (element == null || amt == 0)
            {
                BindGrid();
                return "Please eneter the product and quantity properly.";

            }


            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            string fromDate = "";
            try
            {
                fromDate = Convert.ToDateTime(txtDate.Text.Trim(), dateInfo).ToString();
            }
            catch
            {
                utility.MessageBox(this, "Invalid Date !!!");
            }


            var xmlObject = new XmlDocument();
            xmlObject.LoadXml(element.ToString());
            con = new SqlConnection(method.str);
            com = new SqlCommand("StockTransfer", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@count", tempDt.Rows.Count);
            com.Parameters.AddWithValue("@amt", amt);
            com.Parameters.AddWithValue("@gross", grosstotal);
            com.Parameters.AddWithValue("@Qnty", TotalQnty);
            com.Parameters.AddWithValue("@TotalTaxRs", TotalTaxRs);
            com.Parameters.AddWithValue("@TotalDP", TotalDP);
            com.Parameters.AddWithValue("@TotalBV", TotalBV);
            com.Parameters.AddWithValue("@delChrg", DelCharge);
            com.Parameters.AddWithValue("@disAmt", Discount);
            com.Parameters.AddWithValue("@NetAmt", NetAmt);
            com.Parameters.AddWithValue("@soldTo", ddlbindfrantype.SelectedValue.ToString());
            com.Parameters.AddWithValue("@saleRep", Session["franchiseid"].ToString());
            com.Parameters.AddWithValue("@toAdd", lblToAdd.Text);
            com.Parameters.AddWithValue("@bankname", txtbname.Text);
            com.Parameters.AddWithValue("@checkdate", fromDate);
            com.Parameters.AddWithValue("@checkno", txtDD.Text);
            com.Parameters.AddWithValue("@paymode", ddlpaytype.SelectedItem.Text);
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
                Response.Redirect("StockTranBill.aspx?inv=" + invoiceNo);
            }
            else
            {
                utility.MessageBox(this, status);
            }



            //com = new SqlCommand("AddOrder", con);
            //com.CommandType = CommandType.StoredProcedure;
            //com.Parameters.AddWithValue("@regno", Session["franchiseid"].ToString());
            //com.Parameters.AddWithValue("@count", tempDt.Rows.Count);
            //com.Parameters.AddWithValue("@amt", amt);
            //com.Parameters.AddWithValue("@toAdd", txtDAddress.Text.Trim());
            //com.Parameters.AddWithValue("@orderto", ddlbindfrantype.SelectedValue.ToString());
            //com.Parameters.AddWithValue("@BV", 0);
            //if (ddlpaytype.SelectedValue.ToString() != "1")
            //{
            //    System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            //    dateInfo.ShortDatePattern = "dd/MM/yyyy";
            //    string date = "";
            //    try
            //    {
            //        date = Convert.ToDateTime(txtDate.Text.Trim(), dateInfo).ToString();
            //    }
            //    catch
            //    {
            //        utility.MessageBox(this, "Invalid Date !!!");

            //    }

            //    com.Parameters.AddWithValue("@BankName", txtbname.Text.Trim());
            //    com.Parameters.AddWithValue("@TranNo", txtDD.Text.Trim());
            //    com.Parameters.AddWithValue("@TranDate", date);
            //    com.Parameters.AddWithValue("@PaymentMode", ddlpaytype.SelectedItem.Text.ToString());
            //}
            //else
            //{
            //    com.Parameters.AddWithValue("@TranDate", DateTime.Now.ToString());
            //    com.Parameters.AddWithValue("@PaymentMode", ddlpaytype.SelectedItem.Text.ToString());
            //}
            //com.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
            //com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            //com.Parameters.Add("@InvNo", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            //com.Parameters.AddWithValue("@UploadSlipName", "");
            //con.Open();
            //com.ExecuteNonQuery();
            //status = com.Parameters["@flag"].Value.ToString();
            //string OrderNo = com.Parameters["@InvNo"].Value.ToString();
            //if (status == "1")
            //{
            //    con.Close();
            //    Response.Redirect("purchaseorderbill.aspx?id=" + OrderNo);
            //}
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

            com = new SqlCommand("select b.logoimg as logoURL,'TopTime For Franchise' as companyname ,f.fname + '</br>' + f.address + '</br>' + f.city + space(2)+ f.state as caddress ,f.fname as caddress,p.city as city, f.address as orAddress,f.fname as  SalesRep,f.email ,f.primaryphone,f.tinno,f.cinno,f.panno,f.mobile as phone,f.city as scity, b.tax ,convert(varchar,DATEADD(MINUTE,330,GETUTCDATE()),103) as cdate,delivery,Discount from paymentmst p,billsetting b,franchisemst f where f.username=@funame", con);

            //pass session id

            com.Parameters.AddWithValue("@funame", Session["UserName"].ToString());
            com.Parameters.AddWithValue("@ordId", orderNo);
            com.Parameters.AddWithValue("@regno", ddlbindfrantype.SelectedValue.ToString());
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
                lblCity.Text = reader["Scity"].ToString();
                lblCity2.Text = reader["Scity"].ToString();
                if (Request.QueryString["id"] == null)
                    lblToAdd.Text = reader["orAddress"].ToString();

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


                lblLeftHead.Text += "</br> Email : " + reader["email"].ToString();
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
            double TotalWeight = 0;
            ((Label)GridView1.FooterRow.FindControl("lblQtotal")).Text = double.Parse(dtt.Compute("sum(quantity)", "true").ToString().Trim()).ToString("#0.00");
            Total = Math.Round(double.Parse(dt.Compute("sum(val)", "true").ToString().Trim()));

            ((Label)GridView1.FooterRow.FindControl("lblTotal")).Text = Math.Round(Total).ToString("#0.00");
            grosstotal = Math.Round(double.Parse(dtt.Compute("sum(val)", "true").ToString().Trim()));
            lblGrossTotal.Text = grosstotal.ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblDistotal")).Text = double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim()).ToString("#0.00");
            txtDiscount.Text = double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim()).ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblValtotal")).Text = Math.Round(double.Parse(dtt.Compute("sum(val)", "true").ToString().Trim())).ToString("#0.00");
            ((Label)GridView1.FooterRow.FindControl("lblTaxRsTtotal")).Text = Math.Round(double.Parse(dtt.Compute("sum(TaxRs)", "true").ToString().Trim())).ToString("#0.00");
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
                TotalDP += (qnt * DP);
            }
            TotalDP = TotalDP - double.Parse(dtt.Compute("sum(dis)", "true").ToString().Trim());
            lblWeight.Text = TotalWeight.ToString();

            //CheckPiad();
            Total += TotalTaxRs;
            //Label1.Text = Math.Round(TotalTaxRs).ToString();
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
            //txtDelChrg.Text = DelCharge;
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex >= 0)
        {
            ((TextBox)e.Row.Cells[4].FindControl("txtQuantity")).Attributes.Add("onchange", "javascript:calculate(" + (e.Row.RowIndex + 2).ToString() + ",this)");
            ((TextBox)e.Row.Cells[2].FindControl("txtcode")).Attributes.Add("onblur", "javascript:ShowMRPonPCode(" + (e.Row.RowIndex + 2).ToString() + ",this)");
            ((TextBox)e.Row.Cells[2].FindControl("txtProductNAme")).Attributes.Add("onblur", "javascript:ShowMRP(" + (e.Row.RowIndex + 2).ToString() + ",this)");
            ((TextBox)e.Row.Cells[5].FindControl("txtDis")).Attributes.Add("onchange", "javascript:calculate(" + (e.Row.RowIndex + 2).ToString() + ",this)");
        }
    }
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
                            drow["DP"] = mrp;
                            drow["DPWT"] = Convert.ToDouble(MRP.Text) + Math.Round((mrp * taxValue / 100), 2);
                            drow["cd"] = cd.Text;
                            drow["val"] = (mrp * Convert.ToInt32(text) - Convert.ToDouble(dis.Text)).ToString();
                            drow["Tax"] = float.Parse(string.IsNullOrEmpty(Tax.Text.Trim()) ? "0" : Tax.Text.Trim());
                            drow["TaxRs"] = taxRs.ToString("#0.00");
                            //drow["DP"] = float.Parse(string.IsNullOrEmpty(DP.Text.Trim()) ? "0" : DP.Text.Trim());
                            drow["BV"] = float.Parse(string.IsNullOrEmpty(BV.Text.Trim()) ? "0" : BV.Text.Trim());
                            drow["pname"] = strProduct;
                            drow.EndEdit();


                            drow.EndEdit();
                        }
                        //Recalculate total column
                        drow["gtotal"] = Convert.ToDouble(string.IsNullOrEmpty(drow["quantity"].ToString()) ? "0" : drow["quantity"].ToString()) * Convert.ToDouble(string.IsNullOrEmpty(drow["DPWT"].ToString()) ? "0" : drow["DPWT"].ToString()) - Convert.ToDouble(dis.Text);
                        drow["total"] = Math.Round(Convert.ToDouble(string.IsNullOrEmpty(drow["DPWT"].ToString()) ? "0" : drow["DPWT"].ToString()) * Convert.ToDouble(string.IsNullOrEmpty(drow["quantity"].ToString()) ? "0" : drow["quantity"].ToString()) - Convert.ToDouble(dis.Text));
                    }
                }
            }
        }
        return status;
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

    private void BindProducts()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        //ViewState["Count"] = null;
        try
        {
            DataTable dt = new DataTable();
            da = new SqlDataAdapter("bindorderproduct", con);
            da.SelectCommand.Parameters.AddWithValue("@franchiseid", Session["franchiseid"].ToString());
            //da.SelectCommand.Parameters.AddWithValue("@distype", int.Parse(Session["frantypeid"].ToString()));
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.Fill(dt);

            ViewState["orderproduct"] = dt;
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
        catch
        {
        }
        finally
        {
        }
    }



    public void bindfranchise()
    {

        con = new SqlConnection(method.str);
        SqlDataAdapter sda = new SqlDataAdapter("purchaseorderuser", con);
        sda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sda.SelectCommand.Parameters.AddWithValue("@regno", Session["franchiseid"].ToString());
        DataTable BindFUser = new DataTable();
        sda.Fill(BindFUser);
        ddlbindfrantype.DataTextField = "name";
        ddlbindfrantype.DataValueField = "id";
        ddlbindfrantype.DataSource = BindFUser;
        ddlbindfrantype.DataBind();
        ddlbindfrantype.Items.Insert(0, new ListItem("Select", "0"));

    }

}



