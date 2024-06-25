using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;

public partial class secretadmin_BDM_Dashboard : System.Web.UI.Page
{
    DateTime now = DateTime.Now;
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

                var startDate = new DateTime(now.Year, now.Month, 1);
                txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");
                BindDashboard();
            }
        }
        catch
        {

        }


    }
     

    protected void Button1_Click(object sender, EventArgs e)
    {
        BindDashboard();
    }

    private void BindDashboard()
    {
        String fromDate = "", toDate = "";
        try
        {
            if (txtFromDate.Text.Trim().Length > 0)
            {
                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
            if (txtToDate.Text.Trim().Length > 0)
            {
                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
        }
        catch
        {
            utility.MessageBox(this, "Invalid date entry.!!");
            return;
        }
        try
        {
            SqlParameter[] param = new SqlParameter[] {
            new SqlParameter("@Adminid", Session["admin"].ToString()),
            new SqlParameter("@From", fromDate),
            new SqlParameter("@To", toDate),
            new SqlParameter("@flag", 0),
        };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "Get_BDM_Dashboard");
            if (dt.Rows.Count > 0)
            {

                lbl_RPV.InnerText = dt.Rows[0]["GPV"].ToString();
                lbl_TPV.InnerText = dt.Rows[0]["TPV"].ToString();
                lbl_RPV_TPV.InnerText = dt.Rows[0]["TPV_GPV"].ToString();
                lbl_InvoiceSales.InnerText = dt.Rows[0]["TotalInvoiceSales"].ToString();
                lbl_PrimarySales.InnerText = dt.Rows[0]["TotalPrimarySales"].ToString();

                lbl_TPVText.InnerText = dt.Rows[0]["BV_Text"].ToString();
                lbl_RPVText.InnerText = dt.Rows[0]["PV_Text"].ToString();
                lbl_TPVRPVText.InnerText = dt.Rows[0]["BV_Text"].ToString() + " + " + dt.Rows[0]["PV_Text"].ToString();
            }
            else
            {
                utility.MessageBox(this, "Difference between Date must be of 31 days!!");
                return;
            }
        }
        catch (Exception er)
        {
            utility.MessageBox(this, "Date format not correct.!!");
            return;
        }
    }
}