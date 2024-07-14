using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class admin_PrintIDCard : System.Web.UI.Page
{
    string regno = "";
    SqlConnection con = null;
    DataTable dt = null;
    SqlCommand com = null;
    SqlDataAdapter da = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Convert.ToString(Session["userId"])))
        {
            Response.Redirect("~/Default.aspx", false);
            return;
        }

        if (!IsPostBack)
        {
            regno = Session["userId"].ToString().Trim();
            BindData();

        }
    }

    public void BindData()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("GetUserByIdImg", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", regno);
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
            dt.Columns.Add("imagename", typeof(string));
            dt.Columns.Add("UserState", typeof(string));
            dt.Columns.Add("CompanyLogo", typeof(string));
            dt.Columns.Add("CoWebsite", typeof(string));
            dt.Columns.Add("CoAddres2", typeof(string));
            dt.Columns.Add("CoAddress", typeof(string));
            dt.Columns.Add("Generation_Rank", typeof(string));
            dt.Columns.Add("Binary_Rank", typeof(string));
            dt.Columns.Add("CustomerCareNo", typeof(string));
            DataRow dr;
            foreach (GridViewRow row in GridUserDisplay.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkRow = (row.Cells[0].FindControl("ChkMem") as CheckBox);
                    Label UserId = (row.Cells[0].FindControl("lblUID") as Label);
                    Label UserName = (row.Cells[0].FindControl("lblUserName") as Label);
                    Label UserAddress = (row.Cells[0].FindControl("lblUserAddress") as Label);
                    Label DOJ = (row.Cells[0].FindControl("lblDOJ") as Label);
                    Label Sponsorid = (row.Cells[0].FindControl("lblSponsorId") as Label);
                    Label cname = (row.Cells[0].FindControl("lblCompanyName") as Label);
                    Label Address = (row.Cells[0].FindControl("lblCAddress") as Label);
                    Label MobileNo = (row.Cells[0].FindControl("lblMobileNo") as Label);
                    Label imagename = (row.Cells[0].FindControl("lblimg") as Label);
                    Label UserState = (row.Cells[0].FindControl("lblUserState") as Label);
                    Label coLogo = (row.Cells[0].FindControl("lblCompanyLogo") as Label);
                    Label coWebsite = (row.Cells[0].FindControl("lblCompanyWebsite") as Label);
                    Label coAddress2 = (row.Cells[0].FindControl("lblCompanyAddress2") as Label);
                    Label coAddress = (row.Cells[0].FindControl("lblCompanyAddress") as Label);
                    Label genRank = (row.Cells[0].FindControl("lblGenRank") as Label);
                    Label binRank = (row.Cells[0].FindControl("lblBinRank") as Label);
                    Label custCare = (row.Cells[0].FindControl("lblCustomercare") as Label);
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
                        dr["imagename"] = imagename.Text;
                        dr["UserState"] = UserState.Text;
                        dr["CompanyLogo"] = coLogo.Text;
                        dr["CoWebsite"] = coWebsite.Text;
                        dr["CoAddres2"] = coAddress2.Text;
                        dr["CoAddress"] = coAddress.Text;
                        dr["Generation_Rank"] = genRank.Text;
                        dr["Binary_Rank"] = binRank.Text;
                        dr["CustomerCareNo"] = custCare.Text;
                        dt.Rows.Add(dr);
                    }
                }
            }
            if (dt.Rows.Count > 0)
            {

                Session["DT"] = dt;
                Response.Redirect("IDCard.aspx", true);
                Response.Redirect(Request.Url.AbsoluteUri);

            }
            else
            {
                utility.MessageBox(this, "Please Select User.");
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
                con = new SqlConnection(method.str);
                com = new SqlCommand("GetDataDatewise", con);
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
                    btnSubmit.Visible = true;
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
                con = new SqlConnection(method.str);
                com = new SqlCommand("GetByUserID", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@regno", txtUserSearch.Text.Trim());
                da = new SqlDataAdapter(com);
                dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {

                    GridUserDisplay.DataSource = dt;
                    GridUserDisplay.DataBind();
                    btnSubmit.Visible = true;
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
                utility.MessageBox(this, "Please enter user Id.");
                txtUserSearch.Focus();
                return;
            }

        }
        catch
        {

        }
    }


}