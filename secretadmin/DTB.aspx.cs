using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;

public partial class admin_DTB : System.Web.UI.Page
{
    DataTable dt = new DataTable();
    SqlConnection con = new SqlConnection(method.str);

    SqlDataAdapter da;
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
            BindGrid();

        }

    }
    private void BindGrid()
    {
        try
        {

            con = new SqlConnection(method.str);
            SqlDataAdapter ad = new SqlDataAdapter("select (Select AppmstRegNo from appmst where appmstid=c.Userid)as userId,(Select AppmstTitle+space(1)+AppmstFname from appmst where appmstid=c.Userid)as Name,(Select AppmstRegNo from appmst where appmstid=c.causeid)as Causeid,'DYNAMIC TEAM BONUS'as DTB,Amount,Effectdate from causeid C inner join Appmst A on A.Appmstid=C.Userid order by userid  ", con);

            dt = new DataTable();
            ad.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GrdView.DataSource = dt;
                GrdView.DataBind();
            }
            else
            {
                GrdView.DataSource = null;
                GrdView.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }
}