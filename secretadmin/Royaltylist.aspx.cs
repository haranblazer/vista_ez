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
public partial class admin_list : System.Web.UI.Page
{
    
    SqlConnection con = null;
    SqlDataAdapter da;
    SqlCommand com = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        GetRoyaltyAchievers();
        /*
       // InsertFunction.CheckAdminlogin();
        string str;
        str = Convert.ToString(Session["admin"]);
        if (!IsPostBack)
        {
            if (str != "")
            {
                GetRoyaltyAchievers();
            }
            else
            {
                Response.Redirect("adminLog.aspx");
            }
        }
         */
    }

    public void GetRoyaltyAchievers()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("select appmstregno,appmsttitle+SPACE(1)+AppMstFName as name,IsRltAchvr,convert(varchar,rltAchvrDate,103) as doa from appmst where IsRltAchvr=1 and datediff(day,rltAchvrDate,GETDATE())<=365 ", con);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        Label2.Text = t.Rows.Count.ToString();
        dglst.DataSource = t;
        dglst.DataBind();
        Label1.Text = "";

    }

   
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
       
        dglst.PageIndex = e.NewPageIndex;
        GetRoyaltyAchievers();

    }
    
    protected void Button3_Click(object sender, EventArgs e)
    {
        dglst.PageSize = Convert.ToInt32(Label1.Text);
        GetRoyaltyAchievers();
        Response.Clear();
        Response.AddHeader("content-disposition","attachment;filename=RoyaltyAchvr.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        dglst.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}