using System;
using System.Web.Services;

public partial class secretadmin_Template_Total_Income : System.Web.UI.Page
{
    public static string BackGroundImg = "", Typ = "", Img = "", Rank = "", RankName = "", Month = "", UserName = "", State = "", Distinct = "", Mobile="";
     
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString.Count > 0)
        {
            BackGroundImg = Request.QueryString["BackGroundImg"].ToString();
            Typ = Request.QueryString["Typ"].ToString();
            Img = Request.QueryString["Img"].ToString() == "noimage.png" ? "no-image.jpg" : Request.QueryString["Img"].ToString();
            Rank = "Total Payout"; //Request.QueryString["Rank"].ToString();
            RankName = common.RS_Formate(Request.QueryString["RN"].ToString());
            
            Month = Request.QueryString["Month"].ToString();
            UserName = Request.QueryString["UN"].ToString();
            State = Request.QueryString["State"].ToString();
            Distinct = Request.QueryString["DIST"].ToString();
            Mobile = "";
        }
    }


    [WebMethod]
    public static string SendWhatsApp(string ImgName, string Mobile)
    {
        string result = "";
        try
        { 

        }
        catch (Exception er) { result = "Server error. Time out.!!"; }
        return result;
    }



}

