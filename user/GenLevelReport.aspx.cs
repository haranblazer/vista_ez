using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web;
using System.Collections.Generic;
public partial class User_GenLevelReport : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }


    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string level)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString()),
                   new SqlParameter("@level", level),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GenLevelreport");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.appmstregno = dr["appmstregno"].ToString();
                data.fname = dr["fname"].ToString();
                data.SponsorId = dr["SponsorId"].ToString();
                //data.SponsorName = dr["SponsorName"].ToString();
                data.status = dr["status"].ToString();
                data.CurrentRPV = dr["CurrentRPV"].ToString();
                data.CurrentGBV = dr["CurrentGBV"].ToString();
                data.GenerationRank = dr["GenerationRank"].ToString();
                data.Level = dr["Level"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string appmstregno { get; set; }
        public string fname { get; set; }
        public string SponsorId { get; set; }
        public string SponsorName { get; set; }
        public string status { get; set; }
        public string CurrentRPV { get; set; }
        public string CurrentGBV { get; set; }
        public string GenerationRank { get; set; }
        public string Level { get; set; }
    }

    #endregion

}