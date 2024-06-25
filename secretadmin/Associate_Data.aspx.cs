using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Linq;
using System.Collections.Generic;
using System.Web.Services;
using System.Collections;

public partial class secretadmin_Associate_Data : System.Web.UI.Page
{
    //DataTable t1 = new DataTable();
    //SqlConnection con = new SqlConnection(method.str);
    //SqlCommand com;
    //SqlDataAdapter da;
    //utility u = new utility();
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
            ddl_order.Items.Insert(0, new ListItem("All", "-1"));
            ddl_order.Items.Insert(1, new ListItem(method.Associate, "0"));
            ddl_order.Items.Insert(2, new ListItem(method.Customer, "1"));
            txtFromDate.Text = DateTime.Now.Date.AddDays(-7).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");

            BindState();

            //BindUserList();
        }
    }
 
    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string regno, string AppMstFName, string AppMstState, string District, string AppMstMobile,
        string panno, string BankName, string AccountNo, string IFSCCode, string IsActive,
       string OnlinePanVerify, string PanStatus, string BankStatus, string AadharStatus, string Cust_Type)
    {

        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
           {
               new SqlParameter("@FromDate", min),
               new SqlParameter("@ToDate", max),
               new SqlParameter("@regno", regno),
               new SqlParameter("@AppMstFName", AppMstFName),
               new SqlParameter("@AppMstState", AppMstState),
               new SqlParameter("@District", District),
               new SqlParameter("@AppMstMobile", AppMstMobile),
               new SqlParameter("@panno", panno),
               new SqlParameter("@BankName", BankName),
               new SqlParameter("@AccNo", AccountNo),
               new SqlParameter("@Ifsc", IFSCCode),
               new SqlParameter("@IsActive", IsActive),
               new SqlParameter("@OnlinePanVerify", OnlinePanVerify),
               new SqlParameter("@PanStatus", PanStatus), 
               new SqlParameter("@BankStatus", BankStatus),
               new SqlParameter("@AadharStatus", AadharStatus),
               new SqlParameter("@Adminid", HttpContext.Current.Session["admin"].ToString())  , 
               new SqlParameter("@IsCustomer", Cust_Type),
           };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "AssociateData");
            while (dr.Read())
            {
                utility objutil = new utility();
                UserDetails data = new UserDetails();
                data.AppMstid = dr["AppMstid"].ToString();
                data.RegNo = dr["regno"].ToString();
                data.User_ID = dr["User ID"].ToString();
                data.User_Name = dr["User Name"].ToString();
                data.User_State = dr["User State"].ToString();
                data.User_District = dr["User District"].ToString();
                data.User_Mobile_No = dr["User Mobile No"].ToString();
                data.User_Pan_No = dr["Pan No"].ToString();
                data.User_Bank_Name = dr["Bank Name"].ToString();
                data.User_Acc_No = dr["Acc No"].ToString();
                data.User_IFSC = dr["IFSC"].ToString();
                data.ID_Status = dr["ID Status"].ToString();
                data.PStatus = dr["PStatus"].ToString();
                data.bankstatus = dr["bankstatus"].ToString();
                data.AaStatus = dr["AaStatus"].ToString();
                data.AppMstPinCode = dr["AppMstPinCode"].ToString();
                data.PanApiName = dr["PanApiName"].ToString();
                data.OnlinePanVerify = dr["OnlinePanVerify"].ToString(); 
                data.Customer_Type = dr["IsCustomer"].ToString();
                data.DOJ = dr["AppMstDOJ"].ToString();
                data.City = dr["AppMstCity"].ToString();
                data.Address = dr["AppMstAddress1"].ToString();
                data.Pswrd = objutil.base64Decode(dr["AppMstPassword"].ToString());
               // City, Address, Pswrd
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string AppMstid { get; set; }
        public string RegNo { get; set; }
        public string User_ID { get; set; }
        public string User_Name { get; set; }
        public string User_State { get; set; }
        public string User_District { get; set; }
        public string User_Mobile_No { get; set; }
        public string User_Pan_No { get; set; }
        public string User_Bank_Name { get; set; }
        public string User_Acc_No { get; set; }
        public string User_IFSC { get; set; }
        public string ID_Status { get; set; }
        public string PStatus { get; set; }
        public string bankstatus { get; set; }
        public string AaStatus { get; set; }
        public string AppMstPinCode { get; set; }
        public string PanApiName { get; set; }
        public string OnlinePanVerify { get; set; }
        
                    public string Customer_Type { get; set; }
        public string DOJ { get; set; }
        public string City { get; set; }
        public string Address { get; set; }
        public string Pswrd { get; set; }
      


    }


    [System.Web.Services.WebMethod]
    public static string RegeneratePwd(string RegNo, string Name, string Mobile)
    {
        String Result = "0";
        try
        {
            utility objUtil = new utility();
            string DecoPwd = RandomString(8);
            string EncoPwd = objUtil.base64Encode(DecoPwd);

            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@RegNo", RegNo), new SqlParameter("@Password", EncoPwd) };
            objDu.ExecuteSql(param, "update AppMst set AppMstPassword=@Password where Appmstregno=@RegNo");

            string msgtxt = "";
            if (Name.Length > 20)
                Name = Name.Substring(0, 20).ToString();

            msgtxt = "Dear " + Name + " ID No " + RegNo + " Your  Password : " + DecoPwd;

            objUtil.sendSMSByBilling(Mobile, msgtxt, "FORGETPASSWORD");

            Result = "1";

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


    public void BindState()
    {
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTable("GetState");
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



    //public void BindState()
    //{
    //    DataUtility objDUT = new DataUtility();
    //    DataTable dt = objDUT.GetDataTable("Select id, statename from stategstmst s, ControlMst c where c.RegionId=s.Rid and c.username='" + Session["admin"].ToString() + "'");
    //    if (dt.Rows.Count > 0)
    //    {
    //        ddl_State.Items.Clear();
    //        ddl_State.DataSource = dt;
    //        ddl_State.DataTextField = "StateName";
    //        ddl_State.DataValueField = "Id";
    //        ddl_State.DataBind();
    //        ddl_State.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select State", ""));
    //        ddl_District.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select District", ""));
    //    }
    //}



    //public void BindDistrict(string value)
    //{
    //    try
    //    {
    //        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@state", value) };
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTable(param, "GetStateDistrict");
    //        if (dt.Rows.Count > 0)
    //        {
    //            ddl_District.DataSource = dt;
    //            ddl_District.Items.Clear();
    //            ddl_District.DataTextField = "DistrictName";
    //            ddl_District.DataValueField = "Id";
    //            ddl_District.DataBind();
    //            ddl_District.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select District", ""));
    //        }
    //        else
    //        {
    //            ddl_District.Items.Clear();
    //            ddl_District.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select District", ""));
    //        }
    //    }
    //    catch
    //    {
    //    }
    //}


    #endregion
}