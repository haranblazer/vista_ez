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
public partial class admin_modyfypayment : System.Web.UI.Page
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
        com = new SqlCommand("showpayout", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@pno", payoutno);
        DataTable t = new DataTable();
        da = new SqlDataAdapter(com);
        da.Fill(t);
        if (t.Rows.Count > 0)
        {   

            if (t.Rows[0]["panstatus"].ToString().Trim() == "5")
                ddltdstype.SelectedIndex = 1;
            else if (t.Rows[0]["panstatus"].ToString().Trim() == "20")
                ddltdstype.SelectedIndex = 2;
            else if (t.Rows[0]["panstatus"].ToString().Trim() == "0")
                ddltdstype.SelectedIndex = 0;


            ddlDisplay.SelectedValue = t.Rows[0]["paymentdisplay"].ToString();
            txtTDS.Text = t.Rows[0]["tds"].ToString();
            txtUserId.Text = t.Rows[0]["userid"].ToString();
            txtUserName.Text = t.Rows[0]["name"].ToString();

            txtdirectincome.Text = t.Rows[0]["DirectIncome"].ToString();
            txtMatchingIncome.Text = t.Rows[0]["binaryamt"].ToString();


             txtLB1.Text= t.Rows[0]["salary"].ToString();
            txtLB2.Text = t.Rows[0]["RoyaltyAmt"].ToString();


            txtLB3.Text = t.Rows[0]["level3"].ToString();


            txtSClub.Text = t.Rows[0]["RStar"].ToString();
            txtPClub.Text = t.Rows[0]["RSuper"].ToString();
            txtRClub.Text = t.Rows[0]["Rdiamond"].ToString();

            txt_royalty.Text = t.Rows[0]["RoyaltyIncome"].ToString();

            //txtstarroyalty.Text = t.Rows[0]["RStar"].ToString();
            //txtsuperstar.Text = t.Rows[0]["RSuper"].ToString();
            //txtdiamondstar.Text = t.Rows[0]["Rdiamond"].ToString();
            txtroyalstar.Text = t.Rows[0]["RRoyal"].ToString();


            txtothercharges.Text = t.Rows[0]["othercharges"].ToString();
            txtHandlingChrgs.Text = t.Rows[0]["HandlingCharges"].ToString();

            txtremark.Text = t.Rows[0]["remarks"].ToString();
            txtTDS.Text = t.Rows[0]["tds"].ToString();
            txtTotalEarning.Text = t.Rows[0]["totalearning"].ToString();
            txtDispatch.Text = t.Rows[0]["dispachedamt"].ToString();
             

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddltdstype.SelectedValue.ToString() == "0")
            {
                utility.MessageBox(this, "Please Select TDS Type.");
                return;
            }
            com = new SqlCommand("updatepayout", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regno", txtUserId.Text);
            com.Parameters.AddWithValue("@id", Convert.ToInt32(Request.QueryString["n1"]));
            com.Parameters.AddWithValue("@display", int.Parse(ddlDisplay.SelectedValue.ToString()));

            com.Parameters.AddWithValue("@binary", Convert.ToDouble(txtMatchingIncome.Text.Trim()));
            com.Parameters.AddWithValue("@SClub", Convert.ToDouble(txtSClub.Text.Trim()));
            com.Parameters.AddWithValue("@Lcrown", Convert.ToDouble(txtroyalstar.Text.Trim()));
            com.Parameters.AddWithValue("@PClub", Convert.ToDouble(txtPClub.Text.Trim()));
            com.Parameters.AddWithValue("@RClub",  Convert.ToDouble(txtRClub.Text.Trim()));

            com.Parameters.AddWithValue("@Lemperor", Convert.ToDouble(txt_royalty.Text.Trim()));

            com.Parameters.AddWithValue("@lb3", Convert.ToDouble(txtLB3.Text.Trim()));
            com.Parameters.AddWithValue("@lb1", Convert.ToDouble(txtLB1.Text.Trim()));
            com.Parameters.AddWithValue("@lb2", Convert.ToDouble(txtLB2.Text.Trim()));
             
            com.Parameters.AddWithValue("@HandlingChrgs", Convert.ToDouble(txtHandlingChrgs.Text.Trim()));
            com.Parameters.AddWithValue("@tds", int.Parse(ddltdstype.SelectedValue));
            com.Parameters.AddWithValue("@othercharge", Convert.ToDouble(txtothercharges.Text));
            com.Parameters.AddWithValue("@remarks", txtremark.Text);
            com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            string status = com.Parameters["@flag"].Value.ToString();
            if (status == "1")
            {

                utility.MessageBox(this, "Payout has been Updated.");
                go1(str4, str5);
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
   
}
