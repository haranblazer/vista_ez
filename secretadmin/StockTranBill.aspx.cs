using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;

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
                        
                        //BindProduct(srno);
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




                //Repeater.DataSource = ds.Tables[0];
                //Repeater.DataBind();

                object qty, value, GST, Tax, Total, amt, taxablevalue, IGSTRS,   CGSTRS,  SGSTRS, ProdWeight = 0;
                qty = ds.Tables[0].Compute("Sum(quantity)", "");
                value = ds.Tables[0].Compute("Sum(taxable)", "");
                amt = ds.Tables[0].Compute("Sum(Rate)", "");
                //disc = dt.Compute("Sum(disc)", "");
                GST = ds.Tables[0].Compute("Sum(tax)", "");
                Tax = ds.Tables[0].Compute("Sum(taxrs)", "");
                taxablevalue = ds.Tables[0].Compute("Sum(taxable)", "");
                Total = ds.Tables[0].Compute("Sum(TotalAmt)", "");

                SGSTRS = ds.Tables[0].Compute("Sum(SGSTRS)", "");
                IGSTRS = ds.Tables[0].Compute("Sum(IGSTRS)", "");
                CGSTRS = ds.Tables[0].Compute("Sum(CGSTRS)", "");


                ProdWeight = ds.Tables[0].Compute("Sum(ProdWeight)", "");
                lbl_GrossWeight.Text = ProdWeight.ToString();
                lbl_GrossTotal.Text = value.ToString();
                lbl_NetTotal.Text = Total.ToString();
               


                if (!string.IsNullOrEmpty(SalesGST))
                {
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotalqty1")).Text = qty.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblValue")).Text = value.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblTAX")).Text = Tax.ToString();
                    ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotal")).Text = Total.ToString();
                    lbl_tottax.Text = Tax.ToString();
                    gstr.Visible = true;
                    lbl_tottax.Visible = true;
                    lbl_NetTotal.Text = Total.ToString();
                }
                else
                {
                    lbl_GrossTotal.Text = value.ToString();
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lbltotalqty1")).Text = qty.ToString();
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lblValue")).Text = value.ToString();
                    ((Label)RPT_Seller.Controls[RPT_Seller.Controls.Count - 1].FindControl("lbltotal")).Text = value.ToString();
                    gstr.Visible = false;
                    lbl_tottax.Visible = false;
                    lbl_NetTotal.Text = value.ToString();
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
            lbl_UserINVDate.Text = lbl_User_Date_PO_NO.Text = dt.Rows[0]["Doe"].ToString();
            //lbl_F_city.Text = dt.Rows[0]["City"].ToString();
            //lbl_Userid.Text = dt.Rows[0]["appmstregno"].ToString();
            lbl_UserName.Text = dt.Rows[0]["FName"].ToString();
            lbl_UserAdd.Text = dt.Rows[0]["Address"].ToString();
            lbl_UserSate.Text = dt.Rows[0]["State"].ToString();
            lbl_UserEmail.Text = dt.Rows[0]["email"].ToString();
            //lbl_UserGSTIN.Text = dt.Rows[0]["GST"].ToString();
            lbl_UserPAN.Text = dt.Rows[0]["panno"].ToString();
            lbl_UserCIN.Text = dt.Rows[0]["CinNo"].ToString();

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
            lbl_GSTIN.Text = SalesGST=dt.Rows[0]["GST"].ToString();
            lbl_place_supply.Text = dt.Rows[0]["PlaceOfSupply"].ToString();
            lbl_B_Address.Text = dt.Rows[0]["Address"].ToString();
            lbl_B_state.Text = dt.Rows[0]["State"].ToString();
            
        }
    }


}
    //SqlConnection con = new SqlConnection(method.str);
    //utility obj = new utility();
    //SqlDataAdapter da = null;
    //DataTable dt = null;
    //int str5 = 0;
    
    //protected void Page_Load(object sender, EventArgs e)
    //{
         
    //    if (!IsPostBack)
    //    {
    //        str5 = Convert.ToInt32(Request.QueryString["inv"].ToString());
    //        try
    //        {
    //            Binduser(str5);
    //            BindCompanyDetail(str5);
    //            userdetail(str5);
    //        }
    //        catch
    //        {
    //            rp1.DataSource = null;
    //            rp1.DataBind();
    //        }
    //    }
    //}


    //private void Binduser(int invoiceno)
    //{

    //    da = new SqlDataAdapter("bindstocktranproduct", con);
    //    da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    da.SelectCommand.Parameters.AddWithValue("@invoiceno", invoiceno);
    //    dt = new DataTable();
    //    da.Fill(dt);
    //    if (dt.Rows.Count > 0)
    //    {

    //        rp1.DataSource = dt;
    //        rp1.DataBind();

    //        object qty, amt, disc, taxablevalue, srate, samount, irate, iamount, crate, camount;
    //        qty = dt.Compute("Sum(quantity)", "");
    //        amt = dt.Compute("Sum(amt)", "");
    //        disc = dt.Compute("Sum(disc)", "");

    //        taxablevalue = dt.Compute("Sum(taxable)", "");
    //        samount = dt.Compute("Sum(samount)", "");
    //        iamount = dt.Compute("Sum(iamount)", "");
    //        camount = dt.Compute("Sum(camount)", "");

    //        ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
    //        ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalamt")).Text = amt.ToString();
    //        ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotaldisc")).Text = disc.ToString();
    //        ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalvalue")).Text = taxablevalue.ToString();
    //        ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalsgamount")).Text = samount.ToString();
    //        ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalcgamount")).Text = camount.ToString();
    //        ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotaligamount")).Text = iamount.ToString();
    //    }

    //}


    //public void BindCompanyDetail(int id)
    //{

    //    con = new SqlConnection(method.str);
    //    SqlDataAdapter adapter = new SqlDataAdapter("stockcompanydetail", con);
    //    adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    adapter.SelectCommand.Parameters.AddWithValue("@id", id);
    //    con.Open();
    //    SqlDataReader reader = adapter.SelectCommand.ExecuteReader();
    //    if (reader.HasRows)
    //    {
    //        reader.Read();
    //        lblcompanyname2.Text = lblcompanyname.Text= lblname.Text = lblname1.Text = reader["companyname"].ToString();
    //        lblcompanyname33.Text = reader["oraddress"].ToString();
    //        lblcaddress.Text = reader["oraddress"].ToString();
    //        lblgstno.Text = reader["gst"].ToString();
    //        lblcin.Text = reader["cinno"].ToString();
    //        lblcstate.Text = reader["city"].ToString();
    //        lblcphone.Text = reader["phone"].ToString();
    //        lblemailid.Text = reader["emailid"].ToString();
    //        lblpreparedby.Text = reader["companyhead"].ToString();
    //        lblpanno.Text = reader["panno"].ToString();
    //        lblcstatecode.Text = reader["cstatecode"].ToString();
    //        lblsupply.Text = reader["bstate"].ToString();
    //       // lblsupply.Text = reader["city"].ToString() +" - " + reader["state"].ToString();
    //    }

    //    con.Close();
    //    con.Dispose();

    //}


    //public void userdetail(int invoiceno)
    //{
    //    con = new SqlConnection(method.str);
    //    SqlDataAdapter adapter = new SqlDataAdapter("printstocktran", con);
    //    adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    adapter.SelectCommand.Parameters.AddWithValue("@invoice", invoiceno);
    //    dt = new DataTable();
    //    adapter.Fill(dt);
    //    if (dt.Rows.Count > 0)
    //    {
    //        //lbladdress1.Text = lbladdress.Text = dt.Rows[0]["AppMstFName"].ToString() +" ("+ dt.Rows[0]["appmstregno"].ToString() + ") " + dt.Rows[0]["toaddress"].ToString();
    //        lbladdress1.Text = lbladdress.Text = dt.Rows[0]["toaddress"].ToString();
    //        //lblname1.Text = dt.Rows[0]["AppMstFName"].ToString();  ---- Buyer and Consignee name Stopped as Client want fixed Company Name----
    //        lblinvoiceno.Text = dt.Rows[0]["invoice"].ToString();
    //        // lblamount.Text =
    //        lblallamount.Text = Math.Round(double.Parse(dt.Rows[0]["total"].ToString())).ToString("#0.00");
    //        CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
    //        TextInfo textInfo = cultureInfo.TextInfo;
    //        lblwords.Text = "(Rupees " + textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(double.Parse(lblallamount.Text.Trim())))) + " Only)";
    //        lbldoe.Text = dt.Rows[0]["bildate"].ToString();
    //        //lblUserId.Text = dt.Rows[0]["appmstregno"].ToString();
    //       // lblname.Text = dt.Rows[0]["AppMstFName"].ToString();
          
    //        lblinvoice.Text = dt.Rows[0]["BILLTYPE"].ToString();
    //        lblstate1.Text = lblstate.Text = dt.Rows[0]["state"].ToString();
    //        lblstatecode1.Text = lblstatecode.Text = dt.Rows[0]["statecode"].ToString();
    //       // lblpaymode.Text = dt.Rows[0]["paymode"].ToString();
    //       // lblpv.Text = dt.Rows[0]["totalbv"].ToString();
             
    //        lblgst.Text = dt.Rows[0]["gst"].ToString();
    //        lblgst1.Text = dt.Rows[0]["gst"].ToString();

    //        lbl_AdjustmentAmt.Text= dt.Rows[0]["AdjustmentAmt"].ToString();
    //    }
    //}




