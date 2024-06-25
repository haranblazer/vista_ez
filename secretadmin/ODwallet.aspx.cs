using System;

using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class user_PWallet : System.Web.UI.Page
{
    DataTable dt = new DataTable();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    utility u = new utility();
    SqlDataReader dr;
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");


            if (!IsPostBack)
            {

                Bind();
                txtFromDate.Text = DateTime.Now.AddDays(-30).Date.ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");

            }
        }
        catch
        {

        }


        

         
    }


    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        Bind();
    }


    public void Bind()
    {
        try
        {
            string strmin = "", strmax = "";
            try
            {

                if (txtFromDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    strmin = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
                if (txtToDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    strmax = Date[1] + "/" + Date[0] + "/" + Date[2];
                }

            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry.");
                return;
            }
            da = new SqlDataAdapter("ODAdminwallet", con);
            con.Open();
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@regno", Session["admin"].ToString());
            da.SelectCommand.Parameters.AddWithValue("@min", strmin);
            da.SelectCommand.Parameters.AddWithValue("@max", strmax);
            da.SelectCommand.Parameters.AddWithValue("@UserId", txt_Userid.Text.Trim());
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                dglst.DataSource = dt;
                dglst.DataBind();
            }

            else
            {
                dglst.DataSource = null;
                dglst.DataBind();
            }

            con.Close();

        }
        catch (Exception ex)
        {
        }

    }



    protected void Button1_Click(object sender, EventArgs e)
    {
        Bind();
    }


}