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
using System.Linq;

public partial class admin_ReportMultiPrint : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    utility objUtility = new utility();
    DateTime fromDate = new DateTime();
    DateTime toDate = new DateTime();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!IsPostBack)
        {
            getdate();            
        }
    }
    public void getdate()
    {
        SqlDataAdapter adp = new SqlDataAdapter("select Convert(varchar(20),PayFromDate,103) as PayFromDate, Convert(varchar(20),PayToDate,103) as PayToDate, payoutno from payoutdate order by payoutno", con);
        con.Open();
        DataTable dt = new DataTable();
        adp.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlDate.Items.Clear();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ddlDate.Items.Add(new ListItem(dt.Rows[i]["PayFromDate"].ToString() + "-" + dt.Rows[i]["PayToDate"].ToString(), dt.Rows[i]["payoutno"].ToString()));
               
              
            }
            ddlDate.Items.Insert(0, "Select Closing");
        }
        else
            ddlDate.Items.Insert(0,"No closing found !");
    }
    protected void ddlDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDate.SelectedItem.Text != "No closing found !")
        {
           
            selectdata();
        }
        else
        {
            utility.MessageBox(this, "Please select date !");
        }
    }
    private void selectdata()
    {


        SqlDataAdapter adp = new SqlDataAdapter("select a.appmstregno,a.appmsttitle+space(2)+a.appmstfname as name,p.paymenttrandraftid from PaymentTranDraft p , appmst a  where p.appmstid=a.appmstregno and p.payoutno=@pno order by paymenttrandraftid", con);
        adp.SelectCommand.Parameters.AddWithValue("@pno", ddlDate.SelectedItem.Value.Trim());
       // adp.SelectCommand.Parameters.AddWithValue("@to", toDate);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        if (ds.Tables[0].Rows.Count > 0)
        {
            GridView1.DataSource = ds;
            GridView1.DataBind();
            
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
           
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        //selectdata(ddlDate.SelectedItem.Text.Split('-').GetValue(0).ToString(), ddlDate.SelectedItem.Text.Split('-').GetValue(1).ToString());
        selectdata();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (ddlDate.SelectedItem.Text != "No closing found !")
            Page.Response.Redirect("PrintReport.aspx?startid=" + objUtility.base64Encode(TxtPaymentTrandraftid.Text) + "&pno=" + objUtility.base64Encode(ddlDate.SelectedValue.ToString())  + "&NoChq=" + objUtility.base64Encode(TxtNoChq.Text));
        else
            utility.MessageBox(this, "Please select date !");
    }   
}
