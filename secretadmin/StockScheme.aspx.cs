using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_StockScheme : System.Web.UI.Page
{
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
                txtFromDate.Text = DateTime.Now.Date.AddDays(-10).ToString("dd/MM/yyyy");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                BindFranchise();
                show();
            }
        }
        catch
        {

        }


        
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        show();
    }


    public void show()
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
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }
         
        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@MinDate", fromDate),
            new SqlParameter("@MaxDate", toDate),
            new SqlParameter("@FranchiseId", ddl_Franchise.SelectedValue.ToString())
        };
        DataUtility obj_du = new DataUtility();
        DataTable dt = obj_du.GetDataTableSP(param, "GetSchemeStock");
        Session["dt"] = dt;
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


    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        show();
    }


    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Session["dt"];

            if (dt.Rows.Count > 0)
            {

                
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}","StockScheme.xls"));
                Response.ContentType = "application/ms-excel";
                string str = string.Empty;
                foreach (DataColumn dtcol in dt.Columns)
                {
                    Response.Write(str + dtcol.ColumnName);
                    str = "\t";
                }
                Response.Write("\n");
                foreach (DataRow dr in dt.Rows)
                {
                    str = "";
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Response.Write(str + Convert.ToString(dr[j]));
                        str = "\t";
                    }
                    Response.Write("\n");
                }
                Response.End();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found.');", true);
            }
        }
        catch (Exception er) { }

    }


   
    public void BindFranchise()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select FranchiseId, UserName=Fname+ '('+Cast(FranchiseId as varchar(50))+')'  from FranchiseMst");
        ddl_Franchise.DataSource = dt;
        ddl_Franchise.DataTextField = "UserName";
        ddl_Franchise.DataValueField = "FranchiseId";
        ddl_Franchise.DataBind();
        ddl_Franchise.Items.Insert(0, new ListItem("All", "0"));
    }

}