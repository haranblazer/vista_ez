using System;
using System.Collections.Generic;
using System.Data.SqlClient; 
public partial class User_UpcomingEvents : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        { 
            Response.Redirect("Logout.aspx", false);
        } 
    }

    #region BindTable 
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Active", "1"),
                new SqlParameter("@SessionUserId", ""),
                new SqlParameter("@UpComingEvent", "1") 
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_UserEvent");
            while (dr.Read())
            {
                if (dr["Status1"].ToString() == "1")
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
                    details.Add(data);
                }
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
    }
     
    #endregion
}