using System;
using System.Data; 
using System.Web.UI;
using System.Web.UI.WebControls; 
using System.Data.SqlClient; 
using System.Drawing;
using System.Text.RegularExpressions;
public partial class secretadmin_Repayoutdate : System.Web.UI.Page
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
        try
        {
            com = new SqlCommand("GetRePayoutDate", con);
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
        catch
        {

        }
    }
    protected void dgr_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            //DateTime FromDate = Convert.ToDateTime(dgr.Rows[Convert.ToInt32(e.CommandArgument.ToString().Trim())].Cells[2].Text.ToString().Split('/').GetValue(1).ToString() + "/" + dgr.Rows[Convert.ToInt32(e.CommandArgument.ToString().Trim())].Cells[2].Text.ToString().Split('/').GetValue(0).ToString() + "/" + dgr.Rows[Convert.ToInt32(e.CommandArgument.ToString().Trim())].Cells[2].Text.ToString().Split('/').GetValue(2).ToString());
            //DateTime ToDate = Convert.ToDateTime(((HyperLink)dgr.Rows[Convert.ToInt32(e.CommandArgument.ToString().Trim())].Cells[3].Controls[0]).Text.Split('/').GetValue(1).ToString() + "/" + ((HyperLink)dgr.Rows[Convert.ToInt32(e.CommandArgument.ToString().Trim())].Cells[3].Controls[0]).Text.Split('/').GetValue(0).ToString() + "/" + ((HyperLink)dgr.Rows[Convert.ToInt32(e.CommandArgument.ToString().Trim())].Cells[3].Controls[0]).Text.Split('/').GetValue(2).ToString());

            string payoutno = e.CommandArgument.ToString();

            if (e.CommandName == "SH")
            {
                LinkButton lnksts = e.CommandSource as LinkButton;
                string lnk = StripHTML(lnksts.Text.Trim());
                if (lnk == "Show")
                {
                    com = new SqlCommand("PaymentTranHideShow", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandTimeout = 999999;
                    //com.Parameters.AddWithValue("@fromdate", FromDate);
                    //com.Parameters.AddWithValue("@Todate", ToDate);
                    com.Parameters.AddWithValue("@payoutno", payoutno);
                    com.Parameters.AddWithValue("@type", lnk);
                    com.Parameters.AddWithValue("@action", "2");
                    com.Parameters.Add("@flag", SqlDbType.Int);
                    com.Parameters["@flag"].Direction = ParameterDirection.Output;
                    con.Open();
                    com.ExecuteNonQuery();
                    int status = Convert.ToInt16(com.Parameters["@flag"].Value);
                    if (status == 1)
                    {
                        utility.MessageBox(this, "Payout hidden successfully!");
                    }
                    con.Close();
                }
                else
                {
                    com = new SqlCommand("PaymentTranHideShow", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandTimeout = 999999;
                    //com.Parameters.AddWithValue("@fromdate", FromDate);
                    //com.Parameters.AddWithValue("@Todate", ToDate);
                    com.Parameters.AddWithValue("@payoutno", payoutno);
                    com.Parameters.AddWithValue("@type", lnk);
                    com.Parameters.AddWithValue("@action", "2");
                    com.Parameters.Add("@flag", SqlDbType.Int);
                    com.Parameters["@flag"].Direction = ParameterDirection.Output;
                    con.Open();
                    com.ExecuteNonQuery();
                    int status = Convert.ToInt16(com.Parameters["@flag"].Value);
                    if (status == 1)
                    {
                        utility.MessageBox(this, "Payout shown successfully!");
                    }

                    con.Close();
                }
            }

           if (e.CommandName == "s")
            {
                com = new SqlCommand("payoutsms2", con);
                com.CommandType = CommandType.StoredProcedure;
                com.CommandTimeout = 999999;
                com.Parameters.AddWithValue("@payoutno", payoutno);
                com.Parameters.Add("@flag", SqlDbType.Int);
                com.Parameters["@flag"].Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                int status = Convert.ToInt16(com.Parameters["@flag"].Value);
                if (status == 1)
                {
                    utility.MessageBox(this, "Message Send Successfully To All User Of  Payout  " + payoutno + "");
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

            if (lnk.Text == "0")
            {
                lnk.Text = "Send sms ";
                lnk.Enabled = true;
            }

            if (lnk.Text == "1")
            {
                lnk.Text = "You Already Send Sms";
                lnk.Enabled = false;
                lnk.ForeColor = Color.Red;

            }


        }
    }

    public static string StripHTML(string input)
    {
        return Regex.Replace(input, "<.*?>", String.Empty);
    }
}
