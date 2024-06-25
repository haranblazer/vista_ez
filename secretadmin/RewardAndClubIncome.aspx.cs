using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


public partial class secretadmin_RewardAndClubIncome : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindClubPayoutDate();
            LastClubPayoutDate();
           
        }
    }
    protected void btnClubIncome_Click(object sender, EventArgs e)
    {
        try
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
                utility.MessageBox(this, "Invalid Date !!!");
                return;
            }
            if (fromDate > toDate)
            {
                utility.MessageBox(this, "Invalid Date !!!");
                return;
            }
            if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()))
            {
                if (!string.IsNullOrEmpty(txtToDate.Text.Trim()))
                {
                    DataUtility Sq = new DataUtility();
                    SqlParameter[] sqlparam = new SqlParameter[] {
                    new SqlParameter("@mindate", fromDate),
                    new SqlParameter("@maxdate", toDate),
                    };
                    DataTable dt = Sq.GetDataTableSP(sqlparam, "Clubincome");
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Rows[0]["status"].ToString() == "0")
                            BindClubPayoutDate();
                            utility.MessageBox(this, "Club & Reward Income Calculated Successfully.");
                        return;
                    }

                }
                else
                {
                    utility.MessageBox(this, "Select To Date.");
                    txtToDate.Focus();
                }
            }
            else
            {
                utility.MessageBox(this, "Select From Date.");
                txtFromDate.Focus();
            }
        }
        catch
        {

        }
    }
    public void LastClubPayoutDate()
    {
        try
        {
            da = new SqlDataAdapter("Getlastclubpayoutdate", con);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lblLastClubPayoutDate.Text = "Last Club Income payout was generated on : " + dt.Rows[0]["pdate"].ToString();
                txtFromDate.Text = dt.Rows[0]["fromdate"].ToString();
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            }
        }
        catch
        {

        }
    }
    protected void GridClubIncome_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridClubIncome.PageIndex = e.NewPageIndex;
        LastClubPayoutDate();
    }

    public void BindClubPayoutDate()
    {
        try
        {
            DataUtility dutil = new DataUtility();

            SqlParameter[] param = new SqlParameter[]
            {
                
            };

            DataTable datat = dutil.GetDataTableSP(param, "getclubpayout");
            if (datat.Rows.Count > 0)
            {
                GridClubIncome.DataSource = datat;
                GridClubIncome.DataBind();
            }
            else
            {
                GridClubIncome.DataSource = null;
                GridClubIncome.DataBind();

            }

        }

        catch
        {

        }
    }
}