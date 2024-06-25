using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class admin_AdminPayout3 : System.Web.UI.Page
{
    string strfrom, strto;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminloginInside();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!IsPostBack)
        {
            go();
        }
    }

    public void go()
    {

        com = new SqlCommand("selecttranb2", con);
        com.CommandType = CommandType.StoredProcedure;
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        if (t.Rows.Count > 0)
        {
            Label1.Text = t.Rows[0]["paymentfromdate"].ToString();
            Label2.Text = t.Rows[0]["paymenttodate"].ToString();

            dgr.DataSource = t;
            dgr.DataBind();
        }
        else
        {
            Label3.Text = "No Data Found!";

        }

    }
}