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
using System.Diagnostics;
using Microsoft.Win32;
public partial class admin_pnbchq : System.Web.UI.Page
{
    string todate;
    string fromdate;
    
    int cheques;
    static int j;
    static int c;
    SqlConnection con = new SqlConnection(method.str);

    SqlDataAdapter da;
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        fromdate = Request.QueryString["from"].ToString();
        todate = Request.QueryString["to"].ToString();
        cheques = Convert.ToInt32(Request.QueryString["NoChq"]);
        Server.ScriptTimeout = 1440;
        if (!Page.IsPostBack)
        {
            j = Convert.ToInt32(Request.QueryString["startid"]);
            c = j + cheques - 1;
            fetch();
        }
    }
    public void fetch()
    {
        da = new SqlDataAdapter("select a.appmstregno as regno,p.paymenttrandraftno,convert(char(8),p.paymenttodate,3) as paymenttodate ,a.appmstfname as name,'** '+c244323_soganetworks.NameNum(p.dispachedamt)+' Only **' as dispachedAmtwords,stuff(p.dispachedamt,1,0,'**') as dispachedamt from PaymentTranDraft p , appmst a where p.appmstid=a.appmstregno and p.paymenttrandraftid>='" + j + "' and p.paymenttrandraftid<='" + c + "' and p.paymentfromdate='" + fromdate + "' and p.paymenttodate='" + todate + "' order by Paymenttrandraftno", con);
        da.Fill(dt);
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
        Label mylable = new Label();
        c = c + cheques;
        j = j + cheques;


    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        fetch();
    }
}
