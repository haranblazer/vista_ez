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

public partial class User_TransactionHistory : System.Web.UI.Page
{
    string regno = string.Empty;
    DataUtility dutil = new DataUtility();
    utility objutil = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["userId"] != null)
            {
                regno = Session["userId"].ToString();
            }
            else
            {
                Response.Redirect("~/Login.aspx", false);
            }
            if (!IsPostBack)
            {
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
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("regno",regno),
                new SqlParameter("@type",ddlTranType.SelectedValue.ToString()),

            };
            DataTable dt = dutil.GetDataTableSP(param, "GetUserTran");
            DataColumn dcDtl = new DataColumn("tbl", typeof(string));
            dt.Columns.Add(dcDtl);
            foreach (DataRow row in dt.Rows)
            {
                XElement objXml = XElement.Parse(row["detail"].ToString());
                string strDtl = "<table class='table table-striped table-hover mygrd' rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
                strDtl += "<tr><th>Name</th><th>QTY</th><th>MRP</th><th>CV</th><th>Total</th></tr>";
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
        catch (Exception ex)
        {

        }
    }
    protected void POTranHistoryOnline_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        POTranHistoryOnline.PageIndex = e.NewPageIndex;
        OnlineTranHistory();
    }
    protected void ddlTranType_SelectedIndexChanged(object sender, EventArgs e)
    {
        OnlineTranHistory();
    }


    protected void POTranHistoryOnline_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton btn = (LinkButton)e.Row.FindControl("lnkSubmit");
                LinkButton btnPrint = (LinkButton)e.Row.FindControl("lnlGetInvoice");
                if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "paymentstatus")) == "Success")
                {
                    btn.Visible = false;
                    btnPrint.Visible = true;
                    e.Row.BackColor = Color.FromName("#f4fef4");
                }
                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "paymentstatus")) == "Pending")
                {
                    btn.Visible = true;
                    e.Row.BackColor = Color.FromName("#FCFFF0");
                }
                else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "paymentstatus")) == "Failed")
                {
                    btn.Visible = true;
                    e.Row.BackColor = Color.FromName("#FFCCCC");
                }
            }
        }
        catch
        {

        }
    }
    protected void lnkSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;

            Label lblsrno = (Label)gvrow.FindControl("lblId");

            int srno = Convert.ToInt32(lblsrno.Text.ToString());

            SqlParameter[] sqlparam = new SqlParameter[]
            {
                new SqlParameter("@MasterKey","REPAYMENT_DETAIL"),
                new SqlParameter("@Id",srno)
            };
            DataTable dt = dutil.GetDataTableSP(sqlparam, "Usp_GetMaster");

            if (dt.Rows.Count > 0)
            {
                Response.Redirect("paytmrequesthandler.aspx?order_id=" + objutil.base64Encode(dt.Rows[0]["srno"].ToString()), false);
            }
            else
            {
                utility.MessageBox(this, "Sorry, Record Not Found.");
            }
        }
        catch
        {
            utility.MessageBox(this, "something, went wrong !!!");
        }
    }
    protected void lnlGetInvoice_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;
            Label lblsrno = (Label)gvrow.FindControl("lblId");
            int srno = Convert.ToInt32(lblsrno.Text.ToString());
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@MasterKey","GETINVOICEID"),
                new SqlParameter("@Id",srno),
            };
            DataTable dt = dutil.GetDataTableSP(param, "Usp_GetMaster");
            if (dt.Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "NewTab", "window.open('GSTBill.aspx?id=" + dt.Rows[0]["srno"].ToString() + "&st=" + 1 + "');", true);
            }
        }
        catch
        {

        }
    }
}