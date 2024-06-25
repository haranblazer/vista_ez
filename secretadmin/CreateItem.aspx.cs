using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
 
public partial class admin_Pamentmst : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    public string strDtl;
    public string sid;
    static int flag=0;
    protected void Page_Load(object sender, EventArgs e)
    {

        //if (Convert.ToString(Session["admintype"]) == "sa")
        //{
        //    utility.CheckSuperAdminLogin();
        //}
        //else if (Convert.ToString(Session["admintype"]) == "a")
        //{
        //    utility.CheckAdminLogin();
        //}
        //else
        if (Session["admin"] == null)
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!IsPostBack)
        { 
            BindScheme();
            BindItem();
            BindSettingDetails();

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

            ddlProduct.DataSource = dt;
            ddlProduct.DataTextField = dt.Columns["ProductName"].ToString();
            ddlProduct.DataValueField = dt.Columns["Productid"].ToString();
            ddlProduct.DataBind();
        }
        else
        {
            DataTable dtNULL = new DataTable();
            ddlProduct.DataSource = dtNULL;
            ddlProduct.DataBind();
        }
    }

    public void BindScheme()
    {
        string Sid = "0";
        if (Request.QueryString["sid"] != null)
        {
            Sid = Request.QueryString["sid"].ToString();
        }

        SqlCommand cmd = new SqlCommand(@"select sid, Scheme, OfferType, Condition=(Case OfferType when '3' then (Select stuff((select 'Prod: '+ Cast(Pid as varchar(10)) +' Qty: '+ Cast(Qty as varchar(10)) +'<br/>' 
        from productoffer where SID = s.SID for xml path(''), type).value('.', 'varchar(max)'), 1, 0, '')) else  Cast(Condition as nvarchar(20)) end), 
		Item_Qty, Type = (Select Item_Desc from Item_Collection where Itemid = 5 and UserVal = s.OfferType),
		 CONVERT(varchar, StartDate, 103) as StartDate, 
		CONVERT(varchar, Expdate, 103) as Expdate from schememst s where isactive=1 and sid=" + Sid, con);
        cmd.CommandType = CommandType.Text;
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            //lbl_Scheme.Text = dt.Rows[0]["Scheme"].ToString();
            ddlScheme.DataSource = dt;
            ddlScheme.DataTextField = dt.Columns["Scheme"].ToString();
            ddlScheme.DataValueField = dt.Columns["sid"].ToString();
            ddlScheme.DataBind();

            lbl_Condition.Text = "Scheme Condition: " + dt.Rows[0]["Condition"].ToString();
            lbl_Type_Qty.Text = "Offer Item: " + dt.Rows[0]["Item_Qty"].ToString() + " Offer Type: " + dt.Rows[0]["Type"].ToString(); 

            lbl_date.Text = "Start. Date: " + dt.Rows[0]["StartDate"].ToString() + " Exp. Date: " + dt.Rows[0]["Expdate"].ToString();

            //if (dt.Rows[0]["OfferType"].ToString()=="3")
            //{
            //    ddlItem.Enabled = false;
            //    btAddItemOffer.Visible = false;
            //}
        }
        else
        {
            ddlScheme.DataSource = null;
            ddlScheme.DataBind();
        }
    }


    public void BindItem()
    {
        SqlCommand cmd = new SqlCommand("select itemid, itemname from itemoffer where sid='" + ddlScheme.SelectedValue + "'", con);
        cmd.CommandType = CommandType.Text;
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlItem.DataSource = dt;
            ddlItem.DataTextField = dt.Columns["itemname"].ToString();
            ddlItem.DataValueField = dt.Columns["itemid"].ToString();
            ddlItem.DataBind();
            divhide.Attributes.Add("style", "display:none");
         
        }
        else
        {
            ddlItem.DataSource = null;
            ddlItem.DataBind();
            divhide.Attributes.Add("style", "display:block");
        }
    }

    public void BindSettingDetails()
    {
        try
        {
           
            SqlCommand cmd = new SqlCommand("ItemSetting", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Master", "SELECT");
            cmd.Parameters.AddWithValue("@Item", "");
            cmd.Parameters.AddWithValue("@ItemID", "0"  );
            cmd.Parameters.AddWithValue("@sid", ddlScheme.SelectedValue);
            cmd.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            DataTable dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                txtAddItem.Text = "";
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                DataTable dtNull = new DataTable();
                GridView1.DataSource = dtNull;
                GridView1.DataBind();
            }
        }
        catch
        {

        }
    }
    protected void btn_Reset_Click(object sender, EventArgs e)
    {
        ResetContrl();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
           
            SqlCommand cmd = new SqlCommand("ItemSetting", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Master", "ADD");
            cmd.Parameters.AddWithValue("@Item", txtAddItem.Text);
            cmd.Parameters.AddWithValue("@ItemID", "0");
            cmd.Parameters.AddWithValue("@sid", ddlScheme.SelectedValue);
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            string flag = cmd.Parameters["@flag"].Value.ToString();
           
            BindSettingDetails();
            BindItem();
            //utility.MessageBox(this, flag);
            //return;
        }
        catch (Exception ex)
        {
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int rowindex = Convert.ToInt32(e.CommandArgument);
        GridViewRow row = GridView1.Rows[rowindex];
        HiddenField hnd_offerid = (HiddenField)row.FindControl("hnd_offerid");
        if (e.CommandName == "EDIT")
        {

            SqlCommand cmd = new SqlCommand("Select OFFERID, Pid, Rs, Qty, Isactive from OfferMst where OFFERID=@OFFERID", con);
            cmd.CommandType = CommandType.Text;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@OFFERID", hnd_offerid.Value);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                ddlProduct.SelectedValue = dt.Rows[0]["Pid"].ToString();
                ddlProduct.Enabled = false;
                txtrs.Text = dt.Rows[0]["Rs"].ToString();
                txtqty.Text = dt.Rows[0]["Qty"].ToString();
                ddl_Active.SelectedValue = dt.Rows[0]["Isactive"].ToString();
                hid_Offerid.Value = dt.Rows[0]["OFFERID"].ToString();
            }
            else
            {
                ResetContrl();
            }
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
     
    protected void btnsaveoffer_Click(object sender, EventArgs e)
    { 
        try
        {
            if (hid_Offerid.Value != "0") 
            {
                SqlCommand cmd = new SqlCommand("Update OfferMst set IsActive=@Isactive, Rs=@Rs, Qty=@Qty where OFFERID=@OFFERID", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@OFFERID", hid_Offerid.Value);
                cmd.Parameters.AddWithValue("@Rs",  Convert.ToSingle(txtrs.Text.Trim() == "" ? "0" : txtrs.Text.Trim()));
                cmd.Parameters.AddWithValue("@Qty", txtqty.Text);
                cmd.Parameters.AddWithValue("@Isactive", ddl_Active.SelectedValue);
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
            else
            {
                SqlCommand cmd = new SqlCommand("ItemSetting", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                cmd.Parameters.AddWithValue("@Master", "ADDOFFER");
                cmd.Parameters.AddWithValue("@Item", txtAddItem.Text);
                cmd.Parameters.AddWithValue("@ItemID", ddlItem.SelectedValue);
                cmd.Parameters.AddWithValue("@sid", "0");
                cmd.Parameters.AddWithValue("@Pid", ddlProduct.SelectedValue);
                cmd.Parameters.AddWithValue("@RS", Convert.ToSingle(txtrs.Text.Trim() == "" ? "0" : txtrs.Text.Trim()));
                cmd.Parameters.AddWithValue("@QTY", txtqty.Text.Trim());
                cmd.Parameters.AddWithValue("@Isactive", ddl_Active.SelectedValue);
                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                string flag = cmd.Parameters["@flag"].Value.ToString();
            }

            ResetContrl();
            BindSettingDetails();
        }
        catch
        {
        }
    }


    private void ResetContrl()
    {
        ddlProduct.Enabled = true;
        txtrs.Text = "0";
        txtqty.Text = "0";
        ddl_Active.SelectedValue = "1";
        hid_Offerid.Value = "0";
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

}

