using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Common_GST_INV : System.Web.UI.Page
{
    String SalesGST = "";
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
        SqlParameter[] sqlparam = new SqlParameter[] {  new SqlParameter("@srno", srno) };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "GST_companydetail");
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
            lbl_MainCompanyCIN.Text = dt.Rows[0]["CompanyCIN"].ToString();

            lbl_Sellerid.Text = dt.Rows[0]["franchiseid"].ToString();
            lbl_SellerName.Text = dt.Rows[0]["fname"].ToString();

        }

    }


    private void userdetail(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@srno", srno) };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "GST_INV_Bill");
        if (dt.Rows.Count > 0)
        { 
            lbl_Discount.Text = dt.Rows[0]["Discount"].ToString();
            lbl_CourierCharges.Text = dt.Rows[0]["DelCharge"].ToString();

            
            lbl_UserINVNo.Text = lbl_InvoiceNo.Text = dt.Rows[0]["InvoiceNo"].ToString();
            lbl_UserINVDate.Text = lbl_InvoiceDate.Text = lbl_Date_PO_NO.Text = dt.Rows[0]["Doe"].ToString();


            lbl_User_PO_NO.Text = dt.Rows[0]["orderno"].ToString();
            lbl_PayMode.Text = dt.Rows[0]["PayMode"].ToString();

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

            lbl_UserRemark.InnerHtml = "<b>Remark:</b> " + dt.Rows[0]["UserRemark"].ToString();
            if (dt.Rows[0]["status"].ToString() == "0")
            {
                imgbill.Visible = true;
            }
            else
            {
                imgbill.Visible = false;
            }

        }
    }


    private void BindProduct(string srno)
    {
        try
        {
            SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@srno", srno)  };
            DataUtility objDUT = new DataUtility();
            DataSet ds = objDUT.GetDataSetSP(sqlparam, "GST_INV_List_Print");
            if (ds.Tables[0].Rows.Count > 0)
            {

                Repeater.DataSource = ds.Tables[0];
                Repeater.DataBind();
                Idtaxinvoice.Visible = true;
 

                object GrossAmt, TotalAmt, TaxRs= 0;
                GrossAmt = ds.Tables[0].Compute("Sum(GrossAmt)", ""); 
                TaxRs = ds.Tables[0].Compute("Sum(TaxRs)", ""); 
                TotalAmt = ds.Tables[0].Compute("Sum(TotalAmt)", "");

                lbl_GrossTotal.Text=GrossAmt.ToString();
                lbl_gst.Text = TaxRs.ToString();
                lbl_NetTotal.Text = TotalAmt.ToString();

                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblGrossAmt")).Text = GrossAmt.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblTaxRs")).Text = TaxRs.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblTotalAmt")).Text = TotalAmt.ToString(); 

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
                ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblTaxablevalue")).Text = taxable.ToString();
                ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblCGST")).Text = CGSTRS.ToString();
                ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblSGST")).Text = SGSTRS.ToString();
                ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblIGST")).Text = IGSTRS.ToString();

            }

        }
        catch (Exception er)
        {
            throw;
        }
    }

}