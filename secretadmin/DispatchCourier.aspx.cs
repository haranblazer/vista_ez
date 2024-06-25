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
using System.Collections.Generic;
public partial class admin_DispatchCourier : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataReader dr;
    utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!Page.IsPostBack)
            {

            }
        }
        catch
        {

        }
        if (!IsPostBack)
        {
            ////BindUserID();
            txtDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        dispatch();
        //chkdocketid();

    }
    //private void BindUserID()
    //{
    //    con = new SqlConnection(method.str);
    //    SqlDataAdapter da = new SqlDataAdapter();
    //    //ViewState["Count"] = null;
    //    try
    //    {
    //        DataTable dtt = new DataTable();
    //        da = new SqlDataAdapter("select appmstregno,appmstfname from appmst", con);
    //        da.Fill(dtt);

    //        List<string> objProductList = new List<string>(); ;
    //        String strPrdPrice = string.Empty;
    //        divUserID.InnerText = string.Empty;
    //        foreach (DataRow drw in dtt.Rows)
    //        {
    //            divUserID.InnerText += drw["appmstregno"].ToString() + ",";
    //        }
    //    }
    //    catch
    //    {
    //    }
    //    finally
    //    {
    //    }
    //}
    //private void chkdocketid()
    //{
    //    cmd = new SqlCommand("select * from courierdetails where docketid=@docketNo", con);
    //    cmd.Parameters.AddWithValue("@docketNo", txtDocketNumber.Text.Trim());
    //    con.Open();
    //    dr = cmd.ExecuteReader();

    //    if (dr.HasRows)
    //    {

    //        utility.MessageBox(this, "Duplicate Docket ID !");

    //    }
    //    else
    //    {
    //        con.Close();
    //        dispatch();
    //    }

    //}
    public void dispatch()
    {
        try
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime dispatchDate = new DateTime();
            dispatchDate = Convert.ToDateTime(txtDate.Text.Trim(), dateInfo);

            //cmd = new SqlCommand("insert into courierdetails (userid,description,couriercompany,docketid,dispatcheddate,authorname)values(@id,@description,@company,@DocketNo,@ddate,@from)", con);
            cmd = new SqlCommand("addcourier", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", txtIdNo.Text.Trim());
            cmd.Parameters.AddWithValue("@description", txtDescription.Text.Trim());
            cmd.Parameters.AddWithValue("@company", txtCompany.Text.Trim());
            cmd.Parameters.AddWithValue("@DocketNo", txtDocketNumber.Text.Trim());
            cmd.Parameters.AddWithValue("@ddate", dispatchDate);
            cmd.Parameters.AddWithValue("@from", Session["admin"].ToString());
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            string value = cmd.Parameters["@flag"].Value.ToString();
            if (value == "1")
            {
                utility.MessageBox(this, "Dispatched Successfully !");
                con = new SqlConnection(method.str);
                cmd = new SqlCommand("getUserMobile", con);
                cmd.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("@userid", txtIdNo.Text);
                adp.Fill(dt);
                //string Text = "Dear " + dr["membername"].ToString() + " Your  Password is:" + dr["AppMstPassword"].ToString();
                string Text = "Dear " + dt.Rows[0]["name"].ToString() + " " + dt.Rows[0]["AppMstRegNo"].ToString() + "your courier dispatched from  " + txtCompany.Text + "POD No." + txtDocketNumber.Text + ".Thanks.";
                obj.sendSMSCjstore(dt.Rows[0]["AppMstMobile"].ToString(), Text);

                txtIdNo.Text = String.Empty;
                txtDescription.Text = String.Empty;
                txtCompany.Text = String.Empty;
                txtDocketNumber.Text = String.Empty;
                txtDate.Text = String.Empty;
            }
            else
            {
                utility.MessageBox(this, value.ToString());
            }
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }

        finally
        {
             con.Close();

        }

    }

}
