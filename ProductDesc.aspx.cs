using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls; 

public partial class product_detail : System.Web.UI.Page
{

    string DefaultCat = "", catid = "0", pid = "0", VideoName = "", KEY_INGREDIENTS = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Request.QueryString.Count > 0)
                {
                    BindId(); // This function execute first

                    BindProdId();

                    //BindCategory();
                    BindProduct();
                    BindMultiImage();
                    BindProdBanner();
                }
                else
                {
                    Response.Redirect("Products");
                }

                lbl_CategoryTitle.InnerHtml = DefaultCat;
                lbl_CategoryTitle2.InnerHtml = "<a href='javascript:void(0)'>Home</a></span><i class='fa fa-angle-right'></i><span><a href='javascript:void(0)'>" + DefaultCat + "</a>";

            }
        }
        catch (Exception ex) { }
    }


    private void BindProdBanner()
    {
        try
        {
            int flag = 0;
            StringBuilder sb = new StringBuilder();
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[] { new SqlParameter("@pid", hnd_PId.Value) };
            //string Query = "Select ProductId, CatId, DocName, YoutubeUrl from ShopProductMst where isDeleted=0 and Replace(ProductName,' ','-') like '%'+@pname+'%'";
            string Query = @"Select pb.Pid,pb.BanrImg,pb.ImgURL
            from ProductBanner pb where pid=@pid";

            SqlDataReader dr = objDu.GetDataReader(param1, Query);
            while (dr.Read())
            {
                string url = dr["ImgURL"].ToString();
                string img = dr["BanrImg"].ToString();
                if (string.IsNullOrEmpty(url))
                    url = "javascrip:void(0)";
                if (flag == 0)
                {
                    sb.Append("<div class='item active'><a href='" + url + "'><img width='100%' data-u='image' src='ProductImage/" + dr["BanrImg"].ToString() + "'></a> </div> ");
                }
                else
                {
                    sb.Append("<div class='item'><a href='" + url + "'><img width='100%' data-u='image' src='ProductImage/" + dr["BanrImg"].ToString() + "'></a> </div> ");
                }
                flag = flag + 1;
            }
                

            dr.Close();
            //Div_Slider.InnerHtml = sb.ToString();

            //ddl_SZId.Items.Insert(0, new ListItem("No Size", "0"));

        }
        catch (Exception ex) { }
    }
    private void BindId()
    {
        try
        {
            int IsExists = 0, IsVariant = 0, Count=0;
            string Link = "", Desc_str = "", gif_str = "", StrColor="";
            string Pname = Request.QueryString[0].ToString();
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[] { new SqlParameter("@pname", Pname) };
            //string Query = "Select ProductId, CatId, DocName, YoutubeUrl from ShopProductMst where isDeleted=0 and Replace(ProductName,' ','-') like '%'+@pname+'%'";
            string Query = @"Select s.ProductId, s.CatId, s.ProductCode, s.DocName, s.VideoName, s.YoutubeUrl, s.PT2, s.PD2, s.PT3, s.PD3, s.PT4, s.PD4, s.PT5, s.PD5, s.gif1, s.gif2, s.gif3, s.gif4, s.Title_gif1, s.Title_gif2, s.Title_gif3, s.Title_gif4,
            s.PT8, s.PD8, s.PT9, s.PD9, s.PT10, s.PD10, s.INGREDIENTS_Title, s.EffectResultImg, s.TitleScroll, IsVariant=isnull(s.IsVariant,0),c.CountryName,s.CountryOrigin
            from ShopProductMst s left join Countrymst c on s.CountryOrigin=c.CountryId where isDeleted=0 and Replace(ProductName,' ','-')=@pname";

            SqlDataReader dr = objDu.GetDataReader(param1, Query);
            while (dr.Read())
            {
                catid = dr["CatId"].ToString();
                hnd_PId.Value = pid = dr["ProductId"].ToString();
                VideoName = dr["VideoName"].ToString();

                lbl_ItemCode.InnerHtml = dr["ProductCode"].ToString();

                if (!string.IsNullOrEmpty(dr["DocName"].ToString()))
                {
                    Link += "<a href='" + dr["DocName"].ToString() + "' target='_blank' class='btn-submit' style='padding: 10px; text-align: center;'><i class='fa fa-file-pdf-o me-0'></i></a>";
                }
                if (!string.IsNullOrEmpty(dr["YoutubeUrl"].ToString()))
                {
                    Link += "<a href='" + dr["YoutubeUrl"].ToString() + "' target='_blank' class='btn-submit youtube1' style='padding: 5px; margin-right: 10px; border-radius: 0px;'><i class='fa fa-play me-0' style='border-radius: 50% / 11%;background: #fff; color: #e52d27; height: 28px; width: 28px; padding: 8px; font-size: 13px;'></i></a>";
                }
                div_Add_Link.InnerHtml = Link;


                if (!string.IsNullOrEmpty(dr["PD8"].ToString()))
                {
                    KEY_INGREDIENTS += "<div class='col-md-4 bx_shd'> <div class='key_in'> <div class='key_txt'> <div class='key_cntnt'>";
                    KEY_INGREDIENTS += "<p><strong>" + dr["PT8"].ToString() + "</strong></p>";
                    KEY_INGREDIENTS += "<p>" + dr["PD8"].ToString() + " </p>";
                    KEY_INGREDIENTS += "</div> </div> </div> </div>";
                }

                if (!string.IsNullOrEmpty(dr["PD9"].ToString()))
                {
                    KEY_INGREDIENTS += "<div class='col-md-4 bx_shd'> <div class='key_in'> <div class='key_txt'> <div class='key_cntnt'>";
                    KEY_INGREDIENTS += "<p><strong>" + dr["PT9"].ToString() + "</strong></p>";
                    KEY_INGREDIENTS += "<p>" + dr["PD9"].ToString() + " </p>";
                    KEY_INGREDIENTS += "</div> </div> </div> </div>";
                }

                if (!string.IsNullOrEmpty(dr["PD10"].ToString()))
                {
                    KEY_INGREDIENTS += "<div class='col-md-4 bx_shd'> <div class='key_in'> <div class='key_txt'> <div class='key_cntnt'>";
                    KEY_INGREDIENTS += "<p><strong>" + dr["PT10"].ToString() + "</strong></p>";
                    KEY_INGREDIENTS += "<p>" + dr["PD10"].ToString() + " </p>";
                    KEY_INGREDIENTS += "</div> </div> </div> </div>";
                }
                div_KEY_INGREDIENTS.InnerHtml = KEY_INGREDIENTS;

                div_INGREDIENTS_Title.InnerHtml = dr["INGREDIENTS_Title"].ToString();
                div_TitleScroll.InnerText = dr["TitleScroll"].ToString();
                img_EffectResultImg.ImageUrl = "../ProductImage/" + dr["EffectResultImg"].ToString();


                string PT2 = "";
                if (!string.IsNullOrEmpty(dr["PT2"].ToString()))
                {
                        PT2 = PT2 + "<div class='nm product-detail-accordion'><div class='cc-accordion cc-initialized' data-allow-multi-open='true'><details class='cc-accordion-item'><summary class='cc-accordion-item__title'>"+ dr["PT2"].ToString() + "</summary><div class='cc-accordion-item__panel'><div class='cc-accordion-item__content rte cf'><p></p><p>"+ dr["PD2"].ToString() + "</p></div></div></details></div></div>";
                }
                else
                {
                    PT2 = "";
                }
                div_PT2.InnerHtml = PT2;
                string PT3 = "";
                if (!string.IsNullOrEmpty(dr["PT3"].ToString()))
                {
                    PT3 = PT3 + "<div class='nm product-detail-accordion'><div class='cc-accordion cc-initialized' data-allow-multi-open='true'><details class='cc-accordion-item'><summary class='cc-accordion-item__title'>" + dr["PT3"].ToString() + "</summary><div class='cc-accordion-item__panel'><div class='cc-accordion-item__content rte cf'><p></p><p>" + dr["PD3"].ToString() + "</p></div></div></details></div></div>";
                }
                else
                {
                    PT3 = "";
                }
                div_PT3.InnerHtml = PT3;
                string PT4 = "";
                if (!string.IsNullOrEmpty(dr["PT4"].ToString()))
                {
                    PT4 = PT4 + "<div class='nm product-detail-accordion'><div class='cc-accordion cc-initialized' data-allow-multi-open='true'><details class='cc-accordion-item'><summary class='cc-accordion-item__title'>" + dr["PT4"].ToString() + "</summary><div class='cc-accordion-item__panel'><div class='cc-accordion-item__content rte cf'><p></p><p>" + dr["PD4"].ToString() + "</p></div></div></details></div></div>";
                }
                else
                {
                    PT4 = "";
                }
                div_PT4.InnerHtml = PT4;
                string PT5 = "";
                if (!string.IsNullOrEmpty(dr["PT5"].ToString()))
                {
                    PT5 = PT5 + "<div class='nm product-detail-accordion'><div class='cc-accordion cc-initialized' data-allow-multi-open='true'><details class='cc-accordion-item'><summary class='cc-accordion-item__title'>" + dr["PT5"].ToString() + "</summary><div class='cc-accordion-item__panel'><div class='cc-accordion-item__content rte cf'><p></p><p>" + dr["PD5"].ToString() + "</p></div></div></details></div></div>";
                }
                else
                {
                    PT5 = "";
                }
                div_PT5.InnerHtml = PT5;

                string prodetail = "";
                if (!string.IsNullOrEmpty(dr["PT10"].ToString()))
                //   string prodetail
                //div_detail.InnerHtml = prodetail;
                {
                    if (!string.IsNullOrEmpty(dr["CountryOrigin"].ToString()))
                    {
                        prodetail = prodetail + "<div class='nm product-detail-accordion'><div class='cc-accordion cc-initialized' data-allow-multi-open='true'><details class='cc-accordion-item'><summary class='cc-accordion-item__title'>" + dr["PT10"].ToString() + "</summary><div class='cc-accordion-item__panel'><div class='cc-accordion-item__content rte cf'><p></p><p>" + dr["PD10"].ToString() + "<br>Country Of Origin: " + dr["CountryName"].ToString() + "</p></div></div></details></div></div>";

                        //prodetail = prodetail + "<div class='faq-list'><ul><li><i class='fa fa-info-circle icon-help' aria-hidden='true'></i><a data-bs-toggle='collapse' class='collapse' data-bs-target='#faq-list-1'>" + dr["PT10"].ToString() + "<i class='fa fa-sm fa-angle-down icon-show' aria-hidden='true'></i><i class='fa fa-sm fa-angle-up icon-close'></i></a><div id ='faq-list-1' class='collapse show' data-bs-parent='.faq-list'><p>" + dr["PD10"].ToString() + "<br>Country Of Origin: " + dr["CountryName"].ToString() + "</p></div> </li></ul></div>";

                    }
                    else
                    {
                        prodetail = prodetail + "<div class='nm product-detail-accordion'><div class='cc-accordion cc-initialized' data-allow-multi-open='true'><details class='cc-accordion-item'><summary class='cc-accordion-item__title'>" + dr["PT10"].ToString() + "</summary><div class='cc-accordion-item__panel'><div class='cc-accordion-item__content rte cf'><p></p><p>" + dr["PD10"].ToString() + "</p></div></div></details></div></div>";

                    }
                }
                else
                {
                    prodetail = "";
                }



                div_ProdDetails.InnerHtml = prodetail;



                if (!string.IsNullOrEmpty(dr["PT2"].ToString()))
                {
                    Desc_str += "<div class='nm product-detail-accordion not-in-quickbuy'>";
                    Desc_str += "<div class='cc-accordion cc-initialized' data-allow-multi-open='true'>";
                    Desc_str += "<details class='cc-accordion-item'>";
                    Desc_str += "<summary class='cc-accordion-item__title'> " + dr["PT2"].ToString() + " </summary>";
                    Desc_str += "<div class='cc-accordion-item__panel'>";
                    Desc_str += "<div class='cc-accordion-item__content rte cf'> " + dr["PD2"].ToString() + " </div> ";
                    Desc_str += "</div>";
                    Desc_str += "</details>";
                    Desc_str += "</div>";
                    Desc_str += "</div>";
                }

                if (!string.IsNullOrEmpty(dr["PT3"].ToString()))
                {
                    Desc_str += "<div class='nm product-detail-accordion not-in-quickbuy'>";
                    Desc_str += "<div class='cc-accordion cc-initialized' data-allow-multi-open='true'>";
                    Desc_str += "<details class='cc-accordion-item'>";
                    Desc_str += "<summary class='cc-accordion-item__title'> " + dr["PT3"].ToString() + " </summary>";
                    Desc_str += "<div class='cc-accordion-item__panel'>";
                    Desc_str += "<div class='cc-accordion-item__content rte cf'> " + dr["PD3"].ToString() + " </div> ";
                    Desc_str += "</div>";
                    Desc_str += "</details>";
                    Desc_str += "</div>";
                    Desc_str += "</div>";
                }

                if (!string.IsNullOrEmpty(dr["PT4"].ToString()))
                {
                    Desc_str += "<div class='nm product-detail-accordion not-in-quickbuy'>";
                    Desc_str += "<div class='cc-accordion cc-initialized' data-allow-multi-open='true'>";
                    Desc_str += "<details class='cc-accordion-item'>";
                    Desc_str += "<summary class='cc-accordion-item__title'> " + dr["PT4"].ToString() + " </summary>";
                    Desc_str += "<div class='cc-accordion-item__panel'>";
                    Desc_str += "<div class='cc-accordion-item__content rte cf'> " + dr["PD4"].ToString() + " </div> ";
                    Desc_str += "</div>";
                    Desc_str += "</details>";
                    Desc_str += "</div>";
                    Desc_str += "</div>";
                }

                if (!string.IsNullOrEmpty(dr["PT5"].ToString()))
                {
                    Desc_str += "<div class='nm product-detail-accordion not-in-quickbuy'>";
                    Desc_str += "<div class='cc-accordion cc-initialized' data-allow-multi-open='true'>";
                    Desc_str += "<details class='cc-accordion-item'>";
                    Desc_str += "<summary class='cc-accordion-item__title'> " + dr["PT5"].ToString() + " </summary>";
                    Desc_str += "<div class='cc-accordion-item__panel'>";
                    Desc_str += "<div class='cc-accordion-item__content rte cf'> " + dr["PD5"].ToString() + " </div> ";
                    Desc_str += "</div>";
                    Desc_str += "</details>";
                    Desc_str += "</div>";
                    Desc_str += "</div>";
                }
                div_DescriptionTab.InnerHtml = Desc_str;


                // gif1, gif2, gif3, gif4, Title_gif1, Title_gif2, Title_gif3, Title_gif4
                if (!string.IsNullOrEmpty(dr["gif1"].ToString()))
                    gif_str += "<li class='benefits__item'> <img width='70px' height='70px' class='benefits__icon' src='../Productimage/" + dr["gif1"].ToString() + "'> <p class='benefits__text'>" + dr["Title_gif1"].ToString() + "</p> </li>";

                if (!string.IsNullOrEmpty(dr["gif2"].ToString()))
                    gif_str += "<li class='benefits__item'> <img width='70px' height='70px' class='benefits__icon' src='../Productimage/" + dr["gif2"].ToString() + "'> <p class='benefits__text'>" + dr["Title_gif2"].ToString() + "</p> </li>";

                if (!string.IsNullOrEmpty(dr["gif3"].ToString()))
                    gif_str += "<li class='benefits__item'> <img width='70px' height='70px' class='benefits__icon' src='../Productimage/" + dr["gif3"].ToString() + "'> <p class='benefits__text'>" + dr["Title_gif3"].ToString() + "</p> </li>";

                if (!string.IsNullOrEmpty(dr["gif4"].ToString()))
                    gif_str += "<li class='benefits__item'> <img width='70px' height='70px' class='benefits__icon' src='../Productimage/" + dr["gif4"].ToString() + "'> <p class='benefits__text'>" + dr["Title_gif4"].ToString() + "</p> </li>";

                div_gif.InnerHtml = gif_str;


                IsExists = 1;

                if (dr["IsVariant"].ToString() == "True")
                    IsVariant = 1;
            }
            dr.Close();

            //ddl_SZId.Items.Insert(0, new ListItem("No Size", "0"));
            if (IsVariant == 1)
            {
                dic_Color_Disp.Visible= dic_Size_Disp.Visible = true;

                SqlParameter[] param = new SqlParameter[] { new SqlParameter("@pid", pid) };
                DataTable dt = objDu.GetDataTableSP(param, "Get_Size");
                ddl_SZId.Items.Clear();
                if (dt.Rows.Count > 0)
                {
                    ddl_SZId.DataSource = dt;
                    ddl_SZId.DataTextField = "Size";
                    ddl_SZId.DataValueField = "SZId";
                    ddl_SZId.DataBind();
                }
                else
                    ddl_SZId.Items.Insert(0, new ListItem("No Size", "0"));

              
                dt = null; 
                dt = GetColor(pid, ddl_SZId.SelectedValue);
                foreach (DataRow item in dt.Rows)
                {
                    if(Count==0) {
                        hnd_CLRId.Value = item["CLRId"].ToString(); 
                        StrColor += "<input name='1' value='"+ item["CLRId"].ToString() + "' onclick='SelectColor("+ item["CLRId"].ToString() + ")' type='radio' class='strong-aggree' style='background:" + item["ColorCode"].ToString() + ";' checked />";
                    }
                    else {
                        StrColor += "<input name='1' value='" + item["CLRId"].ToString() + "' onclick='SelectColor("+ item["CLRId"].ToString() + ")' type='radio' class='strong-aggree' style='background:" + item["ColorCode"].ToString() + ";' />";
                    }
                    Count = 1;
                }
                div_ColorBind.InnerHtml = StrColor;
            }

            if (IsExists == 0)
                Response.Redirect("Products");
        }
        catch (Exception ex) { }
    }


    private static DataTable GetColor(string pid, string SZId)
    {
        SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@pid", pid), new SqlParameter("@SZId", SZId)
        };
        DataUtility objDu=new DataUtility();
       return objDu.GetDataTableSP(param, "Get_Color");
    }
    private void BindCategory()
    {
        string CategoryStr = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP("GetCategory");
            while (dr.Read())
            {
                string category = dr["catname"].ToString().Replace(" ", "-");

                CategoryStr += "<li class='p-0 mb-3'>";
                if (dr["catid"].ToString() == catid)
                {
                    DefaultCat = dr["catname"].ToString();
                    //Img_Banner.Attributes.Add("src", "images/product/icon/" + dr["imagename"].ToString());
                    CategoryStr += "<div class='service-block active'>";
                }
                else
                {
                    CategoryStr += "<div class='service-block'>";
                }

                CategoryStr += "<div class=inner-box'>";
                CategoryStr += "<div class='icon'> <a href='products?" + category + "'><img src='images/product/icon/" + dr["IconImg"].ToString() + "' alt='' /></a></div>";
                CategoryStr += "<h5><a href='products?" + category + "'>" + category + "</a></h5>";

                CategoryStr += "</div>";
                CategoryStr += "</div>";
                CategoryStr += "</li>";
            }
            dr.Close();
            //div_category.InnerHtml = CategoryStr;
        }
        catch (Exception er) { }
    }



    private void BindProduct()
    {
        //string ProductStr = "";
        try
        {
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@id", pid) };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "productdesc");
            while (dr.Read())
            {
                // lbl_ProdName.Text = dr["ProductCode"].ToString() +" - "+ dr["ProductName"].ToString();
                lbl_ProdName.Text = dr["ProductName"].ToString();
                lbl_Desc_Eng.InnerHtml = dr["PD1"].ToString();
                //lbl_Desc_Hin.InnerHtml = dr["PD2"].ToString();

                lbl_ProdName2.Text = dr["TagName"].ToString();

                div_PackSize.InnerHtml = dr["PackSize"].ToString() + dr["PackSizeName"].ToString();
                lbl_MRP.Text = dr["mrp"].ToString();
                lbl_CrossMRP.Text = dr["DPWithTax"].ToString(); 
            }
            dr.Close();
        }
        catch (Exception ex) { }
    }

    private void BindMultiImage()
    {
        try
        {
            string MultiBigImg = "", MultiProdScrollImg = "";
            int count = 1;
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {
                new SqlParameter("@pid", pid)
            };
            SqlDataReader dr = objDu.GetDataReader(param1, "Select top 10 ImageName, ImageDefault from ShopProductImageMst where isnull(CLRId,0)=0 and isnull(SZId,0)=0 and ProductId=@pid and isnull(IsDeleted,0)=0 order by ImageDefault desc");
            while (dr.Read())
            {
                string ProdImg = dr["imagename"].ToString();
                if (string.IsNullOrEmpty(ProdImg))
                    ProdImg = "no-image.jpg";

                if (dr["ImageDefault"].ToString() == "1")
                {
                    MultiBigImg += "<div class='item active'> <img src='Productimage/" + ProdImg + "'/>  </div> ";

                    MultiProdScrollImg += "<li data-target='#carousel-custom' data-slide-to='0' class='active'> <img src='Productimage/" + ProdImg + "' alt='' /></li>";
                }
                else
                {
                    MultiBigImg += "<div class='item'> <img src='Productimage/" + ProdImg + "' /> </div>";

                    MultiProdScrollImg += "<li data-target='#carousel-custom' data-slide-to='" + count + "'> <img src='Productimage/" + ProdImg + "' alt='' /> </li>";
                    count = count + 1;

                }
            }
            if (MultiBigImg == "")
            {
                MultiBigImg += "<div class='item active'> <img src='Productimage/no-image.jpg'/>  </div> ";

                MultiProdScrollImg += "<li data-target='#carousel-custom' data-slide-to='0' class='active'> <img src='Productimage/no-image.jpg' alt='' /></li>";
            }
            //if (VideoName != "")
            //{
            //    MultiProdScrollImg += "<li> <img src='images/video.jpg' alt='' data-toggle='modal' data-target='#exampleModal' /></li>";
            //    div_video.InnerHtml = "<video controls='' autoplay='' muted='' loop='' id='myVideo' style='width: 100%;'> <source src='Productimage/" + VideoName + "'> </video>";
            //}
            div_MultiBigImg.InnerHtml = MultiBigImg;
            div_MultiProdScrollImg.InnerHtml = MultiProdScrollImg;
        }
        catch (Exception ex) { }
    }


    private void BindProdId()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand com = new SqlCommand("BatchListData", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@Pid", pid);
        com.Parameters.AddWithValue("@UserId", method.DEFAULT_SELLER);
        com.Parameters.AddWithValue("@BatchList", "");
        com.Parameters.AddWithValue("@BillType", "1");
        com.Parameters.Add("@Batchid", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        com.Parameters.Add("@balqty", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;

        con.Open();
        com.CommandTimeout = 1900;
        com.ExecuteNonQuery();
        string Batchid = com.Parameters["@Batchid"].Value.ToString();
        string balqty = com.Parameters["@balqty"].Value.ToString();
        if (balqty != "0")
        {
            //div_AddBtn.InnerHtml = "<a href='javascript:void(0)' onclick='AddToCart()' class='btn add_to_cart btn-block'>Add to Cart</a>";

            if (AddToCart(Batchid) == "1")
                div_AddBtn.InnerHtml = "<a href='javascript:void(0)' id='AddCart_" + Batchid + "' onclick='AddToCart()' class='added-to-cart btn-block'>Added to Cart</a>";

           // "<a href='javascript:void(0)' id='AddCart_" + Batchid + "' onclick='AddToCart(" + dr["batchid"].ToString() + ")' class='added-to-cart' data-toggle='tooltip' data-original-title='Added to Cart'>Added to Cart</a>";
            else
                div_AddBtn.InnerHtml = "<a href='javascript:void(0)' id='AddCart_" + Batchid + "' onclick='AddToCart()' class='btn add_to_cart btn-block'>Add to Cart</a>";

            //ProductStr += "<a href='javascript:void(0)' onclick='AddToCart(" + dr["batchid"].ToString() + ")' class='btn -submit'><i class='fa fa-shopping-cart'></i>Add to card</a>";  class='btn-custom btn-sm secondary ml-4'  aria-hidden='true'
            // <a href="#" class="btn-submit"><i class="fa fa-shopping-cart"></i>Add to card</a>
        }
        else
        {
            div_AddBtn.InnerHtml = "<a href='javascript:void(0)' class='btn-submit disabled'><i class='fa fa-shopping-cart'></i>Out of Stock</a>";
        }
        div_Wishlist.InnerHtml = "<a href='javascript:void(0)' onclick='AddToWishList(" + Batchid + ");' class='wishlet'> <i class='fa fa-heart'></i> </a>";
        hnd_Batchid.Value = Batchid;
        //<a href="#" class="wishlet"><i class="fa fa-heart-o"></i></a>
    }


    private static string AddToCart(string batchid)
    {
        string result = "0";
        if (HttpContext.Current.Session["RootCart"] != null)
        {
            DataTable Cartdt = (DataTable)HttpContext.Current.Session["RootCart"];
            if (Cartdt.Select("batchid='" + batchid + "'").FirstOrDefault() != null)
                result = "1";
        }
        return result;
    }


    [WebMethod]
    public static ArrayList BindColor(string PId, string SZId)
    {
        ArrayList list = new ArrayList();
        try
        {
            DataTable dt = GetColor(PId, SZId);
            foreach (DataRow dr in dt.Rows)
            { list.Add(new ListItem(dr["ColorCode"].ToString(), dr["CLRId"].ToString())); }
        }
        catch (Exception er) { }
        return list;
    }




    [WebMethod]
    public static Classes.VariantColorSize BindSizeColor(string PId, string SZId, string CLRId)
    {
        Classes.VariantColorSize data = new Classes.VariantColorSize();
        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@Pid", PId),
            new SqlParameter("@SZId", SZId),
            new SqlParameter("@CLRId", CLRId),
            new SqlParameter("@UserId", method.DEFAULT_SELLER),
        };
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_BatchId_By_Color_Size");
        while (dr.Read())
        {

            data.Batchid = dr["Batchid"].ToString();
            data.balqty = dr["balqty"].ToString();
            data.MRP = dr["MRP"].ToString();
            data.ImageName = dr["ImageName"].ToString();
        }
        dr.Close();
        return data;
    }

    private void RelatedProducts()
    {
        try
        {
            string RelatedProd = "";
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@catid", catid),
                new SqlParameter("@id", pid)
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "getRelatedProd");
            while (dr.Read())
            {
                RelatedProd += "<div class='product'>";
                RelatedProd += "<div class='product-thumbnail'>";
                RelatedProd += "<a href='javascript:void(0)'> <img src='Productimage/" + dr["imagename"].ToString() + "'></a>";
                RelatedProd += "</div>";
                RelatedProd += "</div>";
            }
            dr.Close();
            div_RelatedProduct.InnerHtml = RelatedProd;
        }
        catch (Exception ex) { }
    }

    private void TrendingProducts()
    {
        try
        {
            string TrendingProd = "";
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@catid", catid),
                new SqlParameter("@id", pid)
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "getTrendingProd");
            while (dr.Read())
            {
                TrendingProd += "<div class='product'>";
                TrendingProd += "<div class='product-thumbnail'>";
                TrendingProd += "<a href='javascript:void(0)'> <img src='Productimage/" + dr["imagename"].ToString() + "'></a>";
                TrendingProd += "</div>";
                TrendingProd += "</div>";
            }
            dr.Close();
            div_TrendingProduct.InnerHtml = TrendingProd;
        }
        catch (Exception ex) { }
    }


}