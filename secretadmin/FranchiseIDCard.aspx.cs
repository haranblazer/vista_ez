using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_FranchiseIDCard : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = null;
    SqlCommand com = null;
    SqlDataAdapter da = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["DT"] != null)
            {
                DataFranIDCard.DataSource = (DataTable)Session["DT"];
                lblprint.DataBind();
            }
            else
            {
                Response.Redirect("FranchisePrintID.aspx", true);
            }
        }
    }
    //public void BindData()
    //{
    //    da = new SqlDataAdapter("", con);
    //    DataTable dtt = new DataTable();
    //    da.Fill(dtt);
    //    if (dtt.Rows.Count > 0)
    //    {
    //        DataFranIDCard.DataSource = dtt;
    //        lblprint.DataBind();
    //    }
    //    else
    //    {
    //        Session["DT"] = null;
    //    }
    //}
}