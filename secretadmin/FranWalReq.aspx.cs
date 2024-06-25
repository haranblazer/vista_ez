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

public partial class secretadmin_FranWalReq : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand com = null;

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
                    if (Request.QueryString["Key"] == "TOTALFWALLET")
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
                Session["CheckRefresh"] = System.DateTime.Now.ToString();

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
             new SqlParameter("@Status", ddl_Status.SelectedValue),
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "FranWalletRequest");


        try
        {
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
        catch
        {
        }

    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindData();
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



    /// <summary>
    /// 
    /// </summary>

    private void ApproveRequest(int srno, string regno, int status, string coment, string epassword)
    {
        if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();
            try
            {
                utility objutil = new utility();
                //ApproveLoad(@Srno int,@regno varchar(50),@status int,@coment varchar(200),@Epwd varchar(50),@flag varchar(100) output)
                con = new SqlConnection(method.str);
                com = new SqlCommand("ApproveFranWallet", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@admin", Session["admin"].ToString());
                com.Parameters.AddWithValue("@Srno", srno);
                com.Parameters.AddWithValue("@regno", regno);
                com.Parameters.AddWithValue("@status", status);
                com.Parameters.AddWithValue("@coment", coment);
                com.Parameters.AddWithValue("@Epwd", epassword);
                com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string msg = com.Parameters["@flag"].Value.ToString();
                con.Close();
                con.Dispose();
                if (msg == "1")
                {

                    BindData();
                    utility.MessageBox(this, status == 1 ? "Amount wallet approved successfully." : "Amount wallet rejected.");

                }
                else
                {
                    utility.MessageBox(this, msg);
                }
            }
            catch (Exception e)
            {
                utility.WriteErrorLog(e.Message + " ApproveRequest srno:" + srno + ",regno:" + regno + ",status:" + status + ",comment:" + coment);
                utility.MessageBox(this, "TRY LATER!");
            }
        }
        else
        {

        }
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                GridView1.Columns[5].Visible = GridView1.Columns[8].Visible = GridView1.Columns[9].Visible = false;
                BindData();
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.xls");
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
        catch
        {

        }
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                GridView1.Columns[5].Visible = GridView1.Columns[8].Visible = GridView1.Columns[9].Visible = false;
                BindData();
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.doc");
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
        catch
        {

        }
    }
    protected void imgbtnPdf_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                BindData();
                GridView1.Columns[5].Visible = GridView1.Columns[8].Visible = GridView1.Columns[9].Visible = false;
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.pdf");
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
        catch
        {

        }
    }


    protected void dglst_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdf_Status = (HiddenField)e.Row.FindControl("hdf_Status");
            LinkButton LinkButton1 = (LinkButton)e.Row.FindControl("LinkButton1");
            LinkButton LinkButton2 = (LinkButton)e.Row.FindControl("LinkButton2");
            Label lbl_StatusText = (Label)e.Row.FindControl("lbl_StatusText");
            Label lbl_App_Rej = (Label)e.Row.FindControl("lbl_App_Rej");
            TextBox txtPwd = (TextBox)e.Row.FindControl("txtPwd");

            if (hdf_Status.Value == "1")
            {
                lbl_App_Rej.Text = "No Action";
                txtPwd.Enabled = false;
                LinkButton1.Visible = false;
                LinkButton2.Visible = false;
                lbl_StatusText.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                LinkButton1.Visible = true;
                LinkButton2.Visible = true;
                lbl_StatusText.ForeColor = System.Drawing.Color.Red;
            }

        }
    }


    protected void btnShowall_Click(object sender, EventArgs e)
    {
        txtFromdate.Text = txtTodate.Text = string.Empty;
        BindData();
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (string.Compare(e.CommandName, "Aprove", true) == 0 || string.Compare(e.CommandName, "Reject", true) == 0)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int srno = Convert.ToInt32(GridView1.DataKeys[index].Value);
            string regno = GridView1.Rows[index].Cells[1].Text.Trim();


            int status = string.Compare(e.CommandName, "Aprove", true) == 0 ? 1 : 2;
            string coment = "";
            string epassword = ((TextBox)GridView1.Rows[index].FindControl("txtPwd")).Text.Trim();

            if (epassword.Length < 2)
                utility.MessageBox(this, "Invalid transaction password.");
            else
                ApproveRequest(srno, regno, status, coment, epassword);
        }


    }
}