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
public partial class admin_TotalIn : System.Web.UI.Page
{
    SqlConnection con;
    SqlDataAdapter da;
    DataTable dt;
    utility objUtil;
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
                bindgrid(Convert.ToInt32(objUtil.base64Decode(Request.QueryString["pid"].ToString())), Convert.ToInt32(objUtil.base64Decode(Request.QueryString["typ"].ToString())));
            }
        }
    }
    private void bindgrid(int pid, int typ)
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("StockInhandDetail", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@regno", Session["franchiseid"].ToString());
        da.SelectCommand.Parameters.AddWithValue("@pid", pid);
        da.SelectCommand.Parameters.AddWithValue("@mode", typ);
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            //lblpname.Text = "Product Name-" + dt.Rows[0]["Item_Desc"].ToString();
            //lblCode.Text = "Mode : " + dt.Rows[0]["Item_Desc"].ToString() + ", ";
            lblNRecord.Text ="No Of Records : " + dt.Rows.Count + ",";
            lblNoP.Text = "Total Quantity : " + dt.Compute("sum(Quantity)", "true");
            ViewState["TotalInstock"] = dt;
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
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        GridView1.PageIndex = e.NewPageIndex;
        objUtil = new utility();
        bindgrid(Convert.ToInt32(objUtil.base64Decode(Request.QueryString["bid"].ToString())), Convert.ToInt32(objUtil.base64Decode(Request.QueryString["pid"].ToString())));

    }
    //protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (ViewState["r"] != null)
    //    {
    //        objUtil = new utility();
    //        string value = ddlPageSize.SelectedItem.Text;
    //        value = value.ToString() == "All" ? ViewState["r"].ToString() : value;
    //        GridView1.PageSize = Int32.Parse(value);
    //        bindgrid(Convert.ToInt32(objUtil.base64Decode(Request.QueryString["bid"].ToString())), Convert.ToInt32(objUtil.base64Decode(Request.QueryString["pid"].ToString())));
    //    }
    //}
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void ImageButton_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            DataTable dt = (DataTable)ViewState["TotalInstock"];
            GridView1.DataSource = dt;
            GridView1.DataBind();
            GridView1.AllowPaging = false;
            //Grdreport.Columns[16].Visible = Grdreport.Columns[17].Visible = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_StockList.xls");
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
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            DataTable dt = (DataTable)ViewState["TotalInstock"];
            GridView1.DataSource = dt;
            GridView1.DataBind();
            GridView1.AllowPaging = false;
            // Grdreport.Columns[16].Visible = Grdreport.Columns[17].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_StockList.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "can not export as no data found !");
        }
    }
}