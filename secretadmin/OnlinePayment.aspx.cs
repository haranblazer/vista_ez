using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_OnlinePayment : System.Web.UI.Page
{

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

            ddl_order.Items.Insert(0, new ListItem("All", "-1"));
            ddl_order.Items.Insert(1, new ListItem(method.Associate, "0"));
            ddl_order.Items.Insert(2, new ListItem("Customer", "1"));

            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");

            show();
        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        show();
    }


    public void show()
    {

        string fromDate = "", toDate = "";
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
        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@Min", fromDate),
            new SqlParameter("@Max", toDate),
            new SqlParameter("@Userid", txt_userid.Text.Trim()),
            new SqlParameter("@PaymentStatus", ddl_Status.SelectedValue),
            new SqlParameter("@Amount", txt_Amount.Text=="" ? "0" : txt_Amount.Text),
            new SqlParameter("@Orderid", txt_Orderid.Text.Trim()),
            new SqlParameter("@Orderno", txt_Orderno.Text.Trim()),
            new SqlParameter("@IsCustomer", ddl_order.SelectedValue)
        };
        DataUtility obj_du = new DataUtility();
        DataTable dt = obj_du.GetDataTableSP(param, "Get_OnlinePayment");
        Session["dt"] = dt;
        if (dt.Rows.Count > 0)
        {
            DataColumn sr1 = new DataColumn("srno_Encript", typeof(string));
            dt.Columns.Add(sr1);
            DataColumn b_Srno_Encript = new DataColumn("b_Srno_Encript", typeof(string));
            dt.Columns.Add(b_Srno_Encript);

            foreach (DataRow row in dt.Rows)
            {
                utility objutil = new utility();
                row.SetField("srno_Encript", objutil.base64Encode(row["srno"].ToString()));
                row.SetField("b_Srno_Encript", objutil.base64Encode(row["b_Srno"].ToString()));
            }
            dglst.Columns[4].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(Amount)", "true").ToString()) ? "0.00" : dt.Compute("sum(Amount)", "true").ToString());

            dglst.DataSource = dt;
            dglst.DataBind();
        }
        else
        {
            dglst.DataSource = null;
            dglst.DataBind();
        }
    }


    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        show();
    }

    protected void dglst_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = dglst.Rows[Convert.ToInt32(e.CommandArgument)];
        string Srno = dglst.DataKeys[row.RowIndex].Values[0].ToString();
        string Amount = dglst.DataKeys[row.RowIndex].Values[1].ToString();
        string b_Srno = dglst.DataKeys[row.RowIndex].Values[2].ToString();
        TextBox txt_PayStatus = (TextBox)row.FindControl("txt_PayStatus");
        TextBox txt_UserRemark = (TextBox)row.FindControl("txt_UserRemark");


        try
        {
            utility objutil = new utility();
            if (e.CommandName.Equals("Invoice"))
            {
                Response.Redirect("../Common/Invoice.aspx?id=" + objutil.base64Encode(b_Srno));
            }
            if (e.CommandName.Equals("ViewDetail"))
            {
                Response.Redirect("OnlinePayDetail.aspx?id=" + objutil.base64Encode(Srno));
            }

            if (e.CommandName.Equals("Success"))
            {

                if (string.IsNullOrEmpty(txt_UserRemark.Text))
                {
                    utility.MessageBox(this, "Please enter remark.");
                    txt_UserRemark.Focus();
                    return;
                }
                DataUtility objDUT = new DataUtility();

                SqlParameter[] sqlparam = new SqlParameter[] {
                        new SqlParameter("@TYPE", "SUCCESS"),
                        new SqlParameter("@ORDERID", Srno),
                         new SqlParameter("@tracking_id", "0"),
                        new SqlParameter("@TXNAMOUNT", Amount),
                        new SqlParameter("@STATUS", "TXN_SUCCESS"),
                        new SqlParameter("@RESPMSG", txt_PayStatus.Text.Trim()),
                        new SqlParameter("@UserRemark", txt_UserRemark.Text.Trim()),

                        new SqlParameter("@REPONSE", "Approved by Admin"),
                        new SqlParameter("@OnlineRemark", ""),
                        new SqlParameter("@LogId", System.Web.HttpContext.Current.Session["admin"].ToString()),
                        new SqlParameter("@IP", System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] == null ? System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] : System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"])
                };


                DataTable dt =objDUT.GetDataTableSP(sqlparam, "Usp_OnlineSucessProcess");
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["Status"].ToString() == "1")
                    {
                        DataTable dt1 = objDUT.GetDataTable("Select InvoiceNo from billmst where srno=" + dt.Rows[0]["InvNo"].ToString());
                        if (dt1.Rows.Count > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Invoice Generated Successfully.');window.location='OnlinePayment.aspx';", true);

                            utility.MessageBox(this, "Invoice Number is :" + dt1.Rows[0]["InvoiceNo"].ToString());
                        }
                    }
                    else
                    {
                        utility.MessageBox(this, dt.Rows[0]["Status"].ToString());
                    }
                }
                else
                {
                    utility.MessageBox(this, "Server Error. Please Try again.");
                }
                show();
            }
        }
        catch (Exception er)
        {

            utility.MessageBox(this, er.Message);
            //utility.MessageBox(this, System.Web.HttpContext.Current.Session["LogId"].ToString());
        }
    }

    protected void dglst_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lnk_Success = (LinkButton)e.Row.FindControl("lnk_Success");
            LinkButton lnkinvoiceno = (LinkButton)e.Row.FindControl("lnkinvoiceno");

            HiddenField lnkbtn = (HiddenField)e.Row.FindControl("hnd_Srno");
            HiddenField hnd_b_Srno = (HiddenField)e.Row.FindControl("hnd_b_Srno");
            HiddenField hnd_PaymentStatus = (HiddenField)e.Row.FindControl("hnd_PaymentStatus");
            HiddenField hnd_invoiceno = (HiddenField)e.Row.FindControl("hnd_invoiceno");
            TextBox txt_PayStatus = (TextBox)e.Row.FindControl("txt_PayStatus");


            if (!string.IsNullOrEmpty(hnd_invoiceno.Value))
            {
                e.Row.ForeColor = Color.FromName("#009900");
                lnk_Success.Visible = false;
                txt_PayStatus.Enabled = false;
            }
            else
            {
                e.Row.ForeColor = Color.FromName("#000000");
            }

        }
    }


    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Session["dt"];

            if (dt.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "OnlinePayment.xls"));
                Response.ContentType = "application/ms-excel";
                string str = string.Empty;
                foreach (DataColumn dtcol in dt.Columns)
                {
                    Response.Write(str + dtcol.ColumnName);
                    str = "\t";
                }
                Response.Write("\n");
                foreach (DataRow dr in dt.Rows)
                {
                    str = "";
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Response.Write(str + Convert.ToString(dr[j]));
                        str = "\t";
                    }
                    Response.Write("\n");
                }
                Response.End();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found.');", true);
            }
        }
        catch (Exception er) { }

    }



}