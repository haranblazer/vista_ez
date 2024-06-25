using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_BVwithSponsor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
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
                txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            }
        }
        catch
        {

        }
       
    }

    public void show()
    {
        string fromDate = "", toDate = "";
        int YY1 = 0, MM1 = 0, DD1 = 0, YY2 = 0, MM2 = 0, DD2 = 0;
        try
        {
            if (txtFromDate.Text.Trim().Length > 0)
            {
                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];

                YY1 = int.Parse(Date[2]);
                MM1 = int.Parse(Date[1]);
                DD1 = int.Parse(Date[0]);
            }
            if (txtToDate.Text.Trim().Length > 0)
            {
                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                YY2 = int.Parse(Date[2]);
                MM2 = int.Parse(Date[1]);
                DD2 = int.Parse(Date[0]);
            }
        }
        catch
        {
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }

        DateTime date1 = new DateTime(YY1, MM1, DD1);
        DateTime date2 = new DateTime(YY2, MM2, DD2);
        String Days = (date2 - date1).TotalDays.ToString();
        if (int.Parse(Days) > 31)
        {
            utility.MessageBox(this, "Date Range Maximun 31 days.!!");
            return;
        }

        DataTable dt = getdate(fromDate, toDate, txt_Sponsor.Text.Trim(), txt_SelfRPV.Text.Trim(), ddl_D_GPV_RPV.SelectedValue, txt_D_GPV_RPV.Text.Trim(), "");
        if (dt.Rows.Count > 0)
        {
            dglst.Columns[1].FooterText = "Total: "+ dt.Rows.Count;
            //dglst.Columns[6].FooterText = dt.Compute("sum(RPV)", "true").ToString();
            //dglst.Columns[7].FooterText = dt.Compute("sum(NoOfSponsor)", "true").ToString();
            dglst.DataSource = dt;
            dglst.DataBind();
        }
        else
        {
            dglst.DataSource = null;
            dglst.DataBind();
        }
    }

    static private DataTable getdate(string fromDate, string toDate, string Sponsor, string SelfRPV, string GPV_RPV_Type, string D_GPV_RPV, string Userid)
    {
        SelfRPV = SelfRPV == "" ? "0" : SelfRPV;
        D_GPV_RPV = D_GPV_RPV == "" ? "0" : D_GPV_RPV;
        Sponsor = Sponsor == "" ? "0" : Sponsor;
        SqlParameter[] param = new SqlParameter[]
       {
          new SqlParameter("@Mindate", fromDate),
          new SqlParameter("@Maxdate",  toDate),
          new SqlParameter("@SelfRPV", SelfRPV),
          new SqlParameter("@GPV_RPV_Type", GPV_RPV_Type),
          new SqlParameter("@D_GPV_RPV", D_GPV_RPV),
          new SqlParameter("@NoOfSponsor", Sponsor),
          new SqlParameter("@Userid", Userid),
       };
        DataUtility objDu = new DataUtility();
        return objDu.GetDataTableSP(param, "GetUserByCV");
    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        show();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        show();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (dglst.Rows.Count > 0)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "__UserReportByCV.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                dglst.AllowPaging = false;
                show();

                dglst.HeaderRow.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in dglst.HeaderRow.Cells)
                {
                    cell.BackColor = dglst.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in dglst.Rows)
                {
                    row.BackColor = System.Drawing.Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = dglst.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = dglst.RowStyle.BackColor;
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

                dglst.RenderControl(hw);
                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
            //dglst.AllowPaging = false;
            //show();

            //dglst.HeaderRow.BackColor = System.Drawing.Color.White;
            //foreach (GridViewRow row in dglst.Rows)
            //{
            //    row.BackColor = System.Drawing.Color.White;
            //}

            //Response.ClearContent();
            //Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_UserReportByCV.xls");
            //Response.ContentType = "application/vnd.xls";
            //System.IO.StringWriter stw = new System.IO.StringWriter();
            //HtmlTextWriter htextw = new HtmlTextWriter(stw);
            //this.dglst.RenderControl(htextw);
            //Response.Write(stw.ToString());
            //Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
    }

    protected void dglst_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if ((Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Status")) == "0"))
                {
                    e.Row.BackColor = System.Drawing.Color.FromName("#FBDCDB");
                }
            }
        }
        catch
        {
        }
    }

    [System.Web.Services.WebMethod]
    public static SponsorDetails[] GetSponsorData(string FromDate, string ToDate, string Sponsor, string SelfRPV, string GPV_RPV_Type, string D_GPV_RPV, string userid)
    {
        List<SponsorDetails> details = new List<SponsorDetails>();

        string fromDate = "", toDate = "";

        if (FromDate.Length > 0)
        {
            String[] Date = FromDate.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
            fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
        }
        if (ToDate.Length > 0)
        {
            String[] Date = ToDate.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
            toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
        }
        DataTable dt = getdate(fromDate, toDate, Sponsor, SelfRPV, GPV_RPV_Type, D_GPV_RPV, userid);
        foreach (DataRow dr in dt.Rows)
        {
            SponsorDetails data = new SponsorDetails();
            data.UserId = dr["UserId"].ToString();
            data.UserName = dr["UserName"].ToString();
            data.Mobile = dr["Mobile"].ToString();
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
        public String SponsporId { get; set; }
        public String SponsorName { get; set; }
        public String RPV { get; set; }
        public String GPV { get; set; }
        public String RankName { get; set; }
        public String NoOfSponsor { get; set; }
    }
}