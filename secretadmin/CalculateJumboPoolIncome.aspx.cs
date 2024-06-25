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
public partial class CalculateJumboPoolIncome : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com = new SqlCommand();
    static int a;
    static int Pno = 0;
    static DateTime to, from;
    int min = 0;
    int max = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        string strsession = Convert.ToString(Session["userName"]);
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
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Label1.Visible = false;

        com = new SqlCommand("J_UpdatePoolIncome", con);
        com.CommandType = CommandType.StoredProcedure;
        con.Open();
        com.Parameters.AddWithValue("@jp1", TextBox1.Text);
        com.ExecuteNonQuery();
        con.Close();
        Button2.Enabled = false;
        Label7.Visible = true;


    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            string fromdate;
            string todate;
            DateTime day;
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

                    int a;

                    SqlCommand com = new SqlCommand("j_poolUsers", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                    con.Open();
                    com.ExecuteNonQuery();
                    a = int.Parse(com.Parameters["@flag"].Value.ToString());

                    if (a == 1)
                    {
                        con.Close();
                        con = new SqlConnection(method.str);
                        com = new SqlCommand("select * from PayoutDate", con);
                        con.Open();
                        SqlDataReader dr;
                        dr = com.ExecuteReader();
                        if (dr.HasRows)
                        {
                            con.Close();
                            con = new SqlConnection(method.str);
                            com = new SqlCommand("j_PoolmaxPaydate", con);
                            com.CommandType = CommandType.StoredProcedure;
                            con.Open();
                            dr = com.ExecuteReader();
                            dr.Read();
                            day = Convert.ToDateTime(dr[0]);
                            con.Close();
                            if (day < from)
                            {

                                PoolIncome();
                                error.Text = "Success";
                            }
                            else
                                error.Text = "wrong Date Range ";
                        }
                        else
                        {
                            PoolIncome();
                            error.Text = "Success";
                        }

                    }
                    else
                        error.Text = "No User/Achiver in given range";
                    con.Close();
                }
                else

                    error.Text = "Wrong Date Range";
            }
        }
        catch { }
    }
    private void PoolIncome()
    {
        try
        {
            int total2 = 0, one2 = 0, two2 = 0, three2 = 0;
            string fromdate;
            string todate;
            DateTime from2;
            DateTime to;
            fromdate = txtFmm.Text + "/" + txtFddd.Text + "/" + txtfyy.Text;
            todate = txttomm.Text + "/" + txttodd.Text + "/" + txttoyy.Text;
            from2 = Convert.ToDateTime(fromdate);
            to = Convert.ToDateTime(todate);


            SqlConnection con = new SqlConnection(method.str);
            com = new SqlCommand("J_CalculateJpoolIncome", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.Add(new SqlParameter("@fromdate", SqlDbType.DateTime));
            com.Parameters.Add(new SqlParameter("@todate", SqlDbType.DateTime));
            com.Parameters.Add(new SqlParameter("@jp1", SqlDbType.Int));
            com.Parameters.Add(new SqlParameter("@Q1", SqlDbType.Int));
            com.Parameters.Add(new SqlParameter("@NewJoin", SqlDbType.Int));
            con.Open();
            com.Parameters["@fromdate"].Value = from2;
            com.Parameters["@todate"].Value = to;
            com.Parameters["@jp1"].Direction = ParameterDirection.Output;
            com.Parameters["@Q1"].Direction = ParameterDirection.Output;
            com.Parameters["@Newjoin"].Direction = ParameterDirection.Output;
            com.CommandTimeout = 900;
            com.ExecuteNonQuery();
            TextBox1.Text = (com.Parameters["@jp1"].Value.ToString());
            TextBox6.Text = (com.Parameters["@Q1"].Value.ToString());
            TextBox11.Text = (com.Parameters["@Newjoin"].Value.ToString());

            Button2.Enabled = true;
            //Label1.Text = "Total No Of New Joinings:" + total2 + " ,1 Royalty Achievers:" + one2 + " ,2 Royalty Achievers:" + two2 + " ,3 Royalty Achievers:" + three2;
            //Label1.Visible = true;
        }
        catch { }
    }

    protected void TextBox4_TextChanged(object sender, EventArgs e)
    {

    }
    protected void Button3_Click(object sender, EventArgs e)
    {

    }
}
