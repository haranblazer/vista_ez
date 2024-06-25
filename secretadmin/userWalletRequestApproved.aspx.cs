using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Text.RegularExpressions;

public partial class secretadmin_userWalletRequestApproved : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
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
                txtFromdate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/");
                txtTodate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");

                if (Request.QueryString["Key"] != null)
                {
                    if (Request.QueryString["Key"] == "TOTALCWALLET")
                    {
                        ddl_Status.SelectedValue = "1";
                        if (Request.QueryString["From"].ToString().Length > 0)
                            txtFromdate.Text = Request.QueryString["From"].ToString();
                        if (Request.QueryString["To"].ToString().Length > 0)
                            txtTodate.Text = Request.QueryString["To"].ToString();
                    }
                    else
                    {
                        ddl_Status.SelectedValue = "0";
                        txtFromdate.Text = "";
                        txtTodate.Text = "";
                    }

                }
                BindData();

            }
        }
        catch
        {

        }

      
    }

    private void BindData()
    {
        String fromDate = "", toDate = "";
        try
        {
            if (txtFromdate.Text.Trim().Length > 0)
            {
                String[] Date = txtFromdate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
            if (txtTodate.Text.Trim().Length > 0)
            {
                String[] Date = txtTodate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
        }
        catch
        {
            utility.MessageBox(this, "Invalid date entry2.");
            return;
        }


        SqlParameter[] param = new SqlParameter[]
      {
             new SqlParameter("@fromdate",fromDate),
             new SqlParameter("@Todate", toDate),
             new SqlParameter("@regno", null),
             new SqlParameter("@Status", ddl_Status.SelectedValue)
      };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "userWalletRequestApproved");
        if (dt.Rows.Count > 0)
        {
            GridView1.Columns[3].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(amt)", "true").ToString()) ? "0.00" : dt.Compute("sum(amt)", "true").ToString());
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindData();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdf_Status = (HiddenField)e.Row.FindControl("hdf_Status");
            Label lbl_StatusText = (Label)e.Row.FindControl("lbl_StatusText");
            if (hdf_Status.Value == "1")
            {
                lbl_StatusText.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lbl_StatusText.ForeColor = System.Drawing.Color.Red;
            }

        }
    }

    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindData();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_RequestApprovedList.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else

            utility.MessageBox(this, "record not found,can not export.");
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindData();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_RequestApprovedList.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else

            utility.MessageBox(this, "record not found,can not export.");
    }
    protected void imgbtnPdf_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindData();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_RequestApprovedList.pdf");
            Response.ContentType = "application/pdf";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            GridView1.RenderControl(hw);
            StringReader sr = new StringReader(Regex.Replace(sw.ToString(), "</?(a|A).*?>", ""));
            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();
            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }
        else
            utility.MessageBox(this, "record not found,can not export.");
    }

    /// <summary>
    /// This method is used for export the data
    /// </summary>
    /// <param name="control"></param>

    public override void VerifyRenderingInServerForm(Control control)
    {
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        BindData();
    }


}
