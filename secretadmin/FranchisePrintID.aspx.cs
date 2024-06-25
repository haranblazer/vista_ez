using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_FranchisePrintID : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = null;
    SqlCommand com = null;
    SqlDataAdapter da = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Page.Response.Cache.SetCacheability(HttpCacheability.ServerAndNoCache);
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {

                BindData();

            }
        }
        catch
        {

        }
       
    }

    public void BindData()
    {

        com = new SqlCommand("GetFranPrintData", con);
        com.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(com);
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {

            Session["DT"] = null;
            GridUserDisplay.DataSource = dt;
            GridUserDisplay.DataBind();
        }
        else
        {
            GridUserDisplay.DataSource = null;
            GridUserDisplay.DataBind();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        try
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("UserID", typeof(string));
            dt.Columns.Add("UserName", typeof(string));
            dt.Columns.Add("UserAddress", typeof(string));
            dt.Columns.Add("DOJ", typeof(string));
            dt.Columns.Add("Sponsorid", typeof(string));
            dt.Columns.Add("CompanyName", typeof(string));
            dt.Columns.Add("Address", typeof(string));
            dt.Columns.Add("MobileNo", typeof(string));
            DataRow dr;
            foreach (GridViewRow row in GridUserDisplay.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("ChkMem") as CheckBox);
                    Label UserId = (row.Cells[0].FindControl("lblFID") as Label);
                    Label UserName = (row.Cells[0].FindControl("lblFranName") as Label);
                    Label UserAddress = (row.Cells[0].FindControl("lblFranAddress") as Label);
                    Label DOJ = (row.Cells[0].FindControl("lblDOJ") as Label);
                    Label Sponsorid = (row.Cells[0].FindControl("lblFranSponsorId") as Label);
                    Label cname = (row.Cells[0].FindControl("lblCompanyName") as Label);
                    Label Address = (row.Cells[0].FindControl("lblCAddress") as Label);
                    Label MobileNo = (row.Cells[0].FindControl("lblMobileNo") as Label);


                    if (chkRow.Checked)
                    {

                        dr = dt.NewRow();

                        dr["UserID"] = UserId.Text;
                        dr["UserName"] = UserName.Text;
                        dr["UserAddress"] = UserAddress.Text;
                        dr["DOJ"] = DOJ.Text;
                        dr["Sponsorid"] = Sponsorid.Text;
                        dr["CompanyName"] = cname.Text;
                        dr["Address"] = Address.Text;
                        dr["MobileNo"] = MobileNo.Text;
                        dt.Rows.Add(dr);
                    }
                }
            }
            if (dt.Rows.Count > 0)
            {

                Session["DT"] = dt;
                Response.Redirect("FranchiseIDCard.aspx", true);
                Response.Redirect(Request.Url.AbsoluteUri);

            }
            else
            {
                utility.MessageBox(this, "Please Select Franchise.");
                Session["DT"] = null;
                return;
            }
        }
        catch
        {

        }
    }
    protected void GridUserDisplay_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridUserDisplay.PageIndex = e.NewPageIndex;

        try
        {
            if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()))
            {
                BindDataDatewise();
            }
            else
            {
                BindData();
            }
        }
        catch
        {

        }


    }
    protected void btnUserSearch_Click(object sender, EventArgs e)
    {
        SearchByID();

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataDatewise();

    }
    public void BindDataDatewise()
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
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }

            if (fromDate <= toDate)
            {

                com = new SqlCommand("GetFranDateWise", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@FromDate", fromDate);
                com.Parameters.AddWithValue("@ToDate", toDate);
                da = new SqlDataAdapter(com);
                dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {

                    GridUserDisplay.DataSource = dt;
                    GridUserDisplay.DataBind();
                }
                else
                {
                    GridUserDisplay.DataSource = null;
                    GridUserDisplay.DataBind();
                    btnSubmit.Visible = false;
                }
            }
            else
            {
                utility.MessageBox(this, "Sorry,from date should not greater than to date.");
                txtFromDate.Focus();
            }

        }
        catch
        {

        }

    }
    public void SearchByID()
    {
        try
        {
            if (!string.IsNullOrEmpty(txtUserSearch.Text.Trim()))
            {

                com = new SqlCommand("GetByFranId", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@regno", txtUserSearch.Text.Trim());
                da = new SqlDataAdapter(com);
                dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {

                    GridUserDisplay.DataSource = dt;
                    GridUserDisplay.DataBind();
                }
                else
                {
                    GridUserDisplay.DataSource = null;
                    GridUserDisplay.DataBind();
                    btnSubmit.Visible = false;
                }
            }
            else
            {
                utility.MessageBox(this, "Please enter Franchise Id.");
                txtUserSearch.Focus();
                return;
            }

        }
        catch
        {

        }
    }
}