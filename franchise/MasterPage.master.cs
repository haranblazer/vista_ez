using System;
using System.Data; 
using System.Web.UI; 
using System.Data.SqlClient;
public partial class user_MasterPage : System.Web.UI.MasterPage
{
    SqlConnection con = new SqlConnection(method.str);
    SqlDataReader sr;
    SqlCommand com;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["franchiseid"] == null)
            {
                Response.Redirect("Logout.aspx", false);
            }
            else
            {
            
                if (!IsPostBack)
                {
                    //if (Session["userId"].ToString() == "12345")
                    //    id_Menu_SalesReturn.Visible = true;


                    if (Session["franchiseid"] == null)
                        Response.Redirect("Logout.aspx", false);
                    else
                    {
                        lblUserName.Text = "(" + Session["franchiseid"].ToString() + ") " + Session["name"].ToString();
                        lblUserId.Text = Session["franchiseid"].ToString();

                        lblLeft_UserName.Text = Session["name"].ToString();
                        lblLeft_Userid.InnerText = "ID: " + Session["franchiseid"].ToString();

                        GetUserInfo();

                        GetUserBalance(Session["franchiseid"].ToString());
                    }
                }
            }
        }
        catch (Exception er) { }
    }

    private void GetUserInfo()
    {

        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(@"Select IsVendorAuth=isnull(f.IsVendorAuth,0), i.Item_Desc, 
        imagename=imagename, doe=Convert(varchar(20), f.doe, 106), f.FranType, 
	    Experience=Cast(datediff(year, f.doe, getdate()) as varchar(10)) +'.' +
	    Cast(datediff(month, f.doe, getdate())-(datediff(year, f.doe, getdate())*12) as varchar(10)) +' Years',
        IsVerified=isnull(IsVerified,0), OTP_Verify=isnull(OTP_Verify,0), 
        GST_VFYD=(Case when (isnull(GST_VFYD,0)='1' or GST_DeclDate is not null) then '1' else '0' End),
        DeclDate=(Case when f.GST_DeclDate is null then '' else convert(varchar(12), f.GST_DeclDate ,106) End),
        f.FName, f.Mobile,
        COMPANYNAME=(Select UserVal from SettingMst where Caption='COMPANYNAME'),
        COM_CINNO=(Select UserVal from SettingMst where Caption='COM_CINNO'),
        COM_ADDRESS=(Select UserVal from SettingMst where Caption='COM_ADDRESS')
        from FranchiseMst f left join Item_collection i on i.itemid=4 and f.FranType=i.UserVal where f.FranchiseId=" + Session["franchiseid"].ToString());
        if (dt.Rows[0]["IsVendorAuth"].ToString() == "1")
        {
            div_PO.Visible = true;
        }

        lbl_CompanyAddress.InnerHtml = dt.Rows[0]["COM_ADDRESS"].ToString();
        lbl_CompanyName1.InnerHtml = lbl_CompanyName.InnerHtml = dt.Rows[0]["COMPANYNAME"].ToString();
        lbl_CompanyCIN.InnerHtml = dt.Rows[0]["COM_CINNO"].ToString();

        lbl_FranType.Text = dt.Rows[0]["Item_Desc"].ToString();
        lbl_OTP_Mobile.InnerText = hnd_MobileNo.Value = dt.Rows[0]["Mobile"].ToString().Trim();

        lbl_DOJ.InnerText = dt.Rows[0]["doe"].ToString();
        lbl_Experiences.InnerText = dt.Rows[0]["Experience"].ToString();
         

        lbl_OTP_Name.InnerText = lbl_GST_FranName.InnerText = dt.Rows[0]["FName"].ToString();
        lbl_GST_Datetime.InnerText = dt.Rows[0]["DeclDate"].ToString();
        

        if (!string.IsNullOrEmpty(dt.Rows[0]["imagename"].ToString()))
        {
            if (dt.Rows[0]["imagename"].ToString() == "noimage.png")
            {
                div_FirstNameHead.Visible = true;
                div_firstname.Visible = true;
                MobProfileImg.Visible = false;
                ProfileImage.Visible = false;
                div_FirstNameHead.InnerHtml = div_firstname.InnerHtml = Session["name"].ToString().Substring(0, 1);

                MobProfileImg.ImageUrl = ProfileImage.ImageUrl = "~/images/KYC/ProfileImage/noimage.png";
            }
            else
            {
                MobProfileImg.ImageUrl = ProfileImage.ImageUrl = "~/images/KYC/ProfileImage/" + dt.Rows[0]["imagename"].ToString();
                div_FirstNameHead.Visible = false;
                div_firstname.Visible = false;
                MobProfileImg.Visible = true;
                ProfileImage.Visible = true;
            }
        }
        else
        {
            div_FirstNameHead.Visible = true;
            div_firstname.Visible = true;
            MobProfileImg.Visible = false;
            ProfileImage.Visible = false;
            div_FirstNameHead.InnerHtml = div_firstname.InnerHtml = Session["name"].ToString().Substring(0, 1);

            MobProfileImg.ImageUrl = ProfileImage.ImageUrl = "~/images/KYC/ProfileImage/noimage.png";
        }

        if (dt.Rows[0]["FranType"].ToString() == "2")
            lbl_typeImg.InnerHtml = "<img src='images/CompanyLogo.png' style='width:100%'/>";
        if (dt.Rows[0]["FranType"].ToString() == "3")
            lbl_typeImg.InnerHtml = "<img src='images/topdepot.png' style='width:100%'/>";
        else if (dt.Rows[0]["FranType"].ToString() == "4")
            lbl_typeImg.InnerHtml = "<img src='images/topcircal.png' style='width:100%'/>";
        else if(dt.Rows[0]["FranType"].ToString() == "5")
            lbl_typeImg.InnerHtml = "<img src='images/toppoint.png' style='width:100%'/>";
        else if(dt.Rows[0]["FranType"].ToString() == "6")
            lbl_typeImg.InnerHtml = "<img src='images/topshopee.png' style='width:100%'/>";


        string pageName = System.IO.Path.GetFileName(Request.Path);

       
           

        if (dt.Rows[0]["OTP_Verify"].ToString() != "1")
        {
                hnd_OTP_VFYD.Value = "0";
        }
        if (dt.Rows[0]["GST_VFYD"].ToString() != "1")
        {
                hnd_GST_VFYD.Value = "0";
        }
        if (dt.Rows[0]["FranType"].ToString() == "0")
        {
            hnd_FranType_VFYD.Value = "0";
        }
         
    }

    public void GetUserBalance(string franchiseid)
    {
        con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("getwalletBalanceFran", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@appmstid", franchiseid);
        com.Parameters.Add(new SqlParameter("@Bal", SqlDbType.Int));
        com.Parameters["@Bal"].Direction = ParameterDirection.Output;
        con.Open();
        SqlDataReader dr = com.ExecuteReader();
        lbl_Balance.Text = com.Parameters["@Bal"].Value.ToString();
         
    }


    //public void GetUserBalance(string franchiseid)
    //{
    //    con = new SqlConnection(method.str);
    //    SqlCommand com = new SqlCommand("getwalletBalanceFran", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.Parameters.AddWithValue("@appmstid", franchiseid);
    //    com.Parameters.Add(new SqlParameter("@Bal", SqlDbType.Int));
    //    com.Parameters["@Bal"].Direction = ParameterDirection.Output;
    //    con.Open();
    //    SqlDataReader dr = com.ExecuteReader();




    //}


    /*

    try
    {
        if (!IsPostBack)
            InsertFunction.CheckFranchiseLogin();
        if (Session["franchiseid"] == null || string.IsNullOrEmpty(Session["franchiseid"].ToString()))
            Response.Redirect("Default.aspx", false);
        else
        {
            string str = Convert.ToString(Session["franchiseid"]);
            con.Open();
            com = new SqlCommand("getUserMaster", con);
            com.Parameters.AddWithValue("@regno", str.Trim().ToString());
            com.CommandType = CommandType.StoredProcedure;
            sr = com.ExecuteReader();
            if (sr.Read())
            {

                string fname = sr[5].ToString() + " " + sr[1].ToString();
                string lname = sr[2].ToString();
                if (Convert.ToBoolean(sr["IsFranchise"]))
                {
                    liFranchise.Visible = true;
                }
                else
                {
                    liFranchise.Visible = false;
                }

                Label1.Text = fname;
                lblUserName.Text ="User ID: "+ Session["franchiseid"].ToString();
                con.Close();
            }
            else
            {
            }
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }
    }
    catch
    {
    }
    */


    /*
    protected void lnkbtnFranchiseTree_Click(object sender, EventArgs e)
    {
        if (Session["fPassword"] != null)
        {
            if (IsValidFranchisePwd())
            {
                Response.Redirect("FranchiseTree.aspx");
            }
            else
            {
                Session["redirectTo"] = "FT";
                Response.Redirect("FranchisePassword.aspx");
            }
        }
        else
        {
            Session["redirectTo"] = "FT";
            Response.Redirect("FranchisePassword.aspx");
        }
    }
    protected void lnkbtnFranchiseList_Click(object sender, EventArgs e)
    {       
        if (Session["fPassword"] != null)
        {            
            if (IsValidFranchisePwd())
            {
                Response.Redirect("FranchiseDownList.aspx");
            }
            else
            {
                Session["redirectTo"] = "FT";
                Response.Redirect("FranchisePassword.aspx");
            }
        }
        else
        {
            Session["redirectTo"] = "FDL";
            Response.Redirect("FranchisePassword.aspx");
        }
    }
    public Boolean IsValidFranchisePwd()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("IsValidFranchisePwd", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regNo", Convert.ToString(Session["franchiseid"]));
        com.Parameters.AddWithValue("@FranchisePwd", Convert.ToString(Session["fPassword"]));
        try
        {
            con.Open();
            SqlDataReader dr = com.ExecuteReader();
            if (dr.HasRows)
            {                
                con.Close(); con.Dispose();
                return true;
            }
            else
            {                
                con.Close(); con.Dispose();
                return false;
            }

        }
        catch
        {
            return false;

        }


    }
    public void BindData()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("geteWalletInfo", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", Convert.ToString(Session["franchiseid"]));
        try
        {
            con.Open();
            SqlDataReader dr = com.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            con.Close();
            con.Dispose();
            if (dt.Rows.Count > 0)
            {
                lblEWalletBalance.Text = dt.Rows[0][0].ToString();                
            }
            else
            {
                lblEWalletBalance.Text = "0";
                
            }
        }
        catch
        {
            con.Close();
            con.Dispose();
            Response.Redirect("~/Error.aspx");
        }
    }
   */






}
