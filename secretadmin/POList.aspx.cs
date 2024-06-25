using System;
using System.Data.SqlClient;
using System.Collections.Generic;

public partial class franchise_POList : System.Web.UI.Page
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
            Response.Redirect("adminLog.aspx");
        }


        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtFromDate.Text = txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");
            //    if (Request.QueryString.Count > 0)
            //    {
            //        if (Request.QueryString["Key"] != null)
            //        {
            //            ddl_Status.SelectedValue = "0";
            //            txtFromDate.Text = "";
            //            txtToDate.Text = "";
            //        }
            //    }
            //    BindGrid();
        }
    }




    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string status)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@Userid", ""),
                new SqlParameter("@status", status),
                new SqlParameter("@IsCompanyReq", "1"),
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

                data.regno = dr["regno"].ToString();
                data.fname = dr["fname"].ToString();


                data.SalesRepId = dr["SalesRepId"].ToString();
                data.SellerName = dr["SellerName"].ToString();
                data.doe = dr["doe"].ToString();
                data.NoOFProduct = dr["NoOFProduct"].ToString();
                data.amt = dr["amt"].ToString();
                data.Actual_Qty = dr["Actual_Qty"].ToString();
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

        public string regno { get; set; }
        public string fname { get; set; }

        public string SalesRepId { get; set; }
        public string SellerName { get; set; }
        public string doe { get; set; }
        public string NoOFProduct { get; set; }
        public string Actual_Qty { get; set; }
        public string amt { get; set; }
        public string grossAmt { get; set; }
        public string tax { get; set; }
        public string netAmt { get; set; }
        public string SellerState { get; set; }
        public string PlaceOfSupply { get; set; }
    }


    [System.Web.Services.WebMethod]
    public static string UpdateStatus(string Invoice)
    {
        string result = "";
        try
        {

            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Invoice", Invoice)
            };

            objDu.ExecuteSql(param, "update PO_Mst set status=(Case when status=0 then 1 else 0 End)  where InvoiceNo=@Invoice");
            result = "1";
        }
        catch (Exception er) { result = er.Message; }
        return result;
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
    //        ad.SelectCommand.Parameters.AddWithValue("@Userid", "");
    //        ad.SelectCommand.Parameters.AddWithValue("@min", fromDate);
    //        ad.SelectCommand.Parameters.AddWithValue("@max", toDate);
    //        ad.SelectCommand.Parameters.AddWithValue("@status", ddl_Status.SelectedValue); 
    //        ad.SelectCommand.Parameters.AddWithValue("@IsCompanyReq", "1");
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

    //        GridView1.Columns[9].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(amt)", "true").ToString()) ? "0.00" : dt.Compute("sum(amt)", "true").ToString());
    //        GridView1.Columns[10].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(grossAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(grossAmt)", "true").ToString());
    //        GridView1.Columns[11].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(tax)", "true").ToString()) ? "0.00" : dt.Compute("sum(tax)", "true").ToString());
    //        GridView1.Columns[12].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(netAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(netAmt)", "true").ToString());
    //        GridView1.DataSource = dt;
    //        GridView1.DataBind();
    //        //if (dt.Rows.Count > 0)
    //        //{
    //        //    lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
    //        //    lblTotal.Text += ", Gross: " + (string.IsNullOrEmpty(dt.Compute("sum(grossamt)", "true").ToString()) ? "0.00" : dt.Compute("sum(grossamt)", "true").ToString());
    //        //    lblTotal.Text += ", Amount: " + (string.IsNullOrEmpty(dt.Compute("sum(amt)", "true").ToString()) ? "0.00" : dt.Compute("sum(amt)", "true").ToString());
    //        //    lblTotal.Text += ", Tax: " + (string.IsNullOrEmpty(dt.Compute("sum(tax)", "true").ToString()) ? "0.00" : dt.Compute("sum(tax)", "true").ToString());
    //        //    lblTotal.Text += ", Net: " + (string.IsNullOrEmpty(dt.Compute("sum(netAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(netAmt)", "true").ToString());
    //        //}

    //        //else
    //        //{
    //        //    GridView1.DataSource = null;
    //        //    GridView1.DataBind();
    //        //    GridView1.EmptyDataText = "NO Data";
    //        //    lblTotal.Text = "";
    //        //}

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


    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName != "Page" && e.CommandName != "Sort")
    //    {
    //        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //        try
    //        {
    //            HiddenField hnd_invoiceno = (HiddenField)row.FindControl("hnd_invoiceno");
    //            //utility.MessageBox(this, hnd_invoiceno.Value);

    //            if (e.CommandName.Equals("Status"))
    //            {
    //                con = new SqlConnection(method.str);
    //                SqlCommand cmd = new SqlCommand("update PO_Mst set Status=(Case when isnull(Status,0)=0 then 1 else 0 end) where InvoiceNo=@InvoiceNo", con);
    //                cmd.CommandType = CommandType.Text;
    //                cmd.CommandTimeout = 99999;
    //                cmd.Parameters.AddWithValue("@InvoiceNo", hnd_invoiceno.Value);
    //                con.Open();
    //                cmd.ExecuteNonQuery();
    //                con.Close();
    //                BindGrid();
    //            }
    //        }
    //        catch (Exception ex)
    //        {
    //            utility.MessageBox(this, ex.ToString());
    //        }
    //        finally
    //        {

    //        }
    //    }
    //}


    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}


    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{

    //    Response.Clear();
    //    Response.Buffer = true;
    //    Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_PurchaseOrder.xls");
    //    Response.Charset = "";
    //    Response.ContentType = "application/vnd.ms-excel";
    //    using (StringWriter sw = new StringWriter())
    //    {
    //        HtmlTextWriter hw = new HtmlTextWriter(sw);

    //        GridView1.AllowPaging = false;
    //        BindGrid();

    //        GridView1.HeaderRow.BackColor = System.Drawing.Color.White;
    //        foreach (TableCell cell in GridView1.HeaderRow.Cells)
    //        {
    //            cell.BackColor = GridView1.HeaderStyle.BackColor;
    //        }
    //        foreach (GridViewRow row in GridView1.Rows)
    //        {
    //            row.BackColor = System.Drawing.Color.White;
    //            foreach (TableCell cell in row.Cells)
    //            {
    //                if (row.RowIndex % 2 == 0)
    //                {
    //                    cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
    //                }
    //                else
    //                {
    //                    cell.BackColor = GridView1.RowStyle.BackColor;
    //                }
    //                cell.CssClass = "textmode";


    //                List<Control> controls = new List<Control>();

    //                //Add controls to be removed to Generic List
    //                foreach (Control control in cell.Controls)
    //                {
    //                    controls.Add(control);
    //                }

    //                //Loop through the controls to be removed and replace with Literal
    //                foreach (Control control in controls)
    //                {
    //                    switch (control.GetType().Name)
    //                    {
    //                        case "HyperLink":
    //                            cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
    //                            break;
    //                        case "TextBox":
    //                            cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
    //                            break;
    //                        case "Label":
    //                            cell.Controls.Add(new Literal { Text = (control as Label).Text });
    //                            break;
    //                        case "LinkButton":
    //                            cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
    //                            break;
    //                    }
    //                    cell.Controls.Remove(control);
    //                }
    //            }
    //        }

    //        GridView1.RenderControl(hw);
    //        //style to format numbers to string
    //        string style = @"<style> .textmode { } </style>";
    //        Response.Write(style);
    //        Response.Output.Write(sw.ToString());
    //        Response.Flush();
    //        Response.End();
    //    }

    //    //Response.Clear();
    //    //Response.Buffer = true;
    //    //Response.AddHeader("content-disposition", "attachment;filename=PurchaseOrder.xls");
    //    //Response.Charset = "";
    //    //Response.ContentType = "application/vnd.ms-excel";
    //    //using (StringWriter sw = new StringWriter())
    //    ////{
    //    //    HtmlTextWriter hw = new HtmlTextWriter(sw);

    //    //    //To Export all pages
    //    //    GridView1.AllowPaging = false;
    //    //    this.BindGrid();
    //    //    //GridView1.Columns[16].Visible = false;
    //    //    //GridView1.Columns[2].Visible=GridView1.Columns[14].Visible = GridView1.Columns[15].Visible = false;
    //    //    // GridView1.Columns[18].Visible=GridView1.Columns[17].Visible = GridView1.Columns[16].Visible = false;
    //    //    GridView1.HeaderRow.BackColor = Color.White;
    //    //    foreach (TableCell cell in GridView1.HeaderRow.Cells)
    //    //    {
    //    //        cell.BackColor = GridView1.HeaderStyle.BackColor;
    //    //    }
    //    //    foreach (GridViewRow row in GridView1.Rows)
    //    //    {
    //    //        row.BackColor = Color.White;
    //    //        foreach (TableCell cell in row.Cells)
    //    //        {
    //    //            if (row.RowIndex % 2 == 0)
    //    //            {
    //    //                cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
    //    //            }
    //    //            else
    //    //            {
    //    //                cell.BackColor = GridView1.RowStyle.BackColor;
    //    //            }
    //    //            cell.CssClass = "textmode";
    //    //        }
    //    //    }

    //    //    GridView1.RenderControl(hw);

    //    //    //style to format numbers to string
    //    //    string style = @"<style> .textmode { } </style>";
    //    //    Response.Write(style);
    //    //    Response.Output.Write(sw.ToString());
    //    //    Response.Flush();
    //    //    Response.End();

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