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


public partial class CalculateShare : System.Web.UI.Page
       
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com = new SqlCommand();
      SqlDataReader dr;
    static int a;
    static int Pno=0;
    int min = 0;
    int max = 0;
    static DateTime to;
    static DateTime from;
    protected void Page_Load(object sender, EventArgs e)
    {

        InsertFunction.CheckAdminlogin();
        if (!Page.IsPostBack)
        {
            txtFddd.Text = DateTime.Today.Day.ToString();
            txtFmm.Text = DateTime.Today.Month.ToString();
            txtfyy.Text = DateTime.Today.Year.ToString();
            txttodd.Text = DateTime.Today.Day.ToString();
            txttomm.Text = DateTime.Today.Month.ToString();
            txttoyy.Text = DateTime.Today.Year.ToString();
            Label1.Visible = false;
            Label7.Visible = false;
            Button2.Enabled = false;
        }
        string str;
        
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

        DateTime day;
        Label1.Visible = false;
      
        con.Close();
        com = new SqlCommand("S_maxPdateShare", con);
        com.CommandType = CommandType.StoredProcedure;
        con.Open();
        dr = com.ExecuteReader();
        dr.Read();
        if (dr.HasRows)
        {
            day = Convert.ToDateTime(dr[0]);
        }
        else
        {
            day=Convert.ToDateTime("05/05/2001");
        }
        con.Close();
        if (day < from)
        {

            com = new SqlCommand("S_UpdateShareIncome", con);
            com.CommandTimeout = 600;
            com.CommandType = CommandType.StoredProcedure;
            con.Open();
            com.Parameters.AddWithValue("@amount", TextBox1.Text);
            com.Parameters.AddWithValue("@fromdate", from);
            com.Parameters.AddWithValue("@todate", to);
            com.Parameters.AddWithValue("@Newentry", Label6.Text);
            com.Parameters.AddWithValue("@Qualifiers", Label5.Text);
            com.ExecuteNonQuery();
            con.Close();
            Button2.Enabled = false;
            Label7.Visible = true;
            Label7.Text = "Successfully updated";
        }
        else
        {
            Label7.Text = "Date Range already Registered ";
            Label7.Visible = true;
        }

          }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            string fromdate;
            string todate;
    
            DateTime payoutdate;
            Label7.Visible = false;

            if ((Convert.ToInt16(txtFddd.Text) > 31) || (Convert.ToInt16(txtFmm.Text) > 12) || (Convert.ToInt16(txttodd.Text) > 31) || (Convert.ToInt16(txttomm.Text) > 12))
            {
                error.Text = "Invalid date";
            }
            else
            {
                fromdate = txtFmm.Text + "/" + txtFddd.Text + "/" + txtfyy.Text;
                todate = txttomm.Text + "/" + txttodd.Text + "/" + txttoyy.Text;

                from = Convert.ToDateTime(fromdate);
                to = Convert.ToDateTime(todate);



                if ((from <= to) && (from <= DateTime.Today.Date))
                {
                    // error.Text = "Success";
                    int a;
                   SqlCommand com = new SqlCommand("S_ShareUsers", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@fromdate", from);
                    com.Parameters.AddWithValue("@todate", to);
                    com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                    con.Open();
                    com.ExecuteNonQuery();
                    a = int.Parse(com.Parameters["@flag"].Value.ToString());

                    if (a == 1)
                    {
                        ShareIncome();
                        error.Text = "Success";
                            

                    }
                    else//if (a==1)
                        error.Text = "No User/Achiver in given range";
                    con.Close();



                }
                else

                    error.Text = "Wrong Date Range";
            }//TOP ELSE
        }//TRY
        catch { }
    }
      public void ShareIncome()
      {
          try
          {
              
              string fromdate;
              string todate;
              DateTime from2;
              DateTime to;
              fromdate = txtFmm.Text + "/" + txtFddd.Text + "/" + txtfyy.Text;
              todate = txttomm.Text + "/" + txttodd.Text + "/" + txttoyy.Text;
              from2 = Convert.ToDateTime(fromdate);
              to = Convert.ToDateTime(todate);


              SqlConnection con = new SqlConnection(method.str);
              com = new SqlCommand("S_CalculateShareIncome", con);
              com.CommandTimeout = 600;
			com.CommandType = CommandType.StoredProcedure;
              com.Parameters.Add(new SqlParameter("@fromdate", SqlDbType.DateTime));
              com.Parameters.Add(new SqlParameter("@todate", SqlDbType.DateTime));
              com.Parameters.Add(new SqlParameter("@amount", SqlDbType.Int));
              com.Parameters.Add(new SqlParameter("@tshare", SqlDbType.Int));
              com.Parameters.Add(new SqlParameter("@total", SqlDbType.Int));
              con.Open();

              com.Parameters["@fromdate"].Value = from2;
              com.Parameters["@todate"].Value = to;
              com.Parameters["@amount"].Direction = ParameterDirection.Output;
              com.Parameters["@tshare"].Direction = ParameterDirection.Output;
              com.Parameters["@total"].Direction = ParameterDirection.Output;
              com.ExecuteNonQuery();
              
              TextBox1.Text = (com.Parameters["@amount"].Value.ToString());
              Label6.Text = (com.Parameters["@total"].Value.ToString());
              Label5.Text = (com.Parameters["@tshare"].Value.ToString());

              Button2.Enabled = true;
          }
          catch { }
    }
    
    protected void TextBox4_TextChanged(object sender, EventArgs e)
    {

    }
    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {

    }
}

   

