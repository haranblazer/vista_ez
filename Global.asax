<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>
<script RunAt="server">
    void Application_Start(object sender, EventArgs e)
    {
        Application.Lock();
        RegisterRoutes(RouteTable.Routes);
        Application.UnLock();
    }

    static void RegisterRoutes(RouteCollection routes)
    {
        try
        {
            //   routes.MapPageRoute("", "", "~/.aspx");
            routes.MapPageRoute("", "default", "~/Default.aspx");
            routes.MapPageRoute("", "about-us", "~/about-us.aspx");
            routes.MapPageRoute("", "contact-us", "~/contact-us.aspx");
            routes.MapPageRoute("", "login", "~/login.aspx");
            routes.MapPageRoute("", "newjoin", "~/newjoin.aspx");

            routes.MapPageRoute("", "delivery_policy", "~/delivery_policy.aspx");
            routes.MapPageRoute("", "ForgotsPassword", "~/ForgotsPassword.aspx");
            routes.MapPageRoute("", "cancellation", "~/cancellation.aspx");




            routes.MapPageRoute("", "business-plan", "~/business-plan.aspx");

            routes.MapPageRoute("", "download", "~/download.aspx");
            routes.MapPageRoute("", "gallery", "~/gallery.aspx");

            routes.MapPageRoute("", "image_gallery", "~/image_gallery.aspx");

            routes.MapPageRoute("", "testimonial", "~/testimonial.aspx");
            routes.MapPageRoute("", "terms-and-condition", "~/terms-and-condition.aspx");

            routes.MapPageRoute("", "faq", "~/faq.aspx");

            routes.MapPageRoute("", "products", "~/product.aspx");
            routes.MapPageRoute("", "p", "~/productdesc.aspx");
            routes.MapPageRoute("", "cart", "~/cart.aspx");
            routes.MapPageRoute("", "wishlist", "~/wishlist.aspx");

            routes.MapPageRoute("", "CCAvenue_Request", "~/CCAvenue_Request.aspx");
            routes.MapPageRoute("", "CCAvenue_Response", "~/CCAvenue_Response.aspx");


             routes.MapPageRoute("", "phonepe_req", "~/phonepe_req.aspx");
             //routes.MapPageRoute("phonepe_resp", "phonepe_resp/{id}", "~/phonepe_resp.aspx");
             routes.MapPageRoute("phonepe_resp", "phonepe_resp", "~/phonepe_resp.aspx");


            // routes.MapPageRoute("", "{tutorId}", "~/error.aspx");
        }
        catch (Exception er)
        {
            //routes.MapPageRoute("", "{tutorId}", "~/error.aspx");
        }
    }


    //protected void Application_BeginRequest(Object sender, EventArgs e)
    //{
    //    if ((HttpContext.Current.Request.IsSecureConnection.Equals(false)) && HttpContext.Current.Request.IsLocal.Equals(false))
    //        Response.Redirect("https://www." + Request.ServerVariables["HTTP_HOST"].Replace("www.", "") + HttpContext.Current.Request.RawUrl);
    //}


</script>
