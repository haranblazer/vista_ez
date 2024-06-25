using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_UserServices : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    #region HeaderData
    [System.Web.Services.WebMethod]
    public static SalesDetails[] GetSalesData()
    {
        List<SalesDetails> details = new List<SalesDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
           {
             new SqlParameter("@franchiseid", HttpContext.Current.Session["franchiseid"].ToString())
           };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_highcharts_Franchise");
            while (dr.Read())
            {
                SalesDetails data = new SalesDetails();
                data.MonthName = dr["MonthName"].ToString();
                data.Purchase = dr["Purchase"].ToString();
                data.Sales = dr["Sales"].ToString(); 
                data.TotalSales = dr["TotalSales"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [WebMethod]
    public static string generateOTP()
    {
        if (HttpContext.Current.Session["FranchiseId"] == null)
        {
            return "Session expire.";
        }

        string result = "0";
        DataTable dt = new DataTable();
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        da = new SqlDataAdapter("GenerateOTP", con);
        da.SelectCommand.Parameters.AddWithValue("@RegNo", HttpContext.Current.Session["FranchiseId"].ToString());
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            utility objUtil = new utility();
            //String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 30 min ";
            String msg = "OTP " + dt.Rows[0]["OTP"].ToString().Trim() + " for Transaction and valid for 15 min from:toptimenet.com Jai Toptime";
            objUtil.sendSMSByBilling(dt.Rows[0]["AppMstMobile"].ToString().Trim(), msg, "OTP");
            if (dt.Rows[0]["IS_OPTIN"].ToString() == "1")
            {
                String Whatsappmsg = "OTP is *" + dt.Rows[0]["OTP"].ToString().Trim() + "* for transaction and is valid for 15 minutes. From www.toptimenet.com. *Jai Toptime*";
                WhatsApp.Send_WhatsApp_MSG(dt.Rows[0]["AppMstMobile"].ToString().Trim(), Whatsappmsg);
            }
        }
        return result;
    }


    [WebMethod]
    public static string verifyOTP(string telno, string txtotp)
    {
        string chktelno = telno;
        string Result = "";

        if (HttpContext.Current.Session["FranchiseId"] == null)
        {
            return "Session Expire";
        }
        if (chktelno != "" && Regex.IsMatch(chktelno, "@^[6-9][0-9]{9}$"))
        {
            return "Enter 10 digit mobile number";
        }
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("VerifyOTP", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@RegNo", HttpContext.Current.Session["FranchiseId"].ToString());
        com.Parameters.AddWithValue("@OTP", txtotp.Trim());
        com.Parameters.Add("@IsValid", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();

        Result = com.Parameters["@IsValid"].Value.ToString();
        if (Result == "0")
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FranchiseID", HttpContext.Current.Session["FranchiseId"].ToString())
            };
            DataUtility objDu = new DataUtility();
            objDu.ExecuteSql(param, "update FranchiseMst set OTP_Verify=1 where FranchiseID=@FranchiseID");
        }
        return Result;
    }



    [WebMethod]
    public static string GSTDeclaration()
    {
        string result = "0";
        if (HttpContext.Current.Session["FranchiseId"] == null)
        {
            return "Sessionexpire.";
        }
         
        try
        {
            SqlParameter[] param = new SqlParameter[]
            { new SqlParameter("@FranchiseID", HttpContext.Current.Session["FranchiseId"].ToString()) };

            DataUtility objDu = new DataUtility();
            objDu.ExecuteSql(param, "update FranchiseMst set GST_DeclDate=Getdate() where FranchiseID=@FranchiseID");
            result = "1";
        }
        catch (Exception er) { }
        return result;
    }

    [WebMethod]
    public static string AgreementAccept()
    {
        string result = "0";
        if (HttpContext.Current.Session["FranchiseId"] == null)
        {
            return "Sessionexpire.";
        }

        try
        {
            SqlParameter[] param = new SqlParameter[]
            { new SqlParameter("@FranchiseID", HttpContext.Current.Session["FranchiseId"].ToString()) };

            DataUtility objDu = new DataUtility();
            objDu.ExecuteSql(param, "update FranchiseMst set Agrmt_Accept=1, Agrmt_Doe=Getdate() where FranchiseID=@FranchiseID");
            result = "1";
        }
        catch (Exception er) { }
        return result;
    }


    public class SalesDetails
    {
        public String MonthName { get; set; }
        public String Purchase { get; set; }
        public String Sales { get; set; }
        public String TotalSales { get; set; }
    }


    
    #endregion

}