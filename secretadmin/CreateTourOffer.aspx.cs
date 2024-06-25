using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class secretadmin_CreateTourOffer : System.Web.UI.Page
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
            txtStartDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            txtExpDate.Text = DateTime.Now.AddMonths(+1).Date.ToString("dd/MM/yyyy").Replace("-", "/");
            BindRankGen();
            BindTour();
            BindOfferType();
            BindProduct();

            if (Request.QueryString["Tid"] != null)
            {
                Tid = Request.QueryString["Tid"].ToString();
                BindData(Tid);
            }

        }
    }


    public void BindData(string Tid)
    {
        String Qry = @"Select TourName, Condition, NoOfCount, Pack_Rep, TourType, 
        StartDate = convert(nvarchar, StartDate, 103), ExpDate = convert(nvarchar, ExpDate, 103), IsActive, DisplayName, 
        Place, Venue, T_Date=convert(varchar, T_Date, 103), T_Time, TLPer=isnull(TLPer,0), ApplicableRank=isnull(ApplicableRank,0)
        from TourMst t where tid=@Tid";
        SqlParameter[] param1 = new SqlParameter[] { new SqlParameter("@Tid", Tid) };

        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param1, Qry);

        if (dt.Rows.Count > 0)
        {
            txt_TourName.Text = dt.Rows[0]["TourName"].ToString();

            txtCondition.Text = dt.Rows[0]["Condition"].ToString();
            txt_MaxValuesFromSingleLeg.Text = dt.Rows[0]["NoOfCount"].ToString();

            txt_DisplayName.Text = dt.Rows[0]["DisplayName"].ToString();

            txt_Date.Text = dt.Rows[0]["T_Date"].ToString();
            txt_Time.Text = dt.Rows[0]["T_Time"].ToString();
            txt_Place.Text = dt.Rows[0]["Place"].ToString();
            txt_Venue.Text = dt.Rows[0]["Venue"].ToString();

            ddl_TourType.SelectedValue = dt.Rows[0]["TourType"].ToString();
            ddl_OfferOn.SelectedValue = dt.Rows[0]["Pack_Rep"].ToString();
            txtStartDate.Text = dt.Rows[0]["StartDate"].ToString();
            txtExpDate.Text = dt.Rows[0]["ExpDate"].ToString();
            if (dt.Rows[0]["IsActive"].ToString() == "1")
                chkIsActive.Checked = true;
            else
                chkIsActive.Checked = false;

            ddl_RankGen.SelectedValue = dt.Rows[0]["TLPer"].ToString();
            ddl_RankGenApplicable.SelectedValue = dt.Rows[0]["ApplicableRank"].ToString();

            SqlParameter[] param2 = new SqlParameter[] { new SqlParameter("@Tid", Tid) };
            DataTable dtScheme = objDu.GetDataTable(param2, "Select Pid, Qty From ProdOfferTour where Tid=@Tid");
            foreach (GridViewRow gv in GridView2.Rows)
            {
                HiddenField productid = (HiddenField)gv.FindControl("hnd_productid");
                TextBox txtQty = (TextBox)gv.FindControl("txtQty");
                CheckBox chkProd = (CheckBox)gv.FindControl("chkProd");
                foreach (DataRow dtrow in dtScheme.Rows)
                {
                    if (productid.Value == dtrow["Pid"].ToString())
                    {
                        chkProd.Checked = true;
                        txtQty.Text = dtrow["Qty"].ToString();
                    }
                }
            }

            txt_TourName.Enabled = false;
            ddl_TourType.Enabled = false;
            ddl_OfferOn.Enabled = false;
            chkIsActive.Enabled = false;
            ddl_RankGen.Enabled = false;
            ddl_RankGenApplicable.Enabled = false;
        }
        else
        {
            txt_TourName.Text = "";
            txtCondition.Text = "0";
            txt_MaxValuesFromSingleLeg.Text = "0";
            txt_DisplayName.Text = "";
            txt_Date.Text = "";
            txt_Time.Text = "";
            txt_Place.Text = "";
            txt_Venue.Text = "";

            ddl_TourType.SelectedValue = "1";
            ddl_OfferOn.SelectedValue = "3";
            txtStartDate.Text = "";
            txtExpDate.Text = "";
            chkIsActive.Checked = false;
            ddl_RankGen.SelectedValue = "0";
        }

    }

    public void BindTour()
    {
        String Qry = @"Select Tid, TourName, Condition, NoOfCount, Pack_Rep, Pack_RepText=(Case Pack_Rep When 1 then 'Topper' when 3 then 'Generation' when 5 then 'Generation Product' when 6 then 'Topper Product'  when 7 then 'Rank Upgrade' End), 
            TourTypeText = (Select Item_Desc from Item_Collection where ItemId = 7 and UserVal = t.TourType), TourType, 
            StartDate = convert(nvarchar, StartDate, 103), ExpDate = convert(nvarchar, ExpDate, 103), IsActive, DisplayName,
            Date=CONVERT(varchar, t.T_Date, 6), 
            Time=FORMAT(Cast(Cast(t.T_Date as varchar(10)) +' '+  Cast(t.T_Time as varchar(8)) as datetime), 'hh:mm tt') , 
            Place=t.Place, Venue=t.Venue, TLPer=isnull((Select RankName from RePurchase_Slab Where Rankid=isnull(t.TLPer,0)),''),
            ApplicableRank=isnull((Select RankName from RePurchase_Slab Where Rankid=isnull(t.ApplicableRank,0)),'')
            from TourMst t order by tid desc";
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


            string fromDate = "", toDate = "", date = "1900-01-01";
            try
            {
                if (txtStartDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtStartDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
                if (txtExpDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtExpDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                }


            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }



            string prod = "";

            if (ddl_OfferOn.SelectedValue == "5" || ddl_OfferOn.SelectedValue == "6")
            {
                prod = ProductList().ToString();
                if (string.IsNullOrEmpty(prod))
                {
                    utility.MessageBox(this, "Please Select Product.!!?");
                    return;
                }
            }


            string Time = "00:00:00.0000000";

            if (ddl_OfferOn.SelectedValue == "5" || ddl_OfferOn.SelectedValue == "6")
            {
                Time = txt_Time.Text;
                if (txt_Date.Text.Trim().Length > 0)
                {
                    String[] Date = txt_Date.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    date = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
            }

            if (ddl_OfferOn.SelectedValue == "7")
            {
                if (ddl_RankGen.SelectedValue == "0")
                {
                    utility.MessageBox(this, "Please Select Rank.!!?");
                    return;
                }
            }


            String Tid = "0";
            if (Request.QueryString["Tid"] != null)
            {
                Tid = Request.QueryString["Tid"].ToString();
            }
            SqlCommand cmd = new SqlCommand("AddEditTour", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Tid", Tid);
            cmd.Parameters.AddWithValue("@TourName", txt_TourName.Text);
            cmd.Parameters.AddWithValue("@Condition", txtCondition.Text);
            cmd.Parameters.AddWithValue("@NoOfCount", txt_MaxValuesFromSingleLeg.Text == "" ? "0" : txt_MaxValuesFromSingleLeg.Text);
            cmd.Parameters.AddWithValue("@DisplayName", txt_DisplayName.Text);

            cmd.Parameters.AddWithValue("@T_Date", date);
            cmd.Parameters.AddWithValue("@T_Time", Time);
            cmd.Parameters.AddWithValue("@Place", txt_Place.Text);
            cmd.Parameters.AddWithValue("@Venue", txt_Venue.Text);

            cmd.Parameters.AddWithValue("@TourType", ddl_TourType.SelectedValue);
            cmd.Parameters.AddWithValue("@ApplicableRank", ddl_RankGenApplicable.SelectedValue);

            cmd.Parameters.AddWithValue("@Pack_Rep", ddl_OfferOn.SelectedValue);
            cmd.Parameters.AddWithValue("@StartDate", fromDate);
            cmd.Parameters.AddWithValue("@ExpDate", toDate);
            cmd.Parameters.AddWithValue("@Productlist", prod);
            cmd.Parameters.AddWithValue("@isactive", chkIsActive.Checked == true ? "1" : "0");
            cmd.Parameters.AddWithValue("@TLPer", ddl_RankGen.SelectedValue);

            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            string flag = cmd.Parameters["@flag"].Value.ToString();
            if (flag == "0")
            {
                Response.Redirect("CreateTourOffer.aspx");
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
            Response.Redirect("CreateTourOffer.aspx?Tid=" + hnd_Tid.Value);
            return;
        }

        if (e.CommandName == "ACTIVE_DEACTIVE")
        {
            SqlCommand cmd = new SqlCommand("Update TourMst set IsActive=(Case when IsActive=0 then 1 else 0 end) where Tid=@Tid", con);
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
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindTour();
    }

    public void BindOfferType()
    {
        SqlCommand cmd = new SqlCommand("select UserVal, Item_Desc from item_collection where itemid=7 and isactive=1", con);
        cmd.CommandType = CommandType.Text;
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddl_TourType.DataSource = dt;
            ddl_TourType.DataTextField = dt.Columns["Item_Desc"].ToString();
            ddl_TourType.DataValueField = dt.Columns["UserVal"].ToString();
            ddl_TourType.DataBind();
        }
        else
        {
            ddl_TourType.SelectedValue = null;
            ddl_TourType.DataBind();
        }
    }


    public void BindRankGen()
    {
        ddl_RankGenApplicable.Items.Clear();
        ddl_RankGen.Items.Clear();
        SqlDataAdapter da = new SqlDataAdapter("Select Rankid, RankName from RePurchase_Slab Where Rankid>=4 order by Rankid", con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddl_RankGen.DataSource = dt;
            ddl_RankGen.DataTextField = "RankName";
            ddl_RankGen.DataValueField = "Rankid";
            ddl_RankGen.DataBind();
            ddl_RankGen.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Rank", "0"));

            ddl_RankGenApplicable.DataSource = dt;
            ddl_RankGenApplicable.DataTextField = "RankName";
            ddl_RankGenApplicable.DataValueField = "Rankid";
            ddl_RankGenApplicable.DataBind();
            ddl_RankGenApplicable.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Applicable Rank", "0"));
        }
        else
        {
            ddl_RankGen.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Rank", "0"));
            ddl_RankGenApplicable.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Applicable Rank", "0"));
        }

    }



    public void BindProduct()
    {
        String Qry = "", ProductName = "";

        Qry = "select p.Productid,  ProductName=p.ProductName + SPACE(1)+ p.ProductCode + SPACE(1)+ p.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)) from shopproductmst p inner join PackSizemst ps on p.PackSizeUnitId = ps.srno where p.isDeleted = 0 order by p.ProductName";

        SqlCommand cmd = new SqlCommand(Qry, con);
        cmd.CommandType = CommandType.Text;
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            GridView2.DataSource = dt;
            GridView2.DataBind();
        }
        else
        {
            GridView2.DataSource = null;
            GridView2.DataBind();
        } 
    }


    private string ProductList()
    {
        str = "";
        foreach (GridViewRow row in GridView2.Rows)
        {
            if ((row.FindControl("chkProd") as CheckBox).Checked == true)
                str = str + (row.FindControl("hnd_productid") as HiddenField).Value + "^" + (row.FindControl("txtQty") as TextBox).Text + ",";
        }
        return str;
    }



}