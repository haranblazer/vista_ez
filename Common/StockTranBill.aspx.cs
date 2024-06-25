using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;


public partial class secretadmin_StockGstBill : System.Web.UI.Page
{
    static String SalesGST = "", BilltypeValue = "";
    SqlConnection con = new SqlConnection(method.str);
    utility obj = new utility();
    SqlDataAdapter da = null;
    DataTable dt = null;
    int Inv = 0;

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

                        BindFranchiseDetail(srno);
                        BindProduct(srno);
                        userdetail(srno);
                    }
                }
            }
            catch (Exception er) { }

        }
    }

    private void BindProduct(string srno)
    {
        try
        {
            SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@invoice", srno)
            };
            DataUtility objDUT = new DataUtility();
            DataSet ds = objDUT.GetDataSetSP(sqlparam, "GetStockTran_PrintBill");
            if (ds.Tables[0].Rows.Count > 0)
            {

                if (!string.IsNullOrEmpty(SalesGST))
                {
                    Repeater.DataSource = ds.Tables[0];
                    Repeater.DataBind();
                    Idtaxinvoice.Visible = true;
                    Idsalesinvoice.Visible = false;
                }
                else
                {
                    RPT_Seller.DataSource = ds.Tables[0];
                    RPT_Seller.DataBind();
                    Idtaxinvoice.Visible = false;
                    Idsalesinvoice.Visible = true;
                }


                object qty, value, GST, Tax, Total, amt, taxablevalue, IGSTRS, CGSTRS, SGSTRS, ProdWeight = 0, TotalBV = 0;
                qty = ds.Tables[0].Compute("Sum(quantity)", "");
                value = ds.Tables[0].Compute("Sum(taxable)", "");
                amt = ds.Tables[0].Compute("Sum(Rate)", "");
                GST = ds.Tables[0].Compute("Sum(tax)", "");
                Tax = ds.Tables[0].Compute("Sum(taxrs)", "");
                taxablevalue = ds.Tables[0].Compute("Sum(taxable)", "");
                Total = ds.Tables[0].Compute("Sum(TotalAmt)", "");

                SGSTRS = ds.Tables[0].Compute("Sum(SGSTRS)", "");
                IGSTRS = ds.Tables[0].Compute("Sum(IGSTRS)", "");
                CGSTRS = ds.Tables[0].Compute("Sum(CGSTRS)", "");
                TotalBV = ds.Tables[0].Compute("Sum(TotalBV)", "");

                ProdWeight = ds.Tables[0].Compute("Sum(ProdWeight)", "");
                lbl_GrossWeight.Text = ProdWeight.ToString();
                lbl_GrossTotal.Text = value.ToString();
                lbl_NetTotal.Text = Total.ToString();
                lbl_RPV.Text = TotalBV.ToString();
                


                if (!string.IsNullOrEmpty(SalesGST))
                {
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotalqty1")).Text = qty.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblValue")).Text = value.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblTAX")).Text = Tax.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotal")).Text = Total.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbl_TotalRPV")).Text = TotalBV.ToString();
                    lbl_tottax.Text = Tax.ToString();
                    gstr.Visible = true;
                    lbl_tottax.Visible = true;
                    lbl_NetTotal.Text = Total.ToString();
                }
                else
                {
                    lbl_GrossTotal.Text = Total.ToString();
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lbltotalqty1")).Text = qty.ToString();
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lblValue")).Text = Total.ToString();
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lbltotal")).Text = Total.ToString();
                    gstr.Visible = false;
                    lbl_tottax.Visible = false;
                    lbl_NetTotal.Text = Total.ToString();
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
                    ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblCGST")).Text = CGSTRS.ToString();
                    ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblSGST")).Text = SGSTRS.ToString();
                    ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblIGST")).Text = IGSTRS.ToString();
                }
            }
            else
            {
                RepeaterGST.DataSource = null;
                RepeaterGST.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }


    private void userdetail(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@invoice", srno) };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "stockTransferBill");
        if (dt.Rows.Count > 0)
        {

            // DelCharge = isnull(s.DelCharge, 0),  = isnull(s.DLVR_Amount, 0)

            lbl_GSTDelivery.Text = "0";

            if (dt.Rows[0]["DLVR_Amount"].ToString() != "0")
                lbl_GSTDelivery.Text = (Convert.ToDecimal(dt.Rows[0]["DelCharge"].ToString()) - Convert.ToDecimal(dt.Rows[0]["DLVR_Amount"].ToString())).ToString();

            lbl_DeliveryCharge.Text = dt.Rows[0]["DLVR_Amount"].ToString();

            lbl_NetTotal.Text = (Convert.ToDecimal(lbl_NetTotal.Text) + Convert.ToDecimal(dt.Rows[0]["DelCharge"].ToString())).ToString();
            lbl_FPV.Text = dt.Rows[0]["FPV"].ToString();
            //lbl_GrossTotal.Text = dt.Rows[0]["Amount"].ToString();
            lbl_Discount.Text = dt.Rows[0]["Discount"].ToString();
            //lbl_tottax.Text = dt.Rows[0]["TaxRs"].ToString();
            //lbl_NetTotal.Text = dt.Rows[0]["NetAmt"].ToString();
            lbl_Userid.Text = dt.Rows[0]["Franchiseid"].ToString();
            lbl_UserMobileNo.Text = dt.Rows[0]["mobile"].ToString();
            // lbl_GrossWeight.Text = dt.Rows[0]["GrossWeight"].ToString();
            lbl_UserGSTIN.Text = dt.Rows[0]["GST"].ToString();
            //lbl_Sellerid.Text = dt.Rows[0]["salesrep"].ToString();

            lbl_UserINVNo.Text = dt.Rows[0]["InvoiceNo"].ToString();
            lbl_UserINVDate.Text = dt.Rows[0]["Doe"].ToString();

            lbl_User_PO_NO.Text = dt.Rows[0]["orderno"].ToString();
            lbl_PayMode.Text = dt.Rows[0]["PayMode"].ToString();



            //lbl_F_city.Text = dt.Rows[0]["City"].ToString();
            //lbl_Userid.Text = dt.Rows[0]["appmstregno"].ToString();
            lbl_UserName.Text = dt.Rows[0]["FName"].ToString();
            lbl_UserAdd.Text = dt.Rows[0]["Address"].ToString();
            lbl_UserSate.Text = dt.Rows[0]["State"].ToString();
            lbl_UserEmail.Text = dt.Rows[0]["email"].ToString();

            lbl_ComPanNo.Text = dt.Rows[0]["panno"].ToString();
            lbl_ComCIN.Text = dt.Rows[0]["CinNo"].ToString();
            lbl_UserRemark.InnerHtml = "<b>Remark:</b> " + dt.Rows[0]["UserRemark"].ToString();

            if (dt.Rows[0]["status"].ToString() == "2")
            {
                imgbill.Visible = true;
            }
            else
            {
                imgbill.Visible = false;
            }

        }
    }

    private void BindFranchiseDetail(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@invoiceno", srno)
        };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "proc_frachisedetail");
        if (dt.Rows.Count > 0)
        {
            lbl_Regno.Text = dt.Rows[0]["SalesRepID"].ToString();
            lbl_DisplayName.Text = dt.Rows[0]["FName"].ToString();
            lbl_sellerName.Text = dt.Rows[0]["FName"].ToString();
            lbl_Phone.Text = dt.Rows[0]["Mobile"].ToString();
            lbl_F_Email.Text = dt.Rows[0]["email"].ToString();
            SalesGST = dt.Rows[0]["GST"].ToString();
            if (string.IsNullOrEmpty(SalesGST))
                lbl_GSTIN.Text = "Unregistered";
            else
                lbl_GSTIN.Text = SalesGST;

            lbl_place_supply.Text = dt.Rows[0]["PlaceOfSupply"].ToString();
            lbl_B_Address.Text = dt.Rows[0]["Address"].ToString();
            lbl_B_state.Text = dt.Rows[0]["State"].ToString();
            lbl_ShipingAdd.Text = dt.Rows[0]["ToAddress"].ToString();
            lbl_TransportName.Text = dt.Rows[0]["Transport"].ToString();
            lbl_BilityNo.Text = dt.Rows[0]["Tracking"].ToString();


            lbl_UserPAN.Text = dt.Rows[0]["PanNo"].ToString();
            lbl_UserCIN.Text = dt.Rows[0]["CinNo"].ToString();

            //lbl_MainCompanyCIN.Text = dt.Rows[0]["CompanyCIN"].ToString();

        }
    }


}



