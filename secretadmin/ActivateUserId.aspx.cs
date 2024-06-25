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

public partial class admin_ActivateUserId : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com= new SqlCommand() ;
    string  id;
    protected void Page_Load(object sender, EventArgs e)
    {
        string str;
        str = Session["admin"].ToString();
        if (str == "")
            Response.Redirect("adminLog.aspx");

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            com.Connection = con;
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.Add(new SqlParameter("@roll", SqlDbType.VarChar,50));
            com.Parameters.Add(new SqlParameter("@flag", SqlDbType.Int));
            if (rdbDeactivate.Checked == true)
            {
                string a = string.Empty;
                a = txtEnterId.Text;
                string msg = "";
                string[] NameArray = a.Split(',');
                for (int i = 0; i < NameArray.Length; i++)
                {

                    id = Convert.ToString(NameArray[i].ToString());
                    string hold;
                    com.CommandText = "checkData";
                    com.Parameters["@roll"].Value = id;
                    com.Parameters["@flag"].Direction = ParameterDirection.Output;
                    con.Open();
                    com.ExecuteNonQuery();
                    hold = com.Parameters["@flag"].Value.ToString();
                    con.Close();
                    com.CommandText = null;
                    if (hold != "")
                    {
                        if (Convert.ToInt32(hold) == 0)
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

                }
                if (msg == "")
                {
                    lblError.Text = "Id DeActivated";
                }
                else
                {
                    lblError.Text = "No record found for id=" + msg + Environment.NewLine +"," + "Else id De Activated";
                }

            }
            else
            {
                string a = string.Empty;
                a = txtEnterId.Text;
                string msg = "";
                string[] NameArray = a.Split(',');
                for (int i = 0; i < NameArray.Length; i++)
                {
                    id = Convert.ToString(NameArray[i].ToString());
                    string hold;
                    con.Open();


                    com.Parameters["@roll"].Value = id;
                    com.Parameters["@flag"].Direction = ParameterDirection.Output;
                    com.CommandText = "checkData1";
                    com.ExecuteNonQuery();
                    hold = com.Parameters["@flag"].Value.ToString();
                    con.Close();
                    com.CommandText = null;
                    if (hold != "")
                    {
                        if (Convert.ToInt32(hold) == 0)
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
                }
                if (msg == "")
                {
                    lblError.Text = "Id  Activated";
                }
                else
                {
                    lblError.Text = "No record found for id=" + msg + Environment.NewLine + " /  Else id Activated";
                }
            }
        }
        catch (Exception e_)
        {
            lblError.Text = "Some Exception Occured Please Make You Choice Again";

        }
    }
}
