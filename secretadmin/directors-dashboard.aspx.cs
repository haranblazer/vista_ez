using System; 
using System.Web; 
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;

public partial class secretadmin_directors_dashboard : System.Web.UI.Page
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
                //HttpContext.Current.Session["username"] = dt.Rows[0]["FName"].ToString();
                //HttpContext.Current.Session["userid"] = dt.Rows[0]["FranchiseId"].ToString();
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
                //var startDate = new DateTime(now.Year, now.Month, 1);
                //fromDate=startDate.ToString("MM/dd/yyyy").Replace("-", "/");


            }
            if (txtToDate.Text.Trim().Length > 0)
            {
                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                // toDate =  DateTime.UtcNow.AddMinutes(330).ToString("MM/dd/yyyy").Replace("-", "/");
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
            DataTable dt = objDu.GetDataTableSP(param, "GetAd_Dir_DashData");
            if (dt.Rows.Count > 0)
            {
                lbl_GPV.InnerText = common.CurrencyFormate(dt.Rows[0]["GPV"].ToString());
                lbl_GPV_AMT.InnerText = common.RS_Formate(dt.Rows[0]["GPV_Invoice_Amount"].ToString());
                lbl_GPV_CNT.InnerText = common.CurrencyFormate(dt.Rows[0]["GPV_CNT"].ToString());

                lbl_TPV.InnerText = common.CurrencyFormate(dt.Rows[0]["TPV"].ToString());
                lbl_TPV_AMT.InnerText = common.RS_Formate(dt.Rows[0]["TPV_Invoice_Amount"].ToString());
                lbl_TPV_CNT.InnerText = common.CurrencyFormate(dt.Rows[0]["TPV_CNT"].ToString());


                lbl_Loyalty.InnerText = common.CurrencyFormate(dt.Rows[0]["Loyalty"].ToString());
                lbl_Loyalty_AMT.InnerText = common.RS_Formate(dt.Rows[0]["Loyalty_AMT"].ToString());
                lbl_Loyalty_CNT.InnerText = common.CurrencyFormate(dt.Rows[0]["Loyalty_CNT"].ToString());

                lbl_GPV_TPV.InnerText = common.CurrencyFormate(dt.Rows[0]["TPV_GPV"].ToString());
                lbl_GPV_TPV_AMT.InnerText = common.RS_Formate(dt.Rows[0]["TPV_GPV_Invoice_Amount"].ToString());
                lbl_GPV_TPV_CNT.InnerText = common.CurrencyFormate(dt.Rows[0]["TPV_GPV_CNT"].ToString());



                lbl_Online_Sales.InnerText = common.CurrencyFormate(dt.Rows[0]["TotalOnlineBV"].ToString());
                lbl_Online_Sales_AMT.InnerText = common.RS_Formate(dt.Rows[0]["TotalOnlineSales"].ToString());
                lbl_Online_Sales_CNT.InnerText = common.CurrencyFormate(dt.Rows[0]["TotalOnlineCNT"].ToString());

                lbl_Off_Sales.InnerText = common.CurrencyFormate(dt.Rows[0]["TotalOfflineBV"].ToString());
                lbl_Off_Sales_AMT.InnerText = common.RS_Formate(dt.Rows[0]["TotalOfflineSales"].ToString());
                lbl_Off_Sales_CNT.InnerText = common.CurrencyFormate(dt.Rows[0]["TotalOfflineCNT"].ToString());

                 
               // lbl_Comp_Fran_AMT.InnerText = common.RS_Formate(dt.Rows[0]["Franchise_Invoice_Amount"].ToString());
                //lbl_Comp_Fran_CNT.InnerText = common.CurrencyFormate(dt.Rows[0]["Franchise_Invoice_CNT"].ToString());


                lbl_Total_Sales.InnerText = common.CurrencyFormate(dt.Rows[0]["TotalPrimaryBV"].ToString());
                lbl_Total_Sales_AMT.InnerText = common.RS_Formate(dt.Rows[0]["TotalPrimarySales"].ToString());
                lbl_Total_Sales_CNT.InnerText = common.CurrencyFormate(dt.Rows[0]["TotalPrimaryCNT"].ToString());


                //if (dt.Rows[0]["RoleId"].ToString() == "1")
                //{
                //    //div_Fillter.Visible = true;
                //    div_Directors.Visible = true;

                //    lbl_RPV.InnerText = dt.Rows[0]["GPV"].ToString();
                //    lbl_TPV.InnerText = dt.Rows[0]["TPV"].ToString();
                //    lbl_RPV_TPV.InnerText = dt.Rows[0]["TPV_GPV"].ToString();
                //    lbl_InvoiceSales.InnerText = dt.Rows[0]["TotalInvoiceSales"].ToString();
                //    lbl_PrimarySales.InnerText = dt.Rows[0]["TotalPrimarySales"].ToString();

                //    lbl_TPVText.InnerText = dt.Rows[0]["BV_Text"].ToString();
                //    lbl_RPVText.InnerText = dt.Rows[0]["PV_Text"].ToString();
                //    lbl_TPVRPVText.InnerText = dt.Rows[0]["BV_Text"].ToString() + " + " + dt.Rows[0]["PV_Text"].ToString();

                //    lbl_FWalletApprove.InnerText = dt.Rows[0]["FWalletApprove"].ToString();
                //    lbl_CWalletApprove.InnerText = dt.Rows[0]["CWalletApprove"].ToString();
                //    lbl_TotalOnlineSales.InnerText = dt.Rows[0]["TotalOnlineSales"].ToString();
                //    lbl_TotalCollection.InnerText = dt.Rows[0]["Total_Collection"].ToString();

                //    //div_Distribution.Visible = true;
                //    //div_PendingFWalletRequest.InnerText = dt.Rows[0]["PendingFWalletRequest"].ToString();
                //    //div_PendingCWalletRequest.InnerText = dt.Rows[0]["PendingCWalletRequest"].ToString();
                //    //div_PendingPOsreceived.InnerText = dt.Rows[0]["PendingPosReceived"].ToString();
                //    //div_PendingDispatches.InnerText = dt.Rows[0]["PendingDispatches"].ToString();

                //    //div_Customercare.Visible = true;
                //    //div_PendingAadharApprovals.InnerText = dt.Rows[0]["PendingAadharApprovals"].ToString();
                //    //div_PendingPanApprovals.InnerText = dt.Rows[0]["PendingPanApprovals"].ToString();
                //    //div_PendingBankApprovals.InnerText = dt.Rows[0]["PendingBankApprovals"].ToString();
                //}
                //else if (dt.Rows[0]["RoleId"].ToString() == "2")
                //{
                //    div_Directors.Visible = true;
                //    lbl_RPV.InnerText = dt.Rows[0]["GPV"].ToString();
                //    lbl_TPV.InnerText = dt.Rows[0]["TPV"].ToString();
                //    lbl_RPV_TPV.InnerText = dt.Rows[0]["TPV_GPV"].ToString();
                //    lbl_InvoiceSales.InnerText = dt.Rows[0]["TotalInvoiceSales"].ToString();
                //    lbl_PrimarySales.InnerText = dt.Rows[0]["TotalPrimarySales"].ToString();

                //    lbl_TPVText.InnerText = dt.Rows[0]["BV_Text"].ToString();
                //    lbl_RPVText.InnerText = dt.Rows[0]["PV_Text"].ToString();
                //    lbl_TPVRPVText.InnerText = dt.Rows[0]["BV_Text"].ToString() + " + " + dt.Rows[0]["PV_Text"].ToString();

                //    lbl_FWalletApprove.InnerText = dt.Rows[0]["FWalletApprove"].ToString();
                //    lbl_CWalletApprove.InnerText = dt.Rows[0]["CWalletApprove"].ToString();
                //    lbl_TotalOnlineSales.InnerText = dt.Rows[0]["TotalOnlineSales"].ToString();
                //    lbl_TotalCollection.InnerText = dt.Rows[0]["Total_Collection"].ToString();
                //}
                //else if (dt.Rows[0]["RoleId"].ToString() == "3")
                //{
                //    div_Distribution.Visible = true;

                //    div_PendingFWalletRequest.InnerText = dt.Rows[0]["PendingFWalletRequest"].ToString();
                //    div_PendingCWalletRequest.InnerText = dt.Rows[0]["PendingCWalletRequest"].ToString();
                //    div_PendingPOsreceived.InnerText = dt.Rows[0]["PendingPosReceived"].ToString();
                //    div_PendingDispatches.InnerText = dt.Rows[0]["PendingDispatches"].ToString();
                //}
                //else if (dt.Rows[0]["RoleId"].ToString() == "4")
                //{
                //    div_Customercare.Visible = true;

                //    div_PendingAadharApprovals.InnerText = dt.Rows[0]["PendingAadharApprovals"].ToString();
                //    div_PendingPanApprovals.InnerText = dt.Rows[0]["PendingPanApprovals"].ToString();
                //    div_PendingBankApprovals.InnerText = dt.Rows[0]["PendingBankApprovals"].ToString();
                //}
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