using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Linq;


public partial class mumbaiadmin_MasterPage : MasterPage
{

    DataTable dt = null;
    //SqlDataReader sdr;
    //SqlConnection con = null;
    //SqlCommand cmd;
    protected string company=method.COMP_NAME;
    protected void Page_Init(object sender, EventArgs e)
    { 
        if (Session["admin"] == null)
            Response.Redirect("logout.aspx", false);
        else
        {
            if (utility.CheckAdminloginInside() == "a")
            {
                if (!IsPostBack) 
                    ShowOptions(Request.Url.Segments.Last());
            } 
        }
    }

   

    protected void lnkPinTypeZero_Click(object sender, EventArgs e)
    {
        Session["ypin"] = 1;
        Response.Redirect("NewJoin1.aspx", false);
    }

    protected void Page_Load(object sender, EventArgs e)
    { 
        saveAdminLogInInfo();
        Session["UserHasVisitedThisPageBefore"] = null;

    }

    private void ShowOptions(string url)
    {
        GetPagePermission(Session["admin"].ToString());
        //Check direct url call permitted
        if (Request.QueryString.Count == 0 && string.Compare(url, "Welcome.aspx", true) != 0 && (dt == null || dt.AsEnumerable().Where(o => o.Field<string>("pagename").ToLower() == url.ToLower()).FirstOrDefault() == null || dt.AsEnumerable().Where(o => o.Field<string>("pagename").ToLower() == url.ToLower() && o.Field<int>("permission") == 1).Count() < 1))
        {
            if (url == "ScanCode.aspx" || url == "ScanCodeNew.aspx" || url == "AddPromotionAmt.aspx" || url == "AddExtraPV.aspx")
            {

            }
            else
            {
                Response.Redirect("Adminlog.aspx", false);
                return;
            }
        }
        // Check direct url call permitted
        else
        {
            foreach (HtmlGenericControl tabDiv in divmain.Controls.Cast<Control>().Where(o => o is HtmlGenericControl))
            {
                //CheckBoxList chkList = this.FindControl(tabDiv.ID) == null ? null : (CheckBoxList)Master.FindControl("ContentPlaceHolder1").FindControl(tabDiv.ID);
                foreach (HtmlAnchor Anchor in tabDiv.Controls.Cast<Control>().Where(o => o is HtmlAnchor))
                {
                    // value is made lower
                    Anchor.Visible = dt == null ? false : (dt.AsEnumerable().Where(o => o.Field<string>("pagename").ToLower() == Anchor.HRef.ToLower()).FirstOrDefault() == null ? false : (dt.AsEnumerable().Where(o => o.Field<string>("pagename").ToLower() == Anchor.HRef.ToLower() && o.Field<int>("permission") == 1).Count() > 0 ? true : false));
                }
                //check if all links have visible false then , hide then hide its heading div
                if (tabDiv.Controls.Cast<Control>().Where(o => o is HtmlAnchor && o.Visible == true).Count() > 0)
                    tabDiv.Visible = true;
                else
                    tabDiv.Visible = false;
            }
        }
    }

    private void GetPagePermission(string uid)
    {
        try
        {
            DataUtility objdu = new DataUtility();
            SqlParameter[] sp = new SqlParameter[] { new SqlParameter("@userid", uid) }; 
            SqlDataReader dr = objdu.GetDataReader(sp, "Select userid,pagename,permission from pagepermissions where userid=@userid");
            while (dr.Read())
            {
                SavePagePermissions(dr["pagename"].ToString(), Convert.ToInt32(dr["permission"]));
            }



            //con = new SqlConnection(method.str);
            //cmd = new SqlCommand("select userid,pagename,permission from pagepermissions where userid=@userid", con);
            //cmd.Parameters.AddWithValue("@userid", uid);
            //con.Open();
            //sdr = cmd.ExecuteReader();
            //if (sdr.HasRows)
            //{
            //    while (sdr.Read())
            //    {
            //        SavePagePermissions(sdr["pagename"].ToString(), Convert.ToInt32(sdr["permission"]));
            //    }
            //}
            //con.Close();

        }
        catch
        {
        }
    }

    public void SavePagePermissions(string pagename, int permission)
    {
        if (dt == null)
        {
            dt = new DataTable();
            DataColumn dc1 = new DataColumn("userid", typeof(string));
            DataColumn dc2 = new DataColumn("pagename", typeof(string));
            DataColumn dc3 = new DataColumn("permission", typeof(int));
            dt.Columns.Add(dc1);
            dt.Columns.Add(dc2);
            dt.Columns.Add(dc3);
        }
        DataRow row = dt.NewRow();
        row["userid"] = Session["admin"].ToString();
        row["pagename"] = pagename.Trim();
        row["permission"] = permission;
        dt.Rows.Add(row);
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        if (Session["admin"] != null)
        {
            saveAdminLogInInfo();
        }
        Session["admin"] = null;
        Response.Redirect("adminLog.aspx");
    }
    public void saveAdminLogInInfo()
    {
        try
        {
            SqlParameter[] param = new SqlParameter[]
            { new SqlParameter("@id",Session["ipid"])};
            DataUtility objDu = new DataUtility();
            objDu.ExecuteSql(param, "Update admincontrol set logouttime=DATEADD(minute,330,getutcdate()) where srno=@id");



            //SqlConnection con = new SqlConnection(method.str);
            //if (con.State == ConnectionState.Open)
            //{
            //    con.Close();
            //}
            //SqlCommand com = new SqlCommand("update admincontrol set logouttime=DATEADD(minute,330,getutcdate()) where srno=@id", con);
            //com.CommandTimeout = 999999999;
            ////com.CommandType = CommandType.StoredProcedure;
            //com.Parameters.AddWithValue("@id", Session["ipid"]);
            ////com.Parameters.AddWithValue("@ip", GetIP());
            //con.Open();
            //com.ExecuteNonQuery();
            //con.Close();
        }
        catch (Exception ex)
        {
        }
    }

    //private string GetIP()
    //{
    //    string strHostName = "";
    //    strHostName = System.Net.Dns.GetHostName();
    //    IPHostEntry ipEntry = System.Net.Dns.GetHostByName(strHostName);
    //    IPAddress[] addr = ipEntry.AddressList;
    //    return addr[addr.Length - 1].ToString();
    //}



    //public void saveAdminLogInInfo()
    //{
    //    try
    //    {
    //        SqlConnection con = new SqlConnection(method.str);
    //        if (con.State == ConnectionState.Open)
    //        {
    //            con.Close();
    //        }
    //        SqlCommand com = new SqlCommand("update admincontrol set logouttime=DATEADD(minute,330,getutcdate()) where srno=(select top 1 srno from admincontrol where isnull(logouttime,'')='' and UserName=@uname and IPAddress=@ip and datediff(minute,[date],dateadd(minute,330,getutcdate()))<=60 order by [date] desc) ", con);
    //        com.CommandTimeout = 999999999;
    //        //com.CommandType = CommandType.StoredProcedure         
    //        com.Parameters.AddWithValue("@ip", Session["ipid"].ToString());
    //        con.Open();
    //        com.ExecuteNonQuery();
    //        con.Close();
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}
}