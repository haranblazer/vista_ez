using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_ReawardWallet : System.Web.UI.Page
{
    DataTable dt = new DataTable();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    utility u = new utility();
    SqlDataReader dr;
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
                txtFromDate.Text = DateTime.Now.AddDays(-30).Date.ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
                Bind();
            }
        }
        catch
        {

        }



    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        Bind();
    }



    public void Bind()
    {
        try
        {
            string strmin = "", strmax = "";
            try
            {

                if (txtFromDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    strmin = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
                if (txtToDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    strmax = Date[1] + "/" + Date[0] + "/" + Date[2];
                }

            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }
            da = new SqlDataAdapter("GetRewardAdminwallet", con);
            con.Open();
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@regno", Session["admin"].ToString());
            da.SelectCommand.Parameters.AddWithValue("@min", strmin);
            da.SelectCommand.Parameters.AddWithValue("@max", strmax);
            da.SelectCommand.Parameters.AddWithValue("@UserId", txt_Userid.Text.Trim());
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                dglst.DataSource = dt;
                dglst.DataBind();
            }

            else
            {
                dglst.DataSource = null;
                dglst.DataBind();
            }

            con.Close();

        }
        catch (Exception ex)
        {
        }

    }




    protected void Button1_Click(object sender, EventArgs e)
    {
        Bind();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {

        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_RewardWallet.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            dglst.AllowPaging = false;
            Bind();

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

    }
}