using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class secretadmin_CreateFranchisePayout : System.Web.UI.Page
{
    DataUtility Dutil = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
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
                Response.Redirect("adminLog.aspx", false);
            }
            if (!IsPostBack)
            {
                getLastPayoutDate();
                BindAllFranPayout();
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-","/");
            }
        }
        catch
        {

        }

    }
    public void getLastPayoutDate()
    {
        try
        {
            SqlParameter[] param = new SqlParameter[] { };
            DataTable dt = Dutil.GetDataTableSP(param, "GetFPayoutDate");
            if (dt.Rows.Count > 0)
            {
                lblLastPayoutDate.Text = "Last payout was generated on : " + dt.Rows[0]["pdate"].ToString();
                txtFromDate.Text = dt.Rows[0]["fromdate"].ToString();
            }
        }
        catch
        {

        }
    }

    protected void btnCreateFranchisePayout_Click(object sender, EventArgs e)
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

                if (fromDate > toDate)
                {
                    utility.MessageBox(this, "From Date never less than To Date.");
                    return;
                }
            }
            catch
            {
                utility.MessageBox(this, "Invalid Date !!!");
                return;
            }
            if (fromDate <= toDate)
            {
                try
                {
                    SqlConnection con = new SqlConnection(method.str);
                    SqlCommand com = new SqlCommand("FranchisePayout", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@min1", fromDate);
                    com.Parameters.AddWithValue("@max1", toDate);
                    com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    if (com.Parameters["@flag"].Value.ToString() == "1")
                    {
                        Response.Redirect("FranchisePayoutDetails.aspx", false);
                    }
                    else
                    {
                        utility.MessageBox(this, com.Parameters["@flag"].Value.ToString());
                    }
                     

                    //SqlParameter outparam = new SqlParameter("@flag", SqlDbType.VarChar, 100);
                    //outparam.Direction = ParameterDirection.Output;
                    //SqlParameter[] param = new SqlParameter[]
                    //{ 
                    //    new SqlParameter("@min1",fromDate),
                    //     new SqlParameter("@max1",toDate),
                    //     outparam
                    //};
                    //DataTable dt = Dutil.GetDataTableSP(param, "FranchisePayout");
                    //if (dt.Rows.Count > 0)
                    //{
                    //}
                }
                catch
                {
                }
            }
            else
            {
                utility.MessageBox(this, "Wrong Date !!!");
            }
        }
        else
        {
            utility.MessageBox(this, "Invalid Date !!!");
        }
    }

    protected void GridPayoutDate_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridPayoutDate.PageIndex = e.NewPageIndex;
        getLastPayoutDate();
    }

    public void BindAllFranPayout()
    {
        try
        {
            SqlParameter[] AllDataparam = new SqlParameter[]{
            };
            DataTable dt = Dutil.GetDataTableSP(AllDataparam, "GetAllFranPayout");
            if (dt.Rows.Count > 0)
            {
                GridPayoutDate.DataSource = dt;
                GridPayoutDate.DataBind();
            }
            else
            {
                GridPayoutDate.DataSource = null;
                GridPayoutDate.DataBind();
            }
        }
        catch
        {

        }
    }
}