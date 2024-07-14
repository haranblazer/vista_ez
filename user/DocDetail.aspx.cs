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

public partial class user_DocDetail : System.Web.UI.Page
{
    DataUtility dutil = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == "")
        {
            Response.Redirect("../login.aspx");
        }

        if (!IsPostBack)
        {

            DIV1.Visible = false;
            DIV2.Visible = false;
            DIV3.Visible = false;
            DIV4.Visible = false;
            binddata();
        }
    }

    public void binddata()
    {
        try
        {
            SqlParameter[] param=new SqlParameter[]
            {
                new SqlParameter("@regno", Session["userId"].ToString()),
                new SqlParameter("@action", Request.QueryString["doctype"])
            };

            DataTable dt = dutil.GetDataTableSP(param, "GetDocStatus");

            if (dt.Rows.Count > 0)
            {
                if (Request.QueryString["doctype"] == "B")
                {
                    DIV1.Visible = true;
                    DIV2.Visible = false;
                    DIV3.Visible = false;
                    lblAccountName.Text = dt.Rows[0]["type"].ToString();
                    lblBanAcNo.Text = dt.Rows[0]["acountno"].ToString();
                    lblBankName.Text = dt.Rows[0]["bankname"].ToString();
                    lblBranch.Text = dt.Rows[0]["branch"].ToString();
                    lblIFSCode.Text = dt.Rows[0]["ifscode"].ToString();
                    Label1.Text = "<i class='fa fa-university'></i>&nbsp;" + "Bank Details";
                    imgBank.ImageUrl = "~/KYC/BankImage/" + dt.Rows[0]["bankimage"].ToString();
                }
                if (Request.QueryString["doctype"] == "P")
                {
                    DIV1.Visible = false;
                    DIV2.Visible = true;
                    DIV3.Visible = false;
                    lblPAN.Text = dt.Rows[0]["panno"].ToString();
                    Label1.Text = "<i class='fa fa-id-card-o'></i>&nbsp;" + "Pan Card Details";
                    imagePAN.ImageUrl = "~/KYC/PanImage/" + dt.Rows[0]["panimage"].ToString();
                }
                if (Request.QueryString["doctype"] == "A")
                {
                    DIV1.Visible = false;
                    DIV2.Visible = false;

                    if (!string.IsNullOrEmpty(dt.Rows[0]["addressimage"].ToString()))
                    {
                        DIV3.Visible = true;
                        Label1.Text = "<i class='fa fa-address-book'></i>&nbsp;" + "Aadhar/Address Details ";
                        imageAddress.ImageUrl = "~/KYC/AddressImage/" + dt.Rows[0]["addressimage"].ToString();

                    }
                    else
                    {
                        DIV4.Visible = true;
                        Label1.Text = "<i class='fa fa-address-book'></i>&nbsp;" + "Aadhar/Address Details";
                        AadharFront.ImageUrl = "~/KYC/AadharImage/Front/" + dt.Rows[0]["AadharFront"].ToString();
                        AadharBack.ImageUrl = "~/KYC/AadharImage/Back/" + dt.Rows[0]["AadharBack"].ToString();
                    }

                }
            }
          
        }
        catch
        {

        }

    }
}