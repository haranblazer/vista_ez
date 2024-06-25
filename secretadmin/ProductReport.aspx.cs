using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml;
using System.IO;


public partial class secretadmin_ProductReport : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = null;
    SqlDataAdapter da=null;
    utility u = new utility();
    string regno, name = "";
    XmlDocument xmldoc = new XmlDocument();
    string xmlfile = "";
    double tax;
    double taxamount, sum2 = 0, sum4 = 0, sum5 = 0, sum10 = 0, sum12 = 0;
    int invoiceno;
    double amount;
    DateTime date;

    double tax2 = 0, tax4 = 0, tax5 = 0, tax10 = 0, tax12 = 0;    

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            show();
        }
    }

    public void show()
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
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }
        dt = new DataTable();
        da = new SqlDataAdapter("productreport1", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@min", fromDate);
        da.SelectCommand.Parameters.AddWithValue("@max", toDate);
        da.Fill(dt);

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



    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        dglst.PageIndex = e.NewPageIndex;
        dglst.EditIndex = -1;

    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        show();

    }
}