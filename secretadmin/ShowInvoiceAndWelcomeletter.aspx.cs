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
public partial class admin_ShowInvoiceAndWelcomeletter : System.Web.UI.Page
{
    utility obj = new utility();
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
    protected void btnOk_Click(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("select appmstpaid from appmst where appmstregno=@regno", con);
        cmd.Parameters.AddWithValue("@regno", txtRegno.Text.Trim());
        con.Open();
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            if (ddlDocument.SelectedValue.ToString()=="1")
            {
                Response.Redirect("welcomeletter.aspx?id=" + obj.base64Encode(txtRegno.Text));
                
            }
               
            else if (ddlDocument.SelectedValue.ToString() == "2")
            {
                if (dr["appmstpaid"].ToString() == "1")
                {
                    Response.Redirect("invoice.aspx?id=" + obj.base64Encode(txtRegno.Text));
                }
                else
                {
                    Response.Write("<script>alert('this user not paid')</script>");
                }
            }           
        }
        else
        {
            utility.MessageBox(this,"User id does not exists!");
        }
        con.Close();
    }

    private string Attribute(string p)
    {
        throw new NotImplementedException();
    }       
}
