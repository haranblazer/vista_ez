using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI.WebControls;

public partial class Common_UserPOBill : System.Web.UI.Page
{
    static String SalesGST = "", BilltypeValue = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["id"] != "")
                    {
                        utility obj = new utility();
                        string srno = obj.base64Decode(Request.QueryString["id"].ToString());
                        BindCompany(srno);
                        userdetail(srno);
                        BindProduct(srno);
                    }
                }
            }
            catch (Exception er) { }
        }
    }

    private void BindCompany(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@srno", srno)};
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "UserPO_companydetail");
        if (dt.Rows.Count > 0)
        {
            lbl_ComNameFooter.Text = dt.Rows[0]["companyname"].ToString();
            lbl_ComAdd.Text = dt.Rows[0]["oraddress"].ToString();
            lbl_ComMobileno.Text = dt.Rows[0]["phone"].ToString();
            lbl_ComEmail.Text = dt.Rows[0]["emailid"].ToString();
            lbl_ComGSTIN.Text = SalesGST = dt.Rows[0]["gst"].ToString();
            lbl_ComPanNo.Text = dt.Rows[0]["panno"].ToString();
            lbl_ComCIN.Text = dt.Rows[0]["cinno"].ToString();
            //lbl_MainCompanyCIN.Text = dt.Rows[0]["CompanyCIN"].ToString();
        }
    }


    private void userdetail(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@srno", srno) };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "UserPO_BillPrint");
        if (dt.Rows.Count > 0)
        {

            lbl_Discount.Text = dt.Rows[0]["Discount"].ToString();
            lbl_CourierCharges.Text = dt.Rows[0]["DelCharge"].ToString();

            if (!string.IsNullOrEmpty(SalesGST))
            {
                lbl_NetTotal.Text = Math.Round(double.Parse(dt.Rows[0]["NetAmt"].ToString())).ToString("#0.00");
            }
            else
            {
                lbl_GrossTotal.Text = Math.Round(double.Parse(dt.Rows[0]["NetAmt"].ToString())).ToString("#0.00");
                lbl_NetTotal.Text = Math.Round(double.Parse(dt.Rows[0]["NetAmt"].ToString())).ToString("#0.00");
            }

            lbl_Sellerid.Text = dt.Rows[0]["salesrep"].ToString();
            lbl_SellerName.Text = dt.Rows[0]["SellerName"].ToString();

            lbl_UserINVNo.Text = lbl_InvoiceNo.Text = dt.Rows[0]["InvoiceNo"].ToString();
            lbl_UserINVDate.Text = lbl_User_Date_PO_NO.Text = lbl_InvoiceDate.Text = lbl_Date_PO_NO.Text = dt.Rows[0]["Doe"].ToString();

            lbl_Userid.Text = dt.Rows[0]["appmstregno"].ToString();
            lbl_UserName.Text = dt.Rows[0]["appmstfname"].ToString();
            lbl_UserAdd.Text = dt.Rows[0]["AppMstAddress1"].ToString();
            lbl_UserMobileNo.Text = dt.Rows[0]["appmstmobile"].ToString();
            lbl_UserEmail.Text = dt.Rows[0]["email"].ToString();
            lbl_UserGSTIN.Text = dt.Rows[0]["GST"].ToString();
            lbl_UserPAN.Text = dt.Rows[0]["panno"].ToString();
            //lbl_UserInvType.Text = lbl_InvType.Text = dt.Rows[0]["BillType"].ToString();
            lbl_UserCIN.Text = "";
          // lbl_EwayNo.Text = dt.Rows[0]["EwayNo"].ToString();
            lbl_ShipingAdd.Text = dt.Rows[0]["ToAddress"].ToString();
            lbl_Estimated.Text = dt.Rows[0]["AdjustmentAmt"].ToString();

            BilltypeValue = dt.Rows[0]["BilltypeValue"].ToString();
            if (BilltypeValue == "1")
                BilltypeValue = "TPV";
            else
                BilltypeValue = "RPV";
            Session["BilltypeValue"] = BilltypeValue;
        }
    }


    private void BindProduct(string srno)
    {
        try
        {
            SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@srno", srno) };
            DataUtility objDUT = new DataUtility();
            DataSet ds = objDUT.GetDataSetSP(sqlparam, "UserPO_BillProduct");
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (!string.IsNullOrEmpty(SalesGST))
                {
                    Repeater.DataSource = ds.Tables[0];
                    Repeater.DataBind();
                    //Idtaxinvoice.Visible = true;
                    //Idsalesinvoice.Visible = false;
                } 
                else
                {
                    RPT_Seller.DataSource = ds.Tables[0];
                    RPT_Seller.DataBind();
                    //Idtaxinvoice.Visible = true;
                    //Idsalesinvoice.Visible = true;
                }
                object qty, value, Gross, Disc, GST, Tax, Total, PV, ProdWeight = 0;
                qty = ds.Tables[0].Compute("Sum(quantity)", "");
                value = ds.Tables[0].Compute("Sum(taxable)", "");
                Gross = ds.Tables[0].Compute("Sum(Gross)", "");
                GST = ds.Tables[0].Compute("Sum(tax)", "");
                Tax = ds.Tables[0].Compute("Sum(taxrs)", "");
                Disc = ds.Tables[0].Compute("Sum(Disc)", "");

                lbl_gst.Text = Tax.ToString();
                Total = ds.Tables[0].Compute("Sum(TotalAmt)", "");
                PV = ds.Tables[0].Compute("Sum(BV)", "");
                ProdWeight = ds.Tables[0].Compute("Sum(ProdWeight)", "");
                lbl_GrossWeight.Text = ProdWeight.ToString();
                lbl_PV.Text = PV.ToString();
                if (!string.IsNullOrEmpty(SalesGST))
                {
                    lbl_GrossTotal.Text = value.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbl_Gross_Total")).Text = Gross.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbl_Disc_Total")).Text = Disc.ToString();
                    //((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblTAX")).Text = Tax.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotal")).Text = Total.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblPV")).Text = PV.ToString();
                }
                else
                {
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lbl_Gross_Total")).Text = Gross.ToString();
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lbl_Disc_Total")).Text = Disc.ToString();
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lblPV")).Text = PV.ToString();
                }
            }
            if (!string.IsNullOrEmpty(SalesGST))
            {
                if (ds.Tables[1].Rows.Count > 0)
                {
                    RepeaterGST.DataSource = ds.Tables[1];
                    RepeaterGST.DataBind();

                    object taxable, IGSTRS, CGSTRS, SGSTRS;
                    taxable = ds.Tables[1].Compute("Sum(taxable)", "");
                    IGSTRS = ds.Tables[1].Compute("Sum(IGSTRS)", "");

                    CGSTRS = ds.Tables[1].Compute("Sum(CGSTRS)", "");
                    SGSTRS = ds.Tables[1].Compute("Sum(SGSTRS)", "");

                    ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblTaxablevalue")).Text = taxable.ToString();
                    ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblTaxablevalue")).Text = taxable.ToString();
                    ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblCGST")).Text = CGSTRS.ToString();
                    ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblSGST")).Text = SGSTRS.ToString();
                    ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblIGST")).Text = IGSTRS.ToString();

                }
            }
            else
            {
                tdGst.Visible = false;
                lbl_gst.Visible = false;
                RepeaterGST.DataSource = null;
                RepeaterGST.DataBind();
            }
        }
        catch (Exception er)
        {
            throw;
        }
    }
}
