using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class secretadmin_franchisebalancelist : System.Web.UI.Page
{
    utility objUtiliy = new utility();
 
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
            BindDataDatewise();
        }
    }
     
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        BindDataDatewise();
    }


    public void BindDataDatewise()
    {
        try
        {

            DataUtility objdu = new DataUtility();

            SqlParameter[] sqlparam = new SqlParameter[] {
            new SqlParameter("@Userid", txt_Userid.Text.Trim()),
            new SqlParameter("@UserName", txt_UserName.Text.Trim()),
            new SqlParameter("@status", ddl_Status.SelectedValue.ToString()),
            };
            DataTable dt = objdu.GetDataTableSP(sqlparam, "FranGetBalanceList");

            if (dt.Rows.Count > 0)
            {
                dglst.DataSource = dt;
                dglst.DataBind();
            }
            else
            {
                dglst.DataSource = null;
                dglst.DataBind();
            }
        }
        catch
        {
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindDataDatewise();
    }
}