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

public partial class secretadmin_modyfyrepayment : System.Web.UI.Page
{
    string str5;
    string str4;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;

    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        str5 = Convert.ToString(Request.QueryString["n1"]);
        str4 = Convert.ToString(Request.QueryString["n"]);
        if (!IsPostBack)
        {
            //ViewState["check"] = null;
            if (str4 == null)
            {
                Response.Redirect("adminLog.aspx");

            }
            else
            {
                go1(str4, str5);
            }
        }

    }
    public void go1(string str3, string payoutno)
    {
        com = new SqlCommand("showrepayout", con);
        //  com = new SqlCommand("updatepayoutdetail", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@pno", payoutno);

        //com.Parameters.AddWithValue("@action","A");
        //com.Parameters.AddWithValue("@display",0);
        //com.Parameters.AddWithValue("@PI", 0);
        //com.Parameters.AddWithValue("@LB", 0);
        //com.Parameters.AddWithValue("@TF", 0);
        //com.Parameters.AddWithValue("@BF", 0);
        //com.Parameters.AddWithValue("@CF", 0);
        //com.Parameters.AddWithValue("@HF", 0);
        //com.Parameters.AddWithValue("@ZM", 0);
        //com.Parameters.AddWithValue("@GM", 0);
        //com.Parameters.AddWithValue("@CM", 0);
        //com.Parameters.AddWithValue("@TI", 0);


        DataTable t = new DataTable();
        da = new SqlDataAdapter(com);
        da.Fill(t);
        if (t.Rows.Count > 0)
        {
            //txtid.Text = t.Rows[0]["userid"].ToString();

            //txtdispatch.Text = t.Rows[0]["dispachedamt"].ToString();

            ddltdstype.SelectedValue = t.Rows[0]["panstatus"].ToString();
            ddlDisplay.SelectedValue = t.Rows[0]["paymentdisplay"].ToString();
            txtTDS.Text = t.Rows[0]["tds"].ToString();
            txtUserId.Text = t.Rows[0]["userid"].ToString();
            txtUserName.Text = t.Rows[0]["name"].ToString();
          


            //txtdirectincome.Text = t.Rows[0]["DirectIncome"].ToString();
            //txtMatchingIncome.Text = t.Rows[0]["binaryamt"].ToString();
            //txtPoolIncome.Text = t.Rows[0]["RoyaltyAmt"].ToString();



            //txtlevel1.Text = t.Rows[0]["level1"].ToString();
            //txtlevel2.Text = t.Rows[0]["level2"].ToString();
            //txtlevel3.Text = t.Rows[0]["level3"].ToString();

            txtothercharges.Text = t.Rows[0]["othercharges"].ToString();
            txtremark.Text = t.Rows[0]["remarks"].ToString();
            txtcf.Text = t.Rows[0]["cf"].ToString();
            txtpi.Text = t.Rows[0]["pi"].ToString();
            txttf.Text = t.Rows[0]["tf"].ToString();
            txtbf.Text = t.Rows[0]["bf"].ToString();






            //txtPI.Text= t.Rows[0]["pi"].ToString();
            //txtLB.Text= t.Rows[0]["leadershipamt"].ToString();

            //txtTF.Text = t.Rows[0]["tf"].ToString();

            //txtBF.Text= t.Rows[0]["bf"].ToString();

            //txtCF.Text= t.Rows[0]["cf"].ToString();

            //txtHF.Text = t.Rows[0]["hf"].ToString();

            //txtZM.Text = t.Rows[0]["zm"].ToString();

            //txtCM.Text = t.Rows[0]["cm"].ToString();

            //txtTI.Text = t.Rows[0]["ti"].ToString();

            txtTDS.Text = t.Rows[0]["tds"].ToString();

            txtTotalEarning.Text = t.Rows[0]["totalearning"].ToString();

            txtDispatch.Text = t.Rows[0]["dispachedamt"].ToString();

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddltdstype.SelectedItem.Text == "Select")
            {
                utility.MessageBox(this, "Please select  TDS");
                return;

            }
            com = new SqlCommand("updatepayout", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regno", txtUserId.Text);
            com.Parameters.AddWithValue("@id", Convert.ToInt32(Request.QueryString["n1"]));
            com.Parameters.AddWithValue("@display", int.Parse(ddlDisplay.SelectedValue.ToString()));


            //com.Parameters.AddWithValue("@level1", Convert.ToDouble(txtlevel1.Text));
            //com.Parameters.AddWithValue("@level2", Convert.ToDouble(txtlevel2.Text));
            //com.Parameters.AddWithValue("@level3", Convert.ToDouble(txtlevel3.Text));
            //com.Parameters.AddWithValue("@direct", txtdirectincome.Text.Trim());
            //com.Parameters.AddWithValue("@binary", txtMatchingIncome.Text.Trim());
            //com.Parameters.AddWithValue("@RoyaltyAmt", txtPoolIncome.Text.Trim());

            com.Parameters.AddWithValue("@tds", int.Parse(ddltdstype.SelectedItem.Text));
            com.Parameters.AddWithValue("@othercharge", Convert.ToDouble(txtothercharges.Text));
            com.Parameters.AddWithValue("@remarks", txtremark.Text);
            com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            string status = com.Parameters["@flag"].Value.ToString();
            if (status == "1")
            {
                //ViewState["check"] = "1";
                utility.MessageBox(this, "Payout has been Updated");
            }
            else
            {
                Label1.Text = "Not Updated, Try again!";
            }
        }

        catch
        {

        }

        finally
        {
            con.Close();
        }
    }
    protected void ddltdstype_SelectedIndexChanged(object sender, EventArgs e)
    {
        //double total = double.Parse(txtPI.Text) + double.Parse(txtLB.Text) + double.Parse(txtTF.Text) + double.Parse(txtBF.Text) + double.Parse(txtCF.Text) + double.Parse(txtHF.Text) + double.Parse(txtZM.Text) + double.Parse(txtGM.Text) + double.Parse(txtCM.Text) + double.Parse(txtTI.Text);
        //double total = 0;
        //ViewState["check"] = null;
        try
        {




            double total = double.Parse(txtcf.Text.Trim()) + double.Parse(txtpi.Text.Trim()) + double.Parse(txttf.Text.Trim()) + double.Parse(txtbf.Text.Trim());

            //+ double.Parse(txtlevel2.Text) + double.Parse(txtlevel3.Text);
            if (ddltdstype.SelectedValue.ToString() == "1")
            {
                txtTDS.Text = txtTotalEarning.Text = txtDispatch.Text = string.Empty;
                double tds = (5 * Math.Round(total)) / 100;
                txtTDS.Text = Convert.ToString(Math.Round(tds));
                txtTotalEarning.Text = Convert.ToString(Math.Round(total));
                txtDispatch.Text = Convert.ToString(double.Parse(txtTotalEarning.Text) - double.Parse(txtTDS.Text));
            }

            if (ddltdstype.SelectedValue.ToString() == "0")
            {
                txtTDS.Text = txtTotalEarning.Text = txtDispatch.Text = string.Empty;
                double tds = (20 * Math.Round(total)) / 100;
                txtTDS.Text = Convert.ToString(Math.Round(tds));
                txtTotalEarning.Text = Convert.ToString(Math.Round(total));
                txtDispatch.Text = Convert.ToString(double.Parse(txtTotalEarning.Text) - double.Parse(txtTDS.Text));

            }
        }
        catch
        {
            utility.MessageBox(this, "Please Select  TDS.");
        }

    }
}
