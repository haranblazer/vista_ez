using System;
using System.Data;
using System.Data.SqlClient;
public partial class secretadmin_SecondarySales : System.Web.UI.Page
{
    static string MasterKey = "", From = "", To = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("logout.aspx");
            }
            if (!IsPostBack)
            {
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["Key"] != null)
                    {
                        MasterKey = Request.QueryString["Key"].ToString();
                        try
                        {
                            if (Request.QueryString["From"].ToString().Length > 0)
                            {
                                txtFromDate.Text = Request.QueryString["From"].ToString();
                                String[] Date = Request.QueryString["From"].ToString().Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                                From = Date[1] + "/" + Date[0] + "/" + Date[2];
                            }
                            if (Request.QueryString["To"].ToString().Length > 0)
                            {
                                txtToDate.Text = Request.QueryString["To"].ToString();
                                String[] Date = Request.QueryString["To"].ToString().Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                                To = Date[1] + "/" + Date[0] + "/" + Date[2];
                            }
                        }
                        catch
                        {
                            utility.MessageBox(this, "Invalid date entry.!!");
                            return;
                        }
                        Binddata();
                    }
                }

            }
        }
        catch
        {

        }
    }

    private void Binddata()
    {
        SqlParameter[] param = new SqlParameter[] {
            new SqlParameter("@Adminid", Session["admin"].ToString()),
            new SqlParameter("@From", From),
            new SqlParameter("@To", To),
            new SqlParameter("@flag", 0),
        };

        DataUtility obj_du = new DataUtility();
        DataTable dt = obj_du.GetDataTableSP(param, "Get_Secondary_dashboard");
        // Session["dt_2"] = dt;
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["RoleId"].ToString() == "1" || dt.Rows[0]["RoleId"].ToString() == "2")
            {
                div_Directors.Visible = true;
                lbl_INVWISE.InnerText = lbl_DEPOWISE.InnerText = lbl_BUYERWISE.InnerText = dt.Rows[0]["TotalSecondarySales"].ToString();
            }
        }
        else
        {

        }
    }


}
