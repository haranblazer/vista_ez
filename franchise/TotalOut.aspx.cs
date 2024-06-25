using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Xml;
using System.Xml.Linq;
public partial class admin_TotalOut : System.Web.UI.Page
{
    SqlConnection con;
    SqlDataAdapter da;
    DataTable dt;
    utility objUtil;
    public string ProductName = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
        {
            Response.Redirect("../Default.aspx");
        }
        if (!Page.IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                objUtil = new utility();
                bindgrid(Convert.ToInt32(objUtil.base64Decode(Request.QueryString["pid"].ToString()))
                    ,objUtil.base64Decode(Request.QueryString["typ"].ToString())
                    , objUtil.base64Decode(Request.QueryString["From"].ToString())
                    , objUtil.base64Decode(Request.QueryString["To"].ToString()));
            }
        }
    }
    private void bindgrid(int pid, string typ, string From, String To)
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("PurchaseTranDetail", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@regno", Session["franchiseid"].ToString());
        da.SelectCommand.Parameters.AddWithValue("@pid", pid);
        da.SelectCommand.Parameters.AddWithValue("@mode", typ);
        da.SelectCommand.Parameters.AddWithValue("@From", From);
        da.SelectCommand.Parameters.AddWithValue("@To", To);
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            // lblNRecord.Text = "No Of Records : " + dt.Rows.Count + ",";
            /// lblNoP.Text = "Total Quantity : " + dt.Compute("sum(Quantity)", "true");
            GridView1.Columns[3].FooterText = "Total :";
            GridView1.Columns[10].FooterText = dt.AsEnumerable().Select(x => x.Field<int>("Quantity")).Sum().ToString();
            GridView1.Columns[11].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("DP Rate")).Sum().ToString();
            GridView1.Columns[12].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("DP With Tax")).Sum().ToString();
            GridView1.Columns[13].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("RPV")).Sum().ToString();
            GridView1.Columns[14].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("TPV")).Sum().ToString();

            ViewState["TotalInstockReport"] = dt;
            GridView1.DataSource = dt;
            GridView1.DataBind();
            ViewState["r"] = dt.Rows.Count.ToString();
        }
        else
        {
            lblNRecord.Text = "No Of Records:0";
            lblNoP.Text = "No of Products:0";
            GridView1.DataSource = null;
            GridView1.DataBind();
            GridView1.EmptyDataText = "Record not found !";
        }

        DataUtility objDu = new DataUtility();
        SqlParameter[] param1 = new SqlParameter[] {  new SqlParameter("@pid", pid) };
        DataTable dtnew = objDu.GetDataTable(param1, @"Select ProductName=s.ProductCode + ' ' +s.ProductName +SPACE(1)+ s.PackSize +SPACE(1)+(Select PackSize from PackSizemst where srno=s.PackSizeUnitId) 
        from ShopProductMst s where s.ProductId=@pid");
        if (dtnew.Rows.Count > 0) 
        {
            ProductName= dtnew.Rows[0]["ProductName"].ToString();
        }
    }
    
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        GridView1.PageIndex = e.NewPageIndex;
        objUtil = new utility();
        bindgrid(Convert.ToInt32(objUtil.base64Decode(Request.QueryString["bid"].ToString()))
            , objUtil.base64Decode(Request.QueryString["pid"].ToString())
            , objUtil.base64Decode(Request.QueryString["From"].ToString())
            ,  objUtil.base64Decode(Request.QueryString["To"].ToString()));

    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void ImageButton_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            DataTable dt = (DataTable)ViewState["TotalInstockReport"];
            GridView1.DataSource = dt;
            GridView1.DataBind();
            GridView1.AllowPaging = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Transaction.xls");
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