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
public partial class admin_RewardDispatched : System.Web.UI.Page
{
    string AwardName;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataReader dr;
 
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        string str;
        str = Convert.ToString(Session["admin"]);

       
    }

    protected void btnsDispatch_Click(object sender, EventArgs e)
    {

        if (colourmobile.Checked)
        {
            AwardName = "Color Mobile";
            if (rbtnQualify.Checked)
            {
               
                qualify(AwardName,TextBox1.Text);
            }
            if (rbtnDispatch.Checked)
            {
                Dispatch(AwardName, TextBox1.Text);
            }
        }
        if (alto.Checked)
        {
            AwardName = "Maruti Alto";
            if (rbtnQualify.Checked)
            {
               
                qualify(AwardName, TextBox1.Text);
            }
            if (rbtnDispatch.Checked)
            {
                Dispatch(AwardName, TextBox1.Text);
            }
        }
        if (house.Checked)
        {
            AwardName = "House or Rs 15,00,000 Cash";
            if (rbtnQualify.Checked)
            {
               
                qualify(AwardName, TextBox1.Text);
            }
            if (rbtnDispatch.Checked)
            {
                Dispatch(AwardName, TextBox1.Text);
            }
        }
        if (bike.Checked)
        {
            AwardName = "Bike or Laptop";
            if (rbtnQualify.Checked)
            {
               
                qualify(AwardName, TextBox1.Text);
            }
            if (rbtnDispatch.Checked)
            {
                Dispatch(AwardName, TextBox1.Text);
            }
        }
       
        
        
    }


   
    
   
   

    public void qualify(string ql ,string id)
    {
        try
        {
            string q = "1";
            cmd = new SqlCommand("qualify", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", id);
            cmd.Parameters.AddWithValue("@award", ql);
            cmd.Parameters.AddWithValue("@status", q);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Label1.Text = "Successfull !";
        }
        catch (Exception e)
        {
            Label1.Text = e.Message;
        }
    }



    public void Dispatch(string dp, string id)
    {
        try
        {
            string d = "1";
            cmd = new SqlCommand("Dispatch", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", id);
            cmd.Parameters.AddWithValue("@award", dp);
            cmd.Parameters.AddWithValue("@status", d);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Label1.Text = "Successfull !";
        }
        catch (Exception e)
        {
            Label1.Text = e.Message;
        }
    }

    
}
