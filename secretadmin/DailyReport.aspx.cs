using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Collections;
using System.Xml.Linq;

public partial class secretadmin_DailyReport : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlDataAdapter sda = null;
    SqlCommand com = null;
   
    protected void Page_Load(object sender, EventArgs e)
    {

        try
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
                txtFromDate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-","/");
                txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");
                sellerlist();
              //  BindGrid();
            }
        }
        catch
        {

        }
        

    }

    //private void BindGrid()
    //{
    //    try
    //    {
    //        dt = null;
    //        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //        dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //        //string strmin = "";
    //        //string strmax = "";
    //        //try
    //        //{
    //        //    if (txtFromDate.Text.Trim().Length > 0)
    //        //        strmin =
    //        //        Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo).ToString();
    //        //    if (txtToDate.Text.Trim().Length > 0)
    //        //        strmax = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo).ToString();
    //        //}
    //        //catch
    //        //{
    //        //    utility.MessageBox(this, "Invalid date entry.");
    //        //    return;
    //        //}


    //        string fromDate = "", toDate = "";
    //        try
    //        {
    //            if (txtFromDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //            if (txtToDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid date entry.");
    //            return;
    //        }

    //        double datedays = (Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo) - Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo)).TotalDays;
    //        if (datedays > 31)
    //        {
    //            utility.MessageBox(this, "Maximum 31 days allowed");
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //            return;
    //        }

    //        con = new SqlConnection(method.str);
    //        SqlDataAdapter ad = new SqlDataAdapter("totalsell", con);
    //        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        ad.SelectCommand.Parameters.AddWithValue("@regno",ddlseller.SelectedValue.ToString());
    //        ad.SelectCommand.Parameters.AddWithValue("@min", fromDate);
    //        ad.SelectCommand.Parameters.AddWithValue("@max", toDate);          
    //        dt = new DataTable();
           
    //        ad.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {
    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();
    //        }

    //        else
    //        {
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //        }
    //    }

    //    catch
    //    {
    //    }
    //}



    public void sellerlist()
    {

        con = new SqlConnection(method.str);
        sda = new SqlDataAdapter("sellerlist", con);
        sda.SelectCommand.CommandType = CommandType.StoredProcedure;
        dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlseller.DataTextField = "name";
            ddlseller.DataValueField = "id";
            ddlseller.DataSource = dt;
            ddlseller.DataBind();
            ddlseller.Items.Insert(0, new ListItem("All", "0"));
        }

        else
        {
            ddlseller.Items.Insert(0, new ListItem("All", "0"));

        }



        //List<SellerList> list = new List<SellerList>();
        //sl = new SellerList();
        //var ab = from p in dt.AsEnumerable() select p;
        //foreach (var val in ab)
        //{

        //    sl.userid = val["id"].ToString();
        //    sl.username = val["name"].ToString();
        //    list.Add(sl);
        //}

        //return list;
    }


    //public void bindseller()
    //{
    //    ddlseller.DataSource = sellerlist();
    //    ddlseller.DataBind();
    //    ddlseller.DataTextField = "name";
    //    ddlseller.DataValueField = "id";
    //    ddlseller.Items.Insert(0, new ListItem("select", "0"));
    //}

       


//        Dictionary<int, Actor> actors = new Dictionary<int, Actor>{
//    {
//        1,new Actor
//        {
//            ActorId = 1,
//            ActorName= "Rajanikant",
//            BirthDate =DateTime.Parse("12-12-1949"), 
//            BirthPlace ="Bangalore", 
//            Photo ="~/Images/1.jpg", 
//            Movies = new List<string>{"Shivaji (2007)","Baba (2002)","ChaalBaaz (1989)"}
//        }
//    },                 
//    {
//        2,new Actor
//        {
//            ActorId = 2,
//            ActorName= "Jennifer Aniston", 
//            BirthDate =DateTime.Parse("11-2-1969"), 
//            BirthPlace ="Sherman Oaks", 
//            Photo ="~/Images/2.jpg", 
//            Movies=new List<string>{"Friends (1994)","Bruce Almighty (2003)","Just Go with It (2011)"}
//        }
//    }, 
//};
        //List<KeyValuePair<string, string>> d = new List<KeyValuePair<string, string>>();
        //d.Add(new KeyValuePair<string, string>("1", "2323"));
        //d.Add(new KeyValuePair<string, string>("2", "1112323"));

        //GridView1.DataSource = d;
        //GridView1.DataBind();

    
    //public class SellerList
    //{
    //    public string userid
    //    {
    //        get;
    //        set;
    //    }

    //    public string username
    //    {
    //        get;
    //        set;
    //    }
    //}
    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    BindGrid();
    //}
    //protected void ddlseller_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //BindGrid();
    //}
    protected void btnSearch_Click(object sender, EventArgs e)
    {
      //  BindGrid();
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string Seller)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
           // string fromDate = "", toDate = "";
                  
                     if (min.Trim().Length > 0)
                      {
                          String[] Date = min.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                          min = Date[1] + "/" + Date[0] + "/" + Date[2];
                      }
                      if (max.Trim().Length > 0)
                      {
                          String[] Date = max.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                          max = Date[1] + "/" + Date[0] + "/" + Date[2];
                     }
                  
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@regno", Seller),
            };
      
            SqlDataReader dr = objDu.GetDataReaderSP(param,"totalsell");
            utility objutil = new utility();
            while (dr.Read())
            {
                
                UserDetails data = new UserDetails();
                data.UserId = dr["regno"].ToString();
                data.Name = dr["Name"].ToString();
                data.Amount = dr["net"].ToString();
               
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        
        public string UserId { get; set; }
        public string Name { get; set; }
        public string Amount { get; set; }
        
    }

    #endregion
}




