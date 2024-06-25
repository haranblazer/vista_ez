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
public partial class admin_AgreementDetails : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataReader dr;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void chkagreeno()
    {
        cmd = new SqlCommand("select * from agreement where agreementno='" + txtAgreementno.Text + "'", con);
        con.Open();

        dr = cmd.ExecuteReader();


        if (dr.HasRows)
        {

            lblMsg.Text = "Duplicate Agreement Number!";

        }
        else
        {
            con.Close();
            agree();
        }




    }

    public void agree()
    {


        string date = txtMM.Text + "/" + txtDD.Text + "/" + txtYYYY.Text;

        cmd = new SqlCommand("insert into agreement (userid,agreementno,doa)values('" + txtIdNo.Text + "','" + txtAgreementno.Text + "','" + date + "')", con);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        lblMsg.Text = "Submitted Successfully !";

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        chkagreeno();
    }
}
