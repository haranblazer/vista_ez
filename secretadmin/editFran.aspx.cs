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
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Linq;

public partial class secretadmin_editFran : System.Web.UI.Page
{
    int chk = 0;
    SqlConnection con = null;
    SqlCommand com = null;
    SqlDataReader sdr;
    DataTable dt;
    SqlDataAdapter da;
    utility objUtil = null;
    string strid, strname, stradmin;
    protected void Page_Load(object sender, EventArgs e)
    {
       
       
        try
        {
            objUtil = new utility();
            stradmin = Convert.ToString(Session["admin"]);
            strid = objUtil.base64Decode(Request.QueryString["n"].ToString());
            strname = Convert.ToString(Request.QueryString["n1"]);
            if (!IsPostBack)
            {
                BindBank();
                BindState();
                if (strid != null)
                {
                    printsponsorId(strid);
                    go(strid);
                    
                }
                else if (strname != null)
                {
                    //go(strname);
                }
                else
                {
                    Response.Redirect("expire.aspx");
                }
                //finddata();

            }
        }
        catch (Exception ex)
        {
        }

    }


    public void printsponsorId(string strid)
    {
        string sponId;
        con = new SqlConnection(method.str);
        com = new SqlCommand("select AppMstRegNo from AppMst a inner join FranchiseMst f on f.SponsorID=a.AppMstID where f.FranchiseId="+strid, con);
        con.Open();
        sponId = Convert.ToString(com.ExecuteScalar());
        if (sponId == "")
        {
            txtFranSpon.Text = "None";
        }
        else
        {
            txtFranSpon.Text = sponId;
        }

    }
    public void go(string str)
    {

        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("EditFranDetails", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regno", str);
            con.Open();
            sdr = com.ExecuteReader();
            if (sdr.Read()){
                rbtnlstActivate.SelectedIndex = rbtnlstActivate.Items.IndexOf(rbtnlstActivate.Items.FindByValue(sdr["appmstactivate"].ToString()));
                txtName.Text = sdr["FName"].ToString().ToUpper();
                rblsampleal.SelectedIndex = rblsampleal.Items.IndexOf(rblsampleal.Items.FindByValue(sdr["SampleAllowed"].ToString()));
                txtMobileNo.Text=sdr["Mobile"].ToString().ToUpper();
                txtEMailId.Text=sdr["email"].ToString().ToUpper();
                txtAddress.Text = sdr["Address"].ToString().ToUpper();
                txtCity.Text = sdr["City"].ToString().ToUpper();
                txtPinCode.Text = sdr["PinCode"].ToString().ToUpper();
                txtGSTNo.Text = sdr["GST"].ToString().ToUpper();
                txtPanNo.Text = sdr["PanNo"].ToString().ToUpper();
                txtCinNo.Text = sdr["CinNo"].ToString().ToUpper();
                ddlState.SelectedIndex = ddlState.Items.IndexOf(ddlState.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["State"].ToString(), true) == 0).FirstOrDefault());
                txtContactPerson.Text = sdr["PrimaryPhone"].ToString().ToUpper();
                txtflimit.Text = sdr["FLimit"].ToString().ToUpper();
                txtfcom.Text = sdr["FCom"].ToString().ToUpper();
                txtbranch.Text = sdr["Branch"].ToString().ToUpper();
                txtaccountno.Text = sdr["AccountNo"].ToString().ToUpper();
                txtifsc.Text = sdr["IFSCCode"].ToString().ToUpper();
                txtDOB.Text = sdr["dateofentry"].ToString();
                ddlactype.SelectedIndex = ddlactype.Items.IndexOf(ddlactype.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["AccountType"].ToString(), true) == 0).FirstOrDefault());
                ddlbankname.SelectedIndex = ddlbankname.Items.IndexOf(ddlbankname.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["BankName"].ToString(), true) == 0).FirstOrDefault());
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void modifydata()
    {
        try
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime dob2;
            try
            {
                dob2 = Convert.ToDateTime(txtDOB.Text.Trim(), dateInfo);
            }
            catch
            {
                utility.MessageBox(this, "-Sorry :- INVALID DATE OF Registration !");
                return;
            }
            string sBankup = string.Compare(ddlbankname.SelectedItem.Text, "--SELECT BANK--", true) != 0 ? ddlbankname.SelectedItem.Text : "";
            con = new SqlConnection(method.str);
            com = new SqlCommand("modifyFranchisedetail", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@modifiedby ", strid);
            com.Parameters.AddWithValue("@FranchiseId", strid);

            com.Parameters.AddWithValue("@Fname", txtName.Text);

            com.Parameters.AddWithValue("@panno1", txtPanNo.Text.Trim());

            com.Parameters.AddWithValue("@AccountNo ", txtaccountno.Text);

            com.Parameters.AddWithValue("@type1 ", ddlactype.SelectedItem.Text);

            com.Parameters.AddWithValue("@Bankname", sBankup);

            com.Parameters.AddWithValue("@Branch1", txtbranch.Text);

            com.Parameters.AddWithValue("@ifs1", txtifsc.Text);

            com.Parameters.AddWithValue("@Address1", txtAddress.Text);

            com.Parameters.AddWithValue("@City1", txtCity.Text);

            com.Parameters.AddWithValue("@State1", ddlState.SelectedItem.Text);

            com.Parameters.AddWithValue("@distt1", txtdistrict.Text);

            com.Parameters.AddWithValue("@PinCode1", txtPinCode.Text.Trim());

            com.Parameters.AddWithValue("@PrimaryPhone1", txtContactPerson.Text.Trim());

            com.Parameters.AddWithValue("@Mobile1", txtMobileNo.Text.Trim());
            com.Parameters.AddWithValue("@doe1", dob2);
            com.Parameters.AddWithValue("@activate1", rbtnlstActivate.SelectedValue.ToString());
            com.Parameters.AddWithValue("@Sampleallow", rblsampleal.SelectedValue.ToString());
            com.Parameters.AddWithValue("@Gst", txtGSTNo.Text);
            com.Parameters.AddWithValue("@Cinno", txtCinNo.Text);
            com.Parameters.AddWithValue("@email1", txtEMailId.Text.Trim());
            com.Parameters.AddWithValue("@flag", SqlDbType.VarChar).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            string result = com.Parameters["@flag"].Value.ToString();
            if (result == "1")
            {
                utility.MessageBox(this, "Profile updated successfully!");
            }
            else
            {
                utility.MessageBox(this, result);
            }
            if (strid != null)
            {
                go(strid);
            }
            else if (strname != null)
            {
                go(strname);
            }
            else
            {
                Response.Redirect("expire.aspx");
            }
        }
        catch (Exception ex)
        {
        }
        
    
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        modifydata();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Welcome.aspx");
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
                ddlState.Items.Insert(0, new ListItem("Select", "0"));
                //ddlDistrict.Items.Insert(0, new ListItem("Select", "0"));
            }

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
            ddlbankname.DataSource = dt;
            ddlbankname.DataBind();
            ddlbankname.DataTextField = "BankName";
            ddlbankname.DataValueField = "SrNo";
            ddlbankname.DataBind();
            //ddlBankName.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch
        {

        }
    }
}