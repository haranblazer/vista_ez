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

public partial class admin_BulkIdSubmission : System.Web.UI.Page
{
    int cn = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com1 = new SqlCommand("select max(ClosingNo) from GrowthList where Closed=1", con);
        SqlDataReader dr;
        con.Open();
        dr = com1.ExecuteReader();
        dr.Read();
        int a = 0;
        if (dr[0].ToString() != "")
        {
            a = int.Parse(dr[0].ToString());
            cn = a + 1;
        }
        con.Close();
        if (!Page.IsPostBack)
        {
            Label1.Visible = false;
            Label2.Visible = false;
            Label2.Text = a + " Closing Done";
            
        }
    }
    
    protected void Button2_Click1(object sender, EventArgs e)
    {
         try
         {
             int s = int.Parse(TextBox1.Text);
             if ((s >= cn) && (s <= 12))
             {

            SqlConnection con = new SqlConnection(method.str);
            string msg="";
            string a = string.Empty;
            string id;
            a = TextBox2.Text;
            string[] UserId = a.Split(',');
            int hold = 0;
            for (int i = 0; i < UserId.Length; i++)
            {
                id = UserId[i].ToString();
              
                SqlCommand com = new SqlCommand("G_InsertGrowthList", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@id", id);
                com.Parameters.AddWithValue("@ClosingNo", TextBox1.Text);
                com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                hold = int.Parse(com.Parameters["@flag"].Value.ToString());
                con.Close();
                if (hold == 2)
                {
                    
                        if (msg == "")
                        {
                            msg = id.ToString();
                        }
                        else
                        {
                            msg = msg + "," + id;
                        }
                    
                }
                
            }

           
                if (msg == "")
                {
                    
                        Label1.Visible = true;
                        Label1.Text = " All User Accounts Closed for Growth Payment";
                    
                }
                else if(msg != "")
                {
                    Label1.Visible = true;
                    Label1.Text = "Unable To Close " + msg + Environment.NewLine + "," + " Rest Closed";
                }
         }
        else
        {
            Label1.Visible = true;
            
            Label1.Text = "Closing no should be between than " + cn + " to 12";
        }
            }
            catch (SqlException err)
            {
                Response.Write(err.Message.ToString());
            }
           
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        

    }
    protected void TextBox2_TextChanged(object sender, EventArgs e)
    {

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {

    }
}
