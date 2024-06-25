using System;
using System.Data;
using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Drawing;


public partial class secretadmin_ExpressSignUp : System.Web.UI.Page, ICallbackEventHandler
{
    string strajax = "";
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    utility objUtil = null;
    static string joinfor = "0";
    Validation val = new Validation();
    protected void Page_Load(object sender, EventArgs e)
    {



        try
        {
            LblMsg.Text = string.Empty;
            lblIP.Text = Request.ServerVariables["REMOTE_HOST"];

            //checkpage();

            if (!IsPostBack)
            {

               
                clearcontrol();
                TxtPassword.Attributes["value"] = string.Empty;
                Session["CheckRefresh"] = System.DateTime.Now.ToString();
                //BindPinNo();
                objUtil = new utility();
                ShowNewJoin();
                CheckMaintanance();

                string pinno = Request.QueryString["p1"] != null ? objUtil.base64Decode(Request.QueryString["p1"].ToString()) : string.Empty;
                //ddlPinNo.SelectedIndex = ddlPinNo.Items.IndexOf(ddlPinNo.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, pinno, true) == 0).FirstOrDefault());
                //lblProduct.Text = ddlPinNo.SelectedIndex > 0 ? ddlPinNo.SelectedItem.Value.Trim().Split(',').Last() : "";
                lblUser.Text = GetSponsorName(TxtSponsorId.Text.Trim());
                // lblcospon.Text=
                //  BindPin();
            }
            string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
            StringBuilder newFunction = new StringBuilder("function ServerSendValue(arg,ctx){" + js + "}");
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            //Response.Redirect("~/Error.aspx", false);
        }
    }
    public void clearcontrol()
    {
        TxtSponsorId.Text = txtUserName.Text = string.Empty;
    }
    private void CheckMaintanance()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("CheckStartDate", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
        con.Open();
        com.ExecuteNonQuery();
        int flag = Convert.ToInt32(com.Parameters["@flag"].Value);
        if (flag == 0)
            Response.Redirect("maintenance.aspx");
        con.Close();
    }

    private void ShowNewJoin()
    {
        //DivConfirm.Visible = false;
        regForm.Visible = true;
       
        btnSubmit.Visible = true;
        DivNewjoin.Enabled = true;
        RequiredFieldValidator7.Enabled = true;
        Popup.Visible = false;
    }

    private void HideNewJoin()
    {
        // DivConfirm.Visible = true;
        btnSubmit.Visible = false;
        DivNewjoin.Enabled = false;
        RequiredFieldValidator7.Enabled = false;
    }

    #region (ICallbackEventHandlar Methods..)
    public string GetCallbackResult()
    {
        return strajax;
    }

    public void RaiseCallbackEvent(string eventArguments)
    {
        if (eventArguments != "")
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand();
            SqlDataReader dr;
            cmd.CommandText = "select appmstfname as name from appmst where appmstregno=@regno";
            cmd.Parameters.AddWithValue("@regno", eventArguments.Trim());
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                strajax = Convert.ToString(dr["name"]);
                Session["sname"] = Convert.ToString(dr["name"]);
            }
            else
            {
                strajax = "User Does Not Exist!";
            }
            dr.Close();
            con.Close();
        }
        else
        {
            strajax = "Required field cannot be blank !";
        }
    }
    #endregion

    protected void btnConfirm_Click(object sender, EventArgs e)
    {



        if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();
            utility obj = new utility();
            BaseValidator bs = Page.Validators.Cast<BaseValidator>().Where(o => o.IsValid == false).FirstOrDefault();
     
            if (TxtPassword.Attributes["value"].Trim().Length < 5)
            {
                LblMsg.Text = "Password Length Can Be Minimum Of 6 Character !";

                return;
            }
       

            else
            {


                SaveData();
            }

        }
    }

    private void SaveData()
    {
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        string date = "";
        //date = Convert.ToDateTime(txtDateofBirth.Text.Trim(), dateInfo).ToString();
        CheckMaintanance();
        objUtil = new utility();
        string AppMstRegNo = "";
        con = new SqlConnection(method.str);
        com = new SqlCommand("Insertdata5", con);
        com.CommandType = CommandType.StoredProcedure;
        com.CommandTimeout = 99999999;
        com.Parameters.AddWithValue("@FId", "0");

        com.Parameters.AddWithValue("@PID", "");
        //com.Parameters.AddWithValue("@pinno", ddlPinNo.SelectedValue.Trim());

        com.Parameters.AddWithValue("@pinno", 0);

        com.Parameters.AddWithValue("@sponserID", TxtSponsorId.Text.Trim());
        com.Parameters.AddWithValue("@AppMstLeftRight", ddlposition.SelectedValue.ToString());
        com.Parameters.AddWithValue("@AppMstTitle", ddlTitle.SelectedItem.Text.ToString());

        com.Parameters.AddWithValue("@AppMstFName", TxtName.Text.Trim());
        com.Parameters.AddWithValue("@Gtitle", "");
        com.Parameters.AddWithValue("@GName", "");
        com.Parameters.AddWithValue("@DOB", DateTime.Now);
        com.Parameters.AddWithValue("@AppMstState", "");
        com.Parameters.AddWithValue("@District", "");

        com.Parameters.AddWithValue("@AppMstCity", "");


        com.Parameters.AddWithValue("@AppMstAddress1", "");
        com.Parameters.AddWithValue("@AppMstPinCode", "");

        com.Parameters.AddWithValue("@AppMstLogin", txtUserName.Text.Trim());

        com.Parameters.AddWithValue("@panno", "");
        com.Parameters.AddWithValue("@mobile", TxtMobile.Text.Trim());
        com.Parameters.AddWithValue("@emailid", "");
        com.Parameters.AddWithValue("@BankName", "");
        com.Parameters.AddWithValue("@Branch", "");
        com.Parameters.AddWithValue("@AccountNo", "");
        com.Parameters.AddWithValue("@AccountType", "");
        com.Parameters.AddWithValue("@IFS", "");
        com.Parameters.AddWithValue("@NomineeName", "");
        com.Parameters.AddWithValue("@NomineeRelation", "");
        com.Parameters.AddWithValue("@AppMstPassword", TxtPassword.Attributes["value"].Trim());
        com.Parameters.AddWithValue("@IPAddress", lblIP.Text.Trim().ToString());
        com.Parameters.AddWithValue("@epassword", string.Empty);

        com.Parameters.AddWithValue("@panstatus", "");
        com.Parameters.AddWithValue("@Gender", "");
        com.Parameters.AddWithValue("@MStatus", "");
        com.Parameters.AddWithValue("@MName", "");
        com.Parameters.AddWithValue("@Occupation", "");

        com.Parameters.Add("@regDisplay", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        string msg = "";
        string epassword = "";
        try
        {
            con.Open();
            com.ExecuteNonQuery();
            AppMstRegNo = com.Parameters["@regDisplay"].Value.ToString();
            msg = com.Parameters["@flag"].Value.ToString();
            epassword = com.Parameters["@epassword"].Value.ToString();
            if (msg == "1")
            {


                if (AppMstRegNo.Trim().Length > 0)
                {

                    if (!string.IsNullOrEmpty(TxtMobile.Text.Trim()) && val.IsValidMobile(TxtMobile.Text.Trim()))
                    {
                        sendSMS(TxtName.Text.Trim(), AppMstRegNo, TxtMobile.Text.Trim(), TxtPassword.Attributes["value"].Trim());
                    }
                    Response.Redirect("Thanks.aspx?i=" + objUtil.base64Encode(AppMstRegNo.Trim()) + "&n=" + objUtil.base64Encode(TxtName.Text.Trim()) + "&sid=" + objUtil.base64Encode(TxtSponsorId.Text.Trim()) + "&mob=" + objUtil.base64Encode(TxtMobile.Text.Trim()) + "&em=" + "" + "&pass=" + objUtil.base64Encode(TxtPassword.Attributes["value"].Trim()), false);
                    clearcontrol();
                }
                else
                    Response.Write("");
            }
            else
                utility.MessageBox(this, msg);
        }
        catch (Exception ex)
        {
            AppMstRegNo = "";
            //utility.WriteErrorLog(ex.Message);
            Response.Write(ex.Message);
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
    private void sendSMS(string name, string reg, string mobile, string pass)
    {
        objUtil = new utility();
        string text = "Dear " + name + " Thanks for joining, your User id: " + reg + " , Password: " + pass;
        // string text = "Dear " + lblname.Text.Trim() + " id:" + lblUserid.Text.Trim() + " Your password is " + objUtil.base64Decode(Request.QueryString["pass"].Trim()); 
        objUtil.sendSMSByPage(mobile.Trim(), text);
    }
    private Boolean IsNOtExistsUserNameAndSponsor()
    {
        InsertFunction func = new InsertFunction();
        Boolean TF = false;
        func.SID = TxtSponsorId.Text.Trim();
        func.Uname = txtUserName.Text.Trim();
        func.SponserCheck();
        if (func.check == 1)
        {
            utility.MessageBox(this, "Invalid Sponsor ID !");

            TF = false;
        }
     
        else
        {
            TF = true;
        }
        return TF;
    }

    protected void btnNewJoin_Click(object sender, EventArgs e)
    {
        Response.Redirect("newjoin.aspx", false);
    }

    protected void BtnWelcome_Click(object sender, EventArgs e)
    {
        Response.Redirect("welcome.aspx", false);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

   

            TxtPassword.Attributes["value"] = TxtPassword.Text.Trim();
            //if (CheckBox1.Checked == false)
            //{
            //    utility.MessageBox(this, "Please Accepts Terms & Conditions.");
            //    return;
            //}
            utility obj = new utility();
            if (Page.IsValid)
            {


          
                if (TxtPassword.Attributes["value"].Trim().Length < 5)
                {
                    LblMsg.Text = "Password Length Can Be Minimum Of 6 Character !";

                    return;
                }





                else if (IsNOtExistsUserNameAndSponsor())
                {
                    HideNewJoin();
                    // OTP();
                    GetDetails();
                    Popup.Visible = true;
                    regForm.Visible = false;

                }
              

            }
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.Message);
        }
    }



    protected void btnEdit_Click(object sender, EventArgs e)
    {
        ShowNewJoin();
    }

  
    private string GetSponsorName(string regno)
    {
        string name = string.Empty;
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("select appmstfname from AppMst where AppMstRegNo=@regno", con);
            com.Parameters.AddWithValue("@regno", regno.Trim());
            con.Open();
            name = com.ExecuteScalar().ToString();
            con.Close();
        }
        catch
        {
        }
        return name;

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        TxtPassword.Attributes["value"] = TxtPassword.Text.Trim();
        btnSubmit.Enabled = true;
        //if (CheckBox1.Checked)
        //{
        //    btnSubmit.Enabled = true;
        //}
       // else
           // btnSubmit.Enabled = false;
        //ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('../Teamancondiation.aspx', '_blank');", true);
    }
    private void getcosponsor()
    {

    }
    protected void ddlTitle_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    public void checkpage()
    {
        SqlDataReader dr;
        con = new SqlConnection(method.str);
        com = new SqlCommand("pageprocess", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@action", "1");
        con.Open();
        dr = com.ExecuteReader();
        while (dr.Read())
        {
            if (dr["signup"].ToString() == "OFF")
            {

                Response.Redirect("~/error.aspx");
            }
        }
    }

   

   
   
    //public void OTP()
    //{

    //    con = new SqlConnection(method.str);
    //    com = new SqlCommand("OTPsend", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.Parameters.AddWithValue("@mobile", TxtMobile.Text);
    //    com.Parameters.Add("@value", SqlDbType.VarChar, 300).Direction = ParameterDirection.Output;
    //    con.Open();
    //    com.ExecuteNonQuery();
    //    ViewState["OTP"] = com.Parameters["@value"].Value.ToString();
    //    con.Close();
    //}


    protected void lnkotp_Click(object sender, EventArgs e)
    {
        //OTP();
    }

    public void GetDetails()
    {

        lblSponsorID.Text = TxtSponsorId.Text.Trim();
        lblSponsorName.Text = Session["sname"].ToString();
        lblPosition.Text = ddlposition.SelectedItem.Text;
        lblName.Text = TxtName.Text.Trim();
       
        lblMobile.Text = TxtMobile.Text.Trim();
       
         
    }
   

        


    
    protected void TxtMobile_TextChanged(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(method.str);
        con.Open();
        SqlCommand cmd = new SqlCommand("select appmstmobile from appmst where appmstmobile='" + TxtMobile.Text.Trim() + "'", con);
        cmd.CommandTimeout = 9999;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(TxtMobile.Text.Trim()))
            {
                //Session["mob"] = dt.Rows[0]["appmstmobile"].ToString();
                lblMob.Text = "Mobile No. Already Exists!";
                lblMob.ForeColor = Color.Red;
                TxtMobile.Focus();
                return;
            }
            else
            {
                lblMob.Text = string.Empty;
            }

        }

        else if (!string.IsNullOrEmpty(TxtMobile.Text.Trim()) && val.IsValidMobile(TxtMobile.Text.Trim()))
        {
            lblMob.Text = string.Empty;
            lblMob.Text = "Mobile No. is valid.";
            lblMob.ForeColor = Color.Green;



        }
        else if (val.IsValidMobile(TxtMobile.Text.Trim()))
        {

            lblMob.Text = string.Empty;
            lblMob.Text = "Mobile No. is not valid.";
            lblMob.ForeColor = Color.Red;

        }
        else if (string.IsNullOrEmpty(TxtMobile.Text.Trim()))
        {
            lblMob.Text = string.Empty;
        }



    }
   







}
