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
using System.Text.RegularExpressions;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Text;
public partial class admin_TopperDetail : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);

    SqlDataAdapter da;
    DataTable dt = new DataTable();
    string strsessionid;
    StringBuilder sb;
    string doe;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
        {
            Response.Redirect("adminlog.aspx");
        }



        if (!IsPostBack)
        {

        

            if (Request.QueryString["t"] != null)
            {
                doe = Request.QueryString["d"];
                go(Convert.ToInt32(Request.QueryString["t"]),"T",doe);
            }

            if (Request.QueryString["a"] != null)
            {
                doe = Request.QueryString["d"];
                go(Convert.ToInt32(Request.QueryString["a"]),"A",doe);
            }

        }
    }


    protected void dgList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        dgList.PageIndex = e.NewPageIndex;

        if (Request.QueryString["t"] != null)
        {
            doe = Request.QueryString["d"];
            go(Convert.ToInt32(Request.QueryString["a"]), "A", doe);
        }

        if (Request.QueryString["a"] != null)
        {
            doe = Request.QueryString["d"];
            go(Convert.ToInt32(Request.QueryString["a"]), "A", doe);
        }


    }

    protected void dgList_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void dgList_RowCreated(object sender, GridViewRowEventArgs e)
    {

    }

    public void go(int value, string type, string d)
    {
        try
        {
            da = new SqlDataAdapter("topperdetail", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@action", type);
            da.SelectCommand.Parameters.AddWithValue("@sno", value);

            da.SelectCommand.Parameters.AddWithValue("@doe",String.Format("{0:MM/dd/yyyy}",d.ToString()));

            con.Open();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                dgList.DataSource = dt;
                dgList.DataBind();

            }
            else
            {
                dgList.DataSource = null;
                dgList.DataBind();
                dgList.EmptyDataText = "No data Found";

            }
        }

        catch (Exception ex)
        {

        }


    }
}