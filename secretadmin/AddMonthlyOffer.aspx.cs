using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class secretadmin_AddMonthlyOffer : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    static string strDtl = "", Mid = "0", str = "";



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
            txtStartDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            txtExpDate.Text = DateTime.Now.AddMonths(+1).Date.ToString("dd/MM/yyyy").Replace("-", "/");
            BindTour(); 

            if (Request.QueryString["Mid"] != null)
            {
                Mid = Request.QueryString["Mid"].ToString();
                BindData(Mid);
            }

        }
    }





    public void BindData(string MId)
    { 
        String Qry = @"Select BV_Point, Commission, UserType, FranType, BillType,
            StartDate = convert(nvarchar, StartDate, 103), EndDate = convert(nvarchar, EndDate, 103), IsActive
            from MonthlyIncome_Slab t where MId=@MId";
        SqlParameter[] param1 = new SqlParameter[]
           {
                new SqlParameter("@MId", MId)
           };

        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param1, Qry);

        if (dt.Rows.Count > 0)
        {
            txtStartDate.Text = dt.Rows[0]["StartDate"].ToString();
            txtExpDate.Text = dt.Rows[0]["EndDate"].ToString();

            ddl_BillType.SelectedValue = dt.Rows[0]["BillType"].ToString();
            txt_BV_Point.Text = dt.Rows[0]["BV_Point"].ToString();
            txt_Commission.Text = dt.Rows[0]["Commission"].ToString();
            ddl_UserType.Text = dt.Rows[0]["UserType"].ToString();
            ddl_FranchiseType.SelectedValue = dt.Rows[0]["FranType"].ToString(); 
            ddl_Inc_Type_Cause.SelectedValue = dt.Rows[0]["Inc_Type_Cause"].ToString(); 
            if (dt.Rows[0]["IsActive"].ToString() == "1")
                chkIsActive.Checked = true;
            else
                chkIsActive.Checked = false;

            ddl_UserType.Enabled = false;
            ddl_FranchiseType.Enabled = false; 
            chkIsActive.Enabled = false;
        }
        else
        {
            txt_BV_Point.Text = "0";
            txt_Commission.Text = "0";
            ddl_UserType.SelectedValue = "0";
            ddl_FranchiseType.SelectedValue = "0";
            txtStartDate.Text = "";
            txtExpDate.Text = "";
            chkIsActive.Checked = false;
        }

    }

    public void BindTour()
    {
                       

        String Qry = @"Select MId, StartDate = convert(nvarchar, StartDate, 103), EndDate = convert(nvarchar, EndDate, 103),
        BV_Point, Commission, UserType=(Case when UserType=1 then 'Associate' else 'Franchise' End), 
        FranType=(Select Item_Desc from Item_Collection where Itemid=4 and UserVal=m.FranType), 
        BillType=(Case when BillType=1 then 'Topper' when BillType=3 then 'Generation' else 'Franchise' End) ,IsActive, 
        Inc_Type_Cause=(Case When isnull(Inc_Type_Cause,0)=1 then 'Offer Income 1' When isnull(Inc_Type_Cause,0)=2 
        then 'Offer Income 2' else '' End)

        from MonthlyIncome_Slab m order by MId desc";
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
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime strmin = new DateTime();
            DateTime strmax = new DateTime();
            try
            {
                if (txtStartDate.Text.Trim().Length > 0)
                    strmin = Convert.ToDateTime(txtStartDate.Text.Trim(), dateInfo);
                if (txtExpDate.Text.Trim().Length > 0)
                    strmax = Convert.ToDateTime(txtExpDate.Text.Trim(), dateInfo);
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }
           
            if(ddl_UserType.SelectedValue == "2")
            {
                if (ddl_UserType.SelectedValue == "0")
                {
                    utility.MessageBox(this, "Please Select Franchise Type.");
                    return;
                }
            }

            if (Request.QueryString["Mid"] != null)
            {
                Mid = Request.QueryString["Mid"].ToString();
            }
 
            SqlCommand cmd = new SqlCommand("[AddEditMonthlyOffer]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Mid", Mid);
            cmd.Parameters.AddWithValue("@StartDate", strmin);
            cmd.Parameters.AddWithValue("@EndDate", strmax);
            cmd.Parameters.AddWithValue("@Inc_Type_Cause", ddl_Inc_Type_Cause.SelectedValue);
            cmd.Parameters.AddWithValue("@BV_Point", txt_BV_Point.Text == "" ? "0" : txt_BV_Point.Text);
            cmd.Parameters.AddWithValue("@Commission", txt_Commission.Text == "" ? "0" : txt_Commission.Text);
            cmd.Parameters.AddWithValue("@UserType", ddl_UserType.SelectedValue);
            cmd.Parameters.AddWithValue("@FranType", ddl_FranchiseType.SelectedValue);
            cmd.Parameters.AddWithValue("@BillType", ddl_BillType.SelectedValue);
            cmd.Parameters.AddWithValue("@isactive", chkIsActive.Checked == true ? "1" : "0");
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            string flag = cmd.Parameters["@flag"].Value.ToString();
            if (flag == "0")
            {
                Response.Redirect("AddMonthlyOffer.aspx");
            }
            else
            {
                utility.MessageBox(this, flag);
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int rowindex = Convert.ToInt32(e.CommandArgument);
        GridViewRow row = GridView1.Rows[rowindex];
        HiddenField hnd_Tid = (HiddenField)row.FindControl("hnd_Tid");
        if (e.CommandName == "Edit")
        {
            Response.Redirect("AddMonthlyOffer.aspx?Mid=" + hnd_Tid.Value);
            return;
        }

        if (e.CommandName == "ACTIVE_DEACTIVE")
        {
            SqlCommand cmd = new SqlCommand("Update MonthlyIncome_Slab set IsActive=(Case when isnull(IsActive,0)=0 then 1 else 0 end) where Mid=@Mid", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@Mid", hnd_Tid.Value);
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
            BindTour();
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindTour();
    }
     
}