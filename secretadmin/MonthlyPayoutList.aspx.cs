using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;

public partial class secretadmin_MonthlyPayoutList : System.Web.UI.Page
{
    int index;
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da = null;
    DataTable dt = null;
    utility objUtil = new utility();
    int joinTotal1 = 0;
    int joinTotal2 = 0; int joinTotal3 = 0; int joinTotal4 = 0; int joinTotal5 = 0;
    string value = "";

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
            go();
            if (Request.QueryString["pno"] != null)
            {
                ddlDateRange.SelectedValue = Request.QueryString["pno"].ToString();
            }
            getList();
        }
    }


    protected void ddl_Payout_Fillter_SelectedIndexChanged(object sender, EventArgs e)
    {
        getList();
    }

    public void go()
    {
        da = new SqlDataAdapter("[Monthlypayout]", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlDateRange.Items.Clear();
            ddlDateRange.DataSource = dt;
            ddlDateRange.DataTextField = "payoutdate";
            ddlDateRange.DataValueField = "PayoutNo";
            ddlDateRange.DataBind();
        }
        else
        {
            trGrid.Visible =  false;
            ddlDateRange.Items.Insert(0, new System.Web.UI.WebControls.ListItem("No Payout", "0"));
        }
    }


    public void getList()
    {

        lblPayoutNo.Text = "Payout No." + ddlDateRange.SelectedItem.ToString();
        index = Convert.ToInt32(ddlDateRange.SelectedValue.ToString());
        da = new SqlDataAdapter("GetTopperMonthlyList", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@payoutno", index);
        da.SelectCommand.Parameters.AddWithValue("@orderby", "1");
        da.SelectCommand.Parameters.AddWithValue("@BankWallet", ddl_BankWallet.SelectedValue.ToString());
        da.SelectCommand.Parameters.AddWithValue("@iselegible", ddl_Payout_Fillter.SelectedValue.ToString());
        dt = new DataTable();
        da.Fill(dt);

       // ViewState["dt"] = dt;
        if (dt.Rows.Count > 0)
        {
            // Label2.Text = dt.Rows.Count.ToString();
            trGrid.Visible =  true;
            Session["payoutno"] = index;

            dgList.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());


            dgList.Columns[0].FooterText ="Total : "+ dt.Rows.Count.ToString();
            dgList.Columns[12].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Bronze_Silver])", "true").ToString());
            dgList.Columns[13].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Gold])", "true").ToString());
            dgList.Columns[14].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Ruby])", "true").ToString());
            dgList.Columns[15].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Pearl])", "true").ToString());
            dgList.Columns[16].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Diamond])", "true").ToString());
            dgList.Columns[17].FooterText = String.Format("{0:0.##}", dt.Compute("sum([DoubleDiamond])", "true").ToString());
            dgList.Columns[18].FooterText = String.Format("{0:0.##}", dt.Compute("sum([BlueDiamond])", "true").ToString());
            dgList.Columns[19].FooterText = String.Format("{0:0.##}", dt.Compute("sum([BlackDiamond])", "true").ToString());
            dgList.Columns[20].FooterText = String.Format("{0:0.##}", dt.Compute("sum([CrownAmbassador])", "true").ToString());
            dgList.Columns[21].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Offer_Income])", "true").ToString());
            dgList.Columns[22].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Reward_Fund])", "true").ToString());
            dgList.Columns[23].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Total Payout])", "true").ToString());
            dgList.Columns[24].FooterText = String.Format("{0:0.##}", Math.Round( Convert.ToDecimal(dt.Compute("sum([TDS])", "true")), 2, MidpointRounding.ToEven).ToString());
            dgList.Columns[25].FooterText = String.Format("{0:0.##}", dt.Compute("sum([PC Charges])", "true").ToString());
            dgList.Columns[26].FooterText = String.Format("{0:0.##}", dt.Compute("sum([Net Payout])", "true").ToString());

            dgList.DataSource = dt;
            dgList.DataBind();
        }
        else
        {
            trGrid.Visible =  false;
            dgList.DataSource = null;
            dgList.DataBind();

        }
    }


    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void ibtnExcel_Click(object sender, ImageClickEventArgs e)
    {

        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_MonthlyPayoutList.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            dgList.AllowPaging = false;
            getList();

            dgList.HeaderRow.BackColor = System.Drawing.Color.White;
            foreach (TableCell cell in dgList.HeaderRow.Cells)
            {
                cell.BackColor = dgList.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in dgList.Rows)
            {
                row.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = dgList.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = dgList.RowStyle.BackColor;
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

            dgList.RenderControl(hw);
            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }

    }

    //protected void ibtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        if (ViewState["dt"] != null)
    //        {
    //            DataTable dt = new DataTable();
    //            dt = (DataTable)ViewState["dt"];
    //            /*=====================Remove Columns=====================*/
    //            dt.Columns.Remove("payoutno");
    //            dt.Columns.Remove("appmstregno");
    //            dt.Columns.Remove("iselegible");
    //            if (dt.Rows.Count > 0)
    //            {
    //                Response.ClearContent();
    //                Response.Buffer = true;
    //                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "MonthlyPayoutList.xls"));
    //                Response.ContentType = "application/ms-excel";
    //                string str = string.Empty;
    //                foreach (DataColumn dtcol in dt.Columns)
    //                {
    //                    Response.Write(str + dtcol.ColumnName);
    //                    str = "\t";
    //                }
    //                Response.Write("\n");
    //                foreach (DataRow dr in dt.Rows)
    //                {
    //                    str = "";
    //                    for (int j = 0; j < dt.Columns.Count; j++)
    //                    {
    //                        Response.Write(str + Convert.ToString(dr[j]));
    //                        str = "\t";
    //                    }
    //                    Response.Write("\n");
    //                }
    //                Response.End();
    //            }
    //            else
    //            {
    //                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found.');", true);
    //            }
    //        }
    //        else
    //            utility.MessageBox(this, "can not export as no data found !");
    //    }
    //    catch (Exception er) { }
    //}

    protected void ibtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (ViewState["dt"] != null)
        {
            dgList.AllowPaging = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_PayoutList.doc");
            Response.ContentType = "application/vnd.ms-word";
            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            dgList.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }
        else
            utility.MessageBox(this, "can not export as no data found !");

    }
    

    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDateRange.SelectedItem.Text != "no date found !")
            getList();

    }

    protected void dgList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dgList.PageIndex = e.NewPageIndex;
        getList();
    }
    protected void dgList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "Page")
        {
            GridViewRow row = dgList.Rows[Convert.ToInt32(e.CommandArgument)];
            string payoutno = dgList.DataKeys[row.RowIndex].Values[0].ToString();
            string regno = dgList.DataKeys[row.RowIndex].Values[1].ToString();
            Response.Redirect("MonthlyPayoutStatement.aspx?n=" + objUtil.base64Encode(payoutno) + "&id=" + objUtil.base64Encode(regno));
        }
    }

    protected void ddl_BankWallet_SelectedIndexChanged(object sender, EventArgs e)
    {
        getList();
    }

    protected void ddlDateRange_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDateRange.SelectedItem.Text != "no date found !")
            getList();
    }
    
}