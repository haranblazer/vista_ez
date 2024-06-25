using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class franchise_ProductList : System.Web.UI.Page
{
    utility objUtil = new utility();
    int userid;

    string date, type;

    string str;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            go();
        }
    }

    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        go();
    }


    public void go()
    {

        da = new SqlDataAdapter("plist", con);
        //da.SelectCommand.Parameters.AddWithValue("@userid", str);
        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {
            // Label2.Text = "No of Records :" + t.Rows.Count.ToString();
            dglst.DataSource = dt;
            dglst.DataBind();

        }
        else
        {
            dglst.DataSource = null;
            dglst.DataBind();
        }
    }
}
