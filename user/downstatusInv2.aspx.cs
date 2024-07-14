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
            try
            {
                if (Request.QueryString.Count > 0)
                {
                    objUtil = new utility();

                    bindgrid(objUtil.base64Decode(Request.QueryString["reg"].ToString()), objUtil.base64Decode(Request.QueryString["type"].ToString()), objUtil.base64Decode(Request.QueryString["min"].ToString()), objUtil.base64Decode(Request.QueryString["max"].ToString()));
                    //bindgrid(Request.QueryString["reg"].ToString(), Request.QueryString["type"].ToString(), Request.QueryString["min"].ToString(), Request.QueryString["max"].ToString());

                }
            }
            catch
            {
            }
        }
    }

    private void bindgrid(string reg,string type,string min,string max)
    {
        try
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


            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();

            fromDate = Convert.ToDateTime(min.Trim(), dateInfo);
            toDate = Convert.ToDateTime(max.Trim(), dateInfo);


            con = new SqlConnection(method.str);
            da = new SqlDataAdapter("DownReportBillDetail2", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@regno", reg);
            da.SelectCommand.Parameters.AddWithValue("@type", type);
            da.SelectCommand.Parameters.AddWithValue("@min", fromDate);
            da.SelectCommand.Parameters.AddWithValue("@max", toDate);

            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lblpname.Text = "Invoice Detail";
                lblnoofinv.Text = "No Of Invoices:" + dt.Compute("count(InvoiceNo)", "true");
                lblNRecord.Text = "Total " + cv + ":  " + dt.Compute("sum(CV)", "true");
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
        catch
        {
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            GridView1.PageIndex = e.NewPageIndex;
            objUtil = new utility();

            //bindgrid(Request.QueryString["reg"].ToString(), Request.QueryString["type"].ToString(), Request.QueryString["min"].ToString(), Request.QueryString["max"].ToString());
            bindgrid(objUtil.base64Decode(Request.QueryString["reg"].ToString()), objUtil.base64Decode(Request.QueryString["type"].ToString()), objUtil.base64Decode(Request.QueryString["min"].ToString()), objUtil.base64Decode(Request.QueryString["max"].ToString()));
        }
        catch
        {
        }
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            objUtil = new utility();
            string value = ddlPageSize.SelectedItem.Text;
            value = value.ToString() == "All" ? ViewState["r"].ToString() : value;
            GridView1.PageSize = Int32.Parse(value);
            //bindgrid(Request.QueryString["reg"].ToString(), Request.QueryString["type"].ToString(), Request.QueryString["min"].ToString(), Request.QueryString["max"].ToString());
            bindgrid(objUtil.base64Decode(Request.QueryString["reg"].ToString()), objUtil.base64Decode(Request.QueryString["type"].ToString()), objUtil.base64Decode(Request.QueryString["min"].ToString()), objUtil.base64Decode(Request.QueryString["max"].ToString()));
        }
        catch
        {
        }
    }
}