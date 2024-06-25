using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient; 
using System.Web; 

public partial class secretadmin_old_AddSize : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [System.Web.Services.WebMethod]
    public static void UpdateStatus(string Size_Id)
    {
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SZId", Size_Id)
            };
            objDu.ExecuteSql(param, "update  tbl_size set IsActive=(case when IsActive=1 then 0 else 1 end) where SZId=@SZId");
        }
        catch (Exception er)
        {

        }
    }

    [System.Web.Services.WebMethod]
    public static Detail openPopup(string Size_Id)
    {
        Detail data = new Detail();
        try
        {
            HttpContext.Current.Session["SZId"] = Size_Id;

            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SZId", Size_Id)
            };
            SqlDataReader dr = objDu.GetDataReader(param, @"Select Size from tbl_size where SZId=@SZId");
            while (dr.Read())
            {


                data.Size = dr["Size"].ToString();
               // data.Colour_Code = dr["ColorCode"].ToString();
                //  data.Min_Voucher_Amt = dr["ConditionAmount"].ToString();

                //details.Add(data);
            }
        }
        catch (Exception er) { }
        return data;
    }
    [System.Web.Services.WebMethod]
    public static string Save(string Size_ID, string Size)
    {
        string result = "";
        try
        {
            SqlParameter outparam = new SqlParameter("@intResult", SqlDbType.VarChar, 100);
            outparam.Direction = ParameterDirection.Output;

            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SZId", Size_ID),
                new SqlParameter("@Size", Size),
                outparam
            };
            objDu.ExecuteSqlSP(param, "AddSize").ToString();
        }
        catch (Exception er)
        {

        }
        return result;
    }
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

            SqlDataReader dr = objDu.GetDataReader(param, "Select * from tbl_size");
            utility objUtil = new utility();
            while (dr.Read())
            {
                Detail data = new Detail();
               
                            

                data.Size_Id = dr["SZId"].ToString();
                data.Size = dr["Size"].ToString();
                data.Status = dr["IsActive"].ToString();





                details.Add(data);
            };



        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class Detail

    {


        
        public string Size_Id { get; set; }
        public string Size { get; set; }
        public string Status { get; set; }


    }
}