using System; 
using System.Data;
using System.Data.SqlClient; 
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using System.Linq;
public partial class franchise_Stock_GIT : System.Web.UI.Page
{
    int Disable_Enable = 0;
    SqlConnection con = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txt_VendorINVDate.Text = DateTime.Now.Date.AddDays(0).ToString("dd/MM/yyyy").Replace("-", "/");

            if (Session["franchiseid"] == null)
                Response.Redirect("Logout.aspx");

            Bind_Vendor();

            if (Request.QueryString.Count > 0)
            {
                if (Request.QueryString["Inv"] != null)
                {
                    BindForPrint(Request.QueryString["Inv"].ToString());

                }
            }
        }
    }




    private void BindForPrint(string InvoiceNo)
    {

        lblMsg.Text = "";
        try
        {
            con = new SqlConnection(method.str);

            SqlDataAdapter adapter = new SqlDataAdapter("Fran_PO_List", con);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@orderno", InvoiceNo);
            adapter.SelectCommand.Parameters.AddWithValue("@SessionId", Session["franchiseid"].ToString());
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                if (Request.QueryString["Inv"] != null)
                {
                    ddl_Vendor.SelectedValue = dt.Rows[0]["VID"].ToString();
                    BindOrderList(dt.Rows[0]["VID"].ToString());
                    ddl_orderno.SelectedValue = Request.QueryString["Inv"].ToString();
                }

                tblUserDetails.Visible = true;
                if (dt.Rows[0]["Status"].ToString() == "0")
                {
                    btn_Submit.Visible = true;
                    lblMsg.Text = "";
                    lblMsg.ForeColor = System.Drawing.Color.Blue;
                }
                else
                {
                    Disable_Enable = 1;
                    chk_Status.Checked = true;
                    chk_Status.Enabled = false;
                    lblMsg.Text = "Order Number already received.!!";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    btn_Submit.Visible = false;
                }
                lblInvoiceNo.Text = dt.Rows[0]["invoiceno"].ToString();
                lbl_VendorName.Text = dt.Rows[0]["VenderName"].ToString();
                txtUserName.Text = dt.Rows[0]["UserName"].ToString() + " (" + dt.Rows[0]["SessionId"].ToString() + ")";
                lblBillDate.Text = dt.Rows[0]["BillDate"].ToString();
                lbl_DeliveryDate.Text = dt.Rows[0]["DeliveryDate"].ToString();

                DataTable dt_temp = new DataTable();
                dt_temp = CreateStructure().Clone();
                //Start of creating datatable for the products
                XElement objXml = XElement.Parse(dt.Rows[0]["detail"].ToString());

                foreach (XElement p in objXml.Elements("P"))
                {
                    DataRow row = dt_temp.NewRow();
                    row["pname"] = p.Elements("pname").FirstOrDefault() != null ? p.Elements("pname").FirstOrDefault().Value : string.Empty;
                    row["cd"] = p.Elements("cd").FirstOrDefault() != null ? p.Elements("cd").FirstOrDefault().Value : string.Empty;
                    row["pcode"] = p.Elements("pcode").FirstOrDefault() != null ? p.Elements("pcode").FirstOrDefault().Value : string.Empty;
                    row["hsncode"] = p.Elements("hsncode").FirstOrDefault() != null ? p.Elements("hsncode").FirstOrDefault().Value : string.Empty;
                    row["quantity"] = p.Elements("Qnt").FirstOrDefault() != null ? p.Elements("Qnt").FirstOrDefault().Value : string.Empty;



                    row["IGST"] = p.Elements("IGST").FirstOrDefault() != null ? p.Elements("IGST").FirstOrDefault().Value : string.Empty;
                    row["IGSTRS"] = p.Elements("IGSTRS").FirstOrDefault() != null ? p.Elements("IGSTRS").FirstOrDefault().Value : string.Empty;
                    row["CGST"] = p.Elements("CGST").FirstOrDefault() != null ? p.Elements("CGST").FirstOrDefault().Value : string.Empty;
                    row["CGSTRS"] = p.Elements("CGSTRS").FirstOrDefault() != null ? p.Elements("CGSTRS").FirstOrDefault().Value : string.Empty;
                    row["SGST"] = p.Elements("SGST").FirstOrDefault() != null ? p.Elements("SGST").FirstOrDefault().Value : string.Empty;
                    row["SGSTRS"] = p.Elements("SGSTRS").FirstOrDefault() != null ? p.Elements("SGSTRS").FirstOrDefault().Value : string.Empty;

                    row["Received"] = p.Elements("Received").FirstOrDefault() != null ? p.Elements("Received").FirstOrDefault().Value : string.Empty;

                    string Price = "0", Tax = "0", RMNG = "0", gross="0", TaxRs = "0";

                    Price = p.Elements("Price").FirstOrDefault() != null ? p.Elements("Price").FirstOrDefault().Value : "0";
                    Tax = p.Elements("TAX").FirstOrDefault() != null ? p.Elements("TAX").FirstOrDefault().Value : "0";
                    RMNG = p.Elements("RMNG").FirstOrDefault() != null ? p.Elements("RMNG").FirstOrDefault().Value : "0";
                    row["Price"] = Price;
                    row["Tax"] = Tax;
                    row["RMNG"] = RMNG;

                    gross = (Convert.ToDouble(Price) * Convert.ToDouble(RMNG)).ToString();
                    TaxRs = (Convert.ToDouble(gross) * Convert.ToDouble(Tax) / 100).ToString();

                    row["gross"] = gross;
                    row["TaxRs"] = TaxRs;
                    row["total"] = Convert.ToDouble(gross) + Convert.ToDouble(TaxRs);

                 
                    dt_temp.Rows.Add(row);
                }
                GridView1.DataSource = dt_temp;
                GridView1.DataBind();
                BindTableData();
            }
            else
            {
                resetControl();
            }
        }
        catch (Exception ex)
        {
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
                TextBox txtRate = (TextBox)gv.FindControl("txtRate");

                if (Disable_Enable == 1)
                {
                    txtReceived.Enabled = false;
                    txtRate.Enabled = false;
                }
                Label lblTax = (Label)gv.FindControl("lblTax");

                Label lblValue = (Label)gv.FindControl("lblValue");
                Label lblTaxRs = (Label)gv.FindControl("lblTaxRs");
                Label lblTotal = (Label)gv.FindControl("lblTotal");

                string Received = "0", Rate = "0", Tax = "0", gross = "0", TaxRs = "0";

                Received = txtReceived.Text;
                Rate = txtRate.Text;
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
            lbl_FooterData.Text= "";
            lbl_FooterData.Text += "Received Qty: " + Total_Qty.ToString();
            lbl_FooterData.Text += ", Gross: " + Total_gross.ToString();
            lbl_FooterData.Text += ", GST: " + Total_TaxRs.ToString();
            lbl_FooterData.Text += ", Total Amt: " + Total_Amt.ToString();

        }
        catch (Exception er) { }
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        try
        {
            XElement element = new XElement("Bill");
            double Gross = 0, TaxRs = 0, NetAmt = 0;
            int TotalQty = 0;

            if (string.IsNullOrEmpty(txt_VendorINV.Text))
            {
                utility.MessageBox(this, "Please Enter Vendor Invoice No.!!");
                txt_VendorINV.Focus();
                return;

            }

            foreach (GridViewRow gv in GridView1.Rows)
            {
                HiddenField pid = (HiddenField)gv.FindControl("hd_pid");
                HiddenField hd_pcode = (HiddenField)gv.FindControl("hd_pcode");
                HiddenField pname = (HiddenField)gv.FindControl("hd_pname");
                HiddenField hsncode = (HiddenField)gv.FindControl("hd_hsncode");
                HiddenField Req_Qty = (HiddenField)gv.FindControl("hd_quantity");

                TextBox txtQty = (TextBox)gv.FindControl("txtReceived");
                TextBox Price = (TextBox)gv.FindControl("txtRate");

                Label lblTaxRs = (Label)gv.FindControl("lblTaxRs");
                Label lblValue = (Label)gv.FindControl("lblValue");
                Label total = (Label)gv.FindControl("lblTotal");

                HiddenField Tax = (HiddenField)gv.FindControl("hd_Tax");

                HiddenField IGST = (HiddenField)gv.FindControl("hd_IGST");
                HiddenField IGSTRS = (HiddenField)gv.FindControl("hd_IGSTRS");
                HiddenField CGST = (HiddenField)gv.FindControl("hd_CGST");
                HiddenField CGSTRS = (HiddenField)gv.FindControl("hd_CGSTRS");
                HiddenField SGST = (HiddenField)gv.FindControl("hd_SGST");
                HiddenField SGSTRS = (HiddenField)gv.FindControl("hd_SGSTRS");
                DropDownList Batch = (DropDownList)gv.FindControl("ddl_Batch");

                if (string.IsNullOrEmpty(Batch.SelectedValue.ToString()))
                {
                    utility.MessageBox(this, "Please select Batch No.!!");
                    return;
                }
                string _IGST = "0", _IGSTRS = "0", _CGST = "0", _CGSTRS = "0", _SGST = "0", _SGSTRS = "0";
                if (Convert.ToDouble(IGST.Value)>0 && Convert.ToDouble(IGSTRS.Value) > 0)
                {
                    _IGST = Tax.Value;
                    _IGSTRS = lblTaxRs.Text;
                }
                else
                {
                    _CGST = (Convert.ToDouble(Tax.Value)/2).ToString();
                    _CGSTRS = (Convert.ToDouble(lblTaxRs.Text) / 2).ToString();
                    _SGST = (Convert.ToDouble(Tax.Value) / 2).ToString();
                    _SGSTRS = (Convert.ToDouble(lblTaxRs.Text) / 2).ToString();
                }
               

                XElement prdXml = new XElement("P",
                    new XElement("pname", pname.Value),
                    new XElement("cd", pid.Value),
                    new XElement("pcode", hd_pcode.Value),
                    new XElement("batchid", Batch.SelectedValue.ToString()),
                    new XElement("hsncode", hsncode.Value),
                    new XElement("Req_Qnt", Req_Qty.Value),
                    new XElement("Qnt", txtQty.Text),
                    new XElement("TAX", Tax.Value),
                    new XElement("TAXRS", lblTaxRs.Text),
                    new XElement("Price", Price.Text),
                    new XElement("Gross", lblValue.Text),
                    new XElement("total", total.Text),
                    new XElement("IGST", _IGST),
                    new XElement("IGSTRS", _IGSTRS),
                    new XElement("CGST", _CGST),
                    new XElement("CGSTRS", _CGSTRS),
                    new XElement("SGST", _SGST),
                    new XElement("SGSTRS", _SGSTRS)
                );
                element.Add(prdXml);

                Gross = Gross + Convert.ToDouble(lblValue.Text); 
                TaxRs = TaxRs + Convert.ToDouble(lblTaxRs.Text);
                NetAmt = NetAmt + Convert.ToDouble(total.Text);

                TotalQty = TotalQty + Convert.ToInt32(txtQty.Text); 
            }
            if(TotalQty<=0)
            {
                utility.MessageBox(this, "Please Enter Receive Qty.!!");
                return;

            }
            var xmlObject = new XmlDocument();
            xmlObject.LoadXml(element.ToString());
            if (element != null)
            {
                String VendorINVDate = "";
                try
                {
                    if (txt_VendorINVDate.Text.Trim().Length > 0)
                    {
                        String[] Date = txt_VendorINVDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                        VendorINVDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                    }
                    else
                    {
                        VendorINVDate = DateTime.Now.ToString();
                    }
                }
                catch
                {
                    utility.MessageBox(this, "Invalid date entry2.");
                    return;
                }
                 
                con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("RecStock_FromVendor", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@OrderNo", ddl_orderno.SelectedValue);
                cmd.Parameters.AddWithValue("@SessionId", Session["franchiseid"].ToString());
                cmd.Parameters.AddWithValue("@Status", chk_Status.Checked == true ? "1" : "0");
                cmd.Parameters.AddWithValue("@VendorInvNo", txt_VendorINV.Text);
                cmd.Parameters.AddWithValue("@VendorInv_Date", VendorINVDate);

                cmd.Parameters.AddWithValue("@Gross", Gross.ToString());
                cmd.Parameters.AddWithValue("@TaxRs", TaxRs.ToString());
                cmd.Parameters.AddWithValue("@NetAmt", NetAmt.ToString());

                cmd.Parameters.Add("@detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                string status = cmd.Parameters["@flag"].Value.ToString();
                if (status == "1")
                {
                    lblMsg.Text = "GRN Stock sucessfully.";
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    btn_Submit.Visible = false;
                    return;
                }
                else
                {
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = status;
                    return;
                }
            }

        }
        catch (Exception er) { }


    }


    private static DataTable getBatch(String Pid)
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[]
        {
            new SqlParameter("@Pid",Pid)
        };
        DataTable dt = objDu.GetDataTable(param1, @"Select b.Batchid, BatchName=Cast(b.BatchDate  as varchar)+' ('+ Cast(b.BatchNo as varchar) +') '  
        + (Case when isnull(c.ColorName,'')!='' then isnull(c.ColorName,'') else '' End) +' ' + (Case when isnull(s.Size,'')!='' then isnull(s.Size,'') else '' End)  
        from Batchmst b left join tbl_color c on b.CLRId=c.CLRId
        left join tbl_size s on b.SZId=s.SZId
        where b.IsExpired=0 and b.Productid=@Pid");
        return dt;
    }

    decimal Qty = 0;
    decimal Value = 0;
    decimal TaxRs = 0;
    decimal Total = 0;
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           // TextBox txtQty = (TextBox)gv.FindControl("txtReceived");

            Qty += Convert.ToDecimal(((TextBox)e.Row.FindControl("txtReceived")).Text);
            Value += Convert.ToDecimal(((Label)e.Row.FindControl("lblValue")).Text);
            TaxRs += Convert.ToDecimal(((Label)e.Row.FindControl("lblTaxRs")).Text);
            Total += Convert.ToDecimal(((Label)e.Row.FindControl("lblTotal")).Text);

            HiddenField pid = (HiddenField)e.Row.FindControl("hd_pid");
            DropDownList ddlBatch = (DropDownList)e.Row.FindControl("ddl_Batch");
            ddlBatch.DataSource = getBatch(pid.Value);
            ddlBatch.DataTextField = "BatchName";
            ddlBatch.DataValueField = "Batchid";
            ddlBatch.DataBind();
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

        DataColumn Received = new DataColumn("Received", typeof(Int32));
        Received.DefaultValue = 0;
        dt_temp.Columns.Add(Received);

        DataColumn RMNG = new DataColumn("RMNG", typeof(Int32));
        RMNG.DefaultValue = 0;
        dt_temp.Columns.Add(RMNG);

        DataColumn Damage = new DataColumn("Damage", typeof(Int32));
        Damage.DefaultValue = 0;
        dt_temp.Columns.Add(Damage);

        DataColumn batchid = new DataColumn("batchid", typeof(Int32));
        batchid.DefaultValue = 0;
        dt_temp.Columns.Add(batchid);

        DataColumn dcpnmae = new DataColumn("pname", typeof(string));
        dcpnmae.DefaultValue = string.Empty;
        dt_temp.Columns.Add(dcpnmae);

        DataColumn hsncode = new DataColumn("hsncode", typeof(string));
        hsncode.DefaultValue = string.Empty;
        dt_temp.Columns.Add(hsncode);

        DataColumn dcMRP = new DataColumn("Price", typeof(float));
        dcMRP.DefaultValue = 0;
        dt_temp.Columns.Add(dcMRP);

        DataColumn code = new DataColumn("cd", typeof(float));
        code.DefaultValue = 0;
        dt_temp.Columns.Add(code);

        DataColumn pcode = new DataColumn("pcode", typeof(string));
        pcode.DefaultValue = string.Empty;
        dt_temp.Columns.Add(pcode);


        DataColumn dcTax = new DataColumn("Tax", typeof(float));
        dcTax.DefaultValue = 0;
        dt_temp.Columns.Add(dcTax);
        DataColumn dcTaxRs = new DataColumn("TaxRs", typeof(float));
        dcTaxRs.DefaultValue = 0;
        dt_temp.Columns.Add(dcTaxRs);

        DataColumn dc = new DataColumn("quantity", typeof(int));
        dc.DefaultValue = 0;
        dt_temp.Columns.Add(dc);


        DataColumn total = new DataColumn("total", typeof(double));
        total.DefaultValue = 0;
        dt_temp.Columns.Add(total);

        DataColumn Qty = new DataColumn("Qty", typeof(double));
        Qty.DefaultValue = 0;
        dt_temp.Columns.Add(Qty);
        DataColumn gross = new DataColumn("gross", typeof(double));
        gross.DefaultValue = 0;
        dt_temp.Columns.Add(gross);


        DataColumn IGST = new DataColumn("IGST", typeof(double));
        IGST.DefaultValue = 0;
        dt_temp.Columns.Add(IGST);
        DataColumn IGSTRS = new DataColumn("IGSTRS", typeof(double));
        IGSTRS.DefaultValue = 0;
        dt_temp.Columns.Add(IGSTRS);


        DataColumn CGST = new DataColumn("CGST", typeof(double));
        CGST.DefaultValue = 0;
        dt_temp.Columns.Add(CGST);
        DataColumn CGSTRS = new DataColumn("CGSTRS", typeof(double));
        CGSTRS.DefaultValue = 0;
        dt_temp.Columns.Add(CGSTRS);

        DataColumn SGST = new DataColumn("SGST", typeof(double));
        SGST.DefaultValue = 0;
        dt_temp.Columns.Add(SGST);
        DataColumn SGSTRS = new DataColumn("SGSTRS", typeof(double));
        SGSTRS.DefaultValue = 0;
        dt_temp.Columns.Add(SGSTRS);

        return dt_temp;
    }

    #region Selector

    private void Bind_Vendor()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MasterKey", "GET-VENDOR-LIST") };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetMasterList");
        if (dt.Rows.Count > 0)
        {
            ddl_Vendor.DataSource = dt;
            ddl_Vendor.DataTextField = "DisplayName";
            ddl_Vendor.DataValueField = "VID";
            ddl_Vendor.DataBind();
            ddl_Vendor.Items.Insert(0, new ListItem("Select a vendor", "0"));
        }
        else
        {
            ddl_Vendor.Items.Clear();
            ddl_Vendor.Items.Insert(0, new ListItem("Select", "0"));
        }
        ddl_orderno.Items.Insert(0, new ListItem("Not available", "0"));
    }
    #endregion

    protected void ddl_Vendor_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("~/Login.aspx");

        string Vid = ddl_Vendor.SelectedValue;
        if (Vid != "0")
        {
            BindOrderList(Vid);
            ddl_orderno.Focus();
        }
        else
        {
            ddl_orderno.Items.Clear();
            ddl_orderno.Items.Insert(0, new ListItem("Not available", "0"));

            resetControl();


            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Text = "Please select a Purchase Order.!!";
        }
    }

    private void BindOrderList(string Vid)
    {
        DataUtility objDu = new DataUtility();
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Vid", Vid) };
        DataTable dt = objDu.GetDataTable(param, "Select id=invoiceno, Text=invoiceno from FranPurchaseOrder where VendorId=@Vid");
        if (dt.Rows.Count > 0)
        {
            ddl_orderno.DataSource = dt;
            ddl_orderno.DataTextField = "Text";
            ddl_orderno.DataValueField = "id";
            ddl_orderno.DataBind();
            ddl_orderno.Items.Insert(0, new ListItem("Select Order", "0"));
        }
        else
        {
            ddl_orderno.Items.Clear();
            ddl_orderno.Items.Insert(0, new ListItem("Not available", "0"));

            resetControl();

        }
    }

    protected void ddl_orderno_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("~/Login.aspx");

        string Orderno = ddl_orderno.SelectedValue;
        if (Orderno != "0")
        {
            Response.Redirect("Stock-GIT.aspx?Inv=" + Orderno);
            //BindForPrint(Orderno);
        }
        else
        {
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Text = "Please select a Purchase Order.!!";
            resetControl();
        }
    }

    void resetControl()
    {
        lblMsg.ForeColor = System.Drawing.Color.Red;
        tblUserDetails.Visible = false;
        GridView1.DataSource = null;
        GridView1.DataBind();
    }
}


