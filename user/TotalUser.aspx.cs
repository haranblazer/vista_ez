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

public partial class user_TotalUser : System.Web.UI.Page
{

    SqlConnection con = null;
    SqlCommand com=null;
    SqlDataAdapter da=null;
    DataTable dt = null;
    string type = null;
    utility u = new utility();
   
  
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["userId"] == null || Request.QueryString["t"] == null)
        {
            Response.Redirect("~/Default.aspx", true);
        }

        else   
        {
            if (!IsPostBack)
            {

                binddata(u.base64Decode(Request.QueryString["t"].ToString()), u.base64Decode(Request.QueryString["p"].ToString()));
            }
        }
    }

    public void binddata(string value1,string value2)
    {
        dt = new DataTable();
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("userlist", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@regno",Session["userId"].ToString());
        da.SelectCommand.Parameters.AddWithValue("@t",Convert.ToInt32(value1));
        da.SelectCommand.Parameters.AddWithValue("@p", Convert.ToInt32(value2));
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            //if (value == "0")
            //lbltotal.Text = "Total Left " + Convert.ToString(dt.Rows.Count);
            //else
            //lbltotal.Text = "Total Right " + Convert.ToString(dt.Rows.Count);
         
            dglst.DataSource = dt;
            dglst.DataBind();

        }

        else
        {

            //if (value == "0")
            //    lbltotal.Text = "Total Left 0";
            //else
            //    lbltotal.Text = "Total Right 0 ";
            dglst.DataSource = null;
            dglst.DataBind();
        }
    }

    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        dglst.PageIndex = e.NewPageIndex;
        binddata(u.base64Decode(Request.QueryString["t"].ToString()), u.base64Decode(Request.QueryString["p"].ToString()));
    }
}