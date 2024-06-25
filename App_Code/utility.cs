using System;
using System.Data;
//using System.Configuration;
using System.Web;
//using System.Web.Security;
using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
//using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Net;
using System.IO;
using System.Text.RegularExpressions;
//using System.Net;
using System.Net.Mail;
using System.Collections.Generic;

/// <summary>
/// Summary description for utility
/// </summary>
public class utility
{
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    SqlCommand com = null;
    string apikey = "", clientId = "", smsurl = "", smssenderid = "";
    public utility()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public DataSet getCompnayDetails()
    {

        DataSet dsCD = new DataSet();
        da = new SqlDataAdapter("select * from settingmst", con);
        da.Fill(dsCD);
        return dsCD;
    }
    public DataTable GetProductList()
    {

        DataTable Dt = new DataTable();
        da = new SqlDataAdapter("select ProductName+' ('+convert(varchar(50),amount)+')' as Name, srno from productmst where isDeleted=0", con);
        da.Fill(Dt);
        return Dt;
    }

    public DataTable companyname()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter adapter = new SqlDataAdapter();
        adapter.SelectCommand = new SqlCommand("companydetails");
        adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
        adapter.SelectCommand.Connection = con;
        DataTable dt = new DataTable();
        adapter.Fill(dt);
        return dt;
    }

    public DataTable Getreward()
    {
        DataTable t = new DataTable();
        try
        {
            string qstr = "select rewardrank, Name from rewardmst order by rewardrank ";
            com = new SqlCommand(qstr, con);
            da = new SqlDataAdapter(com);
            da.Fill(t);
        }
        catch (Exception ex)
        {
        }
        return t;

    }

    private DataSet GetDataSetForMenu()
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = new SqlCommand("SELECT CatID,CatName  FROM CategoryMst where status=1 order by catid desc");
            adapter.SelectCommand.Connection = con;
            DataSet ds = new DataSet();
            adapter.Fill(ds, "Categories");
            adapter.SelectCommand.CommandText = "SELECT SubCatId,SubCatName,CatID FROM SubCategoryMst where status=1";
            adapter.Fill(ds, "subcat");
            adapter.SelectCommand.CommandText = "SELECT Sub2CatId,SubCatId,SubCatName FROM Sub2CategoryMst where status=1";
            adapter.Fill(ds, "sub2cat");
            ds.Relations.Add("Children", ds.Tables["Categories"].Columns["CatID"], ds.Tables["subcat"].Columns["CatID"], false);
            ds.Relations.Add("SubChildren", ds.Tables["subcat"].Columns["SubCatId"], ds.Tables["sub2cat"].Columns["SubCatId"], false);
            return ds;
        }
        catch
        {
            return null;
        }
    }

    public string leftmenu()
    {
        string MenuItem = "";
        utility obj = new utility();
        DataSet ds = GetDataSetForMenu();
        if (ds != null && ds.Tables["Categories"] != null)
        {
            foreach (DataRow parentItem in ds.Tables["Categories"].Rows)
            {
                MenuItem += "<li><a href='/delhi/" + parentItem["CatName"].ToString().Replace(' ', '_') + "' class='pram'>" + parentItem["CatName"].ToString().Trim() + "</a></li> ";
                //"<div> <ul>";

                //foreach (DataRow childItem in parentItem.GetChildRows("Children"))
                //{
                //    MenuItem += "<li ><a href='/delhi/" + childItem["SubcatName"].ToString().Replace(' ', '_') + "' class='parent'><span>" + childItem["SubcatName"].ToString().Trim() + "</span></a></li>";
                //}
                //MenuItem += "</ul></div>";
                //MenuItem += "</li>";
            }
            MenuItem += "";

        }
        return MenuItem;
    }




    public string mymenu()
    {
        string MenuItem = "";
        utility obj = new utility();
        DataSet ds = GetDataSetForMenu();
        if (ds != null && ds.Tables["Categories"] != null)
        {
            foreach (DataRow parentItem in ds.Tables["Categories"].Rows)
            {
                MenuItem += "<li ><a href=''/delhi/" + parentItem["CatName"].ToString().Replace(' ', '_') + "' class='parent'><span >" + parentItem["CatName"].ToString().Trim() + "</span></a>" +
                            "<div> <ul>";

                foreach (DataRow childItem in parentItem.GetChildRows("Children"))
                {
                    MenuItem += "<li ><a href='/delhi/" + childItem["SubcatName"].ToString().Replace(' ', '_') + "' class='parent'><span>" + childItem["SubcatName"].ToString().Trim() + "</span></a></li>";
                }
                MenuItem += "</ul></div>";
                MenuItem += "</li>";
            }
            MenuItem += "";

        }
        return MenuItem;
    }
    public static string NumberToWords(int number)
    {
        if (number == 0)
            return "zero";

        if (number < 0)
            return "minus " + NumberToWords(Math.Abs(number));

        string words = "";
        if ((number / 10000000) > 0)
        {
            words += NumberToWords(number / 10000000) + " crore ";
            number %= 10000000;
        }

        if ((number / 100000) > 0)
        {
            words += NumberToWords(number / 100000) + " lac ";
            number %= 100000;
        }

        if ((number / 1000) > 0)
        {
            words += NumberToWords(number / 1000) + " thousand ";
            number %= 1000;
        }

        if ((number / 100) > 0)
        {
            words += NumberToWords(number / 100) + " hundred ";
            number %= 100;
        }

        if (number > 0)
        {
            if (words != "")
                words += "and ";

            var unitsMap = new[] { "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen" };
            var tensMap = new[] { "zero", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" };

            if (number < 20)
                words += unitsMap[number];
            else
            {
                words += tensMap[number / 10];
                if ((number % 10) > 0)
                    words += "-" + unitsMap[number % 10];
            }
        }

        return words;
    }
   

    public void sendSMS(string mobile, String Text)
    {
        WebClient client = new WebClient();
        string companyname = "", url = "";
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("selectSMSInformation", con);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    companyname = rdr["companyname"].ToString().Trim();
                    url = rdr["url"].ToString().Trim();
                }
            }
        }
        catch
        {
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        try
        {
            Text = Text + ". From: " + companyname;
            string baseurl = url + "&to=" + mobile.Trim() + "&text=" + Text.Trim() + "&route=Trans&type=text";
            Stream data = client.OpenRead(baseurl);
            StreamReader reader = new StreamReader(data);
            string s = reader.ReadToEnd();
            data.Close();
            reader.Close();
        }
        catch
        {
        }
        finally
        {

        }
    }


    #region sendSMSByBilling
    public int sendSMSByBilling(string mobile, string Text, string Caption)
    {
        int ret = 0; 
        string companyname = "", website = "", TEMPLATE_ID="", EntityId="", SMSPWD="", VId = "";
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("GETSMS24Info", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Caption", Caption);
        try
        {
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    apikey = rdr["apikey"].ToString().Trim();
                    clientId = rdr["clientId"].ToString().Trim();
                    smsurl = rdr["smsurl"].ToString().Trim();
                    smssenderid = rdr["smssenderid"].ToString().Trim();
                    website = rdr["website"].ToString().Trim();
                    companyname = rdr["companyname"].ToString().Trim();
                    TEMPLATE_ID = rdr["TEMPLATE_ID"].ToString().Trim();
                    EntityId = rdr["EntityId"].ToString().Trim();
                    SMSPWD = rdr["SMSPWD"].ToString().Trim();
                    VId = rdr["VId"].ToString().Trim();
                }
            }
        }
        catch (Exception ex)
        {
            ret = 0;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        try
        {
 

            //string baseurl = smsurl + "mobile=" + mobile + "&country_code=91&sms=" + Text + "&sender=" + smssenderid + "&pe_id=" + EntityId + "&template_id=" + TEMPLATE_ID + "&fb1voice=" + Text;

            string baseurl = smsurl + "mobile=" + mobile + "&country_code=91&sms=" + Text + "&sender=" + smssenderid + "&pe_id=" + EntityId + "&template_id=" + TEMPLATE_ID;



            //System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
            WebClient client = new WebClient();
            Stream data = client.OpenRead(baseurl);
            StreamReader reader = new StreamReader(data);
            string s = reader.ReadToEnd();
            data.Close();
            reader.Close();
            DebitSMS(1, Text, mobile, s);
            ret = 1;
        }
        catch (Exception ex)
        {
            ret = 0;
        }
        finally
        {
        }
        return ret;
    }
    #endregion

    public void sendSMSCjstore(string mobile, String Text)
    {
        WebClient client = new WebClient();
        string companyname = "", url = "", website = "";
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("GETSMSInfo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    website = rdr["website"].ToString().Trim();
                    companyname = rdr["sendername"].ToString().Trim();
                    url = rdr["url"].ToString().Trim();
                }
            }
        }
        catch
        {
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        try
        {
            Text = Text + " from: " + website + " Jai Toptime"; 
            string baseurl = url + "&to=" + mobile.Trim() + "&text=" + Text.Trim() + "&route=Trans&type=text";
            //string baseurl = url + Text.Trim() + "&sendername=" + companyname + "&smstype=Trans&numbers=" + mobile + "&apikey=6f41681a-d89f-43e9-bcd3-3efceb81f127";
            Stream data = client.OpenRead(baseurl);
            StreamReader reader = new StreamReader(data);
            string s = reader.ReadToEnd();
            data.Close();
            reader.Close();


            con = new SqlConnection(method.str);
            SqlCommand cmd2 = new SqlCommand("insertdataInSmsMst", con);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.AddWithValue("@srno", 0);
            cmd2.Parameters.AddWithValue("@mobile", mobile);
            cmd2.Parameters.AddWithValue("@TextMsg", Text);
            cmd2.Parameters.AddWithValue("@response", s);
            cmd2.Parameters.AddWithValue("@doe", DateTime.Now.ToString());
            con.Open();
            cmd2.ExecuteNonQuery();
            con.Close();
        }
        catch
        {
        }
        finally
        {

        }
    }

    private void DebitSMS(int noOfSMS, string text, string mobile, string response)
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("update paymentmst set SMSCredit=SMSCredit-@count where SMSCredit>=@count;" +
                "insert into SmsMst (Mobile,TextMsg,Response,Doe) values(@mobile,@text,@response,dateadd(minute,330,getutcdate()))", con);
            com.Parameters.AddWithValue("@count", noOfSMS);
            com.Parameters.AddWithValue("@mobile", mobile);
            com.Parameters.AddWithValue("@text", text);
            com.Parameters.AddWithValue("@response", response);
            com.CommandTimeout = 9999999;
            con.Open();
            com.ExecuteNonQuery();
            con.Close();

        }
        catch
        {
        }
    }


    public void sendFromGmail(string to, string subject, string msg)
    {
        WebClient client = new WebClient();
        string companyname = "", gMailAccount = "", password = "";
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("selectGmailAccountInfo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    companyname = rdr["companyname"].ToString().Trim();
                    gMailAccount = rdr["gmailAccount"].ToString().Trim();
                    password = rdr["gmailPassword"].ToString().Trim();
                }
            }
        }
        catch
        {
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        try
        {

            NetworkCredential loginInfo = new NetworkCredential(gMailAccount, password);
            MailMessage mm = new MailMessage();
            mm.From = new MailAddress(gMailAccount);
            mm.To.Add(new MailAddress(to));
            mm.Subject = subject;
            mm.Body = msg + " :" + companyname;
            mm.IsBodyHtml = true;
            SmtpClient emailClient = new SmtpClient("smtp.gmail.com");
            emailClient.EnableSsl = true;
            emailClient.UseDefaultCredentials = false;
            emailClient.Credentials = loginInfo;
            emailClient.Send(mm);

        }
        catch
        {
        }
        finally
        {

        }
    }
    public string base64Encode(string sData)
    {
        try
        {
            byte[] encData_byte = new byte[sData.Length];
            encData_byte = System.Text.Encoding.UTF8.GetBytes(sData);
            string encodedData = Convert.ToBase64String(encData_byte);
            return encodedData;
        }
        catch
        {
            return "";

        }
    }
    public DataTable searchPin(string strSearch, string min, string max)
    {
        DataTable t = new DataTable();
        try
        {
            string qstr = "select p.Pinsrno,paidappmstid=case p.paidappmstid  when 0 then 'UN USED' when 1 then 'USED' end,UPPER(p.remark) AS remark," +
            "(select Appmstregno from appmst where appmstid=p.RegNo) as usedby,(select AppMstFName from appmst where appmstid=p.RegNo) as usedbyname, " +
            "p.joinfor,pintype=case p.pintype when 0 then 'NOT UPDATED' when 1 then 'JOINING' when 2 then 'TOP UP' end,p.amount, " +
            "a.Appmstregno as allotedto, " +
            "a.AppMstFName as allotedtoname, " +
            "plantype=case p.plantype  when 1 then 'SAVING PLUS' when 2 then 'SAVE SURPLUS' when 3 then 'IMS' end, " +
            "allotmentdate=convert(char(20),p.allotmentdate,103) from pinmst p inner join AppMst a on p.allotedto=a.AppMstID " +
            "and (p.pinsrno like @search or  a.AppMstRegNo like @search or p.amount like @search ) and " +
            "(case when @min is null or len(@min)=0 then 1 when @min is not null and @min<>'' and  cast(floor(cast(p.allotmentdate as float)) as datetime)>=cast(floor(cast(convert(datetime,@min) as float)) as datetime) then 1 " +
            "else 0 end)=1 " +
            "and  " +
            "(case when @max is null or LEN(@max)=0 then 1 when @max is not null and @max <>'' and cast(floor(cast(p.allotmentdate as float)) as datetime)<=cast(floor(cast(convert(datetime,@max) as float)) as datetime) then 1 " +
            "else 0 end)=1 ";

            com = new SqlCommand(qstr, con);
            com.Parameters.AddWithValue("@search", strSearch);
            com.Parameters.AddWithValue("@min", min);
            com.Parameters.AddWithValue("@max", max);
            da = new SqlDataAdapter(com);
            da.Fill(t);
        }
        catch (Exception ex)
        {
        }
        return t;

    }
    public string base64Decode(string sData)
    {
        System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
        System.Text.Decoder utf8Decode = encoder.GetDecoder();
        try
        {
            byte[] todecode_byte = Convert.FromBase64String(sData);

            int charCount = utf8Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
            char[] decoded_char = new char[charCount];
            utf8Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
            string result = new String(decoded_char);
            return result;
        }
        catch
        {

            return "";
        }
    }

    public Boolean IsValiduserid(string str)
    {
        if (Regex.Match(str, @"\d+").Success)
            return true;
        else
            return false;
    }

    public Boolean IsNumeric(string str)
    {
        if (Regex.Match(str, "^[0-9]+(\\.[0-9]{1,20})?$").Success)
            return true;
        else
            return false;
    }
    public Boolean IsAlphaNumeric(string str)
    {
        if (Regex.Match(str, @"^[a-zA-Z0-9]*$").Success)
            return true;
        else
            return false;
    }
    public Boolean IsAlphabet(string str)
    {
        if (Regex.Match(str, @"^[a-zA-Z]*$").Success)
            return true;
        else
            return false;
    }
    public static void CheckSuperAdminLogin()
    {

        try
        {
            string admin = HttpContext.Current.Session["admin"].ToString();
            if (Regex.Match(admin, @"^[a-zA-Z0-9]*$").Success)
            {
                if (HttpContext.Current.Session["admin"] == null)
                {
                    HttpContext.Current.Response.Redirect("logout.aspx");
                }
                else
                {
                    string admid = null;
                    string admpwd = null;
                    admid = HttpContext.Current.Session["admin"].ToString();
                    SqlConnection con = new SqlConnection(method.str);
                    string sqltext = "SessionsuperAdminExists";
                    SqlCommand cmd = new SqlCommand(sqltext, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@uname", admid);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                    }
                    else
                    {
                        HttpContext.Current.Response.Redirect("logout.aspx");
                    }
                }
            }
            else
            {
                HttpContext.Current.Response.Redirect("logout.aspx");
            }
        }
        catch
        {
            HttpContext.Current.Response.Redirect("logout.aspx");
        }
    }
    public static void CheckAdminLogin()
    {

        try
        {
            string admin = HttpContext.Current.Session["admin"].ToString();
            if (Regex.Match(admin, @"^[a-zA-Z0-9]*$").Success)
            {
                if (HttpContext.Current.Session["admin"] == null)
                {
                    HttpContext.Current.Response.Redirect("logout.aspx");
                }
                else
                {

                    string admid = null;
                    string admpwd = null;
                    admid = HttpContext.Current.Session["admin"].ToString();


                    SqlConnection con = new SqlConnection(method.str);
                    string sqltext = "HavePermissions";
                    SqlCommand cmd = new SqlCommand(sqltext, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@uname", admid);
                    cmd.Parameters.AddWithValue("@pagename", HttpContext.Current.Request.Url.Segments[HttpContext.Current.Request.Url.Segments.Length - 1].Trim());
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {

                    }
                    else
                    {
                        HttpContext.Current.Response.Redirect("logout.aspx");
                    }
                }
            } 
            else
            {
                HttpContext.Current.Response.Redirect("logout.aspx");
            }
        }
        catch (Exception er)
        {
            HttpContext.Current.Response.Redirect("logout.aspx");
        }
    }
    public static void CheckSuperAdminlogin()
    {

        try
        {
            string admin = HttpContext.Current.Session["admin"].ToString();
            if (Regex.Match(admin, @"^[a-zA-Z0-9]*$").Success)
            {
                if (HttpContext.Current.Session["admin"] == null)
                {
                    HttpContext.Current.Response.Redirect("logout.aspx");
                }
                else
                {
                    string admid = null;
                    string admpwd = null;
                    admid = HttpContext.Current.Session["admin"].ToString();
                    SqlConnection con = new SqlConnection(method.str);
                    string sqltext = "SessionsuperAdminExsist";
                    SqlCommand cmd = new SqlCommand(sqltext, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@uname", admid);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                    }
                    else
                    {
                        HttpContext.Current.Response.Redirect("logout.aspx");
                    }
                }
            }
            else
            {
                HttpContext.Current.Response.Redirect("logout.aspx");
            }
        }
        catch
        {
            HttpContext.Current.Response.Redirect("logout.aspx");
        }
    }



    public static void CheckAdminLoginInside()
    {

        try
        {
            string admin = HttpContext.Current.Session["admin"].ToString();
            if (Regex.Match(admin, @"^[a-zA-Z0-9]*$").Success)
            {
                if (HttpContext.Current.Session["admin"] == null)
                {
                    HttpContext.Current.Response.Redirect("logout.aspx");
                }
                else
                {

                    string admid = null;
                    string admpwd = null;
                    admid = HttpContext.Current.Session["admin"].ToString();


                    SqlConnection con = new SqlConnection(method.str);
                    string sqltext = "SessionAdminExsist";
                    SqlCommand cmd = new SqlCommand(sqltext, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@uname", admid);

                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {

                    }
                    else
                    {
                        HttpContext.Current.Response.Redirect("logout.aspx");
                    }
                }
            }


            else
            {
                HttpContext.Current.Response.Redirect("logout.aspx");
            }
        }
        catch
        {
            HttpContext.Current.Response.Redirect("logout.aspx");
        }

    }

    public DataTable searchF(string a, string b)
    {
        string qstr = "select appmstregno,appmsttitle+space(1)+AppmstFName+space(1)+AppmstLName as AppmstFName ,AppMstLName,AppMstMobile,AppMstCity,AppmstState,panno,SponsorId,AppmstDoj=convert(char(20),Appmstdoj,103),appmstpaid=case appmstpaid when 0 then 'UnPaid' when 1 then 'Paid' end from AppMst where AuthorType=(select franchiseid from franchisemst where username=@atype) and " + a + " like " + b + "";
        com = new SqlCommand(qstr, con);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        return t;


    }
    public DataTable search(string a, string b)
    {
        string qstr = "select appmstregno,appmsttitle+space(1)+AppmstFName+space(1)+AppmstLName as AppmstFName ,AppMstLName,AppMstMobile,AppMstCity,AppmstState,panno,SponsorId,AppmstDoj=convert(char(20),Appmstdoj,103),appmstpaid=case appmstpaid when 0 then 'UnPaid' when 1 then 'Paid' end from AppMst where  " + a + " like " + b + "";
        com = new SqlCommand(qstr, con);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        return t;


    }
    public DataTable searchPin(string a, string b)
    {
        string qstr = "select Pinsrno,paidappmstid=case paidappmstid when 0 then 'UnUsed' when 1 then 'Used' end,regno,joinfor,pintype=case pintype when 1 then 'Join For' when 2 then 'Top Up' end,amount,allotedto,Paidstatus=case Paidstatus when 0 then 'UnPaid' when 1 then 'Paid' end,allotmentdate=convert(char(20),allotmentdate,103) from pinmst where " + a + " like " + b + "";
        com = new SqlCommand(qstr, con);
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        return t;
    }


    public void updateSMSCredit()
    {
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("update paymentmst set SMSCredit=SMSCredit-1", con);
        con.Open();
        com.ExecuteNonQuery();
        con.Close();
    }
    public Boolean IsValidPAN(string str)
    {
        if (Regex.Match(str, @"^[a-zA-Z]{3}(p|P|c|C|h|H|f|F|a|A|t|T|b|B|l|L|j|J|g|G)[a-zA-Z][0-9]{4}[a-zA-Z]$").Success)
            return true;
        else
            return false;
    }

    public Boolean IsValidatePAN(string str)
    {
        if (Regex.Match(str, "[A-Z]{5}[0-9]{4}[A-Z]{1}").Success)
            return true;
        else
            return false;
    }
   
    public static void CheckAdminlogin()
    {

        try
        {
            string admin = HttpContext.Current.Session["admin"].ToString();
            if (Regex.Match(admin, @"^[a-zA-Z0-9]*$").Success)
            {
                if (HttpContext.Current.Session["admin"] == null)
                {
                    HttpContext.Current.Response.Redirect("adminLog.aspx");
                }
                else
                {
                    string admid = null;
                    string admpwd = null;
                    admid = HttpContext.Current.Session["admin"].ToString();
                    SqlConnection con = new SqlConnection(method.str);
                    string sqltext = "HavePermissions";
                    SqlCommand cmd = new SqlCommand(sqltext, con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@uname", admid);
                    cmd.Parameters.AddWithValue("@pagename", HttpContext.Current.Request.Url.Segments[HttpContext.Current.Request.Url.Segments.Length - 1].Trim());
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {

                    }
                    else
                    {
                        HttpContext.Current.Response.Redirect("adminLog.aspx", false);
                    }
                }
            }
            else
            {
                HttpContext.Current.Response.Redirect("adminLog.aspx", false);
            }
        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Redirect("adminLog.aspx", false);
        }
    }
    public static void MessageBox(Control ctl, string ss)
    {
        ss = ss.Replace("'", "\\'");
        if (string.IsNullOrEmpty(ss))
        {
            ss = string.Empty;
        }
        // Return char and concat substring.
        ss = char.ToUpper(ss[0]) + ss.Substring(1).ToLower();
        ScriptManager.RegisterStartupScript(ctl, ctl.GetType(), "myalert", "javascript:alert('" + ss + "');", true);
    }

    public static string CheckAdminloginInside()
    {
        string admintype = "";

        try
        {
            
                if (HttpContext.Current.Session["admin"] == null)
                {
                    HttpContext.Current.Response.Redirect("adminLog.aspx");
                }
                else
                {
                SqlParameter[] param = new SqlParameter[]
                { new SqlParameter("@uname", HttpContext.Current.Session["admin"].ToString()) };
                DataUtility objDu = new DataUtility();
                  admintype = objDu.GetScaler(param, "Select admintype from controlmst where username=@uname").ToString() ;


                //SqlConnection con = new SqlConnection(method.str);
                //    string sqltext = "Select admintype from controlmst where username=@uname";
                //    SqlCommand cmd = new SqlCommand(sqltext, con);
                //    cmd.CommandType = CommandType.Text;
                //    cmd.Parameters.AddWithValue("@uname", HttpContext.Current.Session["admin"].ToString());
                //    con.Open();
                //    admintype = cmd.ExecuteScalar().ToString();
                //    con.Close();
                }
            
        }
        catch
        {
            HttpContext.Current.Response.Redirect("adminLog.aspx");
        }
        return admintype;
    }

    public static void sendsms(string mobile, String Text)
    {

        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("HTTP_DB_ALERT", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@mobile", mobile);
        cmd.Parameters.AddWithValue("@text", Text);
        cmd.Parameters.AddWithValue("@SMSType", "websms");
        cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            string result = cmd.Parameters["@flag"].Value.ToString();
        }
        catch
        {
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
    public int sendSMSByPage(string mobile, String Text)
    {
        int ret = 0;
        WebClient client = new WebClient();
        string companyname = "", url = "", website = "";
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("GETSMS24Info", con);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    apikey = rdr["apikey"].ToString().Trim();
                    clientId = rdr["clientId"].ToString().Trim();
                    smsurl = rdr["smsurl"].ToString().Trim();
                    smssenderid = rdr["smssenderid"].ToString().Trim();
                    website = rdr["website"].ToString().Trim();
                    companyname = rdr["companyname"].ToString().Trim();

                }
            }
        }
        catch (Exception ex)
        {
            ret = 0;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        try
        {

            //Dear#VAL#id:#VAL#Your passwordis:#VAL# From:#VAL#Thanks
            Text = Text + " generated successfully from Toptimenet.com Jai Toptime";
            string baseurl = smsurl + "SenderId=" + smssenderid + "&Message=" + Text.Trim() + "&MobileNumbers=" + mobile + "&ApiKey=" + apikey + "&ClientId=" + clientId;
            //string baseurl = url + "&to=" + mobile.Trim() + "&text=" + Text.Trim() + "&route=Trans&type=text";
            Stream data = client.OpenRead(baseurl);
            StreamReader reader = new StreamReader(data);
            string s = reader.ReadToEnd();
            data.Close();
            reader.Close();
            DebitSMS(1, Text, mobile, s);
            ret = 1;
        }
        catch (Exception ex)
        {
            ret = 0;
        }
        finally
        {
        }
        return ret;


    //    int ret = 0;
    //    WebClient client = new WebClient();
    //    string companyname = "", url = "";
    //    con = new SqlConnection(method.str);
    //    SqlCommand cmd = new SqlCommand("selectSMSInformation", con);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    try
    //    {
    //        con.Open();
    //        SqlDataReader rdr = cmd.ExecuteReader();
    //        if (rdr.HasRows)
    //        {
    //            while (rdr.Read())
    //            {
    //                companyname = rdr["website"].ToString().Trim();
    //                url = rdr["url"].ToString().Trim();
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        ret = 0;
    //    }
    //    finally
    //    {
    //        con.Close();
    //        con.Dispose();
    //    }
    //    try
    //    {

    //        //Dear#VAL#id:#VAL#Your passwordis:#VAL# From:#VAL#Thanks
    //        Text = Text + "generated successfully from: " + companyname + " Jai Toptime";
    //        string baseurl = url + "&to=" + mobile.Trim() + "&text=" + Text.Trim() + "&route=Trans&type=text";
    //        Stream data = client.OpenRead(baseurl);
    //        StreamReader reader = new StreamReader(data);
    //        string s = reader.ReadToEnd();
    //        data.Close();
    //        reader.Close();
    //        DebitSMS(1, Text, mobile, s);
    //        ret = 1;
    //    }
    //    catch (Exception ex)
    //    {
    //        ret = 0;
    //    }
    //    finally
    //    {
    //    }
    //    return ret;
    }

  
    public void sendInvoiceMail(string to, string subject, string msg)
    {
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        WebClient client = new WebClient();
        string companyname = "", gMailAccount = "", password = "";
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("selectGmailAccountInfo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    companyname = rdr["companyname"].ToString().Trim();
                    gMailAccount = rdr["gmailAccount"].ToString().Trim();
                    password = rdr["gmailPassword"].ToString().Trim();
                }
            }
        }
        catch
        {
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        try
        {
            NetworkCredential loginInfo = new NetworkCredential(gMailAccount, password);
            MailMessage mm = new MailMessage();
            mm.From = new MailAddress(gMailAccount, "Golden Grow. Support");
            mm.To.Add(new MailAddress(to));
            mm.SubjectEncoding = System.Text.Encoding.UTF8;
            mm.Subject = subject;
            mm.BodyEncoding = System.Text.Encoding.UTF8;
            mm.IsBodyHtml = true;
            System.Net.Mail.AlternateView plainView = System.Net.Mail.AlternateView.CreateAlternateViewFromString(System.Text.RegularExpressions.Regex.Replace(msg, @"<(.|\n)*?>", string.Empty), null, "text/plain");
            System.Net.Mail.AlternateView htmlView = System.Net.Mail.AlternateView.CreateAlternateViewFromString(msg, null, "text/html");
            mm.AlternateViews.Add(plainView);
            mm.AlternateViews.Add(htmlView);
            mm.Body = msg;
            mm.Priority = MailPriority.High;

            SmtpClient emailClient = new SmtpClient("64.71.180.28");
            emailClient.Port = 587;
            emailClient.EnableSsl = false;
            emailClient.UseDefaultCredentials = false;
            emailClient.Credentials = loginInfo;
            emailClient.Send(mm);
        }
        catch (Exception e)
        {
        }
        finally
        {
        }
    }

    public int sendSMSByPage1(string mobile, String Text)
    {
        int ret = 0;
        WebClient client = new WebClient();
        string companyname = "", url = "";
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("selectSMSInformation", con);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    companyname = rdr["website"].ToString().Trim();
                    url = rdr["url"].ToString().Trim();
                }
            }
        }
        catch (Exception ex)
        {
            ret = 0;
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        try
        {

            //Dear#VAL#id:#VAL#Your passwordis:#VAL# From:#VAL#Thanks
            Text = Text + " from: " + companyname + " Thanks";
            string baseurl = url + "&to=" + mobile.Trim() + "&text=" + Text.Trim() + "&route=Trans&type=text";
            Stream data = client.OpenRead(baseurl);
            StreamReader reader = new StreamReader(data);
            string s = reader.ReadToEnd();
            data.Close();
            reader.Close();
            DebitSMS(1, Text, mobile, s);
            ret = 1;
        }
        catch (Exception ex)
        {
            ret = 0;
        }
        finally
        {
        }
        return ret;
    }

    public void SendbyZoho(string to, string subject, string msg)
    {
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
        WebClient client = new WebClient();
        string companyname = string.Empty, gMailAccount = string.Empty, password = string.Empty;
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("selectZohoAccountInfo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        try
        {
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    companyname = rdr["companyname"].ToString().Trim();
                    gMailAccount = rdr["noreply"].ToString().Trim();
                    password = rdr["norplypass"].ToString().Trim();
                }
            }
        }
        catch
        {
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
        try
        {

            NetworkCredential loginInfo = new NetworkCredential(gMailAccount, password);
            MailMessage mm = new MailMessage();
            mm.From = new MailAddress(gMailAccount);
            mm.To.Add(new MailAddress(to));
            mm.SubjectEncoding = System.Text.Encoding.UTF8;
            mm.Subject = subject;
            mm.BodyEncoding = System.Text.Encoding.UTF8;
            mm.IsBodyHtml = true;
            System.Net.Mail.AlternateView plainView = System.Net.Mail.AlternateView.CreateAlternateViewFromString(System.Text.RegularExpressions.Regex.Replace(msg, @"<(.|\n)*?>", string.Empty), null, "text/plain");
            System.Net.Mail.AlternateView htmlView = System.Net.Mail.AlternateView.CreateAlternateViewFromString(msg, null, "text/html");
            mm.AlternateViews.Add(plainView);
            mm.AlternateViews.Add(htmlView);
            mm.Body = msg;
            mm.Priority = MailPriority.High;
            SmtpClient emailClient = new SmtpClient("smtp.zoho.com");
            emailClient.Port = 587;
            emailClient.EnableSsl = true;
            emailClient.UseDefaultCredentials = false;
            emailClient.Credentials = loginInfo;
            emailClient.Send(mm);

        }
        catch
        {
        }
        finally
        {

        }
    }

     public bool hasSpecialChar(string input)
    {
        string specialChar = @"\|!#$%&/()=?»«@£§€{}.-;'<>_,+~*/?";
        foreach (var item in specialChar)
        {
            if (input.Contains(item.ToString()))
                return false;
        }

        return true;
    }



     public static void WriteErrorLog(string message)
     {
         try
         {
             string path = System.Web.HttpContext.Current.Server.MapPath("~/Error.xml");
             using (StreamWriter writer = new StreamWriter(path, true))
             {
                 writer.WriteLine("<Error> <doe>" + DateTime.Now.ToString() + "</doe>" + message + "</Error>");
                 writer.Close();
             }

         }
         catch
         {
         }
     }



     public int SENDOTP(string mobile, String Text)
     {
         int ret = 0;
         WebClient client = new WebClient();
         try
         {

        //http://enterprise.smsgupshup.com/GatewayAPI/rest?method=SendMessage&send_to=9650443548&msg=Hellotest&msg_type=TEXT&userid=2000171052&auth_scheme=plain&password=lk18cbAJM&v=1.1&format=text
             string baseurl = "http://enterprise.smsgupshup.com/GatewayAPI/rest?method=SendMessage&send_to=" + mobile.Trim() + "&msg=" + Text.Trim() + "&msg_type=TEXT&userid=2000171052&auth_scheme=plain&password=lk18cbAJM&v=1.1&format=text";
             Stream data = client.OpenRead(baseurl);
             StreamReader reader = new StreamReader(data);
             string s = reader.ReadToEnd();
             data.Close();
             reader.Close();
             ret = 1;
         }
         catch (Exception ex)
         {
             ret = 0;
         }
         finally
         {
             ret = 0;
         }
         return ret;
     }


     public List<string> getvalue()
     {
         List<string> bv = new List<string>();

         con = new SqlConnection(method.str);
         DataTable dt = new DataTable();
         da = new SqlDataAdapter("BV", con);
         da.SelectCommand.CommandType = CommandType.StoredProcedure;
         con.Open();
         da.Fill(dt);
         if (dt.Rows.Count > 0)
         {
             bv.Add(dt.Rows[0]["pbv"].ToString());
             bv.Add(dt.Rows[0]["gbv"].ToString());
             bv.Add(dt.Rows[0]["rpbv"].ToString());
             bv.Add(dt.Rows[0]["rgbv"].ToString());
             bv.Add(dt.Rows[0]["CoAdd"].ToString());
             bv.Add(dt.Rows[0]["CoEmail"].ToString());
             bv.Add(dt.Rows[0]["CoWebsite"].ToString());
             bv.Add(dt.Rows[0]["CoAdd2"].ToString());
             bv.Add(dt.Rows[0]["CoLogo"].ToString());
             bv.Add(dt.Rows[0]["CustomerCareNo"].ToString());
             bv.Add(dt.Rows[0]["HeadDesignation"].ToString());
             bv.Add(dt.Rows[0]["HeadName"].ToString());
         }
         con.Close();

         return bv;
     }

     public PVBV_Text HeaderText()
     {
         PVBV_Text obj = new PVBV_Text();
         try
         {

             con = new SqlConnection(method.str);
             string queryy = "Select Userval as 'BVText' from settingMst where Caption='BV'";
             com = new SqlCommand(queryy, con);
             con.Open();
             string result = (string)com.ExecuteScalar();
             obj.PV = result;

         }
         catch (Exception ex)
         {
             throw ex;
         }
         return obj;
     }


    public string GetShowProdPrice(string username)
    {
        DataUtility objDu = new DataUtility();
        return objDu.GetScalar("Select isnull(ShowProdPrice,0) from ControlMst where username='"+ username + "'").ToString();
    }


    public DataTable ProductBrandList()
    {
        DataUtility objDu = new DataUtility();
        return objDu.GetDataTable("Select bid, Title, PriorityNo, Img from tbl_Brand where IsActive=1");
    }


}

public class PVBV_Text
{
    public string PV { get; set; }
    public string BV { get; set; }
    public string TGBV { get; set; }

}