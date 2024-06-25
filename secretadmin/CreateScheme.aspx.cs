using System;

using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


public partial class admin_Pamentmst : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    public string strDtl;
    public string str = "";

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
            txtStartDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-","/");
            txtExpDate.Text = DateTime.Now.AddMonths(+1).Date.ToString("dd/MM/yyyy").Replace("-", "/");

            BindSettingDetails();
            BindOfferType();
            BindProduct();
            BindUserProduct();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindProduct();
    }

    public void BindProduct()
    {
        String Qry = "", ProductName = "";
        String[] strProduct = txt_product.Text.Split(new String[] { "=" }, StringSplitOptions.RemoveEmptyEntries);
        try
        {
            if (strProduct[0] != null)
                ProductName = strProduct[0];
        }
        catch { }



        if (String.IsNullOrEmpty(ProductName))
            Qry = "select p.Productid,  ProductName=p.ProductName + SPACE(1)+ p.ProductCode + SPACE(1)+ p.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)) from shopproductmst p inner join PackSizemst ps on p.PackSizeUnitId = ps.srno where p.isDeleted = 0 order by p.ProductName";
        else
            Qry = "select p.Productid, ProductName=p.ProductName + SPACE(1)+ p.ProductCode  +SPACE(1)+ p.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)) from shopproductmst p inner join PackSizemst ps on p.PackSizeUnitId = ps.srno where p.isDeleted = 0 and p.ProductCode like '%" + ProductName + "%' or p.ProductName like '%" + ProductName + "%' order by p.ProductName";

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
        txtItemQty.Text = "1";

    }

    public void BindOfferType()
    {
        SqlCommand cmd = new SqlCommand("select UserVal,Item_Desc from item_collection where itemid=5 and isactive=1", con);
        cmd.CommandType = CommandType.Text;
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlOfferType.DataSource = dt;
            ddlOfferType.DataTextField = dt.Columns["Item_Desc"].ToString();
            ddlOfferType.DataValueField = dt.Columns["UserVal"].ToString();
            ddlOfferType.DataBind();
        }
        else
        {
            ddlOfferType.SelectedValue = null;
            ddlOfferType.DataBind();
        }
    }

    private string ProductList()
    {
        foreach (GridViewRow row in GridView2.Rows)
        {
            if ((row.FindControl("chkProd") as CheckBox).Checked == true)
                str = str + (row.FindControl("hnd_productid") as HiddenField).Value + "^" + (row.FindControl("txtQty") as TextBox).Text + ",";
        }
        return str;
    }

    public void BindSettingDetails()
    {
        try
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime strmin = new DateTime();
            DateTime strmax = new DateTime();
            strmax = strmin = DateTime.Now.Date;

            SqlCommand cmd = new SqlCommand("SchemeSetting", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Master", "SELECT");
            cmd.Parameters.AddWithValue("@IsActive", ddl_Active.SelectedValue);
            cmd.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            DataTable dt = new DataTable();
            sda.Fill(dt);

            btnSave.Text = "ADD";
            txtScheme.Text = "";
            txtCondition.Text = "0";
            txt_MaxAmt.Text = "0";

            txtItemQty.Text = "0";
            txt_MonthlyCondition.Text = "0";
            txt_Monthlyoffer.Text = "0";
            txtScheme.Enabled = true;
            ddl_OfferOn.Enabled = true;
            txtScheme.Enabled = true;
            ddlOfferType.Enabled = true;
            lblsno.Text = "0";
            GridView1.DataSource = dt;
            GridView1.DataBind();

        }
        catch (Exception ex)
        {

        }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string prod = "";

            if (ddlOfferType.SelectedValue == "3")
            {
                prod = ProductList().ToString();
                if (string.IsNullOrEmpty(prod))
                {
                    utility.MessageBox(this, "Please Select Product.!!?");
                    return;
                }
            }
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

            SqlCommand cmd = new SqlCommand("SchemeSetting", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Master", btnSave.Text);
            cmd.Parameters.AddWithValue("@Scheme", txtScheme.Text);
            cmd.Parameters.AddWithValue("@Condition", txtCondition.Text.Trim() == "" ? "0" : txtCondition.Text.Trim());
            cmd.Parameters.AddWithValue("@MaxAmount", txt_MaxAmt.Text.Trim()==""  ? "0" : txt_MaxAmt.Text.Trim());

            cmd.Parameters.AddWithValue("@Item_Qty", Convert.ToInt32(txtItemQty.Text));
            cmd.Parameters.AddWithValue("@OfferType", ddlOfferType.SelectedValue);
            cmd.Parameters.AddWithValue("@isactive", chkIsActive.Checked == true ? "1" : "0");
            cmd.Parameters.AddWithValue("@StartDate", strmin);
            cmd.Parameters.AddWithValue("@ExpDate", strmax);
            cmd.Parameters.AddWithValue("@sid", lblsno.Text);
            cmd.Parameters.AddWithValue("@Productlist", prod);
            cmd.Parameters.AddWithValue("@OfferOn", ddl_OfferOn.SelectedValue);

            cmd.Parameters.AddWithValue("@Condition_Month", txt_MonthlyCondition.Text == "" ? "0" : txt_MonthlyCondition.Text);
            cmd.Parameters.AddWithValue("@Give_Month_offer", txt_Monthlyoffer.Text == "" ? "0" : txt_Monthlyoffer.Text);

            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            string flag = cmd.Parameters["@flag"].Value.ToString();
            BindSettingDetails();
            BindProduct();
            ClientScriptManager csm = Page.ClientScript;
            csm.RegisterStartupScript(this.GetType(), "message", "alert('" + flag + "')", true);
            chkIsActive.Enabled = true;
            txtScheme.Enabled = true;
            ddl_OfferOn.Enabled = true;
            txtScheme.Enabled = true;
            ddlOfferType.Enabled = true;
            ddlOfferType.SelectedValue = "1";
            ddl_OfferOn.SelectedValue = "0";
        }
        catch (Exception ex)
        {
        }
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lnkOffer = (LinkButton)e.Row.FindControl("lnkOffer");
            HiddenField hnd_OfferTypeVal = (HiddenField)e.Row.FindControl("hnd_OfferTypeVal");
            if (hnd_OfferTypeVal.Value == "4")
            {
                lnkOffer.Enabled = false;
                lnkOffer.Text = "Offer Added";
                 
            }
        }
    }


    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        int rowindex = Convert.ToInt32(e.CommandArgument);
        GridViewRow row = GridView1.Rows[rowindex];
        HiddenField hnd_productid = (HiddenField)row.FindControl("hnd_productid");
        if (e.CommandName == "Offer")
        {
            Response.Redirect("CreateItem.aspx?sid="+hnd_productid.Value);
            return;
        }

        if (e.CommandName == "ACTIVE_DEACTIVE")
        {
            SqlCommand cmd = new SqlCommand("Update SchemeMst set IsActive=(Case when IsActive=0 then 1 else 0 end) where sid=@sid", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@sid", hnd_productid.Value);
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

            SqlCommand cmd1 = new SqlCommand("Insert Scheme_log(SID, IsActive)values(@sid,(Select IsActive from SchemeMst Where sid=@sid))", con);
            cmd1.CommandType = CommandType.Text;
            cmd1.Parameters.AddWithValue("@sid", hnd_productid.Value);
            try
            {
                con.Open();
                cmd1.ExecuteNonQuery();
            }
            catch (Exception er) { }
            finally
            {
                con.Close();
            }

            BindSettingDetails();
        }
        if (e.CommandName == "Edit")
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {
                new SqlParameter("@sid", hnd_productid.Value)
            };

            DataTable dt = objDu.GetDataTable(param1, "select sid, MaxAmount=isnull(MaxAmount,0), Scheme, Condition, Item_Qty, OfferType, IsActive, CONVERT(varchar,StartDate,103) as StartDate, CONVERT(varchar,Expdate,103) as Expdate, OfferOn=isnull(OfferOn,0), Condition_Month=Cast(isnull(Condition_Month,0) as int), Give_Month_offer from SchemeMst where sid=@sid");

            if (dt.Rows.Count > 0)
            {
                ddl_OfferOn.SelectedValue = dt.Rows[0]["OfferOn"].ToString();
                txtScheme.Text = dt.Rows[0]["Scheme"].ToString();
                txtCondition.Text = dt.Rows[0]["Condition"].ToString();
                txt_MaxAmt.Text = dt.Rows[0]["MaxAmount"].ToString();

                txtItemQty.Text = dt.Rows[0]["Item_Qty"].ToString();
                ddlOfferType.SelectedValue = dt.Rows[0]["OfferType"].ToString();
                bool chk = dt.Rows[0]["Isactive"].ToString() == "1" ? true : false;
                chkIsActive.Checked = chk;
                chkIsActive.Enabled = false;
                ddl_OfferOn.Enabled = false;

                txtStartDate.Text = dt.Rows[0]["StartDate"].ToString();
                txtExpDate.Text = dt.Rows[0]["Expdate"].ToString();

                txt_MonthlyCondition.Text = dt.Rows[0]["Condition_Month"].ToString();
                txt_Monthlyoffer.Text = dt.Rows[0]["Give_Month_offer"].ToString();

                lblsno.Text = dt.Rows[0]["sid"].ToString();
                btnSave.Text = "Update";
                txtScheme.Enabled = false;
                ddlOfferType.Enabled = false;

                SqlParameter[] param2 = new SqlParameter[] { new SqlParameter("@sid", hnd_productid.Value) };
                DataTable dtScheme = objDu.GetDataTable(param2, "Select Pid, Qty From productoffer where SID=@sid");

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
            }
            else
            {
                btnSave.Text = "ADD";
                txtScheme.Enabled = true;
            }
            ControlHide_Show();
        }
    }


    private void ControlHide_Show()
    {

        if (ddlOfferType.SelectedValue == "3")
        {
            productdiv.Attributes.Add("style", "display: block; overflow: scroll; width: 100 %; height: 280px;");
            txt_MonthlyCondition.Enabled = false;
            txt_Monthlyoffer.Enabled = false;
            lblCondition.Enabled = false;
            txtCondition.Enabled = false;
        }
        else if (ddlOfferType.SelectedValue == "4")
        {
            productdiv.Attributes.Add("style", "display:none;");
            txt_MonthlyCondition.Enabled = true;
            txt_Monthlyoffer.Enabled = true;
            lblCondition.Enabled = false;
            txtCondition.Enabled = false;
        }
        else
        {
            productdiv.Attributes.Add("style", "display:none;");
            txt_MonthlyCondition.Enabled = false;
            txt_Monthlyoffer.Enabled = false;
            lblCondition.Enabled = true;
            txtCondition.Enabled = true;
        }

    }


    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindSettingDetails();
    }


    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }

    public void BindUserProduct()
    {
        SqlDataReader dr;
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("select p.ProductCode, ProductName=p.ProductName+'='+SPACE(1)+ p.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)) from shopproductmst p inner join PackSizemst ps on p.PackSizeUnitId = ps.srno and p.isDeleted = 0", con);
        com.CommandType = CommandType.Text;
        con.Open();
        dr = com.ExecuteReader();
        divProductcode.InnerText = string.Empty;
        while (dr.Read())
        {
            divProductcode.InnerText += dr["ProductCode"].ToString() + "," + dr["ProductName"].ToString() + ",";
        }
        con.Close();
    }


    protected void ddl_Active_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindSettingDetails();
    }
}

