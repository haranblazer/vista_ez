using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Drawing;
using System.Xml;
using System.IO;

public partial class secretadmin_DeliveryReports : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlConnection conn = new SqlConnection(method.str);
    SqlCommand com = null;
    string regno = string.Empty;
    XmlDocument xmldoc = new XmlDocument();
    string invoiceno = "";
    string status = "";
    string monthname = "";
         utility obj = new utility();
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

        checkpage();
        if (!IsPostBack)
        {
            txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy").Replace("-", "/");
            txtFromDate.Text = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");
            BindFranchise();
            BindUserID();
            BindGrid();
        }
    }
    public void BindFranchise()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select FranchiseId='Admin' Union all Select FranchiseId from FranchiseMst ");
        ddl_RoleWise.DataSource = dt;
        ddl_RoleWise.DataTextField = "FranchiseId";
        ddl_RoleWise.DataValueField = "FranchiseId";
        ddl_RoleWise.DataBind();
        ddl_RoleWise.Items.Insert(0, new ListItem("All", ""));

    }
    private void BindGrid()
    {
        try
        {
            pnlSelect.Visible = false;
            this.lnkbtnpopex.Hide();
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            string strmin = "";
            string strmax = "";
            try
            {
                if (txtFromDate.Text.Trim().Length > 0)
                    strmin = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo).ToString();
                if (txtToDate.Text.Trim().Length > 0)
                    strmax = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo).ToString();
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }
            double datedays = (Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo) - Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo)).TotalDays;
            if (datedays > 31)
            {
                utility.MessageBox(this, "Maximum 31 days allowed");
                GridView1.DataSource = null;
                GridView1.DataBind();
                lblTotal.Text = "";
                return;
            }
            con = new SqlConnection(method.str);
            SqlDataAdapter ad = new SqlDataAdapter("PackageDelivery", con);
            ad.SelectCommand.CommandType = CommandType.StoredProcedure;
            ad.SelectCommand.Parameters.AddWithValue("@search", TxtSponsorId.Text == "" ? "" : TxtSponsorId.Text.Trim());
            ad.SelectCommand.Parameters.AddWithValue("@min", strmin);
            ad.SelectCommand.Parameters.AddWithValue("@max", strmax);
            ad.SelectCommand.Parameters.AddWithValue("@billtype", DropDownList2.SelectedValue.ToString());
            ad.SelectCommand.Parameters.AddWithValue("@status", ddl_Status.SelectedValue);
            ad.SelectCommand.Parameters.AddWithValue("@RoleWise", ddl_RoleWise.SelectedValue.ToString());
            ad.SelectCommand.Parameters.AddWithValue("@PaymentMode", ddl_paymode.SelectedValue.ToString());
            dt = new DataTable();
            ad.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
                lblTotal.Text += ", Gross: " + (string.IsNullOrEmpty(dt.Compute("sum(grossamt)", "true").ToString()) ? "0.00" : dt.Compute("sum(grossamt)", "true").ToString());
                lblTotal.Text += ", Amount: " + (string.IsNullOrEmpty(dt.Compute("sum(amt)", "true").ToString()) ? "0.00" : dt.Compute("sum(amt)", "true").ToString());
                lblTotal.Text += ", Tax: " + (string.IsNullOrEmpty(dt.Compute("sum(tax)", "true").ToString()) ? "0.00" : dt.Compute("sum(tax)", "true").ToString());
                lblTotal.Text += ", Net: " + (string.IsNullOrEmpty(dt.Compute("sum(netAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(netAmt)", "true").ToString());
            }
            else
            {
                lblTotal.Text = "";
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        pnlSelect.Visible = false;
        this.lnkbtnpopex.Hide();
        BindGrid();
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        pnlSelect.Visible = false;
        this.lnkbtnpopex.Hide();
        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
        if (e.CommandName.Equals("Submit"))
        {
            try
            {
                invoiceno = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
                DropDownList ddldelivery = ((DropDownList)row.FindControl("ddldelivery"));
                TextBox txtremark = ((TextBox)row.FindControl("txtremark"));
                con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("DeliveryReport", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@invoiceno", invoiceno);
                cmd.Parameters.AddWithValue("@DeliveryType", ddldelivery.SelectedValue);
                cmd.Parameters.AddWithValue("@Remark", txtremark.Text.Trim());
                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 200).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                status = cmd.Parameters["@flag"].Value.ToString();
                if (status == "1")
                {

                    utility.MessageBox(this, " Delivery Report Submitted Successfully");
                }
                else
                {
                    utility.MessageBox(this, status);
                }
            }

            catch (Exception ex)
            {
                utility.MessageBox(this, ex.ToString());
            }
            finally
            {
                con.Close();
                BindGrid();
            }
        }
    }
    private void BindUserID()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        try
        {
            DataTable dtt = new DataTable();
            da = new SqlDataAdapter("select   franchiseid from franchisemst", con);
            da.Fill(dtt);

            List<string> objProductList = new List<string>(); ;
            String strPrdPrice = string.Empty;
            divUserID.InnerText = string.Empty;
            foreach (DataRow drw in dtt.Rows)
            {
                divUserID.InnerText += drw["franchiseid"].ToString() + ",";
            }
        }
        catch
        {
        }
        finally
        {
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {


        try
        {
            if (GridView1.Rows.Count > 0)
            {
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_DeliveryReports.xls");
                Response.Charset = "";
                Response.ContentType = "application/vnd.ms-excel";
                using (StringWriter sw = new StringWriter())
                {
                    HtmlTextWriter hw = new HtmlTextWriter(sw);
                    //To Export all pages
                    GridView1.AllowPaging = false;
                    GridView1.Columns[0].Visible = false;
                    GridView1.Columns[20].Visible = false;
                    this.BindGrid();

                    GridView1.HeaderRow.BackColor = Color.White;
                    foreach (TableCell cell in GridView1.HeaderRow.Cells)
                    {
                        cell.BackColor = GridView1.HeaderStyle.BackColor;
                    }
                    foreach (GridViewRow row in GridView1.Rows)
                    {
                        row.BackColor = Color.White;
                        foreach (TableCell cell in row.Cells)
                        {
                            //if (row.RowIndex % 2 == 0)
                            //{
                            //    cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                            //}
                            //else
                            //{
                            //    cell.BackColor = GridView1.RowStyle.BackColor;
                            //}
                            cell.CssClass = "textmode";
                            List<Control> controls = new List<Control>();
                            //Add controls to be removed to Generic List
                            foreach (Control control in cell.Controls)
                            {
                                controls.Add(control);
                            }

                            //Loop through the controls to be removed and replace with Literal
                            foreach (Control control in controls)
                            {
                                switch (control.GetType().Name)
                                {
                                    case "HyperLink":
                                        cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
                                        break;
                                    case "TextBox":
                                        cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
                                        break;
                                    case "DropDownList":
                                        cell.Controls.Add(new Literal { Text = (control as DropDownList).SelectedItem.Text });
                                        break;

                                }
                                cell.Controls.Remove(control);
                            }
                        }
                    }

                    GridView1.RenderControl(hw);
                    //style to format numbers to string
                    string style = @"<style> .textmode { } </style>";
                    Response.Write(style);
                    Response.Output.Write(sw.ToString());
                    Response.Flush();
                    Response.End();
                }

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
            if (GridView1.Rows.Count > 0)
            {
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "__DeliveryReports.doc");
                Response.Charset = "";
                Response.ContentType = "application/vnd.ms-word";
                using (StringWriter sw = new StringWriter())
                {
                    HtmlTextWriter hw = new HtmlTextWriter(sw);
                    GridView1.AllowPaging = false;
                    GridView1.Columns[1].Visible = false;
                    GridView1.Columns[20].Visible = false;
                    this.BindGrid();
                    GridView1.HeaderRow.BackColor = Color.White;
                    foreach (TableCell cell in GridView1.HeaderRow.Cells)
                    {
                        cell.BackColor = GridView1.HeaderStyle.BackColor;
                    }
                    foreach (GridViewRow row in GridView1.Rows)
                    {
                        row.BackColor = Color.White;
                        foreach (TableCell cell in row.Cells)
                        {
                            cell.CssClass = "textmode";
                            List<Control> controls = new List<Control>();
                            foreach (Control control in cell.Controls)
                            {
                                controls.Add(control);
                            }
                            foreach (Control control in controls)
                            {
                                switch (control.GetType().Name)
                                {
                                    case "HyperLink":
                                        cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
                                        break;
                                    case "TextBox":
                                        cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
                                        break;
                                    case "DropDownList":
                                        cell.Controls.Add(new Literal { Text = (control as DropDownList).SelectedItem.Text });
                                        break;

                                }
                                cell.Controls.Remove(control);
                            }
                        }
                    }
                    GridView1.RenderControl(hw);
                    string style = @"<style> .textmode { } </style>";
                    Response.Write(style);
                    Response.Output.Write(sw.ToString());
                    Response.Flush();
                    Response.End();
                }

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
    public void checkpage()
    {
        SqlDataReader dr;
        con = new SqlConnection(method.str);
        com = new SqlCommand("pageprocess", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@action", "1");
        con.Open();
        dr = com.ExecuteReader();
       // con.Close();
        while (dr.Read())
        {
            if (dr["billing"].ToString() == "OFF")
            {

                Response.Redirect("~/error.aspx");
            }
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbldilsts = (Label)e.Row.FindControl("lbldilsts");
            Label lbldiltype = (Label)e.Row.FindControl("lbldiltype");
            DropDownList ddldelivery = ((DropDownList)e.Row.FindControl("ddldelivery"));
            TextBox txtremark = (TextBox)e.Row.FindControl("txtremark");
            LinkButton lnkbtnsubmit = (LinkButton)e.Row.FindControl("lnkbtnsubmit");
            string lblbillby = ((Label)e.Row.FindControl("lblbillby")).Text;
            if (lbldiltype.Text == "1")
            {
                e.Row.BackColor = Color.FromName("#ffffff");
            }
            else if (lbldiltype.Text == "2")
            {
                e.Row.BackColor = Color.FromName("#d5fbff");
            }
            if (lbldilsts.Text == "1")
            {
                ddldelivery.SelectedValue = lbldiltype.Text;
                ddldelivery.Enabled = false;
                txtremark.Enabled = false;
                lnkbtnsubmit.Visible = false;
            }
            else
            {                
                ddldelivery.Enabled = true;
                txtremark.Enabled = true;
                lnkbtnsubmit.Visible = true;
            }
        }
    }
    protected void ddldelivery_SelectedIndexChanged(object sender, EventArgs e)
    {
        int rowIndex = Convert.ToInt32(((sender as DropDownList).NamingContainer as GridViewRow).RowIndex);
        GridViewRow row = GridView1.Rows[rowIndex];
        string ddl = (row.FindControl("ddldelivery") as DropDownList).SelectedValue;
        ViewState["Invoiceno"] = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
        ViewState["Deliverytype"]=ddl;
        if (ddl == "2")
        {
            pnlSelect.Visible = true;
            this.lnkbtnpopex.Show();
             // ClientScript.RegisterStartupScript(this.GetType(), "Pop", "openModal();", true);
        }
        else if (ddl == "1")
        {
            pnlSelect.Visible = false;
            this.lnkbtnpopex.Hide();
        }
    }   
    protected void btndispatch_Click(object sender, EventArgs e)
    {
        try
        {
            if (ViewState["Invoiceno"] != null && ViewState["Deliverytype"] != null)
            {
                System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
                dateInfo.ShortDatePattern = "dd/MM/yyyy";
                DateTime dispatchDate = new DateTime();
                SqlCommand cmd =new SqlCommand();
                dispatchDate = Convert.ToDateTime(txtDate.Text.Trim(), dateInfo);
                cmd = new SqlCommand("DeliveryReport", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", txtIdNo.Text.Trim());
                cmd.Parameters.AddWithValue("@Remark", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@company", txtCompany.Text.Trim());
                cmd.Parameters.AddWithValue("@DocketNo", txtDocketNumber.Text.Trim());
                cmd.Parameters.AddWithValue("@ddate", dispatchDate);
                cmd.Parameters.AddWithValue("@invoiceno", ViewState["Invoiceno"].ToString());
                cmd.Parameters.AddWithValue("@DeliveryType", ViewState["Deliverytype"].ToString());
                cmd.Parameters.AddWithValue("@from", Session["admin"].ToString());
                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                conn.Open();
                cmd.ExecuteNonQuery();
                string value = cmd.Parameters["@flag"].Value.ToString();
               // conn.Close();
                if (value == "1")
                {
                    utility.MessageBox(this, "Dispatched Successfully !");
                    conn = new SqlConnection(method.str);
                    com = new SqlCommand("getUserMobile", conn);
                    com.CommandType = CommandType.StoredProcedure;
                    DataTable dt = new DataTable();
                    SqlDataAdapter adp = new SqlDataAdapter(com);
                    com.Parameters.AddWithValue("@userid", txtIdNo.Text);
                    adp.Fill(dt);
                    string Text = "Dear " + dt.Rows[0]["name"].ToString() + " " + dt.Rows[0]["AppMstRegNo"].ToString() + "your courier dispatched from  " + txtCompany.Text + "POD No." + txtDocketNumber.Text + ".Thanks.";
                    obj.sendSMSCjstore(dt.Rows[0]["AppMstMobile"].ToString(), Text);
                    txtIdNo.Text = String.Empty;
                    txtDescription.Text = String.Empty;
                    txtCompany.Text = String.Empty;
                    txtDocketNumber.Text = String.Empty;
                    txtDate.Text = String.Empty;
                    pnlSelect.Visible = false;
                    this.lnkbtnpopex.Hide();
                }
                else
                {
                    utility.MessageBox(this, value.ToString());
                }
            }
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }

        finally
        {
           conn.Close();
           BindGrid();

        }

    }
}