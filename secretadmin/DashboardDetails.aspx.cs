using System;
using System.Collections.Generic;
//using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
//using System.Linq;
//using System.Web;
using System.Web.UI;
//using System.Web.UI.WebControls;

public partial class secretadmin_DashboardDetails : System.Web.UI.Page
{
    static string MasterKey = "", From = "", To = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
            {
                utility.CheckSuperAdminLogin();
            }
            
            if(Session["admin"]==null)
            {
                Response.Redirect("logout.aspx");
            }
            if (!IsPostBack)
            {
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["Key"] != null)
                    {
                        MasterKey = Request.QueryString["Key"].ToString();
                        try
                        {
                            if (Request.QueryString["From"].ToString().Length > 0)
                            {
                                String[] Date = Request.QueryString["From"].ToString().Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                                txtFromDate.Text = Date[0] + "/" + Date[1] + "/" + Date[2];
                            }
                            if (Request.QueryString["To"].ToString().Length > 0)
                            {
                                String[] Date = Request.QueryString["To"].ToString().Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                                txtToDate.Text = Date[0] + "/" + Date[1] + "/" + Date[2];
                            }
                        }
                        catch
                        {
                            utility.MessageBox(this, "Invalid date entry.!!");
                            return;
                        }
                         
                        if (MasterKey == "TPVRPV")
                            lbl_ReportName.Text = "TPV + RPV";
                        else
                            lbl_ReportName.Text = MasterKey;
                    }
                }
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
            new SqlParameter("@MasterKey", MasterKey),
            new SqlParameter("@Adminid", HttpContext.Current.Session["admin"].ToString()),
            new SqlParameter("@State", ""),
            new SqlParameter("@From", min),
            new SqlParameter("@To", max)
            };
            DataUtility obj_du = new DataUtility();
            SqlDataReader dr = obj_du.GetDataReaderSP(param, "GetDashboardDetails");
             
            //SqlParameter[] param = new SqlParameter[]
            //{
            //    new SqlParameter("@min", min),
            //    new SqlParameter("@max", max),
            //    new SqlParameter("@Userid", ""),
            //    new SqlParameter("@status", status),
            //    new SqlParameter("@IsCompanyReq", "1"),
            //};
            //SqlDataReader dr = objDu.GetDataReaderSP(param, "POFranList");
            //utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                //data.srno_Encode = objutil.base64Encode(dr["srno"].ToString());

                data.Invoice_No = dr["Invoice No"].ToString();
                data.Date = dr["Date"].ToString();
                data.Seller_UserId = dr["Seller UserId"].ToString();
                data.Seller_Name = dr["Seller Name"].ToString();
                data.Seller_State = dr["Seller State"].ToString();
                data.Seller_District = dr["Seller District"].ToString();
                data.Buyer_UserId = dr["Buyer UserId"].ToString();
                data.Buyer_Name = dr["Buyer Name"].ToString();
                data.Buyer_Mobile_No = dr["Buyer Mobile No"].ToString();
                data.Total_Amount = dr["Total Amount"].ToString();

                data.DP_Amount = dr["DP Amount"].ToString();
                data.Normal_PV = dr["Normal PV"].ToString();
                data.Topper_PV = dr["Topper PV"].ToString();
                data.Sponsor_ID = dr["Sponsor ID"].ToString();
                data.Sponsor_Name = dr["Sponsor Name"].ToString();
                data.Reference_Id = dr["Reference Id"].ToString();
                data.Reference_Name = dr["Reference Name"].ToString();
                data.Tax_Sales_Invoive = dr["Tax / Sales Invoive"].ToString();
                data.Billing_Type = dr["Billing Type"].ToString();
                data.Invoice_Status = dr["Invoice Status"].ToString();
                
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    { 
        public string Invoice_No { get; set; }
        public string Date { get; set; }
        public string Seller_UserId { get; set; }
        public string Seller_Name { get; set; }
        public string Seller_State { get; set; }
        public string Seller_District { get; set; }
        public string Buyer_UserId { get; set; }
        public string Buyer_Name { get; set; }
        public string Buyer_Mobile_No { get; set; }
        public string Total_Amount { get; set; }

        public string DP_Amount { get; set; }
        public string Normal_PV { get; set; }
        public string Topper_PV { get; set; }
        public string Sponsor_ID { get; set; }
        public string Sponsor_Name { get; set; } 
        public string Reference_Id { get; set; }
        public string Reference_Name { get; set; }
        public string Tax_Sales_Invoive { get; set; }
        public string Billing_Type { get; set; }
        public string Invoice_Status { get; set; }
         
    }

 

    #endregion



    //private void BindGrid()
    //{
    //    SqlParameter[] param = new SqlParameter[]
    //   {
    //        new SqlParameter("@MasterKey", MasterKey),
    //        new SqlParameter("@Adminid", Session["admin"].ToString()),
    //        new SqlParameter("@State", ""),
    //        new SqlParameter("@From", From),
    //        new SqlParameter("@To", To)
    //   };
    //    DataUtility obj_du = new DataUtility();
    //    DataTable dt = obj_du.GetDataTableSP(param, "GetDashboardDetails");
    //    //Session["dt"] = dt;
    //    if (dt.Rows.Count > 0)
    //    {          
    //        if (MasterKey == "RPV" || MasterKey == "TPV" || MasterKey == "TPVRPV" || MasterKey == "LOYALTYINV" || MasterKey == "ONLINE_INVSALES" || MasterKey == "OFFLINE_INVSALES" || MasterKey == "FRAN_SALES" || MasterKey == "TOTAL_SALES")
    //        {
    //            Grid_RPV.Columns[1].FooterText ="Total: "+ dt.Rows.Count.ToString();
    //            Grid_RPV.Columns[9].FooterText = dt.Compute("sum([Total Amount])", "true").ToString();
    //            Grid_RPV.Columns[10].FooterText = dt.Compute("sum([DP Amount])", "true").ToString();
    //            Grid_RPV.Columns[11].FooterText = dt.Compute("sum([Normal PV])", "true").ToString();
    //            Grid_RPV.Columns[12].FooterText = dt.Compute("sum([Topper PV])", "true").ToString();

    //            Grid_RPV.DataSource = dt;
    //            Grid_RPV.DataBind();
    //        } 
    //    }
    //    else
    //    {
    //       Grid_RPV.DataSource = null;
    //       Grid_RPV.DataBind();
    //    }
    //}

    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}

    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{

    //    if (Grid_RPV.Rows.Count > 0)
    //    {
    //        Grid_RPV.AllowPaging = false;
    //        BindGrid();
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + MasterKey+ ".xls");
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        Grid_RPV.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");

    //}

    
}