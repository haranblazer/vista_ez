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
public partial class rewardrequestlist : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        Label1.Visible = false;
        if (!Page.IsPostBack)
        {

            bind();

        }

    }
    public void bind()
    {
        try
        {
            con.Close();
            SqlCommand com = new SqlCommand("Select a.AppMstRegNo,b.appmstfname,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12 from RewardRequest a,appmst b where a.appmstregno=b.appmstregno", con);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count <= 0)
            {

                Label1.Text = "No data Exist";
                Label1.Visible = true;
                GridView1.Visible = false;
            }
            else
            {
                Label1.Visible = false;
                GridView1.Visible = true;
                GridView1.DataSource = ds;
                GridView1.DataBind();
                con.Close();

            }

        }
        catch (Exception ex)
        { }

    }
    protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
}

