using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.IO;
using System.Data;
using System.Web.UI.WebControls;
using System.Drawing;

public partial class d2000admin_AddEditProduct : System.Web.UI.Page
{
    string strPostedFile, strFile, pdfFile, strPostedFile1, Description1, Description2, Description3, Description4, Description5, Description6, Description7, Description8, Description9, Description10;
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    SqlCommand com;
    utility objUtil = new utility();
    DataTable dt = new DataTable();
    int height, width, packsizeunitid;
    string ShowProdPrice = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("adminLog.aspx");
            }
            if (!Page.IsPostBack)
            {
                getCategory();
                getPackSize();
                GetCountries();
                GetBrand();
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["id"] != null)
                    {
                        BindProduct(Request.QueryString["id"].ToString());
                        chk_IsComboPack.Attributes.Add("onclick", "return false;");
                    }
                }
            }
        }
        catch
        {
        }
    }


    public void GetBrand()
    {
        utility obju = new utility();
        DataTable dt = obju.ProductBrandList();
        ddl_bid.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddl_bid.DataSource = dt;
            ddl_bid.DataTextField = "Title";
            ddl_bid.DataValueField = "bid";
            ddl_bid.DataBind();
        }
        ddl_bid.Items.Insert(0, new ListItem("Select Brand", ""));
    }


    public void GetCountries()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select CId=CountryID, CountryName from countrymst order by CountryName");
        ddl_Countries.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddl_Countries.DataSource = dt;
            ddl_Countries.DataTextField = "CountryName";
            ddl_Countries.DataValueField = "CId";
            ddl_Countries.DataBind();
            ddl_Countries.SelectedValue = "101";
        }
        ddl_Countries.Items.Insert(0, new ListItem("Select Country", ""));
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(txtProductCode.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter product/bar Code!");
                return;
            }
            else if (string.IsNullOrEmpty(txtProductName.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter product !");
                return;
            }
            else if (string.IsNullOrEmpty(txt_Prod_Display.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter product display name !");
                return;
            }
            else if (string.IsNullOrEmpty(ddl_LUnit.SelectedValue.ToString()))
            {
                utility.MessageBox(this, "Please Select Length Unit Type !");
                return;
            }
            else if (string.IsNullOrEmpty(txt_length.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter Length Value !");
                return;
            }
            else if (string.IsNullOrEmpty(txt_width.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter Width Value !");
                return;
            }
            else if (string.IsNullOrEmpty(txt_height.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter Height Value !");
                return;
            }
            else
            {
                addProduct();
            }
        }
        catch
        {
        }
    }

    public void saveImg(string file)
    {
        try
        {
            if (imgUpload.HasFile)
            {
                string[] strFileNames = Directory.GetFiles(Server.MapPath("~/ProductImage/"));
                strPostedFile = Server.MapPath("~/ProductImage/" + file);
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
                    utility.MessageBox(this, "Image already exits with the same name! Plaese re-name your image!");
                }
                else
                {
                    imgUpload.SaveAs(strPostedFile);
                    using (System.Drawing.Image objImage = System.Drawing.Image.FromFile(strPostedFile))
                    {
                        height = 350;
                        width = 300;
                    }
                    Stream stream = imgUpload.PostedFile.InputStream;
                    System.Drawing.Bitmap image = new System.Drawing.Bitmap(stream);
                    System.Drawing.Bitmap target = new System.Drawing.Bitmap(width, height);
                    System.Drawing.Graphics graphic = System.Drawing.Graphics.FromImage(target);
                    graphic.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                    graphic.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                    graphic.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                    graphic.DrawImage(image, 0, 0, width, height);
                    target.Save(Server.MapPath("~/ProductImage/" + file));
                }
            }

        }
        catch
        {
        }
    }


    public void savepdf(string pdff)
    {
        try
        {
            if (pdfUpload.HasFile)
            {
                string[] strFileNames = Directory.GetFiles(Server.MapPath("~/ProductImage/"));
                strPostedFile1 = Server.MapPath("~/ProductImage/" + pdff);
                int flag = 0;
                for (int ctr = 0; ctr < strFileNames.Length; ctr++)
                {
                    string ss = strFileNames[ctr];

                    if (strPostedFile1 == strFileNames[ctr])
                    {
                        flag = 1;
                    }
                }

                if (flag == 1)
                {
                    utility.MessageBox(this, "File already exits with the same name! Please re-name your file!");
                }
                else
                {
                    pdfUpload.SaveAs(strPostedFile1);
                }
            }

        }
        catch
        {
        }
    }
    private void addProduct()
    {
        if (Session["admin"] == null)
        {
            Response.Redirect("adminLog.aspx");
        }


        if (imgUpload.HasFile)
        {
            if (Regex.Match(txtProductName.Text.Trim().ToString(), @"^[a-zA-Z0-9 ]*$").Success)
            {
                strFile = imgUpload.PostedFile.FileName.ToString();
            }
            else
            {
                strFile = this.imgUpload.PostedFile.FileName.ToString();
            }
        }
        else
        {
            strFile = "noimage.png";
        }
        if (pdfUpload.HasFile)
        {
            if (Regex.Match(txtProductName.Text.Trim().ToString(), @"^[a-zA-Z0-9 ]*$").Success)
            {
                pdfFile = pdfUpload.PostedFile.FileName.ToString();
            }
            else
            {
                pdfFile = this.pdfUpload.PostedFile.FileName.ToString();
            }
        }
        else
        {
            pdfFile = "0";
        }

        String EffectResultImg = "";
        if (FU_EffectResultImg.HasFile)
        {
            Stream stream = FU_EffectResultImg.PostedFile.InputStream;
            Bitmap bitimg = new Bitmap(stream);
            int height = bitimg.Height;
            int width = bitimg.Width;
            if (width == 1400 && height == 520)
            {
                string Random = Guid.NewGuid().ToString();
                EffectResultImg = Random + Path.GetExtension(FU_EffectResultImg.FileName);
            }
            else
            {
                utility.MessageBox(this, "Image size must be width 1400 and height 520.");
                return;
            }
        }


        try
        {
            string ProductId = "0";
            if (Request.QueryString.Count > 0)
            {
                if (Request.QueryString["id"] != null)
                    ProductId = Request.QueryString["id"].ToString();
            }


            com = new SqlCommand("AddProduct1", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@AdminId", Session["admin"].ToString());
            com.Parameters.AddWithValue("@EditProductId", ProductId);
            com.Parameters.AddWithValue("@ProductCode", txtProductCode.Text.Trim().ToString());
            com.Parameters.AddWithValue("@CatId", ddlCategory.SelectedValue.ToString());
            com.Parameters.AddWithValue("@SubCatId", ddl_Sub_Cat.SelectedValue.ToString());

            com.Parameters.AddWithValue("@ProductName", txtProductName.Text.Trim());
            com.Parameters.AddWithValue("@Prod_Display", txt_Prod_Display.Text.Trim());
            com.Parameters.AddWithValue("@TagName", txt_TagName.Text.Trim());
            com.Parameters.AddWithValue("@YoutubeUrl", txt_youtubeUrl.Text.Trim());

            com.Parameters.AddWithValue("@HSNCODE", txt_HSN.Text);
            com.Parameters.AddWithValue("@GST", ddlGST.SelectedValue);
            com.Parameters.AddWithValue("@PackSize", txtPack.Text);
            com.Parameters.AddWithValue("@PackSizeUnitId", ddlPackSize.SelectedValue.ToString());

            com.Parameters.AddWithValue("@CaseSize", txt_CaseSize.Text);
            com.Parameters.AddWithValue("@IsVariant", chk_variant.Checked == true ? "1" : "0");

            com.Parameters.AddWithValue("@MaxLoyalty", txt_MaxLoyalty.Text.Trim() == "" ? "0" : txt_MaxLoyalty.Text.Trim());

            com.Parameters.AddWithValue("@Country_Origin", ddl_Countries.SelectedValue);
            com.Parameters.AddWithValue("@bid", ddl_bid.SelectedValue);


            com.Parameters.AddWithValue("@IsRedeem", ddl_IsRedeem.SelectedValue.ToString());
            com.Parameters.AddWithValue("@SaleType", ddl_SaleType.SelectedValue.ToString());
            com.Parameters.AddWithValue("@L_Unit", ddl_LUnit.SelectedValue.ToString());
            // FC3 float, FC4 float, FC5 float, FC6 float, FC7 float, FC8 float, FC9 float, FC10

            com.Parameters.AddWithValue("@FPC3", "0");
            com.Parameters.AddWithValue("@FPC4", "0");
            com.Parameters.AddWithValue("@FPC5", "0");
            com.Parameters.AddWithValue("@FPC6", "0");
            com.Parameters.AddWithValue("@FSC4", "0");
            com.Parameters.AddWithValue("@FSC5", "0");
            com.Parameters.AddWithValue("@FSC6", "0");
            com.Parameters.AddWithValue("@FSC7", "0");

            com.Parameters.AddWithValue("@pt1", "");
            com.Parameters.AddWithValue("@pd1", txtDescription1.Text.Trim());
            com.Parameters.AddWithValue("@pt2", txtTitle1.Text.Trim());
            com.Parameters.AddWithValue("@pd2", txtDescription2.Text.Trim());
            com.Parameters.AddWithValue("@pt3", txtTitle2.Text.Trim());
            com.Parameters.AddWithValue("@pd3", txtDescription3.Text.Trim());
            com.Parameters.AddWithValue("@pt4", txtTitle3.Text.Trim());
            com.Parameters.AddWithValue("@pd4", txtDescription4.Text.Trim());
            com.Parameters.AddWithValue("@pt5", txtTitle4.Text.Trim());
            com.Parameters.AddWithValue("@pd5", txtDescription5.Text.Trim());
            com.Parameters.AddWithValue("@ImageName", strFile);
            com.Parameters.AddWithValue("@DocName", pdfFile);
            com.Parameters.AddWithValue("@weight", Convert.ToDouble(txtWeight.Text));
            com.Parameters.AddWithValue("@Description", ""); // txtpdesc.Text.Trim());
            com.Parameters.AddWithValue("@ProductCost", txt_ProductCost.Text.Trim() == "" ? "0" : txt_ProductCost.Text.Trim());
            com.Parameters.AddWithValue("@IsComboPack", chk_IsComboPack.Checked == true ? "1" : "0");

            com.Parameters.AddWithValue("@Lengths", txt_length.Text.Trim());
            com.Parameters.AddWithValue("@Width", txt_width.Text.Trim());
            com.Parameters.AddWithValue("@Height", txt_height.Text.Trim());

            com.Parameters.AddWithValue("@PT8", txt_PT8.Text.Trim());
            com.Parameters.AddWithValue("@PD8", txtPD8.Text.Trim());
            com.Parameters.AddWithValue("@PT9", txt_PT9.Text.Trim());
            com.Parameters.AddWithValue("@PD9", txtPD9.Text.Trim());
            com.Parameters.AddWithValue("@PT10", txt_manufacture_title.Text.Trim());
            com.Parameters.AddWithValue("@PD10", txt_manufacture_detail.Text.Trim());
            com.Parameters.AddWithValue("@Ing_header", txt_Ingredients_Topic.Text.Trim());

            com.Parameters.AddWithValue("@INGREDIENTS_Title", txt_INGREDIENTS_Title.Text.Trim());
            com.Parameters.AddWithValue("@TitleScroll", txt_TitleScroll.Text.Trim());
            com.Parameters.AddWithValue("@EffectResultImg", EffectResultImg);


            com.Parameters.Add("@iName", SqlDbType.VarChar, 50);
            com.Parameters["@iName"].Direction = ParameterDirection.Output;
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            com.Parameters.AddWithValue("@ProductId", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            com.CommandTimeout = 999999;
            com.ExecuteNonQuery();
            string result = com.Parameters["@flag"].Value.ToString();
            if (result == "11")
            {
                if (FU_EffectResultImg.HasFile)
                {
                    FU_EffectResultImg.PostedFile.SaveAs(Server.MapPath("~/ProductImage/" + EffectResultImg));
                }

                //saveImg(strFile);
                savepdf(pdfFile);
                utility.MessageBox(this, "Product added successfully!");
                resetControls();
                Response.Redirect("ProductList.aspx");
            }
            else if (result == "1")
            {
                utility.MessageBox(this, "Product already exists, Please activate from there ! !");
            }
            else if (result == "0")
            {
                utility.MessageBox(this, "Product already exists in acitve list !");
            }
            else
            {
                utility.MessageBox(this, result);
            }


        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.Message);
        }
        finally
        {
            con.Close();
        }
    }


    public void resetControls()
    {


        txt_CaseSize.Text = "";
        ddl_IsRedeem.SelectedValue = "0";
        ddl_SaleType.SelectedValue = "0";

        txtPack.Text = "";
        //txtpdesc.Text = "";

        txtProductName.Text = "";
        txt_Prod_Display.Text = "";
        txt_TagName.Text = "";
        txt_youtubeUrl.Text = "";
        txtWeight.Text = "";

    }


    public void BindProduct(String productId)
    {

        utility obju = new utility();
        ShowProdPrice = obju.GetShowProdPrice(Session["admin"].ToString());
        //string Variant = chk_variant.Checked.ToString();
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
                div_Product.Visible = false;
                div_Product1.Visible = false;
                txtProductCode.Enabled = false;

                ddlCategory.SelectedValue = dt.Rows[0]["CatId"].ToString();
                getSubCategory(dt.Rows[0]["CatId"].ToString());
                ddl_Sub_Cat.SelectedValue = dt.Rows[0]["SubCatId"].ToString();

                txtProductCode.Text = dt.Rows[0]["ProductCode"].ToString();
                txtProductName.Text = dt.Rows[0]["ProductName"].ToString();
                txt_Prod_Display.Text = dt.Rows[0]["Prod_Display"].ToString();
                ddl_LUnit.SelectedValue = dt.Rows[0]["LengthUnit"].ToString();
                txt_TagName.Text = dt.Rows[0]["TagName"].ToString();
                txt_youtubeUrl.Text = dt.Rows[0]["YoutubeUrl"].ToString();
                String Variant = dt.Rows[0]["IsVariant"].ToString();
                if (Variant == "True")
                {
                    chk_variant.Checked = true;
                    chk_variant.Enabled = false;
                }

                else
                {
                    chk_variant.Checked = false;
                }


                if (ShowProdPrice == "1")
                    txt_ProductCost.Text = dt.Rows[0]["Price"].ToString();
                else
                {
                    txt_ProductCost.Text = "*****";
                    txt_ProductCost.ReadOnly = true;
                }
                ddlGST.SelectedValue = dt.Rows[0]["Tax"].ToString();

                txt_HSN.Text = dt.Rows[0]["HSNCode"].ToString();
                txtWeight.Text = dt.Rows[0]["weight"].ToString();
                txt_CaseSize.Text = dt.Rows[0]["CaseSize"].ToString();
                txtDescription1.Text = dt.Rows[0]["pd1"].ToString();
                txtTitle10.Text = dt.Rows[0]["pt1"].ToString();
                txtDescription2.Text = dt.Rows[0]["pd2"].ToString();
                txtTitle1.Text = dt.Rows[0]["pt2"].ToString();
                txtDescription3.Text = dt.Rows[0]["pd3"].ToString();
                txtTitle2.Text = dt.Rows[0]["pt3"].ToString();
                txtDescription4.Text = dt.Rows[0]["pd4"].ToString();
                txtTitle3.Text = dt.Rows[0]["pt4"].ToString();
                txtDescription5.Text = dt.Rows[0]["pd5"].ToString();
                txtTitle4.Text = dt.Rows[0]["pt5"].ToString();

                txt_length.Text = dt.Rows[0]["Lengths"].ToString();
                txt_width.Text = dt.Rows[0]["Width"].ToString();
                txt_height.Text = dt.Rows[0]["Height"].ToString();


                txt_TitleScroll.Text = dt.Rows[0]["TitleScroll"].ToString();
                txt_Ingredients_Topic.Text = dt.Rows[0]["Ing_header"].ToString();
                txt_INGREDIENTS_Title.Text = dt.Rows[0]["INGREDIENTS_Title"].ToString();

                if (!string.IsNullOrEmpty(dt.Rows[0]["EffectResultImg"].ToString()))
                    div_EffectResult.InnerHtml = "<img src='../ProductImage/" + dt.Rows[0]["EffectResultImg"].ToString() + "' style='width: 400px; height: 150px;'>";


                txt_PT8.Text = dt.Rows[0]["pt8"].ToString();
                txtPD8.Text = dt.Rows[0]["pd8"].ToString();
                txt_PT9.Text = dt.Rows[0]["pt9"].ToString();
                txtPD9.Text = dt.Rows[0]["pd9"].ToString();
                //txt_PT10.Text = dt.Rows[0]["pt10"].ToString();
                //txtPD10.Text = dt.Rows[0]["pd10"].ToString(); 
                ddl_bid.SelectedValue = dt.Rows[0]["bid"].ToString();

                ddl_Countries.SelectedValue = dt.Rows[0]["CountryOrigin"].ToString();
                ddl_IsRedeem.SelectedValue = dt.Rows[0]["IsRedeem"].ToString();
                ddl_SaleType.SelectedValue = dt.Rows[0]["SaleType"].ToString();
                txt_manufacture_title.Text = dt.Rows[0]["pt10"].ToString();
                txt_manufacture_detail.Text = dt.Rows[0]["pd10"].ToString();
                txt_MaxLoyalty.Text = dt.Rows[0]["MaxLoyalty"].ToString();

                txtPack.Text = dt.Rows[0]["PackSize"].ToString();
                ddlPackSize.Items.FindByValue(dt.Rows[0]["PackSizeUnitId"].ToString()).Selected = true;

                if (dt.Rows[0]["IsComboPack"].ToString() == "1")
                {
                    chk_IsComboPack.Checked = true;
                    chk_IsComboPack.Attributes.Add("onclick", "return false;");
                }


            }
        }
        catch (Exception er) { }
        {
        }
    }


    public void getPackSize()
    {

        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select srno,PackSize from PackSizemst where isDeleted=0 order by PackSize");
        if (dt.Rows.Count > 0)
        {
            ddlPackSize.DataSource = dt;
            ddlPackSize.DataTextField = "PackSize";
            ddlPackSize.DataValueField = "srno";
            ddlPackSize.DataBind();
        }
        else
        {
            ddlPackSize.Items.Insert(0, "Pack size unit is not added");
        }

    }



    public void getCategory()
    {

        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("select distinct CatId,CatName from  Categorymst where isDeleted=0");
        if (dt.Rows.Count > 0)
        {
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CatName";
            ddlCategory.DataValueField = "CatId";
            ddlCategory.DataBind();
        }

        getSubCategory(ddlCategory.SelectedValue);
    }


    public void getSubCategory(string CatId)
    {
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@CatId", CatId)
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param, "Select SubCatId, SubCatName from SubCategoryMst where CatId=@CatId");
            ddl_Sub_Cat.Items.Clear();
            if (dt.Rows.Count > 0)
            {
                ddl_Sub_Cat.DataSource = dt;
                ddl_Sub_Cat.DataTextField = "SubCatName";
                ddl_Sub_Cat.DataValueField = "SubCatId";
                ddl_Sub_Cat.DataBind();
            }
            ddl_Sub_Cat.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch
        {
        }
    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        getSubCategory(ddlCategory.SelectedValue);
    }
}
