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
public partial class admin_growthIncomeResult : System.Web.UI.Page
{
    int i, i1;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataReader dr;
    SqlDataAdapter adp;
    int a = 1;
    int b;
    string txtclosingno;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        txtclosingno = Convert.ToString(Session["ColsingNo"]);
        if (Convert.ToString(Session["rbtn2"]) == "RadioButton2")
        {
            dgd123.DataSource = null;
            selectsponsergrowthlist();

        }
        else if (Convert.ToString(Session["rbtn1"]) == "RadioButton1")
        {
            dgd123.DataSource = null;
            growthlist();
        }      
    }
    private void selectsponsergrowthlist()
    {

        dgd123.Visible = true;
        adp = new SqlDataAdapter("ShowClosingIncomList", con);
        adp.SelectCommand.CommandType = CommandType.StoredProcedure;


        adp.SelectCommand.Parameters.Add("@closingno", SqlDbType.Int).Value = txtclosingno;

        DataSet ds = new DataSet();
        adp.Fill(ds);
        dgd123.DataSource = ds;
        dgd123.DataBind();
        con.Close();

    }
    private void growthlist()
    {

        dgd123.Visible = true;
        adp = new SqlDataAdapter("ShowGrowthIncomList", con);
        adp.SelectCommand.CommandType = CommandType.StoredProcedure;
        int rnk = Convert.ToInt32(txtclosingno);
        adp.SelectCommand.Parameters.Add("@closingno", SqlDbType.Int).Value = rnk;

        DataSet ds = new DataSet();
        adp.Fill(ds);

        dgd123.DataSource = ds;
        dgd123.DataBind();
        con.Close();
        
    }
    protected void dgd123_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        if (Convert.ToString(Session["rbtn2"]) == "RadioButton2")
        {
            int i = e.NewPageIndex * 0;
            dgd123.CurrentPageIndex = e.NewPageIndex;
            selectsponsergrowthlist();
        }
        else if (Convert.ToString(Session["rbtn1"]) != null)
        {
            dgd123.CurrentPageIndex = e.NewPageIndex * 0;
            dgd123.CurrentPageIndex = e.NewPageIndex;
            growthlist();
        }

    }
}
