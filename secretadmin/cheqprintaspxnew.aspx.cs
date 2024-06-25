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
public partial class admin_cheqprintaspx : System.Web.UI.Page
{
    string todate;
    string fromdate;
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    int closings;
    utility objUtil = new utility();
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
      
        if (IsPostBack)
            btnprint.Visible = false;
        if (IsPostBack==false)
        {
            getdate();
            GridView1.Visible = false;
            btnprint.Visible = false;
            Session["startid"] = 0;
        }
        else
        {                  
        }
    }
    public void getdate()
    {
        try
        {
            SqlDataAdapter adp = new SqlDataAdapter("select distinct PaymentFromDate ,PaymentToDate from PaymentTranDraft", con);           
            con.Open();
            DataTable dt = new DataTable();
            adp.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    ddlDate.Items.Add(dt.Rows[i]["PaymentFromDate"].ToString() + "-" + dt.Rows[i]["PaymentToDate"].ToString());    
                }
            }
        }
        catch
        {
        }
    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {      
        string[] date = ddlDate.SelectedItem.Text.Split('-');
        fromdate = date[0].ToString();
        todate = date[1].ToString();
        GridView1.EditIndex = e.NewEditIndex;
        selectdata(fromdate, todate);     
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
      
        GridView1.EditIndex = e.RowIndex;
        string pid = ((Label)GridView1.Rows[e.RowIndex].FindControl("lblPid")).Text;
        string amount = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtTotalAmount")).Text;
        string chequedate =((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtChequeDate")).Text;
        if (string.IsNullOrEmpty(amount))
        {
            utility.MessageBox(this, "Please enter amount!");
            return;
        }
        else if (string.IsNullOrEmpty(chequedate))
        {
            utility.MessageBox(this, "Invalid day!");
            return;
        }   
            else
        {

                       
            editchq(amount,chequedate, pid);
            GridView1.EditIndex = -1;
            selectdata(ddlDate.SelectedItem.Text.Split('-').GetValue(0).ToString(), ddlDate.SelectedItem.Text.Split('-').GetValue(1).ToString());
        }
        

        }
    public bool IsLeapYear(int year)
    {
        if ((year % 400) == 0)       
            return true; 
        else if ((year % 100) == 0)
            return false;
        else if ((year % 4) == 0)      
            return true; 
        else           
            return false;
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        string[] date = ddlDate.SelectedItem.Text.Split('-');
        fromdate = date[0].ToString();
        todate = date[1].ToString();
        GridView1.EditIndex = -1;
        selectdata(fromdate, todate);
    }
  
    public void editchq(string amt,string chquedate, string id)
    {
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        DateTime cDate = new DateTime();      
        try
        {
            cDate = Convert.ToDateTime(chquedate, dateInfo);        
        }
        catch
        {
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }
        try
        {
            cmd = new SqlCommand("editchq", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@chequedate", cDate);
            cmd.Parameters.AddWithValue("@dispachedamt", amt);
            cmd.Parameters.AddWithValue("@PaymenttranDraftId", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        catch
        {
        }
    }
    protected void ddlDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtDate.Text = string.Empty;
        if (ddlDate.SelectedItem.Text == "Select Closing")
        {
            utility.MessageBox(this, "Please select closing date first!");
            GridView1.Visible = false;
        }
        else
        {            
            selectdata(ddlDate.SelectedItem.Text.Split('-').GetValue(0).ToString(), ddlDate.SelectedItem.Text.Split('-').GetValue(1).ToString());
            GridView1.Visible = true;
        }

    }
    private void selectdata(string from,string to)
    { 
        try
        {
            SqlDataAdapter adp = new SqlDataAdapter("getChequeData", con);
            adp.SelectCommand.CommandType = CommandType.StoredProcedure;
            adp.SelectCommand.Parameters.AddWithValue("@fromdate", from);
            adp.SelectCommand.Parameters.AddWithValue("@todate", to);
            con.Open();

            DataSet ds = new DataSet();
            adp.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                GridView1.DataSource = ds;
                GridView1.DataBind();
                lblTotalAmount.Text ="Total Amount : "+ Convert.ToString(ds.Tables[0].Compute("sum(dispachedamt)", "1=1"));

            }
            else
            {
                GridView1.DataSource =null;
                GridView1.DataBind();

            }
            con.Close();
        }
        catch
        {
        }
    

    }



    protected void btnprint_Click(object sender, EventArgs e)
    {
        string[] date = ddlDate.SelectedItem.Text.Split('-');
        fromdate = date[0].ToString();
        todate = date[1].ToString();
        Page.Response.Redirect("printchq.aspx?startid=" + TxtPaymentTrandraftid.Text + "&from=" + fromdate + "&to=" + todate + "&NoChq=" + TxtNoChq.Text);
    }
    

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GridView1.Visible = true;     
        selectdata(ddlDate.SelectedItem.Text.Split('-').GetValue(0).ToString(), ddlDate.SelectedItem.Text.Split('-').GetValue(1).ToString());
        
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
       string s = Convert.ToString(ddlDate.SelectedItem.Text);
        closings = Convert.ToInt32(s);       
        selectdata(ddlDate.SelectedItem.Text.Split('-').GetValue(0).ToString(), ddlDate.SelectedItem.Text.Split('-').GetValue(1).ToString());
        GridView1.Visible = true;

       
       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            string ct = "b";

            string[] date = ddlDate.SelectedItem.Text.Split('-');

            fromdate = date[0].ToString();
            todate = date[1].ToString();
            if (rbtnICICI.Checked == true)
            {
                Page.Response.Redirect("printchqnew.aspx?startid=" + objUtil.base64Encode(TxtPaymentTrandraftid.Text) + "&from=" + objUtil.base64Encode(fromdate) + "&to=" + objUtil.base64Encode(todate) + "&NoChq=" + objUtil.base64Encode(TxtNoChq.Text) + "&ChqType=" + objUtil.base64Encode(ct));
            }
            else if (rbtnPNB.Checked == true)
            {
                Page.Response.Redirect("pnbchq.aspx?startid=" + objUtil.base64Encode(TxtPaymentTrandraftid.Text) + "&from=" + objUtil.base64Encode(fromdate) + "&to=" + objUtil.base64Encode(todate) + "&NoChq=" + objUtil.base64Encode(TxtNoChq.Text) + "&ChqType=" + objUtil.base64Encode(ct));
            }
            else if (rbtnAxis.Checked == true)
            {
                Page.Response.Redirect("AxisCheque.aspx?startid=" + objUtil.base64Encode(TxtPaymentTrandraftid.Text) + "&from=" + objUtil.base64Encode(fromdate) + "&to=" + objUtil.base64Encode(todate) + "&NoChq=" + objUtil.base64Encode(TxtNoChq.Text) + "&ChqType=" + objUtil.base64Encode(ct));
            }
            else if (rbtnBOB.Checked == true)
            {
                Page.Response.Redirect("BankOfBaroda.aspx?startid=" + objUtil.base64Encode(TxtPaymentTrandraftid.Text) + "&from=" + objUtil.base64Encode(fromdate) + "&to=" + objUtil.base64Encode(todate) + "&NoChq=" + objUtil.base64Encode(TxtNoChq.Text) + "&ChqType=" + objUtil.base64Encode(ct));
            }
            else if (rbtnHDFC.Checked == true)
            {
                Page.Response.Redirect("HDFCCheque.aspx?startid=" + objUtil.base64Encode(TxtPaymentTrandraftid.Text) + "&from=" + objUtil.base64Encode(fromdate) + "&to=" + objUtil.base64Encode(todate) + "&NoChq=" + objUtil.base64Encode(TxtNoChq.Text) + "&ChqType=" + objUtil.base64Encode(ct));
            }
            else if (rbtnSBI.Checked == true)
            {
                Page.Response.Redirect("SBI.aspx?startid=" + objUtil.base64Encode(TxtPaymentTrandraftid.Text) + "&from=" + objUtil.base64Encode(fromdate) + "&to=" + objUtil.base64Encode(todate) + "&NoChq=" + objUtil.base64Encode(TxtNoChq.Text) + "&ChqType=" + objUtil.base64Encode(ct));
            }
            else if (rbtnBOI.Checked == true)
            {
                Page.Response.Redirect("BOIChq.aspx?startid=" + objUtil.base64Encode(TxtPaymentTrandraftid.Text) + "&from=" + objUtil.base64Encode(fromdate) + "&to=" + objUtil.base64Encode(todate) + "&NoChq=" + objUtil.base64Encode(TxtNoChq.Text) + "&ChqType=" + objUtil.base64Encode(ct));
            }
            else if (rbtnING.Checked == true)
            {
                Page.Response.Redirect("ING.aspx?startid=" + objUtil.base64Encode(TxtPaymentTrandraftid.Text) + "&from=" + objUtil.base64Encode(fromdate) + "&to=" + objUtil.base64Encode(todate) + "&NoChq=" + objUtil.base64Encode(TxtNoChq.Text) + "&ChqType=" + objUtil.base64Encode(ct));
            }
            else if (rbtnYes.Checked == true)
            {
                Page.Response.Redirect("yes.aspx?startid=" + objUtil.base64Encode(TxtPaymentTrandraftid.Text) + "&from=" + objUtil.base64Encode(fromdate) + "&to=" + objUtil.base64Encode(todate) + "&NoChq=" + objUtil.base64Encode(TxtNoChq.Text) + "&ChqType=" + objUtil.base64Encode(ct));
            }
        }
        else
            utility.MessageBox(this, "Records not found for printing.");
    }
    protected void btnDate_Click(object sender, EventArgs e)
    {

        if (GridView1.Rows.Count > 0)
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime Date = new DateTime();
            try
            {
                Date = Convert.ToDateTime(txtDate.Text.Trim(), dateInfo);

            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }

            if (ddlDate.SelectedItem.Text == "Select")
            {
                utility.MessageBox(this, "Please select closing Date First!");
                GridView1.Visible = false;

            }
            else
            {
                
                string[] date = ddlDate.SelectedItem.Text.Split('-');
                string frmdt = date[0].ToString();
                string todt = date[1].ToString();
                cmd = new SqlCommand("updatechqdate", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@cdate", Date);
                cmd.Parameters.AddWithValue("@frmdt", frmdt);
                cmd.Parameters.AddWithValue("@todt", todt);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                txtDate.Text = string.Empty;
                selectdata(frmdt, todt);
            }
        }
        else
            utility.MessageBox(this, "Records not found for date change.");
    
    }
    
}
