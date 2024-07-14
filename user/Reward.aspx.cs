using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Drawing;
using System.Xml;



public partial class User_Reward : System.Web.UI.Page
{

    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    utility objutil;
    XmlDocument xmldoc = new XmlDocument();
    int srno = 0;
    string status = "";
    string monthname = "";
    string strsessionid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        strsessionid = Convert.ToString(Session["userId"]);

        // appid = Convert.ToString(Session["appmstid"]);
        if (strsessionid == "")
        {
            Response.Redirect("~/login.aspx");
        }

        if (!IsPostBack)
        {
            BindGrid();
        }
    }

    private void BindGrid()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter ad = new SqlDataAdapter("userreward1", con);
        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
        ad.SelectCommand.Parameters.AddWithValue("@reg", strsessionid);
        dt = new DataTable();
        ad.Fill(dt);

        if (dt.Rows.Count > 0)
        {
            Repeater1.DataSource = dt;
            Repeater1.DataBind();
        }
    }
}