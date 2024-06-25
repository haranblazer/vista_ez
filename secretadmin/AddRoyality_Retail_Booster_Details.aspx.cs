using System;
using System.Data;
using System.Data.SqlClient; 

public partial class AddRoyality_Retail_Booster_Details : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    static string Mid = "0";

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

            if (Request.QueryString["Mid"] != null)
            {
                Mid = Request.QueryString["Mid"].ToString();
                BindData(Mid);
            }

        }
    }


    public void BindData(string MId)
    {
        String Qry = @"Select BV_Point, Commission, MaxRoyalty, RoyaltyType=isnull(RoyaltyType,0),
            StartDate = convert(nvarchar, StartDate, 103), EndDate = convert(nvarchar, EndDate, 103), IsActive
            from LoyaltyMonthly_Retail_Booster_Slab t where MId=@MId";
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
            txt_LoyaltyOffer.Text = dt.Rows[0]["RoyaltyType"].ToString();


            txt_BV_Point.Text = dt.Rows[0]["BV_Point"].ToString();
            txt_Loyalty.Text = dt.Rows[0]["MaxRoyalty"].ToString();

            if (dt.Rows[0]["IsActive"].ToString() == "1")
                chkIsActive.Checked = true;
            else
                chkIsActive.Checked = false;


            chkIsActive.Enabled = false;
        }
        else
        {
            txt_BV_Point.Text = "0";
            txt_Loyalty.Text = "0";
            txt_LoyaltyOffer.Text = "0";
            txtStartDate.Text = "";
            txtExpDate.Text = "";
            chkIsActive.Checked = false;
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

            if (Request.QueryString["Mid"] != null)
            {
                Mid = Request.QueryString["Mid"].ToString();
            }
            String BV_Point = txt_BV_Point.Text == "" ? "0" : txt_BV_Point.Text;
            String MaxLoyalty = txt_Loyalty.Text == "" ? "0" : txt_Loyalty.Text;
            String LoyaltyOffer = txt_LoyaltyOffer.Text == "" ? "0" : txt_LoyaltyOffer.Text;
            if (BV_Point == "0")
            {
                utility.MessageBox(this, "Please enter invoice value.!!");
                return;
            }
            if (MaxLoyalty == "0")
            {
                utility.MessageBox(this, "Please enter max loyalty in month.!!");
                return;
            }

            SqlCommand cmd = new SqlCommand("[AddEditLoyalty_Retail_Booster_Offer]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Mid", Mid);
            cmd.Parameters.AddWithValue("@StartDate", strmin);
            cmd.Parameters.AddWithValue("@EndDate", strmax);
            cmd.Parameters.AddWithValue("@RoyaltyType", LoyaltyOffer);
            cmd.Parameters.AddWithValue("@BV_Point", BV_Point);
            cmd.Parameters.AddWithValue("@MaxRoyalty", MaxLoyalty);
            cmd.Parameters.AddWithValue("@isactive", chkIsActive.Checked == true ? "1" : "0");
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            string flag = cmd.Parameters["@flag"].Value.ToString();
            if (flag == "0")
            {
                Response.Redirect("AddRoyality_Retail_Booster.aspx");
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

}