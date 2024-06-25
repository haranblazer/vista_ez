using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class admin_RankCalc : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand com = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
        {
            Response.Redirect("~/admin/adminlog.aspx");
        }
        if (!IsPostBack)
        {
            DateShow();
        }
    }
    public void DateShow()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("select MAX(RankDate) from  RankMst", con);
            con.Open();
            lblmsg.Text = com.ExecuteScalar().ToString();
            con.Close();
        }
        catch
        {
        }
    }
    

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("RankCalculate", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.Add("@Flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            utility.MessageBox(this, com.Parameters["@flag"].Value.ToString());
            DateShow();
        }
        catch {
            utility.MessageBox(this, "Error");
        
        }
    }
}