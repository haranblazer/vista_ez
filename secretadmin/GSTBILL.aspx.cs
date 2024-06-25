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

public partial class secretadmin_GSTBILL : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    utility obj = new utility();
    SqlDataAdapter da = null;
    DataTable dt = null;
    int str5 = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                str5 = Convert.ToInt32(Request.QueryString["id"].ToString());
                try
                {
                    Binduser(str5);
                    BindCompanyDetail(str5);
                    userdetail(str5);
                }
                catch
                {
                    rp1.DataSource = null;
                    rp1.DataBind();
                }
            }
        }
        catch
        {

        }
    }

    private void Binduser(int invoiceno)
    {
        try
        {

            da = new SqlDataAdapter("bindbillproduct", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@invoiceno", invoiceno);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                ViewState["product"] = dt;
                rp1.DataSource = dt;
                rp1.DataBind();

                object qty, amt, Gross, taxablevalue, srate, samount, irate, iamount, crate, camount;
                qty = dt.Compute("Sum(quantity)", "");
                amt = dt.Compute("Sum(amt)", "");
                Gross = dt.Compute("Sum(Gross)", "");

                taxablevalue = dt.Compute("Sum(taxable)", "");
                samount = dt.Compute("Sum(samount)", "");
                iamount = dt.Compute("Sum(iamount)", "");
                camount = dt.Compute("Sum(camount)", "");


                ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
                ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalamt")).Text = amt.ToString();
                ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lblTotalgross")).Text = Gross.ToString();

                ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalvalue")).Text = taxablevalue.ToString();

                //((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalsgrate")).Text = qty.ToString();
                ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalsgamount")).Text = samount.ToString();
                //((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalcgrate")).Text = qty.ToString();

                ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalcgamount")).Text = camount.ToString();

                //((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotaligrate")).Text = qty.ToString();

                ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotaligamount")).Text = iamount.ToString();
            }
        }
        catch
        {
        }
    }


    public void BindCompanyDetail(int invoiceno)
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlDataAdapter adapter = new SqlDataAdapter("companydetail", con);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@invoice", invoiceno);
            con.Open();
            SqlDataReader reader = adapter.SelectCommand.ExecuteReader();
            if (reader.HasRows)
            {
                reader.Read();

                lblcompanyname2.Text = lblcompanyname.Text = lblfromname.Text = reader["companyname"].ToString();
                //lblcompanyname4.Text = lblcompanyname33.Text = reader["oraddress"].ToString();
                lblcompanyname33.Text = reader["oraddress"].ToString();
                lblcaddress.Text = lblfromaddress.Text = reader["oraddress"].ToString();
                lblgstno.Text = reader["gst"].ToString();
                lblcin.Text = reader["cinno"].ToString();
                lblcstate.Text = lbladdress.Text = reader["city"].ToString();
                //lblcmobileno.Text=
                lblcphone.Text = lblfromphone.Text = reader["phone"].ToString();
                lblemailid.Text = reader["emailid"].ToString();
                lblpreparedby.Text = reader["companyhead"].ToString();
                //lblauthorisedsignatory.Text = reader["companyhead"].ToString();
                lblpanno.Text = reader["panno"].ToString();
                lblcstatecode.Text = reader["cstatecode"].ToString();
            }
            con.Close();
            con.Dispose();
        }
        catch
        {
        }
    }


    public void userdetail(int invoiceno)
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlDataAdapter adapter = new SqlDataAdapter("printbill", con);
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            adapter.SelectCommand.Parameters.AddWithValue("@invoice", invoiceno);
            adapter.SelectCommand.Parameters.AddWithValue("@action", "");
            dt = new DataTable();
            adapter.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lbladdress1.Text = lbladdress.Text = lbltoaddress.Text = dt.Rows[0]["toaddress"].ToString();
                lblname1.Text = lblname.Text = lbltoname.Text = dt.Rows[0]["AppMstFName"].ToString();
                lbltophone.Text = dt.Rows[0]["appmstmobile"].ToString();

                lblinvoiceno.Text = dt.Rows[0]["invoice"].ToString();
                //lblDiscount.Text = dt.Rows[0]["Discount"].ToString();
                lblamount.Text = lblallamount.Text = Math.Round(double.Parse(dt.Rows[0]["NetAmt"].ToString())).ToString("#0.00");
                
                CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
                TextInfo textInfo = cultureInfo.TextInfo;
                lblwords.Text = "(Rupees " + textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(double.Parse(lblallamount.Text.Trim())))) + " Only)";
                lbldoe.Text = dt.Rows[0]["bildate"].ToString();
                lblUserId.Text = lblUId.Text = dt.Rows[0]["appmstregno"].ToString();
                lblsupply.Text = dt.Rows[0]["placeofsupply"].ToString();
                lblinvoice.Text = dt.Rows[0]["BILLTYPE"].ToString();
                lblstate1.Text = lblstate.Text = dt.Rows[0]["state"].ToString();
                lblstatecode1.Text = lblstatecode.Text = dt.Rows[0]["statecode"].ToString();
                lblpaymode.Text = dt.Rows[0]["paymode"].ToString();
                lblpv.Text = dt.Rows[0]["totalbv"].ToString();
                lblgst.Text = dt.Rows[0]["gst"].ToString();
                lblgst1.Text = dt.Rows[0]["gst"].ToString();
                lbl_Adjustemnt.Text = dt.Rows[0]["AdjustmentAmt"].ToString();
            }
        }
        catch
        {
        }
    }

}