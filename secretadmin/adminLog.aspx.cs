using System;
using System.Data; 
using System.Web; 
using System.Web.UI; 
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Net; 


public partial class admin_adminLog : System.Web.UI.Page
{
    string userId, userName;
    SqlConnection con = new SqlConnection(method.str);
    SqlDataReader sdr;
    utility obj = new utility();
    public string sadmintype;
    protected void Page_Load(object sender, EventArgs e)
    {

        Label1.Text = Request.ServerVariables["REMOTE_HOST"];
        if (!IsPostBack)
        {
            Session.Abandon();
            Session.RemoveAll();
            Session.Clear();
            Session["admin"] = null;
        }
    }
    private void checkAdmin()
    {
        if (Regex.Match(txtId.Text, @"^[a-zA-Z0-9]*$").Success && Regex.Match(txtPassword.Text, @"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&amp;])[A-Za-z\d$@$!%*#?&amp;]{8,}$").Success)
        {

            SqlDataAdapter sda = new SqlDataAdapter("checkAdmin", con);
            sda.SelectCommand.CommandType = CommandType.StoredProcedure;
            sda.SelectCommand.Parameters.AddWithValue("@uid", txtId.Text);
            sda.SelectCommand.Parameters.AddWithValue("@pwd", txtPassword.Text);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                utility objUt = new utility();
                if (txtId.Text == dt.Rows[0]["username"].ToString() && txtPassword.Text == objUt.base64Decode(dt.Rows[0]["password"].ToString()))
                {
                    Session["admin"] = txtId.Text;
                    //Session["userName"] = dt.Rows[0]["username"].ToString();
                    //Session["Password"] = txtPassword.Text.Trim();
                    Session["admintype"] = dt.Rows[0]["admintype"].ToString();

                    saveAdminLogInInfo(txtId.Text, txtPassword.Text, Session["admintype"].ToString());

                    if (dt.Rows[0]["RoleId"].ToString() == "5")
                    {
                        Response.Redirect("BDM-Dashboard.aspx", false);
                    }
                    else
                    {
                        Response.Redirect("welcome.aspx", false);
                    }
                }
                else
                {
                    lblMsg.Text = "Sorry! admin does not exsist!";
                }

            }

            else
            {
                lblMsg.Text = "Sorry! admin does not exsist!";
            }

        }
        else if (!Regex.Match(txtId.Text, @"^[a-zA-Z0-9]*$").Success)
        {
            utility.MessageBox(this, "Only Alphanumeric Value Is Allowed in username !");
            txtId.Focus();
            return;

        }
        else if (!Regex.Match(txtPassword.Text, @"^[a-zA-Z0-9]{6,}$").Success)
        {
            utility.MessageBox(this, "Password must be six characters long including letters and numbers !");
            txtPassword.Focus();
            return;
        }
        else if (txtId.Text == "" && txtPassword.Text == "")
        {
            utility.MessageBox(this, "Both user name and password are required!");
            return;

        }
        else if (txtId.Text == "" && txtPassword.Text != "")
        {
            utility.MessageBox(this, "User Name is required!");
            return;

        }
        else if (txtId.Text != "" && txtPassword.Text == "")
        {
            utility.MessageBox(this, "Password is required!");
            return;

        }
    }


    public void saveAdminLogInInfo(string aname, string pwd, string at)
    {
        try
        {



            GetIP();
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            SqlCommand com = new SqlCommand("saveAdminLogin1", con);
            com.CommandTimeout = 999999999;
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@uname", aname);
            com.Parameters.AddWithValue("@password", pwd);
            com.Parameters.AddWithValue("@admintype", Session["admintype"]);
            //com.Parameters.AddWithValue("@LogInDateTime", ldt);
            com.Parameters.AddWithValue("@IPAddress", Request.UserHostAddress);
            com.Parameters.AddWithValue("@hostname", Dns.GetHostName());
            com.Parameters.Add("@id", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            string value = com.Parameters["@id"].Value.ToString();
            Session["ipid"] = value.ToString();
            con.Close();
        }
        catch (Exception er) { }
    }

    protected void loginbtn_Click(object sender, ImageClickEventArgs e)
    {
        Session["Administrator"] = txtId.Text;
        checkAdmin();

    }


    public string GetIP()
    {


        string IPAddress = string.Empty;
        string SearchName = string.Empty;

        String ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

        if (string.IsNullOrEmpty(ip))
        {
            ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }

        return ip;


    }

    public string GetIPAddress()
    {
        string externalIP = "";
        externalIP = (new WebClient()).DownloadString("http://checkip.dyndns.org/");
        externalIP = (new Regex(@"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}")).Matches(externalIP)[0].ToString();
        return externalIP;
    }


    protected void loginbtn_Click(object sender, EventArgs e)
    {
        Session["Administrator"] = txtId.Text;
        checkAdmin();
    }
}
