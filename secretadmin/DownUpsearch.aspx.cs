using System; 
using System.Data.SqlClient; 
using System.Collections.Generic;

public partial class user_downstatus : System.Web.UI.Page
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
        }
        catch { } 
    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string UserId, string DOWNUP, string Paid)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] sqlparam = new SqlParameter[] {
            new SqlParameter("@Regno",UserId),
            new SqlParameter("@Type",DOWNUP),
            new SqlParameter("@Paid",Paid)
            };

            SqlDataReader dr = objDu.GetDataReaderSP(sqlparam, "SponsorTran_UpDownLine");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.MobileNo = dr["MobileNo"].ToString();
                data.SponsorName = dr["SponsorName"].ToString();
                data.SponsorId = dr["SponsorId"].ToString();
                data.PBV = dr["PBV"].ToString();
                data.GBV = dr["GBV"].ToString();
                data.Total_PBV = dr["Total_PBV"].ToString();
                data.Total_Gbv = dr["Total_Gbv"].ToString();
                data.TPV = dr["TPV"].ToString();
                data.Status = dr["Status"].ToString();
                data.IsPaid = dr["IsPaid"].ToString();
                data.RePurchase_rankName = dr["RePurchase_rankName"].ToString();


                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string MobileNo { get; set; }
        public string SponsorName { get; set; }
        public string SponsorId { get; set; }
        public string PBV { get; set; }
        public string GBV { get; set; }
        public string Total_PBV { get; set; }
        public string Total_Gbv { get; set; }
        public string TPV { get; set; }
        public string Status { get; set; }
        public string IsPaid { get; set; }
        public string RePurchase_rankName { get; set; }

    }


    #endregion


    //private string SortDirection
    //{
    //    get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
    //    set { ViewState["SortDirection"] = value; }
    //}


    //protected void OnSorting(object sender, GridViewSortEventArgs e)
    //{

    //    string SortDir = string.Empty;
    //    this.downUp(e.SortExpression);
    //    if (ViewState["SortDirection"].ToString() == "ASC")
    //    {
    //        SortDir = "Sorting in ascending order.";
    //    }
    //    else
    //    {
    //        SortDir = "Sorting in descending order.";
    //        //GridView1.HeaderRow.Cells[1].Text = "User Id <img src='../images/sort_dec.png' />";

    //        // GridView1.SortExpression = "AppMstRegNo";
    //        //GridView1.CssClass = "headerSortDown";

    //    }
    //}


    //public void getcv()
    //{
    //    SqlConnection con = new SqlConnection(method.str);
    //    SqlCommand com;
    //    SqlDataReader sdr;
    //    con.Open();
    //    com = new SqlCommand("BV", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    sdr = com.ExecuteReader();
    //    if (sdr.Read())
    //    {
    //        cv = sdr["PBV"].ToString();
    //        gcv = sdr["GBV"].ToString();
    //    }
    //    con.Close();
    //}

    //private void downUp(string sortExpression)
    //{
    //    try
    //    {
    //        DataUtility objDUT = new DataUtility();
    //        DataTable dt = new DataTable();
    //        SqlParameter[] sqlparam = new SqlParameter[] {
    //        new SqlParameter("@Regno",txtUserId.Text.Trim()),
    //        new SqlParameter("@Type",ddlDOWNUP.SelectedValue.ToString()),
    //        new SqlParameter("@Paid",ddl_Paid.SelectedValue.ToString())
    //        };
    //        dt = objDUT.GetDataTableSP(sqlparam, "SponsorTran_UpDownLine");
    //        if (dt.Rows.Count > 0)
    //        {


    //            if (sortExpression != null)
    //            {
    //                DataView dv = dt.AsDataView();
    //                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";
    //                dv.Sort = sortExpression + " " + this.SortDirection;
    //                lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
    //                GridView1.DataSource = dv;
    //                GridView1.DataBind();

    //            }
    //            else
    //            {
    //                //lblTotal.Text = "Total Record: " + dt.Rows.Count.ToString();
    //                GridView1.DataSource = dt;
    //                GridView1.DataBind();
    //            }

    //        }
    //        else
    //        {
    //            lblTotal.Text = "";
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //}
    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    downUp(null);
    //}


    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    //BindDataWithViewState();
    //}

    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}


    //protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        Response.Clear();
    //        Response.Buffer = true;
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_DownUpList.xls");
    //        Response.Charset = "";
    //        Response.ContentType = "application/vnd.ms-excel";
    //        using (StringWriter sw = new StringWriter())
    //        {
    //            HtmlTextWriter hw = new HtmlTextWriter(sw);

    //            GridView1.AllowPaging = false;
    //            downUp(null);

    //            GridView1.HeaderRow.BackColor = System.Drawing.Color.White;
    //            foreach (TableCell cell in GridView1.HeaderRow.Cells)
    //            {
    //                cell.BackColor = GridView1.HeaderStyle.BackColor;
    //            }
    //            foreach (GridViewRow row in GridView1.Rows)
    //            {
    //                row.BackColor = System.Drawing.Color.White;
    //                foreach (TableCell cell in row.Cells)
    //                {
    //                    if (row.RowIndex % 2 == 0)
    //                    {
    //                        cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
    //                    }
    //                    else
    //                    {
    //                        cell.BackColor = GridView1.RowStyle.BackColor;
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

    //            GridView1.RenderControl(hw);
    //            //style to format numbers to string
    //            string style = @"<style> .textmode { } </style>";
    //            Response.Write(style);
    //            Response.Output.Write(sw.ToString());
    //            Response.Flush();
    //            Response.End();
    //        }
    //    }
    //    catch (Exception er) { }

    //}


    //protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    //{


    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        GridView1.Columns[10].Visible = false;
    //        //BindDataWithViewState();
    //        Response.Clear();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "AllotedPinList.doc");
    //        Response.Charset = "";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        GridView1.RenderControl(htmlWrite);
    //        Response.Write(stringWrite.ToString());
    //        Response.End();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Can't export as no data found.");
    //    }




    //}

}
