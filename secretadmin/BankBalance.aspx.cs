using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class admin_BankBalance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if (Session["admin"] != null)
        {
           if (!IsPostBack)
           {
               bindgrid();
           }
       }
      
    }
    private void bindgrid()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter("BankBalance", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        da.Fill(dt);
        GrdWithdraw.DataSource = dt;
        GrdWithdraw.DataBind();
    }
    protected void dgrd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GrdWithdraw.PageIndex = e.NewPageIndex;
        bindgrid();
    }

    

}
