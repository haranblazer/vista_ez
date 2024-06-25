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
public partial class admin_RefundRequest : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable t = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if (Page.IsPostBack == false)
        {
            go();
        }

    }
    public void go()
    {


        cmd = new SqlCommand("select userid,Amount,Reason,CONVERT(VARCHAR(10), date, 103)  as date from refund", con);

        da = new SqlDataAdapter(cmd);
        da.Fill(t);
      Label1.Text = "No Of Records Found:" + t.Rows.Count.ToString();
        if (t.Rows.Count > 0)
        {

            GridView1.DataSource = t;
            GridView1.DataBind();

        }
        else
        {

           Label1.Text = "No data Found !";
        }


    }
  
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    { GridView1.PageIndex = e.NewPageIndex;
        go();

    }
}
