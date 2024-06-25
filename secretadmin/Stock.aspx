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
using System.Net;
using System.IO;
public partial class SIMadmin_sendSMStoAll : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    WebClient client = new WebClient();
    protected void Page_Load(object sender, EventArgs e)
    {
    InsertFunction.CheckAdminlogin();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        sendSMS();
    }
    public void sendSMS()
    {
        string sender_id = null;
        string Profile_id = null;
        string Password = null;
        SqlCommand cmd = new SqlCommand("selectSMSInformation", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandTimeout = 999999999;
        con.Open();
        SqlDataReader rdr = cmd.ExecuteReader();
        if (rdr.HasRows)
        {
            while (rdr.Read())
            {
                sender_id = rdr["senderid"].ToString().Trim();
                Profile_id = rdr["profileid"].ToString().Trim();
                Password = rdr["pwd"].ToString().Trim();
            }
        }
        con.Close();

        com = new SqlCommand("idsForSMSToAll", con);

        com.CommandType = CommandType.StoredProcedure;
        com.CommandTimeout = 999999999;

        SqlDataAdapter sda = new SqlDataAdapter(com);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        int c = dt.Rows.Count;
        if (dt.Rows.Count > 0)
        {


            for (int i = 0; i < dt.Rows.Count; i++)
            {
             string name = dt.Rows[i]["uname"].ToString();
             string mobileno = dt.Rows[i]["appmstmobile"].ToString();
            
                if ((mobileno != " "))
                {

                      try
                        {
                         
                            string msgtxt = "Dear, " +name+ ", " +txtMessage.Text;
                            string baseurl = " http://sms.ayuveinfocom.com/sendurl.asp?user=" + Profile_id + "&pwd=" + Password + "&senderid=" + sender_id + "&mobileno='" + mobileno + "'&msgtext=" + msgtxt + " ";
                            Stream data = client.OpenRead(baseurl);
                            StreamReader reader = new StreamReader(data);
                            string s = reader.ReadToEnd();
                            data.Close();
                            reader.Close();
                            lblMsg.Text = "Message Sent Successfully!";
                           
                        }
                        catch (Exception ex)
                        {

                            lblMsg.Text = "Message couldn't sent,Please try later!";

                        }
                    
                }
            }
        }
        else
        {
            lblMsg.Text = "No Data Found!";

        }

    }

  
}
