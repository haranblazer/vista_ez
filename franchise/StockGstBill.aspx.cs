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
    SqlConnection con = new SqlConnection(method.str);
    utility obj = new utility();
    SqlDataAdapter da = null;
    DataTable dt = null;
    int str5 = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            // str5= Convert.ToInt32(Request.QueryString["st"].ToString());
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

    private void Binduser(int invoiceno)
    {

        da = new SqlDataAdapter("bindstockbillproduct", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@invoiceno", invoiceno);
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {

            ViewState["product"] = dt;
            rp1.DataSource = dt;
            rp1.DataBind();

            object qty, amt, disc, taxablevalue, srate, samount, irate, iamount, crate, camount;
            qty = dt.Compute("Sum(quantity)", "");
            amt = dt.Compute("Sum(amt)", "");
            disc = dt.Compute("Sum(disc)", "");

            taxablevalue = dt.Compute("Sum(taxable)", "");
            samount = dt.Compute("Sum(samount)", "");
            iamount = dt.Compute("Sum(iamount)", "");
            camount = dt.Compute("Sum(camount)", "");


            ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalqty")).Text = qty.ToString();
            ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalamt")).Text = amt.ToString();
            ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotaldisc")).Text = disc.ToString();

            ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalvalue")).Text = taxablevalue.ToString();

            //((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalsgrate")).Text = qty.ToString();
            ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalsgamount")).Text = samount.ToString();
            //((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalcgrate")).Text = qty.ToString();

            ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotalcgamount")).Text = camount.ToString();

            //((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotaligrate")).Text = qty.ToString();

            ((Label)rp1.Controls[rp1.Controls.Count - 1].FindControl("lbltotaligamount")).Text = iamount.ToString();

        }

    }


    public void BindCompanyDetail(int invoiceno)
    {

        con = new SqlConnection(method.str);
        SqlDataAdapter adapter = new SqlDataAdapter("stockcompanydetail", con);
        adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
        adapter.SelectCommand.Parameters.AddWithValue("@invoice", invoiceno);
        con.Open();
        SqlDataReader reader = adapter.SelectCommand.ExecuteReader();
        if (reader.HasRows)
        {
            reader.Read();

            lblcompanyname2.Text = lblcompanyname.Text = reader["companyname"].ToString();
            //lblcompanyname4.Text = lblcompanyname33.Text = reader["oraddress"].ToString();
            lblcompanyname33.Text = reader["oraddress"].ToString();
            lblcaddress.Text = reader["oraddress"].ToString();
            lblgstno.Text = reader["gst"].ToString();
            lblcin.Text = reader["cinno"].ToString();
            lblcstate.Text = lbladdress.Text = reader["city"].ToString();
            //lblcmobileno.Text=
            lblcphone.Text = reader["phone"].ToString();
            lblemailid.Text = reader["emailid"].ToString();
            lblpreparedby.Text = reader["companyhead"].ToString();
            //lblauthorisedsignatory.Text = reader["companyhead"].ToString();
            lblpanno.Text = reader["panno"].ToString();
            lblcstatecode.Text = reader["cstatecode"].ToString();
        }


        con.Close();
        con.Dispose();

    }

    public void userdetail(int invoiceno)
    {

        con = new SqlConnection(method.str);
        SqlDataAdapter adapter = new SqlDataAdapter("printstockbill", con);
        adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
        adapter.SelectCommand.Parameters.AddWithValue("@invoice", invoiceno);
        adapter.SelectCommand.Parameters.AddWithValue("@action", "");
        dt = new DataTable();
        adapter.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            lbladdress1.Text = lbladdress.Text = dt.Rows[0]["toaddress"].ToString();
            lblname1.Text = lblname.Text = dt.Rows[0]["AppMstFName"].ToString();

            lblinvoiceno.Text = dt.Rows[0]["invoice"].ToString();
            lblamount.Text = lblallamount.Text = Math.Round(double.Parse(dt.Rows[0]["NetAmt"].ToString())).ToString("#0.00");
            CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
            TextInfo textInfo = cultureInfo.TextInfo;
            lblwords.Text = "(Rupees " + textInfo.ToTitleCase(utility.NumberToWords(Convert.ToInt32(double.Parse(lblallamount.Text.Trim())))) + " Only)";
            lbldoe.Text = dt.Rows[0]["bildate"].ToString();
            lblUserId.Text = dt.Rows[0]["appmstregno"].ToString();
            lblsupply.Text = dt.Rows[0]["panno"].ToString();
            lblinvoice.Text = dt.Rows[0]["BILLTYPE"].ToString();
            lblstate1.Text = lblstate.Text = dt.Rows[0]["state"].ToString();
            lblstatecode1.Text = lblstatecode.Text = dt.Rows[0]["statecode"].ToString();
            lblpaymode.Text = dt.Rows[0]["paymode"].ToString();
            lblpv.Text = dt.Rows[0]["totalbv"].ToString();
            lblgst.Text = dt.Rows[0]["tinno"].ToString();
            lblgst1.Text = dt.Rows[0]["tinno"].ToString();


        }




    }




}