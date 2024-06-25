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
public partial class solaradmin_pooldisplayadmin : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    DataSet ds = new DataSet();
    string strsessionid = "";
    string tname;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Convert.ToString(Session["admin"])))
            Response.Redirect("adminLog.aspx");
       
            
            tname = Request.QueryString["poolname"].ToString();
            if (tname == "C0")
                Label2.Text = "Pool 0";
            if (tname == "C1")
                Label2.Text = "Pool 1";
            if (tname == "C2")
                Label2.Text = "Pool 2";
            if (tname == "C3")
                Label2.Text = "Pool 3";
            if (tname == "C4")
                Label2.Text = "Pool 4";
            if (tname == "C5")
                Label2.Text = "Pool 5";
            if (tname == "C6")
                Label2.Text = "Pool 6";

            pooldisplay();
    }
    protected void pooldisplay()
    {

        // string qstr = "Select poolid,convert(varchar,PoolEntryDOJ,103) from " +tname+ " where appmstid= '" + Convert.ToString(Session["userId"]) +"'";
        string qstr = "Select poolid,convert(varchar,PoolEntryDOJ,103) as  PoolEntryDOJ ,appmstregno from " + tname + "  a,appmst  b where a.appmstid=b.appmstid order by a.appmstid";

        da = new SqlDataAdapter(qstr, con);
        con.Open();
        da.Fill(ds);

        if (ds.Tables.Count > 0)
        {

            GridView1.DataSource = ds;
            GridView1.DataBind();

        }
        else
        {
            Label1.Text = "No Data Found!";
        }
        con.Close();
    }
   
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        pooldisplay();
    }
    protected void lnkBtnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("poolmainadmin.aspx");
    }
}
