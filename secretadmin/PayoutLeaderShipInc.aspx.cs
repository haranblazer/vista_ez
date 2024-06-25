using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;

public partial class secretadmin_PayoutLeaderShipInc : System.Web.UI.Page
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
          
            getLastPayoutDate();
            txtFromDate.Text = DateTime.Now.AddDays(-30).Date.ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
           
        }

    }
    public void getLastPayoutDate()
    {
        sda = new SqlDataAdapter("select convert(varchar(20),paytodate,103) as pdate, convert(varchar(20),dateadd(day,1,paytodate),103) fromdate from LDate where payoutno=(select max(payoutno) from LDate )", con);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            lblLastPayoutDate.Text = "Last payout was generated on : " + dt.Rows[0]["pdate"].ToString();
            txtFromDate.Text = dt.Rows[0]["pdate"].ToString();
        }
    }
    
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
                    com = new SqlCommand("CalculateClubIncome", con);
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
                        utility.MessageBox(this, "Income Calculated successfully.");
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
