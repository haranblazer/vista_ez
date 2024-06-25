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
public partial class admin_TurnOver : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string fromdate;
        string todate;
        DateTime from;
        DateTime to;

        fromdate = txtFmm.Text + "/" + txtFddd.Text + "/" + txtfyy.Text;
        todate = txttomm.Text + "/" + txttodd.Text + "/" + txttoyy.Text;

        from = Convert.ToDateTime(fromdate);
        to = Convert.ToDateTime(todate);

        com = new SqlCommand("turnovermaster", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@fromdate", from);
        com.Parameters.AddWithValue("@Todate", to);
        com.Parameters.AddWithValue("@regno", TextBox1.Text);
        com.Parameters.AddWithValue("@consolidated", SqlDbType.Float).Direction = ParameterDirection.Output;
        com.Parameters.AddWithValue("@plana", SqlDbType.Float).Direction = ParameterDirection.Output;
        com.Parameters.AddWithValue("@planb", SqlDbType.Float).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();

        Label5.Text = com.Parameters["@consolidated"].Value.ToString();
        Label6.Text = com.Parameters["@plana"].Value.ToString();
        Label7.Text = com.Parameters["@planb"].Value.ToString();





    }
}
