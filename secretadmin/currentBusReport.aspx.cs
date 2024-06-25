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
            SqlDataReader dr = objDu.GetDataReaderSP("CurrentBus_report");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.First_Purchase_BV = dr["First_Purchase_BV"].ToString();
                data.Self_Repurchase_BV = dr["Self_Repurchase_BV"].ToString();
                data.GBVAMT = dr["GBVAMT"].ToString();
                data.TotalMatched = dr["TotalMatched"].ToString();
                data.CarryLeft = dr["CarryLeft"].ToString();
                 
                data.CarryRight = dr["CarryRight"].ToString();
                data.CurrRank = dr["CurrRank"].ToString();
                data.NextRank = dr["NextRank"].ToString();
                data.RequiredMatched = dr["RequiredMatched"].ToString();
                data.HighestLegId = dr["HighestLegId"].ToString();
                data.HighestLegGBV = dr["HighestLegGBV"].ToString();
                data.SecondLegId = dr["SecondLegId"].ToString();


                data.SecondLegGBV = dr["SecondLegGBV"].ToString();
                data.RestLegId = dr["RestLegId"].ToString();
                data.RestLegGBV = dr["RestLegGBV"].ToString();
                

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
        public string GBVAMT { get; set; }
        public string TotalMatched { get; set; }


        public string CarryLeft { get; set; }
        public string CarryRight { get; set; }
        public string CurrRank { get; set; }
        public string NextRank { get; set; }
        public string RequiredMatched { get; set; }
        public string HighestLegId { get; set; }

        public string HighestLegGBV { get; set; }
        public string SecondLegId { get; set; }
        public string SecondLegGBV { get; set; }
        public string RestLegId { get; set; }
        public string RestLegGBV { get; set; } 


    }


    #endregion

}