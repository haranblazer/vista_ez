using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;
using System.Net;
using System.IO;

public partial class admin_Enquiry : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    SqlCommand cmd;
    DataTable dt;
    utility objutil = new utility();
    string body;
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

            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.Date.AddDays(-1).ToString("dd/MM/yyyy").Replace("-","/");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
                GetEnquiry();

            }
        }
        catch
        {

        }
       
    }
    public void GetEnquiry()
    {
        try
        {

            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            string fromDate = "";
            string toDate = "";
            try
            {
                if (txtFromDate.Text.Trim().Length > 0)
                    fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo).ToString();
                if (txtToDate.Text.Trim().Length > 0)
                    toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo).ToString();
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }
            //DateTime fromDate = new DateTime();
            //DateTime toDate = new DateTime();
            //fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            //toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
            //string fromDate = "", toDate = "";
            try
            {
                if (txtFromDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
                if (txtToDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }
            //double datedays = (toDate - fromDate).TotalDays;

           // if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
          //  {
                cmd = new SqlCommand("GetEnquiryDetail", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@mindate", fromDate);
                cmd.Parameters.AddWithValue("@maxdate", toDate);
                cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                con.Open();
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {

                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                else
                {
                    DataTable dtnull = new DataTable();
                    GridView1.DataSource = dtnull;
                    GridView1.DataBind();
                    txtRpy.Visible = false;
                    btnRpy.Visible = false;
                }
                con.Close();
            //}
            //else
            //{
            //    DataTable dtnull = new DataTable();
            //    GridView1.DataSource = dtnull;
            //    GridView1.DataBind();
            //    txtRpy.Visible = false;
            //    btnRpy.Visible = false;
            //}
        }
        catch
        {

        }
        finally
        {
            //con.Close();
            //cmd.Dispose();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        GetEnquiry();
    }

    protected void btnReply_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            TextBox txtMsg = row.FindControl("txtReply") as TextBox;
            if (!string.IsNullOrEmpty(txtMsg.Text.Trim()))
            {
                Session["id"] = row.Cells[6].Text;
                string name = row.Cells[2].Text;
                string mobile = row.Cells[3].Text;
                string email = row.Cells[4].Text;
                Session["qry"] = row.Cells[5].Text;
                Session["msg"] = txtMsg.Text.Trim();
                PopulateBody(name, email, Session["qry"].ToString(), Session["msg"].ToString(), Session["id"].ToString());
                InsertCmt();
                utility.MessageBox(this, "Replied Successfully.");
            }
            else if (string.IsNullOrEmpty(txtMsg.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter some text to reply.");
                txtMsg.Focus();
                txtMsg.Focus();
            }
        }
        catch
        {

        }


    }

    protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow && (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate))
            {
                CheckBox chkBxSelect = (CheckBox)e.Row.Cells[0].FindControl("chkSelect");
                CheckBox chkBxHeader = (CheckBox)this.GridView1.HeaderRow.FindControl("chkAll");
                chkBxSelect.Attributes["onclick"] = string.Format("javascript:ChildClick(this,'{0}');", chkBxHeader.ClientID);
            }
        }
        catch
        {

        }
    }
    protected void btnRpy_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (((CheckBox)row.FindControl("chkSelect")).Checked && !string.IsNullOrEmpty(txtRpy.Text.Trim()))
                {
                    string enqid = row.Cells[6].Text;
                    string name = row.Cells[2].Text;
                    string mobile = row.Cells[3].Text;
                    string email = row.Cells[4].Text;
                    Session["qry"] = row.Cells[5].Text;
                    Session["rply"] = txtRpy.Text.Trim();
                    PopulateBody(name, email, Session["qry"].ToString(), Session["rply"].ToString(), Session["id"].ToString());
                    InsertReplyAllCmt(Session["rply"].ToString(), Convert.ToInt32(enqid));
                    utility.MessageBox(this, "Replied successfully.");
                }
               
            }
        }
        catch
        {

        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        GetEnquiry();
    }
    public void InsertCmt()
    {
        try
        {
            cmd = new SqlCommand("update enquirymst set Reply=@reply,status=@status,RplyDate=@rplydate  where enquiryid=@id", con);
            con.Open();
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@id", Session["id"]);
            cmd.Parameters.AddWithValue("@reply", Session["msg"].ToString());
            cmd.Parameters.AddWithValue("@status", 1);
            cmd.Parameters.AddWithValue("@rplydate", DateTime.UtcNow.AddMinutes(330));
            cmd.ExecuteNonQuery();
            con.Close();
            GetEnquiry();
            


        }
        catch
        {

        }
    }
    public void InsertReplyAllCmt(string msg, int enqid)
    {
        try
        {

            cmd = new SqlCommand("ReplyAllCmt", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@enqId", enqid);
            cmd.Parameters.AddWithValue("@rplyAll", msg);
            cmd.Parameters.AddWithValue("@status",1);
            cmd.Parameters.AddWithValue("@rplydate", DateTime.UtcNow.AddMinutes(330));
            cmd.ExecuteNonQuery();
            con.Close();
            GetEnquiry();
            
        }
        catch
        {

        }
       
       
    }
    private void PopulateBody(string name, string email, string qry, string msg,string id)
    {

        string ActivationUrl;
        ActivationUrl = "http://eksbd.com";

        WebRequest request = WebRequest.Create("http://eksbd.com/Mailer/EnquiryA.htm");
        WebResponse response = request.GetResponse();
        Stream data = response.GetResponseStream();
        using (StreamReader sr = new StreamReader(data))
        {
            body = sr.ReadToEnd();
        }
        body = body.Replace("dt", DateTime.Now.ToString("dd/MM/yyyy"));
        body = body.Replace("Enqid", id);
        body = body.Replace("{qst}", qry);
        body = body.Replace("{msg}", msg);
        body = body.Replace("{Name}", name);
        body = body.Replace("{cn}", objutil.companyname().AsEnumerable().FirstOrDefault().Field<string>("companyname"));
        body = body.Replace("{cmpeml}", objutil.companyname().AsEnumerable().FirstOrDefault().Field<string>("emailid"));
        body = body.Replace("{Link}", "<a href='" + ActivationUrl + "'>Click here for visit site</a>");
        objutil.SendbyZoho(email, "EKSBD : Enquiry Details", body);

    }
}

