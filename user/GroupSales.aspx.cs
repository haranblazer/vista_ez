using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;

public partial class user_GroupSales : System.Web.UI.Page
{
   public static string UrlLink = "", Userid="";
    Validation val = new Validation();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        if (!IsPostBack)
        {
            HttpContext.Current.Session["Refdt_GS"] = null;
            txtFromDate.Text = DateTime.Now.Date.AddDays(-1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

            Session["DownlineUser"] = null;
            Session["DownlineUser"] = Userid= Session["userId"].ToString();

            GetRank();
            //go();

        }

    }


    #region Bind Binary Downline
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindRepurchase(string rank, string paid, string Userid)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            string regno = "";
            if (HttpContext.Current.Session["DownlineUser"] == null)
                regno = HttpContext.Current.Session["userId"].ToString();
            else
                regno = HttpContext.Current.Session["DownlineUser"].ToString();

            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@regno", regno),
                   new SqlParameter("@rank", rank),
                   new SqlParameter("@paid", paid)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "groupline");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Img_Name = dr["Img_Name"].ToString();
                data.status = dr["status"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.UserId = dr["UserId"].ToString();
                data.SponsorId = dr["SponsorId"].ToString();
                data.SponsorName = dr["SponsorName"].ToString();
                data.PBV = dr["PBV"].ToString();
                data.GBV = dr["GBV"].ToString();
                data.TPV = dr["TPV"].ToString();
                data.TotalGBV = dr["TotalGBV"].ToString();
                data.OLDPBV = dr["OLDPBV"].ToString();
                data.OLDGBV = dr["OLDGBV"].ToString();
                data.OLDTVP = dr["OLDTVP"].ToString();
                data.CumulativeGBVPV = dr["CumulativeGBVPV"].ToString();
                data.RankName = dr["RankName"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static string SetUserid(string Userid, string Type)
    {
        string Msg = "";
        if (Type == "Status")
        {
            HttpContext.Current.Session["DownlineUser"] = Userid;
        }
        else if (Type == "GOUP")
        {
            HttpContext.Current.Session["DownlineUser"] = HttpContext.Current.Session["userId"].ToString();
        }
        else if (Type == "Downline")
        {
            if (Userid != "")
            {
                SqlParameter[] param = new SqlParameter[]
                {
                    new SqlParameter("@Userid", HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@Downline", Userid)
                };
                DataUtility objDu = new DataUtility();
                DataTable dt = objDu.GetDataTableSP(param, "IsChildExistsSponsor");
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["Msg"].ToString() == "1")
                        HttpContext.Current.Session["DownlineUser"] = Userid;
                    else
                        Msg = "This user not in your downline.!!";
                }
                else
                {
                    Msg = "This user not in your downline.!!";
                }
            }
        }
        StoreUser(Userid);
        return Msg;
    }


    public class UserDetails
    {
        public string Img_Name { get; set; }
        public string status { get; set; }
        public string UserName { get; set; }
        public string UserId { get; set; }
        public string SponsorId { get; set; }
        public string SponsorName { get; set; }
        public string PBV { get; set; }
        public string GBV { get; set; }
        public string TPV { get; set; }
        public string TotalGBV { get; set; }

        public string OLDPBV { get; set; }
        public string OLDGBV { get; set; }
        public string OLDTVP { get; set; }
        public string CumulativeGBVPV { get; set; }
        public string RankName { get; set; }
    }

    #endregion





    [System.Web.Services.WebMethod]
    public static StoreUserid[] StoreUser(string Userid)
    {
        List<StoreUserid> details = new List<StoreUserid>();
        try
        {
            if (HttpContext.Current.Session["Refdt_GS"] == null)
                CreateStucture();

            DataTable Refdt_GS = (DataTable)HttpContext.Current.Session["Refdt_GS"];

            if (Userid != "")
            {
                int Sno = 1;
                if (Refdt_GS.Select("Userid='" + Userid + "'").FirstOrDefault() == null)
                {
                    if (Refdt_GS.Rows.Count > 0)
                        Sno = 1 + Convert.ToInt32(Refdt_GS.AsEnumerable().Max(row => row["Sno"]));

                    DataRow dr = Refdt_GS.NewRow();

                    dr["Sno"] = Sno;
                    dr["Userid"] = Userid;

                    Refdt_GS.Rows.Add(dr);
                    HttpContext.Current.Session["Refdt_GS"] = Refdt_GS;
                }
                else
                {
                    DataRow findrow = Refdt_GS.Select("Userid='" + Userid + "'").FirstOrDefault();
                    Sno = findrow == null ? 0 : findrow.Field<int>("Sno");

                    DataTable newTable = Refdt_GS.Copy();

                    foreach (DataRow dr in newTable.Rows)
                    {
                        if (Convert.ToInt32(dr["Sno"].ToString()) > Sno)
                        {
                            DataRow findNewrow = Refdt_GS.Select("Sno='" + dr["Sno"].ToString() + "'").FirstOrDefault();
                            findNewrow.Delete();
                        }
                    }
                    HttpContext.Current.Session["Refdt_GS"] = Refdt_GS;
                }
            }


            DataView view = Refdt_GS.DefaultView;
            view.Sort = "Sno Asc";
            DataTable dt_Sorted = view.ToTable();

            foreach (DataRow dr in dt_Sorted.Rows)
            {
                if (!string.IsNullOrEmpty(dr["Userid"].ToString()))
                {
                    StoreUserid data = new StoreUserid();
                    data.Userid = dr["Userid"].ToString();
                    details.Add(data);
                }
            }
        }

        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static string Back()
    {
        string Result = "";
        try
        {
            if (HttpContext.Current.Session["Refdt_GS"] == null)
                CreateStucture();
            int Sno = 0;
            DataTable Refdt_GS = (DataTable)HttpContext.Current.Session["Refdt_GS"];
            if (Refdt_GS.Rows.Count > 0)
            {
                Sno = Convert.ToInt32(Refdt_GS.AsEnumerable().Max(row => row["Sno"]));
                DataRow findNewrow = Refdt_GS.Select("Sno='" + Sno.ToString() + "'").FirstOrDefault();
                findNewrow.Delete();
                HttpContext.Current.Session["Refdt_GS"] = Refdt_GS;
                Sno = 0;
                if (Refdt_GS.Rows.Count > 0)
                {
                    Sno = Convert.ToInt32(Refdt_GS.AsEnumerable().Max(row => row["Sno"]));
                    DataRow findrow = Refdt_GS.Select("Sno='" + Sno + "'").FirstOrDefault();
                    Result = findrow == null ? "" : findrow.Field<string>("Userid");
                }
                else
                {
                    Result = HttpContext.Current.Session["userId"].ToString();
                }
            }
            else
            {
                Result = HttpContext.Current.Session["userId"].ToString();
            }
        }
        catch (Exception er) { }
        return Result;
    }



    public class StoreUserid
    {
        public string Userid { get; set; }
    }

    private static void CreateStucture()
    {
        DataTable dtStuc = new DataTable();
        dtStuc.Columns.Add(new DataColumn("Sno", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("Userid", typeof(string)));
        HttpContext.Current.Session["Refdt_GS"] = dtStuc;
    }



    private void GetRank()
    {
        DataUtility objDu = new DataUtility();

        DataTable dt = objDu.GetDataTable("Select Rankid, RankName=RankName from RePurchase_Slab");
        ddl_Rank.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddl_Rank.DataSource = dt;
            ddl_Rank.DataTextField = "RankName";
            ddl_Rank.DataValueField = "Rankid";
            ddl_Rank.DataBind();
            ddl_Rank.Items.Insert(0, new ListItem("Direct", "0"));
        }
        else
        {
            ddl_Rank.Items.Insert(0, new ListItem("Direct", "0"));
        }

    }



}
