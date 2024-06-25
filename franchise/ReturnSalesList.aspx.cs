using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using System.Web;

public partial class franchise_ReturnSalesList : System.Web.UI.Page
{
    string regno = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                DateTime now = DateTime.Now;
                var startDate = new DateTime(now.Year, now.Month, 1);

                txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");

                // BindGrid1();
            }
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string Regno)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Regno", Regno),
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@Sessionid", HttpContext.Current.Session["franchiseid"].ToString()),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetReturnList");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.srno_Encript = objutil.base64Encode(dr["srno"].ToString());
                data.srno = dr["srno"].ToString();
                data.Doe = dr["Doe"].ToString();
                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.SellerUserId = dr["SellerUserId"].ToString();
                data.SellerName = dr["SellerName"].ToString();
                data.BuyerUserId = dr["BuyerUserId"].ToString();
                data.BuyerName = dr["BuyerName"].ToString();
                data.ProdCount = dr["ProdCount"].ToString();
                data.DP = dr["DP"].ToString();

                data.SGST = dr["SGST"].ToString();
                data.CGST = dr["CGST"].ToString();
                data.IGST = dr["IGST"].ToString();
                data.DPWithTax = dr["DPWithTax"].ToString();
                data.Courier_Charges = dr["Courier_Charges"].ToString();
                data.InvoiceValue = dr["InvoiceValue"].ToString();
                data.StatusText = dr["StatusText"].ToString();
                data.Dispatch_Status = dr["Dispatch_Status"].ToString();
                data.PAN = dr["PAN"].ToString();
                data.GSTN = dr["GSTN"].ToString();
                data.Dispatch_Date = dr["Dispatch_Date"].ToString();
                data.Dispatch_Details = dr["Dispatch_Details"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string srno_Encript { get; set; }
        public string srno { get; set; }

        public string Doe { get; set; }
        public string InvoiceNo { get; set; }
        public string SellerUserId { get; set; }
        public string SellerName { get; set; }
        public string BuyerUserId { get; set; }
        public string BuyerName { get; set; }
        public string ProdCount { get; set; }
        public string DP { get; set; }
        public string SGST { get; set; }
        public string CGST { get; set; }
        public string IGST { get; set; }

        public string DPWithTax { get; set; }
        public string Courier_Charges { get; set; }
        public string InvoiceValue { get; set; }
        public string StatusText { get; set; }
        public string Dispatch_Status { get; set; }
        public string PAN { get; set; }
        public string GSTN { get; set; }
        public string Dispatch_Date { get; set; }
        public string Dispatch_Details { get; set; }
    }


    #endregion
     

    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindGrid1();
    //}


    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    BindGrid1();
    //}

    //private void BindGrid1()
    //{
    //    try
    //    {

    //        string strmin = "", strmax = "";
    //        try
    //        {
    //            if (txtFromDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                strmin = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //            if (txtToDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                strmax = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid date entry.");
    //            return;
    //        }

    //        SqlParameter[] param = new SqlParameter[]
    //      {
    //             new SqlParameter("@Regno", txtUserid.Text),
    //             new SqlParameter("@min", strmin),
    //             new SqlParameter("@max", strmax),
    //             new SqlParameter("@Sessionid", Session["franchiseid"].ToString())
    //      };
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTableSP(param, "GetReturnList");


    //        //con = new SqlConnection(method.str);
    //        //SqlDataAdapter ad = new SqlDataAdapter("GetReturnList", con);
    //        //ad.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        //ad.SelectCommand.Parameters.AddWithValue("@Regno", txtUserid.Text);
    //        //ad.SelectCommand.Parameters.AddWithValue("@min", strmin);
    //        //ad.SelectCommand.Parameters.AddWithValue("@max", strmax);
    //        //ad.SelectCommand.Parameters.AddWithValue("@Sessionid", Session["franchiseid"].ToString());
    //        //dt = new DataTable();
    //        //ad.Fill(dt);
    //        DataColumn dcDtl = new DataColumn("tbl", typeof(string));
    //        dt.Columns.Add(dcDtl);

    //        DataColumn srno_Encript = new DataColumn("srno_Encript", typeof(string));
    //        dt.Columns.Add(srno_Encript);

    //        foreach (DataRow row in dt.Rows)
    //        {
    //            utility objutil = new utility();
    //            row.SetField("srno_Encript", objutil.base64Encode(row["srno"].ToString()));

    //            //XElement objXml = XElement.Parse(row["dtl"].ToString());
    //            //string strDtl = "<table rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
    //            //strDtl += "<tr><th>Name</th><th>Quantity</th><th>MRP</th><th>BV</th><th>Total</th></tr>";
    //            //foreach (XElement p in objXml.Elements("P"))
    //            //{
    //            //    strDtl += "<tr>";
    //            //    strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
    //            //    strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
    //            //    strDtl += "<td>" + p.Elements("MRP").FirstOrDefault().Value + "</td>";
    //            //    strDtl += "<td>" + p.Elements("BV").FirstOrDefault().Value + "</td>";
    //            //    strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
    //            //    strDtl += "</tr>";
    //            //}
    //            //strDtl += "</table>";
    //            //row["tbl"] = strDtl;
    //        }
    //        //GridView1.Columns[12].FooterText = dt.Compute("sum(grossAmt)", "true").ToString();
    //        //GridView1.Columns[13].FooterText = dt.Compute("sum(Discount)", "true").ToString();
    //        //GridView1.Columns[14].FooterText = dt.Compute("sum(netAmt)", "true").ToString();

    //        GridView1.DataSource = dt;
    //        GridView1.DataBind();

    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}


    //protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    //{
    //    GridView1.EditIndex = -1;
    //}

    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}

    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    Response.Clear();
    //    Response.Buffer = true;
    //    Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_AssociateInvList.xls");
    //    Response.Charset = "";
    //    Response.ContentType = "application/vnd.ms-excel";
    //    using (StringWriter sw = new StringWriter())
    //    {
    //        HtmlTextWriter hw = new HtmlTextWriter(sw);

    //        GridView1.AllowPaging = false;
    //        BindGrid1();
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

    //}

}