using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_LegWiseRoyalty : System.Web.UI.Page
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
                txtFromDate.Text = DateTime.Now.Date.AddMonths(-4).ToString("dd/MM/yyyy").Replace("-", "/");
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
        string MinV = txt_MinV.Text.Trim() == "" ? "0" : txt_MinV.Text.Trim();
        string MaxV = txt_MaxV.Text.Trim() == "" ? "0" : txt_MaxV.Text.Trim();

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
        if (int.Parse(Days) > 365)
        {
            utility.MessageBox(this, "Date Range Maximun 12 Months.!!");
            return;
        }
        if (string.IsNullOrEmpty(txt_Userid.Text.Trim()))
        {
            utility.MessageBox(this, "Please Enter User Id.!!");
            return;
        }
        if (MinV == "0")
        {
            utility.MessageBox(this, "Please Enter Min Values.!!");
            return;
        }
        if (MaxV == "0")
        {
            utility.MessageBox(this, "Please Enter Max Values.!!");
            return;
        }

        DataTable dt = getdate(fromDate, toDate, MinV, MaxV, txt_Userid.Text.Trim(), "");
        //lbl_Msg.Text = "Total: " + dt.Rows.Count;
        if (dt.Rows.Count > 0)
        {
            GridView1.Columns[2].FooterText = "Total : " + dt.Rows.Count;
            GridView1.Columns[6].FooterText = dt.Compute("sum(Jan)", "true").ToString();
            GridView1.Columns[7].FooterText = dt.Compute("sum(Feb)", "true").ToString();
            GridView1.Columns[8].FooterText = dt.Compute("sum(Mar)", "true").ToString();
            GridView1.Columns[9].FooterText = dt.Compute("sum(Apr)", "true").ToString();

            GridView1.Columns[10].FooterText = dt.Compute("sum(May)", "true").ToString();
            GridView1.Columns[11].FooterText = dt.Compute("sum(Jun)", "true").ToString();
            GridView1.Columns[12].FooterText = dt.Compute("sum(Jul)", "true").ToString();
            GridView1.Columns[13].FooterText = dt.Compute("sum(Aug)", "true").ToString();

            GridView1.Columns[14].FooterText = dt.Compute("sum(Sep)", "true").ToString();
            GridView1.Columns[15].FooterText = dt.Compute("sum(Oct)", "true").ToString();
            GridView1.Columns[16].FooterText = dt.Compute("sum(Nov)", "true").ToString();
            GridView1.Columns[17].FooterText = dt.Compute("sum(Dec)", "true").ToString();

            GridView1.DataSource = dt;
            GridView1.DataBind();

            GridView1.Columns[6].Visible = false;
            GridView1.Columns[7].Visible = false;
            GridView1.Columns[8].Visible = false;
            GridView1.Columns[9].Visible = false;
            GridView1.Columns[10].Visible = false;
            GridView1.Columns[11].Visible = false;
            GridView1.Columns[12].Visible = false;
            GridView1.Columns[13].Visible = false;
            GridView1.Columns[14].Visible = false;
            GridView1.Columns[15].Visible = false;
            GridView1.Columns[16].Visible = false;
            GridView1.Columns[17].Visible = false;
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReader(@"Select Month=Cast(DateName(Month,DATEADD(Month,x.number,DateAdd(Month, -4, GETDATE()))) as varchar(3))
            FROM master.dbo.spt_values x WHERE x.type = 'P' AND x.number <= DATEDIFF(Month, DateAdd(Month, -4, GETDATE()), DateAdd(Month, -1, GETDATE()))");
            while (dr.Read())
            {
                if (dr["Month"].ToString() == "Jan")
                    GridView1.Columns[6].Visible = true;
                else if (dr["Month"].ToString() == "Feb")
                    GridView1.Columns[7].Visible = true;
                else if (dr["Month"].ToString() == "Mar")
                    GridView1.Columns[8].Visible = true;
                else if (dr["Month"].ToString() == "Apr")
                    GridView1.Columns[9].Visible = true;
                else if (dr["Month"].ToString() == "May")
                    GridView1.Columns[10].Visible = true;
                else if (dr["Month"].ToString() == "Jun")
                    GridView1.Columns[11].Visible = true;
                else if (dr["Month"].ToString() == "Jul")
                    GridView1.Columns[12].Visible = true;
                else if (dr["Month"].ToString() == "Aug")
                    GridView1.Columns[13].Visible = true;
                else if (dr["Month"].ToString() == "Sep")
                    GridView1.Columns[14].Visible = true;
                else if (dr["Month"].ToString() == "Oct")
                    GridView1.Columns[15].Visible = true;
                else if (dr["Month"].ToString() == "Nov")
                    GridView1.Columns[16].Visible = true;
                else if (dr["Month"].ToString() == "Dec")
                    GridView1.Columns[17].Visible = true;
            }

        }
        else
        {

            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }


    protected void Grdreport_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string fromDate = "", toDate = "",  SessionId = txt_Userid.Text.Trim();
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

        string MinV = txt_MinV.Text.Trim() == "" ? "0" : txt_MinV.Text.Trim();
        string MaxV = txt_MaxV.Text.Trim() == "" ? "0" : txt_MaxV.Text.Trim();

        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
        string UserId = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
        if (e.CommandName == "Jan")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));
        else if (e.CommandName == "Feb")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));
        else if (e.CommandName == "Mar")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));
        else if (e.CommandName == "Apr")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));
        else if (e.CommandName == "May")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));
        else if (e.CommandName == "Jun")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));
        else if (e.CommandName == "Jul")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));
        else if (e.CommandName == "Aug")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));
        else if (e.CommandName == "Sep")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));
        else if (e.CommandName == "Oct")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));
        else if (e.CommandName == "Nov")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));
        else if (e.CommandName == "Dec")
            Response.Redirect("LoyaltyDetails.aspx?From=" + secure.Encrypt(fromDate) + "&To=" + secure.Encrypt(toDate) + "&MinV=" + secure.Encrypt(MinV) + "&MaxV=" + secure.Encrypt(MaxV) + "&userid=" + secure.Encrypt(UserId) + "&MonthName=" + secure.Encrypt(e.CommandName) + "&SessionId=" + secure.Encrypt(SessionId));

    }


    static private DataTable getdate(string fromDate, string toDate, string MinV, string MaxV, string Userid, string MonthName)
    {
        SqlParameter[] param = new SqlParameter[]
       {
          new SqlParameter("@Mindate", fromDate),
          new SqlParameter("@Maxdate",  toDate),
          new SqlParameter("@MinV", MinV),
          new SqlParameter("@MaxV", MaxV),
          new SqlParameter("@Userid", Userid),
          new SqlParameter("@MonthName", MonthName),
       };
        DataUtility objDu = new DataUtility();
        return objDu.GetDataTableSP(param, "GetLegwise_Loyalty");
    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
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
        if (GridView1.Rows.Count > 0)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "__UserLegwiseRoyalty.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                GridView1.AllowPaging = false;
                show();

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
        }
        else
            utility.MessageBox(this, "can not export as no data found !");
    }


}