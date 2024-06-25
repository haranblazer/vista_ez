using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;
using System.Data.Linq;

public partial class franchise_PO_BILL : System.Web.UI.Page
{
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
                        BindProduct(srno);
                        //BindProduct(srno);
                        BindFranchiseDetail(srno);
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
            DataSet ds = objDUT.GetDataSetSP(sqlparam, "GetPO_PrintBill");
            if (ds.Tables[0].Rows.Count > 0)
            {
                Repeater.DataSource = ds.Tables[0];
                Repeater.DataBind();

                object qty, value, Gross, disc, BV, GST, Tax, Total, amt, taxablevalue, IGSTRS, CGSTRS, SGSTRS, ProdWeight = 0;
                qty = ds.Tables[0].Compute("Sum(quantity)", "");
                value = ds.Tables[0].Compute("Sum(taxable)", "");

                Gross = ds.Tables[0].Compute("Sum(Gross)", ""); 
                disc = ds.Tables[0].Compute("Sum(disc)", "");
                BV = ds.Tables[0].Compute("Sum(BV)", "");

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


                lbl_GrossTotal.Text = Gross.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblGross")).Text = Gross.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbl_Disc")).Text = disc.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblPV")).Text = BV.ToString();

                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
               // ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblValue")).Text = value.ToString();
                // ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblTAX")).Text = Tax.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotal")).Text = Total.ToString();
            }

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
                lbl_GrossTotal.Text = taxable.ToString();
                ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblCGST")).Text = CGSTRS.ToString();
                ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblSGST")).Text = SGSTRS.ToString();
                ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblIGST")).Text = IGSTRS.ToString();
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
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "POTransferBill");
        if (dt.Rows.Count > 0)
        {
            lbl_Estimated.Text = dt.Rows[0]["AdjustmentAmt"].ToString();

            //lbl_GrossTotal.Text = dt.Rows[0]["GrossAmt"].ToString();
            lbl_Discount.Text = dt.Rows[0]["Discount"].ToString();
            lbl_tottax.Text = dt.Rows[0]["TaxRs"].ToString();
           // lbl_NetTotal.Text = dt.Rows[0]["Amount"].ToString();

            lbl_NetTotal.Text = Math.Round(double.Parse(dt.Rows[0]["Amount"].ToString())).ToString("#0.00");



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
            lbl_DeliverTo.Text = dt.Rows[0]["DeliverTo"].ToString();

            lbl_UserSate.Text = dt.Rows[0]["State"].ToString();
            lbl_UserEmail.Text = dt.Rows[0]["email"].ToString();
            //lbl_UserGSTIN.Text = dt.Rows[0]["GST"].ToString();
            lbl_UserPAN.Text = dt.Rows[0]["panno"].ToString();
            lbl_UserCIN.Text = dt.Rows[0]["CinNo"].ToString();

            lbl_UserRemark.InnerHtml = "<b>Remark:</b> " + dt.Rows[0]["UserRemark"].ToString();
        }
    }

    private void BindFranchiseDetail(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@invoiceno", srno)
        };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "PO_frachisedetail");
        if (dt.Rows.Count > 0)
        {
            lbl_Regno.Text = dt.Rows[0]["SalesRepID"].ToString();
            lbl_DisplayName.Text = dt.Rows[0]["FName"].ToString();
            lbl_Phone.Text = dt.Rows[0]["Mobile"].ToString();
            lbl_F_Email.Text = dt.Rows[0]["email"].ToString();
            lbl_GSTIN.Text = dt.Rows[0]["GST"].ToString();
            lbl_place_supply.Text = dt.Rows[0]["PlaceOfSupply"].ToString();
            lbl_B_Address.Text = dt.Rows[0]["Address"].ToString();
            lbl_B_state.Text = dt.Rows[0]["State"].ToString();
            //lbl_MainCompanyCIN.Text = dt.Rows[0]["CompanyCIN"].ToString();
        }
    }


}




