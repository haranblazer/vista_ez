using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Common_Invoice : System.Web.UI.Page
{
    public String SalesGST = "", BilltypeValue = "";
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
        SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@invoice", srno)
        };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "companydetail");
        if (dt.Rows.Count > 0)
        {
            lbl_ComNameFooter.Text = dt.Rows[0]["companyhead"].ToString();

            lbl_ComAdd.Text = dt.Rows[0]["oraddress"].ToString();
            lbl_ComMobileno.Text = dt.Rows[0]["phone"].ToString();
            lbl_ComEmail.Text = dt.Rows[0]["emailid"].ToString();
            SalesGST = dt.Rows[0]["gst"].ToString();
            if (string.IsNullOrEmpty(SalesGST))
                lbl_ComGSTIN.Text = "Unregistered";
            else
                lbl_ComGSTIN.Text = SalesGST;
            lbl_ComPanNo.Text = dt.Rows[0]["panno"].ToString();
            lbl_ComCIN.Text = dt.Rows[0]["cinno"].ToString();
            //lbl_MainCompanyCIN.Text = dt.Rows[0]["CompanyCIN"].ToString();
        }

    }


    private void userdetail(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@invoice", srno) };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "printbill");
        if (dt.Rows.Count > 0)
        {


            lbl_TotalPV.Text = dt.Rows[0]["totalbv"].ToString();

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
            if (dt.Rows[0]["FranType"].ToString() == "2" || dt.Rows[0]["FranType"].ToString() == "3")
            {
                img_sign.ImageUrl = "~/images/ezcare_sign.png";
            }
            else
            {
                img_sign.ImageUrl = "";
            }
            lbl_Sellerid.Text = dt.Rows[0]["salesrep"].ToString();
            lbl_SellerName.Text = dt.Rows[0]["SellerName"].ToString();
            lbl_state.Text = dt.Rows[0]["State"].ToString();
            lbl_UserINVNo.Text = lbl_InvoiceNo.Text = dt.Rows[0]["InvoiceNo"].ToString();
            lbl_UserINVDate.Text = lbl_InvoiceDate.Text = lbl_Date_PO_NO.Text = dt.Rows[0]["Doe"].ToString();

            lbl_User_PO_NO.Text = dt.Rows[0]["orderno"].ToString();
            lbl_PayMode.Text = dt.Rows[0]["PayMode"].ToString();
            //lbl_UseWallet.Text = dt.Rows[0]["WalletAmount"].ToString();
            //lbl_secondaryAmount.Text = dt.Rows[0]["secondaryAmount"].ToString();

            lbl_Userid.Text = dt.Rows[0]["appmstregno"].ToString();
            lbl_UserName.Text = dt.Rows[0]["appmstfname"].ToString();
            lbl_UserAdd.Text = dt.Rows[0]["AppMstAddress1"].ToString();
            lbl_UserMobileNo.Text = dt.Rows[0]["appmstmobile"].ToString();
            lbl_UserEmail.Text = dt.Rows[0]["email"].ToString();
            lbl_UserGSTIN.Text = dt.Rows[0]["GST"].ToString();
            lbl_UserPAN.Text = dt.Rows[0]["panno"].ToString();
            lbl_UserInvType.Text = lbl_InvType.Text = dt.Rows[0]["BillType"].ToString();
            lbl_UserCIN.Text = "";
            lbl_EwayNo.Text = dt.Rows[0]["EwayNo"].ToString();
            lbl_ShipingAdd.Text = dt.Rows[0]["ToAddress"].ToString();

            lbl_TransportName.Text = dt.Rows[0]["Transport"].ToString();
            lbl_BilityNo.Text = dt.Rows[0]["Tracking"].ToString();
            lbl_Estimated.Text = dt.Rows[0]["AdjustmentAmt"].ToString();
            lbl_UserRemark.InnerHtml = "<b>Remark:</b> " + dt.Rows[0]["UserRemark"].ToString();
            if (dt.Rows[0]["status"].ToString() == "0")
            {
                imgbill.Visible = true;
            }
            else
            {
                imgbill.Visible = false;
            }
            BilltypeValue = dt.Rows[0]["BilltypeValue"].ToString();
            if (BilltypeValue == "1")
                BilltypeValue = "PV";
            else
                BilltypeValue = "GPV";
        }
    }


    private void BindProduct(string srno)
    {
        try
        {
            SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@invoiceno", srno)
            };
            DataUtility objDUT = new DataUtility();
            DataSet ds = objDUT.GetDataSetSP(sqlparam, "bindbillproduct");
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (!string.IsNullOrEmpty(SalesGST))
                {
                    //Idtaxinvoice.Visible = true;
                    //Idsalesinvoice.Visible = false;

                    div_InvType.InnerHtml = "Tax Invoice";
                }
                else
                {
                    div_InvType.InnerHtml = "Sales Invoice";
                    //Idtaxinvoice.Visible = false;
                    //Idsalesinvoice.Visible = true;
                }

                Repeater.DataSource = ds.Tables[0];
                Repeater.DataBind();
                object qty, DP, GST, Tax, Total, PV, ProdWeight = 0, Gross = 0, Disc = 0;
                qty = ds.Tables[0].Compute("Sum(quantity)", "");
                DP = ds.Tables[0].Compute("Sum(DP)", "");
                Gross = ds.Tables[0].Compute("Sum(Gross)", "");
                Disc = ds.Tables[0].Compute("Sum(Disc)", "");

                GST = ds.Tables[0].Compute("Sum(tax)", "");
                Tax = ds.Tables[0].Compute("Sum(taxrs)", "");
                lbl_gst.Text = Tax.ToString();
                Total = ds.Tables[0].Compute("Sum(TotalAmt)", "");
                PV = ds.Tables[0].Compute("Sum(BV)", "");
                ProdWeight = ds.Tables[0].Compute("Sum(ProdWeight)", "");
                lbl_GrossWeight.Text = ProdWeight.ToString();


                lbl_GrossTotal.Text = Gross.ToString();
                lvl_Gross.Text = Gross.ToString();
                lbl_Discount.Text = Disc.ToString();

                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblGross")).Text = Gross.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbl_Disc")).Text = Disc.ToString();
                 ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbl_TotalPV")).Text = PV.ToString();

                // ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbl_BillingValue")).Text = DP.ToString();
                // ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblTAX")).Text = Tax.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotal")).Text = Total.ToString();

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
