using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

public partial class secretadmin_CostReport : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand com=null;
    SqlDataReader sdr=null;
    SqlDataAdapter sda=null;
    DataTable dt = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getLastPayoutDate();
            bind();
        }

    }

    public void getLastPayoutDate()
    {
        con = new SqlConnection(method.str);
        sda = new SqlDataAdapter("allbpayout", con);
        sda.SelectCommand.CommandType = CommandType.StoredProcedure;
        dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlpayout.DataTextField = "payoutdate";
            ddlpayout.DataValueField = "PayoutNo";
            ddlpayout.DataSource = dt;
            ddlpayout.DataBind();

        }

        else
        {
            ddlpayout.Items.Insert(0, new ListItem("No Payout", "0"));
        }
    }
    protected void ddlpayout_SelectedIndexChanged(object sender, EventArgs e)
    {
        bind();
    }

    public void bind()
    {
        con = new SqlConnection(method.str);
        sda = new SqlDataAdapter("binaryreport", con);
        sda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sda.SelectCommand.Parameters.Add("@pno", ddlpayout.SelectedValue.ToString());
        dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            object a1, a2, a3, a4;
            //a1 = dt.AsEnumerable().Select(x => x.Field<double>("Sale")).Sum().ToString();
            //a2 = dt.AsEnumerable().Select(x => x.Field<double>("cost")).Sum().ToString();
            //a3 = dt.AsEnumerable().Select(x => x.Field<double>("payout")).Sum().ToString();
            //a4 = dt.AsEnumerable().Select(x => x.Field<double>("tax")).Sum().ToString();

            //lblnetprofit.Text = Convert.ToString(Convert.ToDouble(a1) -( Convert.ToDouble(a2) + Convert.ToDouble(a3) + Convert.ToDouble(a4)));
            GridView1.DataSource = dt;
            GridView1.DataBind();

        }

          

        else
        {
            
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       


        if (e.CommandName.Equals("c1"))
        {
            utility obj = new utility();
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            string min = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
            string max = GridView1.DataKeys[row.RowIndex].Values[1].ToString();

            Response.Redirect("Billreport.aspx?min=" + min + "&max=" + max + "&t=" + "1");

        }

        if (e.CommandName.Equals("c2"))
        {
            utility obj = new utility();
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            string min = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
            string max = GridView1.DataKeys[row.RowIndex].Values[1].ToString();

            Response.Redirect("Billreport.aspx?min=" + min + "&max=" + max + "&t=" + "1");

        }

        if (e.CommandName.Equals("c3"))
        {
            utility obj = new utility();
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            string min = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
            string max = GridView1.DataKeys[row.RowIndex].Values[1].ToString();

            Response.Redirect("payoutlist.aspx?pno=" + ddlpayout.SelectedValue.ToString() );
        }

        if (e.CommandName.Equals("c4"))
        {
            utility obj = new utility();
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            string min = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
            string max = GridView1.DataKeys[row.RowIndex].Values[1].ToString();

            Response.Redirect("payoutlist.aspx?pno=" + ddlpayout.SelectedValue.ToString());
        }
    }
}