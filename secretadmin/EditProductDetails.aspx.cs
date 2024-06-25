using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Data;
public partial class d2000admin_EditProductDetails : System.Web.UI.Page
{
    string productId;
 
    SqlConnection con;
    DataTable dt;
    SqlDataAdapter da;
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        productId = Convert.ToString(Request.QueryString["n"]);
        if (!Page.IsPostBack)
        {
            getPackSize();
            go();
        }

    }
    public void getPackSize()
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("select srno,PackSize from PackSizemst where isDeleted=0 order by PackSize", con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ViewState["dtPackSize"] = dt;
            ddlPackSize.DataSource = dt;
            ddlPackSize.DataTextField = dt.Columns["PackSize"].ToString();
            ddlPackSize.DataValueField = dt.Columns["srno"].ToString();
            ddlPackSize.DataBind();
        }
        else
        {
            ddlPackSize.Items.Insert(0, "Pack size unit is not added");
        }
        //ddlPackSize.Items.Add(new ListItem("Add New", "0"));
    }
    public void go()
    {

        con = new SqlConnection(method.str);
        dt = new DataTable();
        try
        {
            da = new SqlDataAdapter("getShopProduct", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@ProductId", productId);
            da.Fill(dt);
            if (dt.Rows.Count.ToString() == "0")
            {
                lblMsg.Text = "No Data Found !";

            }
            else
            {


                txtTitle.Text = dt.Rows[0]["Title"].ToString();
                txtProductName.Text = dt.Rows[0]["ProductName"].ToString();
                txtPack.Text = dt.Rows[0]["PackSize"].ToString();
                try
                {
                    ddlPackSize.Items.FindByValue(dt.Rows[0]["PackSizeUnitId"].ToString()).Selected = true;
                }
                catch
                {
                }
                txtMRP.Text = dt.Rows[0]["MRP"].ToString();          
                txtDPWithTax.Text = dt.Rows[0]["DPWithTax"].ToString();
                txtDPTax.Text = dt.Rows[0]["Tax"].ToString();
                txtSTTax.Text = dt.Rows[0]["STTax"].ToString();
                txtQTY.Text = dt.Rows[0]["QTY"].ToString();
                txtDP.Text = dt.Rows[0]["DPAmt"].ToString();
                txtBV.Text = dt.Rows[0]["BVAmt"].ToString();
                txtDescription.Text = dt.Rows[0]["Description"].ToString();
                txt_MaxAllowed.Text = dt.Rows[0]["MaxAllowed"].ToString();
            }
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            dt.Dispose();
            da.Dispose();
        }

    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        if (!string.IsNullOrEmpty(txtProductName.Text.Trim()))
        {
            if (!string.IsNullOrEmpty(txtTitle.Text.Trim()))
            {
                if (txtTitle.Text.Trim().ToString().Length < 51)
                {
                    if (!string.IsNullOrEmpty(txtMRP.Text.Trim()))
                    {
                        if (Regex.Match(txtMRP.Text.Trim().ToString(), @"^[0-9.]*$").Success)
                        {
                            
                                if (!string.IsNullOrEmpty(txtDP.Text.Trim()))
                                {
                                    if (Regex.Match(txtDP.Text.Trim().ToString(), @"^[0-9.]*$").Success)
                                    {
                                        if (!string.IsNullOrEmpty(txtBV.Text.Trim()))
                                        {
                                            if (Regex.Match(txtBV.Text.Trim().ToString(), @"^[0-9.]*$").Success)
                                            {
                                                if (!string.IsNullOrEmpty(txtDescription.Text.Trim()))
                                                {
                                                    if (Regex.Match(txt_MaxAllowed.Text.Trim().ToString(), @"^[0-9.]*$").Success)
                                                    {
                                                        editProduct();
                                                    }
                                                    else
                                                    {
                                                        utility.MessageBox(this, "Please Enter Numeric and Max Allowed!");
                                                    }
                                                   
                                                }
                                                else
                                                {
                                                    lblMsg.Text = "Please Enter Description!";
                                                }
                                            }
                                            else
                                            {
                                                lblMsg.Text = "Please Enter Numeric BV!";
                                            }
                                        }
                                        else
                                        {
                                            lblMsg.Text = "Please Enter BV !";
                                        }
                                    }
                                    else
                                    {
                                        lblMsg.Text = "Please Enter Numeric DP!";
                                    }
                                }
                                else
                                {
                                    lblMsg.Text = "Please Enter DP !";
                                }
                            
                        }
                        else
                        {
                            lblMsg.Text = "Please Enter Numeric MRP!";
                        }
                    }
                    else
                    {
                        lblMsg.Text = "Please Enter MRP!";
                    }
                }
                else
                {
                    lblMsg.Text = "Only 50 Characters Are Allowed In Title!";
                }
            }
            else
            {
                lblMsg.Text = "Please Enter Title!";
            }
        }
        else
        {
            lblMsg.Text = "Please Enter Product !";
        }
        go();
    }
    public void editProduct()
    {

        con = new SqlConnection(method.str);
        cmd = new SqlCommand();
        try
        {
            cmd = new SqlCommand("editShopProduct", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@PackSize", txtPack.Text.Trim());
            cmd.Parameters.AddWithValue("@PackSizeUnitId", string.IsNullOrEmpty(txtPack.Text.Trim()) == true ? "0" : ddlPackSize.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@MRP", txtMRP.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@DPWithTax", txtDPWithTax.Text.Trim());
            cmd.Parameters.AddWithValue("@Tax", txtDPTax.Text.Trim());
            cmd.Parameters.AddWithValue("@STTax", txtSTTax.Text.Trim());
            cmd.Parameters.AddWithValue("@QTy", txtQTY.Text.Trim());
            cmd.Parameters.AddWithValue("@DP", string.IsNullOrEmpty(hdnCalculatedDP.Value.Trim()) == true ? txtDP.Text.Trim() : hdnCalculatedDP.Value.Trim());
            cmd.Parameters.AddWithValue("@BV", string.IsNullOrEmpty(hdnCalculatedBV.Value.Trim()) == true ? txtBV.Text.Trim() : hdnCalculatedBV.Value.Trim());
            cmd.Parameters.AddWithValue("@MaxAllowed", txt_MaxAllowed.Text.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim().ToString());
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            lblMsg.Text = "Product Edited Successfully !";           
            chkBV.Checked = false;
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            cmd.Dispose();
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddEditProduct.aspx", false);
    }
}
