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

public partial class secretadmin_Title : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddMonths(-1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            BindDataDatewise();

        }
    }

    //public void reward()
    //{
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("userreward", con);
    //        com.CommandType = CommandType.StoredProcedure;

    //        da = new SqlDataAdapter(com);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {

    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();
    //            lblMessage.Text = "No of Record(s): " + dt.Rows.Count;


    //        }
    //        else
    //        {
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //            lblMessage.Text = string.Empty;
    //        }


    //    }
    //    catch
    //    {

    //    }

    //}

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //GridView1.PageIndex = e.NewPageIndex;
        if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && ddlTitleList.SelectedValue != "0")
        {
            BindSearchReward();
        }
        else
        {
            BindDataDatewise();
        }
        


    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //GridView1.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && ddlTitleList.SelectedValue!="0")
            {
                BindSearchReward();
            }
            else
            {
                BindDataDatewise();
            }
            //if (GridView1.Rows.Count > 0)
            //{
            //    Response.ClearContent();
            //    Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Title.doc");
            //    Response.ContentType = "application/vnd.ms-word";
            //    StringWriter stw = new StringWriter();
            //    HtmlTextWriter htextw = new HtmlTextWriter(stw);
            //    GridView1.RenderControl(htextw);
            //    Response.Write(stw.ToString());
            //    Response.End();
            //}
            //else
            //{
            //    utility.MessageBox(this, "Can't Export,No Data Found!");
            //}
        }
        catch
        {

        }
    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //GridView1.AllowPaging = false;
            //if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && ddlTitleList.SelectedValue != "0")
            //{
            //    BindSearchReward();
            //}
            //else
            //{
            //    BindDataDatewise();
            //}
            //if (GridView1.Rows.Count > 0)
            //{
            //    Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Title.xls");
            //    Response.ContentType = "application/vnd.xls";
            //    System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            //    System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            //    GridView1.RenderControl(htmlWrite);
            //    Response.Write(stringWrite.ToString());
            //    Response.End();
            //}
            //else
            //{
            //    utility.MessageBox(this, "Can't Export,No Data Found!");
            //}


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
                com = new SqlCommand("DatewiseTitle", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@FromDate", fromDate);
                com.Parameters.AddWithValue("@ToDate", toDate);
                da = new SqlDataAdapter(com);
                dt = new DataTable();
                da.Fill(dt);
                //if (dt.Rows.Count > 0)
                //{
                //    BindTitleList();
                //    GridView1.DataSource = dt;
                //    GridView1.DataBind();
                //    lblMessage.Text = "No of Record(s): " + dt.Rows.Count;
                //}
                //else
                //{
                //    GridView1.DataSource = null;
                //    GridView1.DataBind();
                //    lblMessage.Text = string.Empty;

                //}
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

    public void BindTitleList()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetTitleList", con);
            com.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlTitleList.DataSource = dt;
            ddlTitleList.DataTextField = "rewardRank";
            ddlTitleList.DataValueField = "srno";
            ddlTitleList.DataBind();
            ddlTitleList.Items.Insert(0, new ListItem("--Select Title--", "0"));
        }
        catch
        {

        }
    }
    protected void ddlTitleList_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()))
        {
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

            if (fromDate <= toDate)
            {
                con = new SqlConnection(method.str);
                com = new SqlCommand("SearchTitle", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@FromDate", fromDate);
                com.Parameters.AddWithValue("@ToDate", toDate);
                com.Parameters.AddWithValue("@Search", ddlTitleList.SelectedItem.Value.Trim());
                da = new SqlDataAdapter(com);
                dt = new DataTable();
                da.Fill(dt);
                //if (dt.Rows.Count > 0)
                //{
                //    GridView1.DataSource = dt;
                //    GridView1.DataBind();
                //    lblMessage.Text = "No of Record(s): " + dt.Rows.Count;
                //}
                //else
                //{
                //    GridView1.DataSource = null;
                //    GridView1.DataBind();
                //    lblMessage.Text = string.Empty;

                //}
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
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            //string d1 = GridView1.DataKeys[e.Row.RowIndex].Values[1].ToString();
            //string d3 = GridView1.DataKeys[e.Row.RowIndex].Values[0].ToString();
            //string d2 = GridView1.DataKeys[e.Row.RowIndex].Values[2].ToString();
            //if (d1 != "" || d2 != "")
            //{
            //    e.Row.BackColor = Color.FromName("#f5e187");
            //}

        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //try
        //{
        //    foreach (GridViewRow gv in GridView1.Rows)
        //    {
        //        TextBox txtdraft = (TextBox)gv.FindControl("txtdraftno");
        //        TextBox txtcomment = (TextBox)gv.FindControl("txtcomment");
        //        string id = GridView1.DataKeys[gv.DataItemIndex].Values[0].ToString();
              
        //        if (txtcomment.Text.Trim() != "" && txtcomment.Text.Trim() != "")
        //        {
        //            con = new SqlConnection(method.str);
        //            com = new SqlCommand("addrewardremark", con);
        //            com.CommandType = CommandType.StoredProcedure;
        //            com.Parameters.AddWithValue("@srno", id);
        //            com.Parameters.AddWithValue("@remarks", txtcomment.Text);
        //            com.Parameters.AddWithValue("@tranid", txtdraft.Text);
      
        //            con.Open();
        //            com.ExecuteNonQuery();
        //            con.Close();

        //        }

        //    }
        //    BindDataDatewise();
        //}
        //catch
        //{
        //}

    }
}