using System; 

public partial class Timer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Label1.Text = "Time: " + DateTime.Now.ToString();
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        Label1.Text = "Time: " + DateTime.Now.ToString();
    }
}