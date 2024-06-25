using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;

/// <summary>
/// Summary description for WhatsApp
/// </summary>
public class WhatsApp
{
    static string Response = "", API_URL = "", Api_Password = "", Whatsapp_UserId = "", EntityId = "", CountryCode="91";
    public WhatsApp()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #region sendWhatsApp
    public static string Send_WhatsApp_OPT_IN(string Mobileno)
    {
        string Result = "1";
        try
        {
            GetSettingData();
            string baseurl = API_URL + "method=OPT_IN&format=json&userid=" + Whatsapp_UserId + "&password=" + Api_Password + "&phone_number=" +CountryCode + Mobileno + "&v=1.1&auth_scheme=plain&channel=WHATSAPP";

            Response = SendMsg(baseurl);
            DebitWhatsAppSMS(Mobileno, "OPT_IN", Response);
        }
        catch (Exception ex)
        {
            Result = ex.Message;
        }
        return Result;
    }
     

    public static string Send_WhatsApp_MSG(string Mobileno, string msg)
    {
        string Result = "1";
        try
        {
            GetSettingData();
            string baseurl = API_URL + "method=SendMessage&format=json&userid=" + Whatsapp_UserId + "&password=" + Api_Password
                + "&send_to=" + CountryCode + Mobileno + "&&v=1.1&auth_scheme=plain&msg_type=HSM&msg="+ msg;

            Response = SendMsg(baseurl);
            DebitWhatsAppSMS(Mobileno, "OPT_OUT", Response);
        }
        catch (Exception ex)
        {
            Result = ex.Message;
        }
        return Result;
    }


    public static string Send_WhatsApp_With_Header(string Mobileno, string msg, string Header)
    {
        string Result = "1";
        try
        {
            GetSettingData(); 
            string baseurl = API_URL + "method=SendMessage&userid=" + Whatsapp_UserId + "&password=" + Api_Password 
                + "&send_to=" + CountryCode + Mobileno + "&msg_type=HSM&isHSM=true&isTemplate=true&v=1.1&header=" + Header 
                + "&footer=Jai%20Toptime&msg=" + msg;
             
            Response = SendMsg(baseurl);
            DebitWhatsAppSMS(Mobileno, "OPT_OUT", Response);
        }
        catch (Exception ex)
        {
            Result = ex.Message;
        }
        return Result;
    }

    public static string Send_WhatsApp_With_Header_Text(string Mobileno, string msg, string Header)
    {
        
        string Result = "1";
        try
        {
            GetSettingData();
            msg = msg.Replace("&", "%26");
            msg = msg.Replace(" ", "+");

            string baseurl = API_URL + "method=SendMessage&userid=" + Whatsapp_UserId + "&password=" + Api_Password
                + "&send_to=" + CountryCode + Mobileno + "&msg_type=TEXT&format=json&isTemplate=true&v=1.1&header=" + Header
                + "&footer=Jai%20Toptime&msg=" + msg;

            Response = SendMsg(baseurl);
            DebitWhatsAppSMS(Mobileno, "OPT_OUT", Response);
        }
        catch (Exception ex)
        {
            Result = ex.Message;
        }
        return Result;
    }


    /// <summary>
    /// Send Whats app message
    /// </summary>
    /// <param name="baseurl"></param>
    /// <returns></returns>
    private static string SendMsg(string baseurl)
    {
        WebClient client = new WebClient();
        Stream data = client.OpenRead(baseurl);
        StreamReader reader = new StreamReader(data);
        string Response = reader.ReadToEnd();
        data.Close();
        reader.Close();
        return Response;
    }


    private static void GetSettingData()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(@"Select API_URL=UserVal,
                       Api_Password=(Select UserVal from SettingMst where Caption='Whatsapp_Api_Password'),
                       Whatsapp_UserId=(Select UserVal from SettingMst where Caption='Whatsapp_UserId'),
                       EntityId=(Select UserVal from SettingMst where Caption='EntityId') 
                       from SettingMst where Caption='Whatsapp_API_URL'");
        if (dt.Rows.Count > 0)
        {
            API_URL = dt.Rows[0]["API_URL"].ToString().Trim();
            Api_Password = dt.Rows[0]["Api_Password"].ToString().Trim();
            Whatsapp_UserId = dt.Rows[0]["Whatsapp_UserId"].ToString().Trim();
            EntityId = dt.Rows[0]["EntityId"].ToString().Trim();
        }
    }
   
    private static void DebitWhatsAppSMS(string Mobileno, string Methord, string Response)
    {
        SqlParameter[] param1 = new SqlParameter[]
        {
            new SqlParameter("@Mobileno", Mobileno),
            new SqlParameter("@Methord", Methord),
            new SqlParameter("@Response", Response)
        };
        DataUtility objDu = new DataUtility();
        objDu.ExecuteSql(param1, "insert WhatsApp_Log(MobileNo, Methord, Response) values(@Mobileno, @Methord, @Response)");
    }
    #endregion
}