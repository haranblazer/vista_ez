using System;
//using System.Collections.Generic;
using System.Linq;
//using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Web;
using System.IO;
using System.Collections.Generic;

public partial class user_OrderList : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    /// <summary>
    /// //By <S>
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            DateTime now = DateTime.Now;
            var startDate = new DateTime(now.Year, now.Month, 1);

            txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");

            BindGrid1();
        }
    }


    /// <summary>
    /// //By <S>
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid1();
    }

    /// <summary>
    /// //By <S>
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid1();
    }

    private void BindGrid1()
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


            con = new SqlConnection(method.str);
            SqlDataAdapter ad = new SqlDataAdapter("billdetail", con);
            ad.SelectCommand.CommandType = CommandType.StoredProcedure;
            ad.SelectCommand.Parameters.AddWithValue("@search", txtSearch.Text == "" ? "" : txtSearch.Text);
            ad.SelectCommand.Parameters.AddWithValue("@min", strmin);
            ad.SelectCommand.Parameters.AddWithValue("@max", strmax);
            ad.SelectCommand.Parameters.AddWithValue("@salesrepid", Session["franchiseid"].ToString());
            ad.SelectCommand.Parameters.AddWithValue("@SoldTo", "");
            ad.SelectCommand.Parameters.AddWithValue("@Del_Status", ddl_DispatchStatus.SelectedValue);
            ad.SelectCommand.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
            dt = new DataTable();
            ad.Fill(dt);
            DataColumn dcDtl = new DataColumn("tbl", typeof(string));
            dt.Columns.Add(dcDtl);

            DataColumn srno_Encript = new DataColumn("srno_Encript", typeof(string));
            dt.Columns.Add(srno_Encript);

            foreach (DataRow row in dt.Rows)
            {
                utility objutil = new utility();
                row.SetField("srno_Encript", objutil.base64Encode(row["srno"].ToString()));

                XElement objXml = XElement.Parse(row["dtl"].ToString());
                string strDtl = "<table rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
                strDtl += "<tr><th>Name</th><th>Quantity</th><th>MRP</th><th>BV</th><th>Total</th></tr>";
                foreach (XElement p in objXml.Elements("P"))
                {
                    strDtl += "<tr>";
                    strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("MRP").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("BV").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
                    strDtl += "</tr>";
                }
                strDtl += "</table>";
                row["tbl"] = strDtl;
            }
            GridView1.Columns[12].FooterText = dt.Compute("sum(grossAmt)", "true").ToString();
            GridView1.Columns[13].FooterText = dt.Compute("sum(SGST)", "true").ToString();
            GridView1.Columns[14].FooterText = dt.Compute("sum(CGST)", "true").ToString();
            GridView1.Columns[15].FooterText = dt.Compute("sum(IGST)", "true").ToString();
            GridView1.Columns[16].FooterText = dt.Compute("sum(CourierCharges)", "true").ToString();
            GridView1.Columns[17].FooterText = dt.Compute("sum(netAmt)", "true").ToString();
           
            GridView1.Columns[18].FooterText = dt.Compute("sum(PV)", "true").ToString();
            GridView1.Columns[19].FooterText = dt.Compute("sum(BV)", "true").ToString();
            GridView1.Columns[20].FooterText = dt.Compute("sum(TotalFPV)", "true").ToString();
            GridView1.Columns[21].FooterText = dt.Compute("sum(NoOFProduct)", "true").ToString();
            GridView1.Columns[22].FooterText = dt.Compute("sum(Actual_Qty)", "true").ToString();


            // GridView1.Columns[20].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(TotalFPV)", "true").ToString()) ? "0.00" : dt.Compute("sum(TotalFPV)", "true").ToString());

            GridView1.DataSource = dt;
            GridView1.DataBind();
            //if (dt.Rows.Count > 0)
            //{
            //    lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
            //    lblTotal.Text += ", Billing Amt: " + (string.IsNullOrEmpty(dt.Compute("sum(grossamt)", "true").ToString()) ? "0.00" : dt.Compute("sum(grossamt)", "true").ToString());
            //    lblTotal.Text += ", Invoice  Amt: " + (string.IsNullOrEmpty(dt.Compute("sum(amt)", "true").ToString()) ? "0.00" : dt.Compute("sum(amt)", "true").ToString());
            //    lblTotal.Text += ", Tax: " + (string.IsNullOrEmpty(dt.Compute("sum(tax)", "true").ToString()) ? "0.00" : dt.Compute("sum(tax)", "true").ToString());
            //    //lblTotal.Text += ", Net: " + (string.IsNullOrEmpty(dt.Compute("sum(netAmt)", "true").ToString()) ? "0.00" : dt.Compute("sum(netAmt)", "true").ToString());
            //    lblTotal.Text += ", TPV: " + (string.IsNullOrEmpty(dt.Compute("sum(bv)", "true").ToString()) ? "0.00" : dt.Compute("sum(bv)", "true").ToString());
            //    lblTotal.Text += ", RPV: " + (string.IsNullOrEmpty(dt.Compute("sum(PV)", "true").ToString()) ? "0.00" : dt.Compute("sum(PV)", "true").ToString());

            //}
            //else
            //{

            //    lblTotal.Text = "No record";
            //}
        }
        catch (Exception ex)
        {
        }
    }


    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
    }


    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
        try
        {
            string invoiceno = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
            if (e.CommandName.Equals("cancel"))
            {
                con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("Billcancel", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@invoiceno", invoiceno);
                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                if (cmd.Parameters["@flag"].Value.ToString() == "1")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Bill cancel Successfully.');window.location='BillingList.aspx';", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('" + cmd.Parameters["@flag"].Value.ToString() + "');window.location='BillingList.aspx';", true);

                    // utility.MessageBox(this, cmd.Parameters["@flag"].Value.ToString());
                }
            }


            if (e.CommandName == "update")
            {
                TextBox txtTransport = (TextBox)row.FindControl("txtTransport");
                TextBox txtTracking = (TextBox)row.FindControl("txtTracking");
                TextBox txt_EWayBill = (TextBox)row.FindControl("txt_EWayBill");
                TextBox txtcmt = (TextBox)row.FindControl("txtcom");
                con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("Update_Del_Invoice", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@invoiceno", invoiceno);
                cmd.Parameters.AddWithValue("@Transport", txtTransport.Text);
                cmd.Parameters.AddWithValue("@Tracking", txtTracking.Text);
                cmd.Parameters.AddWithValue("@EWayBill", txt_EWayBill.Text);
                cmd.Parameters.AddWithValue("@Del_Remarks", txtcmt.Text);
                cmd.Parameters.AddWithValue("@Del_by", Session["franchiseid"].ToString());
                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                string status2 = cmd.Parameters["@flag"].Value.ToString();
                if (status2 == "1")
                {
                    utility.MessageBox(this, "Deliver Updated Successfully");
                    BindGrid1();
                }
                else
                {
                    utility.MessageBox(this, status2);
                }
            }

        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }
        finally
        {

        }

    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    { }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //LinkButton lnkbtn_Cancel = (LinkButton)e.Row.FindControl("lnkbtn_Cancel");
            Label lblcancelled = (Label)e.Row.FindControl("lbl_cancelled");
            HiddenField H_Status = (HiddenField)e.Row.FindControl("hdn_status");

            HiddenField hnd_Del_Status = (HiddenField)e.Row.FindControl("hnd_Del_Status");
            //Button btnSubmit = (Button)e.Row.FindControl("btnSubmit");
            //TextBox txtcmt = (TextBox)e.Row.FindControl("txtcom");

            //if (hnd_Del_Status.Value == "0")
            //    btnSubmit.Enabled = true;
            //else
            //{
            //    btnSubmit.Enabled = false;
            //  //  txtcmt.Enabled = false;
            //}

            if (H_Status.Value == "Submit")
            {
                //lnkbtn_Cancel.Enabled = true;
                lblcancelled.Text = "Submit";
                lblcancelled.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                // lnkbtn_Cancel.Enabled = false;
                //lnkbtn_Cancel.Text = "";
                lblcancelled.Text = "Cancelled";
                lblcancelled.ForeColor = System.Drawing.Color.Red;
                e.Row.ForeColor = System.Drawing.Color.Red;
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#ffdadc");
            }
        }
    }




    public override void VerifyRenderingInServerForm(Control control)
    {

    }


    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindGrid1();
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ViewSalesBills.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
    }


    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_AssociateInvList.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            GridView1.AllowPaging = false;
            BindGrid1();
            GridView1.HeaderRow.BackColor =System.Drawing.Color.White;
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



        //if (GridView1.Rows.Count > 0)
        //{
        //    GridView1.AllowPaging = false;
        //    BindGrid1();
        //    Response.Clear();
        //    Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ViewSalesBills.xls");
        //    Response.Charset = "";
        //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //    Response.ContentType = "application/vnd.xls";
        //    System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        //    System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        //    this.GridView1.RenderControl(htmlWrite);
        //    Response.Write(stringWrite.ToString());
        //    Response.End();
        //}
        //else
        //{
        //    utility.MessageBox(this, "Can't export as no data found.");
        //}

    }
}
