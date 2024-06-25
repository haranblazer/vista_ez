using System; 
using System.Web; 
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class secretadmin_distribution_dashboard : System.Web.UI.Page
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

    [WebMethod]
    public static string GetLogin(string flag, string Userid, string UserType)
    {
        string IsValid = "0";
        DataUtility objDu = new DataUtility();
        if (UserType == "1")
        {
            SqlParameter[] param1 = new SqlParameter[] { new SqlParameter("@Userid", Userid) };
            DataTable dt = objDu.GetDataTable(param1, "Select AppmstRegno from Appmst where AppmstRegno=@Userid");
            if (dt.Rows.Count > 0)
            {
                IsValid = "1";
                HttpContext.Current.Session["userId"] = dt.Rows[0]["AppmstRegno"].ToString();
            }
            else
            {
                return "Invalid UserId.!!";
            }
        }

        if (UserType == "2")
        {
            SqlParameter[] param1 = new SqlParameter[] { new SqlParameter("@Userid", Userid) };
            DataTable dt = objDu.GetDataTable(param1, "Select FranchiseId, FName from FranchiseMst where FranchiseId=@Userid");
            if (dt.Rows.Count > 0)
            {
                IsValid = "1";
                HttpContext.Current.Session["franchiseid"] = dt.Rows[0]["FranchiseId"].ToString();
                HttpContext.Current.Session["username"] = dt.Rows[0]["FName"].ToString();
                HttpContext.Current.Session["userid"] = dt.Rows[0]["FranchiseId"].ToString();
                HttpContext.Current.Session["name"] = dt.Rows[0]["FName"].ToString();
                HttpContext.Current.Session["frantype"] = "0";
            }
            else
            {
                return "Invalid UserId.!!";
            }
        }
        return IsValid;

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

        SqlParameter[] param = new SqlParameter[] {
            new SqlParameter("@Adminid", Session["admin"].ToString()),
            new SqlParameter("@From", fromDate),
            new SqlParameter("@To", toDate),
            new SqlParameter("@flag", 0),
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetAd_Dist_DashData");
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["RoleId"].ToString() == "1")
            { 
                div_Distribution.Visible = true;
                //div_PendingFWalletRequest.InnerText = dt.Rows[0]["PendingFWalletRequest"].ToString();
                div_PendingCWalletRequest.InnerText = dt.Rows[0]["PendingCWalletRequest"].ToString();

                div_PO_Offline.InnerText = dt.Rows[0]["PO_OFFLINE"].ToString();
                div_PO_Online.InnerText = dt.Rows[0]["PO_ONLINE"].ToString();

                div_PO_INV_DONE.InnerText = dt.Rows[0]["PO_Done"].ToString();
                //div_PENDING_PO.InnerText = dt.Rows[0]["PO_Pending"].ToString();

                div_PENDING.InnerText = dt.Rows[0]["Inv_Pending"].ToString();
                div_DISPATCH.InnerText = dt.Rows[0]["Inv_Dispatches"].ToString();

               // div_Fran_Transit.InnerText = dt.Rows[0]["Fran_Transit"].ToString();
                div_Fran_pod_upload.InnerText = dt.Rows[0]["Fran_pod_upload"].ToString();
                div_Fran_Delivery.InnerText = dt.Rows[0]["Fran_Delivery"].ToString();
                
            }

            else if (dt.Rows[0]["RoleId"].ToString() == "3")
            {
                div_Distribution.Visible = true;

                //div_PendingFWalletRequest.InnerText = dt.Rows[0]["PendingFWalletRequest"].ToString();
                div_PendingCWalletRequest.InnerText = dt.Rows[0]["PendingCWalletRequest"].ToString();

                div_PO_Offline.InnerText = dt.Rows[0]["PO_OFFLINE"].ToString();
                div_PO_Online.InnerText = dt.Rows[0]["PO_ONLINE"].ToString();

                div_PO_INV_DONE.InnerText = dt.Rows[0]["PO_Done"].ToString();
               // div_PENDING_PO.InnerText = dt.Rows[0]["PO_Pending"].ToString();

                div_PENDING.InnerText = dt.Rows[0]["Inv_Pending"].ToString();
                div_DISPATCH.InnerText = dt.Rows[0]["Inv_Dispatches"].ToString();

                //div_Fran_Transit.InnerText = dt.Rows[0]["Fran_Transit"].ToString();
                div_Fran_pod_upload.InnerText = dt.Rows[0]["Fran_pod_upload"].ToString();
                div_Fran_Delivery.InnerText = dt.Rows[0]["Fran_Delivery"].ToString();

            }
             
        }
        else
        {
            utility.MessageBox(this, "Difference between Date must be of 31 days!!");
            return;
        }
    }

}