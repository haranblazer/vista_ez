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
public partial class admin_unpaidtopaid : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    SqlDataAdapter dr;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if (!IsPostBack)
        {
            bind();
            ddlitem();
        }
    }
    public void bind()
    {
     string qstr = "select * from appmst where appmstpaid='0'";
     da = new SqlDataAdapter(qstr,con);
     DataTable t = new DataTable();
     da.Fill(t);
     if (t.Rows.Count > 0)
     {
         Label5.Text = "";
         GridView1.DataSource = t;
         GridView1.DataBind();
     }
     else {
         GridView1.DataSource = null;
         GridView1.DataBind();
         Label5.Text = "No Unpaid Member! ";
          }
    }
    public DataTable ddlitem()
    {

        string qstr2 = "select productname from productdetails";
        com = new SqlCommand(qstr2,con);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        return t;
    }
    protected void Button2_Click1(object sender, EventArgs e)
    {

        string gvIDs = "";
        con.Open();
        foreach (GridViewRow gv in GridView1.Rows)
        { CheckBox ChkBxItem = (CheckBox)gv.FindControl("SelectChk");
            if (ChkBxItem.Checked)
            {
                gvIDs = ((Label)gv.FindControl("EmpID")).Text.ToString();
               com = new SqlCommand("sp_unpaidtopaid", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@downid", gvIDs);               
                com.ExecuteNonQuery();               
            }

        }
        con.Close();
        bind();
    }
    protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {

    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string  str = GridView1.FindControl("ddl").ToString(); ;
        Response.Write(str);
       
    }
    protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        string regno = GridView1.DataKeyNames.ToString();
        Response.Write(regno);
    }
}
