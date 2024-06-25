using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;

//using System.Drawing;

public partial class User_OldGbvIncrement : System.Web.UI.Page, ICallbackEventHandler
{
    SqlConnection con = null;
    SqlCommand com = null;
    string strajax = "";
    utility objUtil = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        //else if (Convert.ToString(Session["admintype"]) == "a")
        //{
        //    utility.CheckAdminLogin();
        //}
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!IsPostBack)
        {

        }
        string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
        StringBuilder newFunction = new StringBuilder("function ServerSendValue(arg,ctx){" + js + "}");
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);
    }

    #region (ICallbackEventHandlar Methods..)
    public string GetCallbackResult()
    {
        return strajax;
    }

    public void RaiseCallbackEvent(string eventArguments)
    {
        if (eventArguments != "")
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand();
            SqlDataReader dr;
            cmd.CommandText = "select isnull(appmsttitle,'')+space(1)+appmstfname as name from appmst where appmstregno=@regno";
            cmd.Parameters.AddWithValue("@regno", eventArguments.Trim());
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                strajax = Convert.ToString(dr["name"]);
                Session["sname"] = Convert.ToString(dr["name"]);
            }
            else
            {
                strajax = "User Does Not Exist!";
            }
            dr.Close();
            con.Close();
        }
        else
        {
            strajax = "Required field cannot be blank !";
        }
    }
    #endregion

    private void AddGbv()
    {
        if (txtGbvAdd.Text.Trim() == String.Empty || txtUserId.Text.Trim() == String.Empty)
        {
            utility.MessageBox(this, "Please enter userid and value!");
            return;
        }
        else if (Convert.ToDecimal(txtGbvAdd.Text.Trim()) > 900000)
        {
            utility.MessageBox(this, "Amount limit 1-900000");
            return;
        }
        else
        {
            con = new SqlConnection(method.str);
            string status = ""; string value = "";
            com = new SqlCommand("AddOldGbv", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regno", txtUserId.Text.Trim());
            com.Parameters.AddWithValue("@value", Convert.ToInt32(txtGbvAdd.Text.Trim()));
            com.Parameters.Add("@fvalue", SqlDbType.Int).Direction = ParameterDirection.Output;
            com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            //com.Parameters.AddWithValue("@fvalue", 0);
            //com.Parameters.AddWithValue("@flag", "0");
            con.Open();
            //com.CommandTimeout = 90000;
            if (com.ExecuteNonQuery() > 0)
            {
                status = com.Parameters["@flag"].Value.ToString();
                value = com.Parameters["@fvalue"].Value.ToString();
                if (status == "1")
                {
                    utility.MessageBox(this, "Data Updated Successfully:" + value.Trim());
                    txtUserId.Text = string.Empty;
                    txtGbvAdd.Text = string.Empty;

                }
                else
                {
                    utility.MessageBox(this, "Error!");

                }
            }
            else
            {
                utility.MessageBox(this, "try later.");
                con.Close();
            }
        }

    }
    protected void btSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            AddGbv();
        }
        catch
        {
        }

    }
}