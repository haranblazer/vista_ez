using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_BusinessInformation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
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
                new SqlParameter("@Userid", HttpContext.Current.Session["userId"].ToString())
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetBusinessInformation");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                data.Month_Encode = objutil.base64Encode(dr["Month"].ToString());

                data.Month = dr["Month"].ToString();
                data.MatchingIncome = dr["MatchingIncome"].ToString();
                data.TopperFund = dr["TopperFund"].ToString();
                data.RepurchaseIncome = dr["RepurchaseIncome"].ToString();
                data.AnnualRoyalty = dr["AnnualRoyalty"].ToString();
                data.TotalAmount = dr["TotalAmount"].ToString();
                
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Month_Encode { get; set; }
        public string Month { get; set; }
        public string MatchingIncome { get; set; }
        public string TopperFund { get; set; }
        public string RepurchaseIncome { get; set; }
        public string AnnualRoyalty { get; set; }
        public string TotalAmount { get; set; } 
        
    }

    #endregion



    /// <summary>
    /// //By <S>
    /// </summary>
    //private void BindGrid()
    //{
    //    try
    //    {
    //        SqlParameter[] param1 = new SqlParameter[]
    //         {
    //            new SqlParameter("@Userid", Session["userId"].ToString())
    //         };
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTableSP(param1, "GetBusinessInformation");
    //        if (dt.Rows.Count > 0)
    //        {
    //            GridView1.Columns[2].FooterText = dt.Compute("sum(MatchingIncome)", "true").ToString();
    //            GridView1.Columns[3].FooterText = dt.Compute("sum(TopperFund)", "true").ToString();
    //            GridView1.Columns[4].FooterText = dt.Compute("sum(RepurchaseIncome)", "true").ToString();
    //            GridView1.Columns[5].FooterText = dt.Compute("sum(AnnualRoyalty)", "true").ToString();
    //            GridView1.Columns[6].FooterText = dt.Compute("sum(TotalAmount)", "true").ToString();

    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();
    //        }
    //        else
    //        {
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //    }

    //}

    /// <summary>
    /// //By <S>
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindGrid();
    //}

    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName != "Page")
    //    {
    //        if (e.CommandName.Equals("Statement"))
    //        {
    //            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //            string Month = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
    //            utility objUtil = new utility();
    //            Response.Redirect("TotalMonthlyIncStatment.aspx?m=" + objUtil.base64Encode(Month));
    //        }
    //    }
    //}


    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    BindGrid();
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
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_GenerationPointd.xls");
    //        Response.Charset = "";
    //        Response.ContentType = "application/vnd.ms-excel";
    //        using (StringWriter sw = new StringWriter())
    //        {
    //            HtmlTextWriter hw = new HtmlTextWriter(sw);

    //            GridView1.AllowPaging = false;
    //            BindGrid();
    //            //GridView1.Columns[30].Visible = false;
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
    //        GridView1.Columns[10].Visible = false;
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_GenerationPointd.doc");
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