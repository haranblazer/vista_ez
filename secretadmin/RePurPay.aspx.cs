using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class Admin_RePurPay : System.Web.UI.Page
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
            getLastPayoutDate();
            txtFromDate.Text = DateTime.Now.AddDays(-6).Date.ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            //go();
        }

    }
    public void getLastPayoutDate()
    {
        //sda = new SqlDataAdapter("select isnull(max(paytodate),'2015-01-01') fromdate from Rdate", con);
        sda = new SqlDataAdapter("select Convert(varchar(50),(isnull(max(paytodate),'2015-01-01')),103) as  fromdate from Rdate", con);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["fromdate"].ToString() == "1/1/2015 12:00:00 AM")
            {
                lblLastPayoutDate.Text = "Last Repurchase was generated on Repurchase was generated ";
                txtFromDate.Text ="2015-01-01";
            }
            else
            {
                lblLastPayoutDate.Text = "Last Repurchase was generated on : " + dt.Rows[0]["fromdate"].ToString();
                txtFromDate.Text = dt.Rows[0]["fromdate"].ToString();
            }
        }
    }
    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    //go();
    //}
    //public void go()
    //{
    //    if (Regex.Match(txtFromDate.Text + txtFromDate.Text, @"^[0-9/]*$").Success)
    //    {
    //        try
    //        {
    //            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //            dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //            DateTime fromDate = new DateTime();
    //            DateTime toDate = new DateTime();
    //            try
    //            {
    //                fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
    //                toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
    //            }
    //            catch
    //            {
    //                utility.MessageBox(this, "Invalid date entry.");
    //                return;
    //            }
    //            if (fromDate <= toDate)
    //            {
    //                com = new SqlCommand("payoutdetails", con);
    //                com.CommandType = CommandType.StoredProcedure;
    //                com.Parameters.AddWithValue("@min", fromDate);
    //                com.Parameters.AddWithValue("@max", toDate);
    //                con.Open();
    //                sdr = com.ExecuteReader();
    //                if (sdr.Read())
    //                {

    //                    lblpaidUsers.Text = sdr["t1"].ToString();
    //                    lblunpaid.Text = sdr["Unpaid"].ToString();
    //                    lblTotalRegistered.Text = sdr["regcount"].ToString();
    //                    lblBV.Text = sdr["total"].ToString();
    //                    lblTotalPayout.Text = sdr["ptotal"].ToString();
    //                    lblPercentage.Text = sdr["percentage"].ToString() + "%";
    //                    lblbinaryamt.Text = sdr["b"].ToString();
    //                    lblbinarypercent.Text = sdr["bp"].ToString() + "%";
    //                    lblTPair.Text = sdr["Tpair"].ToString();
    //                    lblTPV.Text = sdr["TJoinFor"].ToString();
    //                }
    //            }
    //            else
    //            {
    //                utility.MessageBox(this, "Wrong date !");
    //            }
    //        }
    //        catch
    //        {
    //        }
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Invalid Date !");
    //    }
    //}
    protected void Button3_Click(object sender, EventArgs e)
    {
        if (Regex.Match(txtFromDate.Text + txtFromDate.Text, @"^[0-9/]*$").Success)
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();
            try
            {
                fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
                toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }
            if (fromDate <= toDate)
            {
                try
                {
                    com = new SqlCommand("PerformanceBonusIncome", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@min", fromDate);
                    com.Parameters.AddWithValue("@max", toDate);
                    com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    if (com.Parameters["@flag"].Value.ToString() == "1")
                    {
                        con.Close();
                        getLastPayoutDate();
                        utility.MessageBox(this, "Sucessfully...");
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
                utility.MessageBox(this, "Wrong date!");
            }
        }
        else
        {
            utility.MessageBox(this, "Invalid date !");
        }
    }

   
}