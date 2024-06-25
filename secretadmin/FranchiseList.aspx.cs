using System;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.Services;
using System.IO;
using System.Web;
using System.Linq;
using System.Collections;
using System.Web.UI.WebControls;

public partial class d2000admin_FranchiseList : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-7).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");

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


            BindState();
            Bind_FranchiseTypeEdit();
            //BindGrid(null);
        }
    }


    #region DataTable

    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string fromDate, string toDate, string Name, string State, string District, string City, string PIN,
     string FranType, string appmstActivate, string mobile, string PanNo, string GST)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FromDate", fromDate),
                new SqlParameter("@ToDate", toDate),
                new SqlParameter("@Name", Name),
                new SqlParameter("@State", State),
                new SqlParameter("@District", District),
                new SqlParameter("@City", City),
                new SqlParameter("@PIN", PIN),
                new SqlParameter("@FranType", FranType),
                new SqlParameter("@appmstActivate", appmstActivate),
                new SqlParameter("@mobile",mobile),
                new SqlParameter("@PanNo", PanNo),
                new SqlParameter("@GST", GST),
                new SqlParameter("@Adminid", HttpContext.Current.Session["admin"].ToString())
             };
            DataUtility objDu = new DataUtility();

            SqlDataReader dr = objDu.GetDataReaderSP(param, "getFranchiseList");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                utility objUtil = new utility();


                data.FID_ENCPT = objUtil.base64Encode(dr["FranchiseID"].ToString());
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
                data.Type = dr["Type"].ToString();

                data.IsReturn = dr["IsReturn"].ToString();
                data.IsVendorAuth = dr["IsVendorAuth"].ToString();
                data.SampleAllowed = dr["SampleAllowed"].ToString();
                data.FranType = dr["FranType"].ToString();
                data.Slip = dr["Slip"].ToString();
                data.IsStockMNT_Inc = dr["IsStockMNT_Inc"].ToString();
                data.IsPacked = dr["IsPacked"].ToString();
                data.LeaderId = dr["LeaderId"].ToString();
                data.LeaderName = dr["LeaderName"].ToString();
                data.PSWRD = objUtil.base64Decode(dr["Password"].ToString());

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }



    public class UserDetails
    {
        public string FID_ENCPT { get; set; }
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

        public string Type { get; set; }
        public string IsReturn { get; set; }
        public string FranType { get; set; }
        public string IsVendorAuth { get; set; }
        public string SampleAllowed { get; set; }
        public string Slip { get; set; }
        public string IsStockMNT_Inc { get; set; }
        public string IsPacked { get; set; }
        public string LeaderId { get; set; }
        public string LeaderName { get; set; }
        public string PSWRD { get; set; }

    }





    [System.Web.Services.WebMethod]
    public static string UpdateApprove(string FranchiseID, string flag)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FranchiseID", FranchiseID)
            };

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





    [WebMethod]
    public static string ViewBalance(string FranchiseId)
    {
        String Result = "0";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@FranchiseId", FranchiseId)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetFranchiseTotalBal");
            while (dr.Read())
            {
                Result = dr["DPWithTax"].ToString();
            }
        }
        catch (Exception er) { Result = "0"; }
        return Result;
    }


    private static Random random = new Random();
    public static string RandomString(int length)
    {
        const string chars = "abcdefghijklmnpqrstuvwxyz123456789";
        return new string(Enumerable.Repeat(chars, length).Select(s => s[random.Next(s.Length)]).ToArray());
    }


    [WebMethod]
    public static string RegeneratePwd(string FranchiseId, string Name, string Mobile)
    {
        String Result = "0";
        try
        {
            utility objUtil = new utility();
            string DecoPwd = RandomString(8);
            string EncoPwd = objUtil.base64Encode(DecoPwd);


            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@FranchiseID", FranchiseId), new SqlParameter("@Password", EncoPwd) };
            objDu.ExecuteSql(param, "update FranchiseMst set Password=@Password where FranchiseID=@FranchiseID");


            string msgtxt = "";
            if (Name.Length > 20)
                Name = Name.Substring(0, 20).ToString();

            msgtxt = "Dear " + Name + " ID No " + FranchiseId + " Your  Password : " + DecoPwd;

            objUtil.sendSMSByBilling(Mobile, msgtxt, "FORGETPASSWORD");

            Result = "1";

        }
        catch (Exception er) { Result = "0"; }
        return Result;
    }




    [WebMethod]
    public static string FranLogin(string FranchiseId, string frantype, string Name)
    {
        String Result = "0";
        try
        {
            if (HttpContext.Current.Session["admin"] == null)
            {
                return "SessionOut";
            }
            HttpContext.Current.Session["franchiseid"] = FranchiseId;
            //HttpContext.Current.Session["userid"] = FranchiseId;

            HttpContext.Current.Session["frantype"] = frantype;

            HttpContext.Current.Session["username"] = Name;
            HttpContext.Current.Session["name"] = Name;

            HttpContext.Current.Session["LogId"] = HttpContext.Current.Session["admin"].ToString();
            Result = "1";
        }
        catch (Exception er) { Result = "0"; }
        return Result;
    }






    [System.Web.Services.WebMethod]
    public static string UpdateStatus(string FranchiseId, string flag)
    {
        string objResult = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@FranchiseID", FranchiseId) };

            if (flag == "ACT_DEA")
                objDu.ExecuteSql(param, "update FranchiseMst set appmstActivate=(Case when isnull(appmstActivate,0)=0 then 1 else 0 end) where FranchiseID=@FranchiseID");

            if (flag == "VendorAuthorization")
                objDu.ExecuteSql(param, "update FranchiseMst set IsVendorAuth=(Case when isnull(IsVendorAuth,0)=0 then 1 else 0 end) where FranchiseID=@FranchiseID");

            if (flag == "IsReturn")
                objDu.ExecuteSql(param, "update FranchiseMst set IsReturn=(Case when isnull(IsReturn,0)=0 then 1 else 0 end) where FranchiseID=@FranchiseID");

            if (flag == "SampleAllow")
                objDu.ExecuteSql(param, "update FranchiseMst set SampleAllowed=(Case when isnull(SampleAllowed,0)=0 then 1 else 0 end) where FranchiseID=@FranchiseID");

            if (flag == "StockMntInc")
                objDu.ExecuteSql(param, "update FranchiseMst set IsStockMNT_Inc=(Case when isnull(IsStockMNT_Inc,0)=0 then 1 else 0 end) where FranchiseID=@FranchiseID");

            if (flag == "IsPacked")
                objDu.ExecuteSql(param, "update FranchiseMst set IsPacked=(Case when isnull(IsPacked,0)=0 then 1 else 0 end) where FranchiseID=@FranchiseID");


            objResult = "1";
        }
        catch (Exception er)
        {
            return objResult;
        }
        return objResult;
    }



    private void Bind_FranchiseTypeEdit()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4 and UserVal not in (1, 7, 8, 9, 10)");
        if (dt.Rows.Count > 0)
        {
            ddl_Type.DataSource = dt;
            ddl_Type.DataTextField = "Item_Desc";
            ddl_Type.DataValueField = "Frantype";
            ddl_Type.DataBind();
            ddl_Type.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Type", "-1"));
        }
        else
        {
            ddl_Type.Items.Clear();
            ddl_Type.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Type", "-1"));
        }
    }


    public void BindState()
    {
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP("GetState");
        if (dt.Rows.Count > 0)
        {
            ddl_State.Items.Clear();
            ddl_State.DataSource = dt;
            ddl_State.DataTextField = "StateName";
            ddl_State.DataValueField = "Id";
            ddl_State.DataBind();
            ddl_State.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select State", ""));
            ddl_District.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select District", ""));
        }

    }
    [WebMethod]
    public static ArrayList GetDistrict(string StateId)
    {
        ArrayList list = new ArrayList();
        try
        {
            DataUtility objDUT = new DataUtility();
            SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@state", StateId) };
            DataTable dt = objDUT.GetDataTableSP(sqlparam, "GetStateDistrict");
            foreach (DataRow dr in dt.Rows)
            { list.Add(new ListItem(dr["DistrictName"].ToString(), dr["DistrictName"].ToString())); }
        }
        catch (Exception er) { }
        return list;
    }

    #endregion

}
