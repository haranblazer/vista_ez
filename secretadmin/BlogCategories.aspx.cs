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
    string id = string.Empty;
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
            cmd = new SqlCommand("Select * from Tb_BlogCategories", con);
            cmd.CommandType = CommandType.Text;
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

    

    
  


 

 


    

    protected void Save_Click(object sender, EventArgs e)
    {

        using (SqlCommand cmd = new SqlCommand("AddEditBlogCategories",con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@catid", hiddenID.Value);
            cmd.Parameters.AddWithValue("@catname", txtCatName.Text);
            cmd.Parameters.AddWithValue("@isActive", chkActive.Checked);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            BindBlogDetails();
        }
    }
    protected void AddEdit_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        if (btn == null)
        {
            using (GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent)
            {

                id = row.Cells[1].Text;
                hiddenID.Value = id;
                txtCatName.Text = row.Cells[2].Text;
                bool isActive = (row.FindControl("chkActice") as CheckBox).Checked;
                chkActive.Checked = isActive;
                
            }
        }
        else
        {
            hiddenID.Value= "0";
            txtCatName.Text = string.Empty;
            chkActive.Checked = false;
        }
        popup.Show();

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