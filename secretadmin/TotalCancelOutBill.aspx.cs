using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Xml.Linq;
using System.Xml;
using System.Drawing;
using System.Text;

public partial class secretadmin_TotalCancelOutBill : System.Web.UI.Page
{
    SqlConnection con;
    SqlDataAdapter da;
    DataTable dt;
    utility objUtil;
    string soldto,stfby,sbf;
    int status;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                objUtil = new utility();
               soldto=objUtil.base64Decode(Request.QueryString["sid"].ToString());
                stfby= objUtil.base64Decode(Request.QueryString["stof"].ToString());
                sbf= objUtil.base64Decode(Request.QueryString["sbyf"].ToString());             
                if ("c" == Request.QueryString["bby"].ToString())
                {
                    lblheader.Text = "Total Cancel";
                    status = 0;
                }
                else if ("O" == Request.QueryString["bby"].ToString())
                {
                    lblheader.Text = "Total Out";
                    status = 1;
                }
                BindGrid(soldto, stfby, sbf);
            }
        }
    }
    private void BindGrid(string soldto,string stfby,string sbf)
    {
        try
        {
           
            con = new SqlConnection(method.str);
            SqlDataAdapter ad = new SqlDataAdapter("Totaloutcancel", con);
            ad.SelectCommand.CommandType = CommandType.StoredProcedure;
            ad.SelectCommand.Parameters.AddWithValue("@soldto", soldto);            
            ad.SelectCommand.Parameters.AddWithValue("@soldbyflage", stfby);
            ad.SelectCommand.Parameters.AddWithValue("@soldtoflage", sbf);
            ad.SelectCommand.Parameters.AddWithValue("@status", status); 
            dt = new DataTable();
            ad.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                DataColumn dcDtl = new DataColumn("tbl", typeof(string));
                dt.Columns.Add(dcDtl);
                foreach (DataRow row in dt.Rows)
                {
                    XElement objXml = XElement.Parse(row["dtl"].ToString());
                    string strDtl = "<table rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
                    strDtl += "<tr><th>Name</th><th>Quantity</th><th>MRP</th><th>BV</th><th>Total</th></tr>";
                    foreach (XElement p in objXml.Elements("P"))
                    {
                        strDtl += "<tr>";
                        strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
                        strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
                        strDtl += "<td>" + p.Elements("MRP").FirstOrDefault().Value + "</td>";
                        strDtl += "<td>" + p.Elements("BV").FirstOrDefault().Value + "</td>";
                        strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
                        strDtl += "</tr>";
                    }
                    strDtl += "</table>";
                    row["tbl"] = strDtl;
                }

                GridView1.DataSource = dt;
                GridView1.DataBind();
                ViewState["r"] = dt.Rows.Count.ToString();
                if (dt.Rows.Count > 0)
                {
                    lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
                    lblTotal.Text += ", Gross: " + (string.IsNullOrEmpty(dt.Compute("sum(grossAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(grossAmt)", "true").ToString());
                    lblTotal.Text += ", Amount: " + (string.IsNullOrEmpty(dt.Compute("sum(Amount)", "true").ToString()) ? "0.00" : dt.Compute("sum(Amount)", "true").ToString());
                    lblTotal.Text += ", Tax: " + (string.IsNullOrEmpty(dt.Compute("sum(tax)", "true").ToString()) ? "0.00" : dt.Compute("sum(tax)", "true").ToString());
                    lblTotal.Text += ", Net: " + (string.IsNullOrEmpty(dt.Compute("sum(netAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(netAmt)", "true").ToString());
                }
            }
            else
            {
                ViewState["r"] = "1";
                GridView1.DataSource = null;
                GridView1.DataBind();
                GridView1.EmptyDataText = "No Of Records";
                lblTotal.Text = "";
            }

        }
        catch (Exception ex)
        {
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
           BindGrid(soldto,stfby,sbf);
            //Grdreport.Columns[16].Visible = Grdreport.Columns[17].Visible = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stockinhand.xls");
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
            GridView1.AllowPaging = false;
            BindGrid(soldto, stfby, sbf);
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stockinhand.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
          Label lbltype = (Label)e.Row.FindControl("lbltype");
            if (e.Row.RowType == DataControlRowType.DataRow)
            {                
                  if (lbltype.Text == "GSTBill")
                {
                    e.Row.Cells[1].Visible = true;
                    e.Row.Cells[2].Visible = false;
                    GridView1.Columns[1].Visible = true;
                    GridView1.Columns[2].Visible = false;
                }
                  else if (lbltype.Text == "StockGSTBill")
                  {
                      e.Row.Cells[1].Visible = false;
                      e.Row.Cells[2].Visible = true;
                      GridView1.Columns[2].Visible = true;
                      GridView1.Columns[1].Visible = false;
                  }
            }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid(soldto, stfby, sbf);
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        string value = ddlPageSize.SelectedItem.Text;
        value = value.ToString() == "All" ? ViewState["r"].ToString() : value;
        GridView1.PageSize = Int32.Parse(value);
        BindGrid(soldto, stfby, sbf);
    }
}