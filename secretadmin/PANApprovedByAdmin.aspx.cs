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

public partial class secretadmin_PANApprovedByAdmin : System.Web.UI.Page
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
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!Page.IsPostBack)
            {
                BindBlogDetails();
            }
        }
        catch
        {

        }
       


    }
    protected void GridAllBlogs_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridAllBlogs.PageIndex = e.NewPageIndex;
        BindBlogDetails();
    }

    public void BindBlogDetails()
    {
        try
        {
            cmd = new SqlCommand("GetApprovedPANList", con);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridAllBlogs.DataSource = dt;
                GridAllBlogs.DataBind();
            }
            else
            {
                GridAllBlogs.DataSource = null;
                GridAllBlogs.DataBind();
            }

        }
        catch (Exception ex)
        {

        }
    }

    //protected void GridAllBlogs_RowDataBound(object sender, GridViewRowEventArgs e)
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

    
    [WebMethod]
    public static bool ApproveUserPan(int userid)
    {
        string mobile,Name = "";
        if (HttpContext.Current.Session["admin"] == null)
        {
            return false;
        }
        SqlConnection con = new SqlConnection(method.str);
        
        SqlCommand cmd = new SqlCommand("UpdatePANStatus", con);
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
            text = "Dear " + subUserName + " ID No :" + userid + " KYC for Pan Approved ";
        }
        else //Dear {#var#} ID No {#var#} Invoice No: {#var#} Invoice Amt : {#var#} generated successfully
        {
            text = "Dear " + Name + " ID No :" + userid + " KYC for Pan Approved ";
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
    public static bool RejectUserPan(int userid)
    {
        string mobile, Name = "";
        if (HttpContext.Current.Session["admin"] == null)
        {
            return false;
        }
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("PANRejection", con);
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
                text = "Dear " + subUserName + " ID No :" + userid + " KYC for Pan Rejected ";
            }
            else //Dear {#var#} ID No {#var#} Invoice No: {#var#} Invoice Amt : {#var#} generated successfully
            {
                text = "Dear " + Name + " ID No :" + userid + " KYC for Pan Rejected ";
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string username, userid, mobileno, text = string.Empty;
            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            string id = GridAllBlogs.DataKeys[row.RowIndex].Value.ToString();

            DropDownList ddlAR = (DropDownList)row.FindControl("ddlApproveReject");
            string apprej = ddlAR.SelectedValue.ToString();

            if (apprej == "1")
            {
                SqlCommand cmd = new SqlCommand("UpdatePANStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                int result = cmd.ExecuteNonQuery();
                con.Close();

                if (result > 0)
                {
                    utility.MessageBox(this, "PAN Approved Successfully.");
                }
            }
            else
            {
                userid = row.Cells[3].Text;
                username = row.Cells[4].Text;
                Label lblmob = (Label)row.FindControl("lblMobile");
                mobileno = lblmob.Text.Trim();
                text = "Dear " + userid + "," + " Name- " + username + " " + "your PAN image has been rejected.";
                System.Web.UI.WebControls.Image img = (System.Web.UI.WebControls.Image)row.FindControl("PANImage");
                string path = Server.MapPath(img.ImageUrl);
                FileInfo info = new FileInfo(path);
                if (info.Exists)
                {
                    info.Delete();
                }
                SqlCommand cmd = new SqlCommand("PANRejection", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                int rslt = cmd.ExecuteNonQuery();
                con.Close();
                if (rslt > 0)
                {
                    objutil.sendSMSByPage(mobileno.Trim(), text.Trim());
                    utility.MessageBox(this, "PAN Image Rejected Successfully.");
                }

            }
            BindBlogDetails();
        }
        catch
        {

        }
    }


    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        //string message = ddlSearch.SelectedItem.Text + " - " + ddlSearch.SelectedItem.Value;
        //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + message + "');", true);
        try
        {
            cmd = new SqlCommand("GetPANSearch", con);
            cmd.CommandType = CommandType.StoredProcedure;

            if (ddlSearch.SelectedValue.ToString() == "1")
            {
                cmd.Parameters.AddWithValue("@status", 2);
                GridAllBlogs.Columns[0].Visible = false;
            }
            else
            {
                cmd.Parameters.AddWithValue("@status", 1);
                GridAllBlogs.Columns[0].Visible = true;
            }
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                GridAllBlogs.DataSource = dt;
                GridAllBlogs.DataBind();
            }
            else
            {
                GridAllBlogs.DataSource = null;
                GridAllBlogs.DataBind();
            }
        }

        catch
        {

        }
    }

    protected void btnUserSearch_Click(object sender, EventArgs e)
    {
        try
        {
            cmd = new SqlCommand("GetPanSearchByUserID", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", txtSearch.Text.Trim());
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                GridAllBlogs.DataSource = dt;
                GridAllBlogs.DataBind();
                if (dt.Rows[0]["sts"].ToString() == "Approved")
                {
                    utility.MessageBox(this, "User is Already Approved.");
                    GridAllBlogs.Columns[0].Visible = false;
                }
                else
                {
                    utility.MessageBox(this, "User Approval Pending.");
                    GridAllBlogs.Columns[0].Visible = true;
                }

            }
            else
            {
                GridAllBlogs.DataSource = null;
                GridAllBlogs.DataBind();
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
                SqlCommand cmd = new SqlCommand("UpdatePANStatus", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@regno", value);
                con.Open();
                result = cmd.ExecuteNonQuery();
                con.Close();

            }

            utility.MessageBox(this, "PAN Approved Successfully.");
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
                SqlCommand cmd = new SqlCommand("PANRejection", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@regno", value);
                con.Open();
                result = cmd.ExecuteNonQuery();
                con.Close();

            }
            utility.MessageBox(this, "PAN Image Rejected Successfully.");
        }

        Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri);
        GridAllBlogs.DataBind();


    }


}

public class CheckRepository
{


    public IEnumerable<Check> GetList()
    {
        var list = new List<Check>();
        for (int i = 0; i < 20; i++)
        {
            var cheque = new Check()
            {
                userid = string.Format("{0:00000000}", i + 1),
                panDateApprove = DateTime.Now
            };
            list.Add(cheque);
        }
        return list;
    }
}

public class Check
{


    public DateTime panDateLoaded { get; set; }

    public string userid { get; set; }

    public string appmstfname { get; set; }

    public DateTime dob { get; set; }

    public int panno { get; set; }

    public DateTime panDateApprove { get; set; }
}