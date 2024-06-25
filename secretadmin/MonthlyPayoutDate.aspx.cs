using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Drawing;
using System.Text.RegularExpressions;

public partial class secretadmin_MonthlyPayoutDate : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com = null;
    SqlDataAdapter sda = null;
    utility objUtility = new utility();
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

        if (!Page.IsPostBack)
        {
            go();
        }
    }
    public void go()
    {
        com = new SqlCommand("GetMonthlyPayoutDate", con);
        com.CommandType = CommandType.StoredProcedure;
        sda = new SqlDataAdapter(com);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            dgr.DataSource = dt;
            dgr.DataBind();
        }
        else
        {
            dgr.DataSource = null;
            dgr.DataBind();
        }
    }
    protected void dgr_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "SH")
            {
                GridViewRow row = dgr.Rows[Convert.ToInt32(e.CommandArgument)];
                String payoutno = dgr.DataKeys[row.RowIndex].Values[0].ToString();
                String Status = dgr.DataKeys[row.RowIndex].Values[1].ToString();

                com = new SqlCommand("PaymentTranHideShow", con);
                com.CommandType = CommandType.StoredProcedure;
                com.CommandTimeout = 999999;
                com.Parameters.AddWithValue("@payoutno", payoutno);
                com.Parameters.AddWithValue("@type", Status == "1" ? "ON" : "OFF");
                com.Parameters.AddWithValue("@action", "1");
                com.Parameters.Add("@flag", SqlDbType.Int);
                com.Parameters["@flag"].Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                int Result = Convert.ToInt16(com.Parameters["@flag"].Value);
                if (Result == 1)
                {
                    if (Status == "0")
                        utility.MessageBox(this, "Payout show successfully!");

                    if (Status == "1")
                        utility.MessageBox(this, "Payout hidden successfully!");
                }
                con.Close();
            }
             

            if (e.CommandName == "s")
            {
                string payoutno = e.CommandArgument.ToString();
                try
                {
                    string apmobile = "";
                    string msgtxt = "";
                    com = new SqlCommand(" select amount=dispachedamt,userid=appmstid,name=(select appmstfname from appmst where appmstid=p.appmstid1 and AppMstActivate=1),mobile=(select appmstmobile from appmst where appmstid=p.appmstid1 and AppMstActivate=1) from paymenttrandraft p where payoutno=@payoutno and paymentdisplay=1", con);
                    com.CommandType = CommandType.Text;
                    com.CommandTimeout = 999999;
                    com.Parameters.AddWithValue("@payoutno", payoutno);
                    con.Open();
                    SqlDataReader dr = com.ExecuteReader();
                    if (dr.HasRows == true)
                    {
                        while (dr.Read())
                        {
                            apmobile = dr["mobile"].ToString();
                            msgtxt = "Dear " + dr["name"].ToString() + " ID No " + dr["userid"].ToString() + " Amount " + dr["amount"].ToString() + " through Topper Payout Congratulations Jai Toptime";
                            //msgtxt = "Dear " + dr["name"].ToString() + " ID:" + dr["userid"].ToString() + " Congratulations payout of INR:" + dr["amount"].ToString() + " achieved. ";


                            objUtility.sendSMSByBilling(dr["mobile"].ToString(), msgtxt, "PAYOUT");
                        }
                    }
                    utility.MessageBox(this, "Message Send Successfully To All User Of  Payout  " + payoutno + "");
                    //go();
                }
                catch
                {
                    utility.MessageBox(this, "Error!");
                }
                finally
                {
                    go();
                }

            }
            if (e.CommandName == "SW")
            {
                string payoutno = e.CommandArgument.ToString();
                com = new SqlCommand("SendToTopperWallet", con);
                com.CommandType = CommandType.StoredProcedure;
                com.CommandTimeout = 999999;
                com.Parameters.AddWithValue("@Payoutno", payoutno);
                con.Open();
                int i = com.ExecuteNonQuery();
                if (i != 0)
                {
                    utility.MessageBox(this, "Send to Wallet Successfully To All User Of  Payout  " + payoutno + "");
                }
            }
            go();

        }
        catch
        {
            utility.MessageBox(this, "Try again later !");
        }
    }
    protected void dgr_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lnk = (LinkButton)e.Row.FindControl("linkButton1");
            LinkButton lnkbtnsendwallet = (LinkButton)e.Row.FindControl("lnkbtnsendwallet");
            Label lblispaid = (Label)e.Row.FindControl("lblispaid");
            if (lnk.Text == "0")
            {
                lnk.Text = "Send sms";
                lnk.Enabled = true;
            }
            else if (lnk.Text == "1")
            {
                lnk.Text = "You Already Send Sms";
                lnk.Enabled = false;
                lnk.ForeColor = Color.Red;
            }
            if (lblispaid.Text == "0")
            {
                lnkbtnsendwallet.Enabled = true;
            }
            else if (lblispaid.Text == "1")
            {
                lnkbtnsendwallet.Enabled = false;
            }
        }
    }
    public static string StripHTML(string input)
    {
        return Regex.Replace(input, "<.*?>", String.Empty);
    }
}
