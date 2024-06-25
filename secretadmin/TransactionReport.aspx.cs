using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Admin_TransactionReport : System.Web.UI.Page
{

    SqlDataAdapter da;
    SqlConnection con = new SqlConnection(method.str);
    utility u = new utility();
    string paid = null;
    int joinTotal = 0;

    protected void Page_Load(object sender, EventArgs e)
    {



        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminloginInside();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!Page.IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            //td2.Visible = false;
            //td4.Visible = false;
            //td6.Visible = false;
            //td8.Visible = false;
            //td10.Visible = false;
            pinlist();
            bindGrid();
        }




    }


    private void bindGrid()
    {
        txtSearch.Text = string.Empty;
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        DateTime fromDate = new DateTime();
        DateTime toDate = new DateTime();
        try
        {
            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
        }
        catch
        {
            lblMsg.Text = "Invalid date entry.";
            return;
        }
        da = new SqlDataAdapter("searchPinlist", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@mindate", fromDate);
        da.SelectCommand.Parameters.AddWithValue("@maxdate", toDate);
        //da.SelectCommand.Parameters.AddWithValue("@type", "cl");
        //da.SelectCommand.Parameters.AddWithValue("@ptype", ddlPinType.SelectedItem.Value);
        DataTable table = new DataTable();
        da.Fill(table);
        if (table.Rows.Count > 0)
        {
            ViewState["dt"] = table;
            gvActivePinList.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? table.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
            gvActivePinList.DataSource = table;
            gvActivePinList.DataBind();
        }
        else
        {
            gvActivePinList.DataSource = null;
            gvActivePinList.DataBind();
        }
    }





    private void pinlist()
    {
        DataTable tbl = new DataTable();
        con = new SqlConnection(method.str);
        con.Open();
        da = new SqlDataAdapter("select productname + ' (' + convert(varchar(50),amount)  + ')' as pname,srno from productmst", con);
        da.Fill(tbl);
        DropDownList2.DataTextField = "pname";
        DropDownList2.DataValueField = "srno";
        DropDownList2.DataSource = tbl;
        DropDownList2.DataBind();
        DropDownList2.Items.Insert(0, new ListItem("select", "0"));
        con.Close();

    }





    protected void Button3_Click(object sender, EventArgs e)
    {


        if (txtinvoiveno.Text != "")
        {

            txtSearch.Text = "";

            DropDownList2.SelectedIndex = 0;

            DataTable dt = (DataTable)ViewState["dt"];
            DataView dv = new DataView(dt);

            dv.RowFilter = "srno='" + txtinvoiveno.Text + "'";
            gvActivePinList.DataSource = dv;
            gvActivePinList.DataBind();


        }



    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        bindGrid();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

    }



    private void search()
    {
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        DateTime fromDate = new DateTime();
        DateTime toDate = new DateTime();
        try
        {
            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
        }
        catch
        {
            lblMsg.Text = "Invalid date entry.";
            return;
        }
        da = new SqlDataAdapter("searchPinlist", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@mindate", fromDate);
        da.SelectCommand.Parameters.AddWithValue("@maxdate", toDate);
        da.SelectCommand.Parameters.AddWithValue("@UserId", txtSearch.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@type", "s");
        da.SelectCommand.Parameters.AddWithValue("@ptype", ddlPinType.SelectedItem.Value);
        DataTable table = new DataTable();
        da.Fill(table);
        if (table.Rows.Count > 0)
        {

            gvActivePinList.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? table.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
            gvActivePinList.DataSource = table;
            gvActivePinList.DataBind();
        }
        else
        {
            gvActivePinList.DataSource = null;
            gvActivePinList.DataBind();
        }
    }

    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindGrid();
    }
    protected void gvActivePinList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvActivePinList.PageIndex = e.NewPageIndex;
        bindGrid();
    }

    protected void ddlPinType_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindGrid();
    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtinvoiveno.Text = "";
        txtSearch.Text = "";

        DataTable dt = (DataTable)ViewState["dt"];


        DataView dv = new DataView(dt);

        dv.RowFilter = "productname='" + DropDownList2.SelectedItem.Text + "'";
        gvActivePinList.DataSource = dv;
        gvActivePinList.DataBind();


    }
    protected void txtinvoiveno_TextChanged(object sender, EventArgs e)
    {
        txtSearch.Text = "";
    }
    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        txtinvoiveno.Text = "";
    }
    protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
    {
       // check();
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
       // check();

    }
    protected void CheckBox3_CheckedChanged(object sender, EventArgs e)
    {
      //  check();
    }
    protected void CheckBox4_CheckedChanged(object sender, EventArgs e)
    {
      //  check();

    }
    protected void CheckBox5_CheckedChanged(object sender, EventArgs e)
    {
      //  check();

    }

    public void check()
    {

        //if (CheckBox1.Checked == true)
        //{

        //    td4.Visible = true;

        //}

        //if (CheckBox1.Checked == false)
        //{
        //    td4.Visible = false;
        //}
        //if (CheckBox2.Checked == true)
        //{

        //    td2.Visible = true;

        //}

        //if (CheckBox2.Checked == false)
        //{
        //    td2.Visible = false;
        //}

        //if (CheckBox3.Checked == true)
        //{

        //    td6.Visible = true;

        //}

        //if (CheckBox3.Checked == false)
        //{
        //    td6.Visible = false;
        //}

        //if (CheckBox4.Checked == true)
        //{

        //    td8.Visible = true;

        //}

        //if (CheckBox4.Checked == false)
        //{
        //    td8.Visible = false;
        //}


        //if (CheckBox5.Checked == true)
        //{

        //    td10.Visible = true;

        //}

        //if (CheckBox5.Checked == false)
        //{
        //    td10.Visible = false;
        //}

    }


    protected void Button4_Click(object sender, EventArgs e)
    {
        if (txtSearch.Text != "")
        {
            txtinvoiveno.Text = "";

            DropDownList2.SelectedIndex = 0;
            DataTable dt = (DataTable)ViewState["dt"];

            DataView dv = new DataView(dt);

            dv.RowFilter = "AppMstregno='" + txtSearch.Text + "'";
            gvActivePinList.DataSource = dv;
            gvActivePinList.DataBind();
            //search();

        }
    }


    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> SearchCustomers(string prefixText, int count)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("select appmstregno from appmst where appmstregno like ''+'%'+@SearchText+'%'+''",con);
        cmd.Parameters.AddWithValue("@SearchText", prefixText);
        SqlDataReader dr;
        con.Open();
        dr=cmd.ExecuteReader();
       
        List<string> customers = new List<string>();
       
        {
            while (dr.Read())
            {
                customers.Add(dr["appmstregno"].ToString());
            }
        }
        con.Close();
        dr.Close();
        return customers;
    }
}
       
    

