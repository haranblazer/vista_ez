using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient; 

public partial class Loyality_Retail_Booster : System.Web.UI.Page 
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
            go();
            if (Request.QueryString["pno"] != null)
            {
                ddlDateRange.SelectedValue = Request.QueryString["pno"].ToString();
            }

        }
    }




    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string FromDate, string ToDate, string Regno, string Payoutno)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Regno", Regno),
                 new SqlParameter("@FromDate", FromDate),
                new SqlParameter("@ToDate", ToDate),
                new SqlParameter("@Payoutno", Payoutno),
                new SqlParameter("@MstKey", "Main"),
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetRetail_Booster_Monthly_Loyalty");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.BackGroundImg = dr["BackGroundImg"].ToString();
                data.Dates = dr["Dates"].ToString();
                data.appmstregno = dr["appmstregno"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.Mobile = dr["Mobile"].ToString();
                data.District = dr["District"].ToString();
                data.State = dr["State"].ToString();
                data.LoyalityInc = dr["LoyalityInc"].ToString();
                data.NoOfQualfy = dr["NoOfQualfy"].ToString();
                data.payoutno = dr["payoutno"].ToString();
                data.imagename = dr["imagename"].ToString();
                details.Add(data); 
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string BackGroundImg { get; set; }
        public string Dates { get; set; }
        public string appmstregno { get; set; }
        public string UserName { get; set; }
        public string Mobile { get; set; }
        public string District { get; set; }
        public string State { get; set; }
        public string LoyalityInc { get; set; }
        public string NoOfQualfy { get; set; }
        public string payoutno { get; set; }
         public string imagename { get; set; }
    }


    public void go()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select payoutno, Dates=Cast(DateName(Month, paytodate) as nvarchar(3)) + '-' + RIGHT(DateName(Year, paytodate),2) from Loyalty_Retail_Booster_date order by payoutno desc");
        if (dt.Rows.Count > 0)
        {
            ddlDateRange.Items.Clear();
            ddlDateRange.DataSource = dt;
            ddlDateRange.DataTextField = "Dates";
            ddlDateRange.DataValueField = "payoutno";
            ddlDateRange.DataBind();
            ddlDateRange.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select", "0"));
        }
        else
        {
            ddlDateRange.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select", "0"));
        }
    }




    [System.Web.Services.WebMethod]
    public static SponsorDetails[] GetLoyalityData(string Payoutno, string Regno)
    {
        List<SponsorDetails> details = new List<SponsorDetails>();

        SqlParameter[] param = new SqlParameter[]
       {
             new SqlParameter("@Regno", Regno),
             new SqlParameter("@Payoutno", Payoutno),
             new SqlParameter("@MstKey", "Details"),
       };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetRetail_Booster_Monthly_Loyalty");

        foreach (DataRow dr in dt.Rows)
        {
            SponsorDetails data = new SponsorDetails();
            data.Doe = dr["Doe"].ToString();
            data.SoldTo = dr["SoldTo"].ToString();
            //data.Mobile = dr["Mobile"].ToString();
            //data.District = dr["District"].ToString();
            //data.State = dr["State"].ToString();
            data.InvoiceNo = dr["InvoiceNo"].ToString();
            data.Amount = dr["Amount"].ToString();
            data.Status = dr["Status"].ToString();
            details.Add(data);
        }
        return details.ToArray();
    }

    public class SponsorDetails
    {
        public String Doe { get; set; }
        public String SoldTo { get; set; }
        //public String Mobile { get; set; }
        //public String District { get; set; }
        //public String State { get; set; }
        public String InvoiceNo { get; set; }
        public String Amount { get; set; }
        public String Status { get; set; }
    }



    #endregion


}