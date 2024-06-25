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
using System.Text.RegularExpressions;
public partial class admin_downline : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!Page.IsPostBack)
            BindUserID();
    }
    private void BindUserID()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            DataTable tbl = new DataTable();
            da = new SqlDataAdapter("select appmstregno from appmst order by appmstid", con);
            da.Fill(tbl);
            divUserID.InnerText = string.Empty;
            foreach (DataRow row in tbl.Rows)
            {
                divUserID.InnerText += row["appmstregno"].ToString().Trim() + ",";
            }
        }
        catch
        {
        }
        finally
        {
        }
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
    if (Regex.Match(txtRegNo.Text+txtPayoutNo.Text, @"^[a-zA-Z0-9]*$").Success)
    {
        Session["regno"] = txtRegNo.Text;
        Session["pno"] = txtPayoutNo.Text;
        Response.Redirect("downlineresult.aspx");
    }
    else
    {
       utility.MessageBox(this,"Invalid User Id!");
    }   
    }
   


    
}
