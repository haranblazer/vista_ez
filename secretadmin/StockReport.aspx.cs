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
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Text.RegularExpressions;

public partial class Admin_StockReport : System.Web.UI.Page
{

    DataTable t1 = new DataTable();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    utility u = new utility();
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
               txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
               txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
               go1();

           }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        go1();

    }


      protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        dglst.PageIndex = e.NewPageIndex;
        go1();

    }


    public void go1()
    {
        try
        {

            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();



            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);

            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {

                da = new SqlDataAdapter("Select productid,Productname,Qty from shopproductmst where CAST(FLOOR(CAST(doe as float)) as datetime) between @mindate and @maxdate", con);
              
                da.SelectCommand.Parameters.AddWithValue("@mindate", fromDate.ToString());
                da.SelectCommand.Parameters.AddWithValue("@maxdate", toDate.ToString());


                DataTable t = new DataTable();

                da.Fill(t);

                if (t.Rows.Count > 0)
                {
                    Label2.Text = "No of Records :" + t.Rows.Count.ToString();
                    dglst.DataSource = t;
                    dglst.DataBind();

                }
                else
                {
                    dglst.DataSource = null;
                    dglst.DataBind();
                }


            }

            else
            {
                dglst.DataSource = null;
                dglst.DataBind();
                utility.MessageBox(this, "Invalid date");

            }

        }

        catch
        {
        }

    }
}