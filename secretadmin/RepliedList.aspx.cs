using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class admin_RepliedList : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataAdapter sda;
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

                GetReplyGrievance();
            }
        }
        catch
        {

        }

        

    }
    public void GetReplyGrievance()
    {
        try
        {
            cmd = new SqlCommand("GetReplyGrievance", con);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView2.DataSource = dt;
                GridView2.DataBind();
            }
            else
            {
                GridView2.DataSource = null;
                GridView2.DataBind();
            }
        }
        catch
        {

        }
    }

    protected bool SetVisibility(object desc, int maxLength)
    {
        var cmplnt = (string)desc;
        if (string.IsNullOrEmpty(cmplnt)) { return false; }
        return cmplnt.Length > maxLength;
    }

    protected void ReadRmrkGrvnMorelnkbtn_Click(object sender, EventArgs e)
    {
        LinkButton button = (LinkButton)sender;
        GridViewRow row = button.NamingContainer as GridViewRow;
        Label cmpltlbl = row.FindControl("lblremarkgrvnCmplnt") as Label;
        button.Text = (button.Text == "Read More") ? "Hide" : "Read More";
        string temp = cmpltlbl.Text;
        cmpltlbl.Text = cmpltlbl.ToolTip;
        cmpltlbl.ToolTip = temp;
    }


    protected void ReadReplyGrvnMorelnkbtn_Click(object sender,EventArgs e)
    {
        LinkButton button = (LinkButton)sender;
        GridViewRow row = button.NamingContainer as GridViewRow;
        Label cmpltlbl = row.FindControl("lblRplidCmplnt") as Label;
        button.Text = (button.Text == "Read More") ? "Hide" : "Read More";
        string temp = cmpltlbl.Text;
        cmpltlbl.Text = cmpltlbl.ToolTip;
        cmpltlbl.ToolTip = temp;
    }

    
    protected void ReadRplyMorelnkbtn_Click(object sender, EventArgs e)
    {
        LinkButton button = (LinkButton)sender;
        GridViewRow row = button.NamingContainer as GridViewRow;
        Label cmpltlbl = row.FindControl("lblrplyCmplnt") as Label;
        button.Text = (button.Text == "Read More") ? "Hide" : "Read More";
        string temp = cmpltlbl.Text;
        cmpltlbl.Text = cmpltlbl.ToolTip;
        cmpltlbl.ToolTip = temp;
    }

    protected string Limit(object cmpl, int maxLength)
    {
        var lblcmplnt = (string)cmpl;
        if (string.IsNullOrEmpty(lblcmplnt)) { return lblcmplnt; }
        return lblcmplnt.Length <= maxLength ?
            lblcmplnt : lblcmplnt.Substring(0, maxLength) + "...";
    }

}