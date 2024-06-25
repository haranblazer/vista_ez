using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.IO;
using System.Text;
using System.Web.Services;

public partial class secretadmin_BankApprovedByAdmin : System.Web.UI.Page
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
                BindApprovedBankList();
            }
         
        }
        catch
        {

        }

        
    }
    protected void GridApprovedBankDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridApprovedBankDetails.PageIndex = e.NewPageIndex;
        BindApprovedBankList();
    }

    public void BindApprovedBankList()
    {
        try
        {
            cmd = new SqlCommand("GetApprovedBankList", con);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridApprovedBankDetails.DataSource = dt;
                GridApprovedBankDetails.DataBind();
            }
            else
            {
                GridApprovedBankDetails.DataSource = null;
                GridApprovedBankDetails.DataBind();
            }

        }
        catch (Exception ex)
        {

        }
    }

    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        //string message = ddlSearch.SelectedItem.Text + " - " + ddlSearch.SelectedItem.Value;
        //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + message + "');", true);
        try
        {
            cmd = new SqlCommand("GetSearchResult", con);
            cmd.CommandType = CommandType.StoredProcedure;

            if (ddlSearch.SelectedValue.ToString() == "1")
            {
                cmd.Parameters.AddWithValue("@status", 2);
                GridApprovedBankDetails.Columns[0].Visible = false;
            }
            else
            {
                cmd.Parameters.AddWithValue("@status", 1);
                GridApprovedBankDetails.Columns[0].Visible = true;
            }
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridApprovedBankDetails.DataSource = dt;
                GridApprovedBankDetails.DataBind();
            }
            else
            {
                GridApprovedBankDetails.DataSource = null;
                GridApprovedBankDetails.DataBind();
            }
        }

        catch (Exception ex)
        {

        }
    }


    //protected void GridApprovedBankDetails_RowDataBound(object sender, GridViewRowEventArgs e)
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


    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        string username, userid, mobileno, text = string.Empty;
    //        GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
    //        string id = GridApprovedBankDetails.DataKeys[row.RowIndex].Value.ToString();

    //        DropDownList ddlAR = (DropDownList)row.FindControl("ddlApproveReject");
    //        string apprej = ddlAR.SelectedValue.ToString();

    //        if (apprej == "1")
    //        {
    //            SqlCommand cmd = new SqlCommand("UpdateBankStatus", con);
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@id", id);
    //            con.Open();
    //            int result = cmd.ExecuteNonQuery();
    //            con.Close();

    //            if (result > 0)
    //            {
    //                utility.MessageBox(this, "Bank Approved Successfully.");
    //            }
    //        }
    //        else
    //        {
    //            userid = row.Cells[1].Text;
    //            username = row.Cells[2].Text;
    //            Label lblmob = (Label)row.FindControl("lblMobile");
    //            mobileno = lblmob.Text.Trim();
    //            text = "Dear " + userid + "," + " Name- " + username + " " + "your bank image has been rejected. Please upload fresh bank Image.";
    //            System.Web.UI.WebControls.Image img = (System.Web.UI.WebControls.Image)row.FindControl("bankimage");
    //            string path = Server.MapPath(img.ImageUrl);
    //            FileInfo info = new FileInfo(path);
    //            if (info.Exists)
    //            {
    //                info.Delete();
    //            }
    //            SqlCommand cmd = new SqlCommand("BankRejection", con);
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@id", id);
    //            con.Open();
    //            int rslt = cmd.ExecuteNonQuery();
    //            con.Close();
    //            if (rslt > 0)
    //            {
    //                objutil.sendSMSByPage(mobileno.Trim(), text.Trim());
    //                utility.MessageBox(this, "Bank Image Rejected Successfully.");
    //            }

    //        }
    //        BindApprovedBankList();
    //    }
    //    catch
    //    {

    //    }
    //}
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            cmd = new SqlCommand("GetSearchResult", con);
            cmd.CommandType = CommandType.StoredProcedure;

            if (ddlSearch.SelectedValue.ToString() == "1")
            {
                cmd.Parameters.AddWithValue("@status", 2);
                GridApprovedBankDetails.Columns[0].Visible = false;
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
                GridApprovedBankDetails.DataSource = dt;
                GridApprovedBankDetails.DataBind();
            }
            else
            {
                GridApprovedBankDetails.DataSource = null;
                GridApprovedBankDetails.DataBind();
            }
        }

        catch
        {

        }
    }


    [WebMethod]
    public static bool ApproveUserPan(int userid)
    {
        string mobile, Name = "";
        if (HttpContext.Current.Session["admin"] == null)
        {
            return false;
        }
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("UpdateBankStatus", con);
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
                text = "Dear " + subUserName + " ID No :" + userid + " KYC for Bank Approved ";
            }
            else //Dear {#var#} ID No {#var#} Invoice No: {#var#} Invoice Amt : {#var#} generated successfully
            {
                text = "Dear " + Name + " ID No :" + userid + " KYC for Bank Approved ";
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
    public static bool RejectUserBank(int userid)
    {
        string mobile, Name = "";
        if (HttpContext.Current.Session["admin"] == null)
        {
            return false;
        }
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("BankRejection", con);
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
                text = "Dear " + subUserName + " ID No :" + userid + " KYC for Bank Rejected ";
            }
            else //Dear {#var#} ID No {#var#} Invoice No: {#var#} Invoice Amt : {#var#} generated successfully
            {
                text = "Dear " + Name + " ID No :" + userid + " KYC for Bank Rejected ";
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

    protected void btnUserSearch_Click(object sender, EventArgs e)
    {
        try
        {
            cmd = new SqlCommand("GetBankSearchByUserID", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", txtSearch.Text.Trim());
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridApprovedBankDetails.DataSource = dt;
                GridApprovedBankDetails.DataBind();
                if (dt.Rows[0]["sts"].ToString() == "Approved")
                {
                    utility.MessageBox(this, "User Bank is Already Approved.");
                    GridApprovedBankDetails.Columns[0].Visible = false;
                }
                else
                {
                    utility.MessageBox(this, "User Bank Approval Pending.");
                    GridApprovedBankDetails.Columns[0].Visible = true;
                }
            }
            else
            {
                GridApprovedBankDetails.DataSource = null;
                GridApprovedBankDetails.DataBind();
            }
        }
        catch
        {

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
                SqlCommand cmd = new SqlCommand("UpdateBankStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@regno", value);
                con.Open();
                result = cmd.ExecuteNonQuery();
                con.Close();

            }

            utility.MessageBox(this, "Bank Approved Successfully.");
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
                SqlCommand cmd = new SqlCommand("BankRejection", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@regno", value);
                con.Open();
                result = cmd.ExecuteNonQuery();
                con.Close();

            }
            utility.MessageBox(this, "Bank Rejected Successfully.");
        }

        Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri);
        GridApprovedBankDetails.DataBind();


    }
}