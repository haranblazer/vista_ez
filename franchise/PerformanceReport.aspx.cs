using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class franchise_PerformanceReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("Logout.aspx");

    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {

            SqlParameter[] param = new SqlParameter[]
            {
              new SqlParameter("@Franchiseid", HttpContext.Current.Session["franchiseid"].ToString())
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetFranchisePerformance");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                data.Month = dr["Month"].ToString();
                data.PurchaseValue = dr["PurchaseValue"].ToString();
                data.AssociateSalesVale = dr["AssociateSalesVale"].ToString();
                data.FranchiseSalesValue = dr["FranchiseSalesValue"].ToString();
                data.ClosingStock = dr["ClosingStock"].ToString();
                data.CommissionGenerated = dr["CommissionGenerated"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Month { get; set; }
        public string PurchaseValue { get; set; }
        public string AssociateSalesVale { get; set; }
        public string FranchiseSalesValue { get; set; }

        public string ClosingStock { get; set; }
        public string CommissionGenerated { get; set; }
    }

    #endregion



    //public void BindPerformanceReport()
    //{
    //    SqlParameter[] param = new SqlParameter[] {
    //       new SqlParameter("@Franchiseid", Session["franchiseid"].ToString())
    //    };
    //    DataUtility objDu = new DataUtility();
    //    DataTable dt = objDu.GetDataTableSP(param, "GetFranchisePerformance");

    //    if (dt.Rows.Count > 0)
    //    {
    //        dglst.Columns[1].FooterText = "Total: ";
    //        dglst.Columns[2].FooterText = dt.Compute("sum(PurchaseValue)", "true").ToString();
    //        dglst.Columns[3].FooterText = dt.Compute("sum(AssociateSalesVale)", "true").ToString();
    //        dglst.Columns[4].FooterText = dt.Compute("sum(FranchiseSalesValue)", "true").ToString();
    //        dglst.Columns[5].FooterText = dt.Compute("sum(ClosingStock)", "true").ToString();
    //        dglst.Columns[6].FooterText = dt.Compute("sum(CommissionGenerated)", "true").ToString();

    //        dglst.DataSource = dt;
    //        dglst.DataBind();
    //    }
    //    else
    //    {
    //        dglst.DataSource = null;
    //    }
    //}



    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}


    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    Response.Clear();
    //    Response.Buffer = true;
    //    Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_PerformanceReport.xls");
    //    Response.Charset = "";
    //    Response.ContentType = "application/vnd.ms-excel";
    //    using (StringWriter sw = new StringWriter())
    //    {
    //        HtmlTextWriter hw = new HtmlTextWriter(sw);

    //        dglst.AllowPaging = false;
    //        BindPerformanceReport();
    //        dglst.HeaderRow.BackColor = System.Drawing.Color.White;
    //        foreach (TableCell cell in dglst.HeaderRow.Cells)
    //        {
    //            cell.BackColor = dglst.HeaderStyle.BackColor;
    //        }
    //        foreach (GridViewRow row in dglst.Rows)
    //        {
    //            row.BackColor = System.Drawing.Color.White;
    //            foreach (TableCell cell in row.Cells)
    //            {
    //                if (row.RowIndex % 2 == 0)
    //                {
    //                    cell.BackColor = dglst.AlternatingRowStyle.BackColor;
    //                }
    //                else
    //                {
    //                    cell.BackColor = dglst.RowStyle.BackColor;
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

    //        dglst.RenderControl(hw);
    //        //style to format numbers to string
    //        string style = @"<style> .textmode { } </style>";
    //        Response.Write(style);
    //        Response.Output.Write(sw.ToString());
    //        Response.Flush();
    //        Response.End();
    //    }
    //}
}