using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;

public partial class secretadmin_TrnReqReport : System.Web.UI.Page
{
    //SqlConnection con;
    //SqlCommand com;
    //SqlDataAdapter da;
    //DataTable dt;

    //private string SortDirection
    //{
    //    get { return ViewState["SortDirection"] != null ? ViewState["SortDirection"].ToString() : "ASC"; }
    //    set { ViewState["SortDirection"] = value; }
    //}
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
                txtFromDate.Text = DateTime.Now.Date.AddMonths(-1).ToString("dd/MM/yyyy");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
                // BindDataDatewise(null);

            }
        }
        catch
        {

        }

    }




    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FromDate", min),
                new SqlParameter("@ToDate", max),
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetTrnReqByDate");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.AppMstRegNo = dr["AppMstRegNo"].ToString();
                data.AppMstFName = dr["AppMstFName"].ToString();
                data.TypeOfRequest = dr["TypeOfRequest"].ToString();
                data.State = dr["State"].ToString();
                data.City = dr["City"].ToString();
                data.Requestdate = dr["Requestdate"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string AppMstRegNo { get; set; }
        public string AppMstFName { get; set; }
        public string TypeOfRequest { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string Requestdate { get; set; }

    }


    #endregion




    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;

    //    BindDataDatewise(null);

    //}

    //protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        GridView1.AllowPaging = false;
    //        if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()))
    //        {
    //            //BindSearchReward();
    //        }
    //        else
    //        {
    //            BindDataDatewise(null);
    //        }
    //        if (GridView1.Rows.Count > 0)
    //        {
    //            Response.ClearContent();
    //            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_TrnReq.doc");
    //            Response.ContentType = "application/vnd.ms-word";
    //            StringWriter stw = new StringWriter();
    //            HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //            GridView1.RenderControl(htextw);
    //            Response.Write(stw.ToString());
    //            Response.End();
    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "Can't Export,No Data Found!");
    //        }
    //    }
    //    catch
    //    {

    //    }
    //}
    //protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        GridView1.AllowPaging = false;
    //        if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()))
    //        {
    //            //BindSearchReward();
    //        }
    //        else
    //        {
    //            BindDataDatewise(null);
    //        }
    //        if (GridView1.Rows.Count > 0)
    //        {
    //            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_TrnReq.xls");
    //            Response.ContentType = "application/vnd.xls";
    //            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //            GridView1.RenderControl(htmlWrite);
    //            Response.Write(stringWrite.ToString());
    //            Response.End();
    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "Can't Export,No Data Found!");
    //        }


    //    }
    //    catch
    //    {

    //    }

    //}
    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}

    //protected void OnSorting(object sender, GridViewSortEventArgs e)
    //{

    //    string SortDir = string.Empty;
    //    this.BindDataDatewise(e.SortExpression);
    //    if (ViewState["SortDirection"].ToString() == "ASC" )
    //    {
    //        SortDir = "Sorting in ascending order.";
    //    }
    //    else
    //    {
    //        SortDir = "Sorting in descending order.";
    //        //GridView1.HeaderRow.Cells[1].Text = "User Id <img src='../images/sort_dec.png' />";

    //       // GridView1.SortExpression = "AppMstRegNo";
    //        //GridView1.CssClass = "headerSortDown";

    //    }
    //}
    //public void BindDataDatewise(string sortExpression)
    //{
    //    try
    //    {
    //        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //        dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //        DateTime fromDate = new DateTime();
    //        DateTime toDate = new DateTime();
    //        try
    //        {
    //            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
    //            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid Date!");
    //            return;
    //        }
    //        double datedays = (toDate - fromDate).TotalDays;
    //        if (datedays > 31)
    //        {
    //            utility.MessageBox(this, "Maximum 31 days allowed");
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //            lblMessage.Text=string.Empty;
    //            return;
    //        }
    //        if (fromDate <= toDate)
    //        {
    //            con = new SqlConnection(method.str);
    //            com = new SqlCommand("GetTrnReqByDate", con);
    //            com.CommandType = CommandType.StoredProcedure;
    //            com.Parameters.AddWithValue("@FromDate", fromDate);
    //            com.Parameters.AddWithValue("@ToDate", toDate);
    //            da = new SqlDataAdapter(com);
    //            dt = new DataTable();
    //            da.Fill(dt);
    //            if (sortExpression != null)
    //            {
    //                DataView dv = dt.AsDataView();

    //                this.SortDirection = this.SortDirection == "ASC" ? "DESC" : "ASC";

    //                dv.Sort = sortExpression + " " + this.SortDirection;
    //                GridView1.DataSource = dv;
    //                GridView1.DataBind();

    //            }
    //            else
    //            {
    //                GridView1.DataSource = dt;
    //                GridView1.DataBind();
    //            }

    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "Sorry,from date should not greater than to date.");
    //            txtFromDate.Focus();
    //        }

    //    }
    //    catch
    //    {

    //    }

    //}


    //protected void btnSearchByDate_Click(object sender, EventArgs e)
    //{
    //    BindDataDatewise(null);
    //}

    //protected void GridView1_RowCreated(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.Header)
    //    {
    //        foreach (TableCell tc in e.Row.Cells)
    //        {
    //            if (tc.HasControls())
    //            {
    //                LinkButton lb = (LinkButton)tc.Controls[0];
    //                if (lb != null)
    //                {
    //                    Image icon = new Image();
    //                    icon.ImageUrl = "../images/" + (this.SortDirection == "ASC" ? "sort_incr" : "sort_dec") + ".png";
    //                    if (lb.CommandArgument!="")
    //                    {
    //                        tc.Controls.Add(new LiteralControl(" "));
    //                        tc.Controls.Add(icon);
    //                    }
    //                }
    //            }
    //        }
    //    }
    //}


}