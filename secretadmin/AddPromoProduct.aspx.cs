using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.IO;
using System.Data;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;


public partial class secretadmin_AddPromoProduct : System.Web.UI.Page
{
    string strPostedFile, strFile, a;
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    SqlCommand com;
    utility objUtil = new utility();
    DataTable dt = new DataTable();
    int height, width, packsizeunitid;
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
        if (!Page.IsPostBack)
        {

            getCategory();
            if (Session["Category"] != null)
            {
                ddlCategory.Items.FindByValue(Convert.ToString(Session["Category"])).Selected = true;
            }
            getPackSize();
            BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), string.Empty);
        }
    }
    public void getCategory()
    {
        da = new SqlDataAdapter("select distinct CatId,CatName from  Categorymst where isDeleted=0", con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = dt.Columns["CatName"].ToString();
            ddlCategory.DataValueField = dt.Columns["CatId"].ToString();
            ddlCategory.DataBind();
        }
    }
    public void getPackSize()
    {
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
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {

        BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), string.Empty);
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        utility objUtility = new utility();

        this.Rte1.Text = H1.Value;
        a = H1.Value;
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


                            if (!string.IsNullOrEmpty(txtBV.Text.Trim()))
                            {
                                if (Regex.Match(txtQuanty.Text.Trim().ToString(), @"^[0-9.]*$").Success)
                                {
                                    if (Regex.Match(txtBV.Text.Trim().ToString(), @"^[0-9.]*$").Success)
                                    {


                                        if (!string.IsNullOrEmpty(Rte1.Text.Trim()))
                                        {
                                            if (Regex.Match(txt_MaxBilling.Text.Trim().ToString(), @"^[0-9.]*$").Success)
                                            {
                                                addProduct();
                                            }
                                            else
                                            {
                                                utility.MessageBox(this, "Please Enter Numeric and Max Allowed!");
                                            }
                                        }
                                        else
                                        {
                                            utility.MessageBox(this, "Please enter description!");
                                        }
                                    }
                                    else
                                    {
                                        utility.MessageBox(this, "Please Enter Numeric Values!");
                                    }
                                }
                                else
                                {
                                    utility.MessageBox(this, "Please enter numeric BV!");
                                }
                            }
                            else
                            {
                                utility.MessageBox(this, "Please enter BV !");
                            }

                        }
                        else
                        {
                            utility.MessageBox(this, "Please enter numeric MRP!");
                        }
                    }
                    else
                    {
                        utility.MessageBox(this, "Please enter MRP!");
                    }
                }
                else
                {
                    utility.MessageBox(this, "Only 50 characters are allowed in title!");
                }
            }
            else
            {
                utility.MessageBox(this, "Please enter title!");
            }
        }
        else
        {
            utility.MessageBox(this, "Please enter product !");
        }
    }


    public void saveImg(string file)
    {
        try
        {
            if (imgUpload.HasFile)
            {
                string[] strFileNames = Directory.GetFiles(Server.MapPath("~/ProductImages/"));
                strPostedFile = Server.MapPath("~/ProductImages/" + file);
                // FileInfo objFile = new FileInfo(strPostedFile);

                int flag = 0;
                for (int ctr = 0; ctr < strFileNames.Length; ctr++)
                {
                    string ss = strFileNames[ctr];

                    if (strPostedFile == strFileNames[ctr])
                    {
                        flag = 1;
                    }
                }

                if (flag == 1)
                {
                    utility.MessageBox(this, "Image not saved.this image already exits with the same name!Plaese re-name your image!");
                }
                else
                {
                    imgUpload.SaveAs(strPostedFile);

                    //Product Images Resize starts

                    using (System.Drawing.Image objImage = System.Drawing.Image.FromFile(strPostedFile))
                    {
                        height = 250;
                        width = Convert.ToInt32(Convert.ToDecimal(height) * (Convert.ToDecimal(Convert.ToString(Convert.ToInt32(objImage.Width.ToString()) / Convert.ToInt32(objImage.Height.ToString())) + "." + Convert.ToString(Convert.ToInt32(objImage.Width.ToString()) % Convert.ToInt32(objImage.Height.ToString())))));
                    }
                    Stream stream = imgUpload.PostedFile.InputStream;
                    System.Drawing.Bitmap image = new System.Drawing.Bitmap(stream);
                    System.Drawing.Bitmap target = new System.Drawing.Bitmap(width, height);
                    System.Drawing.Graphics graphic = System.Drawing.Graphics.FromImage(target);
                    graphic.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                    graphic.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                    graphic.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                    graphic.DrawImage(image, 0, 0, width, height);
                    target.Save(Server.MapPath("~/ProductImages/" + file));

                    //Product Images Resize ends

                }
            }

        }
        catch
        {
            //utility.MessageBox(this,"Try again.";

        }
    }
    private void addProduct()
    {

        if (imgUpload.HasFile)
        {
            if (Regex.Match(txtProductName.Text.Trim().ToString(), @"^[a-zA-Z0-9 ]*$").Success)
            {
                strFile = txtProductName.Text.Trim().ToString().Replace(" ", "").ToString().Replace("'", "").Replace(".", "") + System.IO.Path.GetExtension(this.imgUpload.PostedFile.FileName).ToString();
            }
            else
            {
                strFile = this.imgUpload.PostedFile.FileName.ToString();
            }
        }
        else
        {
            strFile = "0";
        }
        try
        {


            com = new SqlCommand("AddPromoProduct", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@CatId", ddlCategory.SelectedValue.ToString());
            com.Parameters.AddWithValue("@ProductName", txtProductName.Text.Trim().ToString());
            com.Parameters.AddWithValue("@PackSize", txtPack.Text);

            //com.Parameters.AddWithValue("@PackSizeUnitId", string.IsNullOrEmpty(txtPack.Text.Trim()) == true ? "0" : ddlPackSize.SelectedValue.ToString());
            com.Parameters.AddWithValue("@PackSizeUnitId", ddlPackSize.SelectedValue.ToString());
            com.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
            com.Parameters.AddWithValue("@MRP", txtMRP.Text.Trim().ToString());
            com.Parameters.AddWithValue("@DPWithTax", txtDPWithTax.Text.Trim());
            com.Parameters.AddWithValue("@Tax", txtDPTax.Text.Trim());
            com.Parameters.AddWithValue("@STTax", txtStock.Text.Trim());

            com.Parameters.AddWithValue("@DPAmt", string.IsNullOrEmpty(hdnCalculatedDP.Value.Trim()) == true ? Convert.ToString((Convert.ToDecimal(txtDPWithTax.Text.Trim()) * 100) / (Convert.ToDecimal(txtDPTax.Text.Trim()) + 100)) : hdnCalculatedDP.Value.Trim());
            com.Parameters.AddWithValue("@BVAmt", string.IsNullOrEmpty(hdnCalculatedBV.Value.Trim()) == true ? txtBV.Text.Trim() : hdnCalculatedBV.Value.Trim());
            com.Parameters.AddWithValue("@ImageName", strFile);
            com.Parameters.AddWithValue("@Qty", 0);

            com.Parameters.AddWithValue("@weight", Convert.ToDouble(txtWeight.Text));
            com.Parameters.AddWithValue("@Description", a);
            com.Parameters.AddWithValue("@MaxAllowed", txt_MaxBilling.Text.Trim());

            com.Parameters.Add("@iName", SqlDbType.VarChar, 50);
            com.Parameters["@iName"].Direction = ParameterDirection.Output;
            com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            com.Parameters.AddWithValue("@ProductId", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            com.CommandTimeout = 999999;
            com.ExecuteNonQuery();
            int result = Convert.ToInt32(com.Parameters["@flag"].Value);
            if (result == 11)
            {
                utility.MessageBox(this, "Product added successfully!");
                getPackSize();
                saveImg((String)com.Parameters["@iName"].Value);
                Session["Category"] = ddlCategory.SelectedValue.ToString();
                resetControls();

                utility.MessageBox(this, "Promo Product Added Successfully");
                //Response.Redirect("ProductDetail.aspx?pd=" + objUtil.base64Encode(com.Parameters["@ProductId"].Value.ToString()));
            }
            else if (result == 1)
            {
                utility.MessageBox(this, "This product already exists in in-acitve list,Please activate from there ! !");
            }
            else if (result == 0)
            {
                utility.MessageBox(this, "This product already exists in acitve list !");
            }
            else
            {
                utility.MessageBox(this, "Operation Unsuccessful!Please try later");
            }


        }
        catch
        {
            utility.MessageBox(this, "Try again.");
        }
        finally
        {
            con.Close();

        }


    }


    public void resetControls()
    {
        txtTitle.Text = txtProductName.Text = txtPack.Text = txtDPWithTax.Text = txtDPTax.Text = txtStock.Text = string.Empty;
        txtMRP.Text = string.Empty;
        txtDP.Text = string.Empty;
        Rte1.Text = string.Empty;
        txtTitle.Text = string.Empty;

    }

    private void BindGrid(int Status, string product)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        ViewState["Count"] = null;
        try
        {
            da = new SqlDataAdapter("getpromoProductList", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@CatId", ddlCategory.SelectedValue.ToString());
            da.SelectCommand.Parameters.AddWithValue("@Product", product);
            da.SelectCommand.Parameters.AddWithValue("@isDeleted", Status);

            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                GridView1.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
                ViewState["product"] = dt;
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                ViewState["product"] = null;
                GridView1.DataSource = null;
                GridView1.DataBind();
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

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    System.Web.UI.WebControls.Image img = (System.Web.UI.WebControls.Image)e.Row.FindControl("imgStatus");
        //    LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkbtnStatus");
        //    if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "sts")) == "Activated")
        //    {
        //        img.ImageUrl = "images/yes.jpeg";
        //        lnkbtn.Text = "De Activate";
        //        lnkbtn.CommandName = "DeActivate";
        //    }
        //    else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "sts")) == "De-Activated")
        //    {
        //        img.ImageUrl = "images/no.jpeg";
        //        lnkbtn.Text = "Activate";
        //        lnkbtn.CommandName = "Activate";
        //    }
        //}
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "Page")
        {
            int rowindex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = GridView1.Rows[rowindex];
            Label lbl = (Label)row.FindControl("lblId");
            if (e.CommandName == "DeActivate")
            {
                updateStatus(lbl.Text, 1);
                utility.MessageBox(this, "Product de activated successfully !");
            }
            else if (e.CommandName == "Activate")
            {
                updateStatus(lbl.Text, 0);
                utility.MessageBox(this, "Product activated successfully !");
            }
        }
    }
    public void updateStatus(string id, int st)
    {
        SqlConnection con = new SqlConnection(method.str);
        da = new SqlDataAdapter();
        try
        {

            com = new SqlCommand("editProductStatus", con);
            com.CommandType = CommandType.StoredProcedure;
            com.CommandTimeout = 99999;
            com.Parameters.AddWithValue("@isDeleted", st);
            com.Parameters.AddWithValue("@ProductId", id);
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), txtSearch.Text.Trim());
            }
            else
            {
                BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), string.Empty);
            }
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            da.Dispose();
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
        {
            BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), txtSearch.Text.Trim());
        }
        else
        {
            if (ViewState["product"] != null)
            {
                DataTable dt = new DataTable();
                dt = (DataTable)ViewState["product"];
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), string.Empty);
            }
        }
    }


    protected void btnShow_Click(object sender, EventArgs e)
    {
        txtSearch.Text = string.Empty;
        BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), string.Empty);
    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {

        if (ddlStatus.SelectedItem.Text == "Active" || ddlStatus.SelectedItem.Text == "In Active")
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                {
                    BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), txtSearch.Text.Trim());
                }
                else
                {
                    if (ViewState["product"] != null)
                    {
                        DataTable dt = new DataTable();
                        dt = (DataTable)ViewState["product"];
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                    else
                    {
                        BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), string.Empty);
                    }
                }
                GridView1.Columns[10].Visible = GridView1.Columns[11].Visible = GridView1.Columns[12].Visible = GridView1.Columns[13].Visible = false;
                Response.Clear();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductList.xls");
                Response.Charset = "";
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter stringWrite = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
                GridView1.RenderControl(htmlWrite);
                Response.Write(stringWrite.ToString());
                Response.End();
            }
            else
                utility.MessageBox(this, "can not export as no data found !");
        }
    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlStatus.SelectedItem.Text == "Active" || ddlStatus.SelectedItem.Text == "In Active")
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                {
                    BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), txtSearch.Text.Trim());
                }
                else
                {
                    if (ViewState["product"] != null)
                    {
                        DataTable dt = new DataTable();
                        dt = (DataTable)ViewState["product"];
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                    else
                    {
                        BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), string.Empty);
                    }
                }
                GridView1.Columns[10].Visible = GridView1.Columns[11].Visible = GridView1.Columns[12].Visible = GridView1.Columns[13].Visible = false;
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductList.doc");
                Response.ContentType = "application/vnd.ms-word";
                StringWriter stw = new StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                GridView1.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();

            }
            else
                utility.MessageBox(this, "can not export as no data found !");
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), txtSearch.Text.Trim());
        else
            utility.MessageBox(this, "Please enter product!");
    }
    protected void btnShowAll_Click(object sender, EventArgs e)
    {
        txtSearch.Text = string.Empty;
        BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), string.Empty);
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtSearch.Text = string.Empty;
        BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), string.Empty);
    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtSearch.Text = string.Empty;
        BindGrid(Convert.ToInt32(ddlStatus.SelectedValue.ToString()), string.Empty);
    }

   
}
