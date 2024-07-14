using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_payment_cancel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                if (Request.QueryString["tid"].ToString() != null)
                {
                    lblTranid.Text = Request.QueryString["tid"].ToString();
                    lbl_msg.Text = Request.QueryString["msg"].ToString();
                }
            }
        }
    }
}