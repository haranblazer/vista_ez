using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;

public partial class member_member : System.Web.UI.MasterPage
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
    public string LastDateForLogout = "0";
    protected string company;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["MemberId"] != null)
        {

            if (!Page.IsPostBack)
            {
                var now = DateTime.Now.AddDays(0); 
                var CurrentDate = new DateTime(now.Year, now.Month, now.Day, 00, 00, 00);
                var LastDate = new DateTime(now.Year, now.Month, DateTime.DaysInMonth(now.Year, now.Month), 00, 00, 00);
                if (CurrentDate == LastDate)
                    LastDateForLogout = "1";
                
                

                BindData();
                // getCompName();

                //cmd = new SqlCommand("select appmstid from appmst where appmstregno=@regno", con);
                //cmd.CommandType = CommandType.Text;
                //con.Open();
                //cmd.Parameters.AddWithValue("@regno", Session["userId"].ToString());
                //da = new SqlDataAdapter(cmd);
                //dt = new DataTable();
                //da.Fill(dt);
                //if (dt.Rows.Count > 0)
                //{
                //    hfappmstid.Text = dt.Rows[0]["appmstid"].ToString();
                //}
            }
        }
        else
        {
            Response.Redirect("Logout.aspx", false);
        }

    }

    //public void getCompName()
    //{
    //    SqlCommand com;
    //    con = new SqlConnection(method.str);
    //    com = new SqlCommand("companydetails", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    SqlDataAdapter adp = new SqlDataAdapter(com);
    //    DataTable dt = new DataTable();
    //    adp.Fill(dt);
    //    if (dt.Rows.Count > 0)
    //    {
    //        company = dt.Rows[0]["companyname"].ToString();
    //    }
    //}

    public void BindData()
    {
        try
        {
            cmd = new SqlCommand("GetProfileData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@regno", Session["MemberId"].ToString());
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                company = dt.Rows[0]["companyname"].ToString();
                hfappmstid.Text = dt.Rows[0]["appmstid"].ToString();
                lbl_DOJ.InnerText = dt.Rows[0]["AppMstDOJ"].ToString();
                lbl_Experience.InnerText = dt.Rows[0]["Experience"].ToString();
                if (!string.IsNullOrEmpty(dt.Rows[0]["imagename"].ToString()))
                {
                    if (dt.Rows[0]["imagename"].ToString() == "noimage.png")
                    {
                        div_FirstNameHead.Visible = true;
                        div_firstname.Visible = true;
                        MobProfileImg.Visible = false;
                        ProfileImage.Visible = false;
                        div_FirstNameHead.InnerHtml = div_firstname.InnerHtml = dt.Rows[0]["UserName"].ToString().Substring(0, 1);

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
                    div_FirstNameHead.InnerHtml = div_firstname.InnerHtml = dt.Rows[0]["UserName"].ToString().Substring(0, 1);

                    MobProfileImg.ImageUrl = ProfileImage.ImageUrl = "~/images/KYC/ProfileImage/noimage.png";
                }
                moblblUserName.Text = lbl_Mst_UserName.Text = dt.Rows[0]["UserName"].ToString();
                lblUserid.InnerText = "ID: " + Session["MemberId"].ToString();
                lblUserIdHeader.Text = Session["MemberId"].ToString();
                lbl_Notification_Count.InnerHtml = dt.Rows[0]["NOTIF"].ToString();

                if (Convert.ToInt32(dt.Rows[0]["Tlper"].ToString()) >= 4)
                {
                    li_Notification.Visible = true;
                }

                hnd_PStatus.Value = dt.Rows[0]["PStatus"].ToString();
                hnd_bankstatus.Value = dt.Rows[0]["bankstatus"].ToString();
                hnd_AaStatus.Value = dt.Rows[0]["AaStatus"].ToString();
                hnd_PageUrl.Value = System.IO.Path.GetFileName(Request.Path);

                try
                {
                    if (Session["LogFromAdmin"] != null)
                        hnd_LogFromAdmin.Value = Session["LogFromAdmin"].ToString();
                }
                catch { }
                
            }

        }
        catch
        {

        }
        finally
        {
            con.Close();
            con.Dispose();
            cmd.Dispose();
        }
    }
}
