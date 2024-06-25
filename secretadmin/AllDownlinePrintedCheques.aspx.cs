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
public partial class admin_AllDownlinePrintedCheques : System.Web.UI.Page
{
    string regno;
    string payoutno;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if (!IsPostBack)
        {
            fetchdata();
        }
    }
    private void fetchdata()
    {


        SqlDataAdapter adp = new SqlDataAdapter("select srno,regno,paymenttodate,name,amount,payoutno,parentid from downlineprintedcheque ", con);

        con.Open();

        DataSet ds = new DataSet();
        adp.Fill(ds);

        if (ds.Tables[0].Rows.Count > 0)
        {
            dgr.DataSource = ds;
            dgr.DataBind();
            Label1.Visible = false;

        }
        else
        {
            dgr.Visible = false;
            Label1.Visible = true;

            Label1.Text = "Record not Found!";

        }
        con.Close();
    }
    protected void dgr_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dgr.PageIndex = e.NewPageIndex;
        fetchdata();
    }
    protected void checkme(object sender, EventArgs e)
    {

        int j;

        for (j = 0; j < dgr.Rows.Count; j++)
        {
            if (((CheckBox)(dgr.HeaderRow.Cells[9].FindControl("chk1"))).Checked == true)
            {
                ((CheckBox)(dgr.Rows[j].Cells[9].FindControl("chk2"))).Checked = true;


            }
            else
            {
                ((CheckBox)(dgr.Rows[j].Cells[9].FindControl("chk2"))).Checked = false;

            }

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        bool chk = false;
        foreach (GridViewRow gr in dgr.Rows)
        {
            CheckBox Chqchkbox = (CheckBox)gr.FindControl("chk2");
            if (Chqchkbox.Checked)
            {
                chk = true;

                string srno = gr.Cells[1].Text;

                com = new SqlCommand("delete from downlineprintedcheque where srno='" + srno + "' ", con);
                con.Open();
                com.ExecuteNonQuery();
                con.Close();



                fetchdata();
                Label1.Text = " Successfull!";
            }
        }
    }
}
