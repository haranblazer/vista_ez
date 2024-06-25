using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class yesadmin_ShowInvoiceAndWelcomeletter1 : System.Web.UI.Page
{
   

    utility obj = new utility();
    SqlConnection con = new SqlConnection(method.str);
    utility objUtility = new utility();
    DateTime fromDate = new DateTime();
    DateTime toDate = new DateTime();
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
        if (!IsPostBack)
        {
            getdate();
        }
    }
    public void getdate()
    {

        SqlDataAdapter adp = new SqlDataAdapter("select Convert(varchar(20),PayFromDate,103) as PayFromDate, Convert(varchar(20),PayToDate,103) as PayToDate, payoutno from repayoutdate order by payoutno", con);
        con.Open();
        DataTable dt = new DataTable();
        adp.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlDate.Items.Clear();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ddlDate.Items.Add(new ListItem(dt.Rows[i]["PayFromDate"].ToString() + "-" + dt.Rows[i]["PayToDate"].ToString(), dt.Rows[i]["payoutno"].ToString()));


            }
            ddlDate.Items.Insert(0, "Select Closing");
        }
        else
            ddlDate.Items.Insert(0, "No closing found !");
    }
   
    private void selectdata()
    {
        SqlDataAdapter da = new SqlDataAdapter("WelcomeInvoiceData", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.CommandTimeout = 999999;
            da.SelectCommand.Parameters.AddWithValue("@Payoutno", ddlDate.SelectedItem.Value.Trim());
            da.SelectCommand.Parameters.AddWithValue("@Types", DropDownList1.SelectedValue.Trim());
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                lblMsg.Visible = false;
            }
          else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
            lblMsg.Text = "Record not Found";
        }
       
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        selectdata();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedItem.Text.Trim() == "Select")
        {
            utility.MessageBox(this, "Please Select Inovice or Welcome letter");   
        }

        if (ddlDate.SelectedItem.Text.Trim() == "Select Closing")
        {
            utility.MessageBox(this, "Please Select Date");   
        }

        if ((DropDownList1.SelectedItem.Text.Trim() != "Select") && (ddlDate.SelectedItem.Text.Trim() != "Select Closing"))
        {

            if (Convert.ToInt32(TxtPaymentTrandraftid.Text) > 0 || Convert.ToInt32(TxtNoChq.Text) > 0)
            {

                if (DropDownList1.SelectedItem.Text == "Invoice")
                {

                    Page.Response.Redirect("invoice1.aspx?pno=" + objUtility.base64Encode(ddlDate.SelectedItem.Value.Trim()) + "&min=" + objUtility.base64Encode(TxtPaymentTrandraftid.Text.Trim().ToString()) + "&max=" + objUtility.base64Encode(TxtNoChq.Text.Trim()));
                }

                if (DropDownList1.SelectedItem.Text == "Welcome Letter")
                {
                    Page.Response.Redirect("WelcomeLetter1.aspx?pno=" + objUtility.base64Encode(ddlDate.SelectedItem.Value.Trim()) + "&min=" + objUtility.base64Encode(TxtPaymentTrandraftid.Text.Trim().ToString()) + "&max=" + objUtility.base64Encode(TxtNoChq.Text.Trim()));

                }

            }
        }
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (DropDownList1.SelectedValue != "Select")
        {
            selectdata();

        }

        else
        {
            utility.MessageBox(this, "please select date");
        }
    }
    protected void ddlDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList1.SelectedValue = "Select";
        GridView1.DataSource = null;
        GridView1.DataBind();
        TxtPaymentTrandraftid.Text = TxtNoChq.Text = String.Empty;
    }
}
