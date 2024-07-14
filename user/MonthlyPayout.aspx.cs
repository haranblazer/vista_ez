using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_MonthlyPayout : System.Web.UI.Page
{

    //SqlConnection con = new SqlConnection(method.str);
    //SqlDataAdapter da = null;
    //DataTable dt = null;
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
                new SqlParameter("@Regno", HttpContext.Current.Session["userId"].ToString())
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetTopperMonthly_UserWise");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Decode_appmstregno = objutil.base64Encode(dr["appmstregno"].ToString());
                data.Decode_payoutno = objutil.base64Encode(dr["payoutno"].ToString());
                
                data.Payout_Period = dr["Payout Period"].ToString();
                data.payoutno = dr["payoutno"].ToString();
                data.TPV = dr["TPV"].ToString();
                data.Mathing_Counts = dr["Mathing Counts"].ToString();
                data.TopperPIN = dr["TopperPIN"].ToString();
                data.Bronze_Silver = dr["Bronze_Silver"].ToString();
                data.Gold = dr["Gold"].ToString();
                data.Ruby = dr["Ruby"].ToString();
                data.Pearl = dr["Pearl"].ToString();
                data.Diamond = dr["Diamond"].ToString();
                data.DoubleDiamond = dr["DoubleDiamond"].ToString();
                data.BlueDiamond = dr["BlueDiamond"].ToString();
                data.BlackDiamond = dr["BlackDiamond"].ToString();
                data.CrownAmbassador = dr["CrownAmbassador"].ToString();
                data.Offer_Income = dr["Offer_Income"].ToString();
                data.Reward_Fund = dr["Reward_Fund"].ToString();
                data.Total_Payout = dr["Total Payout"].ToString();
                data.TDS = dr["TDS"].ToString();
                data.PC_Charges = dr["PC Charges"].ToString();
                data.Net_Payout = dr["Net Payout"].ToString();
                data.Payout_Status = dr["Payout Status"].ToString();
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
        public string TPV { get; set; }
        public string Mathing_Counts { get; set; }
        public string TopperPIN { get; set; }
        public string Bronze_Silver { get; set; }
        public string Gold { get; set; }

        public string Ruby { get; set; }
        public string Pearl { get; set; }
        public string Diamond { get; set; }
        public string DoubleDiamond { get; set; }
        public string BlueDiamond { get; set; }
        public string BlackDiamond { get; set; }
        public string CrownAmbassador { get; set; }
        public string Offer_Income { get; set; }
        public string Reward_Fund { get; set; }
        public string Total_Payout { get; set; }
        public string TDS { get; set; }
        public string PC_Charges { get; set; }
        public string Net_Payout { get; set; }
        public string Payout_Status { get; set; }
    }

    #endregion



    //public void getList()
    //{ 
    //    da = new SqlDataAdapter("GetTopperMonthly_UserWise", con);
    //    da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    da.SelectCommand.Parameters.AddWithValue("@Regno", Session["userId"].ToString()); 
    //    dt = new DataTable();
    //    da.Fill(dt); 
    //    if (dt.Rows.Count > 0)
    //    { 
    //        dgList.Columns[0].FooterText = "Total : " + dt.Rows.Count.ToString();
    //        dgList.Columns[5].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Bronze_Silver])", "true").ToString());
    //        dgList.Columns[6].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Gold])", "true").ToString());
    //        dgList.Columns[7].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Ruby])", "true").ToString());
    //        dgList.Columns[8].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Pearl])", "true").ToString());
    //        dgList.Columns[9].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Diamond])", "true").ToString());
    //        dgList.Columns[10].FooterText = String.Format("{0:0.##}", dt.Compute("sum([DoubleDiamond])", "true").ToString());
    //        dgList.Columns[11].FooterText = String.Format("{0:0.##}", dt.Compute("sum([BlueDiamond])", "true").ToString());
    //        dgList.Columns[12].FooterText = String.Format("{0:0.##}", dt.Compute("sum([BlackDiamond])", "true").ToString());
    //        dgList.Columns[13].FooterText = String.Format("{0:0.##}", dt.Compute("sum([CrownAmbassador])", "true").ToString());
    //        dgList.Columns[14].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Offer_Income])", "true").ToString());
    //        dgList.Columns[15].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Reward_Fund])", "true").ToString());
    //        dgList.Columns[16].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Total Payout])", "true").ToString());
    //        dgList.Columns[17].FooterText = String.Format("{0:0.##}", Math.Round(Convert.ToDecimal(dt.Compute("sum([TDS])", "true")), 2, MidpointRounding.ToEven).ToString());
    //        dgList.Columns[18].FooterText = String.Format("{0:0.##}", dt.Compute("sum([PC Charges])", "true").ToString());
    //        dgList.Columns[19].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Net Payout])", "true").ToString());

    //        dgList.DataSource = dt;
    //        dgList.DataBind();
    //    }
    //    else
    //    {
    //        dgList.DataSource = null;
    //        dgList.DataBind();

    //    }
    //}

    //protected void dgList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    dgList.PageIndex = e.NewPageIndex;
    //    getList();
    //}
    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}

    //protected void dgList_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName != "Page")
    //    {
    //        if (e.CommandName.Equals("Statement"))
    //        {
    //            GridViewRow row = dgList.Rows[Convert.ToInt32(e.CommandArgument)];
    //            string payoutno = dgList.DataKeys[row.RowIndex].Values[0].ToString();
    //            string regno = dgList.DataKeys[row.RowIndex].Values[1].ToString();
    //            Response.Redirect("MonthlyPayoutStatement.aspx?n=" + objUtil.base64Encode(payoutno) + "&id=" + objUtil.base64Encode(regno));
    //        }
    //    }
    //}


    //    protected void ibtnExcel_Click(object sender, ImageClickEventArgs e)
    //    {
    //        try
    //        {
    //            Response.Clear();
    //            Response.Buffer = true;
    //            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_MonthlyPayoutList.xls");
    //            Response.Charset = "";
    //            Response.ContentType = "application/vnd.ms-excel";
    //            using (StringWriter sw = new StringWriter())
    //            {
    //                HtmlTextWriter hw = new HtmlTextWriter(sw);

    //                dgList.AllowPaging = false;
    //                getList();

    //                dgList.HeaderRow.BackColor = System.Drawing.Color.White;
    //                foreach (TableCell cell in dgList.HeaderRow.Cells)
    //                {
    //                    cell.BackColor = dgList.HeaderStyle.BackColor;
    //                }
    //                foreach (GridViewRow row in dgList.Rows)
    //                {
    //                    row.BackColor = System.Drawing.Color.White;
    //                    foreach (TableCell cell in row.Cells)
    //                    {
    //                        if (row.RowIndex % 2 == 0)
    //                        {
    //                            cell.BackColor = dgList.AlternatingRowStyle.BackColor;
    //                        }
    //                        else
    //                        {
    //                            cell.BackColor = dgList.RowStyle.BackColor;
    //                        }
    //                        cell.CssClass = "textmode";


    //                        List<Control> controls = new List<Control>();

    //                        //Add controls to be removed to Generic List
    //                        foreach (Control control in cell.Controls)
    //                        {
    //                            controls.Add(control);
    //                        }

    //                        //Loop through the controls to be removed and replace with Literal
    //                        foreach (Control control in controls)
    //                        {
    //                            switch (control.GetType().Name)
    //                            {
    //                                case "HyperLink":
    //                                    cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
    //                                    break;
    //                                case "TextBox":
    //                                    cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
    //                                    break;
    //                                case "Label":
    //                                    cell.Controls.Add(new Literal { Text = (control as Label).Text });
    //                                    break;
    //                                case "LinkButton":
    //                                    cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
    //                                    break;
    //                            }
    //                            cell.Controls.Remove(control);
    //                        }
    //                    }
    //                }

    //                dgList.RenderControl(hw);
    //                //style to format numbers to string
    //                string style = @"<style> .textmode { } </style>";
    //                Response.Write(style);
    //                Response.Output.Write(sw.ToString());
    //                Response.Flush();
    //                Response.End();
    //            }
    //        }
    //        catch (Exception er) { }
    //    }

}