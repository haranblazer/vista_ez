using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Text;
using System.Text.RegularExpressions;

public partial class secretadmin_ChangeUserDetail : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                //  BindState();
                BindBank();
                clearcontrol();

            }

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);

        }
    }


    void clearcontrol()
    {
        txtuserid.Text = string.Empty;
        txtsponsorid.Text = string.Empty;
        txtCoSponsor.Text = string.Empty;
        TxtName.Text = string.Empty;
        txtGName.Text = string.Empty;
        txtUserName.Text = string.Empty;
        TxtMobile.Text = string.Empty;
        txtemail.Text = string.Empty;
        txtdistrict.Text = string.Empty;
        TxtAddress.Text = string.Empty;
        TxtPinCode.Text = string.Empty;
        
        txtbranch.Text = string.Empty;
        txtaccountno.Text = string.Empty;
        TxtIFS.Text = string.Empty;
        TxtPanNo.Text = string.Empty;
        txtnominame.Text = string.Empty;
        txtnomineerelation.Text = string.Empty;
        TxtPassword.Text = string.Empty;
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

    private void SaveData()
    {
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        string date = "";
        date = Convert.ToDateTime(txtDateofBirth.Text.Trim(), dateInfo).ToString();
        CheckMaintanance();
        objUtil = new utility();
        string AppMstRegNo = "";
        con = new SqlConnection(method.str);
        com = new SqlCommand("modifyappmst", con);
        com.CommandType = CommandType.StoredProcedure;
        com.CommandTimeout = 99999999;


        //com.Parameters.AddWithValue("@PID", ViewState["pid"] != null ? ViewState["pid"].ToString() : string.Empty);
        //com.Parameters.AddWithValue("@pinno", ddlPinNo.SelectedValue.Trim());



        com.Parameters.AddWithValue("@sponsorregno", txtsponsorid.Text.Trim());
        com.Parameters.AddWithValue("@AppMstLeftRight", ddlposition.SelectedValue.ToString());
        com.Parameters.AddWithValue("@AppMstTitle", ddlTitle.SelectedItem.Text.ToString());

        com.Parameters.AddWithValue("@AppMstFName", TxtName.Text.Trim());
        com.Parameters.AddWithValue("@Gtitle", ddlGtitle.SelectedItem.Text);
        com.Parameters.AddWithValue("@GName", txtGName.Text.Trim());
        com.Parameters.AddWithValue("@DOB", date);
        com.Parameters.AddWithValue("@AppMstState", "");
        com.Parameters.AddWithValue("@District", "");


        com.Parameters.AddWithValue("@AppMstCity", "");





        com.Parameters.AddWithValue("@AppMstAddress1", "");
        com.Parameters.AddWithValue("@AppMstPinCode", "");

        com.Parameters.AddWithValue("@AppMstLogin", txtuserid.Text.Trim());

        com.Parameters.AddWithValue("@panno", TxtPanNo.Text.Trim());
        com.Parameters.AddWithValue("@mobile", TxtMobile.Text.Trim());
        com.Parameters.AddWithValue("@emailid", txtemail.Text.Trim());
        com.Parameters.AddWithValue("@BankName", ddlBankName.SelectedItem.Value.ToString());
        com.Parameters.AddWithValue("@Branch", txtbranch.Text.Trim());
        com.Parameters.AddWithValue("@AccountNo", txtaccountno.Text.Trim());
        com.Parameters.AddWithValue("@AccountType", ddlAccType.SelectedItem.Text.Trim());
        com.Parameters.AddWithValue("@IFS", TxtIFS.Text.Trim());
        com.Parameters.AddWithValue("@NomineeName", txtnominame.Text.Trim());
        com.Parameters.AddWithValue("@NomineeRelation", txtnomineerelation.Text.Trim());
        com.Parameters.AddWithValue("@AppMstPassword", TxtPassword.Text);



        com.Parameters.AddWithValue("@panstatus", rbpanlist.SelectedValue);
        com.Parameters.AddWithValue("@Gender", RdoGender.SelectedValue);
        com.Parameters.AddWithValue("@MStatus", RdoMarital.SelectedValue);
        com.Parameters.AddWithValue("@MName", txtMName.Text.Trim());
        com.Parameters.AddWithValue("@Occupation", ddloccupation.SelectedItem.Text);

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

            if (msg == "1")
            {
                utility.MessageBox(this, "Data Saved Successfully");
                clearcontrol();

            }
            else
                utility.MessageBox(this, msg);
        }
        catch (Exception ex)
        {
            AppMstRegNo = "";

            Response.Write(ex.Message);
        }
        finally
        {
            con.Close();
            con.Dispose();
        }
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
            DdlState.DataSource = dt;
            DdlState.DataTextField = "StateName";
            DdlState.DataValueField = "SrNo";
            DdlState.DataBind();
            DdlState.Items.Insert(0, new ListItem("Select", "0"));


        }
        catch
        {

        }
    }


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

            ddlBankName.DataTextField = "BankName";
            ddlBankName.DataValueField = "SrNo";
            ddlBankName.DataSource = dt;
            ddlBankName.DataBind();

            ddlBankName.Items.Insert(0, new ListItem("Select", "0"));

        }
        catch
        {

        }
    }

    protected void DdlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            BindCity();


        }
        catch
        {

        }

    }

    public void BindCity()
    {

        con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("GetStateCity", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@state", DdlState.SelectedItem.Value);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlCity.Enabled = true;
            ddlCity.DataSource = dt;
            ddlCity.Items.Clear();
            ddlCity.DataTextField = "cityname";
            ddlCity.DataValueField = "srno";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem("Select", "0"));
            ddlCity.Focus();


        }
        else
        {
            ddlCity.Items.Clear();
            ddlCity.Enabled = false;
            ViewState["city"] = DdlState.SelectedItem.Text;

        }



    }

    public void BindUserDetail()
    {
        try
        {

            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("BindUser", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", txtuserid.Text.Trim());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlposition.SelectedIndex = ddlposition.Items.IndexOf(ddlposition.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, dt.Rows[0]["appmstleftright"].ToString(), true) == 0).FirstOrDefault());
            ddlTitle.SelectedIndex = ddlTitle.Items.IndexOf(ddlTitle.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, dt.Rows[0]["appmsttitle"].ToString(), true) == 0).FirstOrDefault());


            TxtName.Text = dt.Rows[0]["appmstfname"].ToString();
            txtsponsorid.Text = dt.Rows[0]["sponsorid"].ToString();
            TxtPanNo.Text = dt.Rows[0]["panno"].ToString();

            ddlGtitle.SelectedIndex = ddlGtitle.Items.IndexOf(ddlGtitle.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, dt.Rows[0]["gtitle"].ToString(), true) == 0).FirstOrDefault());
            ddloccupation.SelectedIndex = ddloccupation.Items.IndexOf(ddloccupation.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, dt.Rows[0]["occupation"].ToString(), true) == 0).FirstOrDefault());






            txtGName.Text = dt.Rows[0]["gname"].ToString();
            txtDateofBirth.Text = dt.Rows[0]["userdob"].ToString();



            //  DdlState.Items.FindByText(dt.Rows[0]["appmststate"].ToString().ToUpper()).Selected = true;

            //ddlCity.Items.FindByText(dt.Rows[0]["appmstcity"].ToString().ToUpper()).Selected = true;
            txtdistrict.Text = dt.Rows[0]["distt"].ToString();

            TxtAddress.Text = dt.Rows[0]["appmstaddress1"].ToString();
            TxtPinCode.Text = dt.Rows[0]["appmstpincode"].ToString();
            TxtMobile.Text = dt.Rows[0]["appmstmobile"].ToString();
            txtemail.Text = dt.Rows[0]["email"].ToString();

            ddlAccType.SelectedIndex = ddlAccType.Items.IndexOf(ddlAccType.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, dt.Rows[0]["type"].ToString(), true) == 0).FirstOrDefault());

            ddlBankName.Items.FindByValue("0").Selected = false;
            ddlBankName.Items.FindByValue(dt.Rows[0]["bankname"].ToString().ToUpper()).Selected = true;
            txtbranch.Text = dt.Rows[0]["branch"].ToString();
            txtaccountno.Text = dt.Rows[0]["acountno"].ToString();
            //  ddlAccType.Items.FindByText(dt.Rows[0]["type"].ToString().ToUpper()).Selected = true;
            TxtIFS.Text = dt.Rows[0]["ifscode"].ToString();
            txtnominame.Text = dt.Rows[0]["nom_name"].ToString();
            txtnomineerelation.Text = dt.Rows[0]["nom_rela"].ToString();

            TxtPassword.Text = dt.Rows[0]["appmstpassword"].ToString();



        }
        catch
        {

        }


    }


    protected void btnShow_Click(object sender, EventArgs e)
    {
        BindUserDetail();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SaveData();
    }
}