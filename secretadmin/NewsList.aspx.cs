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
using System.IO;
public partial class admin_NewsList : System.Web.UI.Page
{
    SqlCommand cmd;
    SqlConnection cn = new SqlConnection(method.str);
    public static string photo;
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
                string str;
                str = Convert.ToString(Session["admin"]);
                getnews();
            }
        }
        catch
        {

        }



    }
    public void getnews()
    {
        string strSe = "Select newsmstid,convert(varchar(20),newsmstvalidupto,103) as newsmstvalidupto,UPPER(NewsMstTitle) AS NewsMstTitle,newsmstdiscription,currentrecord from NewsMst where newstype='" + ddlNewsType.SelectedValue.ToString() + "'ORDER BY NewsMstId DESC  ";
        SqlDataAdapter da = new SqlDataAdapter(strSe, cn);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
            grdHideShow.Visible = true;
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
            grdHideShow.Visible = false;

        }

    }

    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            getnews();
        }
        catch (Exception ex)
        {

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string gvIDs = "";
        bool chkBox = false;

        foreach (GridViewRow gv in GridView1.Rows)
        {
            CheckBox deleteChkBxItem = (CheckBox)gv.FindControl("deleteRec");
            if (deleteChkBxItem.Checked)
            {
                chkBox = true;
                gvIDs += ((Label)gv.FindControl("EmpID")).Text.ToString() + ",";
            }

        }

        if (chkBox)
        {

            try
            {


                string s1 = "select photo from newsmst where NewsmstID IN (" +
              gvIDs.Substring(0, gvIDs.LastIndexOf(",")) + ")";

                cmd = new SqlCommand(s1, cn);
                cn.Open();
                SqlDataReader dr;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {

                    photo = dr["photo"].ToString();

                }

                dr.Close();
                cn.Close();



                string path = Server.MapPath(@"~/KYC/News/" + photo);
                FileInfo file = new FileInfo(path);
                if (file.Exists)//check file exsit or not
                {
                    file.Delete();
                    ////    lbl_output.Text = file_name + " file deleted successfully";
                    ////    lbl_output.ForeColor = Color.Green;
                }


                string deleteSQL = "DELETE from NewsMst WHERE NewsmstID IN (" +
                  gvIDs.Substring(0, gvIDs.LastIndexOf(",")) + ")";
                cmd = new SqlCommand(deleteSQL, cn);
                cn.Open();
                cmd.ExecuteNonQuery();

                string strSe = "Select newsmstid,convert(varchar(20),newsmstvalidupto,103) as newsmstvalidupto,NewsMstTitle,newsmstdiscription,currentrecord from NewsMst where newstype='" + ddlNewsType.SelectedValue.ToString() + "'";
                SqlDataAdapter da = new SqlDataAdapter(strSe, cn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();

                    grdHideShow.Visible = true;
                }
                else
                {
                    grdHideShow.Visible = false;
                }

                utility.MessageBox(this, "News deleted successfully");

            }
            catch (SqlException err)
            {
                Response.Write(err.Message.ToString());
            }
            finally
            {
                cn.Close();
            }

        }
    }


    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        GridView1.PageIndex = e.NewPageIndex;
        getnews();

    }



}