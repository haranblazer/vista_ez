using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_DocApproveList : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand cmd = null;
    int recordCount = 0;
    static int x = 1;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            x = 1;
            Bind(1);
        }
        lbltotalrecord.Text = "Current Page" + " " + x;
    }

    private void Bind(int pageIndex)
    {

        try
        {
            con = new SqlConnection(method.str);

            cmd = new SqlCommand("docapprovedbyadmin", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
            cmd.Parameters.AddWithValue("@PageSize", 50);
            cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4);

            cmd.Parameters["@RecordCount"].Direction = ParameterDirection.Output;
            con.Open();

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridDocsApprove.DataSource = dt;
            GridDocsApprove.DataBind();
            //idr.Close();
            con.Close();
            int recordCount = Convert.ToInt32(cmd.Parameters["@RecordCount"].Value);
            this.PopulatePager(recordCount, pageIndex);

            double dblPageCount = (double)((decimal)recordCount / 50);
            int pageCount = (int)Math.Ceiling(dblPageCount);

            Label1.Text = "Total Record" + " " + recordCount;
            lblControl.Text = "Total Page" + "" + pageCount;

            lbltotalrecord.Text = "Current Page" + " " + x;


            double dblPageCount1 = (double)((decimal)recordCount / 20);
            int pageCount1 = (int)Math.Ceiling(dblPageCount);

            if (pageCount == x)
            {
                btnnext.Enabled = false;
            }
            else
            {
                btnnext.Enabled = true;
            }
            if (x == 1)
            {
                btnpre.Enabled = false;
            }
            else
            {
                btnpre.Enabled = true;
            }


        }
        catch
        {
        }
    }

    protected void btnsearch2_Click(object sender, EventArgs e)
    {
        utility obj = new utility();
        if (!string.IsNullOrEmpty(txtsearch1.Text.Trim()) && !obj.IsValiduserid(txtsearch1.Text.Trim()))
        {
            utility.MessageBox(this, "Invalid page Number!");

            return;
        }

        if (txtsearch1.Text == "")
        {
            string message = "alert('Please Enter page Number .')";
            ScriptManager.RegisterClientScriptBlock((this as Control), this.GetType(), "alert", message, true);

        }
        else
        {

            int y = Convert.ToInt32(txtsearch1.Text);
            x = y;
            lbltotalrecord.Text = "Current Page" + " " + x;
            Bind(y);
        }

    }

    private void PopulatePager(int recordCount, int currentPage)
    {
        double dblPageCount = (double)((decimal)recordCount / 50);
        int pageCount = (int)Math.Ceiling(dblPageCount);
        List<ListItem> pages = new List<ListItem>();
        if (pageCount > 0)
        {
            pages.Add(new ListItem("First", "1", currentPage > 1));
            for (int i = 1; i <= pageCount; i++)
            {
                pages.Add(new ListItem(i.ToString(), i.ToString(), i != currentPage));
            }
            pages.Add(new ListItem("Last", pageCount.ToString(), currentPage < pageCount));
        }


        rptPager.DataSource = pages;
        rptPager.DataBind();
    }
    protected void PageSize_Changed(object sender, EventArgs e)
    {
        this.Bind(1);
    }
    protected void Page_Changed(object sender, EventArgs e)
    {
        int pageIndex = int.Parse((sender as LinkButton).CommandArgument);
        this.Bind(pageIndex);
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        Bind(1);
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void GridDocsApprove_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridDocsApprove.PageIndex = e.NewPageIndex;
        Bind(1);

    }
    protected void btnnext_Click(object sender, EventArgs e)
    {
        double dblPageCount = (double)((decimal)recordCount / 20);
        int pageCount = (int)Math.Ceiling(dblPageCount);
        x++;
        int i = 1;

        lbltotalrecord.Text = "Current Page" + " " + x;

        for (i = 1; i >= pageCount; i++)
        {

            if (x == i)
            {
                Bind(x);
                break;
            }
        }


    }
    protected void btnpre_Click(object sender, EventArgs e)
    {
        double dblPageCount = (double)((decimal)recordCount / 20);
        int pageCount = (int)Math.Ceiling(dblPageCount);

        x--;
        int i = 1;
        lbltotalrecord.Text = "Current Page" + " " + x;


        for (i = 1; i >= pageCount; i++)
        {

            if (x == i)
            {
                Bind(x);
                break;
            }
        }
    }

    protected void lnknext_Click(object sender, EventArgs e)
    {
        double dblPageCount = (double)((decimal)recordCount / 20);
        int pageCount = (int)Math.Ceiling(dblPageCount);
        x++;
        int i = 1;

        lbltotalrecord.Text = "Current Page" + " " + x;

        for (i = 1; i >= pageCount; i++)
        {

            if (x == i)
            {
                Bind(x);
                break;
            }
        }
    }

    protected void lnlprev_Click(object sender, EventArgs e)
    {
        double dblPageCount = (double)((decimal)recordCount / 20);
        int pageCount = (int)Math.Ceiling(dblPageCount);

        x--;
        int i = 1;
        lbltotalrecord.Text = "Current Page" + " " + x;


        for (i = 1; i >= pageCount; i++)
        {

            if (x == i)
            {
                Bind(x);
                break;
            }
        }
    }
}












