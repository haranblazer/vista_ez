using System; 

public partial class Template_Retail_Booster : System.Web.UI.Page
{
    public static string BackGroundImg = "", Img = "", Rank = "", RankName = "", Month = "", UserName = "", State = "", Distinct = "";
        

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString.Count > 0)
        {
            BackGroundImg = Request.QueryString["BackGroundImg"].ToString();
            Img = Request.QueryString["Img"].ToString() == "noimage.png" ? "no-image.jpg" : Request.QueryString["Img"].ToString();
            Rank = "Retail Booster Loyalty worth Rs";
            RankName = Request.QueryString["RN"].ToString();
            Month = Request.QueryString["Month"].ToString();
            UserName = Request.QueryString["UN"].ToString();
            State = Request.QueryString["State"].ToString();
            Distinct = Request.QueryString["DIST"].ToString();
        }
    }
}