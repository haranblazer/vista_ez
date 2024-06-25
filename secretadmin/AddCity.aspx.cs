using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_AddCity : System.Web.UI.Page
{

    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    Validation val = new Validation();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
            Response.Redirect("adminLog.aspx", false);
        if (!Page.IsPostBack)
        {

            BindState();
        }
    }

    public void BindState()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetState", con);
            com.CommandType = CommandType.StoredProcedure;

            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddlSelectState.DataSource = dt;
                ddlSelectState.Items.Clear();
                ddlSelectState.DataTextField = "Statename";
                ddlSelectState.DataValueField = "sid";
                ddlSelectState.DataBind();
                ddlSelectState.Items.Insert(0, new ListItem("Select", "0"));



            }
            else
            {
                ddlSelectState.Items.Insert(0, new ListItem("Select", "0"));
            }


        }
        catch
        {

        }

    }

    protected void btnAddCity_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlSelectState.SelectedValue!="0")
            {
                if (!string.IsNullOrEmpty(txtAddCity.Text.Trim()))
                {
                    if (val.IsAlphabets(txtAddCity.Text.Trim()))
                    {
                        if (btnCity.Text == "ADD")
                        {

                            con = new SqlConnection(method.str);
                            com = new SqlCommand("AddCity", con);
                            com.CommandType = CommandType.StoredProcedure;
                            com.Parameters.AddWithValue("@state", ddlSelectState.SelectedItem.Value.ToString());
                            com.Parameters.AddWithValue("@cityname", txtAddCity.Text.Trim());
                            com.Parameters.Add("@msg", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                            con.Open();
                            com.ExecuteNonQuery();
                            string msg = com.Parameters["@msg"].Value.ToString();
                            utility.MessageBox(this, msg);
                            BindCity();
                            
                            txtAddCity.Text = string.Empty;
                            con.Close();

                        }
                        else
                        {

                            con = new SqlConnection(method.str);
                            com = new SqlCommand("UpdateCity", con);
                            com.CommandType = CommandType.StoredProcedure;
                            com.Parameters.AddWithValue("@srno", Session["srno"].ToString());
                            com.Parameters.AddWithValue("@state", ddlSelectState.SelectedItem.Value.ToString());
                            com.Parameters.AddWithValue("@cityname", txtAddCity.Text.Trim());
                            com.Parameters.Add("@msg", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                            con.Open();
                            com.ExecuteNonQuery();
                            string msg = com.Parameters["@msg"].Value.ToString();
                            utility.MessageBox(this, msg);
                            txtAddCity.Text = string.Empty;
                            BindCity();
                            btnCity.Text = "ADD";
                            con.Close();
                        }
                    }
                    else
                    {
                        utility.MessageBox(this, "Only Alphabets are allowed in City name.");
                        txtAddCity.Focus();
                        return;
                    }

                }

                else
                {
                    utility.MessageBox(this, "Please enter City name.");
                    txtAddCity.Focus();
                    return;
                }

            }
            else
            {
                utility.MessageBox(this, "Please Select State.");
                ddlSelectState.Focus();
                return;
            }


        }
        catch
        {

        }
    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;
           
            string srno = GridCity.DataKeys[gvrow.RowIndex].Value.ToString();
            Session["srno"] = srno.ToString();
            txtAddCity.Text = gvrow.Cells[2].Text;
            Label lbl = (Label)gvrow.FindControl("lblState");
            ddlSelectState.SelectedItem.Selected = false;
            ddlSelectState.Items.FindByValue(lbl.Text).Selected = true;
           
            btnCity.Text = "UPDATE";
        }
        catch
        {

        }

    }
    protected void GridCity_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        
        GridCity.PageIndex = e.NewPageIndex;
        BindCity();

    }
    protected void ddlSelectState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSelectState.SelectedItem.Value != "0")
        {
            BindCity();
            txtAddCity.Text = string.Empty;
            btnCity.Text = "ADD";
        }
        else
        {
            GridCity.DataSource = null;
            GridCity.DataBind();
            txtAddCity.Text = string.Empty;
            btnCity.Text = "ADD";
        }
    }
    public void BindCity()
    {
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("GetStateCity", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@state", ddlSelectState.SelectedItem.Value);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            divCity.InnerText = string.Empty;
            foreach (DataRow drw in dt.Rows)
            {

                divCity.InnerText += drw["cityname"].ToString() + ",";


            }
            GridCity.DataSource = dt;
            GridCity.DataBind();


        }
        else
        {
            GridCity.DataSource = null;
            GridCity.DataBind();

        }



    }
}
