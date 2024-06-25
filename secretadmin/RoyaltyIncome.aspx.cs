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

public partial class secretadmin_RoyaltyIncome : System.Web.UI.Page
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

        }

    }
    public void getLastPayoutDate()
    {
        sda = new SqlDataAdapter("select convert(varchar(20),paytodate,103) as pdate,convert(varchar(20),dateadd(day,1,paytodate),103)  fromdate from payoutdate where payoutno=(select max(payoutno) from payoutdate )", con);
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
        try
        {

            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();

            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);

            if (fromDate <= toDate)
            {

                com = new SqlCommand("Royaltyincome", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@min", fromDate);
                com.Parameters.AddWithValue("@max", toDate);
                com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                if (com.Parameters["@flag"].Value.ToString() == "1")
                {
                    con.Close();
                    utility.MessageBox(this, "Royalty Income Created Successfully");
                }
                else
                {
                    con.Close();
                    utility.MessageBox(this, com.Parameters["@flag"].Value.ToString());
                }
            }

            else
            {
                utility.MessageBox(this, "Starting Date Should Be less Than End Date");
            }



        }


        catch (Exception ex)
        {
            utility.MessageBox(this, ex.StackTrace);
        }





    }
}