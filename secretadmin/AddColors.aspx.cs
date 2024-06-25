using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient; 
using System.Web;

public partial class secretadmin_AddColors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [System.Web.Services.WebMethod]
    public static Detail openPopup(string Colour_ID)
    {
        Detail data = new Detail();
        try
        {
            HttpContext.Current.Session["CLRId"] = Colour_ID;

            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@CLRId", Colour_ID)
            };
            SqlDataReader dr = objDu.GetDataReader(param, @"Select ColorCode, ColorName from tbl_Color where CLRId=@CLRId");
            while (dr.Read())
            {
               

                data.Colour_Name = dr["ColorName"].ToString();
                data.Colour_Code = dr["ColorCode"].ToString();
                //  data.Min_Voucher_Amt = dr["ConditionAmount"].ToString();

                //details.Add(data);
            }
        }
        catch (Exception er) { }
        return data;
    }
    [System.Web.Services.WebMethod]
    public static void UpdateStatus(string Colour_ID)
    {
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@CLRId", Colour_ID)
            };
            objDu.ExecuteSql(param, "update  tbl_Color set IsActive=(case when IsActive=1 then 0 else 1 end) where CLRId=@CLRId");
        }
        catch (Exception er)
        {

        }
    }
    [System.Web.Services.WebMethod]
    public static string Save(string Colour_ID,string Colour_Code,string Colour_Name)
    {
        string result = "";
        try
        {
            SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
            outparam.Direction = ParameterDirection.Output;

            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@CLRId", Colour_ID),
                new SqlParameter("@ColorCode", Colour_Code),
                new SqlParameter("@ColorName", Colour_Name),
                outparam
            };
             objDu.ExecuteSqlSP(param, "AddColor").ToString();
        }
        catch (Exception er)
        {

        }
        return result;
    }

    //[System.Web.Services.WebMethod]
    //public static void AddPopup(string Colour_Code,string Colour_Name)
    //{
        
    //    try
    //    {
    //        DataUtility objDu = new DataUtility();
    //        SqlParameter[] param = new SqlParameter[]
    //        {
    //            new SqlParameter("@ColorCode", Colour_Code),
    //            new SqlParameter("@ColorName", Colour_Name)

    //        };
           
    //        objDu.ExecuteSql(param, "insert into  tbl_Color values('ColorCode=@ColorCode','ColorName=@ColorName')");
    //    }
    //    catch (Exception er)
    //    {

    //    }
    //}
    [System.Web.Services.WebMethod]

    public static Detail[] bindtable()
    {
        List<Detail> details = new List<Detail>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {



            //new SqlParameter("@min", From),
            //new SqlParameter("@max", To),
            //new SqlParameter("@search", Id),
            


           // new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString())
                };

            SqlDataReader dr = objDu.GetDataReader(param, "Select * from tbl_Color");
            utility objUtil = new utility();
            while (dr.Read())
            {
                Detail data = new Detail();


                data.Colour_ID = dr["CLRId"].ToString();
                data.Colour_Code = dr["ColorCode"].ToString();
                data.Colour_Name = dr["ColorName"].ToString();
                data.Status = dr["IsActive"].ToString();





                details.Add(data);
            };



        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class Detail

    {

        public string Colour_ID { get; set; }
        public string Colour_Code { get; set; }
        public string Colour_Name { get; set; }
        public string Status { get; set; }


    }
}