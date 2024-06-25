using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class franchise_PI_BIll : System.Web.UI.Page
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
                        string srno = Request.QueryString["id"].ToString();
                        BindProduct(srno);
                        BindVendorDetail(srno);
                        userdetail(srno);
                    }
                }
            }
            catch (Exception er) { }
        }
    }


    private void userdetail(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@invoice", srno) };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "PIGstBill");
        if (dt.Rows.Count > 0)
        {
            lbl_GrossTotal.Text = dt.Rows[0]["Gross"].ToString();
            lbl_Discount.Text = dt.Rows[0]["Discount"].ToString();
            lbl_tottax.Text = dt.Rows[0]["TotalTax"].ToString();
            lbl_NetTotal.Text = dt.Rows[0]["NetAmt"].ToString();
            lbl_Userid.Text = dt.Rows[0]["Franchiseid"].ToString();
            lbl_UserMobileNo.Text = dt.Rows[0]["mobile"].ToString();
            //lbl_GrossWeight.Text = dt.Rows[0]["GrossWeight"].ToString();
            lbl_UserGSTIN.Text = dt.Rows[0]["GST"].ToString();
            //lbl_Sellerid.Text = dt.Rows[0]["salesrep"].ToString();

            lbl_UserINVNo.Text = dt.Rows[0]["InvoiceNo"].ToString();
            lbl_UserINVDate.Text = lbl_User_Date_PO_NO.Text = dt.Rows[0]["Doe"].ToString();
            lbl_F_city.Text = dt.Rows[0]["City"].ToString();
            //lbl_Userid.Text = dt.Rows[0]["appmstregno"].ToString();
            lbl_UserName.Text = dt.Rows[0]["FName"].ToString();
            lbl_UserAdd.Text = dt.Rows[0]["Address"].ToString();
            //lbl_UserMobileNo.Text = dt.Rows[0]["appmstmobile"].ToString();
            lbl_UserEmail.Text = dt.Rows[0]["email"].ToString();
            //lbl_UserGSTIN.Text = dt.Rows[0]["GST"].ToString();
            lbl_UserPAN.Text = dt.Rows[0]["panno"].ToString();
            lbl_UserCIN.Text = dt.Rows[0]["CinNo"].ToString();

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
            DataSet ds = objDUT.GetDataSetSP(sqlparam, "Get_PI_PrintBill");
            if (ds.Tables[0].Rows.Count > 0)
            {
                Repeater.DataSource = ds.Tables[0];
                Repeater.DataBind();

                object qty, value, GST, Tax, Total, amt, taxablevalue, IGST, IGSTRS, CGST, CGSTRS, SGST, SGSTRS, taxable;
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

                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotalqty1")).Text = qty.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblValue")).Text = value.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lblTAX")).Text = Tax.ToString();
                ((Label)Repeater.Controls[Repeater.Controls.Count - 1].FindControl("lbltotal")).Text = Total.ToString();

                lbl_GrossWeight.Text = ds.Tables[0].Compute("Sum(ProdWeight)", "").ToString();
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
                ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblCGST")).Text = IGSTRS.ToString();
                ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblSGST")).Text = CGSTRS.ToString();
                ((Label)RepeaterGST.Controls[RepeaterGST.Controls.Count - 1].FindControl("lblIGST")).Text = SGSTRS.ToString();


            }
        }
        catch (Exception er)
        {
            throw;
        }
    }

    private void BindVendorDetail(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@invoiceno", srno)
        };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "PI_vendorDetail");
        if (dt.Rows.Count > 0)
        {
            lbl_Regno.Text = dt.Rows[0]["V_regno"].ToString();
            lbl_B_attention.Text = dt.Rows[0]["B_Attention"].ToString();
            lbl_DisplayName.Text = dt.Rows[0]["DisplayName"].ToString();
            lbl_Phone.Text = dt.Rows[0]["Phone"].ToString();
            lbl_V_Email.Text = dt.Rows[0]["V_Email"].ToString();
            lbl_Website.Text = dt.Rows[0]["Website"].ToString();
            lbl_GSTIN.Text = dt.Rows[0]["GSTIN"].ToString();
            lbl_Source_supply.Text = dt.Rows[0]["Source_supply"].ToString();
            lbl_B_ZipCode.Text = dt.Rows[0]["B_ZipCode"].ToString();
            lbl_B_Address.Text = dt.Rows[0]["B_Address"].ToString();
            lbl_B_state.Text = dt.Rows[0]["B_State"].ToString();
        }
    }
}