using System;
using System.Data; 
using System.Web; 
using System.Web.UI;
using System.Web.UI.WebControls; 
using System.Data.SqlClient;
using System.Linq;
using System.Collections.Generic;

public partial class secretadmin_BDM_Associates : System.Web.UI.Page
{
    DataTable t1 = new DataTable();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    utility u = new utility();
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
            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");

            BindState();

            //BindUserList();
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string regno, string AppMstFName, string AppMstMobile, string District
        , string AppMstCity, string AppMstState, string panno, string IsPaid, string IsActive, string IsTopper)
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
               new SqlParameter("@AppMstMobile", AppMstMobile),
               new SqlParameter("@District", District),
               new SqlParameter("@AppMstCity", AppMstCity),
               new SqlParameter("@AppMstState", AppMstState),
               new SqlParameter("@panno", panno),
               new SqlParameter("@IsPaid", IsPaid),
               new SqlParameter("@IsActive", IsActive),
               new SqlParameter("@IsTopper", IsTopper),
               new SqlParameter("@Adminid", HttpContext.Current.Session["admin"].ToString())
           };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "SearchListMember3");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.RegNo = dr["RegNo"].ToString();
                data.User_ID = dr["User ID"].ToString();
                data.User_Name = dr["User Name"].ToString();
                data.Sponsor_ID = dr["Sponsor ID"].ToString();
                data.Sponsor_Name = dr["Sponsor Name"].ToString();
                data.User_Mobile_No = dr["User Mobile No"].ToString();
                data.User_Email_Id = dr["User Email Id"].ToString();
                data.User_District = dr["User District"].ToString();
                data.User_State = dr["User State"].ToString();
                data.Paid_Status = dr["Paid Status"].ToString();
                data.Topper_Status = dr["Topper Status"].ToString();
                data.ID_Status = dr["ID Status"].ToString();
                data.Profit_Level = dr["Profit Level"].ToString();
                data.Generation_PIN = dr["Generation PIN"].ToString();
                data.Topper_PIN = dr["Topper PIN"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string RegNo { get; set; }
        public string User_ID { get; set; }
        public string User_Name { get; set; }
        public string Sponsor_ID { get; set; }
        public string Sponsor_Name { get; set; }
        public string User_Mobile_No { get; set; }
        public string User_Email_Id { get; set; }
        public string User_District { get; set; }
        public string User_State { get; set; }
        public string Paid_Status { get; set; }
        public string Topper_Status { get; set; }
        public string ID_Status { get; set; }
        public string Profit_Level { get; set; }
        public string Generation_PIN { get; set; }
        public string Topper_PIN { get; set; }
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



    public void BindState()
    {
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTable("Select id, statename from stategstmst s, ControlMst c where c.RegionId=s.Rid and c.username='" + Session["admin"].ToString() + "'");
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


    protected void ddl_State_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BindDistrict(ddl_State.SelectedValue);
        }
        catch
        {

        }
    }
    public void BindDistrict(string value)
    {
        try
        { 
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@state", value) };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "GetStateDistrict");
            if (dt.Rows.Count > 0)
            {
                ddl_District.DataSource = dt;
                ddl_District.Items.Clear();
                ddl_District.DataTextField = "DistrictName";
                ddl_District.DataValueField = "Id";
                ddl_District.DataBind();
                ddl_District.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select District", ""));
            }
            else
            {
                ddl_District.Items.Clear();
                ddl_District.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select District", ""));
            }
        }
        catch
        {
        }
    }


    #endregion



    //public void BindUserList()
    //{
    //    try
    //    {
    //        String fromDate = "", toDate = "";
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
    //            utility.MessageBox(this, "Invalid date entry2.");
    //            return;
    //        }

    //        string State = "", District = "";
    //        if (ddl_State.SelectedValue != "")
    //            State = ddl_State.SelectedItem.ToString();

    //        if (ddl_District.SelectedValue != "")
    //            District = ddl_District.SelectedItem.ToString();

    //        SqlParameter[] param = new SqlParameter[]
    //        {
    //            new SqlParameter("@FromDate", fromDate),
    //            new SqlParameter("@ToDate", toDate),
    //            new SqlParameter("@regno", txtid.Text.Trim()),
    //            new SqlParameter("@AppMstFName", txtfname.Text.Trim()),
    //            new SqlParameter("@AppMstMobile", txtMobileNo.Text.Trim()),
    //            new SqlParameter("@District", District),
    //            new SqlParameter("@AppMstCity", txtcity.Text.Trim()),
    //            new SqlParameter("@AppMstState", State),
    //            new SqlParameter("@panno", txtPan.Text.Trim()),
    //            new SqlParameter("@IsPaid", ddl_PaidUnpaid.SelectedValue),
    //            new SqlParameter("@IsActive", ddl_Active.SelectedValue),
    //            new SqlParameter("@IsTopper", ddl_IsTopper.SelectedValue),
    //            new SqlParameter("@Adminid", Session["admin"].ToString())
    //        };
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTableSP(param, "SearchListMember3");
    //        if (dt.Rows.Count > 0)
    //        {
    //            dglst.DataSource = dt;
    //            dglst.DataBind();
    //        }
    //        else
    //        {
    //            dglst.DataSource = null;
    //            dglst.DataBind();
    //        }
    //    }
    //    catch (Exception er)
    //    {
    //    }

    //}
    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    BindUserList();
    //}
    //protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    dglst.PageIndex = e.NewPageIndex;
    //    BindUserList();
    //}

    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}

    //private static Random random = new Random();
    //public static string RandomString(int length)
    //{
    //    const string chars = "abcdefghijklmnpqrstuvwxyz123456789";
    //    return new string(Enumerable.Repeat(chars, length)
    //      .Select(s => s[random.Next(s.Length)]).ToArray());
    //}

    //protected void dglst_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    GridViewRow row = dglst.Rows[Convert.ToInt32(e.CommandArgument)];
    //    if (e.CommandName.Equals("RegeneratePwd"))
    //    {
    //        utility objUtil = new utility();
    //        string EncPwd = objUtil.base64Encode(RandomString(8));
    //        con = new SqlConnection(method.str);
    //        SqlCommand cmd = new SqlCommand("update Appmst set AppMstPassword=@Password where Appmstid=@Appmstid", con);
    //        cmd.CommandType = CommandType.Text;
    //        cmd.CommandTimeout = 99999;
    //        cmd.Parameters.AddWithValue("@Appmstid", dglst.DataKeys[row.RowIndex].Values[0].ToString());
    //        cmd.Parameters.AddWithValue("@Password", EncPwd);
    //        con.Open();
    //        cmd.ExecuteNonQuery();
    //        con.Close();
    //    }
    //}

    //public void BindState()
    //{
    //    DataUtility objDUT = new DataUtility();
    //    DataTable dt = new DataTable();
    //    dt = objDUT.GetDataTable("Select id, statename from stategstmst s, ControlMst c where c.RegionId=s.Rid and c.username='" + Session["admin"].ToString() + "'");
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
    //protected void ddl_State_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        BindDistrict(ddl_State.SelectedValue);
    //    }
    //    catch
    //    {

    //    }
    //}
    //public void BindDistrict(string value)
    //{
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        SqlCommand cmd = new SqlCommand("GetStateDistrict", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@state", value);
    //        SqlDataAdapter da = new SqlDataAdapter(cmd);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
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

    


    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dglst.Rows.Count > 0)
    //    {
    //        dglst.AllowPaging = false;
    //        BindUserList();
    //        Response.Clear();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Associateslist.xls");
    //        Response.Charset = "";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        dglst.RenderControl(htmlWrite);
    //        Response.Write(stringWrite.ToString());
    //        Response.End();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Can't export as no data found.");
    //    }
    //}
    //protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dglst.Rows.Count > 0)
    //    {
    //        dglst.AllowPaging = false;
    //        BindUserList();
    //        Response.Clear();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_paidlist.doc");
    //        Response.Charset = "";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        dglst.RenderControl(htmlWrite);
    //        Response.Write(stringWrite.ToString());
    //        Response.End();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Can't export as no data found.");
    //    }
    //}
}