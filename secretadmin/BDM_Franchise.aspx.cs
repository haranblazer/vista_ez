using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

using System.Collections.Generic;
using System.Linq;
using System.Web.Services;
using System.IO;

public partial class secretadmin_BDM_Franchise : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = new DataTable();
    SqlCommand cmd;
    SqlDataAdapter adp;
    string fid = null;
    string fname = null;
    string fmobile = null;
    string DecPwd = null;
    utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-7).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");

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


            BindState();
            Bind_FranchiseTypeEdit();
            BindGrid(null);
        }
    }


    [WebMethod]
    public static string ViewBalance(int FranchiseId)
    {
        String Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@FranchiseId", FranchiseId)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetFranchiseTotalBal");
            while (dr.Read())
            {
                Result = dr["DPWithTax"].ToString();
            }
        }
        catch (Exception er) { Result = "0"; }
        return Result;
    }

    private string SortDirection
    {
        get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }

    protected void OnSorting(object sender, GridViewSortEventArgs e)
    {

        string SortDir = string.Empty;
        this.BindGrid(e.SortExpression);
        if (ViewState["SortDirection"].ToString() == "ASC")
        {
            SortDir = "Sorting in ascending order.";
        }
        else
        {
            SortDir = "Sorting in descending order.";
        }
    }
    private void BindGrid(string sortExpression)
    {
        adp = new SqlDataAdapter();
        try
        {
            String fromDate = "", toDate = "";
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
                utility.MessageBox(this, "Invalid date entry2.");
                return;
            }


            string State = "", District = "";
            if (ddl_State.SelectedValue != "")
                State = ddl_State.SelectedItem.ToString();

            if (ddl_District.SelectedValue != "")
                District = ddl_District.SelectedItem.ToString();

            SqlParameter[] param = new SqlParameter[]
           {
                new SqlParameter("@FromDate", fromDate),
                new SqlParameter("@ToDate", toDate),
                new SqlParameter("@Name", string.IsNullOrEmpty(txtSearch.Text.Trim()) == true ? null : txtSearch.Text.Trim()),
                  new SqlParameter("@State", State),
                  new SqlParameter("@District", District),
                new SqlParameter("@City", txt_City.Text.Trim()),
                 new SqlParameter("@PIN", txt_PIN.Text.Trim()),
               new SqlParameter("@FranType",ddl_Type.SelectedValue),
                new SqlParameter("@appmstActivate", ddl_IsActive.SelectedValue),
                new SqlParameter("@mobile",txt_Mob.Text.Trim()),
                 new SqlParameter("@PanNo", txt_PanNo.Text.Trim()),
                  new SqlParameter("@GST", txt_GST.Text.Trim()),
                  new SqlParameter("@Adminid", Session["admin"].ToString())
           };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "getFranchiseList");

            if (dt.Rows.Count > 0)
            {

                if (sortExpression != null)
                {
                    DataView dv = dt.AsDataView();
                    this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
                    dv.Sort = sortExpression + " " + this.SortDirection;
                    lblCount.Text = "No of Records :" + dt.Rows.Count.ToString();
                    GridView1.PageSize = ddPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddPageSize.SelectedValue.ToString());
                    GridView1.DataSource = dv;
                    GridView1.DataBind();
                }
                else
                {
                    lblCount.Text = "No of Records :" + dt.Rows.Count.ToString();
                    GridView1.PageSize = ddPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddPageSize.SelectedValue.ToString());
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }


            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();

        }

    }

    protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {

        BindGrid(null);
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid(null);
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        BindGrid(null);
    }
    public void updateStatus(string id, int st)
    {
        try
        {
            con = new SqlConnection(method.str);
            cmd = new SqlCommand("update FranchiseMst set appmstActivate=@appmstActivate where FranchiseId=@Fid", con);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 99999;
            cmd.Parameters.AddWithValue("@appmstActivate", st);
            cmd.Parameters.AddWithValue("@FId", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            BindGrid(null);
        }
        catch
        {
        }
        finally
        {
            con.Dispose();

        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid(null);
    }

    private static Random random = new Random();
    public static string RandomString(int length)
    {
        const string chars = "abcdefghijklmnpqrstuvwxyz123456789";
        return new string(Enumerable.Repeat(chars, length)
          .Select(s => s[random.Next(s.Length)]).ToArray());
    }



    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "Page" && e.CommandName != "Sort")
        {
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            ViewState["fid"] = fid = GridView1.DataKeys[row.RowIndex].Value.ToString();
            if (e.CommandName == "DeActivate")
            {
                updateStatus(fid, 0);
                utility.MessageBox(this, "Franchise de-activated successfully !");
            }
            else if (e.CommandName == "Activate")
            {
                updateStatus(fid, 1);
                utility.MessageBox(this, "Franchise activated successfully !");
            }

            if (e.CommandName.Equals("Edit"))
            {
                Response.Redirect("CreateFranchise.aspx?n=" + obj.base64Encode(fid));
            }
            if (e.CommandName.Equals("login"))
            {
                Session["franchiseid"] = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
                Session["username"] = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
                Session["userid"] = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
                Session["name"] = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
                Session["frantype"] = GridView1.DataKeys[row.RowIndex].Values[2].ToString();
                Session["LogId"] = Session["admin"].ToString();

                Response.Redirect("~/franchise/welcome.aspx", false);

            }
            if (e.CommandName.Equals("StockView"))
            {
                Session["franchiseid"] = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
                Session["username"] = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
                Session["userid"] = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
                Session["name"] = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
                Session["frantype"] = GridView1.DataKeys[row.RowIndex].Values[2].ToString();
                Session["LogId"] = Session["admin"].ToString();
                OpenNewBrowserWindow("../franchise/ClosingStock.aspx", this);

            }
            if (e.CommandName.Equals("VendorAuth") || e.CommandName.Equals("IsReturn") || e.CommandName.Equals("Status") || e.CommandName.Equals("SampleAllowed") || e.CommandName.Equals("RegeneratePwd"))
            {
                try
                {
                    con = new SqlConnection(method.str);

                    if (e.CommandName.Equals("VendorAuth"))
                        cmd = new SqlCommand("update FranchiseMst set IsVendorAuth=(Case when isnull(IsVendorAuth,0)=0 then 1 else 0 end) where FranchiseId=@Fid", con);

                    if (e.CommandName.Equals("IsReturn"))
                        cmd = new SqlCommand("update FranchiseMst set IsReturn=(Case when isnull(IsReturn,0)=0 then 1 else 0 end) where FranchiseId=@Fid", con);

                    if (e.CommandName.Equals("Status"))
                        cmd = new SqlCommand("update FranchiseMst set appmstActivate=(Case when isnull(appmstActivate,0)=0 then 1 else 0 end) where FranchiseId=@Fid", con);

                    if (e.CommandName.Equals("SampleAllowed"))
                        cmd = new SqlCommand("update FranchiseMst set SampleAllowed=(Case when isnull(SampleAllowed,0)=0 then 1 else 0 end) where FranchiseId=@Fid", con);

                    if (e.CommandName.Equals("RegeneratePwd"))
                        cmd = new SqlCommand("update FranchiseMst set Password=@Password where FranchiseId=@Fid", con);

                    cmd.CommandType = CommandType.Text;
                    cmd.CommandTimeout = 99999;
                    cmd.Parameters.AddWithValue("@FId", GridView1.DataKeys[row.RowIndex].Values[0].ToString());
                    if (e.CommandName.Equals("RegeneratePwd"))
                    {
                        utility objUtil = new utility();
                        string EncPwd = objUtil.base64Encode(RandomString(8));
                        cmd.Parameters.AddWithValue("@Password", EncPwd);
                        DecPwd = objUtil.base64Decode(EncPwd);
                    }
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    if (e.CommandName.Equals("VendorAuth") || e.CommandName.Equals("IsReturn") || e.CommandName.Equals("Status") || e.CommandName.Equals("SampleAllowed"))
                    {
                        BindGrid(null);
                    }
                    if (e.CommandName.Equals("RegeneratePwd"))
                    {
                        fname = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
                        fmobile = GridView1.DataKeys[row.RowIndex].Values[3].ToString();
                        fid = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
                        string msgtxt = "";
                        if (fname.Length > 20)
                            fname = fname.Substring(0, 20).ToString();

                        msgtxt = "Dear " + fname + " ID No " + fid + " Your  Password : " + DecPwd;

                        utility objUtil = new utility();
                        objUtil.sendSMSByBilling(fmobile, msgtxt, "FORGETPASSWORD");
                        utility.MessageBox(this, "Password regenerated successfully.!!");
                    }
                }
                catch (Exception er)
                {
                    utility.MessageBox(this, er.Message);
                }
                finally
                {
                }
            }
        }
    }

    public static void OpenNewBrowserWindow(string Url, Control control)
    {
        ScriptManager.RegisterStartupScript(control, control.GetType(), "Open", "window.open('" + Url + "');", true);
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_FranchiseList.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            GridView1.AllowPaging = false;
            BindGrid(null);
            GridView1.Columns[0].Visible = GridView1.Columns[1].Visible = GridView1.Columns[20].Visible = false;
            GridView1.Columns[21].Visible = GridView1.Columns[22].Visible = GridView1.Columns[23].Visible = GridView1.Columns[24].Visible = false;

            //GridView1.Columns[31].Visible = GridView1.Columns[32].Visible = GridView1.Columns[33].Visible = true;
            //GridView1.Columns[34].Visible = GridView1.Columns[35].Visible = GridView1.Columns[36].Visible = false;
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
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            BindGrid(null);
            GridView1.Columns[0].Visible = GridView1.Columns[1].Visible = GridView1.Columns[20].Visible = false;
            GridView1.Columns[21].Visible = GridView1.Columns[22].Visible = GridView1.Columns[23].Visible = GridView1.Columns[24].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_FranchiseList.doc");
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


    private void Bind_FranchiseTypeEdit()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4 and UserVal not in (1, 7, 8, 9, 10)");
        if (dt.Rows.Count > 0)
        {
            ddl_Type.DataSource = dt;
            ddl_Type.DataTextField = "Item_Desc";
            ddl_Type.DataValueField = "Frantype";
            ddl_Type.DataBind();
            ddl_Type.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Type", "-1"));
        }
        else
        {
            ddl_Type.Items.Clear();
            ddl_Type.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Type", "-1"));
        }
    }


    public void BindState()
    {
        DataUtility objDUT = new DataUtility();
        DataTable dt = new DataTable();
        SqlParameter[] sqlparam = new SqlParameter[] {
            };
        dt = objDUT.GetDataTable(sqlparam, "Select id, statename from stategstmst s, ControlMst c where c.RegionId=s.Rid and c.username='" + Session["admin"].ToString() + "'");

        if (dt.Rows.Count > 0)
        {
            ddl_State.Items.Clear();
            ddl_State.DataSource = dt;
            ddl_State.DataTextField = "StateName";
            ddl_State.DataValueField = "Id";
            ddl_State.DataBind();
            ddl_State.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select State", ""));
            ddl_District.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select District", ""));
        }

    }
    protected void ddl_State_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BindDistrict(ddl_State.SelectedValue);
        }
        catch
        {

        }
    }
    public void BindDistrict(string value)
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("GetStateDistrict", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@state", value);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddl_District.DataSource = dt;
                ddl_District.Items.Clear();
                ddl_District.DataTextField = "DistrictName";
                ddl_District.DataValueField = "Id";
                ddl_District.DataBind();
                ddl_District.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select District", ""));
            }
            else
            {
                ddl_District.Items.Clear();
                ddl_District.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select District", ""));
            }
        }
        catch
        {
        }
    }

    [System.Web.Services.WebMethod]
    public static SponsorDetails[] GetStock(string franchiseid)
    {
        List<SponsorDetails> details = new List<SponsorDetails>();
        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@regno", franchiseid),
            new SqlParameter("@ProductName", "")
        };
        DataUtility obj_du = new DataUtility();
        DataTable dt = obj_du.GetDataTableSP(param, "ClosingStock");
        foreach (DataRow dr in dt.Rows)
        {
            SponsorDetails data = new SponsorDetails();
            data.ProductCode = dr["ProductCode"].ToString();
            data.ProductName = dr["ProductName"].ToString();
            data.BatchNo = dr["BatchNo"].ToString();
            data.Mfg = dr["Mfg"].ToString();
            data.Expiry = dr["Expiry"].ToString();
            data.qty = dr["qty"].ToString();
            data.Total_DP = dr["Total_DP"].ToString();
            data.Total_DPWithTax = dr["Total_DPWithTax"].ToString();
            data.Tax = dr["Tax"].ToString();
            data.TPV = dr["TPV"].ToString();
            data.RPV = dr["RPV"].ToString();
            details.Add(data);
        }
        return details.ToArray();
    }

    public class SponsorDetails
    {
        public String ProductCode { get; set; }
        public String ProductName { get; set; }
        public String BatchNo { get; set; }
        public String Mfg { get; set; }
        public String Expiry { get; set; }
        public String qty { get; set; } 
        public String Total_DP { get; set; }
        public String Total_DPWithTax { get; set; }
        public String Tax { get; set; }
        public String TPV { get; set; }
        public String RPV { get; set; }

    }


}