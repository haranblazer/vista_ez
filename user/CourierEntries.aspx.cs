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
using System.Text.RegularExpressions;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Collections.Generic;
public partial class User_CourierEntries : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable t = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        if (!IsPostBack)
        {
            go();
        }

    }
    public void go()
    {
        try
        {

            cmd = new SqlCommand("Usergetcourier", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", Session["userId"].ToString());
            da = new SqlDataAdapter(cmd);
            da.Fill(t);
            if (t.Rows.Count > 0)
            {
                Label2.Text = "No Of Records :" + t.Rows.Count.ToString();
                GridView1.DataSource = t;
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

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        go();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        go();

    }

    protected void imgbtnExcel_Click(object sender, EventArgs e)
    {

        try
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                go();
                Response.Clear();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Courierlist.xls");
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter stringWrite = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
                GridView1.RenderControl(htmlWrite);
                Response.Write(stringWrite.ToString());
                Response.End();
            }
            else
            {
                utility.MessageBox(this, "Can't export as no data found.");
            }
        }
        catch
        {

        }
    }
    protected void imgbtnWord_Click(object sender, EventArgs e)
    {

        try
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                go();
                Response.Clear();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Courierlist.doc");
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = "application/vnd.ms-word";
                System.IO.StringWriter stringWrite = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
                GridView1.RenderControl(htmlWrite);
                Response.Write(stringWrite.ToString());
                Response.End();
            }
            else
            {
                utility.MessageBox(this, "Can't export as no data found.");
            }
        }
        catch
        {

        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        int rowindex = Convert.ToInt32(e.CommandArgument);
        string cartid = GridView1.DataKeys[rowindex].Values[0].ToString();
        //GridViewRow row = ((Button)sender).NamingContainer as GridViewRow;

        //Button btnC = (Button)row.FindControl("Button2");

        if (e.CommandName == "S")
        {

            con = new SqlConnection(method.str);
            cmd = new SqlCommand("courierUpdate", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@cartid", cartid);
            cmd.Parameters.AddWithValue("@type", 1);
            con.Open();
            int c=cmd.ExecuteNonQuery();
            con.Close();
            if (c > 0)
            {
                utility.MessageBox(this, "Courier Received Successfully");
              //  btnC.Text = "Received";
            }
          
        }

        go();


    }

}
