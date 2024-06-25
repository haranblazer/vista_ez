using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Drawing;
using System.Text;
using System.Web.Services;

public partial class secretadmin_AddressApprovedByAdmin : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd = null;
    SqlDataAdapter da;
    DataTable dt;
    utility objutil = new utility();
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
                BindApprovedAddressList();
            }
        }
        catch
        {

        }
       
    }
    protected void GridApprovedAddressDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //GridApprovedAddressDetails.PageIndex = e.NewPageIndex;
        BindApprovedAddressList();
    }

    public void BindApprovedAddressList()
    {
        try
        {
            cmd = new SqlCommand("GetAddressSearch", con);
            cmd.CommandType = CommandType.StoredProcedure;
            if (ddlSearch.SelectedValue.ToString() == "1")
            {
                cmd.Parameters.AddWithValue("@status", 2);
                GridApprovedAddressDetails.Columns[0].Visible = false;
            }
            else
            {
                cmd.Parameters.AddWithValue("@status", 1);
                GridApprovedAddressDetails.Columns[0].Visible = true;
            }
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridApprovedAddressDetails.DataSource = dt;
                GridApprovedAddressDetails.DataBind();
            }
            else
            {
                GridApprovedAddressDetails.DataSource = null;
                GridApprovedAddressDetails.DataBind();
            }
        }
        catch
        {

        }
    }



    //protected void GridApprovedAddressDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {

    //        DropDownList ddlAR = (DropDownList)e.Row.FindControl("ddlApproveReject");
    //        Button btn = (Button)e.Row.FindControl("btnSubmit");
    //        if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "sts")) == "Approved")
    //        {
    //            ddlAR.SelectedIndex = ddlAR.Items.IndexOf(ddlAR.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, "Approved", true) == 0).FirstOrDefault());
    //            btn.Visible = false;
    //            e.Row.Enabled = false;
    //            e.Row.ToolTip = "Already Approved.";
    //            e.Row.BackColor = Color.FromName("#D5F5E3");
    //        }
    //        else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "sts")) == "Not Approved")
    //        {
    //            ddlAR.SelectedIndex = ddlAR.Items.IndexOf(ddlAR.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, "Not Approved", true) == 0).FirstOrDefault());
    //            btn.Visible = true;
    //            e.Row.ToolTip = "Not Approved.";
    //            e.Row.BackColor = Color.FromName("#FDEBD0");
    //        }
    //    }
    //}

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string username, userid, mobileno, text = string.Empty;
            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            string id = GridApprovedAddressDetails.DataKeys[row.RowIndex].Value.ToString();

            DropDownList ddlAR = (DropDownList)row.FindControl("ddlApproveReject");
            string apprej = ddlAR.SelectedValue.ToString();

            if (apprej == "1")
            {
                SqlCommand cmd = new SqlCommand("UpdateAddressStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                int result = cmd.ExecuteNonQuery();
                con.Close();

                if (result > 0)
                {
                    utility.MessageBox(this, "Address Approved Successfully.");
                }
            }
            else
            {
                userid = row.Cells[1].Text;
                username = row.Cells[2].Text;
                Label lblmob = (Label)row.FindControl("lblMobile");
                mobileno = lblmob.Text.Trim();
                text = "Dear " + userid + "," + " Name- " + username + " " + "your Address image has been rejected. Please upload fresh bank Image.";
                System.Web.UI.WebControls.Image img = (System.Web.UI.WebControls.Image)row.FindControl("AddressImage");
                string path = Server.MapPath(img.ImageUrl);
                FileInfo info = new FileInfo(path);
                if (info.Exists)
                {
                    info.Delete();
                }
                SqlCommand cmd = new SqlCommand("AddressRejection", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@regno", id);
                con.Open();
                int rslt = cmd.ExecuteNonQuery();
                con.Close();
                if (rslt > 0)
                {
                    objutil.sendSMSByPage(mobileno.Trim(), text.Trim());
                    utility.MessageBox(this, "Address Image Rejected Successfully.");
                }

            }
            BindApprovedAddressList();
        }
        catch
        {

        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            cmd = new SqlCommand("GetAddressSearch", con);
            cmd.CommandType = CommandType.StoredProcedure;

            if (ddlSearch.SelectedValue.ToString() == "1")
            {
                cmd.Parameters.AddWithValue("@status", 2);
            }
            else
            {
                cmd.Parameters.AddWithValue("@status", 1);
            }
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridApprovedAddressDetails.DataSource = dt;
                GridApprovedAddressDetails.DataBind();
            }
            else
            {
                GridApprovedAddressDetails.DataSource = null;
                GridApprovedAddressDetails.DataBind();
            }
        }

        catch
        {

        }
    }


    [WebMethod]
    public static bool ApproveUserAadhar(int userid)
    {
        string mobile, Name = "";
        if (HttpContext.Current.Session["admin"] == null)
        {
            return false;
        }
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("UpdateAddressStatus", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@regno", userid);
        con.Open();
        int result1 = cmd.ExecuteNonQuery();
        con.Close();
        if (result1 > 0)
        {
            string subUserName, text = "";
            if (Name.Length > 20)
            {
                subUserName = Name.Substring(0, 20).ToString();
                text = "Dear " + subUserName + " ID No :" + userid + " KYC for Address Approve ";
            }
            else //Dear {#var#} ID No {#var#} Invoice No: {#var#} Invoice Amt : {#var#} generated successfully
            {
                text = "Dear " + Name + " ID No :" + userid + " KYC for Address Approve ";
            }
            string querry = "select Appmst.appmstmobile,Appmst.appmstfname from  AppMst where AppMst.AppMstRegNo='" + userid + "'";
            SqlCommand cmd1 = new SqlCommand(querry, con);
            con.Open();
            cmd1.ExecuteScalar();
            using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
            {
                while (reader.Read())
                {
                    mobile = reader["appmstmobile"].ToString();
                    Name = reader["appmstfname"].ToString();
                    utility objUt = new utility();
                    objUt.sendSMSByBilling(mobile, text, "KYC");
                }

            }
        }
        return result1 > 0;

    }


    [WebMethod]
    public static bool RejectUserAadhar(int userid)
    {
        string mobile, Name = "";
        if (HttpContext.Current.Session["admin"] == null)
        {
            return false;
        }
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("AddressRejection", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@regno", userid);
        con.Open();
        int result1 = cmd.ExecuteNonQuery();
        con.Close();
        if (result1 > 0)
        {
            string subUserName, text = "";
            if (Name.Length > 20)
            {
                subUserName = Name.Substring(0, 20).ToString();
                text = "Dear " + subUserName + " ID No :" + userid + " KYC for Address Rejected ";
            }
            else //Dear {#var#} ID No {#var#} Invoice No: {#var#} Invoice Amt : {#var#} generated successfully
            {
                text = "Dear " + Name + " ID No :" + userid + " KYC for Address Rejected ";
            }
            string querry = "select Appmst.appmstmobile,Appmst.appmstfname from  AppMst where AppMst.AppMstRegNo='" + userid + "'";
            SqlCommand cmd1 = new SqlCommand(querry, con);
            con.Open();
            cmd1.ExecuteScalar();
            using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
            {
                while (reader.Read())
                {
                    mobile = reader["appmstmobile"].ToString();
                    Name = reader["appmstfname"].ToString();
                    utility objUt = new utility();
                    objUt.sendSMSByBilling(mobile, text, "KYC");
                }

            }
        }
        return result1 > 0;

    }

    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        //string message = ddlSearch.SelectedItem.Text + " - " + ddlSearch.SelectedItem.Value;
        //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + message + "');", true);
        BindApprovedAddressList();
    }

    protected void btnUserSearch_Click(object sender, EventArgs e)
    {
        try
        {
            cmd = new SqlCommand("GetAddressSearchByUserID", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", txtSearch.Text.Trim());
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridApprovedAddressDetails.DataSource = dt;
                GridApprovedAddressDetails.DataBind();
                if (dt.Rows[0]["sts"].ToString() == "Approved")
                {
                    utility.MessageBox(this, "User is Already Approved.");
                    GridApprovedAddressDetails.Columns[0].Visible = false;
                }
                else
                {
                    utility.MessageBox(this, "User Approval Pending.");
                    GridApprovedAddressDetails.Columns[0].Visible = true;
                }
            }
            else
            {
                GridApprovedAddressDetails.DataSource = null;
                GridApprovedAddressDetails.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private List<string> userids = new List<string>();
    protected void btncheck_Click(object sender, EventArgs e)
    {
        // create a string builder to create the displayed string
        var builder = new StringBuilder();
        // get the selected checkboxes from the form data
        int result;
        var checkString = Request.Form["ChequeSelected"];
        var checkRejString = Request.Form["ChequeSelectedrej"];

        if (checkString != null)
        {
            var values = checkString.Split(',');
            foreach (var value in values)
            {
                builder.Append("<br/>");
                builder.Append(value);
                userids.Add(value);
                con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("UpdateAddressStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@regno", value);
                con.Open();
                result = cmd.ExecuteNonQuery();
                con.Close();

            }

            utility.MessageBox(this, "Address Approved Successfully.");
        }

        if (checkRejString != null)
        {
            // we'll need a split to get the individual ids
            var valuesrej = checkRejString.Split(',');

            foreach (var value in valuesrej)
            {
                builder.Append("<br/>");
                builder.Append(value);
                userids.Add(value);
                con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("AddressRejection", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@regno", value);
                con.Open();
                result = cmd.ExecuteNonQuery();
                con.Close();

            }
            utility.MessageBox(this, "Address Rejected Successfully.");
        }

        Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri);
        GridApprovedAddressDetails.DataBind();


    }

}