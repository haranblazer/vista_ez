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
public partial class admin_BeforPayout : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    DataTable t = new DataTable();
   
    protected void Page_Load(object sender, EventArgs e)
    {
     //InsertFunction.CheckAdminlogin();
        if (!Page.IsPostBack)
        {
            club.Visible = false;
            closing.Visible = false;
        }
    }
    public void go1()
    {

    
        string StrCtype = "";
        
       
            #region Get the Income type
            //if (WelComeClub .Checked )
            //{
            //    StrCtype = "W";
            //}
           
            if (rdbtnC1.Checked )
            {
                StrCtype = "C1"; 
            }
            if (rdbtnC2.Checked)
            {
                StrCtype = "C2";

            }
            if (rdbtnC3.Checked)
            {
                StrCtype = "C3";
            }
            if (rdbtnC4.Checked)
            {
                StrCtype = "C4";
            }
            if (rdbtnC5.Checked)
            {
                StrCtype = "C5";
            }
            if (rdbtnC6.Checked)
            {
                StrCtype = "C6";
            }
            if (rdbtnC7.Checked)
            {
                StrCtype = "C7";
            }
            if (rdbtnC8.Checked)
            {
                StrCtype = "C8";
            }
            if (rdbtnC9.Checked)
            {
                StrCtype = "C9";
            }
            if (rdbtnC10.Checked)
            {
                StrCtype = "C10";
            }
            if (rdbtnC11.Checked)
            {
                StrCtype = "C11";
            }
            #endregion
            com = new SqlCommand("clubEntries", con);
            com.CommandType = CommandType.StoredProcedure;
            string str=DropDownList1.SelectedItem.Value;
            if(str.Contains ("Select"))
                str ="";
            com.Parameters.AddWithValue("@ClubType", StrCtype);

            com.Parameters.AddWithValue("@operation", "A");

            da = new SqlDataAdapter(com);
            da.Fill(t);
            if (t.Rows.Count > 0)
            {
                lbl.Text = "";
                GridView1.DataSource = t;
                GridView1.DataBind();
                Label1.Text =t.Rows.Count.ToString ();
                Label1.Visible = true;

            }
            else
            {

                lbl.Visible = true;
                lbl.Text = "No data Found !";
                GridView1 .DataSource=null ;
                GridView1 .DataBind ();
                Label1.Visible = false;
            }

       
    }

    public void goClosing()
    {


        string StrClosing = "";


        #region Get the Closing type

        if (DropDownList1.SelectedItem.Text == "1")
        {
            StrClosing = "1";
        }
        else if (DropDownList1.SelectedItem.Text == "2")
        {
            StrClosing = "2";
        }
        else
        {
        }
        #endregion
        com = new SqlCommand("clubEntries", con);
        com.CommandType = CommandType.StoredProcedure;
        string str = DropDownList1.SelectedItem.Value;
        if (str.Contains("Select"))
            str = "";
        com.Parameters.AddWithValue("@closingNo", StrClosing);
        com.Parameters.AddWithValue("@ClubType", "a");
        com.Parameters.AddWithValue("@operation", "ACLOSING");

        da = new SqlDataAdapter(com);
        da.Fill(t);
        if (t.Rows.Count > 0)
        {
            lbl.Text = "";
            GridView1.DataSource = t;
            GridView1.DataBind();
            Label1.Text = t.Rows.Count.ToString ();
            Label1.Visible = true;

        }
        else
        {

            lbl.Visible = true;
            lbl.Text = "No data Found !";
            GridView1.DataSource = null;
            GridView1.DataBind();
            Label1.Visible = false;
        }


    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (DropDownList2.SelectedValue == "1")
        {
            go1();
        }
        else if (DropDownList2.SelectedValue == "2")
        {
            goClosing();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
            lbl.Text = "";
            Label1.Text = "";
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        if (DropDownList2.SelectedValue == "1")
        {
            go1();
        }
        else if (DropDownList2.SelectedValue == "2")
        {
            goClosing();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
            lbl.Text = "";
            Label1.Text = "";
          
        }
    }

    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView1.DataSource = null;
        GridView1.DataBind();
        lbl.Text = "";
        Label1.Text = "";
        if (DropDownList2.SelectedValue == "1")
        {
            club.Visible = true;
            closing.Visible = false;
        }
        else if (DropDownList2.SelectedValue == "2")
        {
            club.Visible = false;
            closing.Visible = true;
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
            lbl.Text = "";
            Label1.Text = "";
        }
    }
  
    protected void Button3_Click(object sender, EventArgs e)
    {
        GridView1.PageSize = Convert.ToInt32(Label1.Text);
        go1();

        Response.Clear();

        Response.AddHeader("content-disposition", "attachment;filename=Downstatus.xls");

        Response.Charset = "";

        // If you want the option to open the Excel file without saving than

        // comment out the line below

        // Response.Cache.SetCacheability(HttpCacheability.NoCache);

        Response.ContentType = "application/vnd.xls";

        System.IO.StringWriter stringWrite = new System.IO.StringWriter();

        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

        GridView1.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());

        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
}
