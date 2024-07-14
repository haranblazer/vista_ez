using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Drawing;
using System.IO;
using System.Web.UI;
using System.Collections.Generic;
using System.Web;

public partial class User_PayoutWeekly : System.Web.UI.Page
{

    //SqlDataAdapter da;
    //SqlDataReader dr;
    //SqlCommand com;
    //SqlConnection con = new SqlConnection(method.str);
    //utility objUtil = new utility();
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
                new SqlParameter("@Appmstregno", HttpContext.Current.Session["userId"].ToString()),
                new SqlParameter("@payoutno", "0"),
                new SqlParameter("@orderby", "1"),
                new SqlParameter("@BankWallet", "-1"),
                new SqlParameter("@iselegible", "-1"),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetTopperWeeklyList");

            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                utility objutil = new utility();
                data.Decode_appmstregno = objutil.base64Encode(dr["appmstregno"].ToString());
                data.Decode_payoutno = objutil.base64Encode(dr["payoutno"].ToString());

                data.payoutno = dr["payoutno"].ToString();
                data.Payout_Period = dr["Payout Period"].ToString();
                data.Matching_Counts = dr["Matching Counts"].ToString();
                data.Total_Payout = dr["Total Payout"].ToString();
                data.TDS = dr["TDS"].ToString();
                data.PC_Charges = dr["PC Charges"].ToString();
                data.Net_Payout = dr["Net Payout"].ToString();
                data.Status = dr["Status"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Decode_appmstregno { get; set; }
        public string Decode_payoutno { get; set; }

        public string Payout_Period { get; set; }
        public string payoutno { get; set; }
        public string Matching_Counts { get; set; }
        public string Total_Payout { get; set; }
        public string TDS { get; set; }
        public string PC_Charges { get; set; }
        public string Net_Payout { get; set; }
        public string Status { get; set; }
    }

    #endregion


    //private void finddata()
    //{
    //    try
    //    {
    //        da = new SqlDataAdapter("GetTopperWeeklyList", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@payoutno", 0);
    //        da.SelectCommand.Parameters.AddWithValue("@orderby", "1");
    //        da.SelectCommand.Parameters.AddWithValue("@BankWallet", "-1");
    //        da.SelectCommand.Parameters.AddWithValue("@iselegible", "-1");
    //        da.SelectCommand.Parameters.AddWithValue("@Appmstregno", Session["userId"].ToString());
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {
    //            GridView1.Columns[0].FooterText = "Total : " + dt.Rows.Count;
    //            GridView1.Columns[2].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Matching Counts])", "true"));
    //            GridView1.Columns[3].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Total Payout])", "true"));
    //            GridView1.Columns[4].FooterText = String.Format("{0:0.##}", dt.Compute("sum([TDS])", "true"));
    //            GridView1.Columns[5].FooterText = String.Format("{0:0.##}", dt.Compute("sum([PC Charges])", "true"));
    //            GridView1.Columns[6].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Net Payout])", "true"));

    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();
    //        }
    //        else
    //        {
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //        }
    //    }
    //    catch (Exception er) { }
    //}

    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    finddata();
    //}

    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName != "Page")
    //    {
    //        if (e.CommandName.Equals("Statement"))
    //        {
    //            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //            string payoutno = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
    //            string regno = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
    //            Response.Redirect("WeeklyPayoutStatement.aspx?n=" + objUtil.base64Encode(payoutno) + "&id=" + objUtil.base64Encode(regno));
    //        }
    //    }
    //}



    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}

    //protected void ibtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        Response.Clear();
    //        Response.Buffer = true;
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_WeeklyPayoutList.xls");
    //        Response.Charset = "";
    //        Response.ContentType = "application/vnd.ms-excel";
    //        using (StringWriter sw = new StringWriter())
    //        {
    //            HtmlTextWriter hw = new HtmlTextWriter(sw);

    //            GridView1.AllowPaging = false;
    //            finddata();

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
    //    }
    //    catch (Exception er) { }
    //}
}