
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient; 
using System.Web; 

public partial class User_LegWiseGeneration : System.Web.UI.Page
{
    public static string Userid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        if (!IsPostBack)
        {
            Userid = Session["userId"].ToString();
            Bind_Month();
        }
    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string Userid, string Months)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {

            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@Userid", Userid=="" ?HttpContext.Current.Session["userId"].ToString() : Userid),
                   new SqlParameter("@Months", Months),
                   new SqlParameter("@Typ", "USER")
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetLegWiseGeneration");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Userid = dr["Userid"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.RPV_Count1 = dr["RPV_Count1"].ToString();
                data.PBVAmt = dr["PBVAmt"].ToString();
                
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Userid { get; set; }
        public string UserName { get; set; }
        public string RPV_Count1 { get; set; }
        public string PBVAmt { get; set; }
       
    }



    private void Bind_Month()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(@"Select [Month] From(Select SN=999999, [Month]=Cast(DateName(Month, getdate()) as nvarchar(3)) + '-' + RIGHT(DateName(Year, getdate()),2) Union All Select SN=PayoutNo, [Month]=Cast(DateName(Month, PayToDate) as nvarchar(3)) + '-' + RIGHT(DateName(Year, PayToDate),2)  from RePayoutdate )t order by SN desc");
        if (dt.Rows.Count > 0)
        { 
            ddl_Month.DataSource = dt;
            ddl_Month.DataTextField = "Month";
            ddl_Month.DataValueField = "Month";
            ddl_Month.DataBind();
            //ddl_Month.Items.Insert(0, new ListItem("All", ""));
        }
        else
        {
            ddl_Month.Items.Clear();
           // ddl_Month.Items.Insert(0, new ListItem("All", ""));
        }
    }


    #endregion
 
}