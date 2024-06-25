using System; 
using System.Data; 
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class admin_PaymentReport1 : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter sda;
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
            ViewState["Tpair"] = "0";
            
            txtFromDate.Text = DateTime.Now.AddDays(-30).Date.ToString("dd/MM/yyyy").Replace("-","/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            getLastPayoutDate();
            go();
            Button4.Visible = false;
        }

    }
    public void getLastPayoutDate()
    {
        sda = new SqlDataAdapter(@"select convert(varchar(20),paytodate,103) as pdate,
        convert(varchar(20),dateadd(day,1,paytodate),103)  fromdate from repayoutdate where payoutno=(select max(payoutno) from repayoutdate )", con);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            lblLastPayoutDate.Text =dt.Rows[0]["pdate"].ToString();
            txtFromDate.Text = dt.Rows[0]["fromdate"].ToString();
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
                //com = new SqlCommand("payoutdetail", con);
                com = new SqlCommand("payoutdetail3", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@min", fromDate);
                com.Parameters.AddWithValue("@max", toDate);
                con.Open();
                sdr = com.ExecuteReader();
                if (sdr.Read())
                {

                    lblpaidUsers.Text = sdr["paid"].ToString();
                    lblunpaid.Text = sdr["Unpaid"].ToString();
                    lblTotalRegistered.Text = sdr["regcount"].ToString();
                    lbltotalcollection.Text = sdr["totalamount"].ToString();
                    lbl_TotalPruchaseMember.Text = sdr["PurchasingMembers"].ToString();
                    lblTotalPayout.Text = sdr["ptotal"].ToString();
                    lbltotalamount.Text = sdr["Totalturnamount"].ToString();
                    lblPercentage.Text = sdr["percentage"].ToString() + "%";

                 
                     
                    lbl_Inc_1.Text = sdr["Inc_1"].ToString();
                    lbl_Inc_1_per.Text = sdr["Inc_Per_1"].ToString();

                    lbl_Inc_2.Text = sdr["Inc_2"].ToString();
                    lbl_Inc_3_per.Text = sdr["Inc_Per_2"].ToString();

                    lbl_Inc_3.Text = sdr["Inc_3"].ToString();
                    lbl_Inc_3_per.Text = sdr["Inc_Per_3"].ToString();
                     
                    lbl_Inc_4.Text = sdr["Inc_4"].ToString();
                    lbl_Inc_4_per.Text = sdr["Inc_Per_4"].ToString();

                    lbl_Inc_5.Text = sdr["Inc_5"].ToString();
                    lbl_Inc_5_per.Text = sdr["Inc_Per_5"].ToString();

                    lbl_Inc_6.Text = sdr["Inc_6"].ToString();
                    lbl_Inc_6_per.Text = sdr["Inc_Per_6"].ToString();
                     
                    lbl_Inc_7.Text = sdr["Inc_7"].ToString();
                    lbl_Inc_7_per.Text = sdr["Inc_Per_7"].ToString();

                    //lbl_RI.Text = sdr["Inc_8"].ToString();
                    //lbl_RI1_PER.Text = sdr["Inc_Per_8"].ToString();

                    //lbl_TWF.Text = sdr["Inc_9"].ToString();
                    //lbl_TWF_per.Text = sdr["Inc_Per_9"].ToString();

                    //lbl_FWF.Text = sdr["Inc_10"].ToString();
                    //lbl_FWF_per.Text = sdr["Inc_Per_10"].ToString();
                     
                }
                else
                {
                    utility.MessageBox(this, "Wrong date !");
                }
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
            try
            {
                com = new SqlCommand("finalpayout2", con);
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
                     Response.Redirect("payoutlist1.aspx");
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

    //protected void btnCal_Click(object sender, EventArgs e)
    //{
    //    //try
    //    //{
    //    //    if (!String.IsNullOrEmpty(txtbinary.Text))
    //    //    {
    //    //        if (Regex.Match(txtbinary.Text.Trim(), @"^[0-9 ]*$").Success)
    //    //        {
    //    //            txtBinaruCalc.Text = Math.Ceiling(Convert.ToDouble(lblTPV.Text) * Convert.ToDouble(txtbinary.Text) / Convert.ToDouble(lblTPair.Text.ToString())).ToString();
    //    //        }
    //    //        else
    //    //        {
    //    //            utility.MessageBox(this, "Please enter valid points?");
    //    //            return;
    //    //        }
    //    //    }
    //    //    else
    //    //    {
    //    //        utility.MessageBox(this, "Please enter points?");
    //    //        return;
    //    //    }
    //    //}
    //    //catch { }
    //}
    protected void Button2_Click(object sender, EventArgs e)
    {
        //Button2.Visible = false;
        //Button3.Visible = true;
        //Button4.Visible = true;

    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        //Button3.Visible = false;
        //Button4.Visible = false;
        //Button2.Visible = true;
    }
}
