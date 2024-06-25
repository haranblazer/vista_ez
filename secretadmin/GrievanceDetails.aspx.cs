using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;

public partial class secretadmin_GrievanceDetails : System.Web.UI.Page
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
                GetGrievance();
            }
        }
        catch
        {

        }
       

    }

    public void GetGrievance()
    {
        try
        {
            cmd = new SqlCommand("GetGrievance", con);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
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

    protected void ReadGrvnMorelnkbtn_Click(object sender, EventArgs e)
    {
        LinkButton button = (LinkButton)sender;
        GridViewRow row = button.NamingContainer as GridViewRow;
        Label cmpltlbl = row.FindControl("lblgrvnCmplnt") as Label;
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

    protected void lnkReply_Click(object sender, EventArgs e)
    {
        GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;
        ViewState["id"] = gvrow.Cells[0].Text;
        Popup(true);

    }

    protected void btnRply_Click(object sender, EventArgs e)
    {
        try
        {
            cmd = new SqlCommand("ReplyGrievance", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@reply", txtReply.Text.Trim());
            cmd.Parameters.AddWithValue("@id", ViewState["id"].ToString());
            cmd.Parameters.AddWithValue("@status", 1);
            cmd.Parameters.AddWithValue("@replyDate", DateTime.UtcNow.AddMinutes(330));
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            utility.MessageBox(this, "Replied Successfully.");
            GetGrievance();
            


        }
        catch
        {

        }
    }

    void Popup(bool isDisplay)
    {
        StringBuilder builder = new StringBuilder();
        if (isDisplay)
        {
            builder.Append("<script language=JavaScript> ShowPopup(); </script>\n");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowPopup", builder.ToString());
        }
        else
        {
            builder.Append("<script language=JavaScript> HidePopup(); </script>\n");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "HidePopup", builder.ToString());
        }
    }

    
}