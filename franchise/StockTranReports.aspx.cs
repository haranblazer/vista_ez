﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml;
using System.Xml.Linq;
using System.Globalization;
using System.Threading;

public partial class franchise_StockTranReports : System.Web.UI.Page
{
    SqlConnection con = null;
    // static string SessionUserId = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["franchiseid"] == null)
            {
                Response.Redirect("Logout.aspx");
            }
            if (Request.QueryString.Count > 0)
            {
                if (Request.QueryString["Inv"] != null)
                {
                    txt_invoiceNO.Text = Request.QueryString["Inv"].ToString();
                    BindForPrint(Request.QueryString["Inv"].ToString());
                }
            }

            bindgrid();
        }
    }


    private void BindForPrint(string InvoiceNo)
    {

        //lblMsg.Text = "";
        try
        {
            con = new SqlConnection(method.str);

            SqlDataAdapter adapter = new SqlDataAdapter("SearchStockInward", con);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure; 
            adapter.SelectCommand.Parameters.AddWithValue("@InvoiceNo", InvoiceNo);
            adapter.SelectCommand.Parameters.AddWithValue("@SessionId", Session["franchiseid"].ToString());
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                chk_Status.Visible = true;
                chk_Status.Checked = true;
                tblUserDetails.Visible = true;
                btn_Submit.Visible = true;
                if (dt.Rows[0]["status"].ToString()=="1")
                {   btn_Submit.Visible = false;
                    chk_Status.Enabled = false;
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
                foreach (XElement p in objXml.Elements("P"))
                {
                    row = dt_temp.NewRow();
                    row["cd"] = p.Elements("cd").FirstOrDefault() != null ? p.Elements("cd").FirstOrDefault().Value : string.Empty;
                    row["PCode"] = p.Elements("pcode").FirstOrDefault() != null ? p.Elements("pcode").FirstOrDefault().Value : string.Empty;
                    row["pname"] = p.Elements("pname").FirstOrDefault() != null ? p.Elements("pname").FirstOrDefault().Value : string.Empty;
                    row["batchid"] = p.Elements("batchid").FirstOrDefault() != null ? p.Elements("batchid").FirstOrDefault().Value : string.Empty;
                    row["Received"] = p.Elements("Received").FirstOrDefault() != null ? p.Elements("Received").FirstOrDefault().Value : string.Empty;
                    row["quantity"] = p.Elements("Qnt").FirstOrDefault() != null ? p.Elements("Qnt").FirstOrDefault().Value : string.Empty;
                    
                    if (p.Elements("OFFERID").FirstOrDefault() != null)
                        row["OFFERID"] = p.Elements("OFFERID").FirstOrDefault() != null ? p.Elements("OFFERID").FirstOrDefault().Value : string.Empty;
                    else
                        row["OFFERID"] = "0";


                    string Price = "0", Tax = "0", RMNG = "0", gross = "0", TaxRs = "0";

                    Price = p.Elements("DP").FirstOrDefault() != null ? p.Elements("DP").FirstOrDefault().Value : "0";
                    Tax = p.Elements("TAX").FirstOrDefault() != null ? p.Elements("TAX").FirstOrDefault().Value : "0";
                    RMNG = p.Elements("RMNG").FirstOrDefault() != null ? p.Elements("RMNG").FirstOrDefault().Value : "0";

                   // row["FPV"] = p.Elements("FPV").FirstOrDefault() != null ? p.Elements("FPV").FirstOrDefault().Value : "0";
                    //row["TotalFPV"] = p.Elements("TotalFPV").FirstOrDefault() != null ? p.Elements("TotalFPV").FirstOrDefault().Value : "0";

                    if (p.Elements("FPV").FirstOrDefault() != null)
                        row["FPV"] = p.Elements("FPV").FirstOrDefault() != null ? p.Elements("FPV").FirstOrDefault().Value : "0";
                    else
                        row["FPV"] = "0";

                    if (p.Elements("TotalFPV").FirstOrDefault() != null)
                        row["TotalFPV"] = p.Elements("TotalFPV").FirstOrDefault() != null ? p.Elements("TotalFPV").FirstOrDefault().Value : "0";
                    else
                        row["TotalFPV"] = "0";


                    row["DPWT"] = Price;
                    row["Tax"] = Tax;
                    row["RMNG"] = RMNG;

                    gross = (Convert.ToDouble(Price) * Convert.ToDouble(RMNG)).ToString();
                    TaxRs = (Convert.ToDouble(gross) * Convert.ToDouble(Tax) / 100).ToString();

                    row["val"] = gross;
                    row["TaxRs"] = TaxRs;
                    row["total"] = Convert.ToDouble(gross) + Convert.ToDouble(TaxRs);

                    dt_temp.Rows.Add(row);
                    
                }
                GridView1.DataSource = dt_temp;
                GridView1.DataBind();

            }
            else
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "No search data found against this Invoice No.";
                tblUserDetails.Visible = false;
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
            BindTableData();
        }
        catch (Exception ex)
        {
        }
    }

    protected void btn_Search1_Click(object sender, EventArgs e)
    {
        bindgrid();
    }
    private void bindgrid()
    {

        DataTable dt;
        con = new SqlConnection(method.str);
        SqlDataAdapter ad = new SqlDataAdapter("getStockTranlist", con);
        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
        ad.SelectCommand.Parameters.AddWithValue("@salesrep", Session["franchiseid"].ToString());
        ad.SelectCommand.Parameters.AddWithValue("@Status", ddl_Status.SelectedValue);
        dt = new DataTable();
        ad.Fill(dt);
        DataColumn dcDtl = new DataColumn("tbl", typeof(string));
        dt.Columns.Add(dcDtl);
        DataColumn srno_Encript = new DataColumn("srno_Encript", typeof(string));
        dt.Columns.Add(srno_Encript);

        foreach (DataRow row in dt.Rows)
        {
            utility objutil = new utility();
            row.SetField("srno_Encript", objutil.base64Encode(row["srno"].ToString()));

            XElement objXml = XElement.Parse(row["detail"].ToString());
            string strDtl = "<table rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
            strDtl += "<tr><th>Code</th><th>Name</th><th>Qty</th><th>DP</th><th>Tax</th><th>TaxRs</th><th>Total</th></tr>";
            foreach (XElement p in objXml.Elements("P"))
            {
                strDtl += "<tr align='center'>";
                strDtl += "<td>" + p.Elements("cd").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("MRP").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("TAX").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("TAXRS").FirstOrDefault().Value + "</td>";
                strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
                strDtl += "</tr>";
            }
            strDtl += "</table>";
            row["tbl"] = strDtl;
        }

        GridView2.DataSource = dt;
        GridView2.DataBind();
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txt_invoiceNO.Text))
        {
            BindForPrint(txt_invoiceNO.Text.Trim());
            bindgrid();
        }
        else
        {
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Text = "Enter invoice no.!";
            return;
        }
    }



    protected void btn_Submit_Click(object sender, EventArgs e)
    {

        lblMsg.Text = "";
        int TotalQty = 0, Count = 0;
        double NetAmount = 0, GrossAmt = 0, TotalGross = 0, TotalFPV = 0, TotalTaxRs = 0, TaxRs = 0;
        try
        {
            string ss = "SELECT city=UserVal, State=(select State from FranchiseMst WHERE FranchiseId ='" + Session["franchiseid"].ToString() + "') from SettingMst where IsActive='1' and Caption='COM_STATE'";
            con = new SqlConnection(method.str);
            SqlCommand cmd1 = new SqlCommand(ss, con);
            SqlDataAdapter adp = new SqlDataAdapter(cmd1);
            DataTable dtc = new DataTable();
            adp.Fill(dtc);
            string buyerstate = dtc.Rows[0]["State"].ToString().ToUpper();
            string sellerstate = dtc.Rows[0]["city"].ToString().ToUpper();

            XElement element = new XElement("Bill");
            foreach (GridViewRow gv in GridView1.Rows)
            {
                HiddenField hnd_OFFERID = (HiddenField)gv.FindControl("hnd_OFFERID");
                HiddenField batchid = (HiddenField)gv.FindControl("hnd_batchid");
                HiddenField DP = (HiddenField)gv.FindControl("hnd_DP");
                HiddenField hnd_FPV = (HiddenField)gv.FindControl("hnd_FPV");

                Label Code = (Label)gv.FindControl("lblcd");
                Label pname = (Label)gv.FindControl("lblpname");
                Label MRP = (Label)gv.FindControl("lblDPWT");
                Label Dis = (Label)gv.FindControl("lblDiscount");
                Label Tax = (Label)gv.FindControl("lblTax");
                Label lblQty = (Label)gv.FindControl("lblQty");
                Label lbl_TotalFPV = (Label)gv.FindControl("lbl_TotalFPV");

                TextBox txtReceived = (TextBox)gv.FindControl("txtReceived");
               
                int Qty = 0;
                int Received = 0;

                if (!string.IsNullOrEmpty(lblQty.Text))
                    Qty = Int32.Parse(lblQty.Text);


                if (!string.IsNullOrEmpty(txtReceived.Text))
                    Received = Int32.Parse(txtReceived.Text);

                //if ((Received) > Qty)
                //{
                //    lblMsg.ForeColor = System.Drawing.Color.Red;
                //    lblMsg.Text = "Product " + Code.Text + " Receive stock can not greater than of transfer stock.!!";
                //    return;
                //}
                float itax = 0, taxi = 0, ctax = 0, taxc = 0, stax = 0, taxs = 0;
                if ((Received) > 0)
                {

                    GrossAmt = Convert.ToDouble(MRP.Text) * Convert.ToInt32(Received);
                    TaxRs = (GrossAmt * Convert.ToInt32(Tax.Text) / 100);

                    TotalQty += Convert.ToInt32(Received);
                    TotalGross += GrossAmt;
                    NetAmount += (GrossAmt + TaxRs);
                    TotalTaxRs += Convert.ToDouble(TaxRs);
                    TotalFPV += Convert.ToDouble(lbl_TotalFPV.Text);

                    if (sellerstate.ToUpper().Trim() == sellerstate.ToUpper().Trim())
                    {
                        itax = 0;
                        taxi = 0;
                        ctax = Convert.ToSingle(Tax.Text) / 2;
                        taxc = Convert.ToSingle(Math.Round(TaxRs / 2, 2));
                        stax = Convert.ToSingle(Tax.Text) / 2;
                        taxs = Convert.ToSingle(Math.Round(TaxRs / 2, 2));
                    }
                    else
                    {
                        itax = Convert.ToSingle(Tax.Text);
                        taxi = Convert.ToSingle(Math.Round(TaxRs, 2));
                        ctax = 0;
                        taxc = 0;
                        stax = 0;
                        taxs = 0;
                    }
                    Count = Count + 1;
                }

                XElement prdXml = new XElement("P",
                     new XElement("pname", pname.Text),
                     new XElement("cd", Code.Text),
                     new XElement("dis", Dis.Text),
                     new XElement("Qnt", Received.ToString()),
                     new XElement("MRP", MRP.Text),
                     new XElement("TAX", Tax.Text),
                     new XElement("TAXRS", Math.Round(TaxRs, 0)),
                     new XElement("DP", MRP.Text),
                     new XElement("batchid", batchid.Value),
                     new XElement("Damage", 0),
                     new XElement("FPV", hnd_FPV.Value),
                     new XElement("TotalFPV", lbl_TotalFPV.Text),
                     new XElement("OFFERID", hnd_OFFERID.Value),
                     new XElement("Received", Received.ToString()),
                     new XElement("total", Math.Round((GrossAmt + TaxRs), 0)),
                     new XElement("IGST", itax),
                     new XElement("IGSTRS", taxi),
                     new XElement("CGST", ctax),
                     new XElement("CGSTRS", taxc),
                     new XElement("SGST", stax),
                     new XElement("SGSTRS", taxs)
                );
                element.Add(prdXml);
            }

            if (TotalQty == 0)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Please enter any receive quantity.!!";
                return;
            }

            var xmlObject = new XmlDocument();
            xmlObject.LoadXml(element.ToString());
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("ReceiveStock", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@InvoiceNo", txt_invoiceNO.Text.Trim());
            cmd.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
            cmd.Parameters.AddWithValue("@SessionId", Session["franchiseid"].ToString());
            cmd.Parameters.AddWithValue("@count", Count.ToString());
            cmd.Parameters.AddWithValue("@Amt", Math.Round(NetAmount, 0));
            cmd.Parameters.AddWithValue("@NetAmt", Math.Round(NetAmount, 0));
            cmd.Parameters.AddWithValue("@Qnty", TotalQty.ToString());
            cmd.Parameters.AddWithValue("@TotalTaxRs", Math.Round(TotalTaxRs, 0));
            cmd.Parameters.AddWithValue("@TotalDP", TotalGross.ToString());
            cmd.Parameters.AddWithValue("@gross", Math.Round(TotalGross, 0));
            cmd.Parameters.AddWithValue("@Status", "1"); // chk_Status.Checked == true ? "1" : "0");
            cmd.Parameters.AddWithValue("@TotalFPV", TotalFPV);
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            string status = cmd.Parameters["@flag"].Value.ToString();
            if (status == "1")
            {
                btn_Submit.Visible = false;
                lblMsg.Text = "Received detail save sucessfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                BindForPrint(txt_invoiceNO.Text.Trim());
                bindgrid();
                return;
            }
            else
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = status;
                return;
            }
        }
        catch (Exception er)
        {
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Text = er.Message;
        }

    }


    decimal Qty = 0;
    decimal Discount = 0;
    decimal Value = 0;
    decimal TaxRs = 0;
    decimal Total = 0;
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Qty += Convert.ToDecimal(((Label)e.Row.FindControl("lblQty")).Text);
            Discount += Convert.ToDecimal(((Label)e.Row.FindControl("lblDiscount")).Text);
            Value += Convert.ToDecimal(((Label)e.Row.FindControl("lblValue")).Text);
            TaxRs += Convert.ToDecimal(((Label)e.Row.FindControl("lblTaxRs")).Text);
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

            Label lblF_Total = (Label)e.Row.FindControl("lblF_Total");
            lblF_Total.Text = Total.ToString();
        }

    }


    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = GridView2.Rows[Convert.ToInt32(e.CommandArgument)];
        String Inv = GridView2.DataKeys[row.RowIndex].Values[0].ToString();

        if (e.CommandName.Equals("GIT"))
        { 
            Response.Redirect("StockTranReports.aspx?Inv=" + Inv);
        }

        if (e.CommandName.Equals("Status"))
        {
            try
            {
                con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("update StockTranReport set Status=(Case when isnull(Status,0)=0 then 1 else 0 end) where InvoiceNo=@InvoiceNo", con);
                cmd.CommandType = CommandType.Text;
                cmd.CommandTimeout = 99999;
                cmd.Parameters.AddWithValue("@InvoiceNo", Inv);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                bindgrid();
            }
            catch
            {
            }
            finally
            {
            }
        }
         
    }

    protected void txtRate_Changed(object sender, EventArgs e)
    {
        BindTableData();
    }

    private void BindTableData()
    {
        try
        {
            int Total_Qty = 0;
            double Total_gross = 0, Total_TaxRs = 0, Total_Amt = 0;
            foreach (GridViewRow gv in GridView1.Rows)
            {
                TextBox txtReceived = (TextBox)gv.FindControl("txtReceived");
                Label lblDPWT = (Label)gv.FindControl("lblDPWT");

                if (chk_Status.Checked == true)
                    txtReceived.Enabled = false;

                Label lblTax = (Label)gv.FindControl("lblTax");

                Label lblValue = (Label)gv.FindControl("lblValue");
                Label lblTaxRs = (Label)gv.FindControl("lblTaxRs");
                Label lblTotal = (Label)gv.FindControl("lblTotal");

                string Received = "0", Rate = "0", Tax = "0", gross = "0", TaxRs = "0";

                Received = txtReceived.Text;
                Rate = lblDPWT.Text;
                Tax = lblTax.Text;
                gross = (Convert.ToDouble(Rate) * Convert.ToDouble(Received)).ToString();
                TaxRs = (Convert.ToDouble(gross) * Convert.ToDouble(Tax) / 100).ToString();

                lblValue.Text = gross.ToString();
                lblTaxRs.Text = TaxRs.ToString();
                lblTotal.Text = (Convert.ToDouble(gross) + Convert.ToDouble(TaxRs)).ToString();

                Total_Qty = Total_Qty + Convert.ToInt32(Received);
                Total_gross = Total_gross + Convert.ToDouble(gross);
                Total_TaxRs = Total_TaxRs + Convert.ToDouble(TaxRs);
                Total_Amt = Total_Amt + Convert.ToDouble(gross) + Convert.ToDouble(TaxRs);

            }
            lbl_FooterData.Text = "";
            lbl_FooterData.Text += "Received Qty: " + Total_Qty.ToString();
            lbl_FooterData.Text += ", Gross: " + Total_gross.ToString();
            lbl_FooterData.Text += ", GST: " + Total_TaxRs.ToString();
            lbl_FooterData.Text += ", Total Amt: " + Total_Amt.ToString();

        }
        catch (Exception er) { }
    }


    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lnk_GIT = (LinkButton)e.Row.FindControl("lnk_GIT");
            Label lbl_GIT = (Label)e.Row.FindControl("lbl_GIT");
            HiddenField hd_Status = (HiddenField)e.Row.FindControl("hd_Status");
            if (hd_Status.Value == "0")
            {
                lbl_GIT.Text = "";
                lnk_GIT.Enabled = true;
                lnk_GIT.Text = "GIT";
            }
            else
            {
                lnk_GIT.Text = "";
                lnk_GIT.Visible = false;
                lbl_GIT.Text = "fulfill";
            }

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

        DataColumn OFFERID = new DataColumn("OFFERID", typeof(Int32));
        OFFERID.DefaultValue = 0;
        dt_temp.Columns.Add(OFFERID);

        DataColumn Received = new DataColumn("Received", typeof(Int32));
        Received.DefaultValue = 0;
        dt_temp.Columns.Add(Received);

        DataColumn Damage = new DataColumn("Damage", typeof(Int32));
        Damage.DefaultValue = 0;
        dt_temp.Columns.Add(Damage);

        DataColumn batchid = new DataColumn("batchid", typeof(Int32));
        batchid.DefaultValue = 0;
        dt_temp.Columns.Add(batchid);

        DataColumn RMNG = new DataColumn("RMNG", typeof(Int32));
        RMNG.DefaultValue = 0;
        dt_temp.Columns.Add(RMNG);


        DataColumn FPV = new DataColumn("FPV", typeof(float));
        FPV.DefaultValue = 0;
        dt_temp.Columns.Add(FPV);

        DataColumn TotalFPV = new DataColumn("TotalFPV", typeof(float));
        TotalFPV.DefaultValue = 0;

        dt_temp.Columns.Add(TotalFPV);
        DataColumn dcpnmae = new DataColumn("pname", typeof(string));
        dcpnmae.DefaultValue = string.Empty;
        dt_temp.Columns.Add(dcpnmae);
        DataColumn PCode = new DataColumn("PCode", typeof(string));
        PCode.DefaultValue = string.Empty;
        dt_temp.Columns.Add(PCode);

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