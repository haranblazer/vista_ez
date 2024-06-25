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
using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Text;

public partial class secretadmin_UserSalary : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    DataTable dt;

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


        if (!Page.IsPostBack)
        {

            BindHGrid();



        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
        bindgrid(e.CommandName, GridView1.DataKeys[row.RowIndex].Values[0].ToString());
        
    }


    public void BindHGrid()
    {
        try
        {

            com = new SqlCommand("usersalary", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@type", "1");
            da = new SqlDataAdapter(com);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();

            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();

            }
        }


        catch
        {
        }
        finally
        {



        }

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindHGrid();
        

       
    }

    public void bindgrid(string itype, string userid)
    {
        dt = null;
        com = new SqlCommand("usersalary", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@type", "2");
        com.Parameters.AddWithValue("@regno", userid);
        com.Parameters.AddWithValue("@income", itype);
        da = new SqlDataAdapter(com);
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            GridView2.DataSource = dt;
            GridView2.DataBind();
            this.ModalPopupExtender1.Show();
        }
        else
        {
            GridView2.DataSource = null;
            GridView2.DataBind();
            this.ModalPopupExtender1.Hide();
        }
    }
    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView2.PageIndex = e.NewPageIndex;
        this.ModalPopupExtender1.Show();
    }
}