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
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.Text.RegularExpressions;


public partial class Admin_incomeDetail : System.Web.UI.Page
{
    SqlDataAdapter da;
    SqlConnection con = new SqlConnection(method.str);
   // utility u = new utility();
    utility objUtil = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetAllowResponseInBrowserHistory(true);
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminlogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!IsPostBack)
        {
            Bindgrid();
          
        }
    }
    protected void Bindgrid()
    {
        da = new SqlDataAdapter("getincome", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@userid",txtuserid.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@type", rdolist.SelectedValue.ToString());
        DataTable dt=new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            if (rdolist.SelectedValue == "0")
            {
                Gridreward.DataSource = dt;
                Gridreward.DataBind();
                Gridpayout.Visible = false;
                Gridreward.Visible = true;


            }
            else
            {
                Gridpayout.DataSource = dt;
                Gridpayout.DataBind();
                Gridreward.Visible = false;
                Gridpayout.Visible = true;


            }
        }

        else
        {
            Gridreward.DataSource = null;
            Gridreward.DataBind();
            Gridpayout.DataSource = null;
            Gridpayout.DataBind();
        
        }
       
    }

    
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
       Bindgrid();
    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    protected void rdolist_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void Gridpayout_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "Page")
        {
            GridViewRow row = Gridpayout.Rows[Convert.ToInt32(e.CommandArgument)];
            string payoutno = Gridpayout.DataKeys[row.RowIndex].Values[0].ToString();
            string regno = Gridpayout.DataKeys[row.RowIndex].Values[1].ToString();
            Session["payoutno"] = payoutno;
            Response.Redirect("adminpaymentreport.aspx?n=" + objUtil.base64Encode(payoutno) + "&id=" + objUtil.base64Encode(regno));
        }
    }
}