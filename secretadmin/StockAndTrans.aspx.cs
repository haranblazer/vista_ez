using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;

public partial class admin_StockAndTrans : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter sda;
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
            try
            {
                Product();
                Franchise();
                BindGrid();
            }
            catch { }
        }
    }
    public void Product()
    {
        sda = new SqlDataAdapter("select ProductName,ProductId from ShopProductMst where isdeleted=0", con);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlProduct.DataSource = dt;
            ddlProduct.DataTextField = "ProductName";
            ddlProduct.DataValueField = "ProductId";
            ddlProduct.DataBind();
            ddlProduct.Items.Insert(0, "-Select Product-");
        }
    }
    public void Franchise()
    {
        sda = new SqlDataAdapter("select Franchiseid,username from FranchiseMst where AppmstActivate=1 order by Franchiseid", con);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlFranchise.DataSource = dt;
            ddlFranchise.DataTextField = "username";
            ddlFranchise.DataValueField = "Franchiseid";
            ddlFranchise.DataBind();
            ddlFranchise.Items.Insert(0, "-Select Franchise-");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (ddlProduct.SelectedIndex == 0)
        {
            utility.MessageBox(this, "Please Select Product.");
            return;
        }
        if (ddlFranchise.SelectedIndex == 0)
        {
            utility.MessageBox(this, "Please Select Franchise.");
            return;
        }
        if (txtQty.Text == "")
        {
            utility.MessageBox(this, "Please Enter Quantity.");
            return;
        }
        else
        {
            if (!Regex.Match(txtQty.Text, @"^[0-9]*$").Success)
            {
                utility.MessageBox(this, "Please Enter Valid Quantity.");
                return;
            }
        }
        try
        {
            com = new SqlCommand("StockTransfer", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@Product", ddlProduct.SelectedValue);
            com.Parameters.AddWithValue("@Franchise", ddlFranchise.SelectedValue);
            com.Parameters.AddWithValue("@Qty", txtQty.Text.Trim());
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100);
            com.Parameters["@flag"].Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            if (com.Parameters["@flag"].Value.ToString() =="1")
            {
                BindGrid();
                utility.MessageBox(this, "Transfer Successfylly. ");
                linkST.Visible = true;
                tblST.Visible = false;
                ddlProduct.SelectedIndex = 0;
                ddlFranchise.SelectedIndex = 0;
                txtQty.Text = "";
            }
            utility.MessageBox(this, com.Parameters["@flag"].Value.ToString());
        }
        catch { }
        
    }
    public void BindGrid()
    {
        sda = new SqlDataAdapter("select ProductName,MRP,DPAmt,BVAmt,QTY,MaxAllowed from ShopProductMst ", con);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            GrdProduct.DataSource = dt;
            GrdProduct.DataBind();
        }
        else
        {
            GrdProduct.DataSource = null;
            GrdProduct.DataBind();
        }
    }
    protected void linkST_Click(object sender, EventArgs e)
    {
        tblST.Visible = true;
        linkST.Visible = false;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        tblST.Visible = false;
        linkST.Visible = true;
    }
}