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
public partial class admin_adchangeprofile : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserName"] == null)
        {
            Response.Redirect("Logout.aspx");
        }
        if(!Page.IsPostBack)
            BindUserID();
    }
    private void BindUserID()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            DataTable tbl = new DataTable();
            da = new SqlDataAdapter("select appmstregno from appmst where fid=(select franchiseid from franchisemst where username=@uname) order by appmstid", con);
            da.SelectCommand.Parameters.AddWithValue("@uname", Session["UserName"].ToString());
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
    protected void Button1_Click(object sender, EventArgs e)
    {
        com = new SqlCommand("select * from AppMst where AppMstregno=@RegNo and fid=(select franchiseid from franchisemst where username=@atype)", con);
            com.Parameters.AddWithValue("@RegNo",txtRegNo.Text.Trim());
            com.Parameters.AddWithValue("@atype", Session["UserName"].ToString());
            con.Open();
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {              
                Response.Redirect("edit.aspx?n=" + obj.base64Encode(txtRegNo.Text));
                con.Close();
            }
            else
            {                
                con.Close();
                utility.MessageBox(this, "Wrong user id!");
            }       
    }
}