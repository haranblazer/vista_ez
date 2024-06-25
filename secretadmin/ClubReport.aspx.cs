using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;

public partial class secretadmin_ClubReport : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com = null;
    SqlDataAdapter sda = null;
    DataTable dt = null;
    int flagSearch;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //BindClubList();
            flagSearch = 0;
            ViewState["flagsearch"] = flagSearch;
            txtFromDate.Text = DateTime.Now.Date.AddMonths(0).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            BindDataDatewise();
        }
    }

    public void BindClubList()
    {
        try
        {
            com = new SqlCommand("GetClubList", con);
            com.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridClubList.DataSource = dt;
                GridClubList.DataBind();
            }
            else
            {
                GridClubList.DataSource = null;
                GridClubList.DataBind();
            }
        }
        catch
        {

        }
    }
    protected void GridClubList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridClubList.PageIndex = e.NewPageIndex;
        //BindClubList();
        //BindDataDatewise();
        flagSearch=(int)ViewState["flagsearch"];
        if (flagSearch == 0)
        {
            BindSearchReward();

        }
        else
        {
            BindDataDatewise();

        }
    }
    //protected void rbtClubList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    BindClubList();
    //}



    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            GridClubList.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && ddlRewardList.SelectedValue != "0")
            {
                BindSearchReward();
            }
            else
            {
                BindDataDatewise();
            }
            if (GridClubList.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Reward.doc");
                Response.ContentType = "application/vnd.ms-word";
                StringWriter stw = new StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                GridClubList.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();
            }
            else
            {
                utility.MessageBox(this, "Can't Export,No Data Found!");
            }
        }
        catch
        {

        }
    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            GridClubList.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && ddlRewardList.SelectedValue != "0")
            {
                BindSearchReward();
            }
            else
            {
                BindDataDatewise();
            }
            if (GridClubList.Rows.Count > 0)
            {
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Reward.xls");
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter stringWrite = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
                GridClubList.RenderControl(htmlWrite);
                Response.Write(stringWrite.ToString());
                Response.End();
            }
            else
            {
                utility.MessageBox(this, "Can't Export,No Data Found!");
            }


        }
        catch
        {

        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

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
                utility.MessageBox(this, "Invalid Date!");
                return;
            }
            double datedays = (toDate - fromDate).TotalDays;
            if (datedays > 31)
            {
                utility.MessageBox(this, "Maximum 31 days allowed");
                GridClubList.DataSource = null;
                GridClubList.DataBind();
                lblMessage.Text = "";
                return;
            }
            if (fromDate <= toDate)
            {
                con = new SqlConnection(method.str);
                com = new SqlCommand("DatewiseClub", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@FromDate", fromDate);
                com.Parameters.AddWithValue("@ToDate", toDate);
                sda = new SqlDataAdapter(com);
                dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    BindRewardList();
                    GridClubList.DataSource = dt;
                    GridClubList.DataBind();
                    lblMessage.Text = "No of Record(s): " + dt.Rows.Count;
                }
                else
                {
                    GridClubList.DataSource = null;
                    GridClubList.DataBind();
                    lblMessage.Text = string.Empty;

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


    protected void btnSearchByDate_Click(object sender, EventArgs e)
    {
        flagSearch = 1;
        ViewState["flagsearch"] = flagSearch;
        BindDataDatewise();
    }

    public void BindRewardList()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetTitleList", con);
            com.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddlRewardList.DataSource = dt;
            ddlRewardList.DataTextField = "rewardRank";
            ddlRewardList.DataValueField = "srno";
            ddlRewardList.DataBind();
            //ddlRewardList.Items.Insert(0, new ListItem("--Select Reward--", "0"));
        }
        catch
        {

        }
    }
    protected void ddlRewardList_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()))
        {
            flagSearch = 0;
            ViewState["flagsearch"] = flagSearch;
            BindSearchReward();
        }
        else
        {
            utility.MessageBox(this, "Both From Date and To Date are Required!");
            return;
        }
    }

    public void BindSearchReward()
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
                utility.MessageBox(this, "Invalid Date!");
                return;
            }
            double datedays = (toDate - fromDate).TotalDays;
            if (datedays > 31)
            {
                utility.MessageBox(this, "Maximum 31 days allowed");
                GridClubList.DataSource = null;
                GridClubList.DataBind();
                lblMessage.Text = "";
                return;
            }
            if (fromDate <= toDate)
            {
                con = new SqlConnection(method.str);
                com = new SqlCommand("SearchClub", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@FromDate", fromDate);
                com.Parameters.AddWithValue("@ToDate", toDate);
                com.Parameters.AddWithValue("@Search", ddlRewardList.SelectedItem.Value.Trim());
                sda = new SqlDataAdapter(com);
                dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    GridClubList.DataSource = dt;
                    GridClubList.DataBind();
                    lblMessage.Text = "No of Record(s): " + dt.Rows.Count;
                }
                else
                {
                    GridClubList.DataSource = null;
                    GridClubList.DataBind();
                    lblMessage.Text = string.Empty;

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
}