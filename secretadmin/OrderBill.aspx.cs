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


public partial class secretadmin_OrderBill : System.Web.UI.Page
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
    int status;
    string invoiceno = "";
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!Page.IsPostBack)
        {

            objUtil = new utility();
            if (Request.QueryString["id"] != null)
            {
                status = Convert.ToInt32(Request.QueryString["st"].ToString());
                invoiceno = Request.QueryString["id"].ToString();


                if (Request.QueryString["st"].ToString() != null)
                {
                    if (status == 1)
                    {

                        BindForPrint(invoiceno);
                        BindCompanyDetail(int.Parse(invoiceno));
                        bill();
                    }






                }


            }



        }
    }

    public void bill()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("abc", con);
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



    private void BindForPrint(string billId)
    {
        try
        {


            con = new SqlConnection(method.str);
            // SqlDataAdapter adapter = new SqlDataAdapter("select  b.salesrep as Name,b.Quantity,b.paymode,a.appmstmobile,b.invoiceno as invoice,b.orderno,b.SalesRep,a.AppMstRegNo,a.AppMstFName,b.Amount as total,b.TaxRs,TotalDp,TotalBV,b.DelCharge,b.Discount,b.ToAddress as address1," +
            //"CONVERT(varchar,b.Doe,103) as bildate,b.GrossAmt as gross,b.NetAmt,b.detail from BillMst b  inner join appmst a on b.appmstid=a.AppMstID where b.srno=@id ", con);
            // adapter.SelectCommand.Parameters.AddWithValue("@id", billId);

            SqlDataAdapter adapter = new SqlDataAdapter("printorderbill", con);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@invoice", Convert.ToInt32(billId));
            adapter.SelectCommand.Parameters.AddWithValue("@action", "");
            dt = new DataTable();
            adapter.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                Label3.Text = dt.Rows[0]["appmstmobile"].ToString();
                lblRightHead.Text = dt.Rows[0]["bildate"].ToString();
                //lblp.Text = " " + dt.Rows[0]["Name"].ToString().ToUpper(); ;
                txtDAddress.Text = dt.Rows[0]["toaddress"].ToString();
                //   lblscheme.Text = " The scheme products at Rs. " + 1 + " in the Invoice cannot be returned or exchanged.";
                ddltype.Text = dt.Rows[0]["paymentmode"].ToString();
                invoiceDate = dt.Rows[0]["bildate"].ToString();
                txtUserId.Text = dt.Rows[0]["AppMstRegNo"].ToString();
                //txtUserDisp.Text = dt.Rows[0]["AppMstRegNo"].ToString();
                txtUserName.Text = dt.Rows[0]["AppMstFName"].ToString();
                lblTotalBV.Text = dt.Rows[0]["TotalBV"].ToString();
                lblTotalPy.Text = lblAmt.Text = txtNetAmt.Text = Math.Round(double.Parse(dt.Rows[0]["NetAmt"].ToString())).ToString("#0.00");

                CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
                TextInfo textInfo = cultureInfo.TextInfo;
                lblAmtWord.Text = "(Rupees " + textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(double.Parse(txtNetAmt.Text.Trim())))) + " Only)";
                // lblDelChrg.Text = Convert.ToDouble(dt.Rows[0]["DelCharge"].ToString()).ToString("#0.00");
                // lblDiscount.Text = (double.Parse(dt.Rows[0]["total"].ToString()) * Convert.ToDouble(dt.Rows[0]["Discount"].ToString()) / 100).ToString("#0.00");
                // lblGrossTotal.Text = double.Parse(dt.Rows[0]["gross"].ToString()).ToString("#0.00");
                lblInvoiceNo.Text = dt.Rows[0]["invoice"].ToString();
                //lblOrderNO.Text = dt.Rows[0]["orderno"].ToString();

                lblToAdd.Text = dt.Rows[0]["address1"].ToString();

                // lblTotalBV.Text = double.Parse(dt.Rows[0]["TotalBV"].ToString()).ToString("#0.00");
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



                    row["dis"] = p.Elements("dis").FirstOrDefault() != null ? p.Elements("dis").FirstOrDefault().Value : string.Empty;
                    row["cd"] = p.Elements("cd").FirstOrDefault() != null ? p.Elements("cd").FirstOrDefault().Value : string.Empty;
                    row["pname"] = p.Elements("pname").FirstOrDefault() != null ? p.Elements("pname").FirstOrDefault().Value : string.Empty;
                    row["quantity"] = p.Elements("Qnt").FirstOrDefault() != null ? p.Elements("Qnt").FirstOrDefault().Value : string.Empty;
                    row["DPWT"] = p.Elements("MRP").FirstOrDefault() != null ? p.Elements("MRP").FirstOrDefault().Value : string.Empty;

                    row["BV"] = Convert.ToInt32(row["quantity"]) * Convert.ToInt32(p.Elements("BV").FirstOrDefault() != null ? p.Elements("BV").FirstOrDefault().Value : string.Empty);
               
                    // row["BV"] = p.Elements("BV").FirstOrDefault() != null ? p.Elements("BV").FirstOrDefault().Value : string.Empty;
                    row["total"] = p.Elements("total").FirstOrDefault() != null ? p.Elements("total").FirstOrDefault().Value : string.Empty;
                    row["Tax"] = p.Elements("TAX").FirstOrDefault() != null ? p.Elements("TAX").FirstOrDefault().Value : string.Empty;
                    row["TaxRs"] = p.Elements("TAXRS").FirstOrDefault() != null ? p.Elements("TAXRS").FirstOrDefault().Value : string.Empty;
                    row["DP"] = p.Elements("DP").FirstOrDefault() != null ? p.Elements("DP").FirstOrDefault().Value : string.Empty;
                    tt = Convert.ToDouble(row["DP"].ToString()) * Convert.ToDouble(row["quantity"].ToString()) - Convert.ToDouble(row["dis"].ToString());
                    TotalWeight += (Convert.ToInt32(row["quantity"].ToString()) * findWeight(Convert.ToInt32(row["cd"].ToString())));
                    row["val"] = tt;


                    dt_temp.Rows.Add(row);
                    tot += tt;
                    dd += Convert.ToDouble(row["dis"].ToString());
                    rr += Convert.ToDouble(row["TaxRs"].ToString());

                    //  dd += Convert.ToDouble(row["dis"].ToString());
                    // rr += Convert.ToDouble(row["TaxRs"].ToString());
                }
                //End of creating datatable for the products
                lblWeight.Text = TotalWeight.ToString("#0.00");

                lblTotalBV.Text = Convert.ToString(Convert.ToDouble(dt_temp.Compute("sum(BV)", "1=1").ToString()));
                GridView1.DataSource = dt_temp;
                GridView1.DataBind();


                ((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblTaxRsTtotal")).Text = rr.ToString("#0.00");
                ((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblDistotal")).Text = dd.ToString("#0.00");
                ((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblValtotal")).Text = tot.ToString("#0.00");
                //((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblQtotal")).Text = double.Parse(dt.Rows[0]["Quantity"].ToString()).ToString();
                ((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblTotal")).Text = Math.Round(double.Parse(dt.Rows[0]["total"].ToString())).ToString("#0.00");

                //((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblTaxRsTtotal")).Text = rr.ToString("#0.00");
                //((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblDistotal")).Text = dd.ToString("#0.00");
                //((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblValtotal")).Text = tot.ToString("#0.00");
                //((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblQtotal")).Text = double.Parse(dt.Rows[0]["Quantity"].ToString()).ToString();
                //((Label)GridView1.Controls[GridView1.Controls.Count - 1].FindControl("lblTotal")).Text = Math.Round(double.Parse(dt.Rows[0]["total"].ToString())).ToString("#0.00");
            }
            //make the textBoxes read only to get print out
            //MakeReadOnly();
            //checkUser(dt.Rows[0]["Name"].ToString());


            //trbank.Attributes["display"] = "none";
            //txtDelChrg.Visible = false;
            //txtDiscount.Visible = false;
            //nextbill.Visible = true;



        }
        catch (Exception ex)
        {
        }
    }

    public void BindCompanyDetail(int orderNo)
    {

        try
        {



            con = new SqlConnection(method.str);
            SqlDataAdapter adapter = new SqlDataAdapter("companyorder", con);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@invoice", orderNo);
            con.Open();
            SqlDataReader reader = adapter.SelectCommand.ExecuteReader();
            if (reader.HasRows)
            {
                reader.Read();
                lblComName.Text = reader["companyname"].ToString();
                lbltinno.Text = reader["TinNo"].ToString();
                lblcinno.Text = reader["cinno"].ToString();
                lblpan.Text = reader["panno"].ToString();
                lblCompName.Text = lblComName.Text;
                //lblCityDisplay.Text = reader["city"].ToString();
                //lblCity.Text = reader["city"].ToString();
                //lblCity2.Text = reader["city"].ToString();
                //if (Request.QueryString["id"] == null)
                //lblToAdd.Text = reader["orAddress"].ToString();
                imgLogo.ImageUrl = "../images/" + reader["logoURL"].ToString();

                lblLeftHead.Text = reader["orAddress"].ToString();
                int i = 0;
                lblCompanyAdd.Text = "<b>Registerd Office</b>:" + reader["oraddress"].ToString().Replace("<br/>", " ");
                //foreach (string add in reader["caddress"].ToString().Split(','))
                //{
                //    lblLeftHead.Text += add + ",";
                //    if (i == 1)
                //        lblLeftHead.Text += "";
                //    i++;
                //}
                lblLeftHead.Text += "</br>Tel : " + reader["phone"].ToString();
                lblLeftHead.Text += "</br> Email : " + reader["emailid"].ToString();
                //right heade
                //lblRightHead.Text = reader["InvNo"].ToString();
                //lblRightHead.Text = string.Empty;
                //lblRightHead.Text += "" + (Request.QueryString["id"] != null ? invoiceDate : reader["cdate"].ToString());
                lblBillFooter.Text = "THANKS FOR YOUR BUSINESS!";
                //if (!IsPostBack && Request.QueryString["id"] == null)
                //{
                //    txtDelChrg.Text = reader["delivery"].ToString().Trim();
                //    txtDiscount.Text = reader["Discount"].ToString().Trim();
                //}
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
    protected void nextbill_Click(object sender, EventArgs e)
    {
        Response.Redirect("billingform.aspx");
    }

}