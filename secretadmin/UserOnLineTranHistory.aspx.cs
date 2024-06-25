using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Xml.Linq;

public partial class secretadmin_UserOnLineTranHistory : System.Web.UI.Page
{
    DataUtility dutil = new DataUtility();
    utility objutil = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("~/secretadmin/adminLog.aspx", false);
            }
            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.Date.AddDays(-7).ToString("dd/MM/yyyy");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                OnlineTranHistory();
            }
        }
        catch
        {

        }
    }

    private void OnlineTranHistory()
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
                utility.MessageBox(this, "Invalid Date !!!");
                return;

            }
            if (fromDate > toDate)
            {
                string message = "alert('Invalid Date !!!')";
                ScriptManager.RegisterClientScriptBlock((this as Control), this.GetType(), "alert", message, true);
            }
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FromDate",fromDate),
                new SqlParameter("@ToDate",toDate),
                new SqlParameter("@Type",ddlTranType.SelectedValue.ToString()),
                new SqlParameter("@Regno",txtUserSearch.Text.Trim())
            };

            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {
                DataTable dt = dutil.GetDataTableSP(param, "GetALLTranHistory");
                DataColumn dcDtl = new DataColumn("tbl", typeof(string));
                dt.Columns.Add(dcDtl);
                foreach (DataRow row in dt.Rows)
                {
                    XElement objXml = XElement.Parse(row["detail"].ToString());
                    string strDtl = "<table class='table table-striped table-hover mygrd' rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
                    strDtl += "<tr><th>Name</th><th>QTY</th><th>MRP</th><th>BV</th><th>Total</th></tr>";
                    foreach (XElement p in objXml.Elements("P"))
                    {
                        strDtl += "<tr>";
                        strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
                        strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
                        strDtl += "<td>" + p.Elements("MRP").FirstOrDefault().Value + "</td>";
                        strDtl += "<td>" + p.Elements("BV").FirstOrDefault().Value + "</td>";
                        strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
                        strDtl += "</tr>";
                    }
                    strDtl += "</table>";
                    row["tbl"] = strDtl;
                }
                POTranHistoryOnline.DataSource = dt;
                POTranHistoryOnline.DataBind();
            }
            else
            {
                utility.MessageBox(this, "From Date is greater than To Date.");
                return;
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void POTranHistoryOnline_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        POTranHistoryOnline.PageIndex = e.NewPageIndex;
        OnlineTranHistory();
    }


    protected void POTranHistoryOnline_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton btnPrint = (LinkButton)e.Row.FindControl("lnkGetInvoice");

                LinkButton btndispatch = (LinkButton)e.Row.FindControl("lnkDispatchProduct");

                if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "paymentstatus")) == "Success")
                {
                    btnPrint.Visible = true;
                    btndispatch.Visible = true;
                    e.Row.BackColor = Color.FromName("#f4fef4");
                }
                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "paymentstatus")) == "Pending")
                {
                    btndispatch.Visible = false;
                    btnPrint.Visible = false;
                    e.Row.BackColor = Color.FromName("#FCFFF0");
                }
                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "paymentstatus")) == "Failed")
                {
                    btndispatch.Visible = false;
                    btnPrint.Visible = false;
                    e.Row.BackColor = Color.FromName("#FFCCCC");
                }

                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "receivedstatus")) == "1")
                {
                   
                    btnPrint.Visible = true;
                    btndispatch.Visible = false;
                    e.Row.BackColor = Color.FromName("#f4fef4");
                }


            }
        }
        catch
        {

        }
    }

    protected void lnkGetInvoice_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;
            Label lblsrno = (Label)gvrow.FindControl("lblId");
            int srno = Convert.ToInt32(lblsrno.Text.ToString());

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@MasterKey","GETINVOICEID"),
                new SqlParameter("@Id",srno)
            };

            DataTable dt = dutil.GetDataTableSP(param, "Usp_GetMaster");

            if (dt.Rows.Count > 0)
            {
                Server.Transfer("GSTBill.aspx?id="+ dt.Rows[0]["srno"].ToString() + "&st=1");
               // Response.Redirect("GSTBill.aspx?id="+dt.Rows[0]["srno"].ToString()+"&st=1");
                //ScriptManager.RegisterStartupScript(Page, typeof(Page), "NewTab", "window.open('GSTBill.aspx?id=" + dt.Rows[0]["srno"].ToString() + "&st=" + 1 + "');", true);
            }
        }
        catch
        {

        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            OnlineTranHistory();
        }

        catch
        {

        }
    }


    protected void lnkDispatchProduct_Click(object sender, EventArgs e)
    {

        try
        {
            txtCourierName.Text = txtDispatchDate.Text = txtDocketNumer.Text = string.Empty;
            GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;
            Label lblsrno = (Label)gvrow.FindControl("lblId");
            Label uid = (Label)gvrow.FindControl("lblUID");
            int srno = Convert.ToInt32(lblsrno.Text.ToString());

            lbsrno.Text = srno.ToString();

            lblUserID.Text = uid.Text;


            dialog.Visible = true;

            if (ddlOrderStatus.SelectedValue == "1")
            {
                txtCourierName.Enabled = false;
                txtDocketNumer.Enabled = false;
                txtDispatchDate.Enabled = false;
                txtDesc.Enabled = false;
            }
        }
        catch
        {

        }
    }


    protected void btnClose_Click(object sender, EventArgs e)
    {
        dialog.Visible = false;
        txtCourierName.Text = txtDocketNumer.Text = txtDispatchDate.Text = txtDesc.Text = string.Empty;

        ddlOrderStatus.SelectedIndex = 0;
        chkIsDispatch.Checked = false;

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (ddlOrderStatus.SelectedValue == "0")
        {
            utility.MessageBox(this, "Please Select Collect Type.");
            ddlOrderStatus.Focus();
        }

        if (ddlOrderStatus.SelectedValue == "1")
        {
            if (chkIsDispatch.Checked == false)
            {

                utility.MessageBox(this, "Please Check Dispatch.");
                chkIsDispatch.Focus();
            }
        }
        if (ddlOrderStatus.SelectedValue == "2")
        {

            if (string.IsNullOrEmpty(txtCourierName.Text.Trim()))
            {

                utility.MessageBox(this, "Please Enter Courier Company.");
                txtCourierName.Focus();
            }

            if (string.IsNullOrEmpty(txtDesc.Text.Trim()))
            {
                utility.MessageBox(this, "Please Enter Description.");
                txtDesc.Focus();
            }

            if (string.IsNullOrEmpty(txtDocketNumer.Text.Trim()))
            {
                utility.MessageBox(this, "Please Enter Docket Number.");
                txtDocketNumer.Focus();
            }

            if (string.IsNullOrEmpty(txtDispatchDate.Text.Trim()))
            {

                utility.MessageBox(this, "Please Enter Dispatch Date.");
                txtDispatchDate.Focus();
            }

            if (chkIsDispatch.Checked == false)
            {

                utility.MessageBox(this, "Please Check Dispatch.");
                chkIsDispatch.Focus();
            }

        }
        SaveDispatchDetails();
    }

    public void SaveDispatchDetails()
    {
        try
        {
           
           
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime dispatchDoe = new DateTime();

            try
            {
                if (ddlOrderStatus.SelectedValue == "2")
                    dispatchDoe = Convert.ToDateTime(txtDispatchDate.Text.Trim(), dateInfo);
                else if (ddlOrderStatus.SelectedValue == "1")
                    dispatchDoe = Convert.ToDateTime(DateTime.UtcNow.AddMinutes(330), dateInfo);
            }
            catch
            {
                utility.MessageBox(this, "Invalid Date!!!");
            }

            int status = 0;
            if (chkIsDispatch.Checked == true)
                status = 1;

            SqlParameter Outparam = new SqlParameter("@strResult", SqlDbType.VarChar, 220);
            Outparam.Direction = ParameterDirection.Output;


            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SessionUserid",Session["admin"].ToString()),
                new SqlParameter("@Srno",lbsrno.Text),
                new SqlParameter("@OrderStatus",ddlOrderStatus.SelectedItem.Value.ToString()),
                new SqlParameter("@docketid",txtDocketNumer.Text.Trim()),
                new SqlParameter("@couriercompany",txtCourierName.Text.Trim()),
                new SqlParameter("@Description ",txtDesc.Text.Trim()),
                new SqlParameter("@dispatcheddate",dispatchDoe),
                new SqlParameter("@receivedstatus",status),
                Outparam
            };
            string result = dutil.ExecuteSqlSPS(param, "Usp_UpdateDispatchOrder");
            if (result != "")
                dialog.Visible = false;
            utility.MessageBox(this, result);
            txtCourierName.Text = txtDocketNumer.Text = txtDispatchDate.Text = txtDesc.Text = string.Empty;

        }
        catch
        {

        }
    }

}