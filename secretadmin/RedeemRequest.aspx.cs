using System; 
using System.Data.SqlClient;
using System.Data; 

public partial class secretadmin_PayoutLeaderShipInc : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter sda;
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
        if (!IsPostBack)
        {
            BindDate();
        }
    }


    protected void Button3_Click(object sender, EventArgs e)
    { 
        try
        {
            com = new SqlCommand("GetRedeemProd", con);
            com.CommandType = CommandType.StoredProcedure; 
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.CommandTimeout = 1900;
            com.ExecuteNonQuery();
            if (com.Parameters["@flag"].Value.ToString() == "1")
            {
                con.Close();
                BindDate();
                utility.MessageBox(this, "Successfully Send All Redeem Request To Admin.");
            }
            else
            {
                con.Close();
                utility.MessageBox(this, com.Parameters["@flag"].Value.ToString());
            } 
        }
        catch (Exception er) { utility.MessageBox(this, er.Message); } 
    }


    private void BindDate()
    {
        DataUtility objDu = new DataUtility();
        lblLastPayoutDate.Text = "Last redeem request was executed : " + objDu.GetScalar("Select Convert(varchar(20), Max(doe), 106) from PO_Mst where IsOffer=1 and billBy='System'").ToString();
    }
}
