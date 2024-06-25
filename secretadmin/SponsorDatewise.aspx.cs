using System; 
using System.Data.SqlClient;
using System.Collections.Generic;

public partial class admin_SponsorDatewise : System.Web.UI.Page
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
            txtFromDate.Text = DateTime.Now.Date.AddDays(-6).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            //go();
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string sponsortotal, string ReqTypeSponsor, string NoOfPair, string ReqTypePair)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@sponsortotal", sponsortotal),
                new SqlParameter("@ReqTypeSponsor", ReqTypeSponsor),
                new SqlParameter("@NoOfPair", NoOfPair),
                new SqlParameter("@ReqTypePair", ReqTypePair),
            };
            DataUtility objDu = new DataUtility(); 
            SqlDataReader dr = objDu.GetDataReaderSP(param, "sdate1");
            while (dr.Read())
            {
                UserDetails data = new UserDetails(); 
                data.AppMstregno = dr["AppMstregno"].ToString();
                data.Name = dr["Name"].ToString();
                data.appmstmobile = dr["appmstmobile"].ToString();
                data.sponsorid = dr["sponsorid"].ToString();
                data.sponsorname = dr["sponsorname"].ToString();
                data.AppMstSponsorTotal = dr["AppMstSponsorTotal"].ToString();
                data.TotalPair = dr["TotalPair"].ToString();
                data.AppPaidDateTime = dr["AppPaidDateTime"].ToString();
                data.AppMstCity = dr["AppMstCity"].ToString();
                data.AppMstState = dr["AppMstState"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string AppMstregno { get; set; }
        public string Name { get; set; }
        public string appmstmobile { get; set; }
        public string sponsorid { get; set; }
        public string sponsorname { get; set; }
        public string AppMstSponsorTotal { get; set; }
        public string TotalPair { get; set; }
        public string AppPaidDateTime { get; set; }
        public string AppMstCity { get; set; }
        public string AppMstState { get; set; }

    }


    #endregion



    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    go();
    //}
    //public void go()
    //{

    //    string fromDate = "", toDate = "";
    //    try
    //    {
    //        if (txtFromDate.Text.Trim().Length > 0)
    //        {
    //            String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //            fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //        }
    //        if (txtToDate.Text.Trim().Length > 0)
    //        {
    //            String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //            toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //        }
    //    }
    //    catch
    //    {
    //        utility.MessageBox(this, "Invalid date entry.");
    //        return;
    //    }


    //    SqlConnection con = new SqlConnection(method.str);
    //    SqlDataAdapter da = new SqlDataAdapter("sdate1", con);
    //    da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    da.SelectCommand.Parameters.AddWithValue("@Min", fromDate);
    //    da.SelectCommand.Parameters.AddWithValue("@Max", toDate);
    //    da.SelectCommand.Parameters.AddWithValue("@sponsortotal", txtNoOfSponsor.Text.Trim());
    //    da.SelectCommand.Parameters.AddWithValue("@ReqTypeSponsor", rdoReqTypeSponsor_list.SelectedValue);
    //    da.SelectCommand.Parameters.AddWithValue("@NoOfPair", txt_NoOfPair.Text.Trim());
    //    da.SelectCommand.Parameters.AddWithValue("@ReqTypePair", rdoReqTypePair.SelectedValue);
    //    DataTable dt = new DataTable();
    //    da.Fill(dt);
    //    if (dt.Rows.Count > 0)
    //    {
    //        ViewState["count"] = Convert.ToString(dt.Rows.Count);
    //        dgr.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
    //        lblTotalSponsor.Text = Convert.ToString(Math.Round(Convert.ToDouble(dt.Compute("sum(AppMstSponsorTotal)", "1=1").ToString()), 2));
    //        dgr.DataSource = dt;
    //        dgr.DataBind();
    //        lblcount.Text = "No of records :" + dt.Rows.Count;
    //    }
    //    else
    //    {
    //        lblcount.Text = string.Empty;
    //        dgr.DataSource = null;
    //        dgr.DataBind();
    //    }
    //    //}
    //    //else
    //    //{
    //    //    utility.MessageBox(this,"From Date is not greater than To Date");
    //    //}      

    //}
    //public void select(string str, DateTime fromDate, DateTime toDate)
    //{


    //}
    //protected void dgr_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    dgr.PageIndex = e.NewPageIndex;
    //    go();
    //}

    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}
    //protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    go();
    //}
    //protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dgr.Rows.Count > 0)
    //    {
    //        dgr.AllowPaging = false;
    //        go();
    //        Response.Clear();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_SponsorReportList.xls");
    //        Response.Charset = "";
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        dgr.RenderControl(htmlWrite);
    //        Response.Write(stringWrite.ToString());
    //        Response.End();
    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}
    //protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dgr.Rows.Count > 0)
    //    {
    //        dgr.AllowPaging = false;
    //        go();
    //        Response.Clear();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_SponsorReportList.doc");
    //        Response.Charset = "";
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        dgr.RenderControl(htmlWrite);
    //        Response.Write(stringWrite.ToString());
    //        Response.End();
    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}

    //protected void dgr_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        int total = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "AppMstSponsorTotal"));
    //        joinTotal = joinTotal + total;

    //        int Pair = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalPair"));
    //        PairTotal = PairTotal + Pair;




    //    }
    //    if (e.Row.RowType == DataControlRowType.Footer)
    //    {

    //        Label lbl = (Label)e.Row.FindControl("lblTotal");
    //        lbl.Text = "Total : " + joinTotal.ToString();

    //        Label lblTotalPair = (Label)e.Row.FindControl("lblTotalPair");
    //        lblTotalPair.Text = "Total : " + PairTotal.ToString();

    //    }

    //}
}
