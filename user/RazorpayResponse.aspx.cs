 
using System; 
public partial class User_RazorpayCallBack : System.Web.UI.Page
{
    private string Msg = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.Count > 0)
        {

            Msg = Msg + "<br/> Order_id : " + Request.QueryString["oid"].ToString();
            Msg = Msg + "<br/> Reason : " + Request.QueryString["reason"].ToString();
            Msg = Msg + "<br/> Description : " + Request.QueryString["desc"].ToString();
            Msg = Msg + "<br/> Source : " + Request.QueryString["source"].ToString();
            Msg = Msg + "<br/> Code : " + Request.QueryString["code"].ToString();
            Msg = Msg + "<br/> Step : " + Request.QueryString["step"].ToString();
 
            h1Message.InnerHtml = Msg;

        }
        else
        {
            h1Message.InnerHtml = "Invalid Request. Please try agian.";
        }
    }

}