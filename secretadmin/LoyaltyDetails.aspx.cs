using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_RoyaltyDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Request.QueryString.Count > 0)
                {
                    show(secure.Decrypt(Request.QueryString["From"]), secure.Decrypt(Request.QueryString["To"]),
                       secure.Decrypt(Request.QueryString["MinV"]),
                        secure.Decrypt(Request.QueryString["MaxV"]), secure.Decrypt(Request.QueryString["userid"]),
                        secure.Decrypt(Request.QueryString["MonthName"]), secure.Decrypt(Request.QueryString["SessionId"]));
                }
            }
        }
        catch (Exception er)
        {

        }
    }

    public void show(string fromDate, string toDate, string MinV, string MaxV, string Userid, string MonthName, string SessionId)
    {
        try
        {
            DataTable dt = getdate(fromDate, toDate, MinV, MaxV, Userid, MonthName, SessionId);
            if (dt.Rows.Count > 0)
            {
                GridView1.Columns[2].FooterText = "Total : " + dt.Rows.Count;
                GridView1.Columns[7].FooterText = dt.Compute("sum(RPV)", "true").ToString();
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {

                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        catch (Exception er)
        {
            utility.MessageBox(this, "Invalid date entry.");
            return;
        }


    }

    static private DataTable getdate(string fromDate, string toDate, string MinV, string MaxV, string Userid, string MonthName, string SessionId)
    {
        SqlParameter[] param = new SqlParameter[]
       {
          new SqlParameter("@Mindate", fromDate),
          new SqlParameter("@Maxdate",  toDate),
          new SqlParameter("@MinV", MinV),
          new SqlParameter("@MaxV", MaxV),
          new SqlParameter("@Userid", Userid),
          new SqlParameter("@MonthName", MonthName),
          new SqlParameter("@SessionId", SessionId),
       };
        DataUtility objDu = new DataUtility();
        return objDu.GetDataTableSP(param, "GetLegwise_Loyalty");
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


                show(secure.Decrypt(Request.QueryString["From"]), secure.Decrypt(Request.QueryString["To"]),
                           secure.Decrypt(Request.QueryString["MinV"]),
                           secure.Decrypt(Request.QueryString["MaxV"]), secure.Decrypt(Request.QueryString["userid"]),
                           secure.Decrypt(Request.QueryString["MonthName"]), secure.Decrypt(Request.QueryString["SessionId"]));

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