using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;

public partial class User_CancelOrderList : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] != null)
        {
            regno = Session["userId"].ToString();
            if (!IsPostBack)
                BindGrid();
        }
        else
            Response.Redirect("loginagain.aspx", false);
    }

    private void BindGrid()
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlDataAdapter ad = new SqlDataAdapter("usercancelist", con);
            ad.SelectCommand.CommandType = CommandType.StoredProcedure;
            ad.SelectCommand.Parameters.AddWithValue("@regno", regno);
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
                GridView1.EmptyDataText = "No data";
                GridView1.DataBind();

            }

            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();

            }
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
}
