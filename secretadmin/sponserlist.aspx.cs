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
public partial class admin_sponserlist : System.Web.UI.Page
{
    string sprocedure;
    int ln = 0, rn = 0;
    DataTable t1;
    SqlDataAdapter da;
   
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    DataTable tb1 = new DataTable();
    
    protected void Page_Load(object sender, EventArgs e)
    {

        InsertFunction.CheckAdminlogin();
        string str;
        str = Convert.ToString(Session["admin"]);
        if (str == "")
        {
            Response.Redirect("adminLog.aspx");
        }
        else
        {
            disp();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        disp();

    }
    public void disp()
    {
      

      
        if (RadioButton1.Checked)
        {
            sprocedure = "spwise1";
            select(sprocedure);
        }
        else if (RadioButton2.Checked)
        {
            sprocedure = "spwise2";
            select(sprocedure);
        }
        else if (RadioButton3.Checked)
        {
            sprocedure = "spwise3";
            select(sprocedure);
        }
        else if (RadioButton4.Checked)
        {
            sprocedure = "spwise4";
            select(sprocedure);
        }
        else if (RadioButton5.Checked)
        {
            sprocedure = "spwise5";
            select(sprocedure);
        }
      
    }
    
    public void select(string str1)
    {  datargd1.Visible = true;
        lbl.Text = "";

       
        com = new SqlCommand(str1, con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@sponsortotal", TextBox1.Text);
        da = new SqlDataAdapter(com);
        t1 = new DataTable();
        da.Fill(t1);

        TextBox2.Text = Convert.ToString(t1.Rows.Count);


        if (t1.Rows.Count > 0)
        {


            datargd1.DataSource = t1;
            datargd1.DataBind();

        }
        else
        {
            lbl.Text = "No Data Found!";
            datargd1.Visible = false;
        }
    }


    protected void datargd1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
       
        datargd1.PageIndex = e.NewPageIndex;
        disp();

    }

    
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        PrintHelper.PrintWebControl(Panel1);
    }
}