using System;
using System.Collections.Generic;
using System.Data.SqlClient;
  
public partial class secretadmin_currentBusReport : System.Web.UI.Page
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
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlDataReader dr = objDu.GetDataReaderSP("CurrentBus_report_New");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.First_Purchase_BV = dr["First_Purchase_BV"].ToString();
                data.Self_Repurchase_BV = dr["Self_Repurchase_BV"].ToString();
                data.TotalMatched = dr["TotalMatched"].ToString();
                data.CarryLeft = dr["CarryLeft"].ToString();
                 
                data.CarryRight = dr["CarryRight"].ToString();
                data.CurrRank = dr["CurrRank"].ToString();
                data.NextRank = dr["NextRank"].ToString();

                data.FreshBV_A = dr["CurrGroupA"].ToString();
                data.FreshBV_B = dr["CurrGroupB"].ToString();
                data.FreshMatcheBV = dr["CurrMatchedBV"].ToString();
                data.TotalGroupBV_A = dr["TotalGroupA"].ToString();
                data.TotalGroupBV_B = dr["TotalGroupB"].ToString();
                data.TotalBV = dr["TotalBV"].ToString();

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
        public string First_Purchase_BV { get; set; }
        public string Self_Repurchase_BV { get; set; }
        public string TotalMatched { get; set; }
        public string CarryLeft { get; set; }
        public string CarryRight { get; set; }
        public string CurrRank { get; set; }
        public string NextRank { get; set; }
        public string FreshBV_A { get; set; }
        public string FreshBV_B { get; set; }
        public string FreshMatcheBV { get; set; }
        public string TotalGroupBV_A { get; set; }
        public string TotalGroupBV_B { get; set; }
        public string TotalBV { get; set; }




    }


    #endregion

}