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
    SqlCommand cmd;

    SqlDataAdapter da;
      static  double sbinary1 ;
       static double smobile1 ;
        static double slaptop1;
        static double sbike1 ;
        static double sAlto1 ;
        static double sFiesta1;
    double sHonda1;
    protected void Page_Load(object sender, EventArgs e)
    {

        InsertFunction.CheckAdminlogin();
        str5 = Convert.ToString(Request.QueryString["n1"]);
        str4 = Convert.ToString(Request.QueryString["n"]);
        if (!IsPostBack)
        {
            if (str4 == null)
            {
         Response.Redirect("adminLog.aspx");
                go1(str4, str5);
            }
            else
            {
                go1(str4, str5);
                sbinary1 = Convert.ToDouble(txtbinary.Text);
                smobile1 = Convert.ToDouble(txtMobile.Text);
                slaptop1 = Convert.ToDouble(txtLaptop.Text);
                sbike1 = Convert.ToDouble(txtBike.Text);
                sAlto1 = Convert.ToDouble(txtAlto.Text);
                sFiesta1 = Convert.ToDouble(txtFiesta.Text);
                sHonda1 = Convert.ToDouble(txtHondaCity.Text);
            }
        }

    }
    public void go1(string str3, string payoutno)
    {
        //Label2.Text = payoutno;
        com = new SqlCommand("modyfypay", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@appmstid", str3);
        com.Parameters.AddWithValue("@draftid", payoutno);
        DataTable t = new DataTable();
        da = new SqlDataAdapter(com);
       

        da.Fill(t);
        if (t.Rows.Count > 0)
        {
            txtid.Text = t.Rows[0]["appmstid"].ToString();
            txtbinary.Text = t.Rows[0]["BinaryAmt"].ToString();

           
          
            txtMobile.Text = t.Rows[0]["r1"].ToString();
            txtLaptop.Text = t.Rows[0]["r2"].ToString();
            txtBike.Text = t.Rows[0]["r3"].ToString();
            txtAlto.Text = t.Rows[0]["r4"].ToString();
            txtFiesta.Text = t.Rows[0]["r5"].ToString();
            txtHondaCity.Text = t.Rows[0]["r6"].ToString();

            txttotal.Text = t.Rows[0]["totalearning"].ToString();
            txtdispatch.Text = t.Rows[0]["dispachedamt"].ToString();
            txtdisp.Text = t.Rows[0]["paymentdisplay"].ToString();
            txtother.Text = t.Rows[0]["handlingcharges"].ToString();
            txtTDS.Text = t.Rows[0]["tds"].ToString();
           

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {


       
        updatedata();
       
       
        com = new SqlCommand("updatepay", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@appmstid", txtid.Text);
        com.Parameters.AddWithValue("@BinaryAmt", txtbinary.Text);

        com.Parameters.AddWithValue("@r1", txtMobile.Text);
        com.Parameters.AddWithValue("@r2", txtLaptop.Text);
        com.Parameters.AddWithValue("@r3", txtBike.Text);
        com.Parameters.AddWithValue("@r4", txtAlto.Text);
        com.Parameters.AddWithValue("@r5", txtFiesta.Text);
        com.Parameters.AddWithValue("@r6", txtHondaCity.Text);
        com.Parameters.AddWithValue("@display", txtdisp.Text);
     
       
       
      com.Parameters.AddWithValue("@draftid", str5);
        if (con.State==ConnectionState.Closed)
            con.Open();
        int i = com.ExecuteNonQuery();
        if (i > 0)
        {
           go1(txtid.Text, str5);
            Label1.Text = "Updated!";
        }
        else
        {
            Label1.Text = "Not Updated, Try again!";
        }

        con.Close();
       
        

    }
    protected void updatedata()
    {
        string strsession = Convert.ToString(Session["admin"]);
        

        try
        {
            if (sbinary1 == Convert.ToDouble(txtbinary.Text) && sbike1 == Convert.ToDouble(txtBike.Text) && smobile1 == Convert.ToDouble(txtMobile.Text) && sbike1 == Convert.ToDouble(txtBike.Text) && sAlto1 == Convert.ToDouble(txtAlto.Text) && sFiesta1 == Convert.ToDouble(txtFiesta.Text) )
            {
            }
            else
            {
                cmd = new SqlCommand("insertmodifypayment", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Appmstregno", txtid.Text);
                cmd.Parameters.AddWithValue("@modifiedby", strsession);

                cmd.Parameters.AddWithValue("@Binaryamt1", sbinary1);
                cmd.Parameters.AddWithValue("@BinaryAmt2", txtbinary.Text);
                cmd.Parameters.AddWithValue("@rewardMobile1", smobile1);
                cmd.Parameters.AddWithValue("@rewardMobile2", txtMobile.Text);
                cmd.Parameters.AddWithValue("@rewardbike1", sbike1);
                cmd.Parameters.AddWithValue("@rewardbike2", txtBike.Text);
                cmd.Parameters.AddWithValue("@rewardAlto1", sAlto1);
                cmd.Parameters.AddWithValue("@rewardAlto2 ", txtAlto.Text);
                cmd.Parameters.AddWithValue("@rewardFiesta1", sFiesta1);
                cmd.Parameters.AddWithValue("@rewardFiesta2 ", txtFiesta.Text);
                cmd.Parameters.AddWithValue("@rewardHonda1", sHonda1);
                cmd.Parameters.AddWithValue("@rewardHonda2", txtHondaCity.Text);
                cmd.Parameters.AddWithValue("@rewardlaptop1", slaptop1);
                cmd.Parameters.AddWithValue("@rewardlaptop2", txtLaptop.Text);
                cmd.Parameters.AddWithValue("@payoutno", str5);
                cmd.Parameters.AddWithValue("@reasontomodify", TxtReason.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
            catch(Exception ex)

        {
            Response.Write(ex.Message.ToString());
}
       
    }
    protected void Updatevalue()
    {

        con.Open();
        con.Close();
    }
}
