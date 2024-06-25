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
public partial class admin_BeforPayoutresults : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    string ddl1;
    string ddl2;
    string ddl3;
    string ddl4;
    string ddl5;
    string ddl6;
    protected void Page_Load(object sender, EventArgs e)
    {

        for (int i = 0; i < ((ArrayList)(Session["ddl"])).Count; i++)
        {
            ddl1 = ((ArrayList)(Session["ddl"]))[0].ToString();
            ddl2 = ((ArrayList)(Session["ddl"]))[1].ToString();
            ddl3 = ((ArrayList)(Session["ddl"]))[2].ToString();
            ddl4 = ((ArrayList)(Session["ddl"]))[3].ToString();
            ddl5 = ((ArrayList)(Session["ddl"]))[4].ToString();
            ddl6 = ((ArrayList)(Session["ddl"]))[5].ToString();
        }
            go1();
    }
    public void go1()
    {

        string strmin = ddl2 + "/" + ddl1 + "/" + ddl3;
        string strmax = ddl5 + "/" + ddl6 + "/" + ddl4;

        string qstr = "select * from userpayment where CAST(FLOOR(CAST(dateofentry as float)) as datetime) between '" + strmin + "' and '" + strmax + "' order by dateofentry";

        com = new SqlCommand(qstr, con);
        con.Open();
        sdr = com.ExecuteReader();
        if (sdr.Read())
        {
           // ((Label)PreviousPage.FindControl("lbl")).Text = "";
            GridView1.DataSource = sdr;
            GridView1.DataBind();
            con.Close();
        }
        else
        {
            GridView1.DataSource = "";
            GridView1.DataBind();
           Label1.Text = "No data Found";
           // ((Label)PreviousPage.FindControl("lbl")).Text = "No data Found";

        } con.Close();
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        PrintHelper.PrintWebControl(Panel1);
    }
    //protected void pagechanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    go1();
    //}
}
