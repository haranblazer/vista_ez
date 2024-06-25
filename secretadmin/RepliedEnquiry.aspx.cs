using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_RepliedEnquiry : System.Web.UI.Page
{
    SqlConnection con=new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");


            if (!IsPostBack)
            {
                GetRpliedEnq();

            }
        }
        catch
        {

        }




    }

    public void GetRpliedEnq()
    {
        try
        {
            cmd = new SqlCommand("GetRepliedEnq", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            da = new SqlDataAdapter(cmd);
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
            con.Close();
            cmd.Dispose();
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GetRpliedEnq();
    }
}