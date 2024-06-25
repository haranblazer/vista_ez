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
using System.Text;

public partial class secretadmin_Zero_ID_Paid : System.Web.UI.Page, ICallbackEventHandler
{
    string strajax = "";
    DataTable dt = null;
    SqlDataReader sdr;
    SqlDataAdapter da = null;
    SqlConnection con = null;
    SqlCommand cmd = null;
    utility obj = new utility();
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
                Session["CheckRefresh"] = System.DateTime.Now.ToString();
                //BindState();
            }
        }
        catch
        {

        }
         
       
        lblUser.Text = GetUserName(txtsearch.Text.Trim());
        string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
        StringBuilder newFunction = new StringBuilder("function ServerSendValue(arg,ctx){" + js + "}");
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    private string GetUserName(string regno)
    {
        string name = string.Empty;
        try
        {
            con = new SqlConnection(method.str);
            cmd = new SqlCommand("select appmstfname from AppMst where AppMstRegNo=@regno", con);
            cmd.Parameters.AddWithValue("@regno", regno.Trim());
            con.Open();
            name = cmd.ExecuteScalar().ToString();
            con.Close();
        }
        catch
        {
        }
        return name;

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
            cmd.CommandText = "select Name=isnull(appmsttitle,'') + space(1)  +appmstfname  from appmst where appmstregno=@regno";
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


    protected void Button1_Click1(object sender, EventArgs e)
    {
        if (txtsearch.Text.Trim() == "")
        {
            utility.MessageBox(this, "Please Enter userid");
            return;
        }
        else
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();

                try
                {
                    con = new SqlConnection(method.str);
                    cmd = new SqlCommand("sp_zeroidpaid", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@regno", txtsearch.Text.Trim());
                    cmd.Parameters.AddWithValue("@Joinfor", ddl_Joinfor.SelectedValue);
                    cmd.Parameters.AddWithValue("@AppMstPaid", chk_IsPaid.Checked == true ? 1 : 0);

                    cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    string msg = cmd.Parameters["@flag"].Value.ToString();
                    if (msg == "1")
                    {
                        utility.MessageBox(this, "Updated ID successfully");
                        txtsearch.Text = string.Empty;
                        ddl_Joinfor.SelectedValue = "0";
                        chk_IsPaid.Checked = false;
                    }
                    else
                    {
                        utility.MessageBox(this, msg);
                    }
                }
                catch (Exception ex)
                {
                }
            }
            else
            {
                utility.MessageBox(this, "Don't Refresh Page and Press Back Button.");
                return;
            }
        }


    }
}