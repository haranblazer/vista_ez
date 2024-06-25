using System;
using System.Collections.Generic; 
using System.Data.SqlClient; 

public partial class secretadmin_SubCategoryList : System.Web.UI.Page
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
    
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string isDeleted)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SubCatName", ""),
                new SqlParameter("@isDeleted", isDeleted), 

            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "getSubCategoryList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.CatId = dr["CatId"].ToString();
                data.SubCatId = dr["SubCatId"].ToString();
                data.SubCatName = dr["SubCatName"].ToString();
                data.CatName = dr["CatName"].ToString();
                data.PriorityDispaly = dr["PriorityDisplay"].ToString();
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
        public string SubCatId { get; set; }
        public string CatName { get; set; }
        public string SubCatName { get; set; }
       
        public string PriorityDispaly { get; set; }
        public string isDeleted { get; set; }

    }


    [System.Web.Services.WebMethod]
    public static string UpdateStatus(string SubCatId)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@SubCatId", SubCatId) };

            objDu.ExecuteSql(param, @"update SubCategoryMst set isDeleted=(Case isnull(isDeleted,0) when 0 then 1 else 0 End) 
            where SubCatId=@SubCatId");

            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }

}