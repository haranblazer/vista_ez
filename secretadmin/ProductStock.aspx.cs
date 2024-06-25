using System.Web.UI; 
using System.Data.SqlClient; 
using System.Data;
using System;
using System.Xml; 
using System.Collections.Generic; 
public partial class admin_ProductStock : System.Web.UI.Page
{
    //SqlConnection con;
    //SqlDataAdapter da;
    //DataTable dt;
    //SqlCommand cmd;
    //int qnt;
    //string commonbook;
    //XmlDocument xmldoc;
    //utility objUtil;
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

            if (!Page.IsPostBack)
            {
                BindFranchise();
                //  bindgrid();
            }
        }
        catch { }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string UserId)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] sqlparam = new SqlParameter[] {
            new SqlParameter("@regno",UserId),
            new SqlParameter("@type", "1")
            };

            SqlDataReader dr = objDu.GetDataReaderSP(sqlparam, "StockInhand");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Pid = dr["Pid"].ToString();
                data.ProductName = dr["ProductName"].ToString();
                data.Opening = dr["Opening"].ToString();
                data.ItemIn = dr["ItemIn"].ToString();
                data.GRN = dr["GRN"].ToString();
                data.Sold = dr["Sold"].ToString();
                data.Packed = dr["Packed"].ToString();
                data.PackedUsing = dr["PackedUsing"].ToString();
                data.UnPacked = dr["UnPacked"].ToString();
                data.UnPackedItems = dr["UnPackedItems"].ToString();
                data.ItemOut = dr["ItemOut"].ToString();
                data.Issued = dr["Issued"].ToString();
                data.FromItemAdj = dr["FromItemAdj"].ToString();
                data.ToItemAdj = dr["ToItemAdj"].ToString();
                data.SalesReturn = dr["SalesReturn"].ToString();
                data.RTV = dr["RTV"].ToString();
                data.BalQty = dr["BalQty"].ToString(); 
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Pid { get; set; }
        public string ProductName { get; set; }
        public string Opening { get; set; }
        public string ItemIn { get; set; }
        public string GRN { get; set; }
        public string Sold { get; set; }
        public string Packed { get; set; }
        public string PackedUsing { get; set; }
        public string UnPacked { get; set; }
        public string UnPackedItems { get; set; }
        public string ItemOut { get; set; }
        public string Issued { get; set; }
        public string FromItemAdj { get; set; }
        public string ToItemAdj { get; set; }
        public string SalesReturn { get; set; }
        public string RTV { get; set; }
        public string BalQty { get; set; }

    }

    [System.Web.Services.WebMethod]
    public static Results Details(string Pid, string Typ, string UserId)
    { 
        utility obj = new utility();
        Results objResults = new Results();

        objResults.Pid = obj.base64Encode(Pid);
        objResults.Typ = obj.base64Encode(Typ);
        objResults.UserId = obj.base64Encode(UserId);
        return objResults;
    }

    public class Results
    {
        public String Pid { get; set; }
        public String Typ { get; set; }
        public String UserId { get; set; }
    }

    public void BindFranchise()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select FranchiseId='-111', UserName='Admin' Union all Select FranchiseId, UserName=Fname+ '('+Cast(FranchiseId as varchar(50))+')'  from FranchiseMst order by UserName ");
        ddl_RoleWise.DataSource = dt;
        ddl_RoleWise.DataTextField = "UserName";
        ddl_RoleWise.DataValueField = "FranchiseId";
        ddl_RoleWise.DataBind();
        ddl_RoleWise.SelectedValue = "-111";
    }

    #endregion


    //protected void Grdreport_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    objUtil = new utility();

    //    GridViewRow row = Grdreport.Rows[Convert.ToInt32(e.CommandArgument)];
    //    string pid = Grdreport.DataKeys[row.RowIndex].Values[0].ToString();

    //    if (e.CommandName == "TI")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("11"));

    //    if (e.CommandName == "GRN")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("15"));

    //    if (e.CommandName == "Sales")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("12"));

    //    if (e.CommandName == "Packed")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("17"));

    //    if (e.CommandName == "PackedUsing")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("18"));

    //    if (e.CommandName == "UnPacked")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("19"));

    //    if (e.CommandName == "UnPackedItems")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("20"));

    //    if (e.CommandName == "ItemOut")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("14"));

    //    if (e.CommandName == "Issued")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("16"));

    //    if (e.CommandName == "FromItemAdj")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("21"));

    //    if (e.CommandName == "ToItemAdj")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("22"));

    //    if (e.CommandName == "SalesReturn")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("13"));

    //    if (e.CommandName == "RTV")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("23"));

    //    if (e.CommandName == "Balance")
    //        Response.Redirect("TotalIn.aspx?pid=" + objUtil.base64Encode(pid) + "&typ=" + objUtil.base64Encode("0"));


    //    /*if (e.CommandName == "In")
    //    {
    //        Response.Redirect("TotalIn.aspx?bid=" + objUtil.base64Encode(bid) + "&pid=" + objUtil.base64Encode(pid));
    //    }
    //    if (e.CommandName == "out")
    //    {
    //        Response.Redirect("TotalOut.aspx?bid=" + objUtil.base64Encode(bid) + "&pid=" + objUtil.base64Encode(pid));
    //    }
    //    if (e.CommandName == "Cancel")
    //    {
    //        Response.Redirect("TotalCancel.aspx?bid=" + objUtil.base64Encode(bid) + "&pid=" + objUtil.base64Encode(pid));
    //    }*/
    //}
    //public void bindgrid()
    //{
    //    con = new SqlConnection(method.str);
    //    da = new SqlDataAdapter("StockInhand", con);
    //    da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    da.SelectCommand.Parameters.AddWithValue("@regno", ddl_RoleWise.SelectedValue.ToString());
    //    da.SelectCommand.Parameters.AddWithValue("@type", "1");
    //    dt = new DataTable();
    //    da.Fill(dt);
    //    if (dt.Rows.Count > 0)
    //    {

    //        //Grdreport.Columns[9].FooterText = dt.AsEnumerable().Select(x => x.Field<double>("amount")).Sum().ToString();
    //        Grdreport.DataSource = dt;
    //        Grdreport.DataBind();
    //    }

    //    else
    //    {
    //        Grdreport.DataSource = null;
    //        Grdreport.DataBind();
    //    }
    //}
    //protected void BtnClear_Click(object sender, EventArgs e)
    //{

    //}
    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    bindgrid();
    //}

    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}
    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (Grdreport.Rows.Count > 0)
    //    {
    //        Grdreport.AllowPaging = false;
    //        bindgrid();
    //        //Grdreport.Columns[16].Visible = Grdreport.Columns[17].Visible = false;
    //        Response.Clear();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stockinhand.xls");
    //        Response.Charset = "";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        Grdreport.RenderControl(htmlWrite);
    //        Response.Write(stringWrite.ToString());
    //        Response.End();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Can't export as no data found.");
    //    }
    //}
    //protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (Grdreport.Rows.Count > 0)
    //    {
    //        Grdreport.AllowPaging = false;
    //        bindgrid();
    //        // Grdreport.Columns[16].Visible = Grdreport.Columns[17].Visible = false;
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stockinhand.doc");
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        this.Grdreport.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}
}