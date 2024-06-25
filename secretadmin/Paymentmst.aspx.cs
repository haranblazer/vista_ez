using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Globalization;
using System.Drawing;

public partial class admin_Pamentmst : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindPaymentDetails();
        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime startdate = new DateTime();
            try
            {

                startdate = Convert.ToDateTime(txtStartDate.Text.Trim(), dateInfo);
            }
            catch
            {
                utility.MessageBox(this, "Invalid Start Date!");
                txtStartDate.Focus();
                return;
            }

            SqlCommand cmd = new SqlCommand("UpdatePaymentmst", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Tax", Convert.ToDouble(txtTDS.Text));
            cmd.Parameters.AddWithValue("@NonTax", Convert.ToDouble(txtNonTDS.Text));
            cmd.Parameters.AddWithValue("@oc ", Convert.ToDouble(txtOC.Text));
            cmd.Parameters.AddWithValue("@startdate ", startdate.ToString());
            cmd.Parameters.AddWithValue("@companyname", txtCompanyName.Text.Trim());
            cmd.Parameters.AddWithValue("@address ", txtAddress.Text.Trim());
            cmd.Parameters.AddWithValue("@website ", txtWebsite.Text.Trim());
            cmd.Parameters.AddWithValue("@phone ", txtPhone.Text);
            cmd.Parameters.AddWithValue("@CompanyHead", txtCompanyHead.Text.Trim());
            cmd.Parameters.AddWithValue("@emailid ", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@city ", txtCity.Text.Trim());
            cmd.Parameters.AddWithValue("@gst", txtGstNo.Text.Trim());
            cmd.Parameters.AddWithValue("@CINNO ", txtCINNO.Text);
            cmd.Parameters.AddWithValue("@panno ", txtPANNo.Text.Trim());
            cmd.Parameters.AddWithValue("@noreply ", txtNoReply.Text.Trim());
            cmd.Parameters.AddWithValue("@noreplypass", txtNorplypass.Text.Trim());
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            if (btnSave.Text == "Add")
            {
                ClientScriptManager csm = Page.ClientScript;
                csm.RegisterStartupScript(this.GetType(), "message", "alert('Data saved successfully...')", true);
            }
            else
            {
                ClientScriptManager csm = Page.ClientScript;
                csm.RegisterStartupScript(this.GetType(), "message", "alert('Data Updated successfully...')", true);
            }

            BindPaymentDetails(); 

        }
        catch
        {

        }
    }
    public void BindPaymentDetails()
    {
        try
        {

            SqlCommand cmd = new SqlCommand("GetPaymentmst", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                txtTDS.Text = (Convert.ToDouble(dt.Rows[0]["Tax"])).ToString();
                txtNonTDS.Text = (Convert.ToDouble(dt.Rows[0]["NonTax"])).ToString();
                txtOC.Text = (Convert.ToDouble(dt.Rows[0]["OC"])).ToString();
                txtStartDate.Text = dt.Rows[0]["startdate"].ToString();
                txtCompanyName.Text = dt.Rows[0]["companyname"].ToString();
                txtAddress.Text = dt.Rows[0]["address"].ToString();
                txtWebsite.Text = dt.Rows[0]["website"].ToString();
                txtPhone.Text = dt.Rows[0]["phone"].ToString();
                txtCompanyHead.Text = dt.Rows[0]["CompanyHead"].ToString();
                txtEmail.Text = dt.Rows[0]["emailid"].ToString();
                txtCity.Text = dt.Rows[0]["city"].ToString();
                txtGstNo.Text = dt.Rows[0]["gst"].ToString();
                txtCINNO.Text = dt.Rows[0]["CINNO"].ToString();
                txtPANNo.Text = dt.Rows[0]["panno"].ToString();
                txtNoReply.Text = dt.Rows[0]["noreply"].ToString();
                txtNorplypass.Text = dt.Rows[0]["norplypass"].ToString();
                btnSave.Text = "Update";
            }
            else
            {
                btnSave.Text = "ADD";
            }
        }
        catch
        {

        }
    }




}

