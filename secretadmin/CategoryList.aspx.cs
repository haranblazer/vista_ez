using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class secretadmin_CategoryList : System.Web.UI.Page
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
        catch
        {
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string isDeleted)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Category", ""),
                new SqlParameter("@isDeleted", isDeleted)
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "getCategoryList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.CatId = dr["CatId"].ToString();
                data.CatName = dr["CatName"].ToString();
                data.imagename = dr["imagename"].ToString();
                data.IconImg = dr["IconImg"].ToString();
                data.PriorityDispaly = dr["PriorityDispaly"].ToString();
                data.isDeleted = dr["isDeleted"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string CatId { get; set; }
        public string CatName { get; set; }
        public string imagename { get; set; }
        public string IconImg { get; set; }
        public string PriorityDispaly { get; set; }
        public string isDeleted { get; set; }

    }


    [System.Web.Services.WebMethod]
    public static string UpdateStatus(string CatId)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@CatId", CatId) };

            objDu.ExecuteSql(param, "update CategoryMst set isDeleted=(Case isnull(isDeleted,0) when 0 then 1 else 0 End) where CatId=@CatId");

            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }
     
    #endregion

}