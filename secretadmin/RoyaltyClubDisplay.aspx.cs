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
public partial class Keyadmin_GoldenSalaryIncome : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);

    SqlDataAdapter da;
    protected void Page_Load(object sender, EventArgs e)
    {
        //InsertFunction.CheckAdminlogin();
        if (!IsPostBack)
         {
            DateTime d = System.DateTime.Now;

            DateTime d1 = d.AddDays(-15);

            TextBox1.Text = d1.Day.ToString();
            TextBox2.Text = d1.Month.ToString();
            TextBox3.Text = d1.Year.ToString();
            TextBox4.Text = d.Day.ToString();
            TextBox5.Text = d.Month.ToString();
            TextBox6.Text = d.Year.ToString();
            go("Active");

        }

    }

    public void go(string Expression)
    {
        txtUserId.Text = "";
        string strmin = TextBox2.Text + "/" + TextBox1.Text + "/" + TextBox3.Text;
        string strmax = TextBox5.Text + "/" + TextBox4.Text + "/" + TextBox6.Text;

        da = new SqlDataAdapter("RoyaltyIncome", con);
        da.SelectCommand.CommandTimeout = 99999;
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@operation", "A");
        da.SelectCommand.Parameters.AddWithValue("@mindate", strmin);
        da.SelectCommand.Parameters.AddWithValue("@maxdate", strmax);
        DataSet ds = new DataSet();
        da.Fill(ds);
        if (ds.Tables [0].Rows.Count > 0)
        {
            Label1.Text = "";
            GridView1.PageSize = 50;
          DataView dr =ds.Tables [0].DefaultView;
         // dr.RowFilter = "iselegible='"+Expression+"'";
                GridView1.DataSource = dr;
                GridView1.DataBind();
                Label2.Text = "Total No Of Records:" + ds.Tables [0].Rows.Count.ToString();
        }
        else
        {
            Label1.Text = "No UnPaid Member Found!";
            GridView1.DataSource = null;
            GridView1.DataBind();

        }

    }
    public void bind()
    {
        da = new SqlDataAdapter("RoyaltyIncome", con);
        da.SelectCommand.CommandTimeout = 99999;
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@mindate", "");
        da.SelectCommand.Parameters.AddWithValue("@maxdate", "");
        da.SelectCommand.Parameters.AddWithValue("@operation", "U");

        da.SelectCommand.Parameters.AddWithValue("@regno ", txtUserId.Text.ToString());

        DataTable t = new DataTable();
        da.Fill(t);
        if (t.Rows.Count > 0)
        {

            Label1.Text = "";
            GridView1.DataSource = t;
            GridView1.DataBind();
            GridView1.PageSize = Convert.ToInt32(t.Rows.Count.ToString());
            Label2.Text = "Total No Of Records:" + t.Rows.Count.ToString();

        }
        else
        {
            Label1.Text = "No Data Found In The List !";
            GridView1.DataSource = null;
            GridView1.DataBind();

        }


    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        txtUserId.Text = "";
        GridView1.PageIndex = e.NewPageIndex;
        if (txtUserId.Text == "")
        {
            go("Active");
        }
        else
        {
            bind();
        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        chkUserId();
    }
    private void chkUserId()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("idCheck", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@userid", txtUserId.Text.ToString());
            con.Open();
            SqlDataReader dr;
            dr = com.ExecuteReader();
            if (dr.HasRows)
            {
                bind();
            }
            else
            {

                Label1.Text = "User Does Not Exsist!";
            }
        }
        catch (Exception ee)
        {
            string w = ee.ToString();
        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        go("aa");

    }
    }

