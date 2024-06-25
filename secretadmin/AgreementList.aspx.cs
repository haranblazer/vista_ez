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
public partial class admin_AgreementList : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable t = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


            go();


        }

    }

    public void go()
    {


        cmd = new SqlCommand("select userid,agreementno,convert(varchar(20),doa,103) as doa  from agreement", con);

        da = new SqlDataAdapter(cmd);
        da.Fill(t);
        Label2.Text = "No Of Records Found:" + t.Rows.Count.ToString();
        if (t.Rows.Count > 0)
        {

            GridView1.DataSource = t;
            GridView1.DataBind();

        }
        else
        {

            lbl.Text = "No data Found !";
        }


    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        go();
    }
    public void search()
    {



        if ((txtFDD.Text != "") && (txtFMM.Text != "") && (txtFYYYY.Text != "") && (txtTDD.Text != "") && (txtTMM.Text != "") && (txtTYYYY.Text != ""))
        {
            string strmin = txtFMM.Text + "/" + txtFDD.Text + "/" + txtFYYYY.Text;
            string strmax = txtTMM.Text + "/" + txtTDD.Text + "/" + txtTYYYY.Text;


            GridView1.Visible = true;
            Label1.Text = "";
            cmd = new SqlCommand("select userid,agreementno,convert(varchar(20),doa,103) as doa  from agreement where CAST(FLOOR(CAST(doa as float)) as datetime) between '" + strmin + "' and '" + strmax + "'", con);

            da = new SqlDataAdapter(cmd);
            da.Fill(t);


            Label2.Text = "No Of Records Found:" + t.Rows.Count.ToString();
            if (t.Rows.Count > 0)
            {
                GridView1.DataSource = t;
                GridView1.DataBind();
            }
            else
            {
                Label1.Text = "No Data Found !";
                GridView1.Visible = false;
            }
            con.Close();

        }
        else if (txtUserId.Text != "")
        {
            GridView1.Visible = true;
            Label1.Text = "";

            cmd = new SqlCommand("select userid,agreementno,convert(varchar(20),doa,103) as doa  from agreement where userid='" + txtUserId.Text + "' ", con);

            da = new SqlDataAdapter(cmd);
            da.Fill(t);
            Label2.Text = "No Of Records Found:" + t.Rows.Count.ToString();
            if (t.Rows.Count > 0)
            {
                GridView1.DataSource = t;
                GridView1.DataBind();
            }
            else
            {
                Label1.Text = "No Data Found !";
                GridView1.Visible = false;
            }
            con.Close();

        }
        else if (txtAgreementno.Text != "")
        {
            GridView1.Visible = true;
            Label1.Text = "";
            cmd = new SqlCommand("select userid,agreementno,convert(varchar(20),doa,103) as doa  from agreement where agreementno='" + txtAgreementno.Text + "' ", con);

            da = new SqlDataAdapter(cmd);
            da.Fill(t);
            Label2.Text = "No Of Records Found:" + t.Rows.Count.ToString();
            if (t.Rows.Count > 0)
            {

                GridView1.DataSource = t;
                GridView1.DataBind();
            }
            else
            {
                Label1.Text = "No Data Found !";
                GridView1.Visible = false;
            }
            con.Close();
        }
     
        else
        {
            Label1.Text = "No Data Found !";
            GridView1.Visible = false;
        }
        con.Close();
    }




    protected void Button1_Click(object sender, EventArgs e)
    {
        search();
    }
    protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        if ((txtFDD.Text != "") || (txtFMM.Text != "") || (txtFYYYY.Text != "") || (txtTDD.Text != "") || (txtTMM.Text != "") || (txtTYYYY.Text != "") || (txtUserId.Text != "") || (txtAgreementno.Text != "") )
        {
            search();
        }
        else
        {
            go();
        }




    }
}
