using System; 
using System.Data.SqlClient;
using System.Text;
public partial class _Default : System.Web.UI.Page
{
    public static string banner1 = "";
    public static string banner2 = "";
    public static string brand = "";
    string banner_top = "";
    //public static string banner4 = "";
    //public static string banner5 = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSlider();
            BindTestimonials();
            Bind_DAILYDEAL_Product();
            Bind_NewArrival_Product();
            BindOfferName();
            BindBrand();
        }

    }
    public void BindBrand()
    {
        try
        {
            //  string brand = "";
            brand = "";
            
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReader("Select Img from tbl_brand where IsActive=1 order by PriorityNo");
            while (dr.Read())
            {
                int count = dr.FieldCount;
                for (int i = 0; i < count; i++)
                {
                    brand += "<div class='col-3'><img src = 'images/brand_logo/"+ dr["Img"].ToString() +"' width='100%'></div>";
                }                       
            }
            div_brandlogo.InnerHtml = brand;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
            public void BindSlider()
    {
        try
        {
            int flag = 0;
            StringBuilder sb = new StringBuilder();
            StringBuilder sbcount = new StringBuilder();
            StringBuilder sliderFooter = new StringBuilder();
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP("GetSliderImg");
            while (dr.Read())
            {
                if (dr["IsMain"].ToString() == "1")
                {
                    string url = dr["slider"].ToString();
                    if (string.IsNullOrEmpty(url))
                        url = "javascrip:void(0)";
                     
                    if (flag == 0)
                    {
                        sb.Append("<div class='item active'><a href='" + url + "'>" + dr["img"].ToString() + "</a> </div> ");
                        sbcount.Append("<li data-target='#myCarousel' data-slide-to='" + flag + "' class='active'></li>");
                    }
                    else
                    {
                        sb.Append("<div class='item'><a href='" + url + "'>" + dr["img"].ToString() + "</a> </div> ");
                        sbcount.Append("<li data-target='#myCarousel' data-slide-to='" + flag + "'></li>");
                    }
                    flag = flag + 1;
                }
                if (dr["IsMain"].ToString() == "2")
                {
                    sliderFooter.Append("<div class='slide-item'>" + dr["img"].ToString() + "</div>");
                }
                if (dr["IsMain"].ToString() == "3")
                {
                    banner1 = "style='background: url(../images/SliderImage/" + dr["url"].ToString() + ");'";
                    // sb.Append("<div class='deal-pro bg-image-18' style='background: url(../images/SliderImage/"+ dr["url"].ToString()+");'>");
                }
                if (dr["IsMain"].ToString() == "4")
                {
                    banner2 = "style='background: url(../images/SliderImage/" + dr["url"].ToString() + "); background-attachment: fixed; background-size: cover; background-position: center center; '>";
                    // sb.Append("<div class='deal-pro bg-image-18' style='background: url(../images/SliderImage/"+ dr["url"].ToString()+");'>");
                }
                if (dr["IsMain"].ToString() == "5")
                { //
                    banner_top += "<div class='col-lg-4 col-md-4 mb-sm-30'> <div class='single-banner zoom'><a href='" + dr["slider"].ToString() + "'><img src='../images/SliderImage/" + dr["url"].ToString() + "'></a></div> </div> ";
                    // sb.Append("<div class='deal-pro bg-image-18' style='background: url(../images/SliderImage/"+ dr["url"].ToString()+");'>");
                }
                if (dr["IsMain"].ToString() == "6")
                {
                    banner_top += " <div class='col-lg-4 col-md-4 mb-sm-30'> <div class='single-banner zoom'><a href='" + dr["slider"].ToString() + "'><img src='../images/SliderImage/" + dr["url"].ToString() + "'></a></div> </div>  ";
                    // sb.Append("<div class='deal-pro bg-image-18' style='background: url(../images/SliderImage/"+ dr["url"].ToString()+");'>");
                }
                if (dr["IsMain"].ToString() == "7")
                {
                    banner_top += "<div class='col-lg-4 col-md-4 mb-sm-30'> <div class='single-banner zoom'><a href='" + dr["slider"].ToString() + "'><img src='../images/SliderImage/" + dr["url"].ToString() + "'></a></div> </div>";
                    // sb.Append("<div class='deal-pro bg-image-18' style='background: url(../images/SliderImage/"+ dr["url"].ToString()+");'>");
                }
            }

            div_Sliderfooter.InnerHtml = sliderFooter.ToString();
            DivSlider.InnerHtml = sb.ToString();
            div_Slidercount.InnerHtml = sbcount.ToString();
            div_banner_top.InnerHtml = banner_top;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void Bind_DAILYDEAL_Product()
    {
        String tbl = "";
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReaderSP("GetDailyDealsProd");
        while (dr.Read())
        {
            string product = dr["pname"].ToString().Replace(" ", "-");

            tbl += "<div class='single-makal-product'>";
            tbl += "<div class='pro-img'>";
            tbl += "<a href='p?" + product + "'> <img src='Productimage/" + dr["ImageName"].ToString() + "' alt='product-img'>  </a>";
            tbl += "<span class='sticker-new'>new</span>";
            // <span class="sticker-sale">-5%</span>
            tbl += " <div class='quick-view-pro'> <a data-bs-toggle='modal' data-bs-target='#product-window' class='quick-view' href='#'></a> </div>";
            tbl += "</div>";
            tbl += "<div class='pro-content'>";
            tbl += "<h4 class='pro-title'><a href='p?" + product + "'>" + dr["pname"].ToString() + "</a> </h4>";
            tbl += "<span class='product-item_code text-white'>Item Code: " + dr["Pcode"].ToString() + "</span><span class='product-qty text-white'>" + dr["PackSizeName"].ToString() + " </span>";
            tbl += "<div class='pro-actions'>";
            tbl += "<div class='actions-secondary'><span class='price'>MRP. " + dr["MRP"].ToString() + "</span> </div>";
            if (dr["MaxQty"].ToString() == "0")
                tbl += "<div class='actions-primary'><a href='javascript:void(0)' class='button disabled' data-toggle='tooltip' data-original-title='Out of Stock'>Out of Stock</a> </div>";
            else
                tbl += "<div class='actions-primary'><a href='javascript:void(0)' onclick='AddToCart(" + dr["batchid"].ToString() + ")' class='add-to-cart' data-toggle='tooltip' data-original-title='Add to Cart'>Add To Cart</a> </div>";

            tbl += "</div>";
            tbl += "</div>";
            tbl += "</div>";

        }
        div_DailyDeals_Product.InnerHtml = tbl;
    }



    private void Bind_NewArrival_Product()
    {
        String tbl = "";
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReaderSP("GetNewArrivalProd");
        while (dr.Read())
        {
            string product = dr["pname"].ToString().Replace(" ", "-");
            tbl += "<div class='single-makal-product'>";
            tbl += "<div class='pro-img'>";
            tbl += "<a href='p?" + product + "'> <img src='Productimage/" + dr["ImageName"].ToString() + "' alt='product-img'> </a>";
            tbl += "<span class='sticker-new'>new</span>";
            //tbl += "<span class='sticker-sale'>-5%</span>";
            tbl += " <div class='quick-view-pro'> <a data-bs-toggle='modal' data-bs-target='#product-window' class='quick-view' href='#'></a> </div>";
            tbl += "</div>";
            tbl += "<div class='pro-content'>";
            tbl += "<h4 class='pro-title'><a href='p?" + product + "'>" + dr["pname"].ToString() + "</a> </h4>";
            tbl += "<span class='product-item_code'>Item Code: " + dr["Pcode"].ToString() + "</span><span class='product-qty'>" + dr["PackSizeName"].ToString() + " </span>";
            tbl += "<div class='pro-actions'>";
            tbl += " <div class='actions-secondary'><span class='price'>MRP. " + dr["MRP"].ToString() + "</span> </div>";

            if (dr["MaxQty"].ToString() == "0")
                tbl += "<div class='actions-primary'><a href='javascript:void(0)' class='button disabled' data-toggle='tooltip' data-original-title='Out of Stock'>Out of Stock</a> </div>";
            else
                tbl += "<div class='actions-primary'><a href='javascript:void(0)' onclick='AddToCart(" + dr["batchid"].ToString() + ")' class='add-to-cart' data-toggle='tooltip' data-original-title='Add to Cart'>Add To Cart</a> </div>";

            tbl += "</div>";
            tbl += "</div>";
            tbl += "</div>";
        }
        div_NewArrivals_Product.InnerHtml = tbl;
    }


    private void BindOfferName()
    {
        DataUtility objDUT = new DataUtility();
        SqlDataReader dr = objDUT.GetDataReader(@"Select offer_title from PaymentMst");
        while (dr.Read())
        {
            div_OfferName.InnerHtml = "<h2>" + dr["offer_title"].ToString() + "</h2>";
        }
    }


    private void BindTestimonials()
    {
        string TestimDots = "<ul id='testim-dots' class='dots'>", TestimContent = "<div id='testim-content' class='cont'>";
        int count = 0;
        DataUtility objDUT = new DataUtility();
        SqlDataReader dr = objDUT.GetDataReader(@"Select URL, Name, [Desc] from Testimonialmst where Status=1");
        while (dr.Read())
        {
            if (count == 0)
            {
                count = 1;
                TestimDots += "<li class='dot active'></li>";
                TestimContent += "<div class='active'>";
                TestimContent += "<div class='img'>  <img src='../Testimonial/" + dr["URL"].ToString() + "' alt=''> </div>";
                TestimContent += "<h2>" + dr["Name"].ToString() + "</h2>";
                TestimContent += "<p>" + dr["Desc"].ToString() + "</p>";
                TestimContent += "</div>";
            }
            else
            {
                TestimDots += "<li class='dot'></li>";
                TestimContent += "<div>";
                TestimContent += "<div class='img'>  <img src='../Testimonial/" + dr["URL"].ToString() + "' alt=''> </div>";
                TestimContent += "<h2>" + dr["Name"].ToString() + "</h2>";
                TestimContent += "<p>" + dr["Desc"].ToString() + "</p>";
                TestimContent += "</div>";
            }
        }

        TestimDots += "</ul>";
        TestimContent += "</div>";
        div_testimonials.InnerHtml = TestimDots + TestimContent;
    }
}