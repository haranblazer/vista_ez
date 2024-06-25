using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;
public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                if (Session["MemberId"] != null)
                {
                    hdn_Userid.Value = Session["MemberId"].ToString();
                    lbl_CustomerId.InnerHtml = Session["MemberId"].ToString();
                    link_Mst_CustomerId.Visible = true;
                    link_Mst_Login.Visible = false;
                    link_Mst_Userid.Visible = false;
                }

                if (Session["userId"] != null)
                {
                    hdn_Userid.Value = Session["userId"].ToString();
                    lbl_Userid.InnerHtml = Session["userId"].ToString();
                    link_Mst_Userid.Visible = true;
                    link_Mst_Login.Visible = false;
                    link_Mst_CustomerId.Visible = false;
                }
                //else
                //{
                //    link_Mst_Userid.Visible = false;
                //    link_Mst_Login.Visible = true;
                //}


                //else
                //{
                //    link_Mst_CustomerId.Visible = false;
                //    link_Mst_Login.Visible = true;
                //}





                BindMenu();
            }
        }
        catch (Exception er) { }
    }

    private string BindBrand()
    {
        string brand = "";
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReader("Select Img from tbl_Brand where IsActive=1 order by PriorityNo");
        brand += "<li><a href='#' class='drop-icon'>Our Brands</a><ul class='ht-dropdown megamenu megamenu-three p-1 row d-flex justify-content-center'>";
        while (dr.Read())
        {
            int count = dr.FieldCount;
            for (int i = 0; i < count; i++)
            {
                brand += "<div class='col-md-3 p-2'><img src='images/brand_logo/" + dr["Img"].ToString() + "' width='100%'></div>";
            }
            //brand += "";
        }
        brand += "</ul></a></li>";
        return brand;
        //"<li><a href='#' class='drop-icon'>Our Brands</a> <ul class='ht-dropdown megamenu megamenu-three p-1 row d-flex justify-content-center'> <div class='col-md-3 p-2'><img src='images/brand_logo/blossom_biapers.jpg' width='100%'></div> <div class='col-md-3 p-2'><img src='images/brand_logo/keep_moving.jpg' width='100%'></div><div class='col-md-3 p-2'><img src='images/brand_logo/kira_&_kira.jpg' width='100%'></div><div class='col-md-3 p-2'><img src='images/brand_logo/shine_bull.jpg' width='100%'></div><div class='col-md-3 p-2'><img src='images/brand_logo/sachveda.jpg' width='100%'></div><div class='col-md-3 p-2'><img src='images/brand_logo/kremlin.jpg' width='100%'></div></ul></a></li>";
    }

    private void BindMenu()
    {
        if (Session["RootMenu"] != null)
        {
            li_Menu.InnerHtml = Session["RootMenu"].ToString();
            li_Menu_Mobile.InnerHtml = Session["RootMenuMobile"].ToString();
        }
        else
        {
            string str_menu_start = "", str_menu_last = "", str_menu = "";
            string str_menu_start_mobile = "", str_menu_last_mobile = "", str_menu_mobile = "";

            str_menu += "<li><a href='#' class='drop-icon'>Shop</a>";
            str_menu += "<ul class='ht-dropdown'>";

            str_menu_start += "<li class='position-static'><a href='Default'>home</a></li>";


            // str_menu_start += "<li><a href='#' class='drop-icon'>Our Brands</a><ul class='ht-dropdown megamenu megamenu-three p-1 row d-flex justify-content-center'><div class='col-md-3 p-2'><img src='images/brand_logo/blossom_biapers.jpg' width='100%'></div><div class='col-md-3 p-2'><img src='images/brand_logo/keep_moving.jpg' width='100%'></div><div class='col-md-3 p-2'><img src='images/brand_logo/kira_&_kira.jpg' width='100%'></div><div class='col-md-3 p-2'><img src='images/brand_logo/shine_bull.jpg' width='100%'></div><div class='col-md-3 p-2'><img src='images/brand_logo/sachveda.jpg' width='100%'></div><div class='col-md-3 p-2'><img src='images/brand_logo/kremlin.jpg' width='100%'></div></ul></a></li>";


            str_menu_start += BindBrand();


            str_menu_start += "<li class='position-static'> <a href='about-us.aspx'>About us</a> </li>";



            str_menu_mobile += "<li> <a href='#'>Shop</a>";
            str_menu_mobile += "<ul class='submobile-mega-dropdown' style='display: none;'>";


            str_menu_start_mobile += "<li> <a href='Default'>home</a> </li>";
            str_menu_start_mobile += "<li>";
            str_menu_start_mobile += "<a href='javascript:void(0)'>Our Brands</a>";
            str_menu_start_mobile += "<ul class='submobile-mega-dropdown row'>";
            str_menu_start_mobile += "<div class='col-4 p-0'><img src='images/brand_logo/blossom_biapers.jpg' width='100%'></div><div class='col-4 p-0'><img src='images/brand_logo/keep_moving.jpg' width='100%'></div><div class='col-4 p-0'><img src='images/brand_logo/kira_&_kira.jpg' width='100%'></div><div class='col-4 p-0'><img src='images/brand_logo/shine_bull.jpg' width='100%'></div><div class='col-4 p-0'><img src='images/brand_logo/sachveda.jpg' width='100%'></div><div class='col-4 p-0'><img src='images/brand_logo/kremlin.jpg' width='100%'></div>";
            str_menu_start_mobile += "</ul>";
            str_menu_start_mobile += "</li>";
            str_menu_start_mobile += "<li> <a href='about-us.aspx'>About EZ</a>  </li>";


            DataUtility objDu = new DataUtility();
            DataSet ds = objDu.GetDataSetSP("GetCategory_MultiLable");
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    string category = dr["catname"].ToString().Replace(" ", "-");
                    string angle = "";
                    angle = "";
                    if (Convert.ToInt32(dr["Count_SubCat"].ToString()) > 0)
                        angle = "<i class='fa fa-angle-right'></i>";

                    str_menu += "<li class='menu-item'><a href='#'>" + category + angle + " </a>";
                    str_menu_mobile += "<li> <a href='#'>" + category + "</a>";
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        str_menu += "<ul class='drop-menu'>";
                        str_menu_mobile += "<ul style='display: none;'>";
                        foreach (DataRow dr1 in ds.Tables[1].Rows)
                        {
                            if (dr["catid"].ToString() == dr1["catid"].ToString())
                            {
                                string subcategory = dr1["SubCatName"].ToString().Replace(" ", "-");
                                str_menu += "<li><a href='products?c=" + dr1["catid"].ToString() + "&sc=" + dr1["SubCatId"].ToString() + "&title=" + subcategory + "'>" + subcategory + "</a></li>";
                                str_menu_mobile += "<li><a href='products?c=" + dr1["catid"].ToString() + "&sc=" + dr1["SubCatId"].ToString() + "&title=" + subcategory + "'>" + subcategory + "</a></li>";
                            }
                        }
                        str_menu += "</ul>";
                        str_menu_mobile += "</ul>";

                    }
                    str_menu += "</li>";
                    str_menu_mobile += "</li>";
                }
            }
            str_menu += "</ul>";
            str_menu += "</li>";

            str_menu_mobile += "</ul>";
            str_menu_mobile += "</li>";

            //str_menu_start += "<li><a href='#' class='drop-icon'>Skincare</a><ul class='ht-dropdown'><li class='menu-item'><a href='#'>Sunscream <i class='fa fa-angle-right'></i></a><ul class='drop-menu'><li><a href='#'>Sunscream</a></li><li><a href=''>Lotion</a></li><li><a href=''>Soaps</a></li></ul></li><li><a href=''>Lotion</a></li><li><a href=''>Soaps</a></li></ul></li>";

            /*
            if (Session["userId"] != null)
            {
                if (Session["userId"].ToString() != "")
                {
                    str_menu_last += "<li><a href='javascript:void(0)'><i class='fa fa-user'></i>" + Session["userId"].ToString() + "<i class='fa fa-angle-down'></i></a>";
                    str_menu_last += "<ul class='ht-dropdown'>";
                    str_menu_last += "<li><a href='user/Dashboard.aspx'>Dashboard</a></li>";
                    str_menu_last += "<li><a href='user/Logout.aspx'>Logout</a></li>";
                    str_menu_last += "</ul>";
                    str_menu_last += "</li>";

                    str_menu_last_mobile += "<li>";
                    str_menu_last_mobile += "<a href='javascript:void(0)'>" + Session["userId"].ToString() + "</a>";
                    str_menu_last_mobile += "<ul class='submobile-mega-dropdown'>";
                    str_menu_last_mobile += "<li> <a href='user/Dashboard.aspx'>Dashboard</a> </li>";
                    str_menu_last_mobile += "<li> <a href='user/Logout.aspx'>Logout</a> </li>";
                    str_menu_last_mobile += "</ul>";
                    str_menu_last_mobile += "</li>";
                }
            }
            else
            {
                //str_menu_last += "<li class='position-static'> <a href='login'>Login</a> </li>";
                //str_menu_last += "<li class='position-static'> <a href='newjoin'>Sign Up</a> </li>";

                //str_menu_last_mobile += "<li> <a href='login'>Login</a> </li>";
                //str_menu_last_mobile += "<li> <a href='newjoin'>Sign Up</a> </li>"; 
            }*/


            str_menu_last += "<li class='position-static'> <a href='VideoGallery.aspx'>Gallery</a> </li>";
            str_menu_last += "<li class='position-static'> <a href='contact-us.aspx'>Contact Us</a> </li>";

            str_menu_last_mobile += "<li> <a href='VideoGallery.aspx'>Gallery</a> </li>";
            str_menu_last_mobile += "<li> <a href='contact-us.aspx'>Contact Us</a> </li>";


            li_Menu.InnerHtml = str_menu_start + str_menu + str_menu_last;
            //li_Menu.InnerHtml = str_menu;
            Session["RootMenu"] = str_menu_start + str_menu + str_menu_last;

            li_Menu_Mobile.InnerHtml = str_menu_start_mobile + str_menu_mobile + str_menu_last_mobile;
            Session["RootMenuMobile"] = str_menu_start_mobile + str_menu_mobile + str_menu_last_mobile;


        }


    }


   

}