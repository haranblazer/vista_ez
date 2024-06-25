using System;
using System.Data;
using System.Data.SqlClient; 
using System.Text.RegularExpressions;

public partial class secretadmin_MonthlyPayout : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter sda;
    utility util = new utility();
    protected string bv;
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
        if (!IsPostBack)
        {

            getLastPayoutDate();
            txtFromDate.Text = DateTime.Now.AddDays(-6).Date.ToString("dd/MM/yyyy").Replace("-","/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd-MM-yyyy").Replace("-", "/");
            go();
        }
    }

    public void getLastPayoutDate()
    {
        sda = new SqlDataAdapter("select convert(varchar(20),paytodate,103) as pdate, convert(varchar(20),dateadd(day,1,paytodate),103) fromdate from MonthlyDate where payoutno=(select max(payoutno) from MonthlyDate )", con);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            lblLastPayoutDate.Text = dt.Rows[0]["pdate"].ToString();
            txtFromDate.Text = dt.Rows[0]["pdate"].ToString();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        go();
    }

    public void go()
    {
        if (Regex.Match(txtFromDate.Text + txtFromDate.Text, @"^[0-9/]*$").Success)
        {
            try
            {
                bv = util.getvalue()[1].ToString();

                string fromDate = "", toDate = "";
                try
                {
                    if (txtFromDate.Text.Trim().Length > 0)
                    {
                        String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                        fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                    }
                    if (txtToDate.Text.Trim().Length > 0)
                    {
                        String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                        toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                    }
                }
                catch
                {
                    utility.MessageBox(this, "Invalid date entry.");
                    return;
                }
               
                com = new SqlCommand("payoutdetails", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@min", fromDate);
                com.Parameters.AddWithValue("@max", toDate);
                con.Open();
                sdr = com.ExecuteReader();
                if (sdr.Read())
                {
                    lblTotalRegistered.Text = sdr["regcount"].ToString();
                    lblunpaid.Text = sdr["Unpaid"].ToString();
                    lblpaidUsers.Text = sdr["t1"].ToString();
                    lbltotalcollection.Text = sdr["totalamount"].ToString();
                    lbltotalamount.Text = sdr["Totalturnamount"].ToString();
                      
                }
                con.Close();


                com = new SqlCommand("Payoutdetails_Monthly", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@min", fromDate);
                com.Parameters.AddWithValue("@max", toDate);
                con.Open();
                sdr = com.ExecuteReader();
                if (sdr.Read())
                {
                   
                    lblTotalPayout.Text = sdr["TotalAmt"].ToString();
                    lblPercentage.Text = sdr["T_Per"].ToString() + "%";
                    

                    lbl_BSF_T_Inc.Text = sdr["BSF_T"].ToString();
                    lbl_BSF_T_Per.Text = sdr["BSF_T_Per"].ToString() + "%";
                    lbl_GF_T.Text = sdr["GF_T"].ToString();
                    lbl_GF_T_Per.Text = sdr["GF_T_Per"].ToString() + "%";
                    lbl_RF_T.Text = sdr["RF_T"].ToString();
                    lbl_RF_T_Per.Text = sdr["RF_T_Per"].ToString() + "%";
                    lbl_PF_T.Text = sdr["PF_T"].ToString();
                    lbl_PF_T_Per.Text = sdr["PF_T_Per"].ToString() + "%";
                    lbl_DF_T.Text = sdr["DF_T"].ToString();
                    lbl_DF_T_Per.Text = sdr["DF_T_Per"].ToString() + "%";
                    lbl_DDF_T.Text = sdr["DDF_T"].ToString();
                    lbl_DDF_T_Per.Text = sdr["DDF_T_Per"].ToString() + "%";
                    lbl_BLUEDF_T.Text = sdr["BLUEDF_T"].ToString();
                    lbl_BLUEDF_T_Per.Text = sdr["BLUEDF_T_Per"].ToString() + "%";
                    lbl_BLACKDF_T.Text = sdr["BLACKDF_T"].ToString();
                    lbl_BLACKDF_T_Per.Text = sdr["BLACKDF_T_Per"].ToString() + "%";
                     
                    lbl_CAF_T.Text = sdr["CAF_T"].ToString();
                    lbl_CAF_T_Per.Text = sdr["CAF_T_Per"].ToString() + "%";
                    lbl_OI_T.Text = sdr["OI_T"].ToString();
                    lbl_OI_T_Per.Text = sdr["OI_T_Per"].ToString() + "%";
                    lbl_RWDF_T.Text = sdr["RWDF_T"].ToString();
                    lbl_RWDF_T_Per.Text = sdr["RWDF_T_Per"].ToString() + "%";
                }
                con.Close();


            }
            catch
            {
            }
        }
        else
        {
            utility.MessageBox(this, "Invalid Date !");
        }
    }


    protected void Button3_Click(object sender, EventArgs e)
    {
        if (Regex.Match(txtFromDate.Text + txtFromDate.Text, @"^[0-9/]*$").Success)
        {
            string fromDate = "", toDate = "";
            try
            {

                DateTime now = DateTime.Now;
                if (txtFromDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    fromDate = Date[2] + "/" + Date[1] + "/" + Date[0];
                }
                if (txtToDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    toDate = Date[2] + "/" + Date[1] + "/" + Date[0];
                }
                fromDate += " 00:00:00:000";
                toDate += " 23:59:59:000";
 
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }

            try
            {
                com = new SqlCommand("TopperMonthlyPayout", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@min1", fromDate);
                com.Parameters.AddWithValue("@max1", toDate);
                com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.CommandTimeout = 1900;
                com.ExecuteNonQuery();
                if (com.Parameters["@flag"].Value.ToString() == "1")
                {
                    con.Close();
                    Response.Redirect("MonthlyPayoutList.aspx");
                }
                else
                {
                    con.Close();
                    utility.MessageBox(this, com.Parameters["@flag"].Value.ToString());
                }
            }
            catch
            {
            }
           
        }
        else
        {
            utility.MessageBox(this, "Invalid date !");
        }
    }
 
}