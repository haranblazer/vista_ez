﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
public partial class admin_PaymentReport : System.Web.UI.Page
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
            txtFromDate.Text = DateTime.Now.AddDays(-6).Date.ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            getLastPayoutDate();

            go();


        }

    }
    public void getLastPayoutDate()
    {
        sda = new SqlDataAdapter("Select convert(varchar(20),paytodate,103) as pdate,convert(varchar(20),dateadd(day,1,paytodate),103)  fromdate from payoutdate where payoutno=(select max(payoutno) from payoutdate )", con);
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

                    lblpaidUsers.Text = sdr["t1"].ToString();
                    lblunpaid.Text = sdr["Unpaid"].ToString();
                    lblTotalRegistered.Text = sdr["regcount"].ToString();
                    lblTotalPayout.Text = sdr["ptotal"].ToString();
                    lblPercentage.Text = sdr["percentage"].ToString() + "%";

                    lbl_binaryInc.Text = sdr["matching1"].ToString();
                    lblmatching1percent.Text = sdr["matching1percent"].ToString() + "%";


                    lbl_SelfHelpInc.Text = sdr["matching2"].ToString();
                    lblSelfHelppercent.Text = sdr["matching2percent"].ToString() + "%";



                    lbl_binaryInc2.Text = sdr["matching2"].ToString();
                    lblmatching2percent.Text = sdr["matching2percent"].ToString() + "%";

                    lbl_binaryInc3.Text = sdr["matching3"].ToString();
                    lblmatching3percent.Text = sdr["matching3percent"].ToString() + "%";

                    lbl_binaryInc4.Text = sdr["matching4"].ToString();
                    lblmatching4percent.Text = sdr["matching4percent"].ToString() + "%";

                    lbl_binaryInc5.Text = sdr["matching5"].ToString();
                    lblmatching5percent.Text = sdr["matching5percent"].ToString() + "%";
                    //lbldirect.Text = sdr["direct"].ToString();
                    //lbldirectpercent.Text = sdr["directpercent"].ToString() + "%";


                    lbltotalamount.Text = sdr["Totalturnamount"].ToString();
                    lbltotalcollection.Text = sdr["totalamount"].ToString();

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

                /*if (now.Hour.ToString().Length == 1)
                    toDate += " 0" + now.Hour.ToString() + ":";
                else
                    toDate += " " + now.Hour.ToString() + ":";

                if (now.Minute.ToString().Length == 1)
                    toDate += "0" + now.Minute.ToString() + ":";
                else
                    toDate += now.Minute.ToString() + ":";

                if (now.Second.ToString().Length == 1)
                    toDate += "0" + now.Second.ToString() + ":000";
                else
                    toDate += now.Second.ToString() + ":000";*/

            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }

            try
            {
                com = new SqlCommand("finalpayout", con);
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
                    Response.Redirect("payoutlist.aspx");
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
            //}
            //else
            //{
            //    utility.MessageBox(this,"Wrong date!");
            //}
        }
        else
        {
            utility.MessageBox(this, "Invalid date !");
        }
    }

    protected void btnCal_Click(object sender, EventArgs e)
    {
        try
        {
            if (!String.IsNullOrEmpty(txtbinary.Text))
            {
                if (Regex.Match(txtbinary.Text.Trim(), @"^[0-9 ]*$").Success)
                {
                    //txtBinaruCalc.Text = Math.Ceiling(Convert.ToDouble(lblTPV.Text) * Convert.ToDouble(txtbinary.Text) / Convert.ToDouble(lblTPair.Text.ToString())).ToString();
                }
                else
                {
                    utility.MessageBox(this, "Please enter valid points?");
                    return;
                }
            }
            else
            {
                utility.MessageBox(this, "Please enter points?");
                return;
            }
        }
        catch { }
    }

}
