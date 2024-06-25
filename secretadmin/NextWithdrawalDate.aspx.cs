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
using System.Data.SqlClient;

public partial class admin_NextWithdrawalDate : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }

    }
    protected void btnCalculate_Click(object sender, EventArgs e)
    {
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        DateTime dte = new DateTime();       
                   
            int i = 0;
            try
            {
                dte = Convert.ToDateTime(txtDOB.Text.Trim(), dateInfo);      
                i = 1;
            }
            catch
            {
                utility.MessageBox(this,"Invalid Date !");
                i = 0;
            }
           
            if (i == 1)
            {
                try
                {
                   
                    SqlCommand com = new SqlCommand("update paymentmst set WithdrawalDate=@dte", con);
                    com.Parameters.AddWithValue("@dte", dte);
                    con.Open();
                    int status = com.ExecuteNonQuery();
                    if (status > 0)
                    {
                       utility.MessageBox(this,"Successfull !");

                    }
                    else
                        utility.MessageBox(this,"Try Later !");
                    con.Close();
                    con.Dispose();
                }
                catch
                {
                    Response.Redirect("~/Error.aspx", false);
                }
            }
        
    }
}
