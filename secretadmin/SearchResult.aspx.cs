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

public partial class admin_SearchResult : System.Web.UI.Page
{
    utility u = new utility();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;

    string txtid;
    string txtuname;
    string txtfname;
    string txtlname;
    string txtcity;
    string txtstate;


    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        ArrayList searcharlst = ((ArrayList)(Session["searchtxtbx"]));
        for (int i = 0; i < searcharlst.Count; i++)
        {
            txtid = searcharlst[0].ToString();
            txtuname = searcharlst[1].ToString();
            txtfname = searcharlst[2].ToString();
            txtlname = searcharlst[3].ToString();
            txtcity = searcharlst[4].ToString();
            txtstate = searcharlst[5].ToString();
        }
        go1();
    }
    public void go1()
    {



        if (txtid != "")
        {
            dgr.Visible = true;
            Label1.Text = "";
            string str = "'" + "%" + txtid + "%" + "'";

            string strappmstreno = "appmstregno";
            DataTable t = u.search(strappmstreno, str);
            Label2.Text = t.Rows.Count.ToString();
            if (t.Rows.Count > 0)
            {
                dgr.DataSource = t;
                dgr.DataBind();
            }
            else
            {
                Label1.Text = "No Data Found";
                dgr.Visible = false;
            }
            con.Close();

        }
        else if (txtuname != "")
        {
            dgr.Visible = true;
            Label1.Text = "";

            string str = "'" + "%" + txtuname + "%" + "'";

            string strappmstreno = "AppMstFName";
            DataTable t = u.search(strappmstreno, str);
            Label2.Text = t.Rows.Count.ToString();
            if (t.Rows.Count > 0)
            {
                dgr.DataSource = t;
                dgr.DataBind();
            }
            else
            {
                Label1.Text = "No Data Found";
                dgr.Visible = false;
            }
            con.Close();

        }
        else if (txtfname != "")
        {
            dgr.Visible = true;
            Label1.Text = "";
            string str = "'" + "%" + txtfname + "%" + "'";

            string strappmstreno = "AppMstFName";
            DataTable t = u.search(strappmstreno, str);
            Label2.Text = t.Rows.Count.ToString();
            if (t.Rows.Count > 0)
            {

                dgr.DataSource = t;
                dgr.DataBind();
            }
            else
            {
                Label1.Text = "No Data Found";
                dgr.Visible = false;
            }
            con.Close();
        }
        else if (txtlname != "")
        {
            dgr.Visible = true;
            Label1.Text = "";

            string str = "'" + "%" + txtlname + "%" + "'";

            string strappmstreno = "AppMstLName";
            DataTable t = u.search(strappmstreno, str);
            Label2.Text = t.Rows.Count.ToString();
            if (t.Rows.Count > 0)
            {
                dgr.DataSource = t;
                dgr.DataBind();
            }
            else
            {
                Label1.Text = "No Data Found";
                dgr.Visible = false;
            }
            con.Close();
        }
        else if (txtcity != "")
        {
            dgr.Visible = true;
            Label1.Text = "";
            string str = "'" + "%" + txtcity + "%" + "'";

            string strappmstreno = "AppMstCity ";
            DataTable t = u.search(strappmstreno, str);
            Label2.Text = t.Rows.Count.ToString();
            if (t.Rows.Count > 0)
            {
                dgr.DataSource = t;
                dgr.DataBind();
            }
            else
            {
                Label1.Text = "No Data Found";
                dgr.Visible = false;
            }
            con.Close();
        }
        else if (txtstate != "")
        {
            dgr.Visible = true;
            Label1.Text = "";
            string str = "'" + "%" + txtstate + "%" + "'";

            string strappmstreno = "AppMstState";
            DataTable t = u.search(strappmstreno, str);
            Label2.Text = t.Rows.Count.ToString();
            if (t.Rows.Count > 0)
            {
                dgr.DataSource = t;
                dgr.DataBind();
            }
            else
            {
                Label1.Text = "No Data Found";
                dgr.Visible = false;
            }
            con.Close();
        }
    }
    protected void dgr_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        dgr.CurrentPageIndex = e.NewPageIndex;
        go1();
    }
}
