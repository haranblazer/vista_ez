using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_TotalCancel : System.Web.UI.Page
{
    SqlConnection con;
    SqlDataAdapter da;
    DataTable dt;
    utility objUtil;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                objUtil = new utility();
                bindgrid(Convert.ToInt32(objUtil.base64Decode(Request.QueryString["bid"].ToString())), Convert.ToInt32(objUtil.base64Decode(Request.QueryString["pid"].ToString())));

            }
        }
    }


    private void bindgrid(int bid, int pid)
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("StockInhand", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@regno", Session["admin"].ToString());
        da.SelectCommand.Parameters.AddWithValue("@batchid", bid);
        da.SelectCommand.Parameters.AddWithValue("@productid", pid);
        da.SelectCommand.Parameters.AddWithValue("@type", "4");
        dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {
            lblpname.Text = "Product Name-" + dt.Rows[0]["pname"].ToString();
            lblCode.Text = "Product Code:" + pid + ",";
            lblNRecord.Text = "No Of Records:" + dt.Rows.Count + ",";
            lblNoP.Text = "No of Products:" + dt.Compute("sum(canqty)", "true");

            GridView1.DataSource = dt;
            GridView1.DataBind();
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
        bindgrid(Convert.ToInt32(objUtil.base64Decode(Request.QueryString["bid"].ToString())), Convert.ToInt32(objUtil.base64Decode(Request.QueryString["pid"].ToString())));

    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        objUtil = new utility();
        string value = ddlPageSize.SelectedItem.Text;
        value = value.ToString() == "All" ? ViewState["r"].ToString() : value;
        GridView1.PageSize = Int32.Parse(value);
        bindgrid(Convert.ToInt32(objUtil.base64Decode(Request.QueryString["bid"].ToString())), Convert.ToInt32(objUtil.base64Decode(Request.QueryString["pid"].ToString())));

    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        objUtil = new utility();

        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];

        string pid = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
        string sid = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
        string soldToFlag = GridView1.DataKeys[row.RowIndex].Values[2].ToString();
        string soldbyFlag = GridView1.DataKeys[row.RowIndex].Values[3].ToString();
        if (e.CommandName == "CancelBill")
        {
            Response.Redirect("TotalCancelOutBill.aspx?pid=" + objUtil.base64Encode(pid) + "&sid=" + objUtil.base64Encode(sid) + "&stof=" + objUtil.base64Encode(soldToFlag) + "&sbyf=" + objUtil.base64Encode(soldbyFlag) + "&bby=c");
        }
    }
}