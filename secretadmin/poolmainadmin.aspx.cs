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

public partial class solaradmin_poolmainadmin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
     //   string str;
       // str = Session["admin"].ToString();
        //if (str == "")
        if (string.IsNullOrEmpty(Convert.ToString(Session["admin"])))
        Response.Redirect("adminLog.aspx");
    }
    protected void rbtn6_CheckedChanged(object sender, EventArgs e)
    {
        Response.Redirect("pooldisplayadmin.aspx?poolname=C5");
    }
    protected void rbtn4_CheckedChanged(object sender, EventArgs e)
    {
        Response.Redirect("pooldisplayadmin.aspx?poolname=C3");
    }
    protected void rbtn1_CheckedChanged(object sender, EventArgs e)
    {
        Response.Redirect("pooldisplayadmin.aspx?poolname=C0");
    }
    protected void  rbtn2_CheckedChanged(object sender, EventArgs e)
    {
        Response.Redirect("pooldisplayadmin.aspx?poolname=C1");
    }
    protected void  rbtn3_CheckedChanged(object sender, EventArgs e)
    {
        Response.Redirect("pooldisplayadmin.aspx?poolname=C2");
    }

    protected void rbtn5_CheckedChanged(object sender, EventArgs e)
    {
        Response.Redirect("pooldisplayadmin.aspx?poolname=C4");
    }
    protected void rbtn7_CheckedChanged(object sender, EventArgs e)
    {
        Response.Redirect("pooldisplayadmin.aspx?poolname=C6");
    }
}

