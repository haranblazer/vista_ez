using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Drawing;
using System.Xml;

public partial class secretadmin_BillReport : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    utility objutil;

    string strmin = "";
    string strmax = "";
    string sttype1 = "";
    string strmin1 = "";
    string strmax1 = "";

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

        checkpage();
        if (!IsPostBack)
        {
          
            BindGrid();
        }
    }

    /// <summary>
    /// //By <S>
    /// </summary>
    private void BindGrid()
    {
        try
        {
            strmin1 = Request.QueryString["min"].ToString();
            strmax1 = Request.QueryString["max"].ToString();
            sttype1 = Request.QueryString["t"].ToString();
           
            con = new SqlConnection(method.str);
            SqlDataAdapter ad = new SqlDataAdapter("AssociateBreport", con);
            ad.SelectCommand.CommandType = CommandType.StoredProcedure;
          

            ad.SelectCommand.Parameters.AddWithValue("@min", strmin1);
            ad.SelectCommand.Parameters.AddWithValue("@max", strmax1);
            ad.SelectCommand.Parameters.AddWithValue("@billtype", sttype1);

           
            dt = new DataTable();
            ad.Fill(dt);
            DataColumn dcDtl = new DataColumn("tbl", typeof(string));
            DataColumn sr1 = new DataColumn("srno1", typeof(string));
            dt.Columns.Add(dcDtl);
            dt.Columns.Add(sr1);
            int c = 0;
            foreach (DataRow row in dt.Rows)
            {

                DataRow dr = row;
                objutil = new utility();
                row.SetField("srno1", objutil.base64Encode(row["srno"].ToString()));
                string rrrrrrrrrr = row["srno1"].ToString();
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

            if (dt.Rows.Count > 0)
            {
                lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
                lblTotal.Text += ", Gross: " + (string.IsNullOrEmpty(dt.Compute("sum(grossamt)", "true").ToString()) ? "0.00" : dt.Compute("sum(grossamt)", "true").ToString());
                lblTotal.Text += ", Amount: " + (string.IsNullOrEmpty(dt.Compute("sum(amt)", "true").ToString()) ? "0.00" : dt.Compute("sum(amt)", "true").ToString());
                lblTotal.Text += ", Tax: " + (string.IsNullOrEmpty(dt.Compute("sum(tax)", "true").ToString()) ? "0.00" : dt.Compute("sum(tax)", "true").ToString());
                lblTotal.Text += ", Net: " + (string.IsNullOrEmpty(dt.Compute("sum(netAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(netAmt)", "true").ToString());
            }

            else
            {
                lblTotal.Text = "";
            }

            GridView1.DataSource = dt;
            GridView1.DataBind();
           
        }
        catch (Exception ex)
        {
        }
    }

    /// <summary>
    /// //By <S>
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    /// <summary>
    /// //By <S>
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
   
    

  
   


 
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {

        try
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                BindGrid();
                GridView1.Columns[13].Visible = GridView1.Columns[14].Visible = false;
                GridView1.Columns[15].Visible = false;
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductBillingList.xls");
                Response.ContentType = "application/vnd.xls";
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
        catch
        {

        }
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                BindGrid();
                GridView1.Columns[13].Visible = GridView1.Columns[14].Visible = false;
                GridView1.Columns[15].Visible = false;
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductBillingList.doc");
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
        catch
        {

        }
    }



    public void checkpage()
    {
        SqlDataReader dr;
        con = new SqlConnection(method.str);
        com = new SqlCommand("pageprocess", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@action", "1");
        con.Open();
        dr = com.ExecuteReader();
        while (dr.Read())
        {
            if (dr["billing"].ToString() == "OFF")
            {

                Response.Redirect("~/error.aspx");
            }
        }
    }

}

