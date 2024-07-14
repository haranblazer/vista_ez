
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_MonthlyGenerationPoint : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        //if (!IsPostBack)
        //{
        //    BindGrid();
        //}
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
                   new SqlParameter("@Userid",  HttpContext.Current.Session["userId"].ToString())
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetMonthlyRepurchaseData");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Month = dr["Month"].ToString();
                data.PPV = dr["PPV"].ToString();
                data.GPV = dr["GPV"].ToString();
                data.TPV = dr["TPV"].ToString();
                data.GPV_TPV = dr["GPV_TPV"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Month { get; set; }
        public string PPV { get; set; }
        public string GPV { get; set; }
        public string TPV { get; set; }
        public string GPV_TPV { get; set; }
    }

    #endregion



    //private void BindGrid()
    //{
    //    try
    //    {
    //        SqlParameter[] param1 = new SqlParameter[]
    //         {
    //            new SqlParameter("@Userid", Session["userId"].ToString())
    //         };
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTableSP(param1, "GetMonthlyRepurchaseData");
    //        if (dt.Rows.Count > 0)
    //        {
    //            GridView1.Columns[2].FooterText = dt.Compute("sum(PPV)", "true").ToString();
    //            GridView1.Columns[3].FooterText = dt.Compute("sum(GPV)", "true").ToString();
    //            GridView1.Columns[4].FooterText = dt.Compute("sum(TPV)", "true").ToString();
    //            GridView1.Columns[5].FooterText = dt.Compute("sum(GPV_TPV)", "true").ToString();

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