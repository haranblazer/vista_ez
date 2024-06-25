using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.IO;

public partial class admin_IncRegId : System.Web.UI.Page
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

        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string Mobile, string Verified)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FromDate", min),
                new SqlParameter("@ToDate", max),
                new SqlParameter("@Name", ""),
                new SqlParameter("@State", ""),
                new SqlParameter("@District", ""),
                new SqlParameter("@City", ""),
                new SqlParameter("@PIN", ""),
                new SqlParameter("@FranType","0"),
                new SqlParameter("@appmstActivate", "-1"),
                new SqlParameter("@mobile",Mobile),
                new SqlParameter("@PanNo", ""),
                new SqlParameter("@GST", ""),
                new SqlParameter("@Verified", Verified),
                new SqlParameter("@Adminid", HttpContext.Current.Session["admin"].ToString())
             };
            DataUtility objDu = new DataUtility();

            SqlDataReader dr = objDu.GetDataReaderSP(param, "getFranchiseList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                data.FranchiseID = dr["FranchiseID"].ToString();
                data.FranchiseName = dr["FranchiseName"].ToString();
                data.ContactPerson = dr["ContactPerson"].ToString();
                data.MobileNo = dr["MobileNo"].ToString();
                data.District = dr["District"].ToString();
                data.City = dr["City"].ToString();
                data.PIN = dr["PIN"].ToString();
                data.Address = dr["Address"].ToString();
                data.PAN = dr["PAN"].ToString();
                data.State = dr["State"].ToString();
                data.email = dr["email"].ToString();

                data.BankName = dr["BankName"].ToString();
                data.AccountNo = dr["AccountNo"].ToString();
                data.GST = dr["GST"].ToString();
                data.IFSCCode = dr["IFSCCode"].ToString();
                data.RegistrationDate = dr["RegistrationDate"].ToString();

                data.SponsorID = dr["SponsorID"].ToString();
                data.SponsorName = dr["SponsorName"].ToString();

                data.OpeningAmount = dr["OpeningAmount"].ToString();
                data.MinStkAmt = dr["MinStkAmt"].ToString();
                data.MappingId = dr["MappingId"].ToString();
                data.CinNo = dr["CinNo"].ToString();
                data.Status = dr["Status"].ToString();

                data.Pan_img = dr["Pan_img"].ToString();
                data.Bank_img = dr["Bank_img"].ToString();
                data.GST_img = dr["GST_img"].ToString();
                data.Aadhar_B_img = dr["Aadhar_B_img"].ToString();
                data.Aadhar_F_img = dr["Aadhar_F_img"].ToString();
                data.Pan_VFYD = dr["Pan_VFYD"].ToString();
                data.Bank_VFYD = dr["Bank_VFYD"].ToString();
                data.GST_VFYD = dr["GST_VFYD"].ToString();
                data.AADHAR_VFYD = dr["AADHAR_VFYD"].ToString(); 
                data.IsVerified = dr["IsVerified"].ToString();
                data.IS_OPTIN = dr["IS_OPTIN"].ToString();
                data.Slip = dr["Slip"].ToString();
                
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }

    public class Results
    {
        public String Error { get; set; }
        public String FranchiseId { get; set; }
        public String Name { get; set; }
    }


    [System.Web.Services.WebMethod]
    public static Results UpdateFranDetails(string FranchiseID, string OpeningAmount, string MinStkAmt, string MappingId, string FranType, string Pwd)
    {
        Results objResult = new Results();
        try
        {
            utility objUt = new utility();

            if (FranType == "-1")
            {
                objResult.Error = "Please Select Franchise Type.";
                return objResult;
            }
            if (Pwd.Length <5)
            {
                objResult.Error = "Password should be minimum 5 characters.";
                return objResult;
            }

            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("UpdateFranchise", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@FranchiseIdOld", FranchiseID);
            com.Parameters.AddWithValue("@OpeningAmount", OpeningAmount == "" ? "0" : OpeningAmount);
            com.Parameters.AddWithValue("@MappingId", MappingId);

            com.Parameters.AddWithValue("@MinStkAmt", MinStkAmt == "" ? "0" : MinStkAmt);
            com.Parameters.AddWithValue("@FranType", FranType);
            com.Parameters.AddWithValue("@Pwd", objUt.base64Encode(Pwd) );
            com.Parameters.Add("@FranchiseId", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            com.Parameters.Add("@Name", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            com.Parameters.Add("@Mobile", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open(); 
            com.ExecuteNonQuery();
            string Flag = com.Parameters["@flag"].Value.ToString();
            string FranchiseId = com.Parameters["@FranchiseId"].Value.ToString();
            if (Flag == "1")
            {
                objResult.Error = "";
                objResult.FranchiseId = FranchiseId;
                objResult.Name = com.Parameters["@Name"].Value.ToString(); 

                var Msg = "Dear " + objResult.Name + " Your Franchises ID has been Created Successfully. And your ID No. " + FranchiseId + " Password " + Pwd + " Mobile No is " + com.Parameters["@Mobile"].Value.ToString() + " For latest News & updates please join us on Telegram by clicking the link+%0Ahttps%3A%2F%2Ft.me%2FToptime_Offical";
            
                //WhatsApp.Send_WhatsApp_With_Header(com.Parameters["@Mobile"].Value.ToString(), Msg, "Welcome As Franchsies");

                WhatsApp.Send_WhatsApp_With_Header_Text(com.Parameters["@Mobile"].Value.ToString(), Msg, "Welcome As Franchsies");
                

                return objResult;
            }
            else
            {
                objResult.Error = Flag;
                objResult.FranchiseId = "";
                objResult.Name = "";
                return objResult;
            }
        }
        catch (Exception er)
        {
            objResult.Error = er.Message;
            objResult.FranchiseId = "";
            return objResult;
        }
        return objResult;
    }


    [System.Web.Services.WebMethod]
    public static string RejectFran(string FranchiseID)
    {
        string objResult ="";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FranchiseID", FranchiseID)
            };
            objDu.ExecuteSql(param, "update FranchiseMst set IsVerified=2 where FranchiseID=@FranchiseID");
            objResult = "1";
        }
        catch (Exception er) { 
            return objResult;
        }
        return objResult;
    }


    [System.Web.Services.WebMethod]
    public static string UpdateApprove(string FranchiseID, string flag)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@FranchiseID", FranchiseID) };

            if (flag == "PAN")
                objDu.ExecuteSql(param, "update FranchiseMst set Pan_VFYD=1, PanDateApproved=Getdate() where FranchiseID=@FranchiseID");
            if (flag == "BANK")
                objDu.ExecuteSql(param, "update FranchiseMst set Bank_VFYD=1, BankDateApproved=Getdate() where FranchiseID=@FranchiseID");
            if (flag == "GST")
                objDu.ExecuteSql(param, "update FranchiseMst set GST_VFYD=1, GSTDateApproved=Getdate() where FranchiseID=@FranchiseID");
            if (flag == "AADHAR")
                objDu.ExecuteSql(param, "update FranchiseMst set AADHAR_VFYD=1, AadharDateApproved=Getdate() where FranchiseID=@FranchiseID");
            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }


    [System.Web.Services.WebMethod]
    public static string UpdateReject(string FranchiseID, string flag)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] prm = new SqlParameter[] { new SqlParameter("@FID", FranchiseID) };

            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@FranchiseID", FranchiseID) };

            if (flag == "PAN")
            {
                string OldImgName = objDu.GetScaler(prm, "Select Pan_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set Pan_img=null, Pan_VFYD=2 where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/Slip/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                } 
            }

            if (flag == "BANK")
            { 
                string OldImgName = objDu.GetScaler(prm, "Select Bank_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set Bank_img=null, Bank_VFYD=2 where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/Slip/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                } 
            }

            if (flag == "GST")
            { 
                string OldImgName = objDu.GetScaler(prm, "Select GST_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set GST_img=null, GST_VFYD=2 where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/Slip/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                } 
            }

            if (flag == "AADHAR")
            { 
                string Aadhar_F_img = objDu.GetScaler(prm, "Select Aadhar_F_img from FranchiseMst where FranchiseID=@FID").ToString();
                string Aadhar_B_img = objDu.GetScaler(prm, "Select Aadhar_B_img from FranchiseMst where FranchiseID=@FID").ToString();
                 

                objDu.ExecuteSql(param, "update FranchiseMst set Aadhar_F_img=null, Aadhar_B_img=null, AADHAR_VFYD=2 where FranchiseID=@FranchiseID");

                string filePath1 = Path.Combine(HttpContext.Current.Server.MapPath("~/images/Slip/"), Aadhar_F_img);
                if (System.IO.File.Exists(filePath1))
                {
                    System.IO.File.Delete(filePath1);
                }

                string filePath2 = Path.Combine(HttpContext.Current.Server.MapPath("~/images/Slip/"), Aadhar_B_img);
                if (System.IO.File.Exists(filePath2))
                {
                    System.IO.File.Delete(filePath2);
                }

            }

            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }

    
    [System.Web.Services.WebMethod]
    public static string UpdateImage(string FranchiseID, string flag, string ImgName)
    {
        string Result = "1";
        try
        {
            DataUtility objDu = new DataUtility();

            SqlParameter[] prm = new SqlParameter[] { new SqlParameter("@FID", FranchiseID) };

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FranchiseID", FranchiseID),
                new SqlParameter("@ImgName", ImgName)
            };

            if (flag == "PAN")
            {
                string OldImgName = objDu.GetScaler(prm, "Select Pan_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set Pan_VFYD=1, Pan_img=@ImgName, PanDateApproved=Getdate(), PanDateLoad=Getdate() where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/Slip/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }


            if (flag == "BANK")
            {
                string OldImgName = objDu.GetScaler(prm, "Select Bank_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set Bank_VFYD=1, Bank_img=@ImgName, BankDateApproved=Getdate(), BankDateLoad=Getdate() where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/Slip/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }


            if (flag == "GST")
            {
                string OldImgName = objDu.GetScaler(prm, "Select GST_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set GST_VFYD=1, GST_img=@ImgName, GSTDateLoad=Getdate(), GSTDateApproved=Getdate() where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/Slip/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }


            if (flag == "AADHARFRONT")
            {
                string OldImgName = objDu.GetScaler(prm, "Select Aadhar_F_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set AADHAR_VFYD=1, Aadhar_F_img=@ImgName, AadharDateLoad=Getdate(), AadharDateApproved=Getdate() where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/Slip/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }


            if (flag == "AADHARBACK")
            {
                string OldImgName = objDu.GetScaler(prm, "Select Aadhar_B_img from FranchiseMst where FranchiseID=@FID").ToString();

                objDu.ExecuteSql(param, "update FranchiseMst set AADHAR_VFYD=1, Aadhar_B_img=@ImgName, AadharDateLoad=Getdate(), AadharDateApproved=Getdate() where FranchiseID=@FranchiseID");

                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/Slip/"), OldImgName);
                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }

        }
        catch (Exception er)
        {
            Result = er.Message;
        }
        return Result;
    }


    public class UserDetails
    {
        public string FranchiseID { get; set; }
        public string FranchiseName { get; set; }
        public string ContactPerson { get; set; }
        public string MobileNo { get; set; }
        public string District { get; set; }
        public string City { get; set; }
        public string PIN { get; set; }
        public string Address { get; set; }
        public string PAN { get; set; }
        public string State { get; set; }
        public string email { get; set; }
        public string BankName { get; set; }
        public string AccountNo { get; set; }
        public string GST { get; set; }
        public string IFSCCode { get; set; }

        public string RegistrationDate { get; set; }
        public string SponsorID { get; set; }
        public string SponsorName { get; set; }
        public string OpeningAmount { get; set; }
        public string MinStkAmt { get; set; }
        public string MappingId { get; set; }
        public string CinNo { get; set; }
        public string Status { get; set; }


        public string Pan_img { get; set; }
        public string Bank_img { get; set; }
        public string GST_img { get; set; }
        public string Aadhar_F_img { get; set; }
        public string Aadhar_B_img { get; set; }

        public string Pan_VFYD { get; set; }
        public string Bank_VFYD { get; set; }
        public string GST_VFYD { get; set; }
        public string AADHAR_VFYD { get; set; }
        public string IsVerified { get; set; } 
        public string IS_OPTIN { get; set; }
        public string Slip { get; set; }
    }

    #endregion
}
