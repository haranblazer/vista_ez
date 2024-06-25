<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="product-details.aspx.cs" Inherits="delivery_policy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="css/product_style.css?v=0.1" rel="stylesheet" />
    <%--<div class="testmonial header_cat ptb-90">
        <div class="container">
            <div class="text-center">
                <h2>Shipping & Delivery Policy</h2>
                <div class="bread-crumb">
                    <span>
                        <a href="default.aspx">Home</a></span><i class="fa fa-angle-right"></i><span><a href="javascript:void(0)">Shipping & Delivery Policy</a>
                    </span>
                </div>
            </div>
        </div>
    </div>--%>
    <div class="container-fluid">
        <div class="row border-bottom">
            <div class="col-md-6 p-0">
                <div class="watchBackground">
                    <div id="Wishlist">
                        <a href="javascript:void(0)" onclick="if (!window.__cfRLUnblockHandlers) return false; AddToWishList(2);" class="wishlet"><i class="fa fa-heart"></i></a>
                    </div>
                    <img class="product" style="display: none;">
                    <div id='carousel-custom' class='carousel slide' data-ride='true'>
                        <div class='carousel-outer'>
                            <!-- me art lab slider -->
                            <div class='carousel-inner'>
                                <div class='item active'>
                                    <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' />
                                </div>
                                <div class='item'>
                                    <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' />
                                </div>
                                <div class='item'>
                                    <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' />
                                </div>
                                <div class='item'>
                                    <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' />
                                </div>
                                <div class='item'>
                                    <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' />
                                </div>
                                <div class='item'>
                                    <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' />
                                </div>
                                <div class='item'>
                                    <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' />
                                </div>
                            </div>
                            <!-- sag sol -->
                            <a class='left carousel-control' href='#carousel-custom' data-slide='prev'>
                                <span class='bi bi-chevron-left'></span>
                            </a>
                            <a class='right carousel-control' href='#carousel-custom' data-slide='next'>
                                <span class='bi bi-chevron-right'></span>
                            </a>
                        </div>
                        <!-- thumb -->
                        <ol class='carousel-indicators mCustomScrollbar meartlab'>
                            <li data-target='#carousel-custom' data-slide-to='0' class='active'>
                                <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' alt='' /></li>
                            <li data-target='#carousel-custom' data-slide-to='1'>
                                <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' alt='' />
                            </li>
                            <li data-target='#carousel-custom' data-slide-to='2'>
                                <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' alt='' /></li>
                            <li data-target='#carousel-custom' data-slide-to='3'>
                                <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' alt='' /></li>
                            <li data-target='#carousel-custom' data-slide-to='4'>
                                <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' alt='' /></li>
                            <li data-target='#carousel-custom' data-slide-to='5'>
                                <img src='https://triptales.co.in/Productimage/bdee8b31-bef6-4672-a1e1-0aae257e8b47.jpg' alt='' />
                            </li>
                            <li>
                                <img src='images/video.jpg' alt='' data-toggle="modal" data-target="#exampleModal" />
                            </li>
                        </ol>
                    </div>
                </div>
            </div>
            <div class="col-md-6 p-0">
                <div class="info">
                    <div class="watchName">
                        <h2 class="product_header_text">the azure</h2>
                        <div>
                            <h1 class="big">Swiss Beauty Ultra Blush</h1>
                            <span class="new"><span id="ctl00_ContentPlaceHolder1_div_PackSize">6Caps</span></span>
                        </div>
                        <h2 class="small">Ultra beauty for every skin</h2>
                        <div>
                            <div class="clearfix"></div>
                            Item Code : <span class="new"><span id="ctl00_ContentPlaceHolder1_lbl_ItemCode">978867</span></span>
                        </div>
                    </div>
                    <%--<div class="description">
                            <p class="text">
                                <span id="ctl00_ContentPlaceHolder1_lbl_Desc_Eng"></span>
                            </p>
                        </div>--%>
                    <div class="buy-price">
                        <div class="price">
                            <%--<h2><s>MRP: 400</s></h2>--%>
                            <h1>Rs. 300
                                <br />
                                <small>*inclusive of taxes</small>
                            </h1>
                        </div>
                    </div>
                    <div class="benefits__list">
                        <li class="benefits__item">
                            <img width="70px" height="70px" class="benefits__icon" src="images/pd_1.gif">
                            <p class="benefits__text">Firming</p>
                        </li>
                        <li class="benefits__item">
                            <img width="70px" height="70px" class="benefits__icon" src="images/pd_2.gif">
                            <p class="benefits__text">Protection</p>
                        </li>
                        <li class="benefits__item">
                            <img width="70px" height="70px" class="benefits__icon" src="images/pd_3.gif">
                            <p class="benefits__text">Better aging</p>
                        </li>
                        <li class="benefits__item">
                            <img width="70px" height="70px" class="benefits__icon" src="images/pd_4.gif">
                            <p class="benefits__text">Acne Healing</p>
                        </li>
                    </div>
                    <br>
                    <div class="productDescription not-in-quickbuy">
                        <div class="product-description rte cf">
                            <p><span>Copper Peptide Serum <strong>t</strong></span><strong><span>argets multiple signs of ageing skin, smooths rough texture, evens skin tone, refines enlarged pores</span></strong><span>, and delivers healthy, youthful skin.&nbsp;</span></p>
                            <p>The high-performing synergy of Copper peptides&nbsp;(boosts collagen production -this is a big deal, &amp; very few ingredients help in doing this), Diglucosyl Gallic Acid&nbsp;(for powerhouse brightening action), Hyaluronic acid with Silanol technology&nbsp;(repairs &amp; plumps the skin with moisture), 17 Amino-acids&nbsp;(a key to enhance skin's barrier function)&nbsp;<strong>forms a foundation for long-lasting skin health</strong>.</p>
                        </div>
                    </div>
                    <div class="text-center">
                        <label class="mfklab">
                            <input type="radio" name="id" value="40031513083969" checked="checked" data-stock="" data-price="145000">
                            100 ML
                        </label>
                    </div>
                    <a href="#" class="btn add_to_cart btn-block">Add to Cart</a>
                    <div class="nm product-detail-accordion mt-10">
                        <div class="cc-accordion cc-initialized" data-allow-multi-open="true">
                            <details class="cc-accordion-item">
                                <summary class="cc-accordion-item__title">Product Details</summary>
                                <div class="cc-accordion-item__panel">
                                    <div class="cc-accordion-item__content rte cf">
                                        <p></p>
                                        <p>Good for - addressing visible aspects of skin aging, firming, pore refining, healing, repair and to maintain healthy-looking skin</p>
                                        <p>Skin Type - Dry, Normal, Combination, Oily also for mature, tired, acne-prone, photo-damaged, wounded or inflamed skin.&nbsp;</p>
                                        <p>Skin Goals<strong> </strong>- Energizing, Protection, Better &amp; Well-aging, Skin Healing, Firming, Pore Refining</p>
                                        <p>Texture &amp; Smell<strong> </strong>- Feather-light cobalt blue, oil-free, plant water-based serum with a mild floral note of botanical herbs. Fragrance Free</p>
                                        <p></p>
                                    </div>
                                </div>
                            </details>
                        </div>
                    </div>
                    <div class="nm product-detail-accordion not-in-quickbuy">
                        <div class="cc-accordion cc-initialized" data-allow-multi-open="true">
                            <details class="cc-accordion-item">
                                <summary class="cc-accordion-item__title">Ingredients &amp; Facts</summary>
                                <div class="cc-accordion-item__panel">
                                    <div class="cc-accordion-item__content rte cf">
                                        
                                        <p><b>Full of List </b>- The Most Advanced Peptide Complex, Methyl-Glucoside-6-Phosphate, Copper Tripeptides, Antioxidant Gallic Acid,  17 Amino Acids, Probiotic Yeast, Silanetrol delivered Hyaluronic Acid, Biotechnology-derived Guava leaves from Jeju Island</p>

                                        <p><b>Free of List</b> - parabens, essential oils, artificial fragrances, silicones, micro-plastics, and 1,350+ ingredients that have questionable data.</p>

                                        <p><b>Vegan &amp; Cruelty-free | Dermatologically Tested for Safety &amp; Irritation | Medicert | MADE SAFE Certified | Zero Plastic Inside&nbsp;</b></p>

                                        <p><i>For External Use Only. Always do a patch test before use. Use only as directed on unbroken skin.</i></p>
                                       
                                    </div>
                                </div>
                            </details>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row align-items-center border-bottom d-none">
            <div class="col-md-5">
                <div class="how-it-works-flex ">
                    <iframe frameborder="0" allowfullscreen="1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" width="640" height="360" src="https://www.youtube.com/embed/4W2q3oFNGMs?iv_load_policy=3&amp;modestbranding=1&amp;autoplay=0&amp;loop=1&amp;playlist=4W2q3oFNGMs&amp;rel=0&amp;showinfo=0&amp;enablejsapi=1&amp;origin=https%3A%2F%2Fwww.aminu.life&amp;widgetid=1" data-gtm-yt-inspected-6="true"></iframe>
                </div>
            </div>
            <div class="col-md-7 border-left">
                <div class="how-it-works-heading">
                    <h2>WHY & HOW IT WORKS</h2>
                    <div class="panel">
                        <div class="how-it-works-content">
                            <p class="mob-hidden stars">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </p>
                            <p>
                                While aging is inevitable and irreversible, thanks to science and advances in skin care technologies, we have miraculous copper peptides that reduce its evident signs and effects! Copper is also revered in Ayurvedic principles for its healing ability and it is well known for its fabulous anti-bacterial, anti-viral, and anti-fungicidal effects.
                                <br>
                                Copper peptides utilize the skin's biochemical systems that remove the old, hard cells and damaged proteins and replace them with new skin and new proteins. Copper-peptides also improve the skin's anti-oxidant defenses by activating superoxide dismutase (SOD), a protein which fights free radicals and that is the body's primary anti-oxidant defense. Normally SOD lacks enough copper to be active and copper-peptides, by supplying nutritional copper to SOD, increase the activity of SOD. Copper Peptide's work best on mature skin and show results within one to three months.
&nbsp;<br>
                                <br>
                                Copper peptides are also an amazing second step to the chemical peel process often used to improve aging skin and scarred skin. To aid the skin renewal process after a chemical peel, the use of skin regeneration accelerators, such as a copper tri-peptide helps to accelerate healing and regeneration. They help stimulate the skin's regenerative processes which repair the skin's protective outer barrier and the increase the water-holding proteoglycans and glycosaminoglycans (GAGs) which hold moisture in the skin and are the only "true" moisturization of skin.
                            </p>


                        </div>
                    </div>

                </div>
            </div>

        </div>

        <div class="row border-bottom">
            <div class="col-md-12">
                <ul class="marque-slider-pro item slick-initialized slick-slider">
                    <marquee scrollamount="15">
                        <p>
                            | vegan | cruelty free | solutions for every skin
| made with thoughtfulness & love |
clean | clinical | wholistic | high performing
| vegan | cruelty free | solutions for every skin
| made with thoughtfulness & love |
clean | clinical | wholistic | high performing
| vegan | cruelty free | solutions for every skin
| made with thoughtfulness & love |
                        </p>
                    </marquee>
                </ul>
            </div>
        </div>
        <div class="row border-bottom d-none">
            <div class="col-md-12">
                <div class="product-benefits">
                    <div class="product-benefits-inner">
                        <div class="product-benefits-image relative">
                            <img src="//www.aminu.life/cdn/shop/files/Middle_Pannel_548x752.png?v=1687720735">
                            <div class="absolute image-1">
                                <img src="//www.aminu.life/cdn/shop/files/Left-Pannel_9_287x280.png?v=1658916807">
                            </div>
                            <div class="absolute image-2">
                                <img src="//www.aminu.life/cdn/shop/files/Right-Pannel_9_287x280.png?v=1658916806">
                            </div>
                            <div class="absolute text-border text-3" style="background: #f7e8d8">
                                <p>
                                    <b>Advanced Technology + Powerful Nature + Unique Skin Biology</b>
                                    <br>
                                    The time-tested multi-pathway ingredients with the symphony of amino acids - promote natural skin surface turnover, target all signs of skin aging - even before it actually ages, revealing a radiant glow at every age.
                                </p>
                                <p></p>
                                <p></p>
                            </div>
                            <div class="absolute text-border text-4" style="background: #fce8e6">
                                <p>
                                    <b>Copper Peptides + Antioxidant Gallic Acid + Silanols + Hyaluronic Acid</b><br>
                                    Reduces the overall appearance of lines, acne scars by boosting collagen production!
                                </p>
                            </div>
                            <div class="absolute text-border text-5" style="background: #fcfff5">
                                <p>
                                    <b>To healthy skin!</b><br>
                                    The Copper Peptide Serum forms a foundation for long-lasting skin health by supporting a wide range of functions such as building &amp; enhancing skin barrier function, refining pores, elasticity &amp; skin’s integrity.
                                </p>
                                <p></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container d-none">
        <div class="row">
            <div class="col-md-12">
                <div class="panel ptb-40">
                    <div class="subtitle align-center">
                        <h2>KEY TECHNOLOGIES</h2>
                        <p>We believe in the power of nature + advancements of science. We believe the best and safest formulas are made by tapping into both worlds</p>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <img src="//www.aminu.life/cdn/shop/files/1-Copper-peptide-Key-Technology_565x565.jpg" style="border-radius: 20px; width: 100%;">
                            <div class="mlt_tp">
                                <h3 class="text-column__title  align-center ">Aminoacid Mineral Sugar Complex</h3>
                                <div class="text-column__text rte">
                                    <p><span class="metafield-multi_line_text_field">Created by a leading edge patented green chemistry process. It contains a safe and pre-activated source of energy: MG6P (Methyl-Glucoside-6-Phosphate) to feed aging cells.  It is a pure source of bio-energy which can naturally diffuse into skin, re-energizing senescent fibroblasts and triggering essential elements to produce collagen and elastin.</span></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <img src="//www.aminu.life/cdn/shop/files/2-Copper-peptide-Key-Technology_565x565.jpg" style="border-radius: 20px; width: 100%;">
                            <div class="mlt_tp">
                                <h3 class="text-column__title  align-center ">Multi-Pathway Brightening Technology</h3>
                                <div class="text-column__text rte">
                                    <p><span class="metafield-multi_line_text_field">Activated by the skin's microbiome (the massive amount of microorganisms living in symbiosis with the skin) the alpha-glucoside derivative, derived through biotechnology, is sixty times more potent than kojic acid in visibly brightening skin tone.</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row border-top">
            <div class="col-md-12">
                <div class="panel ptb-40">
                    <div class="subtitle align-center">
                        <h2>KEY INGREDIENTS</h2>
                        <p>Our products are formulated with the highest-quality botanical, earth & marine ingredients, combined with innovative scientific alternatives and technologies.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="border-top">
            <div class="ingredients_blocks row">
                <div class="col-md-4 bx_shd">
                    <div class="key_in">
                        <div class="key_txt">
                            <div class="key_cntnt">
                                <p><strong>Copper Tripeptide</strong></p>
                                <p>A naturally occurring peptide with amino acids and an adjoining copper to renew the     skin’s health and to heal the visible signs of aging.</p>
                            </div>
                        </div>
                        <div class="key_img">
                            <img src="images/copper.png">
                        </div>
                    </div>
                </div>
                <div class="col-md-4 bx_shd">
                    <div class="key_in">
                        <div class="key_txt">
                            <div class="key_cntnt">
                                <p><strong>Yeast + Amino Acids</strong></p>
                                <p>They combat bad bacteria, respect skin’s sensitivity &amp; encourage a healthy microbiome for the good bacteria to thrive on. Amino-acids are building blocks of both peptides and proteins</p>
                            </div>
                        </div>
                        <div class="key_img">
                            <img src="images/yeast.png">
                        </div>
                    </div>
                </div>
                <div class="col-md-4 bx_shd">
                    <div class="key_in">
                        <div class="key_txt">
                            <div class="key_cntnt">
                                <p><strong>Silanol of Hyaluronic Acid</strong></p>
                                <p>Combines organic silicon with low molecular weight hyaluronic acid to provide excellent skin restructuring, firming and elasticity benefits.</p>
                            </div>
                        </div>
                        <div class="key_img">
                            <img src="images/hyaluronic_acid.png">
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
     <div class="container-fluid">
         <img src="images/detail_page_banner.jpg" width="100%" />
     </div>

    <div class="border-top use-alt-bg ptb-40 use-alt-bg">
        <div class="container">
            <div class="subtitle align-center pb-40">
                <h2>DELIVERING SAFE &amp; EFFECTIVE RESULTS</h2>
            </div>
            <div class="row align-center">
                <div class="col-md-2 text-center">
                    <img width="120px" height="120px" src="images/vegan.png">
                    <h3 class="text-column__title">VEGAN</h3>
                    <div class="text-column__text rte">
                        <p>This product contain no animal ingredients or animal byproduct like honey, beeswax, milk, or eggs.</p>
                    </div>
                </div>
                <div class="col-md-2 text-center">
                    <img width="120px" height="120px" src="images/dermatologically_tested.png">
                    <h3 class="text-column__title">DERMATOLOGICALLY TESTED</h3>
                    <div class="text-column__text rte">
                        <p>This product is tested for its safety and is proven non-irritant.</p>
                    </div>
                </div>
                <div class="col-md-2 text-center">
                    <img width="120px" height="120px" src="images/australian_certified.png">
                    <h3 class="text-column__title">AUSTRALIAN CERTIFIED MADE SAFE</h3>
                    <div class="text-column__text rte">
                        <p>It represents safer, cleaner practices than any government standard.</p>
                    </div>
                </div>
                <div class="col-md-2 text-center">
                    <img width="120px" height="120px" src="images/animal_test_free.png">
                    <h3 class="text-column__title ">ANIMAL TEST FREE - BY PETA</h3>
                    <div class="text-column__text rte">
                        <p>We do not conduct, commission, any tests on animals for our products anywhere in the world.</p>
                    </div>
                </div>
                <div class="col-md-2 text-center">
                    <img width="120px" height="120px" src="images/zero_plastic_inside.png">
                    <h3 class="text-column__title ">ZERO PLASTIC INSIDE, NETHERLANDS</h3>
                    <div class="text-column__text rte">
                        <p>We are a signatory to Plastic Soup Foundation. Our products doesn't contain micro plastics or micro-beads.</p>
                    </div>
                </div>
                <div class="col-md-2 text-center">
                    <img width="120px" height="120px" src="images/medicert.png">
                    <h3 class="text-column__title ">MEDICERT AWARDED</h3>
                    <div class="text-column__text rte">
                        <p>It represents the expertise of specialists to test their product formulations for their intended use &amp; marketing claims.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid d-none">
        <div class="row border-top">
            <div class="popup-wrapper">
                <div class="popup-container">
                    <a class="popup-trigger button" href="#quote_modal">All Ingredients</a>
                    <a class="popup-trigger button" href="#quote_modal">More&nbsp;information</a>
                </div>
                <!--Quote Popup Window like Modal-->
                <div id="quote_modal" class="QuoteModal">
                    <div class="popup_modal">
                        <div>
                            <a href="#close" title="Close" class="quoteclose">X</a>
                        </div>
                        <div>
                            <p>Rose Hydrosol, Glycerine, Silanetriol (organic silanol), Hyaluronic Acid, Diglucosyl Gallic Acid (biotech melanoregulator), Methylpropanediol (humectant), Methylglucoside Phosphate, Copper Lysinate/Prolinate (amino acid-mineral complex), Caprylyl Glycol (humectant), Propanediol (humectant), Psidium Guajava Leaf Extract, Lysine, Histidine, Arginine, Aspartic acid, Threonine, Serine, Glutamic acid, Proline, Glycine, Alanine, Valine, Methionine, Isoleucine, Leucine, Tyrosine, Phenylalanine, Cysteine (amino-acid complex), Sodium Benzoate, Potassium Sorbate (food grade preservative), Saccharomyces Lysate Extract, Hydroxypropyl Starch Phosphate (maize starch), Xanthan Gum, Phenylpropanol, Copper Tripeptide-1 At Aminu, we constantly strive for transparency & being at the forefront of innovation. We are dedicated to maintaining the accuracy of the ingredient lists on this website and on other third-party websites. However, because ingredients and regulatory guidelines are subject to change, for an accurate listing of ingredients, please refer to your product packaging. We will always keep evolving and improving!</p>
                        </div>
                        <div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid d-none">
        <div class="row border-top">
            <div class="serums" style="background: #ffffff;">
                <div class="sr_flx">
                    <div class="lft_cntnt">
                        <div class="txt_bx">
                            <h2>DIRECTIONS OF USE</h2>
                            <p></p>
                            <p>HOW : Apply 2-3 drops evenly on clean almost-dry skin, with your fingertips. Let it sink in for one minute before your next skincare move. Use SPF in daytime always.&nbsp;</p>
                            <p>WHERE: Entire face.&nbsp;</p>
                            <p>WHEN: AM &amp; PM, after cleansing but before moisturizing.</p>
                            <p></p>
                        </div>
                    </div>
                    <div class="ryt_cntnt" style="background: #fff8ed;">
                        <div class="uses_blck">

                            <div class="innr_cntnt">

                                <img src="//www.aminu.life/cdn/shop/files/Slow_down-01_200x200.png?v=1687720589">

                                <div class="cntnt">
                                    <p>Start Slow - If your skin is very sensitive or already irritated, start with a very light amount of Copper Peptide Serum every other day for a week. This will allow your skin to re-build its natural skin barrier. Then after the initial week, use more frequently.</p>
                                </div>
                            </div>

                            <div class="innr_cntnt">

                                <img src="//www.aminu.life/cdn/shop/files/One_min_be2da9b6-154a-4940-84b3-0aa93c8c0d20_200x200.png?v=1687720612">

                                <div class="cntnt">
                                    <p>Pro-Tip - When layering treatments, we suggest working from thinnest to thickest consistency. Waiting a minute or so between applying each treatment will also help to avoid pilling.</p>
                                </div>
                            </div>

                            <div class="innr_cntnt">

                                <img src="//www.aminu.life/cdn/shop/files/avoid-01-01_200x200.png?v=1687720611">

                                <div class="cntnt">
                                    <p>Mixing - We would recommend to avoid the use of products containing copper peptides in the same routine as strong antioxidants as well as direct acids/ L-ascorbic acid / Ethylated L-Ascorbic Acid.</p>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <product-sticky-form id="product-form-template--19769122226478__main-6839898439745" class="product-sticky-form product-form theme-init sticky" data-ajax-add-to-cart="true" data-product-id="6839898439745" data-enable-history-state="true">
        <form method="post" action="/cart/add" id="product-form-template--19769122226478__main-6839898439745" accept-charset="UTF-8" class="form product-purchase-form hs-event-static" enctype="multipart/form-data" data-product-id="6839898439745">
            <input type="hidden" name="form_type" value="product"><input type="hidden" name="utf8" value="✓">
            <div class="container">
                <div class="product-sticky-form__inner">
                    <div class="product-sticky-form__content-wrapper desktop-only">
                        <div class="product-sticky-form__image-wrapper">
                            <img class="product-sticky-form__image" sizes="75px" src="//www.aminu.life/cdn/shop/files/Catalogue_75x.png?v=1687714322" loading="lazy">
                        </div>

                        <div class="product-sticky-form__info">
                            <div class="product-sticky-form__bottom-info">
                                <span class="product-sticky-form__title">Copper Peptide Serum</span>
                                <span class="square-separator square-separator--subdued"></span>
                                <span class="product-sticky-form__price ">

                                    <div class="atc-price"><span class="atc-money">Rs. 1,840</span></div>

                                </span>

                            </div>
                        </div>
                    </div>
                    <div class="product-sticky-form__form">


                        <div class="product-sticky-form__payment-container">
                            <input type="hidden" name="id" value="40031513346113">
                            <button class="button button--large ProductForm__AddToCart sticky-add hs-event-static" type="submit" data-add-to-cart-text="Add to cart">Add to cart</button>



                        </div>
                    </div>
                </div>
            </div>
        </form>
    </product-sticky-form>
    <script>


        function isOnScreen(t) {
            if (0 != t.length) {
                var s = $(window);
                var e = s.scrollTop();
                var i = s.height();
                var r = e + i;
                var a = $(t);
                var n = a.offset().top;
                var o = a.height();
                var l = n + o;
                return n >= e && n < r || l > e && l <= r || o > i && n <= e && l >= r
            }
        }
        $(document).ready((function () {
            window.addEventListener("scroll", (function (t) {
                var s = $(".product-sticky-form");
                isOnScreen(jQuery(".quantity-submit-row__submit")) ? (s.hasClass("sticky") && s.removeClass("sticky")) : s.hasClass("sticky") || s.addClass("sticky")
            }
            ))
        }
        ))

    </script>

</asp:Content>

