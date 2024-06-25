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
public partial class admin_DeselectGrowthList : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if(!Page.IsPostBack)
        Label4.Visible = false;
    Label1.Visible = false;
    }
    public void bind()
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("select userid,FName,ClosingNo,SId,joinfor from GrowthList where ClosingNo=" + TextBox2.Text, con);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            con.Open();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                GridView1.Visible = true;
                GridView1.DataSource = ds;
                GridView1.DataBind();
                
            }
            else
            {
                GridView1.Visible = false;
                Label1.Visible = true;
                Label1.Text= "No Data Found";
            }
            con.Close();
        }
        catch { }


    }
    public void ClosingCount()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("CalculateClosingCount", con);
            com.Parameters.AddWithValue("@ClosingNo", TextBox2.Text);
            com.Parameters.AddWithValue("@cno", SqlDbType.VarChar).Direction = ParameterDirection.Output;
            com.CommandType = CommandType.StoredProcedure;
            con.Open();
            com.ExecuteNonQuery();
            int cno = int.Parse(com.Parameters["@cno"].Value.ToString());
            Label4.Visible = true;
            Label4.Text = "Total users in closing " + TextBox2.Text + " =" + cno;
        }
        catch { }
    }
    protected void Button2_Click1(object sender, EventArgs e)
    {
        bind();
        ClosingCount();
    }
    protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
    protected void TextBox2_TextChanged(object sender, EventArgs e)
    {

    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
