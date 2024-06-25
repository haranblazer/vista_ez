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

public partial class user_Dwallet : System.Web.UI.Page
{
    DataTable dt = new DataTable();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    utility u = new utility();
    SqlDataReader dr;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Logout.aspx");
        }


        else
        {
            if (!IsPostBack)
            {
                lblusername.Text = Session["userlogin"].ToString();
                lblcname.Text = Session["cname"].ToString();
                lbllasttime.Text = Session["lastlogin"].ToString();
                lbljointime.Text = Session["UserDoj"].ToString();
                Bind();
                month();
                BindData();
            }

        }
    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        Bind();
    }


    public void Bind()
    {

        try
        {
            da = new SqlDataAdapter("Dwallet", con);
            con.Open();
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@regno", Session["franchiseid"].ToString());
            da.SelectCommand.Parameters.AddWithValue("@month", ddlmonth.SelectedItem.Text == "Select" ? "Select" : ddlmonth.SelectedItem.Text);
            da.SelectCommand.Parameters.AddWithValue("@year", ddlyear.SelectedItem.Text == "Select" ? "Select" : ddlyear.SelectedItem.Text);
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                dglst.DataSource = dt;
                dglst.DataBind();
            }

            else
            {
                dglst.DataSource = null;
                dglst.DataBind();
            }

            con.Close();

        }
        catch (Exception ex)
        {
            Response.Redirect("../default.aspx");
        }

    }


    public void month()
    {
        com = new SqlCommand("userdetail", con);

        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", Session["franchiseid"].ToString());


        con.Open();
        dr = com.ExecuteReader();
        while (dr.Read())
        {
            ddlmonth.Items.Add(dr["monthname"].ToString());


        }
        dr.Close();
        con.Close();
    }


    public void BindData()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("DWalletInfo", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", Session["franchiseid"].ToString());
        try
        {
            con.Open();
            SqlDataReader dr = com.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                lblewallet.Text = dr["balance"].ToString();
            }
            else
            {
                lblewallet.Text = "0";
            }
            con.Close();
            con.Dispose();
        }
        catch
        {
            con.Close();
            con.Dispose();
            Response.Redirect("~/Error.aspx", false);
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Bind();
    }
}