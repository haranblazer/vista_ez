using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using System.Data;
using System.Text;
//using System.Linq;
using System.Drawing;
using System.Web.Services;
using AjaxControlToolkit;

public partial class CreateFranchise : System.Web.UI.Page, ICallbackEventHandler
{
    string strajax = "";
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    utility obj = new utility();
    string franchiseid = "0";
    string UserId;
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
            lblFranSpon.Text = "";
            if (Request.QueryString["n"] != null)
                Bind_FranchiseTypeEdit();
            else
                Bind_FranchiseType();

            BindState();
            BindBank();
           // ShowCreateFran();
            txtConfirmPassword.Attributes["value"] = string.Empty;
            Session["CheckRefresh"] = System.DateTime.Now.ToString();
            if (Request.QueryString["n"] != null)
            {
                franchiseid = Request.QueryString["n"].ToString();
                editFranchise(franchiseid);
                btnSubmit.CommandName = franchiseid;
            }
            else
            {
                btnSubmit.CommandName = "";
            }

        }
        string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
        StringBuilder newFunction = new StringBuilder("function ServerSendValue(arg,ctx){" + js + "}");
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    public void editFranchise(string fid)
    {
        try
        {
            utility utility = new utility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@fid", fid) };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, @"Select Sponsor=(Select Appmstregno from Appmst where Appmstid=f.SponsorID),  
            SponsorName=(Select AppMstFName from Appmst where Appmstid=f.SponsorID),
            LeaderName=(Select AppMstFName from Appmst where AppmstRegno=f.LeaderId),
            * from FranchiseMst f where f.FranchiseId=@fid");
            if (dt.Rows.Count > 0)
            {

                if (dt.Rows[0]["ProfileUpdated"].ToString() == "1")
                {
                    btnSubmit.Enabled = false;
                    lbl_Msg.Text = "Profile Updated.!!";
                }
                txtsponsorid.Text = dt.Rows[0]["Sponsor"].ToString();
                txtsponsorid.Enabled = false;
                txt_LeaderId.Text = dt.Rows[0]["LeaderId"].ToString();
                txt_LeaderName.Text = dt.Rows[0]["LeaderName"].ToString();

                lblFranSpon.ForeColor = Color.Blue;
                lblFranSpon.Text = dt.Rows[0]["SponsorName"].ToString();


                txtName.Text = dt.Rows[0]["FName"].ToString();
                txtAddress.Text = dt.Rows[0]["Address"].ToString();
                txtCity.Text = dt.Rows[0]["City"].ToString();
                txtPinCode.Text = dt.Rows[0]["PinCode"].ToString();
                txtMobileNo.Text = dt.Rows[0]["Mobile"].ToString();
                txtContactPerson.Text = dt.Rows[0]["ContactPerson"].ToString();
                txtEMailId.Text = dt.Rows[0]["email"].ToString();
                txt_fMappingId.Text = dt.Rows[0]["MappingId"].ToString();
                txtCinNo.Text = dt.Rows[0]["CinNo"].ToString();
                txtPanNo.Text = dt.Rows[0]["PanNo"].ToString();
                txtGSTNo.Text = dt.Rows[0]["GST"].ToString();

                txtaccountno.Text = dt.Rows[0]["AccountNo"].ToString();
                txtifsc.Text = dt.Rows[0]["IFSCCode"].ToString();
                txtbranch.Text = dt.Rows[0]["Branch"].ToString();

                txtPassword.Text = utility.base64Decode(dt.Rows[0]["Password"].ToString());
                txtConfirmPassword.Text = utility.base64Decode(dt.Rows[0]["Password"].ToString());

                //txtPassword.Text = utility.base64Decode(dt.Rows[0]["Password"].ToString()); 
                //txtConfirmPassword.Text = utility.base64Decode(dt.Rows[0]["Password"].ToString());
                //txtPassword.Text = utility.base64Decode(dt.Rows[0]["Password"].ToString());

                txt_OpeningAmount.Text = dt.Rows[0]["OpeningAmount"].ToString();
                txt_MinStkAmt.Text = dt.Rows[0]["MinStkAmt"].ToString();

                //txtConfirmPassword.Text = utility.base64Decode(dt.Rows[0]["Password"].ToString());
                try
                {
                    ddlactype.SelectedValue = dt.Rows[0]["AccountType"].ToString();

                    ddltype.SelectedValue = dt.Rows[0]["Frantype"].ToString();

                    ddlState.Items.FindByValue("0").Selected = false;
                    ddlState.Items.FindByText(dt.Rows[0]["State"].ToString()).Selected = true;
                    BindDistrict(ddlState.SelectedValue.ToString());

                    ddlDistrict.Items.FindByValue("0").Selected = false;
                    ddlDistrict.Items.FindByText(dt.Rows[0]["distt"].ToString()).Selected = true;

                    //rblsampleal.Items.FindByValue("1").Selected = false;
                    //rblsampleal.Items.FindByText(dt.Rows[0]["SampleAllowed"].ToString()).Selected = true;

                    ddlbankname.Items.FindByValue("0").Selected = false;
                    ddlbankname.Items.FindByText(dt.Rows[0]["BankName"].ToString()).Selected = true;

                    // ddltype.Items.FindByText("0").Selected = false;

                }
                catch (Exception er) { }
                ddltype.Enabled = false;
                //txtPassword.Enabled = false;
                //txtConfirmPassword.Enabled = false;

            }
        }
        catch (Exception er) { }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            //if (!string.IsNullOrEmpty(txtsponsorid.Text.Trim()))
            //{

            if (!string.IsNullOrEmpty(txtName.Text.Trim()))
            {
                if (!string.IsNullOrEmpty(txtAddress.Text.Trim()))
                {
                    if (!string.IsNullOrEmpty(txtCity.Text.Trim()))
                    {
                        if (ddlDistrict.SelectedIndex > 0)
                        {
                            if (ddlState.SelectedIndex > 0)
                            {
                                if (!string.IsNullOrEmpty(txtPinCode.Text.Trim()))
                                {
                                    if (Regex.Match(txtPinCode.Text.Trim().ToString(), @"^[0-9]*$").Success)
                                    {
                                        if (!string.IsNullOrEmpty(txtMobileNo.Text.Trim()))
                                        {
                                            if (Regex.Match(txtMobileNo.Text.Trim().ToString(), @"^[6789][0-9]{9}$").Success)
                                            {

                                                if (!string.IsNullOrEmpty(txtEMailId.Text.Trim()))
                                                {
                                                    if (Regex.Match(txtEMailId.Text.Trim().ToString(), @"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$").Success)
                                                    {

                                                        if (!string.IsNullOrEmpty(txtPanNo.Text.Trim()))
                                                        {
                                                            if (!obj.IsValidPAN(txtPanNo.Text.Trim()))
                                                            {
                                                                utility.MessageBox(this, "Invalid PAN No.");
                                                                return;
                                                            }
                                                        }

                                                        
                                                            create();


                                                        if (Validation.IsValidPassword(txtPassword.Text.Trim()) == false)
                                                        {
                                                            utility.MessageBox(this, "Password contains [A-Za-z0-9!@#$%^&*()] value.!");
                                                            return;
                                                        }


                                                        if (lblFranSpon.Text == "User Does Not Exist!")
                                                        {
                                                            utility.MessageBox(this, "User Does Not Exist.");
                                                            txtsponsorid.Focus();
                                                            return;
                                                        }
                                                        string Password = txtConfirmPassword.Text.Trim();
                                                        txtPassword.Attributes.Add("value", Password);
                                                        txtConfirmPassword.Attributes.Add("value", Password);
                                                        //HideCreateFran();
                                                        //BindPanelData();


                                                    }
                                                    else
                                                        utility.MessageBox(this, "Email should be like abc@xyz.com !");
                                                }
                                                else
                                                    utility.MessageBox(this, "Please enter e mail id!");

                                            }
                                            else
                                                utility.MessageBox(this, "Please enter valid mobile number!");

                                        }
                                        else
                                            utility.MessageBox(this, "Please enter mobile number!");

                                    }
                                    else
                                        utility.MessageBox(this, "Please enter 6 digits pin code!");

                                }
                                else
                                    utility.MessageBox(this, "Please enter pin code!");

                            }
                            else
                                utility.MessageBox(this, "Please select state !");

                        }
                        else
                            utility.MessageBox(this, "Please select district !");
                    }
                    else
                        utility.MessageBox(this, "Please enter city !");

                }
                else
                    utility.MessageBox(this, "Please enter Address !");

            }
            else
                utility.MessageBox(this, "Please enter name !");
            //}
            //else
            //    utility.MessageBox(this, "Please Enter Franchise SponsorId !");
        }
        catch
        {

        }
    }


    public void create()
    {
        try
        {
            if (Request.QueryString["n"] != null)
            {
                SqlParameter[] param1 = new SqlParameter[]
                {
                    new SqlParameter("@Franchiseid", Request.QueryString["n"].ToString())
                };
                utility utility = new utility();
                string PWD = "";
                DataUtility objDu = new DataUtility();
                DataTable dt = objDu.GetDataTable(param1, "Select Password from FranchiseMst where Franchiseid=@Franchiseid");
                if (dt.Rows.Count > 0)
                    PWD = dt.Rows[0]["Password"].ToString();


                SqlCommand cmd = new SqlCommand("changefranchiseprofile", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fid", Request.QueryString["n"].ToString().Trim());
                cmd.Parameters.AddWithValue("@action", "update");
                cmd.Parameters.AddWithValue("@LeaderId", txt_LeaderId.Text.Trim());

                cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("email", txtEMailId.Text.Trim());
                cmd.Parameters.AddWithValue("@distt", ddlDistrict.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@city", txtCity.Text.Trim());
                cmd.Parameters.AddWithValue("@address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@pincode", txtPinCode.Text.Trim());
                cmd.Parameters.AddWithValue("@mobile", txtMobileNo.Text.Trim());
                cmd.Parameters.AddWithValue("@pwd", utility.base64Encode(txtConfirmPassword.Text.Trim()));
                cmd.Parameters.AddWithValue("@panno", txtPanNo.Text.Trim());
                cmd.Parameters.AddWithValue("@GST", txtGSTNo.Text.Trim());
                cmd.Parameters.AddWithValue("@cinno", txtCinNo.Text.Trim());
                cmd.Parameters.AddWithValue("@primaryphone", txtContactPerson.Text.Trim());
                cmd.Parameters.AddWithValue("@username", "");
                cmd.Parameters.AddWithValue("@state", ddlState.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@SampleAllowed", rblsampleal.SelectedValue);
                cmd.Parameters.AddWithValue("@BankName", ddlbankname.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@Branch", txtbranch.Text.Trim());
                cmd.Parameters.AddWithValue("@AccountNo", txtaccountno.Text.Trim());
                cmd.Parameters.AddWithValue("@AccountType", ddlactype.SelectedItem.Text.Trim());
                cmd.Parameters.AddWithValue("@IfscCode", txtifsc.Text.Trim());
                cmd.Parameters.AddWithValue("@Frantype", ddltype.SelectedValue);
                cmd.Parameters.AddWithValue("@FCom", txtfcom.Text.Trim());
                cmd.Parameters.AddWithValue("@FLimit", txtflimit.Text.Trim());

                cmd.Parameters.AddWithValue("@MappingId", txt_fMappingId.Text.Trim());
                cmd.Parameters.AddWithValue("@ContactPerson", txtContactPerson.Text.Trim());

                cmd.Parameters.AddWithValue("@OpeningAmount", txt_OpeningAmount.Text.Trim() == "" ? "0" : txt_OpeningAmount.Text.Trim());
                cmd.Parameters.AddWithValue("@MinStkAmt", txt_MinStkAmt.Text.Trim() == "" ? "0" : txt_MinStkAmt.Text.Trim());

                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                string msg = cmd.Parameters["@flag"].Value.ToString();
                if (msg == "1")
                {
                    con.Close();
                    Response.Redirect("FranchiseList.aspx");

                    //utility.MessageBox(this, "Franchise Data Updated Successfully");
                    //lbl_Success.Text = "Franchise Data Updated Successfully";
                }
            }
            else
            {
                utility objUt = new utility();

                com = new SqlCommand("CreateFranchise", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@txtsponsorid", txtsponsorid.Text.Trim());
                com.Parameters.AddWithValue("@LeaderId", txt_LeaderId.Text.Trim());

                com.Parameters.AddWithValue("@FranchiseName", txtName.Text.Trim());
                com.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                com.Parameters.AddWithValue("@City", txtCity.Text.Trim());
                com.Parameters.AddWithValue("@District", ddlDistrict.SelectedItem.Text.Trim());
                com.Parameters.AddWithValue("@State", ddlState.SelectedItem.Text.Trim());
                com.Parameters.AddWithValue("@PinCode", txtPinCode.Text.Trim());
                com.Parameters.AddWithValue("@EMailId", txtEMailId.Text.Trim());
                com.Parameters.AddWithValue("@MobileNo", txtMobileNo.Text.Trim());
                com.Parameters.AddWithValue("@ContactPerson", txtContactPerson.Text.Trim());
                com.Parameters.AddWithValue("@MappingId", txt_fMappingId.Text);
                com.Parameters.AddWithValue("@IP", "");
                com.Parameters.AddWithValue("@UserName", "");
                com.Parameters.AddWithValue("@Password", objUt.base64Encode(txtConfirmPassword.Text.Trim()));
                com.Parameters.AddWithValue("@pan", txtPanNo.Text);
                com.Parameters.AddWithValue("@GST", txtGSTNo.Text.Trim());
                com.Parameters.AddWithValue("@cin", txtCinNo.Text);
                com.Parameters.AddWithValue("@createdBy", Session["admin"].ToString());
                com.Parameters.AddWithValue("@frantype", ddltype.SelectedValue.ToString());
                com.Parameters.AddWithValue("@SampleAllowed", rblsampleal.SelectedValue);
                com.Parameters.AddWithValue("@BankName", ddlbankname.SelectedItem.Text.Trim());
                com.Parameters.AddWithValue("@Branch", txtbranch.Text.Trim());
                com.Parameters.AddWithValue("@AccountNo", txtaccountno.Text.Trim());
                com.Parameters.AddWithValue("@AccountType", ddlactype.SelectedItem.Text.Trim());
                com.Parameters.AddWithValue("@IfscCode", txtifsc.Text.Trim());
                com.Parameters.AddWithValue("@flimit", txtflimit.Text.Trim());
                com.Parameters.AddWithValue("@fcom", txtfcom.Text.Trim());
                com.Parameters.AddWithValue("@OpeningAmount", txt_OpeningAmount.Text.Trim() == "" ? "0" : txt_OpeningAmount.Text.Trim());
                com.Parameters.AddWithValue("@MinStkAmt", txt_MinStkAmt.Text.Trim() == "" ? "0" : txt_MinStkAmt.Text.Trim());
                com.Parameters.Add("@FranchiseId", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                if (com.Parameters["@flag"].Value.ToString() == "1")
                {
                    lbl_Success.Text = "Franchise created successfully ! Franchise Id is : " + com.Parameters["@FranchiseId"].Value.ToString();
                    utility.MessageBox(this, "Franchise created successfully ! Franchise Id is : " + com.Parameters["@FranchiseId"].Value.ToString());
                    // string msg = "Dear, " + txtName.Text.Trim() + " Franchise Id: " + com.Parameters["@FranchiseId"].Value.ToString().ToUpper()+" Type: " + ddltype.SelectedItem.Text.ToString() + " and " + "Password: " + lblpassword.Text.Trim();
                    // obj.sendSMSByPage(txtMobileNo.Text.Trim(), msg);
                    //string msg = "Dear, " + txtName.Text.Trim() + " Welcome to Toptime, Franchise Id: " + com.Parameters["@FranchiseId"].Value.ToString().ToUpper() + " Type: " + ddltype.SelectedItem.Text.ToString() + " and " + "Password: " + txtConfirmPassword.Text.Trim();
                    //obj.sendSMSCjstore(txtMobileNo.Text.Trim(), msg);

                    Response.Redirect("FranchiseList.aspx");

                    //ShowCreateFran();
                    //resetControls();

                }
                else
                {
                    utility.MessageBox(this, com.Parameters["@flag"].Value.ToString());
                }
            }
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }
        finally
        {
            con.Dispose();
            com.Dispose();
        }
    }


    private void resetControls()
    {
        txtsponsorid.Text = txt_LeaderId.Text = txtName.Text = txtAddress.Text = txtCity.Text = txtPinCode.Text = txtMobileNo.Text = txtContactPerson.Text = txtEMailId.Text = txtCinNo.Text = txtPanNo.Text = txtGSTNo.Text = txtaccountno.Text = txtbranch.Text = txtifsc.Text = txtPassword.Text = txtConfirmPassword.Text = string.Empty;
        txtPassword.Text = "";
        txtConfirmPassword.Text = "";
        txtfcom.Text = "";
        txtflimit.Text = "";
        ddltype.SelectedIndex = 0;
        ddlState.SelectedIndex = 0;
        BindDistrict(ddlState.SelectedValue.ToString());
        rblsampleal.SelectedIndex = 0;
        ddlbankname.SelectedIndex = 0;
        ddlactype.SelectedItem.Text = "SAVING A/C";
        lblFranSpon.Text = "";

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
            com = new SqlCommand();
            SqlDataReader dr;
            com.CommandText = "select appmsttitle+space(1)+appmstfname as name from appmst where appmstregno=@regno";
            com.Parameters.AddWithValue("@regno", eventArguments.Trim());
            com.Connection = con;
            con.Open();
            dr = com.ExecuteReader();

            if (dr.Read())
            {
                strajax = Convert.ToString(dr["name"]);
                //Session["sname"] = Convert.ToString(dr["name"]);
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

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BindDistrict(ddlState.SelectedItem.Value.ToString());
        }
        catch
        {

        }
    }

    protected void txtsponsorid_TextChanged(object sender, EventArgs e)
    {
        string name = string.Empty;
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("select appmsttitle+space(1)+appmstfname as name from AppMst where AppMstRegNo=@regno", con);
            com.Parameters.AddWithValue("@regno", txtsponsorid.Text.Trim());
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                lblFranSpon.ForeColor = Color.Blue;
                lblFranSpon.Text = dt.Rows[0]["name"].ToString();
            }


            else
            {
                lblFranSpon.ForeColor = Color.Red;
                lblFranSpon.Text = "User Does Not Exist!";
                txtsponsorid.Focus();
            }

        }
        catch
        {

        }

    }

    //private void ShowCreateFran()
    //{
    //    CreateFran.Visible = true;
    //    CreateFran.Enabled = true;
    //    btnSubmit.Visible = true;
    //    PnlConfirmation.Visible = false;
    //}
    //private void HideCreateFran()
    //{
    //    CreateFran.Enabled = false;
    //    CreateFran.Visible = false;
    //    PnlConfirmation.Visible = true;
    //    btnSubmit.Visible = false;


    //}
    //private void BindPanelData()
    //{
    //    try
    //    {

    //        lblFranType.Text = ddltype.SelectedItem.Text;
    //        lblFranSponId.Text = txtsponsorid.Text.Trim();
    //        lblFranSponName.Text = lblFranSpon.Text;
    //        lblFranName.Text = txtName.Text.Trim();
    //        lblMobileNo.Text = txtMobileNo.Text.Trim();
    //        lblEmail.Text = txtEMailId.Text.Trim();
    //        lblpassword.Text = "abc123";


    //    }
    //    catch
    //    {

    //    }
    //}
    protected void btnEdit_Click(object sender, EventArgs e)
    {
      //  ShowCreateFran();
    }
    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        create();
    }
    public void BindState()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetState", con);
            com.CommandType = CommandType.StoredProcedure;

            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddlState.DataSource = dt;
                ddlState.DataTextField = "StateName";
                ddlState.DataValueField = "Id";
                ddlState.DataBind();
                ddlState.Items.Insert(0, new ListItem("--Select--", "0"));
                ddlDistrict.Items.Insert(0, new ListItem("--Select--", "0"));
            }
        }
        catch
        {
        }
    }
    public void BindDistrict(string value)
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("GetStateDistrict", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@state", value);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddlDistrict.DataSource = dt;
                ddlDistrict.Items.Clear();
                ddlDistrict.DataTextField = "DistrictName";
                ddlDistrict.DataValueField = "Id";
                ddlDistrict.DataBind();
                ddlDistrict.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            else
            {
                ddlDistrict.Items.Clear();
                ddlDistrict.Items.Insert(0, new ListItem("--Select--", "0"));
            }
        }
        catch
        {
        }
    }
    //Developed By Raghwendra 06/07/2019
    public void BindBank()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetBank", con);
            com.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlbankname.DataSource = dt;
            ddlbankname.DataTextField = "BankName";
            ddlbankname.DataValueField = "SrNo";
            ddlbankname.DataBind();
            ddlbankname.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch
        {

        }
    }

    private string GetUserId()
    {
        string name = string.Empty;
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("SELECT  max(FranchiseId)+1 as FranchiseId FROM  FranchiseMst", con);
            con.Open();
            name = com.ExecuteScalar().ToString();
            con.Close();
        }
        catch
        {
        }
        return name;
    }


    [WebMethod]
    public static UserDetails GetLeaderName(string LeaderId)
    {
        UserDetails objUser = new UserDetails();
        try
        {
            int flag = 0;
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {  new SqlParameter("@LeaderId", LeaderId.Trim()) };
            SqlDataReader dr = objDu.GetDataReader(param, "Select AppMstFName from AppMst Where AppMstRegNo=@LeaderId");
            while (dr.Read())
            {
                objUser.Error = "";
                objUser.UserName = dr["AppMstFName"].ToString();
                flag++;
            }
            if (flag == 0)
            {
                objUser.Error = "User Does Not Exists!";
            }

            //lblLastPayoutDate.Text = objDu.GetDataReader("Select AppMstFName from AppMst Where AppMstRegNo=@LeaderId").ToString();
            //SqlConnection con = new SqlConnection(method.str);
            //SqlCommand cmd = new SqlCommand("Select AppMstFName from AppMst Where AppMstRegNo=@LeaderId", con);
            //SqlDataReader dr;
            //cmd.CommandType = CommandType.Text;
            //cmd.Parameters.AddWithValue("@LeaderId", LeaderId); 
            //cmd.Connection = con;
            //con.Open();
            //dr = cmd.ExecuteReader();
            //if (dr.Read())
            //{ 
            //    objUser.Error = "";
            //    objUser.UserName = dr["AppMstFName"].ToString();
            //}
            //else
            //{
            //    objUser.Error = "User Does Not Exists!";
            //}
            //dr.Close();
            //con.Close();
        }
        catch (Exception er) { objUser.Error = "Server error. Time out.!!"; }
        return objUser;
    }





    private void Bind_FranchiseType()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4 and UserVal not in (1, 7, 8, 9, 10)");
        if (dt.Rows.Count > 0)
        {
            ddltype.DataSource = dt;
            ddltype.DataTextField = "Item_Desc";
            ddltype.DataValueField = "Frantype";
            ddltype.DataBind();
            ddltype.Items.Insert(0, new ListItem("Select", "0"));
        }
        else
        {
            ddltype.Items.Clear();
            ddltype.Items.Insert(0, new ListItem("Select", "0"));
        }
    }

    private void Bind_FranchiseTypeEdit()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4");
        if (dt.Rows.Count > 0)
        {
            ddltype.DataSource = dt;
            ddltype.DataTextField = "Item_Desc";
            ddltype.DataValueField = "Frantype";
            ddltype.DataBind();
            ddltype.Items.Insert(0, new ListItem("Select", "0"));
        }
        else
        {
            ddltype.Items.Clear();
            ddltype.Items.Insert(0, new ListItem("Select", "0"));
        }
    }


    [WebMethod]
    public static UserDetails GetUser(string fMappingId, string FranType)
    {
        UserDetails objUser = new UserDetails();
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("CheckFranMapping", con);
            SqlDataReader dr;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@fMappingId", fMappingId);
            cmd.Parameters.AddWithValue("@FranType", FranType);
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                // if(FranType> dr["FranType"].ToString())
                objUser.Error = "";
                objUser.UserName = dr["FName"].ToString();
            }
            else
            {
                objUser.Error = "User Does Not Exists!";
            }
            dr.Close();
            con.Close();
        }
        catch (Exception er) { objUser.Error = "Server error. Time out.!!"; }
        return objUser;
    }

    public class UserDetails
    {
        public String Error { get; set; }
        public String UserName { get; set; }

    }


}

