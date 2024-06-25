using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System;
using System.Web;

public partial class secretadmin_ProductWiseSale : System.Web.UI.Page
{
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
            Response.Redirect("logout.aspx");
        }

        if (!Page.IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-7).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");

            bindgrid();
        }
    }



    public void bindgrid()
    {
        string fromDate = "", toDate = "";
        try
        {
            if (txtFromDate.Text.Trim().Length > 0)
            {
                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
            if (txtToDate.Text.Trim().Length > 0)
            {
                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
        }
        catch
        {
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }

        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@min", fromDate),
            new SqlParameter("@max", toDate) ,
            new SqlParameter("@BillType", ddl_PackeType.SelectedValue)
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetProductWiseAssociateSale");
        if (dt.Rows.Count > 0)
        {
            GridView1.Columns[3].FooterText = dt.Compute("sum(TopperQty)", "true").ToString();
            GridView1.Columns[4].FooterText = dt.Compute("sum(GenerationQty)", "true").ToString();
            GridView1.Columns[5].FooterText = dt.Compute("sum(FreeSamplesQty)", "true").ToString();
            GridView1.Columns[6].FooterText = dt.Compute("sum(LoyaltyQty)", "true").ToString();
            GridView1.Columns[7].FooterText = dt.Compute("sum(OfferQty)", "true").ToString();
            GridView1.Columns[8].FooterText = dt.Compute("sum(TotalQty)", "true").ToString();
            GridView1.Columns[10].FooterText = dt.Compute("sum(Purchasevalue)", "true").ToString();

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindgrid();
    }


    protected void btnSearchByDate_Click(object sender, EventArgs e)
    {
        bindgrid();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            bindgrid();
            //GridView1.Columns[16].Visible = GridView1.Columns[17].Visible = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductWiseAssociateSale.xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }
}
 