using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Data;
using System.Data.SqlClient;

public partial class admin_TourPointSecondReport : System.Web.UI.Page
{
    utility objUtiliy = new utility();
    SqlDataAdapter da;
    SqlConnection con = new SqlConnection(method.str);
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

            bindGrid();

        }



    }



    public void bindGrid()
    {

        da = new SqlDataAdapter("select (select appmstregno from appmst where appmstid= a.appmstid) as regno, a.TP2608l,a.TP2608r FROM appmst a", con);
        da.SelectCommand.CommandType = CommandType.Text;

        DataTable table = new DataTable();
        da.Fill(table);
        if (table.Rows.Count > 0)
        {

            dglst.DataSource = table;
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
        bindGrid();
    }
}