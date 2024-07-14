using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class User_downstatusInv : System.Web.UI.Page
{
    SqlConnection con;
    SqlDataAdapter da;
    DataTable dt;
    utility objUtil; protected string cv;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                objUtil = new utility();
                bindgrid(objUtil.base64Decode(Request.QueryString["reg"].ToString()));
            }
        }
    }

    private void bindgrid(string reg)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com;
        SqlDataReader sdr;
        con.Open();
        com = new SqlCommand("BV", con);
        com.CommandType = CommandType.StoredProcedure;
        sdr = com.ExecuteReader();
        if (sdr.Read())
        {
            cv = sdr["PBV"].ToString();
        }
        sdr.Close();
        con.Close();

        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("DownReportBillDetail", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@regno", reg);
    
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            lblpname.Text = "Invoice Detail";
            lblnoofinv.Text = "No Of Invoices:" + dt.Compute("count(InvoiceNo)", "true");
            lblNRecord.Text = "Total "+cv+":  " + dt.Compute("sum(CV)", "true");
            lblNoP.Text = "Total Amount:  " + dt.Compute("sum(amount)", "true");
            GridView1.DataSource = dt;
            GridView1.DataBind();
            GridView1.HeaderRow.Cells[5].Text = cv;
            ViewState["r"] = dt.Rows.Count.ToString();
        }
        else
        {
            ViewState["r"] = "1";
            lblNRecord.Text = "No Of Records:0";
            lblNoP.Text = "No of Products:0";
            GridView1.DataSource = null;
            GridView1.DataBind();
            GridView1.EmptyDataText = "Record not found !";
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        objUtil = new utility();
        bindgrid(objUtil.base64Decode(Request.QueryString["reg"].ToString()));
              
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        objUtil = new utility();
        string value = ddlPageSize.SelectedItem.Text;
        value = value.ToString() == "All" ? ViewState["r"].ToString() : value;
        GridView1.PageSize = Int32.Parse(value);
        bindgrid(objUtil.base64Decode(Request.QueryString["reg"].ToString()));
             
    }
}