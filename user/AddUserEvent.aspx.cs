using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_AddUserEvent : System.Web.UI.Page
{
    public static String Userid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Userid = "";
            Response.Redirect("Logout.aspx", false);
        }
        else
        {
            if (!Page.IsPostBack)
            {
                Userid = Session["userId"].ToString();
                txt_StartDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
                txt_EndDate.Text = DateTime.Now.AddYears(1).ToString("dd/MM/yyyy").Replace("-", "/");
                BindState();
            }
        }
    }

    #region BindTable

    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string Active)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Active", Active),
                new SqlParameter("@SessionUserId", HttpContext.Current.Session["userId"].ToString()),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_UserEvent");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Eid = dr["Eid"].ToString();
                data.SessionUserId = dr["SessionUserId"].ToString();
                data.E_Type = dr["E_Type"].ToString();
                data.StartDate = dr["StartDate"].ToString();
                data.EndDate = dr["EndDate"].ToString();
                data.VenueName = dr["VenueName"].ToString();
                data.VenueAddress = dr["VenueAddress"].ToString();
                data.City = dr["City"].ToString();
                data.PINCode = dr["PINCode"].ToString();
                data.District = dr["District"].ToString();
                data.State = dr["State"].ToString();
                data.Speakers = dr["Speakers"].ToString();
                data.Speakers1 = dr["Speakers1"].ToString();
                data.Speakers2 = dr["Speakers2"].ToString();
                data.FeeCharged = dr["FeeCharged"].ToString();
                data.ContactPersonsName = dr["ContactPersonsName"].ToString();
                data.ContactPersonsMobile = dr["ContactPersonsMobile"].ToString();
                data.Status1 = dr["Status1"].ToString();
                data.Img1 = dr["Img1"].ToString();
                data.Img2 = dr["Img2"].ToString();
                data.Img3 = dr["Img3"].ToString();
                data.Img4 = dr["Img4"].ToString();
                data.Img5 = dr["Img5"].ToString();
                data.Status2 = dr["Status2"].ToString();
                data.Doe = dr["Doe"].ToString(); 
                data.Remark = dr["Remark"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string Eid { get; set; }
        public string SessionUserId { get; set; }
        public string E_Type { get; set; }
        public string StartDate { get; set; }
        public string S_HOUR { get; set; }
        public string S_MINUTE { get; set; }
        public string EndDate { get; set; }
        public string E_HOUR { get; set; }
        public string E_MINUTE { get; set; }
        public string VenueName { get; set; }
        public string VenueAddress { get; set; }
        public string City { get; set; }
        public string PINCode { get; set; }
        public string District { get; set; }
        public string State { get; set; }
        public string Speakers { get; set; }
        public string Speakers1 { get; set; }
        public string Speakers2 { get; set; }
        public string FeeCharged { get; set; }
        public string ContactPersonsName { get; set; }
        public string ContactPersonsMobile { get; set; }
        public string Status1 { get; set; }
        public string Img1 { get; set; }
        public string Img2 { get; set; }
        public string Img3 { get; set; }
        public string Img4 { get; set; }
        public string Img5 { get; set; }
        public string Status2 { get; set; }
        public string Doe { get; set; }
         public string Remark { get; set; }
    }


    [System.Web.Services.WebMethod]
    public static string Save(string Eid, string E_Type, string StartDate, string EndDate,
    string VenueName, string VenueAddress, string City, string PINCode,
    string District, string State, string Speakers, string Speakers1, string Speakers2,
    string FeeCharged, string ContactPersonsName,
    string ContactPersonsMobile)
    {
        string Result = "0";
        if (string.IsNullOrEmpty(FeeCharged))
        {
            FeeCharged = "0";
        }

        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter outparam = new SqlParameter("@intResult", System.Data.SqlDbType.VarChar, 100);
            outparam.Direction = System.Data.ParameterDirection.Output;
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Eid", Eid),
                new SqlParameter("@SessionUserId", HttpContext.Current.Session["userId"].ToString()),
                new SqlParameter("@E_Type", E_Type),
                new SqlParameter("@StartDate", StartDate),
                new SqlParameter("@EndDate", EndDate),
                new SqlParameter("@VenueName", VenueName),
                new SqlParameter("@VenueAddress", VenueAddress),
                new SqlParameter("@City", City),
                new SqlParameter("@PINCode", PINCode),
                new SqlParameter("@District", District),
                new SqlParameter("@State", State),
                new SqlParameter("@Speakers", Speakers),
                new SqlParameter("@Speakers1", Speakers1),
                new SqlParameter("@Speakers2", Speakers2),
                new SqlParameter("@FeeCharged", FeeCharged),
                new SqlParameter("@ContactPersonsName", ContactPersonsName),
                new SqlParameter("@ContactPersonsMobile", ContactPersonsMobile),
                new SqlParameter("@Img1", ""),
                new SqlParameter("@Img2", ""),
                new SqlParameter("@Img3", ""),
                new SqlParameter("@Img4", ""),
                new SqlParameter("@Img5", ""),
                outparam
            };
            Result = objDu.ExecuteSqlSP(param, "Add_UserEvent").ToString();


        }
        catch (Exception er) { Result = er.Message; }
        return Result;
    }


    [System.Web.Services.WebMethod]
    public static UserDetails[] GetDetail(string Eid)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@Eid", Eid) };
            SqlDataReader dr = objDu.GetDataReader(param, @"Select ue.Eid, ue.SessionUserId, ue.E_Type, 
            StartDate=convert(varchar, ue.StartDate, 103), 
            S_HOUR=DATEPART(HOUR, StartDate), 
            S_MINUTE=DATEPART(MINUTE, StartDate),
            EndDate=convert(varchar, ue.EndDate, 103), 
            E_HOUR=DATEPART(HOUR, EndDate), 
            E_MINUTE=DATEPART(MINUTE, EndDate),
            ue.VenueName, ue.VenueAddress, ue.City, ue.PINCode, ue.District,
            State=(Select ID from stategstmst where Statename=ue.State), ue.Speakers, ue.Speakers1, ue.Speakers2, ue.FeeCharged, ue.ContactPersonsName, ue.ContactPersonsMobile,
            ue.Status1, ue.Img1, ue.Img2, ue.Img3, ue.Img4, ue.Img5, ue.Status2
            from tbl_UserEvent ue where ue.Eid=@Eid");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Eid = dr["Eid"].ToString();
                data.SessionUserId = dr["SessionUserId"].ToString();
                data.E_Type = dr["E_Type"].ToString();
                data.StartDate = dr["StartDate"].ToString();
                if (dr["S_HOUR"].ToString().Length == 1)
                    data.S_HOUR = "0" + dr["S_HOUR"].ToString();
                else
                    data.S_HOUR = dr["S_HOUR"].ToString();

                if (dr["S_MINUTE"].ToString().Length == 1)
                    data.S_MINUTE = "0" + dr["S_MINUTE"].ToString();
                else
                    data.S_MINUTE = dr["S_MINUTE"].ToString();


                data.EndDate = dr["EndDate"].ToString();
                if (dr["E_HOUR"].ToString().Length == 1)
                    data.E_HOUR = "0" + dr["E_HOUR"].ToString();
                else
                    data.E_HOUR = dr["E_HOUR"].ToString();

                if (dr["E_MINUTE"].ToString().Length == 1)
                    data.E_MINUTE = "0" + dr["E_MINUTE"].ToString();
                else
                    data.E_MINUTE = dr["E_MINUTE"].ToString();

                data.VenueName = dr["VenueName"].ToString();
                data.VenueAddress = dr["VenueAddress"].ToString();
                data.City = dr["City"].ToString();
                data.PINCode = dr["PINCode"].ToString();
                data.District = dr["District"].ToString();
                data.State = dr["State"].ToString();
                data.Speakers = dr["Speakers"].ToString();
                data.Speakers1 = dr["Speakers1"].ToString();
                data.Speakers2 = dr["Speakers2"].ToString();

                data.FeeCharged = dr["FeeCharged"].ToString();
                data.ContactPersonsName = dr["ContactPersonsName"].ToString();
                data.ContactPersonsMobile = dr["ContactPersonsMobile"].ToString();
                data.Status1 = dr["Status1"].ToString();
                data.Img1 = dr["Img1"].ToString();
                data.Img2 = dr["Img2"].ToString();
                data.Img3 = dr["Img3"].ToString();
                data.Img4 = dr["Img4"].ToString();
                data.Img5 = dr["Img5"].ToString();
                data.Status2 = dr["Status2"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    private void BindState()
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
            ddl_State.Items.Insert(0, new ListItem("Select State", ""));
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