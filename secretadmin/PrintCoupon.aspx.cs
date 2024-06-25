using System;
using System.Data;
using System.Data.SqlClient;

public partial class secretadmin_PrintCoupon : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");
            // BindDataList();
        }
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataList();
    }


    public void BindDataList()
    {
        try
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
                utility.MessageBox(this, "Invalid date entry2.");
                return;
            }



            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@From", fromDate),
                   new SqlParameter("@To", toDate),
                   new SqlParameter("@RegNo", txt_Userid.Text.Trim()),
                   new SqlParameter("@L_Counpon", txt_Coupon.Text.Trim()),
                   new SqlParameter("@Isactive", ddl_Status.SelectedValue),
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "sp_PrintCoupon");

            DL_Coupon.DataSource = dt;
            DL_Coupon.DataBind();

        }
        catch (Exception er)
        {

        }
    }
}