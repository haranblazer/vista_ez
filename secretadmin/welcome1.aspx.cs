using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class mumbaiadmin_welcome : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    DataTable t = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
            Response.Redirect("adminLog.aspx", false);
        else
            lbladmin.Text = Session["admin"].ToString();

        //if (!IsPostBack)
        //{
        //    binddata();
        //}

    }
    protected void lblUserInLeft_Click(object sender, EventArgs e)
    {

    }
    protected void lblUserInRight_Click(object sender, EventArgs e)
    {

    }

   

}
