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
public partial class admin_challan : System.Web.UI.Page
{
    string strAlphaNumeric;
    string str5;
    string product;
    SqlConnection con = new SqlConnection(method.str);
    utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        
        str5 = obj.base64Decode(Request.QueryString["id"]);
       


        SqlCommand cmd = new SqlCommand("select AppmstFname,appmstaddress1,appmstCity,appmstpincode,appmststate,appmstid,Appmsttitle,Appmstlname,productname,convert(varchar(20),appmstdoj,103) as doj  from appmst where appmstregno=@regno", con);
        cmd.Parameters.AddWithValue("@regno", str5);
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lblId.Text = str5;
            lblName.Text = Convert.ToString(dr[6]) + " " + Convert.ToString(dr[0]) + " " + Convert.ToString(dr[7]);

            lblAddress.Text = Convert.ToString(dr[1]);
            lblCity.Text = Convert.ToString(dr[2]);
            // lblpincode.Text = Convert.ToString(dr[3]);
            lblState.Text = Convert.ToString(dr[4]);
            string str = Convert.ToString(dr[5]);
            lblInvoiceNo.Text = "#" + str;

            lblOrderNo.Text = "#" + Convert.ToString(dr["appmstid"]);
            //lblPerticulars.Text = dr["productname"].ToString();
            product = dr["productname"].ToString();
            //lblProductName.Text = dr["productname"].ToString();
            lblQty.Text = "1";
            lblSrNo.Text = "1";
            lblinvoiceDate.Text = dr["doj"].ToString();
            lblOrderDate.Text = dr["doj"].ToString();
            strAlphaNumeric = dr["productname"].ToString();
            con.Close();



            string Alpha = "";

            string Numeric = "";

            for (int Counter = 0; Counter < strAlphaNumeric.Length; Counter++)
            {

                char objChar = strAlphaNumeric[Counter];

                if (Char.IsDigit(objChar))
                {


                    Numeric += objChar.ToString();



                }

                else if (Char.IsLetter(objChar))
                {



                    Alpha += objChar.ToString();


                }



                lblPerticulars.Text = Alpha;




            }
            getjoininamount(product);
            companyname();
        }
       

    }
    private void companyname()
    {

        SqlDataAdapter da = new SqlDataAdapter("select companyname,address,website,phone from paymentmst", con);

        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {
            lblCompany.Text = dt.Rows[0]["companyname"].ToString();


            lblCAddress.Text = dt.Rows[0]["address"].ToString();

        }
        con.Close();
    }
    private void getjoininamount(string pro)
    {

        SqlDataAdapter da = new SqlDataAdapter("select Isnull(amount,0) as amount  from productmst where productname=@product", con);
        da.SelectCommand.Parameters.AddWithValue("@product", pro.Trim());
        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {
            lblAmount.Text = dt.Rows[0]["amount"].ToString();
            lblRate.Text = dt.Rows[0]["amount"].ToString();
            lblTotalAmount.Text = dt.Rows[0]["amount"].ToString();
            lblAmountInWords.Text = utility.NumberToWords(Convert.ToInt16(dt.Rows[0]["amount"].ToString()));

        }
        con.Close();
    }
}
