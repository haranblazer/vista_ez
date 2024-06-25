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

public partial class admin_growthIncome : System.Web.UI.Page
{
    int i, i1;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataReader dr;
    SqlDataAdapter adp; 
     int a=1;
    int b;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        dgd123.CurrentPageIndex = 0;
        Label1.Visible = false;
        
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        
        if (RadioButton2.Checked)
        {
            dgd123.DataSource = null;
            selectsponsergrowthlist();
          
        }
        else if (RadioButton1.Checked)
        {
            dgd123.DataSource = null;
            growthlist();
        }      
    }

    private void selectsponsergrowthlist()
    {
        
            dgd123.Visible = true;
            adp = new SqlDataAdapter("ShowClosingIncomList", con);
            adp.SelectCommand.CommandType = CommandType.StoredProcedure;
           ;

            adp.SelectCommand.Parameters.Add("@closingno", SqlDbType.Int).Value = txtColsingNo.Text;
            
            DataSet ds = new DataSet();
            adp.Fill(ds);
            dgd123.DataSource = ds;
            dgd123.DataBind();
            con.Close();
       
    }
    private void growthlist()
    {
        //if (Convert.ToInt32(txtColsingNo.Text) == 1)
        //{
          //  Label1.Text = "Record not found!";
            //Label1.Visible = true;
            //dgd123.Visible = false;
        //}
        //else
        //{
            dgd123.Visible = true;
            adp = new SqlDataAdapter("ShowGrowthIncomList", con);
            adp.SelectCommand.CommandType = CommandType.StoredProcedure;
            int rnk = Convert.ToInt32(txtColsingNo.Text);
            adp.SelectCommand.Parameters.Add("@closingno", SqlDbType.Int).Value =rnk;
            
            DataSet ds = new DataSet();
            adp.Fill(ds);

            dgd123.DataSource = ds;
            dgd123.DataBind();
            con.Close();
        //}
    }
    protected void dgd123_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        if (RadioButton2.Checked)
        {
            int i= e.NewPageIndex * 0;
            dgd123.CurrentPageIndex = e.NewPageIndex;
            selectsponsergrowthlist();
        }
        else if (RadioButton1.Checked)
        {
            dgd123.CurrentPageIndex = e.NewPageIndex * 0;
            dgd123.CurrentPageIndex = e.NewPageIndex;
            growthlist();
        }
        
    }
}
