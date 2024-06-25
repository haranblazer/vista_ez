using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

public partial class product : System.Web.UI.Page
{
    string DefaultCat = "", SubCatName = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //  Session["RootCart"] = null;

        if (!IsPostBack)
        {
            BindMenu();
            if (Request.QueryString.Count > 0)
            {
                //if (Request.QueryString["title"] != null)
                // DefaultCat = Request.QueryString["title"].ToString();

                if (Request.QueryString["c"] != null)
                    hdn_CatId.Value = Request.QueryString["c"].ToString();

                if (Request.QueryString["sc"] != null)
                    hdn_SubCatId.Value = Request.QueryString["sc"].ToString();
            }
            BindProduct1();
        }
    }


    private void BindMenu()
    {
        if (Session["Menu"] != null)
        {
            div_ProdCategory.InnerHtml = Session["Menu"].ToString();
        }
        else
        {
            string str_menu = "";
            str_menu += "<ul>";

            DataUtility objDu = new DataUtility();
            DataSet ds = objDu.GetDataSetSP("GetCategory_MultiLable");
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    string category = dr["catname"].ToString().Replace(" ", "-");
                    if (Convert.ToInt32(dr["Count_SubCat"].ToString()) > 0)
                        str_menu += "<li class='menu-item-has-children has-children'><a href='#'>" + category + " </a>";
                    else
                        str_menu += "<li><a href='#'>" + category + " </a>";


                    if (ds.Tables[1].Rows.Count > 0 || Convert.ToInt32(dr["Count_SubCat"].ToString()) > 0)
                    {
                        str_menu += "<ul class='sub-menu'>";
                        foreach (DataRow dr1 in ds.Tables[1].Rows)
                        {
                            if (dr["catid"].ToString() == dr1["catid"].ToString())
                            {
                                string subcategory = dr1["SubCatName"].ToString().Replace(" ", "-");
                                str_menu += "<li><a href='products?c=" + dr1["catid"].ToString() + "&sc=" + dr1["SubCatId"].ToString() + "&title=" + subcategory + "'>" + subcategory + "</a></li>";
                            }
                        }
                        str_menu += "</ul>";
                    }
                    str_menu += "</li>";
                }
            }
            str_menu += "</ul>";
            div_ProdCategory.InnerHtml = str_menu;
            Session["Menu"] = str_menu;
        }
    }



    private void BindProduct1()
    {
        String tbl = "";
        DataUtility objDu = new DataUtility();
        if (Request.QueryString.Count == 0)
        {
            DataTable dt = objDu.GetDataTable(@"Select c.CatId, c.CatName, sc.SubCatId, sc.SubCatName 
            from CategoryMst c inner join SubCategoryMst sc on c.CatId=sc.CatId 
            where c.isDeleted=0 and sc.isDeleted=0 order by c.PriorityDispaly offset 0 rows fetch next 1 rows only");
            if (dt.Rows.Count > 0)
            {
                hdn_CatId.Value = dt.Rows[0]["CatId"].ToString();
                hdn_SubCatId.Value = dt.Rows[0]["SubCatId"].ToString();
                DefaultCat = dt.Rows[0]["CatName"].ToString();
                SubCatName = dt.Rows[0]["SubCatName"].ToString();
            }
        }
        else
        {
            SqlParameter[] param1 = new SqlParameter[]
            {
                new SqlParameter("@catid", hdn_CatId.Value),
                new SqlParameter("@SubCatId", hdn_SubCatId.Value),
            };
            DataTable dt = objDu.GetDataTable(param1, @"Select c.CatName, sc.SubCatName
            from CategoryMst c inner join SubCategoryMst sc on c.CatId=sc.CatId 
            where c.isDeleted=0 and sc.isDeleted=0 and c.CatId=@catid and sc.SubCatId=@SubCatId 
            order by c.PriorityDispaly offset 0 rows fetch next 1 rows only");
            if (dt.Rows.Count > 0)
            {
                DefaultCat = dt.Rows[0]["CatName"].ToString();
                SubCatName = dt.Rows[0]["SubCatName"].ToString();
            }
        }

        lbl_CategoryTitle.InnerHtml = DefaultCat;
        lbl_CategoryTitle2.InnerHtml = "<a href='javascript:void(0)'></a></span><span><a href='javascript:void(0)'>" + SubCatName + "</a>";

        SqlParameter[] param = new SqlParameter[]
        {
             new SqlParameter("@catid", hdn_CatId.Value),
            new SqlParameter("@SubCatId", hdn_SubCatId.Value),
        };

        SqlDataReader dr = objDu.GetDataReaderSP(param, "GetRootProd");
        while (dr.Read())
        {
            string product = dr["pname"].ToString().Replace(" ", "-");
            tbl += "<div class='col-lg-4 col-md-4 col-sm-6 col-6'>";
            tbl += "<div class='single-makal-product'>";
            tbl += "<div class='pro-img'> <a href='p?" + product + "'>  <img src='Productimage/" + dr["ImageName"].ToString() + "' alt='product-img'> </a>";
            tbl += "<span class='sticker-new'>new</span>";
            tbl += "<div class='quick-view-pro'> <a data-bs-toggle='modal' data-bs-target='#product-window' class='quick-view' href='javascript:void(0)'></a> </div>";
            tbl += "</div>";
            tbl += "<div class='pro-content'>";
            tbl += "<h4 class='pro-title'> <a href='p?" + product + "'>" + dr["pname"].ToString() + "</a> </h4>";
            tbl += "<span class='product-item_code'>Item Code: " + dr["Pcode"].ToString() + "</span>";
            tbl += "<span class='product-qty'>" + dr["PackSizeName"].ToString() + " </span>";

            tbl += "<div class='pro-actions'>";
            tbl += "<div class='actions-secondary'> <span class='price'>MRP. " + dr["MRP"].ToString() + "</span> </div>";
            tbl += "<div class='actions-primary'>";



            if (dr["IsVariant"].ToString() == "1")
                tbl += "<a class='btn btn-success' data-toggle='tooltip' href='p?" + product + "'>View</a>";
            else if (dr["MaxQty"].ToString() == "0")
                tbl += "<a href='javascript:void(0)' class='button disabled' data-toggle='tooltip' data-original-title='Out of Stock'>Out of Stock</a>";
            else
            { 
                if(AddToCart(dr["batchid"].ToString()) == "1")
                    tbl += "<a href='javascript:void(0)' id='AddCart_" + dr["batchid"].ToString() + "' onclick='AddToCart(" + dr["batchid"].ToString() + ")' class='added-to-cart' data-toggle='tooltip' data-original-title='Added to Cart'>Added to Cart</a>";
                else
                    tbl += "<a href='javascript:void(0)' id='AddCart_" + dr["batchid"].ToString() + "' onclick='AddToCart(" + dr["batchid"].ToString() + ")' class='add-to-cart' data-toggle='tooltip' data-original-title='Add to Cart'>Add to Cart</a>";
            }
            tbl += "</div>";
            tbl += "</div>";
            tbl += "</div>";
            tbl += "</div>";
            tbl += "</div>";
        }
        div_Product.InnerHtml = tbl;
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

    //private void BindCategory()
    //{
    //    string CategoryStr = "";
    //    try
    //    {
    //        if (Request.QueryString.Count == 0)
    //            DefaultCat = "Blushers";
    //        else
    //            DefaultCat = Request.QueryString[0].ToString();

    //        DataUtility objDu = new DataUtility();
    //        SqlDataReader dr = objDu.GetDataReaderSP("GetCategory");
    //        while (dr.Read())
    //        {
    //            string category = dr["catname"].ToString().Replace(" ", "-");

    //            CategoryStr += "<li class='p-0 mb-3'>";
    //            if (category == DefaultCat)
    //            {
    //                //Img_Banner.Attributes.Add("src", "images/product/icon/" + dr["imagename"].ToString());
    //                CategoryStr += "<div class='service-block active'>";
    //            }
    //            else
    //            {
    //                CategoryStr += "<div class='service-block'>";
    //            }

    //            CategoryStr += "<div class=inner-box'>";
    //            CategoryStr += "<div class='icon'> <a href='products?" + category + "'><img src='images/product/icon/" + dr["IconImg"].ToString() + "' alt='' /></a></div>";
    //            CategoryStr += "<h5><a href='products?" + category + "'>" + category + "</a></h5>";

    //            CategoryStr += "</div>";
    //            CategoryStr += "</div>";
    //            CategoryStr += "</li>";

    //        }
    //        //div_category.InnerHtml = CategoryStr;
    //    }
    //    catch (Exception er) { }
    //}



    [WebMethod]
    public static Classes.ProdDetails[] BindProduct(string CatId, string SubCatId)
    {
        List<Classes.ProdDetails> details = new List<Classes.ProdDetails>();
        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@catid", CatId),
            new SqlParameter("@SubCatId", SubCatId),
        };
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReaderSP(param, "GetRootProd");
        while (dr.Read())
        {
            Classes.ProdDetails data = new Classes.ProdDetails();
            data.Qury_product = dr["pname"].ToString().Replace(" ", "-");
            data.pname = dr["pname"].ToString();
            data.batchid = dr["batchid"].ToString();
            data.PackSizeName = dr["PackSizeName"].ToString();
            data.Pcode = dr["Pcode"].ToString();

            data.ImageName = dr["ImageName"].ToString();
            data.MRP = dr["MRP"].ToString();
            data.Descri = dr["Descri"].ToString();
            data.MaxQty = dr["MaxQty"].ToString();
            details.Add(data);
        }
        return details.ToArray();
    }
}