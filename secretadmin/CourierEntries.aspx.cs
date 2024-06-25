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
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Collections.Generic;
public partial class admin_CourierEntries : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable t = new DataTable();
    utility utilobj = new utility();
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
            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            go();
            //BindUserID();
        }

    }
    public void go()
    {
        try
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();

            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
            double datedays = (toDate - fromDate).TotalDays;          
            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {
                if (datedays > 31)
                {
                    utility.MessageBox(this, "Maximum 31 days allowed");
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                    return;
                }   
                           
                cmd = new SqlCommand("getcourier", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@mindate", fromDate);
                cmd.Parameters.AddWithValue("@maxdate", toDate);
                cmd.Parameters.AddWithValue("@userid", txtUserId.Text.Trim());
                cmd.Parameters.AddWithValue("@from", Session["admin"].ToString());
                da = new SqlDataAdapter(cmd);
                da.Fill(t);
                if (t.Rows.Count > 0)
                {
                    Label2.Text = "No Of Records :" + t.Rows.Count.ToString();
                    GridView1.DataSource = t;
                    GridView1.DataBind();

                }
                else
                {
                    Label2.Text = string.Empty;
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                }

            }
            else
            {
                utility.MessageBox(this, "Invalid date entry");
            }
        }
        catch
        {
        }

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        go();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;

        go();

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        go();

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            go();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Courierlist.xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            go();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Courierlist.doc");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        int rowindex = Convert.ToInt32(e.CommandArgument);
        string cartid = GridView1.DataKeys[rowindex].Values[0].ToString();
        //string userid = GridView1.Rows[rowindex].Cells[1].ToString();
        GridViewRow row = (GridViewRow)GridView1.Rows[rowindex];
        
        string userid = (row.FindControl("lbluserid") as Label).Text;
       
        if (e.CommandName == "S")
        {

            con = new SqlConnection(method.str);
            cmd = new SqlCommand("courierUpdate", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@cartid", cartid);
            cmd.Parameters.AddWithValue("@type", 1);
            con.Open();
            int c = cmd.ExecuteNonQuery();
            con.Close();
            if (c > 0)
            {
                utility.MessageBox(this, "Courier Received Successfully");

                //  btnC.Text = "Received";
            }

        }

        go();


    }

}
