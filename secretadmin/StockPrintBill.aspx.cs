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
using System.Drawing;

public partial class admin_StockPrintBill : System.Web.UI.Page
{

    SqlConnection con = null;
    SqlDataAdapter Da;
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
    static int type = 0;
    int status, taxtype;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            objUtil = new utility();
            if (Request.QueryString["id"] != null)
            {

                if (Request.QueryString["st"].ToString() != null)
                {
                    status = Convert.ToInt32(Request.QueryString["st"].ToString());
                    taxtype = Convert.ToInt32(Request.QueryString["ttype"].ToString());
                    if (status == 1)
                    {
                        BindForPrint(Request.QueryString["id"].ToString());
                        bill();
                    }


                    if (status == 0)
                    {
                        Label2.Text = "Cancelled Bill";
                        Label2.ForeColor = Color.Red;
                        BindForPrint(Request.QueryString["id"].ToString());
                        bill();
                    }

                    lbltaxtype.Text = taxtype == 2 ? "CST" : "VAT";
                    lblTotalBV.Text = "0";

                }


            }



        }
    }

    public void bill()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("taxstockbill", con);
        com.Parameters.AddWithValue("@srno", Convert.ToInt32(Request.QueryString["id"]));
        com.CommandType = CommandType.StoredProcedure;
        con.Open();
        Da = new SqlDataAdapter(com);
        DataTable table = new DataTable();
        Da.Fill(table);
        if (table.Rows.Count > 0)
        {

            dglst.DataSource = table;
            dglst.DataBind();

        }
        else
        {

            dglst.DataSource = null;
            dglst.DataBind();
        }

    }
    protected void nextbill_Click(object sender, EventArgs e)
    {
        Response.Redirect("billingform.aspx");
    }
    private void BindCompanyDetail(int orderNo)
    {
        con = new SqlConnection(method.str);
        try
        {
            com = new SqlCommand("bindbilldetail", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@invoice", orderNo);
            com.Parameters.AddWithValue("@action", "Company");
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
                lblCity.Text = reader["oraddress"].ToString();
                lblCity2.Text = reader["oraddress"].ToString();

                lblcity3.Text = reader["city"].ToString();
                if (Request.QueryString["id"] == null)
                    lblToAdd.Text = reader["orAddress"].ToString();
                imgLogo.ImageUrl = "../images/" + reader["logoURL"].ToString();

                //lblLeftHead.Text = string.Empty;
                int i = 0;
                lblCompanyAdd.Text = "<b>Registerd Office</b>:" + reader["orAddress"].ToString().Replace("<br/>", " ");
                //foreach (string add in reader["caddress"].ToString().Split(','))
                //{
                //    lblLeftHead.Text += add + ",";
                //    if (i == 1)
                //        lblLeftHead.Text += "";
                //    i++;
                //}
                lblLeftHead.Text += "</br>" + reader["oraddress"].ToString();
                lblLeftHead.Text += "</br>Tel : " + reader["phone"].ToString();
                lblLeftHead.Text += "</br> Email : " + reader["emailid"].ToString();
                //right heade
                //lblRightHead.Text = reader["InvNo"].ToString();
                //lblRightHead.Text = string.Empty;
                //lblRightHead.Text += "" + (Request.QueryString["id"] != null ? invoiceDate : reader["cdate"].ToString());
                lblBillFooter.Text = "THANKS FOR YOUR BUSINESS!";
                if (!IsPostBack && Request.QueryString["id"] == null)
                {
                    //txtDelChrg.Text = reader["delivery"].ToString().Trim();
                    //txtDiscount.Text = reader["Discount"].ToString().Trim();
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
    private double findWeight(int id)
    {
        con = new SqlConnection(method.str);
        Da = new SqlDataAdapter("select weight from shopproductmst where productid=@id", con);
        Da.SelectCommand.Parameters.AddWithValue("@id", id);
        DataTable dtweight = new DataTable();
        Da.Fill(dtweight);
        if (dtweight.Rows.Count > 0)
        {
            return (Convert.ToDouble(dtweight.Rows[0]["weight"].ToString()));
        }
        else
            return (0);
    }
    private void BindForPrint(string billId)
    {
        try
        {


         

            con = new SqlConnection(method.str);           
            SqlDataAdapter adapter = new SqlDataAdapter("bindbilldetail", con);
            adapter.SelectCommand.Parameters.AddWithValue("@invoice", billId);
            adapter.SelectCommand.Parameters.AddWithValue("@action", "Bill");
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            dt = new DataTable();
            adapter.Fill(dt);

            if (dt.Rows.Count > 0)
            {
              
                //lblp.Text = " " + dt.Rows[0]["Name"].ToString().ToUpper(); ;
                txtDAddress.Text = dt.Rows[0]["address1"].ToString();
                //lblscheme.Text = " The scheme products at Rs. " + 1 + " in the Invoice cannot be returned or exchanged.";
                //ddltype.Text = dt.Rows[0]["paymode"].ToString();
                invoiceDate = dt.Rows[0]["bildate"].ToString();
                lblRightHead.Text = dt.Rows[0]["bildate"].ToString();
                txtUserId.Text = dt.Rows[0]["AppMstRegNo"].ToString();
                //txtUserDisp.Text = dt.Rows[0]["AppMstRegNo"].ToString();
                txtUserName.Text = dt.Rows[0]["AppMstFName"].ToString();
                Label3.Text = dt.Rows[0]["mobile"].ToString();
                lblTotalPy.Text = lblAmt.Text = txtNetAmt.Text = Math.Round(double.Parse(dt.Rows[0]["NetAmt"].ToString())).ToString("#0.00");
                Label1.Text = txtTax.Text = double.Parse(dt.Rows[0]["TaxRs"].ToString()).ToString("#0.00");
                CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
                TextInfo textInfo = cultureInfo.TextInfo;
                lblAmtWord.Text = "(Rupees " + textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(double.Parse(txtNetAmt.Text.Trim())))) + " Only)";
                lblDelChrg.Text = Convert.ToDouble(dt.Rows[0]["DelCharge"].ToString()).ToString("#0.00");
                lblDiscount.Text = (double.Parse(dt.Rows[0]["total"].ToString()) * Convert.ToDouble(dt.Rows[0]["Discount"].ToString()) / 100).ToString("#0.00");
                lblGrossTotal.Text = double.Parse(dt.Rows[0]["gross"].ToString()).ToString("#0.00");
                lblInvoiceNo.Text = dt.Rows[0]["invoice"].ToString();
                lblOrderNO.Text = dt.Rows[0]["orderno"].ToString();

                txtDAddress.Text = lblToAdd.Text = dt.Rows[0]["address1"].ToString();

                lblTotalBV.Text = double.Parse(dt.Rows[0]["TotalBV"].ToString()).ToString("#0.00");
                DataTable dt_temp = new DataTable();
                dt_temp = CreateStructure().Clone();
                //Start of creating datatable for the products
                XElement objXml = XElement.Parse(dt.Rows[0]["detail"].ToString());
                //add 10 default row
                DataRow row = null;
                double tt = 0, dd = 0, tot = 0, rr = 0, TotalWeight = 0;
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
                lblWeight.Text = TotalWeight.ToString("#0.00");
                GridView1.DataSource = dt_temp;
                GridView1.DataBind();
                ((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblTaxRsTtotal")).Text = rr.ToString("#0.00");
                ((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblDistotal")).Text = dd.ToString("#0.00");
                ((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblValtotal")).Text = tot.ToString("#0.00");
                ((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblQtotal")).Text = double.Parse(dt.Rows[0]["Quantity"].ToString()).ToString();
                ((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblTotal")).Text = Math.Round(double.Parse(dt.Rows[0]["total"].ToString())).ToString("#0.00");
            }

            //make the textBoxes read only to get print out
            //MakeReadOnly();
            checkUser(dt.Rows[0]["Name"].ToString());
            trbank.Attributes["display"] = "none";
            txtDelChrg.Visible = false;
            txtDiscount.Visible = false;
            nextbill.Visible = true;



        }
        catch (Exception ex)
        {
        }
    }
    void checkUser(string uname)
    {
        string username = string.Empty;
        con = new SqlConnection(method.str);
        Da = new SqlDataAdapter("select username from controlmst where username=@uname", con);
        Da.SelectCommand.Parameters.AddWithValue("uname", uname);
        dt = new DataTable();
        Da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            type = 1;
        }
        else
        {
            type = 0;
        }
        int orderNo = Convert.ToInt32(Request.QueryString["id"] == null ? "0" : Request.QueryString["id"].ToString());
        BindCompanyDetail(orderNo);
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
}