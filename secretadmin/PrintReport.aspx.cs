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
public partial class admin_PrintReport : System.Web.UI.Page
{
    string todate;
    string fromdate;
    int reports;
    static int j;
    static int c;
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        fromdate = Request.QueryString["from"].ToString();
        todate = Request.QueryString["to"].ToString();
        reports = Convert.ToInt32(Request.QueryString["NoChq"]);
        Server.ScriptTimeout = 1440;
        if (!Page.IsPostBack)
        {
            j = Convert.ToInt32(Request.QueryString["startid"]);
            c = j + reports - 1;
            fetch();
        }

    }
    public void fetch()
    {
        da = new SqlDataAdapter("select a.appmstregno,a.AppMstTitle+space(2)+a.appmstfname as name,space(2),a.appmstaddress1,a.distt,a.AppMstCity,a.AppMstState,a.AppMstPinCode,a.AppMstMobile ,convert(char(10),p.paymentfromdate,103)+'--'+convert(char(10),p.paymenttodate,103) as payoutperiod,isnull(p.TPL,0) as TPL,isnull(p.TPR,'0') as TPR,isnull(p.NPL,'0') as NPL,isnull(p.NPR,'0') as NPR,isnull(p.BFL,'0') as BFL,isnull(p.BFR,'0') as BFR,isnull(p.CFL,'0') as CFL,isnull(p.CFR,'0') as CFR,isnull(p.CPL,'0') as CPL,isnull(p.CPR,'0') as CPR,isnull(p.TP,'0') as TP,p.binaryamt,p.directamt,p.binaryamt,p.leadershipamt,p.royaltyamt,p.totalearning,p.TDS,p.handlingCharges,p.dispachedamt,p.paymenttrandraftno,p.othercharges  from PaymentTranDraft p with(nolock), appmst a where p.iselegible=1 and p.appmstid=a.appmstregno and  p.paymenttrandraftid>='" + j + "' and p.paymenttrandraftid<='" + c + "' and p.paymentfromdate='" + fromdate + "' and p.paymenttodate='" + todate + "' order by Paymenttrandraftid", con);
        da.Fill(dt);
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
        Label mylable = new Label();
        c = c + reports;
        j = j + reports; 

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        fetch();
    }

}
