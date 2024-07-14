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
public partial class user_PaidListing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string str5;
        str5 = Convert.ToString(Session["userId"]);
        if (str5 == "")
            Response.Redirect("loginagain.aspx");
        if (!IsPostBack)
        {
            finddata();

        }
        
    }
    private void finddata()
    {
        string str;
        str = Session["userId"].ToString();
        int left = 0, right = 0;
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("select distinct (select count(*) from appmst where sponsorid='"+ str+"') as sponsor,(select count(*) from appmst where sponsorid='"+str+"' and appmstpaid=1) as paid from appmst", con);
        SqlDataReader dr;
        con.Open();
        dr = com.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();            
            //left = Convert.ToInt32(dr["PaidheadLeft"]);
            //right = Convert.ToInt32(dr["PaidheadRight"]);
            //left = left + right;
            HyperLink5.Text = dr["paid"].ToString();
            HyperLink5.NavigateUrl = "Paidmembers.aspx";
            HyperLink6.Text = dr["sponsor"].ToString();
            HyperLink6.NavigateUrl = "totalsponsor.aspx";
          
        }
    }  
   
}
