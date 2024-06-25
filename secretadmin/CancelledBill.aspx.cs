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


public partial class admin_CancelledBill : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    utility objutil;


    XmlDocument xmldoc = new XmlDocument();

    DataUtility objDUT = null;

    string a = "";
    string b = "";
    string c = "";
    int pbv;

    string salesrep = "";

    string xmlfile = "";
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
            //InsertFunction.CheckAdminlogin();
            txtFromDate.Text = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy");
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
            //string str = "%" + txtSearch.Text + "%";
            con = new SqlConnection(method.str);
            //SqlDataAdapter ad = new SqlDataAdapter("select o.srno,o.appmstid,DATENAME(MONTH,o.doe) as monthname,o.status,SalesRep=case  o.salesrep when 'admin' then 'admin' else (select appmstfname from AppMst where AppMstRegNo=o.SalesRep) end,o.grossamt,a.appmstregno as regno,a.appmstfname as fname,o.NoOFProduct,o.Amount as amt,ToAddress as adrs,o.TaxRs as tax,o.DelCharge,o.Discount,o.netAmt,Detail as dtl, " +
            //    "CONVERT(varchar,Doe,103) AS doe from BillMst o inner join appmst a on a.appmstid=o.appmstid and o.status=0 " +
            //    "and (a.AppMstRegNo like @search or  a.AppMstFName like @search or o.Amount  like @search or o.srno like @search) and " +
            //    "(case when @min is null or len(@min)=0 then 1 when @min is not null and @min<>'' and  cast(floor(cast(o.Doe as float)) as datetime)>=cast(floor(cast(convert(datetime,@min) as float)) as datetime) then 1 " +
            //    "else 0 end)=1 " +
            //    "and  " +
            //    "(case when @max is null or LEN(@max)=0 then 1 when @max is not null and @max <>'' and cast(floor(cast(o.Doe as float)) as datetime)<=cast(floor(cast(convert(datetime,@max) as float)) as datetime) then 1 " +
            //    "else 0 end)=1  " +
            //    "order by o.doe desc ", con);
            SqlDataAdapter ad = new SqlDataAdapter("cancelledbillsearch", con);
            ad.SelectCommand.CommandType = CommandType.StoredProcedure;
            ad.SelectCommand.Parameters.AddWithValue("@search", txtSearch.Text == "" ? "" : txtSearch.Text);
            ad.SelectCommand.Parameters.AddWithValue("@min", strmin);
            ad.SelectCommand.Parameters.AddWithValue("@max", strmax);
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

            GridView1.DataSource = dt;
            GridView1.DataBind();
            if (dt.Rows.Count > 0)
            {
                lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
                lblTotal.Text += ", Gross: " + (string.IsNullOrEmpty(dt.Compute("sum(grossamt)", "true").ToString()) ? "0.00" : dt.Compute("sum(grossamt)", "true").ToString());
                lblTotal.Text += ", Amount: " + (string.IsNullOrEmpty(dt.Compute("sum(amt)", "true").ToString()) ? "0.00" : dt.Compute("sum(amt)", "true").ToString());
                lblTotal.Text += ", Tax: " + (string.IsNullOrEmpty(dt.Compute("sum(tax)", "true").ToString()) ? "0.00" : dt.Compute("sum(tax)", "true").ToString());
                lblTotal.Text += ", Net: " + (string.IsNullOrEmpty(dt.Compute("sum(netAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(netAmt)", "true").ToString());
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

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       

    }
 
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{

        //    LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkbtnEdit1");
        //    Label ll = (Label)e.Row.FindControl("Label1");
           

        //    if (int.Parse(ll.Text) == 0)
        //    {
        //        lnkbtn.Enabled = false;
        //        lnkbtn.Text = "Order Cancelled";
        //        lnkbtn.ForeColor = Color.Red;
        //    }



        //}

    }


    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {



        BindGrid1();


    }


    private void BindGrid1()
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
            string str = "%" + txtSearch.Text + "%";
            con = new SqlConnection(method.str);
            SqlDataAdapter ad = new SqlDataAdapter("select o.srno,o.appmstid,DATENAME(MONTH,o.doe) as monthname,o.status,SalesRep=case  o.salesrep when 'admin' then 'admin' else (select appmstfname from AppMst where AppMstRegNo=o.SalesRep) end,o.grossamt,a.appmstregno as regno,a.appmstfname as fname,o.NoOFProduct,o.Amount as amt,ToAddress as adrs,o.TaxRs as tax,o.DelCharge,o.Discount,o.netAmt,Detail as dtl, " +
                "CONVERT(varchar,Doe,103) AS doe from BillMst o inner join appmst a on a.appmstid=o.appmstid and o.status=0 and o.SalesRepId='" + DropDownList1.SelectedValue + "'" +
                "and (a.AppMstRegNo like @search or  a.AppMstFName like @search or o.Amount  like @search or o.srno like @search) and " +
                "(case when @min is null or len(@min)=0 then 1 when @min is not null and @min<>'' and  cast(floor(cast(o.Doe as float)) as datetime)>=cast(floor(cast(convert(datetime,@min) as float)) as datetime) then 1 " +
                "else 0 end)=1 " +
                "and  " +
                "(case when @max is null or LEN(@max)=0 then 1 when @max is not null and @max <>'' and cast(floor(cast(o.Doe as float)) as datetime)<=cast(floor(cast(convert(datetime,@max) as float)) as datetime) then 1 " +
                "else 0 end)=1  " +
                "order by o.doe desc ", con);
            ad.SelectCommand.Parameters.AddWithValue("@search", str);
            ad.SelectCommand.Parameters.AddWithValue("@min", strmin);
            ad.SelectCommand.Parameters.AddWithValue("@max", strmax);
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

            GridView1.DataSource = dt;
            GridView1.DataBind();
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
                lblTotal.Text = "No Record";
            }
        }
        catch (Exception ex)
        {
        }
    }


    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

    }
}

