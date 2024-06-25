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
public partial class admin_topup : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        checkjf();

    }
    public void checkjf()
    {
        string qstr = "select joinfor,appmstpaid  from appmst where appmstregno='" + txtregno.Text + "'";
        con.Open();
        com = new SqlCommand(qstr, con);
        sdr = com.ExecuteReader();
        if (sdr.Read())
        {
            if (sdr["appmstpaid"].ToString() == "1")
            {

                if (((sdr["joinfor"].ToString() == "2") && (JoinFor.SelectedValue.ToString() == "1")) || ((sdr["joinfor"].ToString() == "4") && (JoinFor.SelectedValue.ToString() == "1")) || ((sdr["joinfor"].ToString() == "4") && (JoinFor.SelectedValue.ToString() == "2")))
                {
                    Label1.Text = "Sorry You Can Not Top Up With Lower Amount!";

                }
                else
                {
                    con.Close();
                    updatejf();
                }
            }
            else
            {
                Label1.Text = "Sorry Top Up Not Allowed!";
            }
        }
    }


    public void updatejf()
    {
        string qstrupdate = "update appmst set joinfor='" + JoinFor.SelectedValue.ToString() + "' where appmstregno='"+txtregno.Text+"'";
        con.Open();
        com = new SqlCommand(qstrupdate, con);
        com.ExecuteNonQuery();
        Label1.Text = "Updated Successfully!";
       
        con.Close();
    }
}
