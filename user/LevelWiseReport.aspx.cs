using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web;

public partial class User_LevelWiseReport : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
         
    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@regno",  HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@level",  "1")
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Levelreport_Summary");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Level = dr["Level"].ToString();
                data.Count = dr["Count"].ToString();
                data.CurrentRPV = dr["CurrentRPV"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Level { get; set; }
        public string Count { get; set; }
        public string CurrentRPV { get; set; }
    }

    #endregion

     
}