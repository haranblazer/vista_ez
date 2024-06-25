using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Xml.Linq;
using System.Xml;
using System.Text;
using System.Text.RegularExpressions;
using System.Globalization;

public partial class secretadmin_BillingPage : System.Web.UI.Page
{
    SqlConnection con = null;
    utility ObjUtil = null;
    SqlCommand cmd = null;
    SqlDataAdapter sda = null;
    DataTable dt = null;
    string strajax = "";
    string status = "";
    string invoiceno = "";
    DataTable dtuser = null;
    object Totalbillamt = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            gridbind();
        }
    }

    public void gridbind()
    {


        con = new SqlConnection(method.str);
        cmd = new SqlCommand("billproduct", con);
        cmd.Parameters.AddWithValue("@action", "allproduct");
        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        dt = new DataTable();
        dt.Load(cmd.ExecuteReader());
        if (dt.Rows.Count > 0)
        {
            dglst.DataSource = dt;
            dglst.DataBind();
        }
        else
        {
            dglst.DataSource = null;
            dglst.DataBind();
        }

    }
    protected void dglst_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //var pid = (Label)e.Row.FindControl("lblpackageid");
            Label pid = (Label)e.Row.FindControl("lblpid");
          
            DropDownList ddlbatch = (DropDownList)e.Row.FindControl("ddlbatchno");
            con = new SqlConnection(method.str);
            cmd = new SqlCommand("billproduct", con);
            cmd.Parameters.AddWithValue("@action", "mode");
            cmd.Parameters.AddWithValue("@pid",Convert.ToInt32(pid.Text));
            con.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            if (dt.Rows.Count > 0)
            {
                ddlbatch.DataTextField = "batchname";
                ddlbatch.DataValueField = "batchid";
                ddlbatch.DataSource = dt;
                ddlbatch.DataBind();
                ddlbatch.Items.Insert(0, new System.Web.UI.WebControls.ListItem("select", "0"));        
            }
            else
            {
                ddlbatch.DataSource = null;
                ddlbatch.DataBind();
                ddlbatch.Items.Insert(0, new System.Web.UI.WebControls.ListItem("select", "0"));        
 
            }

        }
    }

    protected void ddlbatchno_SelectedIndexChanged(object sender, EventArgs e)
    {
      
        
        DropDownList ddlbatchno = (DropDownList)sender;
        GridViewRow Grow = (GridViewRow)ddlbatchno.NamingContainer;
        Label lblpid = (Label)Grow.FindControl("lblpid");

        if (ddlbatchno.SelectedValue.ToString() != "0")
        {             
            con = new SqlConnection(method.str);
            cmd = new SqlCommand("billproduct", con);       
            cmd.Parameters.AddWithValue("@action", "bindqty");
            cmd.Parameters.AddWithValue("@pid", Convert.ToInt32(lblpid.Text));
            cmd.Parameters.AddWithValue("@batchid", ddlbatchno.SelectedValue.ToString());
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            if (dt.Rows.Count > 0)
            {

                ((Label)Grow.FindControl("lblstockqty")).Text = dt.Rows[0][0].ToString();
                //((TextBox)Grow.FindControl("txtquantity")).Text = "1";
                ((Label)Grow.FindControl("lblprice")).Text = dt.Rows[0][1].ToString();
            }
            else
            {
                ((Label)Grow.FindControl("lblstockqty")).Text = "0";
                ((TextBox)Grow.FindControl("txtquantity")).Text = "0";
                ((Label)Grow.FindControl("lblprice")).Text = "0";
                ((Label)Grow.FindControl("lbltotalamt")).Text = "0";
              

            }
            con.Close();
       
         
        }
        if (ddlbatchno.SelectedValue.ToString() == "0")
        {
            ((Label)Grow.FindControl("lblstockqty")).Text = "0";
            ((TextBox)Grow.FindControl("txtquantity")).Text = "0";
            ((Label)Grow.FindControl("lblprice")).Text = "0";
            ((Label)Grow.FindControl("lbltotalamt")).Text = "0";

        }
     
     
    }

    protected void txtquantity_TextChanged(object sender, EventArgs e)
    {
        TextBox txtqty = (TextBox)sender;
        GridViewRow Grow = (GridViewRow)txtqty.NamingContainer;
        Label lblprice = (Label)Grow.FindControl("lblprice");
        Label lbltotalamt = (Label)Grow.FindControl("lbltotalamt");
        lbltotalamt.Text = Convert.ToString(Convert.ToDouble(txtqty.Text) * Convert.ToDouble(lblprice.Text));

    }
}
   