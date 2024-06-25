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
public partial class admin_rewardAchived : System.Web.UI.Page
{
    string Qualify="0";
    string Dispatch="0";
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader dr;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
    }
    public void qualfydata(string status)
    {
        com = new SqlCommand("select a.appmstregno,a.appmstfname,t.awardname,t.AwardAchivedDate from appmst a ,finalreward t where a.appmstregno=t.appmstregno and  qualify='"+status+"'", con);
        con.Open();
        dr = com.ExecuteReader();
        GridView1.DataSource = dr;
        GridView1.DataBind();
        con.Close();
    }
    public void dispatchdata(string status)
    {
        com = new SqlCommand("select a.appmstregno,a.appmstfname,t.awardname,t.AwardAchivedDate from appmst a ,finalreward t where a.appmstregno=t.appmstregno and  dispatch='" + status + "'", con);
        con.Open();
        dr = com.ExecuteReader();
        GridView1.DataSource = dr;
        GridView1.DataBind();
        con.Close();
    }
   
    protected void btnsShow_Click(object sender, EventArgs e)
    {
      
        if (rbtnQualify.Checked)
        {
            Qualify = "1";
            qualfydata(Qualify);

        }
        if (rbtnDispatch.Checked)
        {
            Dispatch = "1";
            dispatchdata(Dispatch);
        }
       
    }
}
