using System;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;

public partial class AddTemplateImg : System.Web.UI.Page
{
    Random Random = new Random();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindImg();
        }

    }


    protected void Btn_GenerationRank_Click(object sender, EventArgs e)
    {
        div_msg.InnerHtml = "";
        string ImgName = "crown.jpg";
        try
        {
            if (fu_GenerationRank.HasFile)
            {

                Stream stream = fu_GenerationRank.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 720 && height == 1280)
                {
                    Random Random = new Random();

                    ImgName = Random.Next().ToString() + "." + Path.GetExtension(fu_GenerationRank.FileName);

                    DataUtility objDu = new DataUtility();
                    objDu.ExecuteSql("update RankImg set ImgName='" + ImgName + "' where Caption='GenerationRank'");
                    fu_GenerationRank.PostedFile.SaveAs(Server.MapPath("images/" + ImgName));
                    div_msg.InnerHtml = "<div class='alert alert-success alert-dismissible'> <strong>Success!</strong> Your image uploaded successfully.</div>";
                    BindImg();

                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 720px and height 1280px.");
                    return;
                }
            }
            else
            {
                div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Select Generation Rank Image.!!</div>";
                return;
            }
        }
        catch (Exception ex)
        {
            div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> " + ex.Message + ".!!</div>";
            return;
        }
    }

    protected void Btn_TopperRank_Click(object sender, EventArgs e)
    {
        div_msg.InnerHtml = "";
        string ImgName = "crown.jpg";
        try
        {
            if (fu_TopperRank.HasFile)
            {
                Stream stream = fu_TopperRank.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 720 && height == 1280)
                {


                    ImgName = Random.Next().ToString() + "." + Path.GetExtension(fu_TopperRank.FileName);

                    DataUtility objDu = new DataUtility();
                    objDu.ExecuteSql("update RankImg set ImgName='" + ImgName + "' where Caption='TopperRank'");
                    fu_TopperRank.PostedFile.SaveAs(Server.MapPath("images/" + ImgName));
                    div_msg.InnerHtml = "<div class='alert alert-success alert-dismissible'> <strong>Success!</strong> Your image uploaded successfully.</div>";
                    BindImg();
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 720px and height 1280px.");
                    return;
                }
            }
            else
            {
                div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Select Topper Rank Image.!!</div>";
                return;
            }
        }
        catch (Exception ex)
        {
            div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> " + ex.Message + ".!!</div>";
            return;
        }
    }

    protected void Btn_DomesticTour_Click(object sender, EventArgs e)
    {
        div_msg.InnerHtml = "";
        string ImgName = "crown.jpg";
        try
        {
            if (fu_DomesticTour.HasFile)
            {
                Stream stream = fu_DomesticTour.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 720 && height == 1280)
                {

                    ImgName = Random.Next().ToString() + "." + Path.GetExtension(fu_DomesticTour.FileName);
                    DataUtility objDu = new DataUtility();
                    objDu.ExecuteSql("update RankImg set ImgName='" + ImgName + "' where Caption='DomesticTour'");
                    fu_DomesticTour.PostedFile.SaveAs(Server.MapPath("images/" + ImgName));
                    div_msg.InnerHtml = "<div class='alert alert-success alert-dismissible'> <strong>Success!</strong> Your image uploaded successfully.</div>";
                    BindImg();
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 720px and height 1280px.");
                    return;
                }
            }
            else
            {
                div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Select Domestic Tour Image.!!</div>";
                return;
            }
        }
        catch (Exception ex)
        {
            div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> " + ex.Message + ".!!</div>";
            return;
        }
    }

    protected void Btn_InternationalTour_Click(object sender, EventArgs e)
    {
        div_msg.InnerHtml = "";
        string ImgName = "crown.jpg";
        try
        {
            if (fu_InternationalTour.HasFile)
            {
                Stream stream = fu_InternationalTour.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 720 && height == 1280)
                {


                    ImgName = Random.Next().ToString() + "." + Path.GetExtension(fu_InternationalTour.FileName);

                    DataUtility objDu = new DataUtility();
                    objDu.ExecuteSql("update RankImg set ImgName='" + ImgName + "' where Caption='InternationalTour'");
                    fu_InternationalTour.PostedFile.SaveAs(Server.MapPath("images/" + ImgName));
                    div_msg.InnerHtml = "<div class='alert alert-success alert-dismissible'> <strong>Success!</strong> Your image uploaded successfully.</div>";
                    BindImg();
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 720px and height 1280px.");
                    return;
                }
            }
            else
            {
                div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Select International Tour Image.!!</div>";
                return;
            }
        }
        catch (Exception ex)
        {
            div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> " + ex.Message + ".!!</div>";
            return;
        }
    }

    protected void Btn_Loyalty_Click(object sender, EventArgs e)
    {
        div_msg.InnerHtml = "";
        string ImgName = "crown.jpg";
        try
        {
            if (fu_Loyalty.HasFile)
            {

                Stream stream = fu_Loyalty.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 720 && height == 1280)
                {


                    ImgName = Random.Next().ToString() + "." + Path.GetExtension(fu_Loyalty.FileName);

                    DataUtility objDu = new DataUtility();
                    objDu.ExecuteSql("update RankImg set ImgName='" + ImgName + "' where Caption='Loyalty'");
                    fu_Loyalty.PostedFile.SaveAs(Server.MapPath("images/" + ImgName));
                    div_msg.InnerHtml = "<div class='alert alert-success alert-dismissible'> <strong>Success!</strong> Your image uploaded successfully.</div>";
                    BindImg();
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 720px and height 1280px.");
                    return;
                }
            }
            else
            {
                div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Select Loyalty Image.!!</div>";
                return;
            }
        }
        catch (Exception ex)
        {
            div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> " + ex.Message + ".!!</div>";
            return;
        }
    }

    protected void Btn_RetailBooster_Click(object sender, EventArgs e)
    {
        div_msg.InnerHtml = "";
        string ImgName = "crown.jpg";
        try
        {
            if (fu_RetailBooster.HasFile)
            {
                Stream stream = fu_RetailBooster.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 720 && height == 1280)
                {


                    ImgName = Random.Next().ToString() + "." + Path.GetExtension(fu_RetailBooster.FileName);

                    DataUtility objDu = new DataUtility();
                    objDu.ExecuteSql("update RankImg set ImgName='" + ImgName + "' where Caption='RetailBoosterLoyalty'");
                    fu_RetailBooster.PostedFile.SaveAs(Server.MapPath("images/" + ImgName));
                    div_msg.InnerHtml = "<div class='alert alert-success alert-dismissible'> <strong>Success!</strong> Your image uploaded successfully.</div>";
                    BindImg();
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 720px and height 1280px.");
                    return;
                }
            }
            else
            {
                div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Select  Retail Booster Image.!!</div>";
                return;
            }
        }
        catch (Exception ex)
        {
            div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> " + ex.Message + ".!!</div>";
            return;
        }
    }

    protected void Btn_Staterfund_Click(object sender, EventArgs e)
    {
        div_msg.InnerHtml = "";
        string ImgName = "crown.jpg";
        try
        {
            if (fu_Staterfund.HasFile)
            {

                Stream stream = fu_Staterfund.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 720 && height == 1280)
                {


                    ImgName = Random.Next().ToString() + "." + Path.GetExtension(fu_Staterfund.FileName);

                    DataUtility objDu = new DataUtility();
                    objDu.ExecuteSql("update RankImg set ImgName='" + ImgName + "' where Caption='Staterfund'");
                    fu_Staterfund.PostedFile.SaveAs(Server.MapPath("images/" + ImgName));
                    div_msg.InnerHtml = "<div class='alert alert-success alert-dismissible'> <strong>Success!</strong> Your image uploaded successfully.</div>";
                    BindImg();

                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 720px and height 1280px.");
                    return;
                }
            }
            else
            {
                div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Select Stater Fund Image.!!</div>";
                return;
            }
        }
        catch (Exception ex)
        {
            div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> " + ex.Message + ".!!</div>";
            return;
        }
    }

    protected void Btn_TopEarnersclub_Click(object sender, EventArgs e)
    {
        div_msg.InnerHtml = "";
        string ImgName = "crown.jpg";
        try
        {
            if (fu_TopEarnersclub.HasFile)
            {
                Stream stream = fu_TopEarnersclub.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 720 && height == 1280)
                {
                    ImgName = Random.Next().ToString() + "." + Path.GetExtension(fu_TopEarnersclub.FileName);
                    DataUtility objDu = new DataUtility();
                    objDu.ExecuteSql("update RankImg set ImgName='" + ImgName + "' where Caption='TopEarnersclub'");
                    fu_TopEarnersclub.PostedFile.SaveAs(Server.MapPath("images/" + ImgName));
                    div_msg.InnerHtml = "<div class='alert alert-success alert-dismissible'> <strong>Success!</strong> Your image uploaded successfully.</div>";
                    BindImg();

                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 720px and height 1280px.");
                    return;
                }


            }
            else
            {
                div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Select Top Earners Club Image.!!</div>";
                return;
            }
        }
        catch (Exception ex)
        {
            div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> " + ex.Message + ".!!</div>";
            return;
        }
    }


    protected void Btn_QualifiedStar_Click(object sender, EventArgs e)
    {
        div_msg.InnerHtml = "";
        string ImgName = "crown.jpg";
        try
        {
            if (Fu_QualifiedStar.HasFile)
            {
                Stream stream = Fu_QualifiedStar.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 720 && height == 1280)
                {
                    ImgName = Random.Next().ToString() + "." + Path.GetExtension(Fu_QualifiedStar.FileName);
                    DataUtility objDu = new DataUtility();
                    objDu.ExecuteSql("update RankImg set ImgName='" + ImgName + "' where Caption='QualifiedStar'");
                    Fu_QualifiedStar.PostedFile.SaveAs(Server.MapPath("images/" + ImgName));
                    div_msg.InnerHtml = "<div class='alert alert-success alert-dismissible'> <strong>Success!</strong> Your image uploaded successfully.</div>";
                    BindImg();

                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 720px and height 1280px.");
                    return;
                }
            }
            else
            {
                div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> Please Select Qualified Star Image.!!</div>";
                return;
            }
        }
        catch (Exception ex)
        {
            div_msg.InnerHtml = "<div class='alert alert-danger alert-dismissible'> <strong>Error!</strong> " + ex.Message + ".!!</div>";
            return;
        }
    }


    private void BindImg()
    {
        DataUtility objDu = new DataUtility();
        SqlDataReader dr = objDu.GetDataReader("Select Caption, ImgName from RankImg");
        while (dr.Read())
        {
            if (dr["Caption"].ToString() == "GenerationRank")
                div_GenerationRankImg.InnerHtml = "<a href='images/" + dr["ImgName"].ToString() + "' data-fancybox='gallery'> <img src='images/" + dr["ImgName"].ToString() + "' width='60px' height='70px'> </a>";

            if (dr["Caption"].ToString() == "TopperRank")
                div_TopperImg.InnerHtml = "<a href='images/" + dr["ImgName"].ToString() + "' data-fancybox='gallery'> <img src='images/" + dr["ImgName"].ToString() + "' width='60px' height='70px'> </a>";

            if (dr["Caption"].ToString() == "DomesticTour")
                div_DomesticTour.InnerHtml = "<a href='images/" + dr["ImgName"].ToString() + "' data-fancybox='gallery'> <img src='images/" + dr["ImgName"].ToString() + "' width='60px' height='70px'> </a>";

            if (dr["Caption"].ToString() == "InternationalTour")
                div_InternationalTour.InnerHtml = "<a href='images/" + dr["ImgName"].ToString() + "' data-fancybox='gallery'> <img src='images/" + dr["ImgName"].ToString() + "' width='60px' height='70px'> </a>";

            if (dr["Caption"].ToString() == "Loyalty")
                div_Loyalty.InnerHtml = "<a href='images/" + dr["ImgName"].ToString() + "' data-fancybox='gallery'> <img src='images/" + dr["ImgName"].ToString() + "' width='60px' height='70px'> </a>";

            if (dr["Caption"].ToString() == "RetailBoosterLoyalty")
                div_RetailBooster.InnerHtml = "<a href='images/" + dr["ImgName"].ToString() + "' data-fancybox='gallery'> <img src='images/" + dr["ImgName"].ToString() + "' width='60px' height='70px'> </a>";

            if (dr["Caption"].ToString() == "Staterfund")
                div_Staterfund.InnerHtml = "<a href='images/" + dr["ImgName"].ToString() + "' data-fancybox='gallery'> <img src='images/" + dr["ImgName"].ToString() + "' width='60px' height='70px'> </a>";

            if (dr["Caption"].ToString() == "TopEarnersclub")
                div_TopEarnersclub.InnerHtml = "<a href='images/" + dr["ImgName"].ToString() + "' data-fancybox='gallery'> <img src='images/" + dr["ImgName"].ToString() + "' width='60px' height='70px'> </a>";

            if (dr["Caption"].ToString() == "QualifiedStar")
                div_QualifiedStar.InnerHtml = "<a href='images/" + dr["ImgName"].ToString() + "' data-fancybox='gallery'> <img src='images/" + dr["ImgName"].ToString() + "' width='60px' height='70px'> </a>";

        }

    }
}
