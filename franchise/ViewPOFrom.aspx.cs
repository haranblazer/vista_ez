using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;


public partial class franchise_ViewPOFrom : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    //By <S>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Default.aspx");
        }
        if (!IsPostBack)
        {
            //InsertFunction.CheckAdminlogin();
            txtFromDate.Text = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy");
            BindGrid();

        }
    }

    private void BindUserID()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        //ViewState["Count"] = null;
        try
        {
            DataTable dtt = new DataTable();
            da = new SqlDataAdapter("select appmstregno,appmstfname from appmst", con);
            da.SelectCommand.Parameters.AddWithValue("@uname", Session["UserName"].ToString());
            da.Fill(dtt);

            List<string> objProductList = new List<string>(); ;
            String strPrdPrice = string.Empty;
            divUserID.InnerText = string.Empty;
            foreach (DataRow drw in dtt.Rows)
            {
                divUserID.InnerText += drw["appmstregno"].ToString() + ",";
            }
        }
        catch
        {
        }
        finally
        {
        }
    }


    private void BindGrid()
    {
        try
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            string strmin = "";
            string strmax = "";
            try
            {
                if (txtFromDate.Text.Trim().Length > 0)
                    strmin = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo).ToString();
                if (txtToDate.Text.Trim().Length > 0)
                    strmax = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo).ToString();
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }

            double datedays = (Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo) - Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo)).TotalDays;
            if (datedays > 31)
            {
                utility.MessageBox(this, "Maximum 31 days allowed");
                GridView1.DataSource = null;
                GridView1.DataBind();
                return;
            }

            //string str = "%" + txtSearch.Text + "%";




            con = new SqlConnection(method.str);



            SqlDataAdapter ad = new SqlDataAdapter("PurchaseToOrderList", con);
            ad.SelectCommand.CommandType = CommandType.StoredProcedure;
            ad.SelectCommand.Parameters.AddWithValue("@search", "");
            ad.SelectCommand.Parameters.AddWithValue("@min", strmin);
            ad.SelectCommand.Parameters.AddWithValue("@max", strmax);
            ad.SelectCommand.Parameters.AddWithValue("@userid", Session["franchiseid"].ToString());
            dt = new DataTable();
            ad.Fill(dt);
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
            if (dt.Rows.Count > 0)
            {
                lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();

                lblTotal.Text += ", Amount: " + (string.IsNullOrEmpty(dt.Compute("sum(amt)", "true").ToString()) ? "0.00" : dt.Compute("sum(amt)", "true").ToString());

            }

            else
            {
                lblTotal.Text = "No Data";
            }
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
}
