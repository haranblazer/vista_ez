using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Collections.Generic;
public partial class user_downstatus : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    DataTable dt = new DataTable();
    string strsessionid;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
            Response.Redirect("~/login.aspx", false);
        else if(!IsPostBack)
            InsertFunction.Checklogin();
        strsessionid = Convert.ToString(Session["userId"]);
       
            if (!IsPostBack)
            {
                
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                txtFromDate.Text = DateTime.Now.Date.AddDays(-1).ToString("dd/MM/yyyy");
                this.go(1);
               // getusername();
            }
        
    }
    public void go(int pageIndex)
    {
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        string strmin = "";
        string strmax = "";
        try
        {
            if (txtFromDate.Text.Trim().Length > 0)
                strmin = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo).ToString();
            if (txtToDate.Text.Trim().Length > 0)
                strmax = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo).ToString();
        }
        catch
        {
            Label1.Text = "Invalid date entry.";
            return;
        }
        double diff = (Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo) - Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo)).TotalDays;
        if (diff > 31)
        {
            utility.MessageBox(this, "Maximum 31 days allowed!");
            GridView1.DataSource = null;
            GridView1.DataBind();
            Label1.Text = string.Empty;
            return;
        }
        try
        {
           
            if (Convert.ToDateTime(strmin) <= Convert.ToDateTime(strmax))
            {
                if (Regex.Match(strsessionid, @"^[a-zA-Z0-9]*$").Success)
                {
                    try
                    {
                        da = new SqlDataAdapter("getcourierforuser", con);
                        da.SelectCommand.CommandType = CommandType.StoredProcedure;
                        da.SelectCommand.Parameters.AddWithValue("@userid", strsessionid);
                        da.SelectCommand.Parameters.AddWithValue("@PageIndex", pageIndex);
                        da.SelectCommand.Parameters.AddWithValue("@PageSize", PageSize);
                        //da.SelectCommand.Parameters.Add("@RecordCount", SqlDbType.Int, 4);
                        //da.SelectCommand.Parameters["@RecordCount"].Direction = ParameterDirection.Output;
                        da.SelectCommand.Parameters.AddWithValue("@mindate", strmin);
                        da.SelectCommand.Parameters.AddWithValue("@maxdate", strmax);
                        con.Open();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                            //int recordCount = Convert.ToInt32(da.SelectCommand.Parameters["@RecordCount"].Value);
                            //this.PopulatePager(recordCount, pageIndex);
                            //Label2.Text = "No Of Records:";
                            int recordCount = Convert.ToInt32(dt.Rows.Count);

                            Label1.Text = "<font color=darkred>NO. OF RECORDS: " + recordCount.ToString() + "</font>";
                            //Label2.Text = dt.Rows.Count.ToString();
                            //double amt = 0,leftTotal=0,rightTotal=0;
                            //foreach (DataRow rw in dt.Rows)
                            //{
                            //    amt += Convert.ToDouble(rw["jamount"].ToString());
                              
                            //}
                            //LblAmount.Text = Convert.ToString(amt);
                        }
                        else
                        {
                            Label1.Text = "<font color=darkred>NO RECORDS FOUND!</font>";
                        }
                        con.Close();
                    }
                    catch
                    {
                    }

                }
                else
                {
                    Label1.Text = "INVALID ID";
                }

            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                Label1.Text = "<font color=darkred>FromDate must be less than or equal to ToDate!</font>";
            }
        }
        catch
        {
        }
    }
    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    go();
    //}
    protected void Button1_Click(object sender, EventArgs e)
    {
        go(1);
    }
    
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            GetExcelExport();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Downstatus.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this,"Can't export as no data found !");
        }
    }

    protected void getusername()
    {
      
        SqlCommand  com = new SqlCommand("getUserMaster", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", strsessionid);
        con.Open();
        SqlDataReader dr = com.ExecuteReader();
        if (dr.Read())
        {
            //lblLeft.Text = Convert.ToString(Convert.ToInt32(dr["AppmstLeftTotal"]));
            //lblRight.Text = Convert.ToString(Convert.ToInt32(dr["AppmstRightTotal"]));

           // Label1.Text = Convert.ToString(Convert.ToInt32(dr["AppmstLeftTotal"]) + Convert.ToInt32(dr["AppmstRightTotal"]));
            con.Close();
        }
        else { }

    }

    private int PageSize = 50;

    private void PopulatePager(int recordCount, int currentPage)
    {
        try
        {
            List<ListItem> pages = new List<ListItem>();
            int startIndex, endIndex;
            int pagerSpan = 5;

            //Calculate the Start and End Index of pages to be displayed.
            double dblPageCount = (double)((decimal)recordCount / Convert.ToDecimal(PageSize));
            int pageCount = (int)Math.Ceiling(dblPageCount);
            startIndex = currentPage > 1 && currentPage + pagerSpan - 1 < pagerSpan ? currentPage : 1;
            endIndex = pageCount > pagerSpan ? pagerSpan : pageCount;
            if (currentPage > pagerSpan % 2)
            {
                if (currentPage == 2)
                {
                    endIndex = 5;
                }
                else
                {
                    endIndex = currentPage + 2;
                }
            }
            else
            {
                endIndex = (pagerSpan - currentPage) + 1;
            }

            if (endIndex - (pagerSpan - 1) > startIndex)
            {
                startIndex = endIndex - (pagerSpan - 1);
            }

            if (endIndex > pageCount)
            {
                endIndex = pageCount;
                startIndex = ((endIndex - pagerSpan) + 1) > 0 ? (endIndex - pagerSpan) + 1 : 1;
            }

            //Add the First Page Button.
            if (currentPage > 1)
            {
                pages.Add(new ListItem("First", "1"));
            }

            //Add the Previous Button.
            if (currentPage > 1)
            {
                pages.Add(new ListItem("<<", (currentPage - 1).ToString()));
            }

            for (int i = startIndex; i <= endIndex; i++)
            {
                pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
            }

            //Add the Next Button.
            if (currentPage < pageCount)
            {
                pages.Add(new ListItem(">>", (currentPage + 1).ToString()));
            }

            //Add the Last Button.
            if (currentPage != pageCount)
            {
                pages.Add(new ListItem("Last", pageCount.ToString()));
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();
           
        }
        catch
        {

        }
    }


    protected void Page_Changed(object sender, EventArgs e)
    {
        try
        {
            int pageIndex = int.Parse((sender as LinkButton).CommandArgument);
            this.go(pageIndex);
        }
        catch
        {

        }
    }

    private void GetExcelExport()
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
                utility.MessageBox(this,"Invalid Date !!!");
                return;

            }
            if (fromDate > toDate)
            {
                ScriptManager.RegisterClientScriptBlock(this,GetType(), "AlertMsg", "alert('Please Select Valid Date !!!')", true);
            }
            con.Open();
            SqlCommand cmd = new SqlCommand("GetExcelExport", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.SelectCommand.Parameters.AddWithValue("@regno", strsessionid);
            cmd.Parameters.AddWithValue("@fromdate", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            da.Fill(dt);
            con.Close();
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
        catch
        {

        }
    }
}
