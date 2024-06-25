using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Text.RegularExpressions;


public partial class admin_ChangeFProfile : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    utility obj = new utility();

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
            if (!Page.IsPostBack)
            {

            }
        }
        catch
        {

        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            if (Regex.IsMatch(txtfrno.Text.Trim(), @"^[A-Za-z0-9]*$"))
            {
                com = new SqlCommand("select * from FranchiseMst where FranchiseId=@RegNo", con);
                com.Parameters.AddWithValue("@RegNo", txtfrno.Text.Trim());
                con.Open();
                sdr = com.ExecuteReader();
                if (sdr.Read())
                {
                    Response.Redirect("editFran.aspx?n=" + obj.base64Encode(txtfrno.Text));
                    con.Close();
                }
                else
                {
                    con.Close();
                    utility.MessageBox(this, "Wrong user id!");
                }
            }
            else
            {
                utility.MessageBox(this, "User Id Contains AlphaNumeric Value Without Space!");
                txtfrno.Focus();
                return;
            }

        }
        catch
        {

        }
    }
    //SqlConnection con = null;
    //SqlDataAdapter sda = null;
    //DataTable dt = null;
    //SqlCommand com;
    //SqlDataAdapter da;
    //SqlDataReader dr = null;
    //Validation val = new Validation();
    //string strajax;
    //protected void Page_Load(object sender, EventArgs e)
    //{
    //    if (Session["admin"] == null)
    //        Response.Redirect("adminLog.aspx", false);

    //    if (!IsPostBack)
    //    {
    //        //divShowHide.Visible = false;
    //        //BindFranchiseID();
    //        // bindfran();
    //        //BindState();
    //        bindfranType();

    //    }
    //     bindfran();
    //    BindState();
    //    bindfranType();
        
    //}

    //public void bindfran()
    //{

    //    con = new SqlConnection(method.str);
    //    sda = new SqlDataAdapter("changefranchiseprofile", con);
    //    sda.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    sda.SelectCommand.Parameters.AddWithValue("@fid", 0);
    //    sda.SelectCommand.Parameters.AddWithValue("@action", "bindall");
    //    sda.SelectCommand.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
    //    dt = new DataTable();
    //    sda.Fill(dt);
    //    if (dt.Rows.Count > 0)
    //    {
    //        //txtUserName.Text = dt.Rows[0]["FranchiseId"].ToString();
    //        //txtName.Text=dt.Rows[1]["fname"].ToString();
    //        //ddlState.SelectedIndex = ddlState.Items.IndexOf(ddlState.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, dt.Rows[2]["state"].ToString(), true) == 0).FirstOrDefault());
    //        //txtAddress.Text = dt.Rows[3]["address"].ToString();
    //        //txtCity.Text = dt.Rows[4]["city"].ToString();
    //        //txtPinCode.Text = dt.Rows[18]["pincode"].ToString();
    //        //txtMobileNo.Text = dt.Rows[5]["mobile"].ToString();
    //        //txtGSTNo.Text=dt.Rows[6]["GST"].ToString();
    //        //txtPanNo.Text = dt.Rows[7]["PanNo"].ToString();
    //        //txtCinNo.Text = dt.Rows[8]["CinNo"].ToString();
    //        //txtEMailId.Text = dt.Rows[9]["email"].ToString();
    //        //txtPinCode.Text = dt.Rows[11]["pincode"].ToString();
    //        //ddlbankname.SelectedIndex = ddlbankname.Items.IndexOf(ddlbankname.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, dt.Rows[16]["BankName"].ToString(), true) == 0).FirstOrDefault());
    //        //txtbranch.Text = dt.Rows[17]["Branch"].ToString();
    //        //txtbranch.Text = dt.Rows[19]["AccountNo"].ToString();
    //        //txtbranch.Text = dt.Rows[20]["IFSCCode"].ToString();
    //    }
    //    //ddltype.DataTextField = "fname";
    //    //ddltype.DataValueField = "franchiseid";
    //    //ddltype.DataSource = dt;
    //    //ddltype.DataBind();
    //    //ddltype.Items.Insert(0, new ListItem("Select", "0"));
    //}


    //public void bindfranType()
    //{

    //    con = new SqlConnection(method.str);
    //    sda = new SqlDataAdapter("select UserVal,Item_Desc from item_collection where itemid=4", con);
    //    sda.SelectCommand.CommandType = CommandType.Text;
    //    sda.SelectCommand.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
    //    dt = new DataTable();
    //    sda.Fill(dt);
        
    //    //ddltype.DataTextField = "Item_Desc";
    //    //ddltype.DataValueField = "UserVal";
    //    //ddltype.DataSource = dt;
    //    //ddltype.DataBind();
    //    //ddltype.Items.Insert(0, new ListItem("Select", "0"));
    //}



    ////protected void ddlFranType_SelectedIndexChanged(object sender, EventArgs e)
    ////{
    ////    try
    ////    {
    ////        itemclear();


    ////        divShowHide.Visible = true;
    ////        con = new SqlConnection(method.str);
    ////        SqlCommand cmd = new SqlCommand("changefranchiseprofile", con);
    ////        cmd.CommandType = CommandType.StoredProcedure;
    ////        cmd.Parameters.AddWithValue("@fid", txtFranId.Text.Trim());
    ////        cmd.Parameters.AddWithValue("@action", "bindone");
    ////        cmd.Parameters.AddWithValue("@name", "");
    ////        cmd.Parameters.AddWithValue("email", "");
    ////        cmd.Parameters.AddWithValue("@distt", "");
    ////        cmd.Parameters.AddWithValue("@city", "");
    ////        cmd.Parameters.AddWithValue("@address", "");
    ////        cmd.Parameters.AddWithValue("@pincode", "");
    ////        cmd.Parameters.AddWithValue("@mobile", "");
    ////        cmd.Parameters.AddWithValue("@pwd", "");
    ////        cmd.Parameters.AddWithValue("@panno", "");
    ////        cmd.Parameters.AddWithValue("@tinno", "");
    ////        cmd.Parameters.AddWithValue("@cinno", "");
    ////        cmd.Parameters.AddWithValue("@primaryphone", "");
    ////        cmd.Parameters.AddWithValue("@username", "");
    ////        cmd.Parameters.AddWithValue("@state", "");
    ////        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
    ////        con.Open();
    ////        dr = cmd.ExecuteReader();
    ////        while (dr.Read())
    ////        {
    ////            txtName.Text = dr["fname"].ToString();
    ////            ddlState.Items.FindByValue("0").Selected = false;
    ////            ddlState.Items.FindByValue(dr["State"].ToString().ToUpper()).Selected = true;
    ////            txtEMailId.Text = dr["email"].ToString();
    ////            txtDistrict.Text = dr["distt"].ToString();
    ////            txtCity.Text = dr["city"].ToString();
    ////            txtAddress.Text = dr["address"].ToString();
    ////            txtPinCode.Text = dr["pincode"].ToString();
    ////            txtMobileNo.Text = dr["mobile"].ToString();
    ////            txtPassword.Text = dr["password"].ToString();
    ////            txtPanNo.Text = dr["panno"].ToString();
    ////            txtTinNo.Text = dr["tinno"].ToString();
    ////            txtCinNo.Text = dr["cinno"].ToString();
    ////            txtContactPerson.Text = dr["primaryphone"].ToString();
    ////            txtUserName.Text = dr["username"].ToString();
    ////            txtConfirmPassword.Text = dr["password"].ToString();
    ////            txtPassword.Text = dr["password"].ToString();
    ////        }
    ////        dr.Close();
    ////        con.Close();


    ////    }
    ////    catch
    ////    {

    ////    }


    ////}
    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{

    //    if ((txtConfirmPassword.Text != "") && (txtPassword.Text != ""))
    //    {
    //        if (txtPassword.Text.Equals(txtConfirmPassword.Text))
    //        {
    //            if (!string.IsNullOrEmpty(txtFranId.Text.Trim()))
    //            {
    //                con = new SqlConnection(method.str);
    //                SqlCommand cmd = new SqlCommand("changefranchiseprofile", con);
    //                cmd.CommandType = CommandType.StoredProcedure;
    //                cmd.Parameters.AddWithValue("@fid", txtFranId.Text.Trim());
    //                cmd.Parameters.AddWithValue("@action", "update");
    //                cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
    //                cmd.Parameters.AddWithValue("email", txtEMailId.Text.Trim());
    //                cmd.Parameters.AddWithValue("@distt", ddlDistrict.SelectedItem.Text.Trim());
    //                cmd.Parameters.AddWithValue("@city", txtCity.Text.Trim());
    //                cmd.Parameters.AddWithValue("@address", txtAddress.Text.Trim());
    //                cmd.Parameters.AddWithValue("@pincode", txtPinCode.Text.Trim());
    //                cmd.Parameters.AddWithValue("@mobile", txtMobileNo.Text.Trim());
    //                cmd.Parameters.AddWithValue("@pwd", txtPassword.Text.Trim());
    //                cmd.Parameters.AddWithValue("@panno", txtPanNo.Text.Trim());
    //                cmd.Parameters.AddWithValue("@GST", txtGSTNo.Text.Trim());
    //                cmd.Parameters.AddWithValue("@cinno", txtCinNo.Text.Trim());
    //                cmd.Parameters.AddWithValue("@primaryphone", txtContactPerson.Text.Trim());
    //                cmd.Parameters.AddWithValue("@username", txtUserName.Text);
    //                cmd.Parameters.AddWithValue("@state", ddlState.SelectedItem.Text.Trim());
    //                cmd.Parameters.AddWithValue("@SampleAllowed",rblsampleal.SelectedValue);
    //                cmd.Parameters.AddWithValue("@BankName",ddlbankname.SelectedItem.Text.Trim());
    //                cmd.Parameters.AddWithValue("@Branch",txtbranch.Text.Trim());
    //                cmd.Parameters.AddWithValue("@AccountNo",txtaccountno.Text.Trim());
    //                cmd.Parameters.AddWithValue("@AccountType",ddlactype.SelectedItem.Text.Trim());
    //                cmd.Parameters.AddWithValue("@IfscCode",txtifsc.Text.Trim());
    //                cmd.Parameters.AddWithValue("@Frantype",ddltype.SelectedValue);
    //                cmd.Parameters.AddWithValue("@FCom", txtfcom.Text.Trim());
    //                cmd.Parameters.AddWithValue("@FLimit", txtflimit.Text.Trim());
    //                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
    //                con.Open();
    //                cmd.ExecuteNonQuery();

    //                string msg = cmd.Parameters["@flag"].Value.ToString();
    //                if (msg == "1")
    //                {
    //                    con.Close();
    //                    utility.MessageBox(this, "Franchise Data Updated Successfully");
    //                    //Response.Redirect(Request.Url.AbsoluteUri);
    //                    divShowHide.Visible = false;


    //                }

    //            }
    //            else
    //            {
    //                utility.MessageBox(this, "Please Enter Franchise Id.");
    //                txtFranId.Focus();
    //                divShowHide.Visible = false;
    //                return;
    //            }
    //        }

    //        else
    //        {
    //            utility.MessageBox(this, "Password Does Not Match");
    //        }
    //    }
    //}
    //public void itemclear()
    //{
    //    txtName.Text = "";
    //    txtEMailId.Text = "";
    //    txtCity.Text = "";
    //    txtAddress.Text = "";
    //    txtPinCode.Text = "";
    //    txtMobileNo.Text = "";
    //    txtPassword.Text = "";
    //    txtPanNo.Text = "";
    //    txtGSTNo.Text = "";
    //    txtCinNo.Text = "";
    //    txtContactPerson.Text = "";
    //    txtUserName.Text = "";
    //    txtConfirmPassword.Text = "";
    //    txtPassword.Text = "";
    //    ddlState.SelectedValue = "0";

    //}
    ////private void BindFranchiseID()
    ////{
    ////    con = new SqlConnection(method.str);
    ////    SqlDataAdapter da = new SqlDataAdapter();

    ////    try
    ////    {
    ////        DataTable dtt = new DataTable();
    ////        da = new SqlDataAdapter("select franchiseid from franchisemst", con);
    ////        da.Fill(dtt);

    ////        List<string> objProductList = new List<string>(); ;
    ////        String strPrdPrice = string.Empty;
    ////        //divFran.InnerText = string.Empty;
    ////        foreach (DataRow drw in dtt.Rows)
    ////        {
    ////           // divFran.InnerText += drw["FranchiseId"].ToString() + ",";

    ////        }
    ////    }
    ////    catch
    ////    {
    ////    }
    ////    finally
    ////    {
    ////    }
    ////}

    //protected void btnSrchSubmit_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        IsNotExistFranID();
    //        if (string.IsNullOrEmpty(txtFranId.Text.Trim()))
    //        {
    //            utility.MessageBox(this, "Please Enter Franchise ID.");
    //            txtFranId.Focus();
    //            return;
    //        }

    //        con = new SqlConnection(method.str);
    //        SqlCommand cmd = new SqlCommand("changefranchiseprofile", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@fid", txtFranId.Text.Trim());
    //        cmd.Parameters.AddWithValue("@action", "bindone");
    //        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
    //        con.Open();
    //        dr = cmd.ExecuteReader();
    //        while (dr.Read())
    //        {
    //            txtFranSpon.Text = dr["regno"].ToString();
    //            txtName.Text = dr["fname"].ToString();
    //            txtEMailId.Text = dr["email"].ToString();
    //            txtCity.Text = dr["city"].ToString();
    //            txtAddress.Text = dr["address"].ToString();
    //            txtPinCode.Text = dr["pincode"].ToString();
    //            txtMobileNo.Text = dr["mobile"].ToString();
    //            txtPassword.Text = dr["password"].ToString();
    //            txtPanNo.Text = dr["panno"].ToString();
    //            txtGSTNo.Text = dr["GST"].ToString();
    //            txtCinNo.Text = dr["cinno"].ToString();
    //            txtContactPerson.Text = dr["primaryphone"].ToString();
    //            txtUserName.Text = dr["username"].ToString();
    //            txtConfirmPassword.Text = dr["password"].ToString();
    //            rblsampleal.SelectedValue = dr["SampleAllowed"].ToString();
    //            txtbranch.Text = dr["Branch"].ToString();
    //            txtaccountno.Text = dr["AccountNo"].ToString();
    //            txtifsc.Text = dr["IfscCode"].ToString();
    //            ddlactype.SelectedItem.Text = dr["AccountType"].ToString();
    //            ddltype.SelectedValue = dr["Frantype"].ToString();
    //            txtfcom.Text = dr["fcom"].ToString();
    //            txtflimit.Text = dr["flimit"].ToString(); 
    //            //txtPassword.Text = dr["password"].ToString();    
    //           // BindBank();
    //            try
    //            {
    //                BindState();
    //                ddlState.Items.FindByValue("0").Selected = false;
    //                ddlState.Items.FindByText(dr["state"].ToString()).Selected = true;
    //            }
    //            catch
    //            {

    //            }

    //            try
    //            {
    //                BindDistrict(ddlState.SelectedValue.ToString());
    //                ddlDistrict.Items.FindByValue("0").Selected = false;
    //                ddlDistrict.Items.FindByText(dr["distt"].ToString()).Selected = true;
    //            }
    //            catch
    //            {

    //            }
    //            try
    //            {
    //                BindBank();
    //                ddlbankname.Items.FindByValue("0").Selected = false;
    //                ddlbankname.SelectedIndex = ddlbankname.Items.IndexOf(ddlbankname.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, dr["BankName"].ToString(), true) == 0).FirstOrDefault());
    //                //ddlAccType.SelectedItem.Text = dr["type"].ToString(); 
    //            }
    //            catch
    //            {
    //            }
    //        }
    //        dr.Close();
    //        con.Close();
    //    }
    //    catch
    //    {

    //    }
    //}

    //public void IsNotExistFranID()
    //{
    //    if (txtFranId.Text.Trim() != "")
    //    {
    //        con = new SqlConnection(method.str);
    //        SqlCommand com = new SqlCommand("select franchiseid from franchisemst where franchiseid=@franId", con);
    //        com.CommandType = CommandType.Text;
    //        com.Parameters.AddWithValue("@franId", txtFranId.Text.Trim());
    //        SqlDataAdapter da = new SqlDataAdapter(com);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        if (dt.Rows.Count <= 0)
    //        {
    //            lblShowmsg.Text = "Franchise Does Not Exists!";
    //            txtFranId.Focus();
    //            divShowHide.Visible = false;
    //            return;
    //        }
    //        else
    //        {
    //            divShowHide.Visible = true;
    //            lblShowmsg.Text = "";
    //        }




    //    }
    //}
    //public void BindState()
    //{
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("GetState", con);
    //        com.CommandType = CommandType.StoredProcedure;

    //        da = new SqlDataAdapter(com);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {
    //            ddlState.DataSource = dt;
    //            ddlState.DataTextField = "StateName";
    //            ddlState.DataValueField = "Id";
    //            ddlState.DataBind();
    //            ddlState.Items.Insert(0, new ListItem("Select", "0"));


    //        }

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
    //            ddlDistrict.DataSource = dt;
    //            ddlDistrict.Items.Clear();
    //            ddlDistrict.DataTextField = "DistrictName";
    //            ddlDistrict.DataValueField = "Id";
    //            ddlDistrict.DataBind();
    //            ddlDistrict.Items.Insert(0, new ListItem("Select", "0"));
    //        }
    //        else
    //        {
    //            ddlDistrict.Items.Clear();
    //            ddlDistrict.Items.Insert(0, new ListItem("Select", "0"));
    //        }
    //    }
    //    catch
    //    {
    //    }
    //}

    //protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        BindDistrict(ddlState.SelectedItem.Value.ToString());
    //    }
    //    catch
    //    {
    //    }

    //}

    ////Developed By Raghwendra 06/07/2019
    //public void BindBank()
    //{
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("GetBank", con);
    //        com.CommandType = CommandType.StoredProcedure;
    //        da = new SqlDataAdapter(com);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        ddlbankname.DataSource = dt;
    //        ddlbankname.DataTextField = "BankName";
    //        ddlbankname.DataValueField = "SrNo";
    //        ddlbankname.DataBind();
    //        ddlbankname.Items.Insert(0, new ListItem("Select", "0"));
    //    }
    //    catch
    //    {

    //    }
    //}

}
