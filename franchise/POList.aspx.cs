using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

public partial class franchise_POList : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    XmlDocument xmldoc = new XmlDocument();
    DataUtility objDUT = null;
    string franchiseid = "";
    string invoiceno = "";
    int status = 0;
    string returnvalue;
    string strajax = "";
    string xmlfile = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("Logout.aspx");


        if (!IsPostBack)
        {
            DateTime now = DateTime.Now;
            var startDate = new DateTime(now.Year, now.Month, 1);

            txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");
            // BindGrid();

        }
    }




    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@Userid", HttpContext.Current.Session["franchiseid"].ToString()),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "POFranList");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.srno_Encode = objutil.base64Encode(dr["srno"].ToString());

                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.Status = dr["Status"].ToString(); 
                data.Status_Text = dr["Status_Text"].ToString();
                data.SalesRepId = dr["SalesRepId"].ToString();
                data.SellerName = dr["SellerName"].ToString();
                data.doe = dr["doe"].ToString();
                data.NoOFProduct = dr["NoOFProduct"].ToString();
                data.amt = dr["amt"].ToString();
                data.grossAmt = dr["grossAmt"].ToString();
                data.tax = dr["tax"].ToString();
                data.netAmt = dr["netAmt"].ToString();
                data.SellerState = dr["SellerState"].ToString();
                data.PlaceOfSupply = dr["PlaceOfSupply"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Status_Text { get; set; }
        public string srno_Encode { get; set; }

        public string InvoiceNo { get; set; } 
        public string Status { get; set; } 
        public string SalesRepId { get; set; }
        public string SellerName { get; set; }
        public string doe { get; set; }
        public string NoOFProduct { get; set; }
        public string amt { get; set; }
        public string grossAmt { get; set; }
        public string tax { get; set; }
        public string netAmt { get; set; }
        public string SellerState { get; set; }
        public string PlaceOfSupply { get; set; }
    }

    #endregion



    //private void BindGrid()
    //{
    //    try
    //    {
    //        String fromDate = "", toDate = "";
    //        try
    //        {
    //            if (txtFromDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //            if (txtToDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid date entry.");
    //            return;
    //        }

    //        con = new SqlConnection(method.str);
    //        SqlDataAdapter ad = new SqlDataAdapter("[POFranList]", con);
    //        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        ad.SelectCommand.Parameters.AddWithValue("@Userid", Session["franchiseid"].ToString());
    //        ad.SelectCommand.Parameters.AddWithValue("@min", fromDate);
    //        ad.SelectCommand.Parameters.AddWithValue("@max", toDate);
    //        dt = new DataTable();
    //        ad.Fill(dt);
    //        DataColumn dcDtl = new DataColumn("tbl", typeof(string));
    //        dt.Columns.Add(dcDtl);

    //        DataColumn srno_Encript = new DataColumn("srno_Encript", typeof(string));
    //        dt.Columns.Add(srno_Encript);
    //        foreach (DataRow row in dt.Rows)
    //        {
    //            utility objutil = new utility();
    //            row.SetField("srno_Encript", objutil.base64Encode(row["srno"].ToString()));

    //            XElement objXml = XElement.Parse(row["dtl"].ToString());
    //            string strDtl = "<table rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
    //            strDtl += "<tr><th>Name</th><th>Quantity</th><th>MRP</th><th>Total</th></tr>";
    //            foreach (XElement p in objXml.Elements("P"))
    //            {
    //                strDtl += "<tr>";
    //                strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
    //                strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
    //                strDtl += "<td>" + p.Elements("MRP").FirstOrDefault().Value + "</td>";
    //                // strDtl += "<td>" + p.Elements("BV").FirstOrDefault().Value + "</td>";
    //                strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
    //                strDtl += "</tr>";
    //            }
    //            strDtl += "</table>";
    //            row["tbl"] = strDtl;
    //        }

    //        GridView1.DataSource = dt;
    //        GridView1.DataBind();
    //        if (dt.Rows.Count > 0)
    //        {
    //            lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
    //            lblTotal.Text += ", Gross: " + (string.IsNullOrEmpty(dt.Compute("sum(grossamt)", "true").ToString()) ? "0.00" : dt.Compute("sum(grossamt)", "true").ToString());
    //            lblTotal.Text += ", Amount: " + (string.IsNullOrEmpty(dt.Compute("sum(amt)", "true").ToString()) ? "0.00" : dt.Compute("sum(amt)", "true").ToString());
    //            lblTotal.Text += ", Tax: " + (string.IsNullOrEmpty(dt.Compute("sum(tax)", "true").ToString()) ? "0.00" : dt.Compute("sum(tax)", "true").ToString());
    //            lblTotal.Text += ", Net: " + (string.IsNullOrEmpty(dt.Compute("sum(netAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(netAmt)", "true").ToString());
    //        }

    //        else
    //        {
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //            GridView1.EmptyDataText = "NO Data";
    //            lblTotal.Text = "";
    //        }

    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}

    ///// <summary>
    ///// //By <S>
    ///// </summary>
    ///// <param name="sender"></param>
    ///// <param name="e"></param>
    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindGrid();
    //}
    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    BindGrid();
    //}
    //protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    //{

    //}

    //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {

    //        HiddenField hnd_Status = (HiddenField)e.Row.FindControl("hnd_status");
    //        Label lbl_status = (Label)e.Row.FindControl("lbl_status");
    //        if (hnd_Status.Value.ToString() == "1")
    //            lbl_status.ForeColor = System.Drawing.Color.Green;
    //        else
    //            lbl_status.ForeColor = System.Drawing.Color.Red;
    //    }
    //}

    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}


    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        BindGrid();
    //        // GridView1.Columns[14].Visible = false;
    //        Response.Clear();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stocktranlist.xls");
    //        Response.Charset = "";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        this.GridView1.RenderControl(htmlWrite);
    //        Response.Write(stringWrite.ToString());
    //        Response.End();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Can't export as no data found.");
    //    }
    //}
    //protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        BindGrid();
    //        //GridView1.Columns[14].Visible = GridView1.Columns[15].Visible = GridView1.Columns[18].Visible = false;
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stockinhand.doc");
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        this.GridView1.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}
}