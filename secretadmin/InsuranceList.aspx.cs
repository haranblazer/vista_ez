using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
public partial class secretadmin_InsuranceList : System.Web.UI.Page
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



    #region BindTable
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string UserName, string Userid)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@UserName", UserName),
                new SqlParameter("@Userid", Userid)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_Insurance");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.IID = dr["IID"].ToString();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.PolicyNo = dr["PolicyNo"].ToString();
                data.SumInsured = dr["SumInsured"].ToString();
                data.StartDate = dr["StartDate"].ToString();
                data.EndDate = dr["EndDate"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string IID { get; set; }
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string PolicyNo { get; set; }
        public string SumInsured { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
    }


    [System.Web.Services.WebMethod]
    public static UserDetails[] GetDetail(string IID)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@IID", IID) };
            SqlDataReader dr = objDu.GetDataReader(param, @"Select i.IID, i.UserId, UserName=a.Appmstfname, i.PolicyNo, i.SumInsured, 
            StartDate=convert(varchar(20), i.StartDate, 103), EndDate=convert(varchar(20), i.EndDate, 103) 
            from InsuranceMst i left join Appmst a on i.UserId=a.Appmstregno where IID=@IID");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.IID = dr["IID"].ToString();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.PolicyNo = dr["PolicyNo"].ToString();
                data.SumInsured = dr["SumInsured"].ToString();
                data.StartDate = dr["StartDate"].ToString();
                data.EndDate = dr["EndDate"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static string Save(string IID, string UserId, string PolicyNo, string SumInsured, string StartDate, string EndDate)
    {
        string Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter outparam = new SqlParameter("@intResult", System.Data.SqlDbType.VarChar, 100);
            outparam.Direction = System.Data.ParameterDirection.Output;
            SqlParameter[] param = new SqlParameter[]
            {   new SqlParameter("@IID", IID),
                new SqlParameter("@UserId", UserId),
                new SqlParameter("@PolicyNo", PolicyNo),
                new SqlParameter("@SumInsured", SumInsured),
                new SqlParameter("@StartDate", StartDate),
                new SqlParameter("@EndDate", EndDate),
                outparam
            };
            Result = objDu.ExecuteSqlSP(param, "Add_Insurance").ToString();
        }
        catch (Exception er) { }
        return Result;
    }


    [System.Web.Services.WebMethod]
    public static string Delete(string IID)
    {
        string Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@IID", IID) };
            Result = objDu.ExecuteSql(param, "Delete InsuranceMst where IID=@IID").ToString();
        }
        catch (Exception er) { }
        return Result;
    }




    #endregion


    protected void btnbulkcopy_Click(object sender, EventArgs e)
    {
        try
        {
            if (FileUpload1.HasFile)
            {
                DataTable dt = new DataTable();
                dt = ReadCsvFile();

                if (dt.Rows.Count > 0)
                {
                    SqlConnection con = new SqlConnection(method.str);
                    SqlCommand cmd = new SqlCommand("Add_Excel_Insurance", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter tvparam = cmd.Parameters.AddWithValue("@dt", dt);
                    cmd.Parameters.Add("@flag", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    tvparam.SqlDbType = SqlDbType.Structured;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    string status = cmd.Parameters["@flag"].Value.ToString();
                    con.Close();
                    if (status == "1")
                    {
                        btnbulkcopy.Enabled = false;
                        utility.MessageBox(this, "Your details save successfully.!!");
                        return;
                    }
                    else
                    {
                        utility.MessageBox(this, status);
                        return;
                    }

                }
            }
            else
            {
                utility.MessageBox(this, "Please Select CSV File !!!");
            }
        }
        catch (Exception EX)
        {
            utility.MessageBox(this, EX.Message.ToString());

        }
    }


    private DataTable ReadCsvFile()
    {
        DataTable dtCsv = new DataTable();
        string Fulltext;
        if (FileUpload1.HasFile)
        {
            string FileName = Path.GetFileName(Guid.NewGuid().ToString() + FileUpload1.PostedFile.FileName);

            string FileSaveWithPath = Server.MapPath("~/secretadmin/ProductDoc/" + FileName);
            FileUpload1.SaveAs(FileSaveWithPath);
            using (StreamReader sr = new StreamReader(FileSaveWithPath))
            {
                while (!sr.EndOfStream)
                {
                    Fulltext = sr.ReadToEnd().ToString(); //read full file text  
                    string[] rows = Fulltext.Split('\n'); //split full file text into rows  
                    for (int i = 0; i < rows.Length - 1; i++)
                    {
                        string[] rowValues = rows[i].Split(','); //split each row with comma to get individual values  
                        {
                            if (i == 0)
                            {
                                for (int j = 0; j < rowValues.Length; j++)
                                {
                                    dtCsv.Columns.Add(rowValues[j]); //add headers  
                                }
                            }
                            else
                            {
                                DataRow dr = dtCsv.NewRow();
                                for (int k = 0; k < rowValues.Length; k++)
                                {
                                    try
                                    {
                                        string Value = rowValues[k].ToString();
                                        if (k == 3)
                                        {
                                            String[] Date = Value.Split(new String[] { "-" }, StringSplitOptions.RemoveEmptyEntries);
                                            dr[k] = Date[2] + "-" + Date[1] + "-" + Date[0] + " 00:00:00.000";
                                        }
                                        else if (k == 4)
                                        {
                                            Value = Value.Replace("\r", "");
                                            String[] Date = Value.Split(new String[] { "-" }, StringSplitOptions.RemoveEmptyEntries);
                                            dr[k] = Date[2] + "-" + Date[1] + "-" + Date[0] + " 00:00:00.000";
                                        }
                                        else
                                        {
                                            dr[k] = Value;
                                        }
                                    }
                                    catch { }
                                }
                                dtCsv.Rows.Add(dr); //add other rows  
                            }
                        }
                    }
                }
            }
        }
        return dtCsv;
    }

}