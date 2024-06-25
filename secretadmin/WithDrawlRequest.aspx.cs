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

public partial class admin_WithDrawlRequest : System.Web.UI.Page
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
                //txtFromdate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                txtFromdate.Text = DateTime.Now.Date.AddDays(-15).Date.ToString("dd/MM/yyyy").Replace("-", "/");
                txtTodate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
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
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        //DateTime validDate = Convert.ToDateTime(toDate, dateInfo); 
        DateTime from;
        DateTime to;
        if (!string.IsNullOrEmpty(txtFromdate.Text.Trim()) && !string.IsNullOrEmpty(txtTodate.Text.Trim()))
        {
            try
            {
                from = Convert.ToDateTime(txtFromdate.Text.Trim(), dateInfo);
                to = Convert.ToDateTime(txtTodate.Text.Trim(), dateInfo);
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }
        }
        else
        {
            from = DateTime.Now.Date;
            to = DateTime.Now.Date;
        }

       
        con = new SqlConnection(method.str);
        com = new SqlCommand("withdrawReportAdmin", con);
        com.CommandType = CommandType.StoredProcedure;
        com.CommandTimeout = 9999999;
        if (!string.IsNullOrEmpty(txtFromdate.Text.Trim()))
            com.Parameters.AddWithValue("@fromdate", from);
        if (!string.IsNullOrEmpty(txtTodate.Text.Trim()))
            com.Parameters.AddWithValue("@Todate", to);
        com.Parameters.AddWithValue("@reqtype",ddlReqType.SelectedValue);
        
        try
        {
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataTable dt = new DataTable();
            adapter.SelectCommand = com;
            adapter.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView1.Columns[3].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(wamount)", "true").ToString()) ? "0.00" : dt.Compute("sum(wamount)", "true").ToString());
                GridView1.Columns[4].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(handling)", "true").ToString()) ? "0.00" : dt.Compute("sum(handling)", "true").ToString());
                GridView1.Columns[5].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(dispatch)", "true").ToString()) ? "0.00" : dt.Compute("sum(dispatch)", "true").ToString());

                GridView1.DataSource = dt;
                GridView1.DataBind();
                //LblTotalRecord.Text = "Total Records:" + dt.Rows.Count.ToString();
                //object objSum;
                //objSum = dt.Compute("Sum(wamount)", "1 = 1");
                //LblAmount.Text = "Total Amount:" + (string.IsNullOrEmpty(objSum.ToString()) ? "0" : objSum.ToString());
            }
            else
            {

                //LblTotalRecord.Text = "Total Records:0";
                //LblAmount.Text = "";
                GridView1.DataSource = null;
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
    protected void Button1_Click(object sender, EventArgs e)
    {
        BindData();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            GridView1.Columns[9].Visible = GridView1.Columns[8].Visible=GridView1.Columns[7].Visible = GridView1.Columns[6].Visible = false;
            BindData();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_WithdrawRequestList.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "record not found,can not export.");
        }
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            GridView1.Columns[9].Visible = GridView1.Columns[8].Visible = GridView1.Columns[7].Visible = GridView1.Columns[6].Visible = false;
            BindData();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_WithdrawRequestList.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "record not found,can not export.");
        }
    }
    protected void imgbtnPdf_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindData();
            GridView1.Columns[9].Visible = GridView1.Columns[8].Visible = GridView1.Columns[7].Visible = GridView1.Columns[6].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_WithdrawRequestList.pdf");
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
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (string.Compare(e.CommandName, "Aprove", true) == 0 || string.Compare(e.CommandName, "Reject", true) == 0)
        {
            
            int index = Convert.ToInt32(e.CommandArgument);
            int srno = Convert.ToInt32(GridView1.DataKeys[index].Value);
            string regno = GridView1.Rows[index].Cells[2].Text.Trim();
            string wamnt = GridView1.Rows[index].Cells[8].Text.Trim();
            string cheque = ((TextBox)GridView1.Rows[index].FindControl("txtChq")).Text.Trim(); 
            int status = string.Compare(e.CommandName, "Aprove", true) == 0 ? 1 : 2;
            string remarks = "";
            remarks = ((TextBox)GridView1.Rows[index].FindControl("txtRem")).Text.Trim();
            ApproveRequest(srno, remarks, cheque, status, regno, wamnt);
        }
    }
    private void ApproveRequest(int srno1, string remark, string cheque, int status1, string regno1, string wamnt)
    {
        if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();
            try
            {
                utility objutil = new utility();              
                con = new SqlConnection(method.str);
                com = new SqlCommand("withdrawrequestapprove", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@reqtype", ddlReqType.SelectedValue);
                com.Parameters.AddWithValue("@action", "2");
                com.Parameters.AddWithValue("@fromdate", null);             
                com.Parameters.AddWithValue("@Todate",null);
                com.Parameters.AddWithValue("@admin", "12345");              
                com.Parameters.AddWithValue("@withdrawid",srno1);
                com.Parameters.AddWithValue("@status", status1);
                com.Parameters.AddWithValue("@cheque", cheque);
                com.Parameters.AddWithValue("@regno", regno1);
                com.Parameters.AddWithValue("@amount", wamnt);
                com.Parameters.AddWithValue("@remarks",remark==""?"No Remark":remark);
                com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string msg = com.Parameters["@flag"].Value.ToString();
                con.Close();
                con.Dispose();
                if (msg == "1")
                {
                    BindData();
                    utility.MessageBox(this, status1 == 1 ? "Amount wallet approved successfully." : "Amount wallet rejected.");
                 }
                else
                {
                    utility.MessageBox(this, msg);
                }
            }
            catch (Exception e)
            {
                utility.WriteErrorLog(e.Message + " ApproveRequest srno:" + srno1 + ",regno:" + regno1 + ",status:" + status1 + ",comment:" + remark);
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

    //protected void chckchanged(object sender, EventArgs e)
    //{

    //    CheckBox chckheader = (CheckBox)GridView1.HeaderRow.FindControl("CheckBox1");

    //    foreach (GridViewRow row in GridView1.Rows)
    //    {

    //        CheckBox chckrw = (CheckBox)row.FindControl("chkSelOne");
    //        TextBox txtcheq = (TextBox)row.FindControl("txtChq");
    //        TextBox txtremarks = (TextBox)row.FindControl("txtrem");

    //        if (chckheader.Checked == true)
    //        {
    //            chckrw.Checked = true;
    //            txtcheq.Text = txtChqNo.Text;
    //            txtremarks.Text = txtRmk.Text;
    //        }
    //        else
    //        {
    //            chckrw.Checked = false;
    //            txtcheq.Text = "";
    //            txtremarks.Text = "";
    //        }

    //    }

    //}  

    protected void chkSelAll_CheckedChanged(object sender, EventArgs e)
    {
        //if (chkSelAll.Checked == true)
        //{

        //}
        //else
        //{

        //}
    }
}