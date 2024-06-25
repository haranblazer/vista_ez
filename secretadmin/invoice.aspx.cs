using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class admin_invoice : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);

 
    utility obj = new utility();
    string str5 = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {

                    str5 = obj.base64Decode(Request.QueryString["id"].ToString());
                    companyname();

                    datadetail();

                    DateTime t = DateTime.Now;
                    string date = t.Day.ToString() + "/" + t.Month.ToString() + "/" + t.Year.ToString();
                    lblInvoicedate.Text = date;
                    SqlCommand cmd = new SqlCommand("showdetail", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@regno", str5.ToString());
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {

                        lblClientName.Text = Convert.ToString(dr["appmsttitle"]).ToUpper() + " " + Convert.ToString(dr["appmstfname"]).ToUpper();
                        lblAdress.Text = Convert.ToString(dr["AppMstAddress1"]).ToUpper();
                        lblCity.Text = Convert.ToString(dr["AppMstCity"]).ToUpper();
                        lblpincode.Text = Convert.ToString(dr["AppMstPinCode"]);
                        lblState.Text = Convert.ToString(dr["AppMstState"]).ToUpper();
                        lblInvoicedate.Text = Convert.ToString(dr["invoicedate"]);
                        lblID.Text = Convert.ToString(dr["appmstregno"]);
                        lblMobile.Text = Convert.ToString(dr["appmstmobile"]);
                       // lblPackgName.Text = Convert.ToString(dr["PName"]);
                        lblInvoiceNo.Text = "#" + Convert.ToString(dr["invoice"]).ToUpper();
                       
                        // BillNo.Text = Convert.ToString(dr["srno"]).ToUpper();
                        //lblBillDate.Text = Convert.ToString(dr["productAmt"]);
                       // lbldiscount.Text = Convert.ToString(dr["discount"]) + ".00";

                      // lblAmount.Text = Convert.ToString(dr["TAmount"]) + ".00";
                      //  if (Convert.ToInt32(dr["Amount"]) > 0)
                      //  {
                           // lblQNT.Text = "1";
                           // lblSNo.Text = "1";
                       // }
                       // else
                       // {
                          //  lblQNT.Text = "0";
                          //  lblSNo.Text = "";
                      //  }
                      //  lblTSaleP.Text = Convert.ToString(dr["Amount"]) + ".00";
                       // lblNetAmt.Text = Convert.ToString(dr["netAmt"]) + ".00";
                       // lblTSaleV.Text = Convert.ToString(dr["SaleV"]) + ".00";
                      //  lblRate.Text = Convert.ToString(dr["Amount"]) + ".00";
                      //  lblVatPre.Text = Convert.ToString(dr["VatPer"]) + " %";
                      //  lblVat.Text = Convert.ToInt32(dr["tax"]) + ".00";
                      //  lblAmtWord.Text = utility.NumberToWords(Convert.ToInt32(dr["TAmount"].ToString())).ToUpper() + " ONLY";
                       con.Close();

                    }
                }
            }
        }
        catch { }
    }

    private void companyname()
    {

        SqlDataAdapter da = new SqlDataAdapter("companydetails", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            lblCPanNo.Text = dt.Rows[0]["panNo"].ToString().ToUpper();
            lblcnm.Text = dt.Rows[0]["TinNo"].ToString().ToUpper();
            //  lblcnm.Text = dt.Rows[0]["companyname"].ToString().ToUpper();
            lblCAddress.Text = dt.Rows[0]["address"].ToString().ToUpper();
            // lblcNameWaterMark.Text = dt.Rows[0]["companyname"].ToString().ToUpper();
            lblCNameNew.Text = dt.Rows[0]["companyname"].ToString().ToUpper();
            imgLogo.ImageUrl ="~/images/"+ Convert.ToString(dt.Rows[0]["logoURL"]);

            lblwebsite.Text = dt.Rows[0]["website"].ToString();

            lblphoneno.Text = dt.Rows[0]["phone"].ToString();

        }
        con.Close();
    }


    public void datadetail()
    {

        SqlCommand cmd = new SqlCommand("showdetail", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@regno", str5.ToString());
        con.Open();
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);

    

        object objSum2 = dt.Compute("Sum(taxamount)", "1 = 1");
        Label3.Text =  objSum2.ToString();


        object objSum3 = dt.Compute("Sum(netamount)", "1 = 1");
        lblAmount.Text = Label4.Text = objSum3.ToString();

        object objSum4 = dt.Compute("Sum(price)", "1 = 1");
        Label5.Text =  objSum4.ToString();

        lblAmtWord.Text = utility.NumberToWords(Convert.ToInt32(lblAmount.Text)).ToUpper() + " ONLY";  

        Repeater1.DataSource = dt;
        Repeater1.DataBind();

        con.Close();
    
    
    }



}

