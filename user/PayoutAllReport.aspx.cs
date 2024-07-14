using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Drawing;
public partial class User_PayourAllReport : System.Web.UI.Page
{
    string fromdate, todate;
    string sstr;
    double total, tds, handeling, other, dispatch, HoldAmt;
    SqlDataAdapter da;
    SqlDataReader dr;
    SqlCommand com;
    SqlConnection con = new SqlConnection(method.str);
    string str;

    string p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11;

    utility objUtil = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        else
        {
            sstr = Convert.ToString(Session["userId"]);
            if (!IsPostBack)
            {
                if (Regex.Match(sstr, @"^[a-zA-Z0-9]*$").Success)
                {
                    GetAllPayout();
                    Bind_TopperMonth();
                    Bind_GenerationMonth();
                    GetTopperData();
                    GetGenerationData();

                }
            }
        }
    }

    private void GetAllPayout()
    {
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Master_Key","TOPPER_GENERATION"),
                new SqlParameter("@Userid", Session["userId"].ToString()),
                new SqlParameter("@Month_Year", "")
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "getUserMonthlyPayout");
            if (dt.Rows.Count > 0)
            {
                lbl_TotalTopperAmount.Text = dt.Rows[0]["TopperAmount"].ToString();
                lbl_TotalTopperRewardAmount.Text = dt.Rows[0]["TopperRewardAmount"].ToString();
                lbl_Total_RepurchaseAmount.Text = dt.Rows[0]["RepurchaseAmount"].ToString();
                lbl_TotalAnnualRoyalty.Text = dt.Rows[0]["AnnualRoyalty"].ToString();
                lbl_TotalAmount.Text = dt.Rows[0]["TotalAmount"].ToString();
            }
            else
            {
                lbl_TotalTopperAmount.Text = "0";
                lbl_TotalTopperRewardAmount.Text = "0";
                lbl_Total_RepurchaseAmount.Text = "0";
                lbl_TotalAnnualRoyalty.Text = "0";
                lbl_TotalAmount.Text = "0";
            }
        }
        catch (Exception ex)
        {
        }
    }


    protected void ddl_TopperMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetTopperData();
    }

    private void GetTopperData()
    {
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Master_Key","TOPPER"),
                new SqlParameter("@Userid", Session["userId"].ToString()),
                new SqlParameter("@Month_Year", ddl_TopperMonth.SelectedValue)
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "getUserMonthlyPayout");
            if (dt.Rows.Count > 0)
            {
                lbl_TopperPayout_Topper.Text = dt.Rows[0]["binaryamt"].ToString();
                lbl_TopperRewardPayout_Topper.Text = dt.Rows[0]["RoyaltyAmt"].ToString();
                lbl_TotalAmountMonth_Topper.Text = dt.Rows[0]["totalearning"].ToString();
                lbl_TDSAmountMonth_Topper.Text = dt.Rows[0]["tds"].ToString();
                lbl_ChargesAmountMonth_Topper.Text = dt.Rows[0]["handlingcharges"].ToString();
                lbl_DispatchedAmountMonth_Topper.Text = dt.Rows[0]["dispachedamt"].ToString();
                lbl_HoldAmountMonth_Topper.Text = dt.Rows[0]["HoldAmt"].ToString();
            }
            else
            {
                lbl_TotalAmountMonth_Topper.Text = "0";
                lbl_TDSAmountMonth_Topper.Text = "0";
                lbl_ChargesAmountMonth_Topper.Text = "0";
                lbl_DispatchedAmountMonth_Topper.Text = "0";
                lbl_HoldAmountMonth_Topper.Text = "0";
            }
        }
        catch (Exception ex)
        {
        }

    }

    private void Bind_TopperMonth()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Distinct [Month]=Cast(DateName(Month, PayToDate) as nvarchar(3)) + '-' + RIGHT(DateName(Year, PayToDate),2)  from PayoutDate");
        if (dt.Rows.Count > 0)
        {
            ddl_TopperMonth.DataSource = dt;
            ddl_TopperMonth.DataTextField = "Month";
            ddl_TopperMonth.DataValueField = "Month";
            ddl_TopperMonth.DataBind();
        }
        else
        {
            ddl_TopperMonth.Items.Clear();
        }
    }


    protected void ddl_GenerationMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetGenerationData();
    }

    private void GetGenerationData()
    {
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Master_Key","GENERATION"),
                new SqlParameter("@Userid", Session["userId"].ToString()),
                new SqlParameter("@Month_Year", ddl_GenerationMonth.SelectedValue)
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "getUserMonthlyPayout");
            if (dt.Rows.Count > 0)
            {
                lbl_RepurchasePayout_Gen.Text = dt.Rows[0]["RepurchasePayout"].ToString();
                lbl_AnnualRoyalty_Gen.Text = dt.Rows[0]["AnnualRoyalty"].ToString();

                lbl_TotalAmountMonth_Gen.Text = dt.Rows[0]["totalearning"].ToString();
                lbl_TDSAmountMonth_Gen.Text = dt.Rows[0]["tds"].ToString();
                lbl_ChargesAmountMonth_Gen.Text = dt.Rows[0]["handlingcharges"].ToString();
                lbl_DispatchedAmountMonth_Gen.Text = dt.Rows[0]["dispachedamt"].ToString();
                lbl_HoldAmountMonth_Gen.Text = dt.Rows[0]["HoldAmt"].ToString();
            }
            else
            {
                lbl_TotalAmountMonth_Gen.Text = "0";
                lbl_TDSAmountMonth_Gen.Text = "0";
                lbl_ChargesAmountMonth_Gen.Text = "0";
                lbl_DispatchedAmountMonth_Gen.Text = "0";
                lbl_HoldAmountMonth_Gen.Text = "0";
            }
        }
        catch (Exception ex)
        {
        }

    }

    private void Bind_GenerationMonth()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Distinct [Month]=Cast(DateName(Month, PayToDate) as nvarchar(3)) + '-' + RIGHT(DateName(Year, PayToDate),2)  from rePayoutDate");
        if (dt.Rows.Count > 0)
        {
            ddl_GenerationMonth.DataSource = dt;
            ddl_GenerationMonth.DataTextField = "Month";
            ddl_GenerationMonth.DataValueField = "Month";
            ddl_GenerationMonth.DataBind();
        }
        else
        {
            ddl_GenerationMonth.Items.Clear();
        }
    }


}