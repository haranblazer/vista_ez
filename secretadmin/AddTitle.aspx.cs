using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_AddTitle : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    static string strDtl = "", Tid = "0", str = "";
 
    protected void Page_Load(object sender, EventArgs e)
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
        if (!IsPostBack)
        {
            BindTitle();
            if (Request.QueryString["T"] != null)
            {
                ddl_TitleType.SelectedValue = Request.QueryString["T"].ToString();
            }
        }
    }
      
    public void BindTitle()
    {
        String Qry = @"Select Tid, Title, TitleType, Isactive from TitleMst order by Tid desc";
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(Qry);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }

    }
     
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("AddTitle", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd); 
            cmd.Parameters.AddWithValue("@Title", txt_Title.Text);
            cmd.Parameters.AddWithValue("@TitleType", ddl_TitleType.SelectedValue);  
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            string flag = cmd.Parameters["@flag"].Value.ToString();
            if (flag == "1")
            { 
                BindTitle();
            }
            else
            {
                utility.MessageBox(this, flag);
                return;
            }
        }
        catch (Exception ex)
        {
        }
    }
     
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindTitle();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int rowindex = Convert.ToInt32(e.CommandArgument);
        GridViewRow row = GridView1.Rows[rowindex];
        HiddenField hnd_Tid = (HiddenField)row.FindControl("hnd_Tid");
        if (e.CommandName == "ACTIVE_DEACTIVE")
        {
            SqlCommand cmd = new SqlCommand("Update TitleMst set IsActive=(Case when IsActive=0 then 1 else 0 end) where Tid=@Tid", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@Tid", hnd_Tid.Value);
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception er) { }
            finally
            {
                con.Close();
            }
            BindTitle();
        }
    }

}