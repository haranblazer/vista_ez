using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class User_EventDetail : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //txtFromDate.Enabled = false;

            DateTime now = DateTime.Now;
            txtFromDate.Text = new DateTime(now.Year, now.Month, 1).ToString("dd/MM/yyyy").Replace("-", "/");

            //txtFromDate.Text = DateTime.Now.Date.AddMonths(-1).ToString("dd/MM/yyyy").Replace("-","/");
            txtToDate.Text = DateTime.Now.Date.AddYears(1).ToString("dd/MM/yyyy").Replace("-", "/");
            BindDataDatewise();
        }
    }

    public void BindState()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetState", con);
            com.CommandType = CommandType.StoredProcedure;

            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DdlState.DataSource = dt;
            DdlState.DataTextField = "StateName";
            DdlState.DataValueField = "SId";
            DdlState.DataBind();
            DdlState.Items.Insert(0, new ListItem("Select", "0"));
            //ddlDistrict.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch
        {

        }
    }

    protected void DdlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()))
        {
            BindSearchEvent();
        }
        else
        {
            utility.MessageBox(this, "Both From Date and To Date are Required!");
            return;
        }
    }
    protected void btnSearchByDate_Click(object sender, EventArgs e)
    {
        BindDataDatewise();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && DdlState.SelectedValue != "0")
        {
            BindSearchEvent();
        }
        else
        {
            BindDataDatewise();
        }

    }

    protected void ibtnWordExport_Click(object sender, EventArgs e)
    {
        try
        {
            GridView1.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && DdlState.SelectedValue != "0")
            {
                BindSearchEvent();
            }
            else
            {
                BindDataDatewise();
            }
            if (GridView1.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Event.doc");
                Response.ContentType = "application/vnd.ms-word";
                StringWriter stw = new StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                GridView1.RenderControl(htextw);
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
    protected void ibtnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {
            GridView1.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && DdlState.SelectedValue != "0")
            {
                BindSearchEvent();
            }
            else
            {
                BindDataDatewise();
            }
            if (GridView1.Rows.Count > 0)
            {
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Event.xls");
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter stringWrite = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
                GridView1.RenderControl(htmlWrite);
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

            if (fromDate <= toDate)
            {
                con = new SqlConnection(method.str);
                com = new SqlCommand("GetEventsByDate", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@FromDate", fromDate);
                com.Parameters.AddWithValue("@ToDate", toDate);
                com.Parameters.AddWithValue("@type", ddltype.SelectedValue);
                da = new SqlDataAdapter(com);
                dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    BindState();
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    lblMessage.Text = "No of Record(s): " + dt.Rows.Count;
                }
                else
                {
                    GridView1.DataSource = null;
                    GridView1.DataBind();
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

    public void BindSearchEvent()
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

            if (fromDate <= toDate)
            {
                con = new SqlConnection(method.str);
                com = new SqlCommand("GetEventsByState", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@FromDate", fromDate);
                com.Parameters.AddWithValue("@ToDate", toDate);
                com.Parameters.AddWithValue("@State", DdlState.SelectedItem.Text.Trim());
                com.Parameters.AddWithValue("@type", ddltype.SelectedValue);
                da = new SqlDataAdapter(com);
                dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    lblMessage.Text = "No of Record(s): " + dt.Rows.Count;
                }
                else
                {
                    GridView1.DataSource = null;
                    GridView1.DataBind();
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