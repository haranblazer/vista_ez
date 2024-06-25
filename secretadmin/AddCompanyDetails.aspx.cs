using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
public partial class winneradmin_ADDProduct : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = new DataTable();
    SqlCommand cmd;
    SqlDataAdapter adp;
    int id = 0;
    Validation val = new Validation();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindGrid();
        }
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            InsertFunction.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            InsertFunction.CheckAdminlogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
    }

    private void addBank()
    {
        con.Open();
        try
        {
            SqlCommand cmd = new SqlCommand("SetBankDetails", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@BankName", txtBankName.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@AccountNo", txtAccNo.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@Accountname", ddlAcType.SelectedItem.Text.Trim());
            cmd.Parameters.AddWithValue("@branch", txtbranch.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@ifs", txtifs.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@userid", "-111");
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            string msg = cmd.Parameters["@flag"].Value.ToString();
            utility.MessageBox(this, msg);
            BindGrid();
            con.Close();
        }
        catch
        {
        }
        txtBankName.Text = txtAccNo.Text = txtbranch.Text = txtifs.Text = string.Empty;
        ddlAcType.SelectedIndex = 0;
    }

    private void BindGrid()
    {

        adp = new SqlDataAdapter();

        try
        {
            // adp = new SqlDataAdapter("select userid,srno,CompanyBank,CompanyAccNo, AccountName, branch, ifs,   Active from companymst where (CompanyBank like @searchtext or CompanyAccNo like @searchtext) and (case when Active=@isActive then 1 when @isActive is null or @isActive=-1 then 1 else 0 end)=1", con);
            adp = new SqlDataAdapter("showbankdetail", con);
            adp.SelectCommand.CommandType = CommandType.StoredProcedure;
            //adp.SelectCommand.CommandType = CommandType.Text;
            adp.SelectCommand.Parameters.AddWithValue("@searchtext", '%' + txtSearch.Text.Trim() + '%');
            adp.SelectCommand.Parameters.AddWithValue("@isActive", ddSearch.SelectedItem.Value);
            adp.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                GridView1.DataSource = dt;
                GridView1.DataBind();
                lblCount.Text = "No of Records:" + dt.Rows.Count;

            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                lblCount.Text = string.Empty;
            }
        }


        catch
        {
        }
        finally
        {
            con.Dispose();

        }

    }

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        Regex regnumeric = new Regex(@"^[0-9]*$");

        if (!string.IsNullOrEmpty(txtBankName.Text.Trim()) && val.IsAlphabets(txtBankName.Text.Trim()))
        {

            if (ddlAcType.SelectedIndex != 0)
            {

                if (!string.IsNullOrEmpty(txtAccNo.Text.Trim()) && regnumeric.IsMatch(txtAccNo.Text.Trim()))
                {

                    if (!string.IsNullOrEmpty(txtbranch.Text.Trim()) && val.IsAlphabets(txtbranch.Text.Trim()))
                    {

                        if (!string.IsNullOrEmpty(txtifs.Text.Trim()) && val.IsAlphaNumeric(txtifs.Text.Trim()))
                        {

                            if (btnInsert.Text == "Submit")
                            {
                                addBank();
                            }
                            if (btnInsert.Text == "Update")
                            {
                                UpdateBank();
                            }

                        }
                        else
                        {
                            utility.MessageBox(this, "Please enter correct IFSC Code.");
                            txtifs.Focus();
                            return;

                        }

                    }
                    else
                    {
                        utility.MessageBox(this, "Please enter correct Branch.");
                        txtbranch.Focus();
                        return;
                    }

                }

                else
                {
                    utility.MessageBox(this, "Please Enter Correct Bank A/C No.");
                    txtAccNo.Focus();
                    return;
                }

            }
            else
            {
                utility.MessageBox(this, "Please Select A/C Type.");
                ddlAcType.Focus();
                return;
            }

        }
        else
        {

            utility.MessageBox(this, "Please Enter Correct Bank Name.");
            txtBankName.Focus();
            return;
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        txtSearch.Text = string.Empty;
        BindGrid();
    }

    public void updateStatus(int id, int st)
    {

        adp = new SqlDataAdapter();
        try
        {

            cmd = new SqlCommand("update CompanyMst set Active=@Active where SrNo=@Id", con);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 99999;
            cmd.Parameters.AddWithValue("@Active", st);
            cmd.Parameters.AddWithValue("@Id", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            BindGrid();
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            adp.Dispose();
        }
    }


    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (ddSearch.SelectedItem.Text == "All" || ddSearch.SelectedItem.Text == "Active" || ddSearch.SelectedItem.Text == "InActive")
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                BindGrid();
                GridView1.Columns[8].Visible = GridView1.Columns[9].Visible = GridView1.Columns[10].Visible = false;
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_BankList.doc");
                Response.ContentType = "application/vnd.ms-word";
                System.IO.StringWriter stw = new System.IO.StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                this.GridView1.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();

            }
            else
                utility.MessageBox(this, "can not export as no data found !");
        }
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (ddSearch.SelectedItem.Text == "All" || ddSearch.SelectedItem.Text == "Active" || ddSearch.SelectedItem.Text == "InActive")
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                BindGrid();
                GridView1.Columns[8].Visible = GridView1.Columns[9].Visible = GridView1.Columns[10].Visible = false;
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_BankList.xls");
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter stw = new System.IO.StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                this.GridView1.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();

            }
            else
                utility.MessageBox(this, "can not export as no data found !");
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            System.Web.UI.WebControls.Image img = (System.Web.UI.WebControls.Image)e.Row.FindControl("imgStatus");
            LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkbtnStatus");
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Active")) == "1")
            {
                img.ImageUrl = "images/yes.jpeg";
                lnkbtn.Text = "De-Activate";
                lnkbtn.CommandName = "DeActivate";
            }
            else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Active")) == "0")
            {
                img.ImageUrl = "images/no.jpeg";
                lnkbtn.Text = "Activate";
                lnkbtn.CommandName = "Activate";
            }
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName != "Page")
        {
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            id = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);

            if (e.CommandName == "DeActivate")
            {
                updateStatus(id, 0);
                utility.MessageBox(this, "Account No De-activated successfully !");
            }
            else if (e.CommandName == "Activate")
            {
                updateStatus(id, 1);
                utility.MessageBox(this, "Account No activated successfully !");
            }


        }

    }

    protected void ddSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }


    private void UpdateBank()
    {
        con.Open();
        cmd = new SqlCommand("UpdateBank", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@srno", Session["srno"].ToString());
        cmd.Parameters.AddWithValue("@BankName", txtBankName.Text.Trim());
        cmd.Parameters.AddWithValue("@Acno", txtAccNo.Text.Trim());
        cmd.Parameters.AddWithValue("@Actype", ddlAcType.SelectedItem.Text.Trim());
        cmd.Parameters.AddWithValue("@Branch", txtbranch.Text.Trim());
        cmd.Parameters.AddWithValue("@IFSC", txtifs.Text.Trim());
        cmd.ExecuteNonQuery();
        utility.MessageBox(this, "Bank Details Updated Successfully.");
        BindGrid();
        btnInsert.Text = "Submit";
        txtAccNo.Text = txtBankName.Text = txtbranch.Text = txtifs.Text = string.Empty;
        ddlAcType.SelectedIndex = 0;
        con.Close();


    }


    protected void lnkbtn_Click(object sender, EventArgs e)
    {
        GridViewRow row = (GridViewRow)((LinkButton)sender).NamingContainer;
        int srno = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
        Session["srno"] = srno.ToString();
        txtBankName.Text = row.Cells[3].Text;
        ddlAcType.SelectedIndex = ddlAcType.Items.IndexOf(ddlAcType.Items.Cast<System.Web.UI.WebControls.ListItem>().Where(o => string.Compare(o.Value, row.Cells[4].Text, true) == 0).FirstOrDefault());
        txtAccNo.Text = row.Cells[5].Text;
        txtbranch.Text = row.Cells[6].Text;
        txtifs.Text = row.Cells[7].Text;
        btnInsert.Text = "Update";
    }
}
