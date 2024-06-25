using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_SendToAll : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlDataAdapter sda = null;
    DataTable dt = null;
    utility objUtil = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {

            }
        }
        catch
        {

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        alluser();

    }

    public void alluser()
    {
        con = new SqlConnection(method.str);
        sda = new SqlDataAdapter("AllUser", con);
        sda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sda.SelectCommand.Parameters.AddWithValue("@type", ddltype.SelectedValue.ToString());
        sda.SelectCommand.Parameters.AddWithValue("@search",txtsearch.Text.Trim()==""?"":txtsearch.Text.Trim());
        sda.SelectCommand.Parameters.AddWithValue("@msg",txtmessage.Text.Trim());
        sda.SelectCommand.Parameters.Add("@flag",SqlDbType.VarChar,100).Direction=ParameterDirection.Output;
        dt = new DataTable();
        sda.Fill(dt);
        string flag = sda.SelectCommand.Parameters["@flag"].Value.ToString();
        if (flag == "1")
        {
            if (dt.Rows.Count > 0)
            {
                string[] allValues = dt.AsEnumerable().SelectMany(r => r.Field<string>(0).Split(',')).ToArray();
                foreach (string item in allValues)
                {                  
                    sendSMS(txtmessage.Text.Trim(), item.Trim());
                }
            }

            utility.MessageBox(this, "Message Send Successfully");
            txtmessage.Text = string.Empty;
            txtsearch.Text = string.Empty;
        }

            //var results = from myRow in dt.AsEnumerable()
        //              select new
        //                  {
        //                      userid = myRow.Field<string>("appmst")
        //                  };

        else
        {
            utility.MessageBox(this, sda.SelectCommand.Parameters["@flag"].Value.ToString());
        }
    }

    private void sendSMS(string textmessage,string mobile)
    {
        objUtil = new utility();
        string text = "Dear " + textmessage;
        // string text = "Dear " + lblname.Text.Trim() + " id:" + lblUserid.Text.Trim() + " Your password is " + objUtil.base64Decode(Request.QueryString["pass"].Trim()); 
        objUtil.sendSMSByPage(mobile.Trim(), text);
    }




}