using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class admin_CancelfranchiseBill : System.Web.UI.Page
{

    DataTable dt = null;
    SqlConnection con = null;
    string strmin = "";
    string strmax = "";


    SqlDataAdapter sda = null;
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
            txtFromDate.Text = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy");
            BindGrid();
        }
    }


    public void BindGrid()
    {

        try
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";


            if (txtFromDate.Text.Trim().Length > 0)
                strmin = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo).ToString();
            if (txtToDate.Text.Trim().Length > 0)
                strmax = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo).ToString();


            con = new SqlConnection(method.str);
            sda = new SqlDataAdapter("bill", con);
            sda.SelectCommand.CommandType = CommandType.StoredProcedure;
            sda.SelectCommand.Parameters.AddWithValue("@action", "franchise");
            sda.SelectCommand.Parameters.AddWithValue("@fromDate", strmin);
            sda.SelectCommand.Parameters.AddWithValue("@toDate", strmax);



            dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();

        }

        catch (Exception ex)
        {
        }

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        con = new SqlConnection(method.str);
        sda = new SqlDataAdapter("bill", con);
        sda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sda.SelectCommand.Parameters.AddWithValue("@franchiseaction", "@faction1");
        sda.SelectCommand.Parameters.AddWithValue("@franchisesearch", txtSearch.Text);
        dt = new DataTable();
        sda.Fill(dt);
        GridView1.DataSource = dt;
        GridView1.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            con.Open();
            GridView gv = (GridView)e.Row.FindControl("gvOrders");
            int invoiceno = Convert.ToInt32(e.Row.Cells[1].Text);
            SqlCommand cmd = new SqlCommand("select (select productname from ShopProductMst where ProductId=f.productid) as pname,f.Productid,f.Quantity from FranchiseProductCancel f where invoiceno='" + invoiceno + "'", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            con.Close();
            gv.DataSource = ds;
            gv.DataBind();
        }
    }

}