using System.Web.UI;
using System.Data.SqlClient;
using System;
using System.Collections.Generic;

public partial class secretadmin_ProductWiseSecondarySales : Page
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
            Response.Redirect("logout.aspx");
        }

        if (!Page.IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-7).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");

            //bindgrid();
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetSecondarySaleProductWise");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                data.ProductCode = dr["ProductCode"].ToString(); 
                data.ProductName = dr["ProductName"].ToString();
                data.TopperQty = dr["TopperQty"].ToString();
                data.GenerationQty = dr["GenerationQty"].ToString();
                data.FreeSamplesQty = dr["FreeSamplesQty"].ToString();
                data.LoyaltyQty = dr["LoyaltyQty"].ToString();
                data.OfferQty = dr["OfferQty"].ToString();
                data.TotalQty = dr["TotalQty"].ToString();
                data.PurchaseRate = dr["PurchaseRate"].ToString();
                data.Purchasevalue = dr["Purchasevalue"].ToString();
                data.SalesQty = dr["SalesQty"].ToString();
                data.AssociateRate = dr["AssociateRate"].ToString();
                data.SalesValue = dr["SalesValue"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string TopperQty { get; set; }
        public string GenerationQty { get; set; }
        public string FreeSamplesQty { get; set; }
        public string LoyaltyQty { get; set; }
        public string OfferQty { get; set; }
        public string TotalQty { get; set; }
        public string PurchaseRate { get; set; }
        public string Purchasevalue { get; set; }
        public string SalesQty { get; set; }
        public string AssociateRate { get; set; }
        public string SalesValue { get; set; }
    }


    #endregion



    //public void bindgrid()
    //{
    //    string fromDate = "", toDate = "";
    //    try
    //    {
    //        if (txtFromDate.Text.Trim().Length > 0)
    //        {
    //            String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //            fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //        }
    //        if (txtToDate.Text.Trim().Length > 0)
    //        {
    //            String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //            toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //        }
    //    }
    //    catch
    //    {
    //        utility.MessageBox(this, "Invalid date entry.");
    //        return;
    //    }

    //    SqlParameter[] param = new SqlParameter[]
    //    {
    //        new SqlParameter("@min", fromDate),
    //        new SqlParameter("@max", toDate)
    //    };
    //    DataUtility objDu = new DataUtility();
    //    DataTable dt = objDu.GetDataTableSP(param, "GetSecondarySaleProductWise");
    //    if (dt.Rows.Count > 0)
    //    {
    //        GridView1.Columns[3].FooterText = dt.Compute("sum(TopperQty)", "true").ToString();
    //        GridView1.Columns[4].FooterText = dt.Compute("sum(GenerationQty)", "true").ToString();
    //        GridView1.Columns[5].FooterText = dt.Compute("sum(FreeSamplesQty)", "true").ToString();
    //        GridView1.Columns[6].FooterText = dt.Compute("sum(LoyaltyQty)", "true").ToString();
    //        GridView1.Columns[7].FooterText = dt.Compute("sum(OfferQty)", "true").ToString();
    //        GridView1.Columns[8].FooterText = dt.Compute("sum(TotalQty)", "true").ToString();
    //        GridView1.Columns[10].FooterText = dt.Compute("sum(Purchasevalue)", "true").ToString();
    //        GridView1.Columns[11].FooterText = dt.Compute("sum(SalesQty)", "true").ToString();
    //        GridView1.Columns[13].FooterText = dt.Compute("sum(SalesValue)", "true").ToString();

    //        GridView1.DataSource = dt;
    //        GridView1.DataBind();
    //    }
    //    else
    //    {
    //        GridView1.DataSource = null;
    //        GridView1.DataBind();
    //    }

    //}

    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    bindgrid();
    //}


    //protected void btnSearchByDate_Click(object sender, EventArgs e)
    //{
    //    bindgrid();
    //}
    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}
    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        Response.Clear();
    //        Response.Buffer = true;
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductWiseSecondarySale.xls");
    //        Response.Charset = "";
    //        Response.ContentType = "application/vnd.ms-excel";
    //        using (StringWriter sw = new StringWriter())
    //        {
    //            HtmlTextWriter hw = new HtmlTextWriter(sw);

    //            GridView1.AllowPaging = false;
    //            bindgrid();

    //            GridView1.HeaderRow.BackColor = System.Drawing.Color.White;
    //            foreach (TableCell cell in GridView1.HeaderRow.Cells)
    //            {
    //                cell.BackColor = GridView1.HeaderStyle.BackColor;
    //            }
    //            foreach (GridViewRow row in GridView1.Rows)
    //            {
    //                row.BackColor = System.Drawing.Color.White;
    //                foreach (TableCell cell in row.Cells)
    //                {
    //                    if (row.RowIndex % 2 == 0)
    //                    {
    //                        cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
    //                    }
    //                    else
    //                    {
    //                        cell.BackColor = GridView1.RowStyle.BackColor;
    //                    }
    //                    cell.CssClass = "textmode";


    //                    List<Control> controls = new List<Control>();

    //                    //Add controls to be removed to Generic List
    //                    foreach (Control control in cell.Controls)
    //                    {
    //                        controls.Add(control);
    //                    }

    //                    //Loop through the controls to be removed and replace with Literal
    //                    foreach (Control control in controls)
    //                    {
    //                        switch (control.GetType().Name)
    //                        {
    //                            case "HyperLink":
    //                                cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
    //                                break;
    //                            case "TextBox":
    //                                cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
    //                                break;
    //                            case "Label":
    //                                cell.Controls.Add(new Literal { Text = (control as Label).Text });
    //                                break;
    //                            case "LinkButton":
    //                                cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
    //                                break;
    //                        }
    //                        cell.Controls.Remove(control);
    //                    }
    //                }
    //            }

    //            GridView1.RenderControl(hw);
    //            //style to format numbers to string
    //            string style = @"<style> .textmode { } </style>";
    //            Response.Write(style);
    //            Response.Output.Write(sw.ToString());
    //            Response.Flush();
    //            Response.End();
    //        }
    //        //GridView1.AllowPaging = false;
    //        //bindgrid();
    //        //Response.Clear();
    //        //Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductWiseFranchiseSale.xls");
    //        //Response.Charset = "";
    //        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        //Response.ContentType = "application/vnd.xls";
    //        //System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        //System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        //GridView1.RenderControl(htmlWrite);
    //        //Response.Write(stringWrite.ToString());
    //        //Response.End();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Can't export as no data found.");
    //    }
    //}
}