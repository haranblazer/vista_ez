using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


public partial class admin_TopperRewards : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void bindgrid()
    {

        con = new SqlConnection(method.str);
        SqlDataAdapter ad = new SqlDataAdapter("select a.AppMstFName,a.AppMstRegNo,a.sponsorid,convert(varchar(50),t.Doe,103) as doe,t.topper, Achieved from UserRewardmst t,AppMst a where a.appmstid=t.userid and t.rewardname=@rw", con);
            
        ad.SelectCommand.Parameters.AddWithValue("@rw",ddlawardtype.SelectedItem.Text);
        dt = new DataTable();
        ad.Fill(dt);

        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
            GridView1.EmptyDataText = "No Data Found";
        }
    }
    protected void ddlawardtype_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindgrid();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindgrid();
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       
            if (e.CommandName == "Total")
            {           

             Response.Redirect("TopperRewardDetail.aspx?id=" + obj.base64Encode(e.CommandArgument.ToString()));
            }
        
    }
}