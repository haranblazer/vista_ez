using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_AddVendor : System.Web.UI.Page
{
    string strajax = "";
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    utility obj = new utility();
    string vendorid = "0";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            try
            {
                Bind_Country();
                Bind_GST();
                Bind_State();
                Bind_Currency();
                Bind_PaymentTerms();
                Bind_TDS();



                if (Request.QueryString["n"] != null) 
                {
                    vendorid = obj.base64Decode(Request.QueryString["n"].ToString());
                    editVendor(vendorid);
                    Btn_AddVender.CommandName = vendorid;
                    vendhead.InnerText = "Edit Vendor";
                }
                //if (Request.QueryString["n"] == null)
                //{
                //    Response.Redirect("Logout.aspx");
                //    Btn_AddVender.CommandName = "";
                //}
            }
            catch (Exception er) { }
        }

    }


    #region Add Vendor

    protected void Btn_AddVender_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("AddVendor", con);
            com.CommandType = CommandType.StoredProcedure;
            if (Request.QueryString["n"] != null)
            {
                com.Parameters.AddWithValue("@Master", "EDIT");
                vendorid = obj.base64Decode(Request.QueryString["n"].ToString());
                com.Parameters.AddWithValue("@VID", vendorid);
            }
            else
            {
                com.Parameters.AddWithValue("@Master", "ADD");
                com.Parameters.AddWithValue("@VID", 0);
            }
            com.Parameters.AddWithValue("@Com_Title", ddl_Title.SelectedItem.Value);
            com.Parameters.AddWithValue("@Com_fname", Txt_FName.Text.Trim());
            com.Parameters.AddWithValue("@Com_Lname", txt_LName.Text.Trim());
            com.Parameters.AddWithValue("@Com_Name", txt_ComName.Text.Trim());
            com.Parameters.AddWithValue("@DisplayName", txt_VenderDisplayName.Text.Trim());
            com.Parameters.AddWithValue("@V_Email", txt_venderEmail.Text.Trim());
            com.Parameters.AddWithValue("@Phone", txt_VendorPhone.Text.Trim());
            com.Parameters.AddWithValue("@Mobile", txt_VendorMobile.Text.Trim());
            com.Parameters.AddWithValue("@SkypeName", txt_SkypeName.Text.Trim());
            com.Parameters.AddWithValue("@Designation", txt_Designation.Text.Trim());
            com.Parameters.AddWithValue("@Department", txt_Department.Text.Trim());
            com.Parameters.AddWithValue("@Website", txt_VendorWebSite.Text.Trim());
            com.Parameters.AddWithValue("@GID", ddl_GST.SelectedItem.Value);
            com.Parameters.AddWithValue("@GSTIN", txt_GSTIN_PAN.Text.Trim());
            com.Parameters.AddWithValue("@Source_Supply", ddl_SourceOfSupply.SelectedItem.Value);
            com.Parameters.AddWithValue("@Currency", ddl_Currency.SelectedItem.Value);
            com.Parameters.AddWithValue("@Opening_Bal", txt_OpeningBal.Text.Trim() == "" ? "0" : txt_OpeningBal.Text.Trim());
            com.Parameters.AddWithValue("@Payment_Terms", ddl_PaymentTerm.SelectedItem.Value);
            com.Parameters.AddWithValue("@TDS", ddl_TDS.SelectedItem.Value);
            com.Parameters.AddWithValue("@Facebook", txt_Facebook.Text.Trim());
            com.Parameters.AddWithValue("@Twitter", txt_twitter.Text.Trim());
            com.Parameters.AddWithValue("@B_Attention", txt_BAttention.Text.Trim());
            com.Parameters.AddWithValue("@B_Country", ddl_BCountry.SelectedItem.Value);
            com.Parameters.AddWithValue("@B_Address", txt_BAddress1.Text.Trim());
            com.Parameters.AddWithValue("@B_State", ddl_BState.SelectedItem.Value);

            com.Parameters.AddWithValue("@B_City", txt_BCity.Text.Trim());
            com.Parameters.AddWithValue("@B_ZipCode", txt_BZipCode.Text.Trim());
            com.Parameters.AddWithValue("@B_Phone", txt_BPhone.Text.Trim());
            com.Parameters.AddWithValue("@B_Fax", txt_BFax.Text.Trim());
            com.Parameters.AddWithValue("@S_Attention", txt_SAttention.Text.Trim());
            com.Parameters.AddWithValue("@S_Country", ddl_SCountry.SelectedItem.Value);
            com.Parameters.AddWithValue("@S_Address", txt_SAddress1.Text.Trim());
            com.Parameters.AddWithValue("@S_State", ddl_SState.SelectedItem.Value);
            com.Parameters.AddWithValue("@S_City", txt_SCity.Text.Trim());
            com.Parameters.AddWithValue("@S_ZipCode", txt_SZipCode.Text.Trim());
            com.Parameters.AddWithValue("@S_Phone", txt_SPhone.Text.Trim());
            com.Parameters.AddWithValue("@S_Fax", txt_SFax.Text.Trim());
            com.Parameters.AddWithValue("@Remarks", txt_Remarks.Text.Trim());
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;

            con.Open();
            com.CommandTimeout = 1900;
            com.ExecuteNonQuery();
            string Result = com.Parameters["@flag"].Value.ToString();
            if (Result == "1")
            {
                ResetControll();
                utility.MessageBox(this, "Vendor Add sucessfully.");
                return;
            }
            if (Result == "2")
            {

                utility.MessageBox(this, "Vendor Updated sucessfully.");
                return;
            }
            else
            {
                utility.MessageBox(this, Result);
            }

           
        }
        catch (Exception er) { }
    }

    #endregion

    #region Selector

    private void Bind_Country()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MasterKey", "GET-COUNTRY-LIST") };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetMasterList");
        if (dt.Rows.Count > 0)
        {
            ddl_BCountry.DataSource = dt;
            ddl_BCountry.DataTextField = "CountryName";
            ddl_BCountry.DataValueField = "CountryID";
            ddl_BCountry.DataBind();
            ddl_BCountry.Items.Insert(0, new ListItem("Select", "0"));
            ddl_BCountry.SelectedValue = "101";

            ddl_SCountry.DataSource = dt;
            ddl_SCountry.DataTextField = "CountryName";
            ddl_SCountry.DataValueField = "CountryID";
            ddl_SCountry.DataBind();
            ddl_SCountry.Items.Insert(0, new ListItem("Select", "0"));
            ddl_SCountry.SelectedValue = "101";
        }
        else
        {
            ddl_BCountry.Items.Clear();
            ddl_SCountry.Items.Clear();
            ddl_BCountry.Items.Insert(0, new ListItem("Select", "0"));
            ddl_SCountry.Items.Insert(0, new ListItem("Select", "0"));
        }
    }


    private void Bind_GST()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MasterKey", "GET-GST-LIST") };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetMasterList");
        if (dt.Rows.Count > 0)
        {
            ddl_GST.DataSource = dt;
            ddl_GST.DataTextField = "GT_Name";
            ddl_GST.DataValueField = "GID";
            ddl_GST.DataBind();
            ddl_GST.Items.Insert(0, new ListItem("Select a GST Treatment", "0"));
        }
        else
        {
            ddl_GST.Items.Clear();
            ddl_GST.Items.Insert(0, new ListItem("Select", "0"));
        }
    }

    private void Bind_State()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MasterKey", "GET-STATE-LIST") };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetMasterList");
        if (dt.Rows.Count > 0)
        {
            ddl_SourceOfSupply.DataSource = dt;
            ddl_SourceOfSupply.DataTextField = "Statename";
            ddl_SourceOfSupply.DataValueField = "StateCode";
            ddl_SourceOfSupply.DataBind();
            ddl_SourceOfSupply.Items.Insert(0, new ListItem("Select", "0"));


            ddl_BState.DataSource = dt;
            ddl_BState.DataTextField = "Statename";
            ddl_BState.DataValueField = "StateCode";
            ddl_BState.DataBind();
            ddl_BState.Items.Insert(0, new ListItem("Select", "0"));


            ddl_SState.DataSource = dt;
            ddl_SState.DataTextField = "Statename";
            ddl_SState.DataValueField = "StateCode";
            ddl_SState.DataBind();
            ddl_SState.Items.Insert(0, new ListItem("Select", "0"));
        }
        else
        {
            ddl_SourceOfSupply.Items.Clear();
            ddl_SourceOfSupply.Items.Insert(0, new ListItem("Select", "0"));

            ddl_BState.Items.Clear();
            ddl_BState.Items.Insert(0, new ListItem("Select", "0"));

            ddl_SState.Items.Clear();
            ddl_SState.Items.Insert(0, new ListItem("Select", "0"));

        }
    }




    private void Bind_Currency()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MasterKey", "GET-CURRENCY-LIST") };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetMasterList");
        if (dt.Rows.Count > 0)
        {
            ddl_Currency.DataSource = dt;
            ddl_Currency.DataTextField = "CurName";
            ddl_Currency.DataValueField = "CurCode";
            ddl_Currency.DataBind();
            ddl_Currency.SelectedValue = "INR";
        }
        else
        {
            ddl_Currency.Items.Clear();
            ddl_Currency.Items.Insert(0, new ListItem("Select", "0"));
        }
    }


    private void Bind_PaymentTerms()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MasterKey", "GET-PAYMENT-TERMS") };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetMasterList");
        if (dt.Rows.Count > 0)
        {
            ddl_PaymentTerm.DataSource = dt;
            ddl_PaymentTerm.DataTextField = "Pname";
            ddl_PaymentTerm.DataValueField = "PayId";
            ddl_PaymentTerm.DataBind();
            ddl_PaymentTerm.SelectedValue = "7";
        }
        else
        {
            ddl_PaymentTerm.Items.Clear();
            ddl_PaymentTerm.Items.Insert(0, new ListItem("Select", "0"));
        }
    }


    private void Bind_TDS()
    {
        SqlParameter[] param = new SqlParameter[] { new SqlParameter("@MasterKey", "GET-TDS-LIST") };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetMasterList");
        if (dt.Rows.Count > 0)
        {
            ddl_TDS.DataSource = dt;
            ddl_TDS.DataTextField = "Tname";
            ddl_TDS.DataValueField = "TDSId";
            ddl_TDS.DataBind();
            ddl_TDS.Items.Insert(0, new ListItem("Select a Tax", "0"));
        }
        else
        {
            ddl_TDS.Items.Clear();
            ddl_TDS.Items.Insert(0, new ListItem("Select a Tax", "0"));
        }
    }



    #endregion

    #region Reset Controll

    private void ResetControll()
    {
        ddl_Title.SelectedItem.Value = "Mr.";
        Txt_FName.Text = "";
        txt_LName.Text = "";
        txt_ComName.Text = "";
        txt_regno.Text = "";
        txt_VenderDisplayName.Text = "";
        txt_venderEmail.Text = "";
        txt_VendorPhone.Text = "";
        txt_VendorMobile.Text = "";
        txt_SkypeName.Text = "";
        txt_Designation.Text = "";
        txt_Department.Text = "";
        txt_VendorWebSite.Text = "";
        ddl_GST.SelectedValue = "0";
        txt_GSTIN_PAN.Text = "";
        ddl_SourceOfSupply.SelectedValue = "0";
        ddl_Currency.SelectedValue = "INR";
        txt_OpeningBal.Text = "";
        ddl_PaymentTerm.SelectedValue = "7";
        ddl_TDS.SelectedValue = "0";
        txt_Facebook.Text = "";
        txt_twitter.Text = "";

        txt_BAttention.Text = "";
        ddl_BCountry.SelectedValue = "0";
        txt_BAddress1.Text = "";
        
        ddl_SState.SelectedValue = "0";
        txt_BCity.Text = "";
        txt_BZipCode.Text = "";
        txt_BPhone.Text = "";
        txt_BFax.Text = "";

        txt_SAttention.Text = "";
        ddl_SCountry.SelectedValue = "0";
        txt_SAddress1.Text = "";
        ddl_BState.SelectedValue = "0";
        txt_SCity.Text = "";
        txt_SZipCode.Text = "";
        txt_SPhone.Text = "";
        txt_SFax.Text = "";

        txt_Remarks.Text = "";
    }
    #endregion

    #region editVendorDetails
    public void editVendor(string vid)
    {
        try
        {
            string qstr = "select * from Vendormst where VID=@vid";
            con.Open();
            com = new SqlCommand(qstr, con);
            com.Parameters.AddWithValue("@vid", vid);
            sdr = com.ExecuteReader();
            if (sdr.Read())
            {
                try
                {
                    
                    ddl_BState.Items.FindByValue("0").Selected = false;
                    ddl_BState.SelectedIndex = ddl_BState.Items.IndexOf(ddl_BState.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["B_State"].ToString(), true) == 0).FirstOrDefault());
                    //ddl_BState.Items.FindByText(sdr["B_State"].ToString()).Selected = true;
                    ddl_GST.Items.FindByValue("0").Selected = false;
                    ddl_GST.SelectedIndex = ddl_GST.Items.IndexOf(ddl_GST.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["GID"].ToString(), true) == 0).FirstOrDefault());
                    ddl_SourceOfSupply.SelectedIndex = ddl_SourceOfSupply.Items.IndexOf(ddl_SourceOfSupply.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["Source_Supply"].ToString(), true) == 0).FirstOrDefault());
                    ddl_Currency.SelectedIndex = ddl_Currency.Items.IndexOf(ddl_Currency.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["Currency"].ToString(), true) == 0).FirstOrDefault());
                    ddl_PaymentTerm.SelectedIndex = ddl_PaymentTerm.Items.IndexOf(ddl_PaymentTerm.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["Payment_Terms"].ToString(), true) == 0).FirstOrDefault());
                    ddl_TDS.SelectedIndex = ddl_TDS.Items.IndexOf(ddl_TDS.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["TDS"].ToString(), true) == 0).FirstOrDefault());
                    ddl_BCountry.SelectedIndex = ddl_BCountry.Items.IndexOf(ddl_BCountry.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["B_Country"].ToString(), true) == 0).FirstOrDefault());
                    ddl_SCountry.SelectedIndex = ddl_SCountry.Items.IndexOf(ddl_SCountry.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["S_Country"].ToString(), true) == 0).FirstOrDefault());
                    ddl_SState.SelectedIndex = ddl_SState.Items.IndexOf(ddl_SState.Items.Cast<ListItem>().Where(o => string.Compare(o.Value, sdr["S_State"].ToString(), true) == 0).FirstOrDefault());
                    
                }
                catch (Exception ex)
                {
                }
                txt_regno.Text = sdr["Com_fname"].ToString();
                Txt_FName.Text = sdr["Com_fname"].ToString();
                txt_LName.Text = sdr["Com_Lname"].ToString();
                txt_ComName.Text = sdr["Com_Name"].ToString();
                txt_VenderDisplayName.Text = sdr["DisplayName"].ToString();
                txt_venderEmail.Text = sdr["V_Email"].ToString();
                txt_GSTIN_PAN.Text = sdr["GSTIN"].ToString();
                txt_OpeningBal.Text = sdr["Opening_Bal"].ToString();
                txt_BAddress1.Text = sdr["B_Address"].ToString();
                txt_BCity.Text = sdr["B_City"].ToString();
                txt_BZipCode.Text = sdr["B_ZipCode"].ToString();
                txt_BFax.Text = sdr["B_Fax"].ToString();
                //txtPinCode.Text = sdr["PinCode"].ToString();
                txt_BPhone.Text = sdr["B_Phone"].ToString();
                txt_VendorPhone.Text = sdr["Phone"].ToString();
                txt_VendorMobile.Text = sdr["Mobile"].ToString();
                txt_SkypeName.Text = sdr["SkypeName"].ToString();
                txt_Facebook.Text = sdr["Facebook"].ToString();
                txt_twitter.Text = sdr["Twitter"].ToString();
                txt_BAttention.Text = sdr["B_Attention"].ToString();
                txt_SAttention.Text = sdr["S_Attention"].ToString();
                txt_SAddress1.Text = sdr["S_Address"].ToString();
                txt_SCity.Text = sdr["S_City"].ToString();
                txt_SZipCode.Text = sdr["S_ZipCode"].ToString();
                txt_SPhone.Text = sdr["S_Phone"].ToString();
                txt_SFax.Text = sdr["S_Fax"].ToString();
                txt_Designation.Text = sdr["Designation"].ToString();
                txt_Department.Text = sdr["Department"].ToString();
                txt_VendorWebSite.Text = sdr["Website"].ToString();
                txt_Remarks.Text = sdr["Remarks"].ToString();
                
            }
        }
        catch (Exception ex)
        {

        }



    }
    #endregion  

}