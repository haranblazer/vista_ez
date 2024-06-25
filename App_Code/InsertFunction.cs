using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
/// <summary>
/// Summary description for InsertFunction
/// </summary>
public class InsertFunction
{
    public SqlDataReader dr;
    SqlConnection con = new SqlConnection(method.str);

    public string SID, Uname, PID, REGNO;
    public int check, LeftRight, appmst;
	public InsertFunction()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public string Sponserid
    {
        set { SID = value; }
        get { return SID; }
    }
    public string UserName
    {
        set { Uname = value; }
        get { return Uname; }
    }
    public int CheckFlag
    {
        set { check = value; }
        get { return check; }
    }
    public int LeftOrRight
    {
        set { LeftRight = value; }
        get { return LeftRight; }
    }
    public int AppMstIdData
    {
        set { appmst = value; }
        get { return appmst; }
    }
    public string ParrentId
    {
        set { PID = value; }
        get { return PID; }
    }
    public string RegistrationNo 
    {
        set { REGNO = value; }
        get { return REGNO; }
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
                    HttpContext.Current.Response.Redirect("adminLog.aspx");
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
                        HttpContext.Current.Response.Redirect("adminLog.aspx");
                    }
                }
            }
            else
            {
                HttpContext.Current.Response.Redirect("adminLog.aspx");
            }
        }
        catch
        {
            HttpContext.Current.Response.Redirect("adminLog.aspx");
        }
    }
    public void SponserCheck()
    {
        con.Close();
        SqlCommand com = new SqlCommand("CheckSidAndUname", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@SID", SID);
        //com.Parameters.AddWithValue("@uname",Uname);
        com.Parameters.Add(new SqlParameter("@flag", SqlDbType.Int));
        com.Parameters["@flag"].Direction = ParameterDirection.Output;
        con.Open();
        dr = com.ExecuteReader();
        check = Convert.ToInt32(com.Parameters["@flag"].Value);
    }
    public void FindMax()
    {
        con.Close();
        SqlCommand com = new SqlCommand("FindMaxId", con);
        com.CommandType = CommandType.StoredProcedure;
        con.Open();
        dr = com.ExecuteReader();
    }
    //public void UpdateParentId()
    //{
    //    con.Close();
    //    SqlCommand com = new SqlCommand("UpdateParrentId", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.Parameters.AddWithValue("@PID", PID);
    //    com.Parameters.AddWithValue("@LeftRight",LeftRight);
    //    com.Parameters.AddWithValue("@appmstregno",REGNO);
    //    con.Open();
    //    com.ExecuteNonQuery();
    //}
    public void UpdateIncreaseSponser()
    {
        SqlCommand com = new SqlCommand("IncreaseSponsor", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@sid", SID);
        con.Open();
        com.ExecuteNonQuery();
    }
    public void UpdateLeftRight()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("UpdateLeftRight", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@downid", REGNO);
        con.Open();
        com.ExecuteNonQuery();
    }
    public static string checkHacked(string svalue)
    {
        svalue = svalue.Replace("'", "");
        svalue = svalue.Replace("exec", "");
        svalue = svalue.Replace("execute", "");
        svalue = svalue.Replace(".js", "");
        svalue = svalue.Replace(".", "");
        svalue = svalue.Replace("-", "");
        svalue = svalue.Replace("_", "");
        svalue = svalue.Replace(";", "");
        svalue = svalue.Replace("--", "");
        svalue = svalue.Replace("drop", "");
        return svalue;

    }
    public static void Checklogin()
    {
        try
        {
            string regno = HttpContext.Current.Session["userId"].ToString().Trim();
            if (Regex.Match(regno, @"^[a-zA-Z0-9]*$").Success)
            {

                {
                    if (HttpContext.Current.Session["userId"] == null)
                    {
                        HttpContext.Current.Response.Redirect("~/Default.aspx");
                    }
                    else
                    {

                        string userid = HttpContext.Current.Session["userId"].ToString().Trim();
                        SqlConnection con = new SqlConnection(method.str);
                        string sqltext = "SessionuserExsist";
                        SqlCommand cmd = new SqlCommand(sqltext, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@regno", userid);
                        con.Open();
                        SqlDataReader rdr = cmd.ExecuteReader();
                        if (rdr.HasRows)
                        {

                        }
                        else
                        {
                            HttpContext.Current.Response.Redirect("~/Default.aspx");
                        }
                    }
                }
            }
            else
            {
                HttpContext.Current.Response.Redirect("~/Default.aspx");

            }
        }
        catch
        {
        }

    }
    public static void CheckAdminlogin()
    {

        try
        {
            if (HttpContext.Current.Session["admin"] == null)
            {
                HttpContext.Current.Response.Redirect("adminLog.aspx");
            }
            string admin = HttpContext.Current.Session["admin"].ToString().Trim();
            if (Regex.Match(admin, @"^[a-zA-Z0-9]*$").Success)
            {
                //if (HttpContext.Current.Session["admin"] == null)
                //{
                //    HttpContext.Current.Response.Redirect("adminLog.aspx");
                //}
                //else
                //{
                    string admid = null;
                    string admpwd = null;
                    admid = HttpContext.Current.Session["admin"].ToString().Trim();
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
                        HttpContext.Current.Response.Redirect("adminLog.aspx");
                    }
                //}
            }
            else
            {
                HttpContext.Current.Response.Redirect("adminLog.aspx");
            }
        }
        catch(Exception ex )
        {
            string s = ex.Message;
            HttpContext.Current.Response.Redirect("adminLog.aspx");
        }
    }

    public string insertPanDetail(string panText, string usrId, string filename)
    {

        SqlCommand cmd = new SqlCommand("DocUpload", con);
        cmd.CommandType = CommandType.StoredProcedure;
         cmd.Parameters.AddWithValue("@modified", usrId);
        cmd.Parameters.AddWithValue("@value", panText);
        cmd.Parameters.AddWithValue("@regno", usrId);
        cmd.Parameters.AddWithValue("@action", "P");
        cmd.Parameters.AddWithValue("@image", filename);
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        cmd.Parameters.Add("@imagename", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
        con.Open();
        cmd.ExecuteNonQuery();
        string msg = cmd.Parameters["@flag"].Value.ToString();
        string imagename = cmd.Parameters["@imagename"].Value.ToString();
        return imagename;
    }

    public string insertFranPanDetail(string panText, string usrId, string filename)
    {

        SqlCommand cmd = new SqlCommand("FDocUpload", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@value", panText);
        cmd.Parameters.AddWithValue("@regno", usrId);
        cmd.Parameters.AddWithValue("@action", "P");
        cmd.Parameters.AddWithValue("@image", filename);
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        cmd.Parameters.Add("@imagename", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
        con.Open();
        cmd.ExecuteNonQuery();
        string msg = cmd.Parameters["@flag"].Value.ToString();
        string imagename = cmd.Parameters["@imagename"].Value.ToString();
        return imagename;
    }

    public string insertProfileImage(string usrId, string filename)
    {
        SqlCommand cmd = new SqlCommand("saveProfileImage", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@AppMstregno", usrId);
        cmd.Parameters.AddWithValue("@image", filename);
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        cmd.Parameters.Add("@imagename", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
        con.Open();
        cmd.ExecuteNonQuery();
        string imagename = cmd.Parameters["@imagename"].Value.ToString();
        return imagename;
    }

    public string UpdateFranchiseProImg(string usrId, string filename)
    {
        SqlCommand cmd = new SqlCommand("UpdateFranchiseProImg", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@franchiseid", usrId);
        cmd.Parameters.AddWithValue("@image", filename);
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        cmd.Parameters.Add("@imagename", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
        con.Open();
        cmd.ExecuteNonQuery();
        string imagename = cmd.Parameters["@imagename"].Value.ToString();
        return imagename;
    }

    public string GST_Detail(string GSTNo, string UsrId, string filename, string modifiedBy)
    {

        SqlCommand cmd = new SqlCommand("GST_Upload", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@modified", modifiedBy);
        cmd.Parameters.AddWithValue("@GSTNo", GSTNo);
        cmd.Parameters.AddWithValue("@regno", UsrId);
        cmd.Parameters.AddWithValue("@image", filename);
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        con.Open();
        cmd.ExecuteNonQuery();
        return cmd.Parameters["@flag"].Value.ToString();
    }


    public string insertBankDetail(string Cropfilename, string ddlBkName, string ddlActype, string txtAccno, string txtIfsc, string txtBranch, string usrid)
    {
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("InsertBankDetails", con);
        cmd.CommandType = CommandType.StoredProcedure;
        con.Open();
        cmd.Parameters.AddWithValue("@action", "B");
        cmd.Parameters.AddWithValue("@bankimage", Cropfilename);
        cmd.Parameters.AddWithValue("@bankstatus", 1);
        cmd.Parameters.AddWithValue("@BankName", ddlBkName);
        cmd.Parameters.AddWithValue("@AccountName", ddlActype);
        cmd.Parameters.AddWithValue("@BankACNo", txtAccno);
        cmd.Parameters.AddWithValue("@Branch", txtBranch);
        cmd.Parameters.AddWithValue("@IFSCCode", txtIfsc);
        cmd.Parameters.AddWithValue("@regno", usrid);
        cmd.Parameters.AddWithValue("@UpdateBy", usrid); 
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        cmd.Parameters.Add("@imagename", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
        cmd.Parameters.Add("@modifiedby", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        cmd.ExecuteNonQuery();
        con.Close();
        string msg = cmd.Parameters["@flag"].Value.ToString();
        string imagename = cmd.Parameters["@imagename"].Value.ToString();
        return imagename;
    }

    public string insertFranBankDetail(string Cropfilename, string ddlBkName, string ddlActype, string txtAccno, string txtIfsc, string txtBranch, string usrid)
    {
        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("InsertFranBankDetails", con);
        cmd.CommandType = CommandType.StoredProcedure;
        con.Open();
        cmd.Parameters.AddWithValue("@action", "B");
        cmd.Parameters.AddWithValue("@bankimage", Cropfilename);
        cmd.Parameters.AddWithValue("@bankstatus", 1);
        cmd.Parameters.AddWithValue("@BankName", ddlBkName);
        cmd.Parameters.AddWithValue("@AccountName", ddlActype);
        cmd.Parameters.AddWithValue("@BankACNo", txtAccno);
        cmd.Parameters.AddWithValue("@Branch", txtBranch);
        cmd.Parameters.AddWithValue("@IFSCCode", txtIfsc);
        cmd.Parameters.AddWithValue("@regno", usrid);
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        cmd.Parameters.Add("@imagename", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
        
        cmd.ExecuteNonQuery();
        con.Close();
        string msg = cmd.Parameters["@flag"].Value.ToString();
        string imagename = cmd.Parameters["@imagename"].Value.ToString();
        return imagename;
    }

    public void insertAddressProof(string filename1, string filename2, string usrId,string aadharText, out string imgFront, out string imgBack, out string msg)
    {
        SqlCommand cmd = new SqlCommand("UploadAadharImg", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@value", aadharText);
        cmd.Parameters.AddWithValue("@regno", usrId);
        cmd.Parameters.AddWithValue("@modifiedby", usrId); 
        cmd.Parameters.AddWithValue("@action", "AD");
        cmd.Parameters.AddWithValue("@AF", filename1);
        cmd.Parameters.AddWithValue("@AB", filename2);
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        cmd.Parameters.Add("@AFImg", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
        cmd.Parameters.Add("@ABImg", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
        con.Open();
        cmd.ExecuteNonQuery();
        msg = cmd.Parameters["@flag"].Value.ToString();
        imgFront = cmd.Parameters["@AFImg"].Value.ToString();
        imgBack = cmd.Parameters["@ABImg"].Value.ToString();


    }
    //public void updatespilldata()
    //{
    //    con.Close(); 
    //    SqlCommand com = new SqlCommand("updatespilldata", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.Parameters.AddWithValue("@sponserid", SID);
    //    com.Parameters.AddWithValue("@appmstid", appmst);
    //    con.Open();
    //    com.ExecuteNonQuery();
    //}
}
