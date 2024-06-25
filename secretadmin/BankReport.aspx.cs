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
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;

public partial class BankReport : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(method.str);

    SqlCommand cmd;

    string str;
    utility objUtiliy = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminloginInside();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!Page.IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-7).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            bindGrid();
        }
    }
    private void bindGrid()
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
            lblMsg.Text = "Invalid date entry.";
            return;
        }
        double datedays = (toDate - fromDate).TotalDays;
        if (datedays > 31)
        {
            utility.MessageBox(this, "Maximum 31 days allowed");
            gvActivePinList.DataSource = null;
            gvActivePinList.DataBind();
            GridView1.DataSource = null;
            GridView1.DataBind();
            return;
        }
        cmd = new SqlCommand("bankdetail", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@mindate", fromDate);
        cmd.Parameters.AddWithValue("@maxdate", toDate);
        cmd.Parameters.AddWithValue("@type", ddlPinType.SelectedItem.Value);
        cmd.Parameters.Add("@mes", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable table = new DataTable();
        sda.Fill(table);
        con.Open();
        {

            str = (string)cmd.Parameters["@mes"].Value;

            if (str == "bank")
            {
                if (table.Rows.Count > 0)
                {
                    // gvActivePinList.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? table.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
                    gvActivePinList.DataSource = table;
                    gvActivePinList.DataBind();
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                }
                else
                {
                    gvActivePinList.DataSource = null;
                    gvActivePinList.DataBind();
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                }

            }


            if (str == "pan")
            {
                if (table.Rows.Count > 0)
                {
                    // GridView1.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? table.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
                    GridView1.DataSource = table;
                    GridView1.DataBind();
                    gvActivePinList.DataSource = null;
                    gvActivePinList.DataBind();
                }
                else
                {
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                    gvActivePinList.DataSource = null;
                    gvActivePinList.DataBind();

                }

            }



        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

    }
   
    //protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    bindGrid();
    //}
    protected void gvActivePinList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvActivePinList.PageIndex = e.NewPageIndex;
        bindGrid();
    }

    protected void ddlPinType_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindGrid();
    }
    //protected void btSearch_Click(object sender, EventArgs e)
    //{
    //    bindGrid();

    //}
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindGrid();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        
    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        
        if(ddlPinType.SelectedItem.Text=="Bank" || ddlPinType.SelectedItem.Text=="Pan")
        {
            if (gvActivePinList.Rows.Count > 0)
            {
                gvActivePinList.AllowPaging = false;
                bindGrid();                
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductBillingList.doc");
                Response.ContentType = "application/vnd.ms-word";
                System.IO.StringWriter stw = new System.IO.StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                this.gvActivePinList.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();

            }
            else if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                bindGrid();                
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductBillingList.doc");
                Response.ContentType = "application/vnd.ms-word";
                System.IO.StringWriter stw = new System.IO.StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                this.GridView1.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();

            }


            else

                utility.MessageBox(this, "can not export as no data found !");
        }
    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if(ddlPinType.SelectedItem.Text=="Bank" || ddlPinType.SelectedItem.Text=="Pan")
        {
        if (gvActivePinList.Rows.Count > 0)
        {
            gvActivePinList.AllowPaging = false;
            bindGrid();
            //gvActivePinList.Columns[14].Visible = GridView1.Columns[17].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductBillingList.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.gvActivePinList.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            bindGrid();
            //gvActivePinList.Columns[14].Visible = GridView1.Columns[17].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductBillingList.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }


        else
        
          utility.MessageBox(this, "can not export as no data found !");
    }
}
}