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
    SqlDataAdapter da;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Logout.aspx");
        }
        if (!IsPostBack)
        {
           // BindUserID();
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
       
    //    cmd = new SqlCommand("select * from courierdetails where docketid=@docketNo",con);
    //    cmd.Parameters.AddWithValue("@docketNo",txtDocketNumber.Text.Trim());
    //    con.Open();
    //    dr = cmd.ExecuteReader();

    //    if (dr.HasRows)
    //    {

    //        utility.MessageBox(this,"Duplicate Docket ID !");

    //    }
    //    else
    //    { 
    //        con.Close();
    //        dispatch();
    //    }      
       
    // }
    //private int findFid(string username)
    //{
    //      da= new SqlDataAdapter("select franchiseid from franchisemst where franchiseid=@username",con);
    //      da.SelectCommand.Parameters.AddWithValue("@username", username);
    //      dt = new DataTable();
    //      da.Fill(dt);
    //      if (dt.Rows.Count > 0)
    //      {
    //          return (Convert.ToInt32(dt.Rows[0][0].ToString()));
    //      }
    //      return 0;
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
            cmd.Parameters.AddWithValue("@from", Session["franchiseid"].ToString());
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            string value = cmd.Parameters["@flag"].Value.ToString();
            if (value == "1")
                utility.MessageBox(this, "Dispatched Successfully !");
            else
                utility.MessageBox(this, value.ToString());
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
