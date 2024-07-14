using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FormDownload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            //        //lblcname.Text = Session["cname"].ToString();
            //        //lblusername.Text = Session["userlogin"].ToString();
            //        //lbllasttime.Text = Session["lastlogin"].ToString();
            //        //lbljointime.Text = Session["UserDoj"].ToString();

            BindGrid();
        }
    }
    public void BindGrid()
    {
        SqlParameter[] param = new SqlParameter[] { 
            //new SqlParameter("@DisplayType", "HOME")
            };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Title, FileName from DownloadMst where status=1 and DocType=2 and  DisplayType='All'");
        GridView1.DataSource = dt;
        GridView1.DataBind();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Dwn")
        {

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GridView1.Rows[index];
            string fName = row.Cells[2].Text;

            string path = Server.MapPath("images/downloads/") + fName;
            Response.ContentType = "application/octet-stream";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fName);
            Response.WriteFile(path);
            Response.Flush();
            Response.End();
        }
    }
}