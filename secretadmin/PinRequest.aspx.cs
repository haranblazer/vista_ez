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
public partial class admin_PinRequest : System.Web.UI.Page
{
    DataTable t1 = new DataTable();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str;
        str = Convert.ToString(Session["admin"]);
        if (!IsPostBack)
        {
            if (str != "")
            {
               

                go();
            }
            else
            {
                Response.Redirect("adminLog.aspx");
            }

        }

    }
    public void go()
    {

        string qstr = "select srno,userid,JoiningAmount,PinAlloted,Description,convert(varchar(20),DOE,103) as DOE,Remark,Status=case Status when 0 then 'Pending' end from pinrequest where status=0";
            com = new SqlCommand(qstr, con);
            da = new SqlDataAdapter(com);
            DataTable t = new DataTable();
            da.Fill(t);
            dgr.DataSource = t;
            dgr.DataBind();

           
            if (t.Rows.Count > 0)
            {
                Label1.Text = "Total No Of Record :" + t.Rows.Count.ToString();
            }
            else
            {
                Label1.Text = "No Record Found!" ;

            }
            
          
        }

    protected void dgr_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dgr.PageIndex = e.NewPageIndex;
        go();
    }
    
}
