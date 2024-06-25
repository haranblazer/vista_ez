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
using System.Text;

public partial class admin_TopperPayReport : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);

    SqlDataAdapter da;
    DataTable dt = new DataTable();
    string strsessionid;
    StringBuilder sb;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["admin"] == null)
        {
            Response.Redirect("adminlog.aspx");
        }

        if (!IsPostBack)
        {

           
            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            go();

        }
        
        
       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        go();
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

            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {
                //string qstr = "Select AppMst.AppMstRegNo,appmstleftright= " +"case appmst.appmstleftright when 0 then 'Left' when 1 then 'Right' end,AppMst.AppMstTitle+space(1)+AppMst.AppMstFName as name ,AppMst.Joinfor as joinfor,Appmst.ProductName As ProductName,convert(char(20),appmst.appmstdoj,103) as AppmstDOJ,AppMstSponsor.AppMstRegNo As SponsorRegNo from AppMst,AppTran, AppMst As AppMstSponsor WHere AppMst.SponsorId = AppMstSponsor.AppmstRegNo And AppMst.AppMstId = AppTran.AppMstId And AppTran.ParentId =(SELECT appmstid FROM appmst WHERE appmstregno='" + strsessionid + "') and AppMst.AppMstPaid=1  AND CAST(FLOOR(CAST(AppMst.AppMstDOJ as float)) as datetime) between '" + strmin + "' and '" + strmax + "'  Order by AppMst.AppMstId";
                da = new SqlDataAdapter("topperreport", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                da.SelectCommand.Parameters.AddWithValue("@min", fromDate);
                da.SelectCommand.Parameters.AddWithValue("@max", toDate);
                //da.SelectCommand.Parameters.AddWithValue("@paid", ddlMemberType.SelectedItem.Value);
                con.Open();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    
                    dgList.DataSource = dt;
                    dgList.DataBind();
                 
                }
                else
                {
                    dgList.DataSource = null;
                    dgList.DataBind();
                    dgList.EmptyDataText = "No data Found";

                }
                con.Close();
            }
            else
            {
                dgList.DataSource = null;
                dgList.DataBind();
                utility.MessageBox(this, "Invalid Date Range");
              

            }

        }
        catch
        {

        }
    }
    protected void dgList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
    
        dgList.PageIndex = e.NewPageIndex;
        go();
    
    }
    protected void dgList_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void dgList_RowCreated(object sender, GridViewRowEventArgs e)
    {

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (dgList.Rows.Count > 0)
        {
            dgList.AllowPaging = false;
            go();
            //Grdreport.Columns[16].Visible = Grdreport.Columns[17].Visible = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_TopperReport.xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dgList.RenderControl(htmlWrite);
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
        if (dgList.Rows.Count > 0)
        {
            dgList.AllowPaging = false;
            go();
            // Grdreport.Columns[16].Visible = Grdreport.Columns[17].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_TopperReport.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.dgList.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
    }
}