using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;
using System.Drawing;

public partial class secretadmin_AddCoupon : System.Web.UI.Page
{
    SqlConnection con;// = null;
    SqlCommand com;
    SqlDataAdapter da;
    Validation val = new Validation();
    protected void Page_Load(object sender, EventArgs e)
    {
         if (Session["admin"] != null)
        {
            if (!IsPostBack)
            {
               
                txtfromdate.Text = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy").Replace("-","/");
                txttodate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");
                BINDGRD();
            }
        }
        else
        {
         Response.Redirect("adminLog.aspx", false);
        }
    }   

    protected void txtUserId_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (txtUserId.Text != "")
            {
                con = new SqlConnection(method.str);
                com = new SqlCommand("select appmstfname from AppMst where AppMstRegNo=@regno and AppMstActivate='1'", con);
                com.CommandType = CommandType.Text;
                com.Parameters.AddWithValue("@regno", txtUserId.Text.Trim());
                da = new SqlDataAdapter(com);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count >0)
                {
                    lblUser.Text = dt.Rows[0]["appmstfname"].ToString();

                }
                else
                {
                    utility.MessageBox(this, "Please Enter Valid User Id !!!");
                }
            }
            else
            {
                utility.MessageBox(this, "Please Enter User Id !!!");
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        {
            if (btnsave.Text == "Save")
            {
                con = new SqlConnection(method.str);
                com = new SqlCommand("AddUpdateVoucher", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@Mode", "ADD");
                com.Parameters.AddWithValue("@Userid", txtUserId.Text.Trim());
                com.Parameters.AddWithValue("@CouponAmount", txtcouponamt.Text.Trim());
                com.Parameters.AddWithValue("@MinAmt", txtminamt.Text.Trim());
                com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string msg = com.Parameters["@flag"].Value.ToString();
                con.Close();
                if (msg == "1")
                {
                    utility.MessageBox(this, "Voucher generate successfully");
                    BINDGRD();
                    clear();
                }
                else
                {
                    utility.MessageBox(this, msg);
                }
            }
            else
            {
                con = new SqlConnection(method.str);
                com = new SqlCommand("AddUpdateVoucher", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@Mode", "Update");
                com.Parameters.AddWithValue("@Userid", txtUserId.Text.Trim());
                com.Parameters.AddWithValue("@CouponId",Convert.ToInt32( ViewState["COUPONID"].ToString()));
                com.Parameters.AddWithValue("@CouponAmount", txtcouponamt.Text.Trim());
                com.Parameters.AddWithValue("@MinAmt", txtminamt.Text.Trim());
                com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string msg = com.Parameters["@flag"].Value.ToString();
                con.Close();
                if (msg == "1")
                {
                    utility.MessageBox(this, "Voucher Amount Updated Successfully");
                    BINDGRD();
                    clear();
                }
                else
                {
                    utility.MessageBox(this,msg);
                }
            
            }
        }
        catch (Exception EX)
        {
        }
    }
    public void BINDGRD()
    {
        try
        {

            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            string strmin = "";
            string strmax = "";
            try
            {
                if (txtfromdate.Text.Trim().Length > 0)
                    strmin = Convert.ToDateTime(txtfromdate.Text.Trim(), dateInfo).ToString();
                if (txttodate.Text.Trim().Length > 0)
                    strmax = Convert.ToDateTime(txttodate.Text.Trim(), dateInfo).ToString();
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }
            double datedays = (Convert.ToDateTime(txttodate.Text.Trim(), dateInfo) - Convert.ToDateTime(txtfromdate.Text.Trim(), dateInfo)).TotalDays;
            if (datedays > 31)
            {
                utility.MessageBox(this, "Maximum 31 days allowed");
                lblTotal.Text = "";
                GRDCOUPAN.DataSource = null;
                GRDCOUPAN.DataBind();
                return;
            }
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetVoucher", con);
            com.Parameters.AddWithValue("@search", txtviewuserid.Text == "" ? "" : txtviewuserid.Text.Trim());
            com.Parameters.AddWithValue("@min", strmin);
            com.Parameters.AddWithValue("@max", strmax);
            com.Parameters.AddWithValue("@status", ddlsts.SelectedValue);
            com.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count >0)
            {
                GRDCOUPAN.DataSource = dt;
                GRDCOUPAN.DataBind();
                lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
                lblTotal.Text += ", Voucher Amt.: " + (string.IsNullOrEmpty(dt.Compute("sum(CouponAmount)", "true").ToString()) ? "0.00" : dt.Compute("sum(CouponAmount)", "true").ToString());
                lblTotal.Text += ", Minimum Voucher Amt.: " + (string.IsNullOrEmpty(dt.Compute("sum(ConditionAmount)", "true").ToString()) ? "0.00" : dt.Compute("sum(ConditionAmount)", "true").ToString());
                 }
            else
            {
                lblTotal.Text = "";
                GRDCOUPAN.DataSource = null;
                GRDCOUPAN.DataBind();
            }
        }
        catch(Exception ex)
        {

        }
    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;
        ViewState["COUPONID"] = GRDCOUPAN.DataKeys[gvrow.RowIndex].Value.ToString();
        txtUserId.Text = ((Label)gvrow.FindControl("lbluserid")).Text;
        lblUser.Text = ((Label)gvrow.FindControl("lblapname")).Text;
        txtcouponamt.Text = ((Label)gvrow.FindControl("lblcopamt")).Text;
        txtminamt.Text = ((Label)gvrow.FindControl("lblcondamt")).Text;
        btnsave.Text = "Update";
        txtUserId.Enabled = false;
        
    }
    private void clear()
    {
        txtUserId.Text = "";
        txtcouponamt.Text = "";
        txtminamt.Text = "";
        lblUser.Text = "";
        btnsave.Text = "Save";
        txtUserId.Enabled = true;
    
    }
    protected void GRDCOUPAN_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GRDCOUPAN.PageIndex = e.NewPageIndex;
        BINDGRD();

    }
    protected void GRDCOUPAN_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {


            Label lblsts = (Label)e.Row.FindControl("lblsts");
            LinkButton lnkEdit = (LinkButton)e.Row.FindControl("lnkEdit");
            LinkButton lnkdelete = (LinkButton)e.Row.FindControl("lnkdelete");

            if (lblsts.Text == "1")
            {
                e.Row.BackColor = Color.FromName("#d5fbff");
                lnkdelete.Enabled = false;
                lnkEdit.Enabled = false;
                lnkdelete.Visible = false;
                lnkEdit.Visible = false;
            }
            else if (lblsts.Text == "2")
            {
                e.Row.BackColor = Color.FromName("#ffffff");
                lnkdelete.Visible = true;
                lnkEdit.Visible = true;

            }
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {


        try
        {
            if (GRDCOUPAN.Rows.Count > 0)
            {
                GRDCOUPAN.AllowPaging = false;
                BINDGRD();              
               GRDCOUPAN.Columns[9].Visible = false;
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Voucher.xls");
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter stw = new System.IO.StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                this.GRDCOUPAN.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();
            }
            else
            {
                utility.MessageBox(this, "can not export as no data found !");
            }
        }
        catch
        {

        }
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (GRDCOUPAN.Rows.Count > 0)
            {
                GRDCOUPAN.AllowPaging = false;
                BINDGRD();                    
              GRDCOUPAN.Columns[9].Visible = false;
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Voucher.doc");
                Response.ContentType = "application/vnd.ms-word";
                System.IO.StringWriter stw = new System.IO.StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                this.GRDCOUPAN.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();
            }
            else
            {
                utility.MessageBox(this, "can not export as no data found !");
            }
        }
        catch
        {

        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BINDGRD();
    }
    protected void lnkdelete_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;
            string id = GRDCOUPAN.DataKeys[gvrow.RowIndex].Value.ToString();
            con = new SqlConnection(method.str);
            com = new SqlCommand("AddUpdateVoucher", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@Mode", "Delete");
            com.Parameters.AddWithValue("@Userid", "");
            com.Parameters.AddWithValue("@CouponId", Convert.ToInt32(id));  
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            string msg = com.Parameters["@flag"].Value.ToString();
            con.Close();
            if (msg == "1")
            {
                utility.MessageBox(this, "Voucher Deleted Successfully");
                BINDGRD();

            }
            else
            {
                utility.MessageBox(this, msg);
            }
        }
        catch (Exception ex)
        { 
        }
    }
}
        