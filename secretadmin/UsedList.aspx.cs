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
public partial class admin_UsedList : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd = new SqlCommand();
  
    int StartIndex;
    int EndIndex;
    protected void Page_Load(object sender, EventArgs e)
    {
        DateTime d = System.DateTime.Now;
        DateTime d1 = d.AddDays(-60); 
        string str;
        InsertFunction.CheckAdminlogin();
      
        if (!IsPostBack)
        {

            ddlday1.Text = d1.Day.ToString();
            ddlmonth1.Text = d1.Month.ToString();
            ddlyear1.Text = d1.Year.ToString();
            ddlday.Text = Convert.ToString(System.DateTime.Now.Day);
            ddlmonth.Text = Convert.ToString(System.DateTime.Now.Month);
            ddlyear.Text = Convert.ToString(System.DateTime.Now.Year);
            
            con.Open();
            //SqlCommand cmd = new SqlCommand("select count(*) from pinmst where isactivate=1 and paidappmstid=1", con);

            //dgrd.VirtualItemCount = (int)((int)(cmd.ExecuteScalar()) / (int)(dgrd.PageSize));
            con.Close();
            databind();
        }

    }
    private void databind()
    {
        int day1 = Convert.ToInt32(ddlday1.SelectedValue);
        int month1 = Convert.ToInt32(ddlmonth1.SelectedValue);
        int year1 = Convert.ToInt32(ddlyear1.SelectedValue);
        string strdate1 = month1 + "/" + day1 + "/" + year1;

        int day = Convert.ToInt32(ddlday.SelectedValue);
        int month = Convert.ToInt32(ddlmonth.SelectedValue);
        int year = Convert.ToInt32(ddlyear.SelectedValue);
        string strdate = Convert.ToString(day1 + month1 + year1);

        EndIndex = StartIndex + dgrd.PageSize;
        SqlConnection con = new SqlConnection(method.str);
        con.Open();
        SqlDataAdapter adp = new SqlDataAdapter("select appmst.appmstfname as name,pinmst.pinsrno as PinSerial_No,pinmst.regno,pinmst.activedate,pinmst.isactivate as IsActivate,pinmst.activedate as Active_Date from pinmst,appmst where pinmst.regno=appmst.appmstregno and isactivate=1 and paidappmstid=1 and pinmst.activedate > '" + strdate1 + "' and pinmst.activedate < '" + strdate + "' order by appmst.appmstregno", con);
        adp.SelectCommand.Parameters.Add("@startindex", StartIndex);
        adp.SelectCommand.Parameters.Add("@endindex", EndIndex);
        DataSet ds = new DataSet();
        adp.Fill(ds);

        dgrd.DataSource = ds;
        dgrd.DataBind();
        txtnorec.Text = ds.Tables[0].Rows.Count.ToString();
        con.Close();
    }
    protected void btnShow_Click1(object sender, EventArgs e)
    {
        int day1 = Convert.ToInt32(ddlday1.SelectedValue);
        int month1 = Convert.ToInt32(ddlmonth1.SelectedValue);
        int year1 = Convert.ToInt32(ddlyear1.SelectedValue);
        string strdate1 = month1 + "/" + day1 + "/" + year1;

        int day = Convert.ToInt32(ddlday.SelectedValue);
        int month = Convert.ToInt32(ddlmonth.SelectedValue);
        int year = Convert.ToInt32(ddlyear.SelectedValue);
        string strdate = Convert.ToString(day1 + month1 + year1);

        SqlConnection con = new SqlConnection(method.str);
        con.Open();
        //DataSet ds;
        SqlDataAdapter adp = new SqlDataAdapter("select appmst.appmstregno,pinmst.pinno as PinSerial_No,pinmst.regno,pinmst.activedate,pinmst.isactivate as IsActivate,pinmst.activedate as Active_Date from pinmst,appmst where pinmst.regno=appmst.appmstregno and isactivate=1 and paidappmstid=1 and pinmst.activedate > '" + strdate1 + "' and pinmst.activedate < '" + strdate + "' order by appmst.appmstregno ", con);
        DataSet ds = new DataSet();
        adp.Fill(ds);
        dgrd.DataSource = ds;
        dgrd.DataBind();
        con.Close();
    }
 
    protected void dgrd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        StartIndex = e.NewPageIndex * dgrd.PageSize;
        dgrd.PageIndex = e.NewPageIndex;
        databind();

    }
   
}
