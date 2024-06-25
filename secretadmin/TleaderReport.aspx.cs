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
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Text.RegularExpressions;

public partial class admin_TleaderReport : System.Web.UI.Page
{
    DataTable t1 = new DataTable();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da=null;
    utility u = new utility();
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

        if (!IsPostBack)
        {
           
            go();
            ddl_list();

        }
    }

    public void go()
    {
        try
        {

            //System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            //dateInfo.ShortDatePattern = "dd/MM/yyyy";
            //DateTime fromDate = new DateTime();
            //DateTime toDate = new DateTime();
            da = new SqlDataAdapter("leaderdetail", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@action","show");
            da.SelectCommand.Parameters.AddWithValue("@value",ddllist.SelectedValue.ToString()==""?"":ddllist.SelectedValue.ToString());
            DataTable t = new DataTable();

            da.Fill(t);

            if (t.Rows.Count > 0)
            {
                //Label2.Text = "No of Records :" + t.Rows.Count.ToString();
                dglst.DataSource = t;
                dglst.DataBind();

            }
            else
            {
                dglst.DataSource = null;
                dglst.DataBind();
            }

           
        }
        catch
        {
        }

    }


    public void ddl_list()
    {
        da = new SqlDataAdapter("leaderdetail", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@action", "bind_ddl");
        da.SelectCommand.Parameters.AddWithValue("@value", "");
        DataTable ddl_list = new DataTable();
        da.Fill(ddl_list);
        ddllist.DataTextField = "appmstrank";
        ddllist.DataValueField = "tlper";
        ddllist.DataSource = ddl_list;
        ddllist.DataBind();
        //ddllist.Items.Insert(0, new System.Web.UI.WebControls.ListItem("select", "0"));


       

    }


    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        dglst.PageIndex = e.NewPageIndex;
        go();

    }
    protected void ddllist_SelectedIndexChanged(object sender, EventArgs e)
    {
        go();

    }



}