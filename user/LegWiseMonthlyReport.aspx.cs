using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO; 
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_LegWiseMonthlyReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
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
        
        SqlParameter[] param = new SqlParameter[]
        {
           new SqlParameter("@regno", Session["userId"].ToString()), 
           new SqlParameter("@RequestType", ddl_RequestType.SelectedValue),
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "LegWise_GPV_TPV_Report");
        if (dt.Rows.Count > 0)
        {
            dt.Columns.Remove("DispOrder");
            //dt.Columns.Add("Total", typeof(decimal));
            //foreach (DataRow row in dt.Rows)
            //{
            //    decimal rowSum = 0;
            //    foreach (DataColumn col in dt.Columns)
            //    {
            //        if (col.ToString() != "Product" && col.ToString() != "ProductCode" && col.ToString() != "Category")
            //        {
            //            if (!row.IsNull(col))
            //            {
            //                string stringValue = row[col].ToString();
            //                decimal d;
            //                if (decimal.TryParse(stringValue, out d))
            //                    rowSum += d;
            //            }
            //        }
            //    }
            //    row.SetField("Total", rowSum);
            //}

            //int total = 0; ;
            //GridView1.FooterRow.Cells[1].Text = "Total";
            //GridView1.FooterRow.Cells[1].Font.Bold = true;
            //GridView1.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Left;
            //for (int k = 4; k < dt.Columns.Count - 1; k++)
            //{
            //    total = dt.AsEnumerable().Sum(row => row.Field<Int32>(dt.Columns[k].ToString()));
            //    GridView1.FooterRow.Cells[k].Text = total.ToString();
            //    GridView1.FooterRow.Cells[k].Font.Bold = true;
            //    GridView1.FooterRow.BackColor = System.Drawing.Color.Beige;
            //}

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
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




    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    

    protected void imgbtnExcel_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LegWiseMonthlyReport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                GridView1.AllowPaging = false;
                BindGrid();
                //GridView1.Columns[30].Visible = false;
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
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }
    protected void imgbtnWord_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindGrid();
           // GridView1.Columns[10].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LegWiseMonthlyReport.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
    }



    protected void ddl_RequestType_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }

    
}