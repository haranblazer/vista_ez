using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class secretadmin_BDMDashboardDetails : System.Web.UI.Page
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

                        BindGrid();
                        if (MasterKey == "TPVRPV")
                            lbl_ReportName.Text = "TPV + RPV";
                        else
                            lbl_ReportName.Text = MasterKey;
                    }
                }
            }
        }
        catch
        {

        }




    }

    private void BindGrid()
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
        //Session["dt"] = dt;
        if (dt.Rows.Count > 0)
        {
            if (MasterKey == "RPV" || MasterKey == "TPV" || MasterKey == "TPVRPV")
            {
                Grid_RPV.Columns[9].FooterText = (string.IsNullOrEmpty(dt.Compute("sum([Total Amount])", "true").ToString()) ? "0.00" : dt.Compute("sum([Total Amount])", "true").ToString());
                Grid_RPV.Columns[10].FooterText = (string.IsNullOrEmpty(dt.Compute("sum([DP Amount])", "true").ToString()) ? "0.00" : dt.Compute("sum([DP Amount])", "true").ToString());
                Grid_RPV.Columns[11].FooterText = (string.IsNullOrEmpty(dt.Compute("sum([Normal PV])", "true").ToString()) ? "0.00" : dt.Compute("sum([Normal PV])", "true").ToString());
                Grid_RPV.Columns[12].FooterText = (string.IsNullOrEmpty(dt.Compute("sum([Topper PV])", "true").ToString()) ? "0.00" : dt.Compute("sum([Topper PV])", "true").ToString());

                Grid_RPV.DataSource = dt;
                Grid_RPV.DataBind();
            }

        }
        else
        {
            Grid_RPV.DataSource = null;
            Grid_RPV.DataBind();
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {

        if (Grid_RPV.Rows.Count > 0)
        {
            Grid_RPV.AllowPaging = false;
            BindGrid();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + MasterKey + ".xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            Grid_RPV.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");

    }
     

}