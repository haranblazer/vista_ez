using System;
using System.Collections.Generic;
using System.Data.SqlClient;


public partial class secretadmin_SMS_DocumnetType : System.Web.UI.Page
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
         
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        { 
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReader("Select DocId, DocName, Isactive=isnull(Isactive,0) from SMS_DocumentType order by DocName");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.DocId = dr["DocId"].ToString();
                data.DocName = dr["DocName"].ToString();
                data.Isactive = dr["Isactive"].ToString();
                
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string DocId { get; set; }
        public string DocName { get; set; }
        public string Isactive { get; set; } 
    }


    [System.Web.Services.WebMethod]
    public static UserDetails[] GetDetail(string DocId)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@DocId", DocId) };
            SqlDataReader dr = objDu.GetDataReader(param, "Select DocName from SMS_DocumentType where DocId=@DocId");
            while (dr.Read())
            {
                UserDetails data = new UserDetails(); 
                data.DocName = dr["DocName"].ToString(); 
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static string Save(string DocId, string Document)
    {
        string Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@DocId", DocId), new SqlParameter("@Document", Document) };
            if(DocId=="")
                Result = objDu.ExecuteSql(param, "Insert SMS_DocumentType(DocName, Isactive) Values(@Document, 1)").ToString();
            else
                Result = objDu.ExecuteSql(param, "Update SMS_DocumentType Set DocName=@Document where DocId=@DocId").ToString();
        }
        catch (Exception er) { }
        return Result; 
    }


    [System.Web.Services.WebMethod]
    public static string Delete(string DocId)
    {
        string Result ="0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@DocId", DocId) };
             Result = objDu.ExecuteSql(param, "Delete SMS_DocumentType where DocId=@DocId").ToString();
        }
        catch (Exception er) { }
        return Result;
    }


    #endregion
}