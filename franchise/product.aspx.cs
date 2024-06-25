using System; 
using System.Data.SqlClient; 

public partial class product : System.Web.UI.Page
{
    String DefaultCat = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindCategory();
            BindProduct();
        }
    }

    private void BindCategory()
    {
        string CategoryStr = "";
        try
        {
            if (Request.QueryString.Count == 0)
                DefaultCat = "Personalcare";
            else
                DefaultCat = Request.QueryString[0].ToString();

            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP("GetCategory");
            while (dr.Read())
            {
                string category = dr["catname"].ToString().Replace(" ", "-");

                CategoryStr += "<div class=col p-0 mb-3'>";
                if (category == DefaultCat)
                {
                    Img_Banner.Attributes.Add("src", "images/product/icon/" + dr["imagename"].ToString());
                    // CategoryStr += "<li class='nav-item'><a class='nav-link active' href='products?" + category + "'>";
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
                CategoryStr += "</div>";
                /*<div class="col p-0 mb-3">
                            <div class="service-block active">
                                <div class="inner-box">
                                    <div class="icon">
                                        <img src="images/icons/1.png" alt="" />
                                    </div>
                                    <h5><a href="#">Healthcare</a></h5>
                                </div>
                            </div>
                        </div>*/
                 

                //CategoryStr += "<img src='images/product/icon/" + dr["IconImg"].ToString() + "' style='width: 85px'/>";
               // CategoryStr += "</a><span>" + dr["catname"].ToString() + "</span> </li>";
            }
            div_category.InnerHtml = CategoryStr;
        }
        catch (Exception er) { }
    }



    private void BindProduct()
    {
        String ProductStr = "";
        if (Request.QueryString.Count== 0)
            DefaultCat = "Personalcare";
        else
            DefaultCat = Request.QueryString[0].ToString();

          DefaultCat = DefaultCat.Replace("-", " ");

        SqlParameter[] param = new SqlParameter[]
        {
             new SqlParameter("@catid", DefaultCat)
        };
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReaderSP(param, "GetRootProd");
        while (dr.Read())
        {
            string product = dr["pname"].ToString().Replace(" ", "-");
             
            ProductStr += "<div class='col-md-4'>";
            ProductStr += "<figure>";
            ProductStr += "<div class='image-container'>";
            ProductStr += "<div class='first'>";
            ProductStr += "<div class='d-flex justify-content-between align-items-center'>";
            //ProductStr += "<span class='discount'></span>"; --  this line is for Item code
            ProductStr += "<a  href='javascript:void(0)' onclick='AddToWishList(" + dr["batchid"].ToString() + ")' class='wishlist'><i class='fa fa-heart-o'></i></a>";
            ProductStr += " </div>";
            ProductStr += " </div>";
            ProductStr += "<a href='p?" + product + "'><img src='Productimage/" + dr["ImageName"].ToString() + "'/></a>";
            ProductStr += " </div>";
            ProductStr += "<a href='p?" + product + "'><figcaption> " + dr["pname"].ToString() +" </figcaption></a> ";
            ProductStr += "<span class='price'>MRP.:<i class='fa fa-inr'></i><b>" + dr["MRP"].ToString() + "/-</b></span>";
            ProductStr += "<p>" + dr["Descri"].ToString() + "</p>";
            if (dr["MaxQty"].ToString() == "0")
            {
                ProductStr += "<a class='button disabled' href='javascript:void(0)'>Out of Stock</a>";
            }
            else
            {
                ProductStr += "<a class='button' href='javascript:void(0)' onclick='AddToCart(" + dr["batchid"].ToString() + ")'>Add to Cart</a>";
            }
           // ProductStr += "<a class='button' href='#'>Add to Cart</a>";
            ProductStr += "</figure>";
            ProductStr += "</div>";
        }
        div_Product.InnerHtml = ProductStr;
    }
 

}