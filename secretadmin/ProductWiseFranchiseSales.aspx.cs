using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System;
using System.Web;
using System.IO;
using System.Collections.Generic;

public partial class secretadmin_ProductWiseFranchiseSales : System.Web.UI.Page
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

            bindgrid();
        }
    }



    public void bindgrid()
    {
        string fromDate = "", toDate = "";
        try
        {
            if (txtFromDate.Text.Trim().Length > 0)
            {
                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
            if (txtToDate.Text.Trim().Length > 0)
            {
                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
            }
        }
        catch
        {
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }

        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@min", fromDate),
            new SqlParameter("@max", toDate)  
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetProductWiseFranchiseSale");
        if (dt.Rows.Count > 0)
        {
            GridView1.Columns[3].FooterText = dt.Compute("sum(SalesQty)", "true").ToString();
            GridView1.Columns[4].FooterText = dt.Compute("sum(FreeSamplesQty)", "true").ToString();
            GridView1.Columns[5].FooterText = dt.Compute("sum(TotalQty)", "true").ToString();
            GridView1.Columns[7].FooterText = dt.Compute("sum(Purchasevalue)", "true").ToString();

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindgrid();
    }


    protected void btnSearchByDate_Click(object sender, EventArgs e)
    {
        bindgrid();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductWiseFranchiseSale.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                GridView1.AllowPaging = false;
                bindgrid();
                
                GridView1.HeaderRow.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in GridView1.HeaderRow.Cells)
                {
                    cell.BackColor = GridView1.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in GridView1.Rows)
                {
                    row.BackColor = System.Drawing.Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = GridView1.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";


                        List<Control> controls = new List<Control>();

                        //Add controls to be removed to Generic List
                        foreach (Control control in cell.Controls)
                        {
                            controls.Add(control);
                        }

                        //Loop through the controls to be removed and replace with Literal
                        foreach (Control control in controls)
                        {
                            switch (control.GetType().Name)
                            {
                                case "HyperLink":
                                    cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
                                    break;
                                case "TextBox":
                                    cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
                                    break;
                                case "Label":
                                    cell.Controls.Add(new Literal { Text = (control as Label).Text });
                                    break;
                                case "LinkButton":
                                    cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
                                    break;
                            }
                            cell.Controls.Remove(control);
                        }
                    }
                }

                GridView1.RenderControl(hw);
                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
            //GridView1.AllowPaging = false;
            //bindgrid();
            //Response.Clear();
            //Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductWiseFranchiseSale.xls");
            //Response.Charset = "";
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.ContentType = "application/vnd.xls";
            //System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            //System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            //GridView1.RenderControl(htmlWrite);
            //Response.Write(stringWrite.ToString());
            //Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }
}