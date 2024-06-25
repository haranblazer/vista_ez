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
using System.Text.RegularExpressions;
public partial class user_Receipt : System.Web.UI.Page
{

    string product;
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        string str5;
        str5 = Request.QueryString["id"]; 

        if (Regex.Match(str5, @"^[a-zA-Z0-9]*$").Success)
        {

            SqlCommand cmd = new SqlCommand("GetReceipt", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", str5);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {

                lblIBO.Text = Convert.ToString(dr[6]) + " " + Convert.ToString(dr[0]) + " " + Convert.ToString(dr[7]);


                string str = Convert.ToString(dr[5]);

                lblreceiptInvoiceNo.Text = "#" + str;

                product = dr["productid"].ToString();


                con.Close();






                getjoininamount(product);
                companyname();
            }

        }
        else
        {


        }





    }
    private void companyname()
    {



        SqlCommand cmd = new SqlCommand("select companyname,website,phone,emailId ,address from paymentmst", con);
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {



            lblCompanyName.Text = Convert.ToString(dr["companyname"]);
            lblCName.Text = Convert.ToString(dr["companyname"]).ToUpper();
            lblWebSite.Text = Convert.ToString(dr["website"]);
            lblPhone.Text = Convert.ToString(dr["phone"]);
            lbleMail.Text = Convert.ToString(dr["emailId"]);
            lblHAddress.Text = Convert.ToString(dr["address"]);



        }
        con.Close();
    }
    private void getjoininamount(string pro)
    {

        SqlDataAdapter da = new SqlDataAdapter("getjoiningamount", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@product", pro.Trim().ToString());

        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {

            lblPackageCost.Text = dt.Rows[0]["amount"].ToString();
            lblProductName.Text = dt.Rows[0]["productname"].ToString();
        }
        con.Close();
    }
}
