using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class user_newjoins : System.Web.UI.Page
{
    utility objUtil = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["n"] != null)
        {
            objUtil = new utility();
            lblname.Text = objUtil.base64Decode(Request.QueryString["n"].Trim());
            lblUserid.Text = objUtil.base64Decode(Request.QueryString["i"].Trim());
            lblMobileNo.Text = objUtil.base64Decode(Request.QueryString["mob"].Trim());
            lblSponsorId.Text = objUtil.base64Decode(Request.QueryString["sid"].Trim());
            LblEMailId.Text = objUtil.base64Decode(Request.QueryString["em"].Trim());
            //   string p = Request.QueryString["pass"].Trim();
            //p=   p.Replace(p.Substring(0, 4), "****");
            lblpassword.Text = objUtil.base64Decode(Request.QueryString["pass"].Trim());
            //sendSMS();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Response.Redirect("newjoin.aspx", false);
    }
    private void sendSMS()
    {
        objUtil = new utility();
        string text = "Dear " + lblname.Text.Trim() + " id:" + lblUserid.Text.Trim() + " Your password is " + lblpassword.Text;
        objUtil.sendSMSByPage(lblMobileNo.Text.Trim(), text);
    }
}
