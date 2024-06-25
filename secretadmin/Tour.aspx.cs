using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class secretadmin_Tour : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = new DataTable();
    SqlDataAdapter sda;
    string tour;
    string mobileno = null;
    string userid = null;
    string username = null;
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
        
        if (!IsPostBack)
        {

            Itour();
        }


    }


    public void Itour()
    {
        dt.Clear();
        sda = new SqlDataAdapter("tour", con);
        sda.SelectCommand.CommandType = CommandType.StoredProcedure;   
        sda.SelectCommand.Parameters.AddWithValue("@action",DropDownList1.SelectedValue.ToString());
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {

            if (DropDownList1.SelectedValue.ToString() == "1")
            {
                lbltext.Text = "Domestic Tour";
                Rpdomestic.DataSource = dt;
                Rpdomestic.DataBind();
                Rpinternational.DataSource = null;
                Rpinternational.DataBind();
            }


            if (DropDownList1.SelectedValue.ToString() == "2")
            {

                lbltext.Text = "International Tour";
                Rpinternational.DataSource = dt;
                Rpinternational.DataBind();

                Rpdomestic.DataSource = null;
                Rpdomestic.DataBind();
            }

        }

        else
        {
            if (DropDownList1.SelectedValue.ToString() == "1")
            {
                lbltext.Text = "Domestic Tour";
            }

            if (DropDownList1.SelectedValue.ToString() == "2")
            {
                lbltext.Text = "International Tour";
            }

            Rpdomestic.DataSource = null;
            Rpdomestic.DataBind();
            Rpinternational.DataSource = null;
            Rpinternational.DataBind();
        }

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Itour();
    }



    protected void Button1_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in Rpdomestic.Rows)
        {
            if (((CheckBox)row.FindControl("chkSelectRow")).Checked)
            {
               mobileno=   ((Label)row.FindControl("lblmobile")).Text;
               userid = ((Label)row.FindControl("lbluserid")).Text;

                username = ((Label)row.FindControl("lblname")).Text;
                SqlCommand com = new SqlCommand("toursms", con);
                com.CommandType = CommandType.StoredProcedure;
                com.CommandTimeout = 999999999;

                com.Parameters.AddWithValue("@mobileno", mobileno.ToString());
                com.Parameters.AddWithValue("@userid", userid.ToString());
                com.Parameters.AddWithValue("@name", username.ToString());
                //com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                con.Close();
                //mobileno += ((Label)row.FindControl("lblmobile")).Text + ",";
            }
        }

        
        //string fvalue = com.Parameters["@flag"].Value.ToString();
        utility.MessageBox(this,"Message Send Successfully");
        con.Close();
    }
}