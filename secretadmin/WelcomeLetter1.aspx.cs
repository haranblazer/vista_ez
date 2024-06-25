using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class yesadmin_WelcomeLetter1 : System.Web.UI.Page
{
    int pno = 0;
    int min = 0;
    int max = 0;
    static int j;
    static int c;
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    DataTable dt = new DataTable();
    utility objUtil = new utility();
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
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["pno"] != null)
            {
                pno = Convert.ToInt32(objUtil.base64Decode(Request.QueryString["pno"].ToString()));
                min = Convert.ToInt32(objUtil.base64Decode(Request.QueryString["min"].ToString()));
                max = Convert.ToInt32(objUtil.base64Decode(Request.QueryString["max"].ToString()));
            }
            fetch();
        }

    }
    public void fetch()
    {

        SqlDataAdapter da = new SqlDataAdapter("welcomeinvoiceprint", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.CommandTimeout = 999999;
        da.SelectCommand.Parameters.AddWithValue("@Payoutno", pno);
        da.SelectCommand.Parameters.AddWithValue("@MinVal", min);
        da.SelectCommand.Parameters.AddWithValue("@MaxVal", max);
        da.SelectCommand.Parameters.AddWithValue("@Types", "WELCOME");
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            Repeater1.DataSource = dt;
            Repeater1.DataBind();
        }
        else
        {
            Repeater1.DataSource = null;
            Repeater1.DataBind();
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        fetch();
    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
       
        
        
    }
}
