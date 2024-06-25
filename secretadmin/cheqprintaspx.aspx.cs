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


public partial class admin_cheqprintaspx : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    int closings;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if (IsPostBack)
            btnprint.Visible = true;
        if (!IsPostBack)
        {
            GridView1.Visible = false;
            btnprint.Visible = false;    
        }
        else
        {
            string s = Convert.ToString(DropDownList1.SelectedValue);
            closings = Convert.ToInt32(s);
            selectdata(closings);
        }
       }
    private void selectdata(int clos)
    {
        //cmd = new SqlCommand("select p.appmstid,p.dispachedamt,a.appmstfname,a.closing from PaymentTranDraft p inner join appmst a on p.appmstid=a.appmstregno and a.closing='" + closings + "'", con);
        SqlDataAdapter adp = new SqlDataAdapter("select p.appmstid,p.dispachedamt,a.appmstfname,p.paymenttrandraftid from PaymentTranDraft p , appmst a where p.appmstid=a.appmstregno and p.paymenttrandraftid='" + closings + "'", con);
        con.Open();

        DataSet ds = new DataSet();
        adp.Fill(ds);
        //dr = cmd.ExecuteReader();
        if (ds.Tables[0].Rows.Count>0)
        {
            GridView1.DataSource = ds;
            GridView1.DataBind();
            Label1.Visible = false;
            btnprint.Visible = true;
        }
        else
        {
            GridView1.Visible = false;
            Label1.Visible = true;
            Label1.Text = "Record not Found";
            btnprint.Visible = false;
        }
        con.Close();
    }
    

    
    protected void btnprint_Click(object sender, EventArgs e)
    {
        Response.Redirect("printchq.aspx?c="+closings);
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string s = Convert.ToString(DropDownList1.SelectedItem.Text);
        closings = Convert.ToInt32(s);
        GridView1.Visible = true;
        closings = Convert.ToInt32(DropDownList1.SelectedValue);
        selectdata(closings);
    }
    
   
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView1.Visible = true;
        closings = Convert.ToInt32(DropDownList1.SelectedValue);
        selectdata(closings);
    }
}
