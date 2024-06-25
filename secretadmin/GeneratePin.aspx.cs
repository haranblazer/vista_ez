using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
public partial class tohadmin_GeneratePin : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter sda;
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
           // utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminlogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!Page.IsPostBack)
            countPins();
    }
    public void countPins()
    {
        try
        {
            con = new SqlConnection(method.str);
            sda = new SqlDataAdapter("select pinsrno,allotedto from pinmst", con);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            btnSoldPins.Text = "Number Of Sold Pins : " + dt.Compute("count(pinsrno)", "allotedto>0").ToString();
            btnUnSoldPins.Text = "Number Of UnSold Pins : " + dt.Compute("count(pinsrno)", "allotedto=0").ToString();
        }
        catch
        {
        }
        finally
        {
            con.Close();
            con.Dispose();
            sda.Dispose();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        generate();
        countPins();
    }
    private void generate()
    {        
        con = new SqlConnection(method.str);
        com = new SqlCommand("GeneratePin", con);
        com.CommandType = CommandType.StoredProcedure;
        com.CommandTimeout = 99999999;
        com.Parameters.AddWithValue("@NoOfPins",  txtNo.Text.Trim());     
        try
        {
            con.Open();
            com.ExecuteNonQuery();
            utility.MessageBox(this, "Pins generated successfully!");
            txtNo.Text = string.Empty;
        }
        catch
        {
            utility.MessageBox(this, "Unsuccessfull!...Please try Later!");
        }
        finally
        {
            con.Close();
            con.Dispose();
            com.Dispose();
        }       

    }
    protected void btnSoldPins_Click(object sender, EventArgs e)
    {
        Response.Redirect("activepinlist.aspx",false);
    }
    protected void btnUnSoldPins_Click(object sender, EventArgs e)
    {
        Response.Redirect("NotAllotedPinList.aspx", false);
    }
}
