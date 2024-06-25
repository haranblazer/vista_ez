using System;
using System.Data.SqlClient;

public partial class franchise_billing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["FranchiseId"] != null)
        {
            if (Session["FranchiseId"].ToString() == method.DEFAULT_SELLER)
            {
                id_Menu_SalesReturn.Visible = true; 
            }
            if (!IsPostBack)
            {
                DataUtility objDu = new DataUtility();
                SqlParameter[] param1 = new SqlParameter[]
                {  new SqlParameter("@FranchiseId", Session["FranchiseId"].ToString() ) };
                string IsReturn = objDu.GetScaler(param1, "Select isnull(IsReturn,0) from FranchiseMst where FranchiseId=@FranchiseId").ToString();
                if (IsReturn == "1")
                {
                    id_Menu_SalesReturn_Asso.Visible = true;
                }
            }
        }
        else
        {
            Response.Redirect("logout.aspx");
        }

    }
}