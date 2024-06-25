using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.IO;
using System.Data;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
public partial class d2000admin_AddEditPackSize : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
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
            txtPackSize.Text = string.Empty;
            BindGrid();

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtPackSize.Text.Trim()))
        {
            if (txtPackSize.Text.Trim().Length > 0 && txtPackSize.Text.Trim().Length < 51)
            {
                addPackSize();
            }
            else
            {
                utility.MessageBox(this, "Only 50 Characters In Pack Size Are Allowed!");
            }
        }
        else
        {
            utility.MessageBox(this, "Please Enter 50 Character Pack Size!");
        }

        BindGrid();

    }
    private void addPackSize()
    {
        try
        {
            com = new SqlCommand("AddPackSize", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@PackSize", txtPackSize.Text.Trim().ToString());
            com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            com.CommandTimeout = 999999;
            com.ExecuteNonQuery();
            int result = Convert.ToInt32(com.Parameters["@flag"].Value);
            if (result == 11)
            {
                utility.MessageBox(this,"PackSize Added Successfully !");
                txtPackSize.Text = string.Empty;

            }
            else if (result == 1)
            {
                utility.MessageBox(this, "This PackSize Already Exists In-Acitve List,Please Activate From There !");
            }
            else if (result == 0)
            {
                utility.MessageBox(this, "This PackSize Already Exists In Acitve List !");
            }
            else
            {
                utility.MessageBox(this, "Operation Unsuccessful!Please Try Later...");
            }
        }
        catch
        {

        }
        finally
        {
            con.Close();

        }
    }

    private void BindGrid()
    {

        SqlConnection con = new SqlConnection(method.str);
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            da = new SqlDataAdapter("getPackSizeList", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            da.SelectCommand.Parameters.AddWithValue("@isDeleted", ddlStatus.SelectedValue.ToString());
            da.SelectCommand.Parameters.AddWithValue("@type", "cl");
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView1.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            dt.Dispose();
            da.Dispose();
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            System.Web.UI.WebControls.Image img = (System.Web.UI.WebControls.Image)e.Row.FindControl("imgStatus");
            //Image img = (Image)e.Row.FindControl("imgStatus");
            LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkbtnStatus");
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "sts")) == "Activated")
            {
                img.ImageUrl = "images/yes.jpeg";
                lnkbtn.Text = "De Activate";
                lnkbtn.CommandName = "DeActivate";
            }
            else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "sts")) == "De-Activated")
            {
                img.ImageUrl = "images/no.jpeg";
                lnkbtn.Text = "Activate";
                lnkbtn.CommandName = "Activate";
            }
        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        txtPackSize.Text = lblMsg.Text = string.Empty;
        if (e.CommandName != "Page")
        {
            int rowindex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GridView1.Rows[rowindex];
            Label lbl = (Label)row.FindControl("lblId");
            if (e.CommandName == "DeActivate")
            {
                updateStatus(Convert.ToInt32(lbl.Text), 1);
                utility.MessageBox(this, "Pack Size De Activated Successfully !");
            }
            else if (e.CommandName == "Activate")
            {
                updateStatus(Convert.ToInt32(lbl.Text), 0);
                utility.MessageBox(this, "Pack Size Activated Successfully !");
            }
        }
    }
    public void updateStatus(int id, int st)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable dt = new DataTable();
        try
        {
            da = new SqlDataAdapter("editPackSizeStatus", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.CommandTimeout = 99999;
            da.SelectCommand.Parameters.AddWithValue("@PackSizeId", id);
            da.SelectCommand.Parameters.AddWithValue("@isDeleted", st);
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            BindGrid();
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            da.Dispose();
            dt.Dispose();
        }
    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        if (!string.IsNullOrEmpty(txtPackSize.Text.Trim()))
            searchbyname();
        else
            BindGrid();
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        lblMsg.Text = string.Empty;
        GridView1.EditIndex = -1;
        if (!string.IsNullOrEmpty(txtPackSize.Text.Trim()))
            searchbyname();
        else
            BindGrid();
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView1.EditIndex = e.RowIndex;
        string pid = ((Label)GridView1.Rows[e.RowIndex].Cells[1].FindControl("lblId")).Text;
        string ps = ((TextBox)(GridView1.Rows[e.RowIndex].Cells[2].Controls[0])).Text;
        if (!string.IsNullOrEmpty(ps.Trim()))
        {
            if (ps.Trim().Length > 0 && ps.Trim().Length < 51)
            {
                editPackSize(pid, ps);
                GridView1.EditIndex = -1;
                if (!string.IsNullOrEmpty(txtPackSize.Text.Trim()))
                    searchbyname();
                else
                    BindGrid();
            }
            else
            {
                utility.MessageBox(this, "Only 50 Characters In Pack Size Are Allowed!");
            }
        }
        else
        {
            utility.MessageBox(this, "Please 50 Character Enter Pack Size!");
        }
    }
    public void editPackSize(string PackSizeId, string PackSize)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand();
        try
        {

            cmd = new SqlCommand("editPackSize", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@PackSizeId", PackSizeId);
            cmd.Parameters.AddWithValue("@PackSize", PackSize);
            cmd.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            int result = Convert.ToInt32(cmd.Parameters["@flag"].Value);
            if (result == 11)
            {
                utility.MessageBox(this, "PackSize Edited Successfully !");
                txtPackSize.Text = string.Empty;

            }
            else if (result == 1)
            {
                utility.MessageBox(this, "This PackSize Already Exists In-Acitve List,Please Activate From There !");
            }
            else if (result == 0)
            {
                utility.MessageBox(this, "This PackSize Already Exists !");
            }
            else
            {
                utility.MessageBox(this, "Operation Unsuccessful!Please Try Later...");
            }
            con.Close();

        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            cmd.Dispose();
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        if (!string.IsNullOrEmpty(txtPackSize.Text.Trim()))
            searchbyname();
        else
            BindGrid();
    }
    public void searchbyname()
    {

        SqlConnection con = new SqlConnection(method.str);
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();


        try
        {
            da = new SqlDataAdapter("getPackSizeList", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@PackSize", txtPackSize.Text.Trim().ToString());
            da.SelectCommand.Parameters.AddWithValue("@isDeleted", ddlStatus.SelectedValue.ToString());
            da.SelectCommand.Parameters.AddWithValue("@type", "s");
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            dt.Dispose();
            da.Dispose();
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        txtPackSize.Text = lblMsg.Text = string.Empty;
        BindGrid();
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtPackSize.Text = lblMsg.Text = string.Empty;
        BindGrid();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;
        if (!string.IsNullOrEmpty(txtPackSize.Text.Trim()))
            searchbyname();
        else
            utility.MessageBox(this, "Please Enter Pack Size ID !");

    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlStatus.SelectedItem.Text == "Active" || ddlStatus.SelectedItem.Text == "In Active")
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                if (!string.IsNullOrEmpty(txtPackSize.Text.Trim()))
                    searchbyname();
                else
                    BindGrid();
                //GridView1.Columns[0].Visible = false;
                //GridView1.Columns[1].Visible = false;
                GridView1.Columns[4].Visible = false;
                GridView1.Columns[5].Visible = false;
                GridView1.Columns[6].Visible = false;
                Response.Clear();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + " PackSizeList.xls");
                Response.Charset = "";
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter stringWrite = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
                this.GridView1.RenderControl(htmlWrite);
                Response.Write(stringWrite.ToString());
                Response.End();
            }
            else
                utility.MessageBox(this, "can not export as no data found !");

        }
    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlStatus.SelectedItem.Text == "Active" || ddlStatus.SelectedItem.Text == "In Active")
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                if (!string.IsNullOrEmpty(txtPackSize.Text.Trim()))
                    searchbyname();
                else
                    BindGrid();

                //GridView1.Columns[0].Visible = false;
                //GridView1.Columns[1].Visible = false;
                GridView1.Columns[4].Visible = false;
                GridView1.Columns[5].Visible = false;
                GridView1.Columns[6].Visible = false;

                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + " PackSizeList.doc");
                Response.ContentType = "application/vnd.ms-word";
                StringWriter stw = new StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                this.GridView1.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();
            }
            else
                utility.MessageBox(this, "can not export as no data found !");
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btnShowAll_Click(object sender, EventArgs e)
    {
        txtPackSize.Text = lblMsg.Text = string.Empty;
        BindGrid();
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtPackSize.Text = lblMsg.Text = string.Empty;
        BindGrid();

    }
    //protected void imgbtnpdf_Click(object sender, ImageClickEventArgs e)
    //{

    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        if (!string.IsNullOrEmpty(txtPackSize.Text.Trim()))
    //            searchbyname();
    //        else
    //            BindGrid();

    //        GridView1.Columns[0].Visible = false;
    //        GridView1.Columns[1].Visible = false;
    //        GridView1.Columns[4].Visible = false;
    //        GridView1.Columns[5].Visible = false;
    //        GridView1.Columns[6].Visible = false;
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + " PackSizeList.pdf");
    //        Response.ContentType = "application/pdf";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        StringWriter sw = new StringWriter();
    //        HtmlTextWriter hw = new HtmlTextWriter(sw);
    //        GridView1.RenderControl(hw);
    //        StringReader sr = new StringReader(Regex.Replace(sw.ToString(), "</?(a|A).*?>", ""));
    //        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
    //        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
    //        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
    //        pdfDoc.Open();
    //        htmlparser.Parse(sr);
    //        pdfDoc.Close();
    //        Response.Write(pdfDoc);
    //        Response.End();
    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
        
    //}
}