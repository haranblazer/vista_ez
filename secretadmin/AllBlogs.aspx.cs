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

public partial class secretadmin_blog_AllBlogs : System.Web.UI.Page
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
                Response.Redirect("~/secretadmin/logout.aspx");

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
            cmd = new SqlCommand("GetBlogsDetails", con);
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




    protected void btnDelete_Click(object sender, EventArgs e)
    {
        int blogid = 0;
        Button btn = (Button)sender;
        foreach (GridViewRow row in GridAllBlogs.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);
                if (chkRow.Checked)
                {
                    blogid = Convert.ToInt32(GridAllBlogs.DataKeys[row.RowIndex].Value);
                    UpdateActiveInactiveBlog(blogid, btn.Text);
                }
            }
        }
    }
    protected void UpdateActiveInactiveBlog(int id, string type)
    {
        using (SqlCommand cmd = new SqlCommand("UpdateActiveInactiveBlog", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@blogid", id);
            cmd.Parameters.AddWithValue("@type", type);
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
        }
        BindBlogDetails();
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


    

    protected void ADD_Click(object sender, EventArgs e)
    {

    }

    protected void Save_Click(object sender, EventArgs e)
    {

    }
    protected void Edit_Click(object sender, EventArgs e)
    {
        using (GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent)
        {
            txtCustomerID.ReadOnly = true;
            txtCustomerID.Text = row.Cells[0].Text;
            txtContactName.Text = row.Cells[1].Text;
            txtDescription.Text = row.Cells[4].Text;
            popup.Show();
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