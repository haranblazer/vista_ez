using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
//using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
//using System.Web.UI.WebControls;

public partial class secretadmin_DashboardInvDetails : Page
{
    static string MasterKey = "", State = "", From = "", To = "";
 
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
            {
                utility.CheckSuperAdminLogin();
            }
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
                        State = Request.QueryString["State"].ToString();
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

                        BindGridDetails();

                        if (MasterKey == "INVSALES")
                            lbl_ReportName.Text = "INVOICE SALES";
                        if (MasterKey == "PRIMARYSALES")
                            lbl_ReportName.Text = "PRIMARY SALES";
                        if (MasterKey == "TOTALCOLLECTION")
                            lbl_ReportName.Text = "TOTAL COLLECTION";

                    }
                }

            }
        }
        catch (Exception er)
        {

        }
         

    }

    
    private void BindGridDetails()
    {
        if (Request.QueryString["From"].ToString().Length > 0)
        {
            String[] Date = Request.QueryString["From"].ToString().Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
            From = Date[0] + "/" + Date[1] + "/" + Date[2];
        }
        if (Request.QueryString["To"].ToString().Length > 0)
        {
            String[] Date = Request.QueryString["To"].ToString().Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
            To = Date[0] + "/" + Date[1] + "/" + Date[2];
        }

        lbl_State.Text = "State: " + State;
        SqlParameter[] param = new SqlParameter[]
       {
            new SqlParameter("@MasterKey", MasterKey),
            new SqlParameter("@Adminid", Session["admin"].ToString()),
            new SqlParameter("@State", State),
            new SqlParameter("@From", From),
            new SqlParameter("@To", To)
       };
        DataUtility obj_du = new DataUtility();
        DataTable dt = obj_du.GetDataTableSP(param, "GetDashboardDetails");
       
        //ViewState["dt_1"] = dt;
        if (dt.Rows.Count > 0)
        {
            if (MasterKey == "INVSALES" || MasterKey == "PRIMARYSALES" || MasterKey == "TOTALCOLLECTION")
            {
                Grid_InvDetails.Columns[8].FooterText = dt.Compute("sum(NoOFProduct)", "true").ToString();
                Grid_InvDetails.Columns[9].FooterText = dt.Compute("sum(Billed_Qty)", "true").ToString();

                Grid_InvDetails.Columns[10].FooterText = dt.Compute("sum([Total Amount])", "true").ToString();
                Grid_InvDetails.Columns[11].FooterText = dt.Compute("sum([RPV])", "true").ToString();
                Grid_InvDetails.Columns[12].FooterText = dt.Compute("sum([TPV])", "true").ToString();

                Grid_InvDetails.DataSource = dt;
                Grid_InvDetails.DataBind();
            }
        }
        else
        {
            Grid_InvDetails.DataSource = null;
            Grid_InvDetails.DataBind();
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Grid_InvDetails.PageIndex = e.NewPageIndex;
        BindGridDetails();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {

        if (Grid_InvDetails.Rows.Count > 0)
        {
            Grid_InvDetails.AllowPaging = false;
            BindGridDetails();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + MasterKey + ".xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            Grid_InvDetails.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");

    }

    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {



    //        DataTable dt = new DataTable();
    //        dt = (DataTable)ViewState["dt_1"];

    //        if (dt.Rows.Count > 0)
    //        {
    //            Response.ClearContent();
    //            Response.Buffer = true;
    //            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", MasterKey + ".xls"));
    //            Response.ContentType = "application/ms-excel";
    //            string str = string.Empty;
    //            foreach (DataColumn dtcol in dt.Columns)
    //            {
    //                Response.Write(str + dtcol.ColumnName);
    //                str = "\t";
    //            }
    //            Response.Write("\n");
    //            foreach (DataRow dr in dt.Rows)
    //            {
    //                str = "";
    //                for (int j = 0; j < dt.Columns.Count; j++)
    //                {
    //                    Response.Write(str + Convert.ToString(dr[j]));
    //                    str = "\t";
    //                }
    //                Response.Write("\n");
    //            }
    //            Response.End();
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found.');", true);
    //        }
    //    }
    //    catch (Exception er) { }
    //}
}