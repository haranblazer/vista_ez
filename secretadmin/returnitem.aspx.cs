using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Xml.Linq;
using System.Threading;
using System.Globalization;
using System.Xml;

public partial class secretadmin_returnitem : System.Web.UI.Page
{
    SqlConnection con = null;
    static string SessionUserId = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            bindgrid();
            if (Session["admin"] == null)
            {
                Response.Redirect("adminLog.aspx");
            }
            else
            {
                SessionUserId = Session["admin"].ToString();
            }
        }
    }


    private void BindForPrint(string InvoiceNo)
    {
        lblMsg.ForeColor = System.Drawing.Color.Red;
        lblMsg.Text = "";
        try
        {
            con = new SqlConnection(method.str);

            SqlDataAdapter adapter = new SqlDataAdapter("RerutnSearchorder", con);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@InvoiceNo", InvoiceNo);
            adapter.SelectCommand.Parameters.AddWithValue("@SessionId", SessionUserId);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                tblUserDetails.Visible = true;
                tblbank.Visible = true;
                btn_Submit.Enabled = true;
                if (!string.IsNullOrEmpty(dt.Rows[0]["Flag"].ToString()))
                {
                    lblMsg.Text = dt.Rows[0]["Flag"].ToString();
                    tblbank.Visible = false;
                }
                lbl_phoneno.Text = dt.Rows[0]["appmstmobile"].ToString();
                lblinvoiceDate.Text = dt.Rows[0]["bildate"].ToString();
                txtUserId.Text = dt.Rows[0]["SoldTo"].ToString();
                txtUserName.Text = dt.Rows[0]["Name"].ToString();
                lblInvoiceNo.Text = dt.Rows[0]["InvoiceNo"].ToString();
                lblToAdd.Text = dt.Rows[0]["toaddress"].ToString();

                CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
                TextInfo textInfo = cultureInfo.TextInfo;

                DataTable dt_temp = new DataTable();
                dt_temp = CreateStructure().Clone();
                //Start of creating datatable for the products
                XElement objXml = XElement.Parse(dt.Rows[0]["detail"].ToString());
                //add 10 default row
                DataRow row = null;
                double tt = 0, dd = 0, tot = 0, rr = 0;
                foreach (XElement p in objXml.Elements("P"))
                {
                    row = dt_temp.NewRow();
                    row["srno"] = dt.Rows[0]["srno"].ToString();

                    row["batchid"] = p.Elements("batchid").FirstOrDefault() != null ? p.Elements("batchid").FirstOrDefault().Value : string.Empty;
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

                    if(p.Elements("Resale").FirstOrDefault() !=null)
                        row["Resale"] = p.Elements("Resale").FirstOrDefault() != null ? p.Elements("Resale").FirstOrDefault().Value : string.Empty;

                    if (p.Elements("Damage").FirstOrDefault() != null)
                        row["Damage"] = p.Elements("Damage").FirstOrDefault() != null ? p.Elements("Damage").FirstOrDefault().Value : string.Empty;


                    tt = Convert.ToDouble(row["DPWT"].ToString()) * Convert.ToDouble(row["quantity"].ToString()) - Convert.ToDouble(row["dis"].ToString());
                    row["val"] = tt;
                    dt_temp.Rows.Add(row);
                    tot += tt;
                    dd += Convert.ToDouble(row["dis"].ToString());
                    rr += Convert.ToDouble(row["TaxRs"].ToString());
                }
                //End of creating datatable for the products
                // lblWeight.Text = TotalWeight.ToString("#0.00");
                GridView1.DataSource = dt_temp;
                GridView1.DataBind();
                 
            }
            else
            {
                lblMsg.Text = "No search data found against this Invoice No.";
                tblUserDetails.Visible = false;
                tblbank.Visible = false;
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
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

        DataColumn srno = new DataColumn("srno", typeof(Int32));
        srno.DefaultValue = 0;
        dt_temp.Columns.Add(srno);

        DataColumn Resale = new DataColumn("Resale", typeof(Int32));
        Resale.DefaultValue = 0;
        dt_temp.Columns.Add(Resale);

        DataColumn Damage = new DataColumn("Damage", typeof(Int32));
        Damage.DefaultValue = 0;
        dt_temp.Columns.Add(Damage);


        DataColumn batchid = new DataColumn("batchid", typeof(Int32));
        batchid.DefaultValue = 0;
        dt_temp.Columns.Add(batchid);
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

    private void bindgrid()
    {
      
        DataTable dt;
        con = new SqlConnection(method.str);
        SqlDataAdapter ad = new SqlDataAdapter("getreturnitemlist", con);
        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
        ad.SelectCommand.Parameters.AddWithValue("@salesrep", SessionUserId);
        //ad.SelectCommand.Parameters.AddWithValue("@min", strmin);
        //ad.SelectCommand.Parameters.AddWithValue("@max", strmax);
        //ad.SelectCommand.Parameters.AddWithValue("@userid", "");
        dt = new DataTable();
        ad.Fill(dt);
        DataColumn dcDtl = new DataColumn("tbl", typeof(string));
        dt.Columns.Add(dcDtl);
        foreach (DataRow row in dt.Rows)
        {
            XElement objXml = XElement.Parse(row["detail"].ToString());
            string strDtl = "<table rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
            strDtl += "<tr><th>Name</th><th>Qty</th><th>MRP</th><th>BV</th><th>Total</th><th>Damage</th><th>Resale</th></tr>";
            foreach (XElement p in objXml.Elements("P"))
            {
                strDtl += "<tr align='center'>";
                strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("MRP").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("BV").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("Damage").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("Resale").FirstOrDefault().Value + "</td>";
                strDtl += "</tr>";
            }
            strDtl += "</table>";
            row["tbl"] = strDtl;
        }

        GridView2.DataSource = dt;
        GridView2.DataBind();
    }

    protected void btnSerch_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txt_invoiceNO.Text))
        {
            BindForPrint(txt_invoiceNO.Text.Trim());
            //bindgrid();
        }
    }

    decimal Qty = 0;
    decimal Discount = 0;
    decimal Value = 0;
    decimal TaxRs = 0;
    decimal BV = 0;
    decimal Total = 0;
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
              Qty +=  Convert.ToDecimal( ((Label)e.Row.FindControl("lblQty")).Text );
              Discount += Convert.ToDecimal(((Label)e.Row.FindControl("lblDiscount")).Text);
              Value += Convert.ToDecimal(((Label)e.Row.FindControl("lblValue")).Text);
              TaxRs += Convert.ToDecimal(((Label)e.Row.FindControl("lblTaxRs")).Text);
              BV += Convert.ToDecimal(((Label)e.Row.FindControl("lblBV")).Text);
              Total += Convert.ToDecimal(((Label)e.Row.FindControl("lblTotal")).Text);
        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblF_Qty = (Label)e.Row.FindControl("lblF_Qty");
            lblF_Qty.Text = Qty.ToString();

            Label lblF_Discount = (Label)e.Row.FindControl("lblF_Discount");
            lblF_Discount.Text = Discount.ToString();

            Label lblF_Value = (Label)e.Row.FindControl("lblF_Value");
            lblF_Value.Text = Value.ToString();

            Label lblF_TaxRs = (Label)e.Row.FindControl("lblF_TaxRs");
            lblF_TaxRs.Text = TaxRs.ToString();

            Label lblF_BV = (Label)e.Row.FindControl("lblF_BV");
            lblF_BV.Text = BV.ToString();

            Label lblF_Total = (Label)e.Row.FindControl("lblF_Total");
            lblF_Total.Text = Total.ToString();
        }

    }


    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        lblMsg.ForeColor = System.Drawing.Color.Red;
        lblMsg.Text = "";
        int ReturnItem = 0;
        try
        {
            XElement element = new XElement("Bill");
            foreach (GridViewRow gv in GridView1.Rows)
            {
                HiddenField batchid = (HiddenField)gv.FindControl("hnd_batchid");
                HiddenField DP = (HiddenField)gv.FindControl("hnd_DP");
                Label Code = (Label)gv.FindControl("lblcd");
                Label pname = (Label)gv.FindControl("lblpname");
                Label MRP = (Label)gv.FindControl("lblDPWT");
                Label Dis = (Label)gv.FindControl("lblDiscount");
                Label Tax = (Label)gv.FindControl("lblTax");
                Label TaxRs = (Label)gv.FindControl("lblTaxRs");
                Label BV = (Label)gv.FindControl("lblBV");
                Label Total = (Label)gv.FindControl("lblTotal");
                Label lblQty = (Label)gv.FindControl("lblQty");

                Decimal Qty = 0;
                Decimal Resale = 0;
                Decimal Damage = 0;
                if (!string.IsNullOrEmpty(lblQty.Text))
                    Qty = Convert.ToDecimal(lblQty.Text);

                TextBox txtResale = (TextBox)gv.FindControl("txtResale");
                if (!string.IsNullOrEmpty(txtResale.Text))
                    Resale = Convert.ToDecimal(txtResale.Text);

                TextBox txtDamage = (TextBox)gv.FindControl("txtDamage");
                if (!string.IsNullOrEmpty(txtDamage.Text))
                    Damage = Convert.ToDecimal(txtDamage.Text);

                if((Resale + Damage) > Qty)
                {
                    lblMsg.Text = "Return quantity can not greater than the sold quantity of this Product " + Code.Text;
                    return;
                }
                if ((Resale + Damage) > 0)
                {
                    ReturnItem += (Convert.ToInt32(Resale) + Convert.ToInt32(Damage));
                }
               
                XElement prdXml = new XElement("P",
                            new XElement("pname", pname.Text),
                            new XElement("cd", Code.Text),
                            new XElement("dis", Dis.Text),
                            new XElement("Qnt", Qty.ToString()),
                             new XElement("MRP", MRP.Text),
                             new XElement("TAX", Tax.Text),
                             new XElement("TAXRS", TaxRs.Text),
                             new XElement("DP", DP.Value),
                             new XElement("BV", BV.Text),
                             new XElement("batchid", batchid.Value),
                             new XElement("Damage", Damage.ToString()),
                              new XElement("Resale", Resale.ToString()),
                             new XElement("total", Total.Text));
                element.Add(prdXml);
            }

            if (ReturnItem == 0)
            {
                lblMsg.Text = "Please enter any return quantity.!!";
                return;
            }

            DateTime chequedate = new DateTime();
            try
            {
                System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
                dateInfo.ShortDatePattern = "dd/MM/yyyy";
                if (ddlpaytype.SelectedIndex > 0)
                {
                    chequedate = Convert.ToDateTime(txtDate.Text.Trim(), dateInfo);
                }
                if (ddlpaytype.SelectedIndex == 0)
                {
                    chequedate = DateTime.Now;
                    txtbname.Text = "";
                    txtDD.Text = "";
                }
            }
            catch (Exception ex)
            {
                utility.MessageBox(this, ex.StackTrace);
            }


            var xmlObject = new XmlDocument();
            xmlObject.LoadXml(element.ToString());

            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("AddReturnItem", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@InvoiceNo", txt_invoiceNO.Text.Trim());
            cmd.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
            cmd.Parameters.AddWithValue("@SessionId", SessionUserId);

            cmd.Parameters.AddWithValue("@bankname", txtbname.Text);
            cmd.Parameters.AddWithValue("@checkdate", chequedate);
            cmd.Parameters.AddWithValue("@checkno", txtDD.Text);
            cmd.Parameters.AddWithValue("@paymode", ddlpaytype.SelectedItem.Text);
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            string status = cmd.Parameters["@flag"].Value.ToString();
            if (status == "1")
            {
                utility.MessageBox(this, "Return detail save sucessfully.");
                lblMsg.Text = "Return detail save sucessfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                btn_Submit.Enabled = false;
                tblbank.Visible = false;
                bindgrid();
                return;
            }
            else
            {
                lblMsg.Text = status;
                return;
            }
        }
        catch (Exception er)
        {
            lblMsg.Text = er.Message;
        }

    }

}