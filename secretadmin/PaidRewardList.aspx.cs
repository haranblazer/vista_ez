using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using System.Drawing;
 

public partial class secretadmin_PaidRewardList : System.Web.UI.Page
{
    SqlConnection con=null;
    SqlCommand com=null;
    SqlDataAdapter da=null;
    DataTable dt=null;
    protected void Page_Load(object sender, EventArgs e)
    {
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
                txtFromDate.Text = DateTime.Now.Date.AddMonths(-1).ToString("dd/MM/yyyy");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                BindRewardList();
                BindDataDatewise();

            }
        }
        catch
        {

        }
       
    }
    protected void gridlist_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridlist.PageIndex = e.NewPageIndex;
        BindDataDatewise();
        //if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && ddlRewardList.SelectedValue != "0")
        //{
        //    BindSearchReward();
        //}
        //else
        //{
        //    BindDataDatewise();
        //}
    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            gridlist.AllowPaging = false;
            BindDataDatewise();
            //if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && ddlRewardList.SelectedValue != "0")
            //{
            //    BindSearchReward();
            //}
            //else
            //{
            //    BindDataDatewise();
            //}
            if (gridlist.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Reward.doc");
                Response.ContentType = "application/vnd.ms-word";
                StringWriter stw = new StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                gridlist.RenderControl(htextw);
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
            gridlist.AllowPaging = false;
            BindDataDatewise();
            //if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && ddlRewardList.SelectedValue != "0")
            //{
            //    BindSearchReward();
            //}
            //else
            //{
            //    BindDataDatewise();
            //}
            if (gridlist.Rows.Count > 0)
            {
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Reward.xls");
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter stringWrite = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
                gridlist.RenderControl(htmlWrite);
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
            if (datedays > 366)
            {
                utility.MessageBox(this, "Maximum 366 days allowed");
                gridlist.DataSource = null;
                gridlist.DataBind();
                return;
            }
            if (fromDate <= toDate)
            {
                con = new SqlConnection(method.str);
                da = new SqlDataAdapter ("PaidReward", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.SelectCommand.Parameters.AddWithValue("@FromDate", fromDate);
                da.SelectCommand.Parameters.AddWithValue("@ToDate", toDate);
                da.SelectCommand.Parameters.AddWithValue("@Search",ddlRewardList.SelectedValue.ToString());                          
                dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    //BindRewardList();
                    gridlist.DataSource = dt;
                    gridlist.DataBind();
                    lblMessage.Text = "No of Record(s): " + dt.Rows.Count;
                }
                else
                {
                    gridlist.DataSource = null;
                    gridlist.DataBind();
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
        BindDataDatewise();
    }

    public void BindRewardList()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetRewardList", con);
            com.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlRewardList.DataSource = dt;
            ddlRewardList.DataTextField = "name";
            ddlRewardList.DataValueField = "srno";
            ddlRewardList.DataBind();
            ddlRewardList.Items.Insert(0, new ListItem("--Select Reward--", "0"));
        }
        catch
        {

        }
    }
    protected void ddlRewardList_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()))
        {
            BindDataDatewise();
        }
        else
        {
            utility.MessageBox(this, "Both From Date and To Date are Required!");
            return;
        }
    }

    //public void BindSearchReward()
    //{
    //    try
    //    {
    //        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //        dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //        DateTime fromDate = new DateTime();
    //        DateTime toDate = new DateTime();
    //        try
    //        {
    //            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
    //            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid Date!");
    //            return;
    //        }

    //        if (fromDate <= toDate)
    //        {
    //            con = new SqlConnection(method.str);
    //            com = new SqlCommand("SearchReward", con);
    //            com.CommandType = CommandType.StoredProcedure;
    //            com.Parameters.AddWithValue("@FromDate", fromDate);
    //            com.Parameters.AddWithValue("@ToDate", toDate);
    //            com.Parameters.AddWithValue("@Search", ddlRewardList.SelectedItem.Value.Trim());
    //            da = new SqlDataAdapter(com);
    //            dt = new DataTable();
    //            da.Fill(dt);
    //            if (dt.Rows.Count > 0)
    //            {
    //                gridlist.DataSource = dt;
    //                gridlist.DataBind();
    //                lblMessage.Text = "No of Record(s): " + dt.Rows.Count;
    //            }
    //            else
    //            {
    //                gridlist.DataSource = null;
    //                gridlist.DataBind();
    //                lblMessage.Text = string.Empty;

    //            }
    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "Sorry,from date should not greater than to date.");
    //            txtFromDate.Focus();
    //        }


    //    }
    //    catch
    //    {

    //    }

    //}
    protected void gridlist_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            //string d1 = gridlist.DataKeys[e.Row.RowIndex].Values[1].ToString();
            //string d3 = gridlist.DataKeys[e.Row.RowIndex].Values[0].ToString();
            //string d2 = gridlist.DataKeys[e.Row.RowIndex].Values[2].ToString();
            //if (d1 != "" || d2 != "")
            //{
            //    e.Row.BackColor = Color.FromName("#f5e187");
            //}

        }
    }

   
}