using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Data;

public partial class admin_EditProductDetail : System.Web.UI.Page
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
    }
    public void go()
    {
        try
        {

            con = new SqlConnection(method.str);
            dt = new DataTable();
            try
            {
                da = new SqlDataAdapter("getShopProduct1", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.SelectCommand.Parameters.AddWithValue("@ProductId", productId);
                da.Fill(dt);
                if (dt.Rows.Count.ToString() == "0")
                {
                    lblMsg.Text = "No Data Found !";

                }
                else
                {

                    //txtBatchNo.Text = dt.Rows[0]["BatchNo"].ToString();
                    txtTitle.Text = dt.Rows[0]["Title"].ToString();
                   // txtTitle.Enabled = false;
                    txtProductName.Text = dt.Rows[0]["ProductName"].ToString();
                   // txtProductName.Enabled = false;
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
                    txtStockDpWithTax.Text = dt.Rows[0]["dpstockwithtax"].ToString();
                    txtDPStock.Text = dt.Rows[0]["DPStock"].ToString();
                    //txtDPTax.Text = dt.Rows[0]["Tax"].ToString();
                    ddlGST.SelectedIndex = ddlGST.Items.IndexOf(ddlGST.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, dt.Rows[0]["Tax"].ToString(), true) == 0).FirstOrDefault());
                    //txtSTTax.Text = dt.Rows[0]["STTax"].ToString();
                    //txtQTY.Text = dt.Rows[0]["QTY"].ToString();
                    txtDP.Text = dt.Rows[0]["DPAmt"].ToString();
                    txtBV.Text = dt.Rows[0]["BVAmt"].ToString();

                    txtpvamt.Text=dt.Rows[0]["pbvamt"].ToString();
                    //txtDescription.Text = dt.Rows[0]["Description"].ToString();
                    

                    txttitle1.Text = dt.Rows[0]["pt1"].ToString();
                    txtDescription1.Text = dt.Rows[0]["pd1"].ToString();
                    txttitle2.Text = dt.Rows[0]["pt2"].ToString();
                    txtDescription2.Text = dt.Rows[0]["pd2"].ToString();
                    txtTitle3.Text = dt.Rows[0]["pt3"].ToString();
                    txtDescription3.Text = dt.Rows[0]["pd3"].ToString();
                    txtTitle4.Text = dt.Rows[0]["pt4"].ToString();
                    txtDescription4.Text = dt.Rows[0]["pd4"].ToString();
                    txtTitle5.Text = dt.Rows[0]["pt5"].ToString();
                    txtDescription5.Text = dt.Rows[0]["pd5"].ToString();

                    txtTitle6.Text = dt.Rows[0]["pt6"].ToString();
                    txtDescription6.Text = dt.Rows[0]["pd6"].ToString();
                    txtTitle7.Text = dt.Rows[0]["pt7"].ToString();
                    txtDescription7.Text = dt.Rows[0]["pd7"].ToString();
                    txtTitle8.Text = dt.Rows[0]["pt8"].ToString();
                    txtDescription8.Text = dt.Rows[0]["pd8"].ToString();
                    txtTitle9.Text = dt.Rows[0]["pt9"].ToString();
                    txtDescription9.Text = dt.Rows[0]["pd9"].ToString();
                    txtTitle10.Text = dt.Rows[0]["pt10"].ToString();
                    txtDescription10.Text = dt.Rows[0]["pd10"].ToString();


                    txtMfdDate.Text = dt.Rows[0]["MadeDoe"].ToString();
                    txt_MaxAllowed.Text = dt.Rows[0]["MaxAllowed"].ToString();
                    txthsncode.Text = dt.Rows[0]["hsncode"].ToString();
                    txtCostAmt.Text = dt.Rows[0]["Price"].ToString();
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
        catch
        {

        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //if (txtDescription.Text.Length > 200)
        //{
        //    utility.MessageBox(this, "Description should not exceed than 200 Characters.");
        //    return;

        //}

        //CheckBatch();

        //if (!string.IsNullOrEmpty(ViewState["batch"].ToString()))
        //{
        //    if (txtBatchNo.Text == ViewState["batch"].ToString())
        //    {
        //        utility.MessageBox(this, "Batch No Already Exists!");
        //        return;

        //    }


        //}
        if (!string.IsNullOrEmpty(txtProductName.Text.Trim()))
        {
            //if (!string.IsNullOrEmpty(txtBatchNo.Text.Trim()))
            //{
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
                                                //if (!string.IsNullOrEmpty(txtDescription.Text.Trim()))
                                                //{
                                                    if (Regex.Match(txt_MaxAllowed.Text.Trim().ToString(), @"^[0-9.]*$").Success)
                                                    {
                                                        if (!string.IsNullOrEmpty(txtCostAmt.Text.Trim()) && Regex.Match(txtCostAmt.Text.Trim(), @"^[0-9.]*$").Success)
                                                        {
                                                            // if (!string.IsNullOrEmpty(txtMfdDate.Text.Trim()))
                                                            // {

                                                            editProduct();
                                                        }
                                                        else
                                                        {
                                                            utility.MessageBox(this, "The cost amount is required and should be numeric value!");
                                                        }
                                                       // }
                                                       // else
                                                      //  {
                                                      //      utility.MessageBox(this, "Please Enter Manufacturing Date.");
                                                      //  }
                                                    }
                                                    else
                                                    {
                                                        utility.MessageBox(this, "Please Enter Numeric and Max Allowed!");
                                                    }

                                                //}
                                                //else
                                                //{
                                                //    utility.MessageBox(this, "Please Enter Description!");
                                                //}
                                            }
                                            else
                                            {
                                                utility.MessageBox(this, "Please Enter Numeric BV!");
                                            }
                                        }
                                        else
                                        {
                                            utility.MessageBox(this, "Please Enter BV !");
                                        }
                                    }
                                    else
                                    {
                                        utility.MessageBox(this, "Please Enter Numeric DP!");
                                    }
                                }
                                else
                                {
                                    utility.MessageBox(this, "Please Enter DP !");
                                }

                            }
                            else
                            {
                                utility.MessageBox(this, "Please Enter Numeric MRP!");
                            }
                        }
                        else
                        {
                            utility.MessageBox(this, "Please Enter MRP!");
                        }
                    }
                    else
                    {
                        utility.MessageBox(this, "Only 50 Characters Are Allowed In Title!");
                    }
                }
                else
                {
                    utility.MessageBox(this, "Please Enter Title!");
                }
            //}
            //else
            //{
            //    utility.MessageBox(this, "Please Enter Batch No.");
            //}
        }
        else
        {
            utility.MessageBox(this, "Please Enter Product !");
        }
        go();
    }
    public void editProduct()
    {
        //System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        //dateInfo.ShortDatePattern = "dd/MM/yyyy";
        //DateTime mfgdate = new DateTime();
        //mfgdate = Convert.ToDateTime(txtMfdDate.Text.Trim(), dateInfo);



        con = new SqlConnection(method.str);
        cmd = new SqlCommand();
        try
        {
            cmd = new SqlCommand("editShopProduct1", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ProductId", productId);
            //cmd.Parameters.AddWithValue("@BatchNo", txtBatchNo.Text.Trim());
            cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@PackSize", int.Parse(txtPack.Text.Trim()));

            cmd.Parameters.AddWithValue("@PackSizeUnitId", ddlPackSize.SelectedValue.ToString());

            // cmd.Parameters.AddWithValue("@PackSizeUnitId", (string.IsNullOrEmpty(txtPack.Text.Trim())) == true ? 0 : Convert.ToInt32(ddlPackSize.SelectedValue.ToString()));
            cmd.Parameters.AddWithValue("@MRP", double.Parse(txtMRP.Text.Trim().ToString()));
            cmd.Parameters.AddWithValue("@DPWithTax", double.Parse(txtDPWithTax.Text.Trim()));
            cmd.Parameters.AddWithValue("@Tax", double.Parse(ddlGST.SelectedItem.Text.Trim()));
            cmd.Parameters.AddWithValue("@STTax", "0");
            //cmd.Parameters.AddWithValue("@QTy", int.Parse(txtQTY.Text.Trim()));
          
            //cmd.Parameters.AddWithValue("@DP", string.IsNullOrEmpty(hdnCalculatedDP.Value.Trim()) == true ? Convert.ToDouble(txtDP.Text.Trim()) : Convert.ToDouble(hdnCalculatedDP.Value.Trim()));
            //cmd.Parameters.AddWithValue("@BV", string.IsNullOrEmpty(hdnCalculatedBV.Value.Trim()) == true ? Convert.ToDouble(txtBV.Text.Trim()) : Convert.ToDouble(hdnCalculatedBV.Value.Trim()));
          
            //cmd.Parameters.AddWithValue("@DP", string.IsNullOrEmpty(hdnCalculatedDP.Value.Trim()) == true ? Convert.ToString((Convert.ToDecimal(txtDPWithTax.Text.Trim()) * 100) / (Convert.ToDecimal(ddlGST.SelectedItem.Text.Trim()) + 100)) : hdnCalculatedDP.Value.Trim());
            //cmd.Parameters.AddWithValue("@BV", string.IsNullOrEmpty(hdnCalculatedBV.Value.Trim()) == true ? txtBV.Text.Trim() : hdnCalculatedBV.Value.Trim());

            cmd.Parameters.AddWithValue("@DP", Convert.ToString((Convert.ToDecimal(txtDPWithTax.Text.Trim()) * 100) / (Convert.ToDecimal(ddlGST.SelectedItem.Text.Trim()) + 100)));

            cmd.Parameters.AddWithValue("@BV", txtBV.Text.Trim());
  
            
            cmd.Parameters.AddWithValue("@pbvamt",Convert.ToDecimal(txtpvamt.Text.Trim()));
            cmd.Parameters.AddWithValue("@MaxAllowed", int.Parse(txt_MaxAllowed.Text.Trim()));
            cmd.Parameters.AddWithValue("@hsncode", txthsncode.Text.Trim());

            cmd.Parameters.AddWithValue("@CostAmt", double.Parse(txtCostAmt.Text.Trim()));
            //cmd.Parameters.AddWithValue("@mfdDate", mfgdate);
            //cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());

            cmd.Parameters.AddWithValue("@pt1", txttitle1.Text.Trim());
            cmd.Parameters.AddWithValue("@pd1", txtDescription1.Text.Trim());   
            cmd.Parameters.AddWithValue("@pt2", txttitle2.Text.Trim());   
            cmd.Parameters.AddWithValue("@pd2", txtDescription2.Text.Trim());   
            cmd.Parameters.AddWithValue("@pt3", txtTitle3.Text.Trim());   
            cmd.Parameters.AddWithValue("@pd3", txtDescription3.Text.Trim());   
            cmd.Parameters.AddWithValue("@pt4", txtTitle4.Text.Trim());   
            cmd.Parameters.AddWithValue("@pd4", txtDescription4.Text.Trim());   
            cmd.Parameters.AddWithValue("@pt5", txtTitle5.Text.Trim());   
            cmd.Parameters.AddWithValue("@pd5", txtDescription5.Text.Trim());   
            cmd.Parameters.AddWithValue("@pt6", txtTitle6.Text.Trim());   
            cmd.Parameters.AddWithValue("@pd6", txtDescription6.Text.Trim());   
            cmd.Parameters.AddWithValue("@pt7", txtTitle7.Text.Trim());   
            cmd.Parameters.AddWithValue("@pd7", txtDescription7.Text.Trim());   
            cmd.Parameters.AddWithValue("@pt8", txtTitle8.Text.Trim());   
            cmd.Parameters.AddWithValue("@pd8", txtDescription8.Text.Trim());   
            cmd.Parameters.AddWithValue("@pt9", txtTitle9.Text.Trim());   
            cmd.Parameters.AddWithValue("@pd9", txtDescription9.Text.Trim());   
            cmd.Parameters.AddWithValue("@pt10", txtTitle10.Text.Trim());
            cmd.Parameters.AddWithValue("@pd10", txtDescription10.Text.Trim());
            cmd.Parameters.AddWithValue("@Dpstockgst", Convert.ToDouble(txtStockDpWithTax.Text.Trim()));
            cmd.Parameters.AddWithValue("@DPStockAmt", Convert.ToString((Convert.ToDecimal(txtStockDpWithTax.Text.Trim()) * 100) / (Convert.ToDecimal(ddlGST.SelectedItem.Text.Trim()) + 100)));
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            string result = cmd.Parameters["@flag"].Value.ToString();                                                                            
            con.Close();
            utility.MessageBox(this, result);
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

    //private void CheckBatch()
    //{
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        cmd = new SqlCommand("CheckBatchNo", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@BatchNo", txtBatchNo.Text.Trim());
    //        da = new SqlDataAdapter(cmd);
    //        dt = new DataTable();
    //        da.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {

    //            ViewState["batch"] = dt.Rows[0]["BatchNo"].ToString();


    //        }
    //        else
    //        {
    //            ViewState["batch"] = "";
    //        }

    //    }
    //    catch
    //    {

    //    }
    //}
}