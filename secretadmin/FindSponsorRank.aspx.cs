using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class secretadmin_FindSponsorRank : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {
                ddl_D_GPV_RPV.Items.Insert(0, new ListItem(method.GBV, "GPV"));
                ddl_D_GPV_RPV.Items.Insert(0, new ListItem(method.PV, "RPV"));
                Bind_Month();
            }
        }
        catch
        {

        }

    }

    


    #region Bind Table

    [System.Web.Services.WebMethod]
    public static SponsorDetails[] GetSponsorData(string Months, string Sponsor, string SelfRPV, string GPV_RPV_Type, string D_GPV_RPV, string userid, string Typ)
    {
        List<SponsorDetails> details = new List<SponsorDetails>();

        DataTable dt = getdate(Months, Sponsor, SelfRPV, GPV_RPV_Type, D_GPV_RPV, userid, Typ);
        foreach (DataRow dr in dt.Rows)
        {
            SponsorDetails data = new SponsorDetails();
            data.UserId = dr["UserId"].ToString();
            data.UserName = dr["UserName"].ToString();
            data.Mobile = dr["Mobile"].ToString();
            data.UserState = dr["UserState"].ToString();
            data.District = dr["District"].ToString();
            data.SponsporId = dr["SponsporId"].ToString();
            data.SponsorName = dr["SponsorName"].ToString();
            data.RPV = dr["RPV"].ToString();
            data.GPV = dr["GPV"].ToString();
            data.RankName = dr["RankName"].ToString();
            data.NoOfSponsor = dr["NoOfSponsor"].ToString();
            details.Add(data);
        }
        return details.ToArray();
    }

    public class SponsorDetails
    {
        public String UserId { get; set; }
        public String UserName { get; set; }
        public String Mobile { get; set; }
        public String UserState { get; set; }
        public String District { get; set; }
        public String SponsporId { get; set; }
        public String SponsorName { get; set; }
        public String RPV { get; set; }
        public String GPV { get; set; }
        public String RankName { get; set; }
        public String NoOfSponsor { get; set; }
    }
    private void Bind_Month()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(@" Select Payoutno, [Month] From(
         Select Payoutno=99999, [Month]=Cast(DateName(Month, Getdate()) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Getdate()),2) 
         Union All 
         Select Payoutno, [Month]=Cast(DateName(Month, PayToDate-1) as nvarchar(3)) + '-' + RIGHT(DateName(Year, PayToDate-1),2)  from RePayoutDate
         ) t Order by t.Payoutno desc");
        if (dt.Rows.Count > 0)
        {
            ddl_Month.DataSource = dt;
            ddl_Month.DataTextField = "Month";
            ddl_Month.DataValueField = "Month";
            ddl_Month.DataBind();
        }
        else
        {
            ddl_Month.Items.Clear();
        }
    }


    static private DataTable getdate(string Months, string Sponsor, string SelfRPV, string GPV_RPV_Type, string D_GPV_RPV, string Userid, string Key)
    {
        SelfRPV = SelfRPV == "" ? "0" : SelfRPV;
        D_GPV_RPV = D_GPV_RPV == "" ? "0" : D_GPV_RPV;
        Sponsor = Sponsor == "" ? "0" : Sponsor;
        SqlParameter[] param = new SqlParameter[]
           {
          new SqlParameter("@Months", Months),
          new SqlParameter("@SelfRPV", SelfRPV),
          new SqlParameter("@GPV_RPV_Type", GPV_RPV_Type),
          new SqlParameter("@D_GPV_RPV", D_GPV_RPV),
          new SqlParameter("@NoOfSponsor", Sponsor),
          new SqlParameter("@Userid", Userid),
          new SqlParameter("@Key", Key)
           };
        DataUtility objDu = new DataUtility();
        return objDu.GetDataTableSP(param, "GetSponsorRank");
    }
    #endregion


    //protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    dglst.PageIndex = e.NewPageIndex;
    //    show();
    //}

    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    show();
    //}
    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}

    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dglst.Rows.Count > 0)
    //    {
    //        Response.Clear();
    //        Response.Buffer = true;
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "__UserReportByCV.xls");
    //        Response.Charset = "";
    //        Response.ContentType = "application/vnd.ms-excel";
    //        using (StringWriter sw = new StringWriter())
    //        {
    //            HtmlTextWriter hw = new HtmlTextWriter(sw);

    //            dglst.AllowPaging = false;
    //            show();

    //            dglst.HeaderRow.BackColor = System.Drawing.Color.White;
    //            foreach (TableCell cell in dglst.HeaderRow.Cells)
    //            {
    //                cell.BackColor = dglst.HeaderStyle.BackColor;
    //            }
    //            foreach (GridViewRow row in dglst.Rows)
    //            {
    //                row.BackColor = System.Drawing.Color.White;
    //                foreach (TableCell cell in row.Cells)
    //                {
    //                    if (row.RowIndex % 2 == 0)
    //                    {
    //                        cell.BackColor = dglst.AlternatingRowStyle.BackColor;
    //                    }
    //                    else
    //                    {
    //                        cell.BackColor = dglst.RowStyle.BackColor;
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

    //            dglst.RenderControl(hw);
    //            //style to format numbers to string
    //            string style = @"<style> .textmode { } </style>";
    //            Response.Write(style);
    //            Response.Output.Write(sw.ToString());
    //            Response.Flush();
    //            Response.End();
    //        }
    //        //dglst.AllowPaging = false;
    //        //show();

    //        //dglst.HeaderRow.BackColor = System.Drawing.Color.White;
    //        //foreach (GridViewRow row in dglst.Rows)
    //        //{
    //        //    row.BackColor = System.Drawing.Color.White;
    //        //}

    //        //Response.ClearContent();
    //        //Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_UserReportByCV.xls");
    //        //Response.ContentType = "application/vnd.xls";
    //        //System.IO.StringWriter stw = new System.IO.StringWriter();
    //        //HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        //this.dglst.RenderControl(htextw);
    //        //Response.Write(stw.ToString());
    //        //Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}

    //protected void dglst_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    try
    //    {
    //        if (e.Row.RowType == DataControlRowType.DataRow)
    //        {
    //            if ((Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Status")) == "0"))
    //            {
    //                e.Row.BackColor = System.Drawing.Color.FromName("#FBDCDB");
    //            }
    //        }
    //    }
    //    catch
    //    {
    //    }
    //}

    //public void show()
    //{
    //    DataTable dt = getdate(ddl_Month.SelectedValue, txt_Sponsor.Text.Trim(), txt_SelfRPV.Text.Trim(), ddl_D_GPV_RPV.SelectedValue, txt_D_GPV_RPV.Text.Trim(), txt_Userid.Text.Trim(), "");
    //    if (dt.Rows.Count > 0)
    //    {
    //        dglst.Columns[1].FooterText = "Total: " + dt.Rows.Count;
    //        dglst.DataSource = dt;
    //        dglst.DataBind();
    //    }
    //    else
    //    {
    //        dglst.DataSource = null;
    //        dglst.DataBind();
    //    }
    //}



}