using System;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class secretadmin_BDMDashboardDetailStateWise : System.Web.UI.Page
{
    static string MasterKey = "", From = "", To = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //if (Convert.ToString(Session["admintype"]) == "sa")
            //{
            //    utility.CheckSuperAdminLogin();
            //}
            //else if (Convert.ToString(Session["admintype"]) == "a")
            //{
            //    utility.CheckAdminLogin();
            //}
            if (Session["admin"] == null)
            {
                Response.Redirect("logout.aspx");
            }
            if (!IsPostBack)
            {
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["Key"] != null)
                    {
                        MasterKey = Request.QueryString["Key"].ToString();
                        try
                        {
                            if (Request.QueryString["From"].ToString().Length > 0)
                            {
                                String[] Date = Request.QueryString["From"].ToString().Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                                From = Date[1] + "/" + Date[0] + "/" + Date[2];
                            }
                            if (Request.QueryString["To"].ToString().Length > 0)
                            {
                                String[] Date = Request.QueryString["To"].ToString().Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                                To = Date[1] + "/" + Date[0] + "/" + Date[2];
                            }
                        }
                        catch
                        {
                            utility.MessageBox(this, "Invalid date entry.!!");
                            return;
                        }
                        BindStateGrid();

                        if (MasterKey == "INVSALES")
                            lbl_ReportName.Text = "Invoice Sales";
                        if (MasterKey == "PRIMARYSALES")
                            lbl_ReportName.Text = "Primary Sales";
                        if (MasterKey == "TOTALCOLLECTION")
                            lbl_ReportName.Text = "Total Collection";

                    }
                }

            }
        }
        catch
        {

        }



    }

    private void BindStateGrid()
    {
        SqlParameter[] param = new SqlParameter[]
       {
            new SqlParameter("@MasterKey", MasterKey),
            new SqlParameter("@Adminid", Session["admin"].ToString()),
            new SqlParameter("@State", ""),
            new SqlParameter("@From", From),
            new SqlParameter("@To", To)
       };
        DataUtility obj_du = new DataUtility();
        DataTable dt = obj_du.GetDataTableSP(param, "GetBDMDashboardDetails");
        // Session["dt_2"] = dt;
        if (dt.Rows.Count > 0)
        {
            if (MasterKey == "INVSALES" || MasterKey == "PRIMARYSALES" || MasterKey == "TOTALCOLLECTION")
            {
                Grid_State.Columns[0].FooterText = "Total Sales";
                Grid_State.Columns[1].FooterText = (string.IsNullOrEmpty(dt.Compute("sum([Secondary_Sales])", "true").ToString()) ? "0.00" : dt.Compute("sum([Secondary_Sales])", "true").ToString());

                Grid_State.DataSource = dt;
                Grid_State.DataBind();
            }
        }
        else
        {
            Grid_State.DataSource = null;
            Grid_State.DataBind();
        }
    }



    protected void Grid_State_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = Grid_State.Rows[Convert.ToInt32(e.CommandArgument)];
        try
        {
            if (e.CommandName.Equals("State"))
            {
                string state = Grid_State.DataKeys[row.RowIndex].Values[0].ToString();
                Response.Redirect("BDMDashboardInvDetails.aspx?Key=" + MasterKey + "&state=" + state + "&From=" + From + "&To=" + To);
            }
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {

        if (Grid_State.Rows.Count > 0)
        {
            Grid_State.AllowPaging = false;
            BindStateGrid();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + MasterKey + ".xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            Grid_State.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");

    }
}