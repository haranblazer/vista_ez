using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;
using System.Web.UI.HtmlControls;
using System.Runtime.CompilerServices;
using System.IO;
using System.Security.Cryptography;
using System.Xml;
using ASP;
using System.Text.RegularExpressions;
using System.Collections;
using System.Xml.Linq;

public partial class blog : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    int blogid = 0;
    readonly PagedDataSource _pgsource = new PagedDataSource();
    int _firstIndex, _lastIndex;
    private int _pageSize = 5;
    private int CurrentPage
    {
        get
        {
            if (ViewState["CurrentPage"] == null)
            {
                return 0;
            }
            return ((int)ViewState["CurrentPage"]);
        }
        set
        {
            ViewState["CurrentPage"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        var qryParam = Request.Url.Query;
        if (!String.IsNullOrEmpty(qryParam))
            blogid = Convert.ToInt32(Regex.Match(qryParam, @"\d+").Value);
        else
        {
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            path = path.Replace("/Blog/", "");
            h1.InnerText = path.Replace("-", " ");
        }

        BindBlogList();
        if (h1.InnerText != "")
        {
            BindBlogComments();
        }
        if (Page.IsPostBack) return;
        BindBlogDetails(h1.InnerText);
        //BindCategoriesTags();
    }


    protected override void OnLoad(EventArgs e)
    {
        Page.Title = "Your Title";
        base.OnLoad(e);
    }

    public void BindBlogComments()
    {
        using (SqlCommand cmd = new SqlCommand("Select * from TB_BlogComments where blogid=" + blogid + "", con))
        {
            cmd.Parameters.AddWithValue("@blogid", blogid);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            rptComments.DataSource = dt;
            rptComments.DataBind();
        }
    }

    public void BindBlogList()
    {
        try
        {
            using (SqlCommand cmd = new SqlCommand("GetBlogsDetails", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@type", "BlogList");
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                foreach (DataRow DR in dt.Rows)
                {
                    if (DR["Title"].ToString() != h1.InnerText)
                    {
                        HtmlGenericControl li = new HtmlGenericControl("li");
                        tabs.Controls.Add(li);

                        HtmlGenericControl anchor = new HtmlGenericControl("a");
                        anchor.Attributes.Add("href", "../Blog/" + DR["Title"].ToString().Replace(' ', '-'));
                        anchor.InnerText = DR["Title"].ToString();
                        li.Controls.Add(anchor);
                    }
                }
            }
        }
        catch (Exception ex)
        {
        }
    }
    public void BindCategoriesTags()
    {
        using (SqlCommand cmd = new SqlCommand("GetBlogCategories_Tags", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);

        }
    }
    internal void BindBlogDetails(string title)
    {
        try
        {
            if (string.IsNullOrEmpty(title))
                singleBlog.Visible = false;
            else
                multipleBlog.Visible = false;

            using (SqlConnection conn = new SqlConnection(method.str))
            {
                SqlCommand cmd = new SqlCommand("GetBlogsDetailsByBlogID", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@blogid", blogid);
                cmd.Parameters.AddWithValue("title", title);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                if(dt.Rows.Count == 0)
                {
                    messagediv.InnerHtml = "<p>There are no blogs to view</p>";
                }
                if (string.IsNullOrEmpty(title))
                {
                 
                    _pgsource.DataSource = dt.DefaultView;
                    _pgsource.AllowPaging = true;
                    // Number of items to be displayed in the Repeater
                    _pgsource.PageSize = _pageSize;
                    _pgsource.CurrentPageIndex = CurrentPage;
                    // Keep the Total pages in View State
                    ViewState["TotalPages"] = _pgsource.PageCount;
                    // Example: "Page 1 of 10"
                    lblpage.Text = "Page " + (CurrentPage + 1) + " of " + _pgsource.PageCount;
                    // Enable First, Last, Previous, Next buttons
                    lbPrevious.Enabled = !_pgsource.IsFirstPage;
                    lbNext.Enabled = !_pgsource.IsLastPage;
                    lbFirst.Enabled = !_pgsource.IsFirstPage;
                    lbLast.Enabled = !_pgsource.IsLastPage;

                    // Bind data into repeater
                    rptBlogs.DataSource = _pgsource;
                    rptBlogs.DataBind();


                    // Call the function to do paging
                    HandlePaging();
                }
                else
                {
                    if (!Convert.ToBoolean(dt.Rows[0]["published"]))
                    {
                        singleBlog.Visible = false;
                        messagediv.InnerHtml = "<p>This blog is not published yet. <br/>You will be able to see once it is published.</p>";
                    }
                    HtmlMeta meta = new HtmlMeta();
                    meta.Name = "Description";
                    meta.Content = dt.Rows[0]["description"].ToString();
                    blogid = Convert.ToInt32(dt.Rows[0]["blogid"]);
                    //HtmlTitle tile = new HtmlTitle();
                    //this.Page.Header.Controls.Add(meta);
                    //tile.Text = h1.InnerText;
                    //this.Page.Header.Controls.Add(tile);

                    this.Page.Title = h1.InnerText + " | " + "ezcarestore.com";
                    lblCreated_DT.Text = dt.Rows[0]["created_dt"].ToString();
                    lblContent.Text = dt.Rows[0]["content"].ToString();
                    imgBlog.ImageUrl = "~/images/blog/" + dt.Rows[0]["imageName"].ToString();
                    if (!Convert.ToBoolean(dt.Rows[0]["showComments"]))
                        divComments.Visible = false;
                    else
                        divComments.Visible = true;
                }

            }
        }
        catch (Exception ex)
        {

        }
    }



    protected void post_click(object sender, EventArgs e)
    {

        using (SqlCommand cmd = new SqlCommand("AddBlogComment", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@comment", comments.Text);
            cmd.Parameters.AddWithValue("@blogid", blogid);
            cmd.Parameters.AddWithValue("comment_by", "user");
            cmd.Parameters.AddWithValue("comment_dt", DateTime.Now);
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
            BindBlogComments();
            comments.Text = "";
        }

    }
    public string Convert_DT_XML(DataTable dt)
    {
        MemoryStream stream = new MemoryStream();
        dt.WriteXml(stream, true);
        stream.Seek(0, SeekOrigin.Begin);
        StreamReader rdr = new StreamReader(stream);
        string xmlstr;
        xmlstr = rdr.ReadToEnd();
        return (xmlstr);
    }

    private void HandlePaging()
    {
        var dt = new DataTable();
        dt.Columns.Add("PageIndex"); //Start from 0
        dt.Columns.Add("PageText"); //Start from 1

        _firstIndex = CurrentPage - 5;
        if (CurrentPage > 5)
            _lastIndex = CurrentPage + 5;
        else
            _lastIndex = 10;

        // Check last page is greater than total page then reduced it to total no. of page is last index
        if (_lastIndex > Convert.ToInt32(ViewState["TotalPages"]))
        {
            _lastIndex = Convert.ToInt32(ViewState["TotalPages"]);
            _firstIndex = _lastIndex - 10;
        }

        if (_firstIndex < 0)
            _firstIndex = 0;

        // Now creating page number based on above first and last page index
        for (var i = _firstIndex; i < _lastIndex; i++)
        {
            var dr = dt.NewRow();
            dr[0] = i;
            dr[1] = i + 1;
            dt.Rows.Add(dr);
        }

        rptPaging.DataSource = dt;
        rptPaging.DataBind();
    }
    protected void lbFirst_Click(object sender, EventArgs e)
    {
        CurrentPage = 0;
        BindBlogDetails("");
    }

    protected void lbLast_Click(object sender, EventArgs e)
    {
        CurrentPage = (Convert.ToInt32(ViewState["TotalPages"]) - 1);
        BindBlogDetails("");
    }

    protected void lbPrevious_Click(object sender, EventArgs e)
    {
        CurrentPage -= 1;
        BindBlogDetails("");
    }
    protected void lbNext_Click(object sender, EventArgs e)
    {
        CurrentPage += 1;
        BindBlogDetails("");
    }
    protected void rptPaging_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (!e.CommandName.Equals("newPage")) return;
        CurrentPage = Convert.ToInt32(e.CommandArgument.ToString());
        BindBlogDetails("");
    }

    protected void rptPaging_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        var lnkPage = (LinkButton)e.Item.FindControl("lbPaging");
        if (lnkPage.CommandArgument != CurrentPage.ToString()) return;
        lnkPage.Enabled = false;
        lnkPage.BackColor = Color.FromName("#00FF00");
    }
}