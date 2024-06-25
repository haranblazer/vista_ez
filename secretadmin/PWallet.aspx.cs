using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
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
        if (Session["admin"] == null)
        {
            Response.Redirect("adminLog.aspx");
        }
        else
        {
            if (!IsPostBack)
            {

                txtFromDate.Text = DateTime.Now.Date.AddDays(-7).ToString("dd/MM/yyyy");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

                Bind();
                //month();
                //BindData();
            }
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
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();
            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);

            da = new SqlDataAdapter("PAdminwallet", con);
            con.Open();
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@regno", txtuserid.Text.Trim());
            da.SelectCommand.Parameters.AddWithValue("@from", fromDate);
            da.SelectCommand.Parameters.AddWithValue("@to", toDate);
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
            Response.Redirect("adminLog.aspx");
        }

    }


    //public void month()
    //{
    //    com = new SqlCommand("pwalletMonth", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.Parameters.AddWithValue("@regno", Session["admin"].ToString());
    //    con.Open();
    //    dr = com.ExecuteReader();
    //    ddlmonth.Items.Clear();
    //    while (dr.Read())
    //    {
    //        ddlmonth.Items.Add(dr["monthname"].ToString());
    //    }
    //    ddlmonth.Items.Insert(0, new ListItem("Select"));
    //    dr.Close();
    //    con.Close();
    //}


    //public void BindData()
    //{
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("ExecuteFunction", con);
    //        com.CommandType = CommandType.StoredProcedure;
    //        com.Parameters.AddWithValue("@function", "getPwalletBalanceForAdmin");
    //        // com.Parameters.AddWithValue("@functionparameter", "'" + Session["userId"].ToString().Trim() + "'");
    //        SqlDataAdapter adp = new SqlDataAdapter(com);
    //        DataTable dt = new DataTable();
    //        adp.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {
    //            lblewallet.Text = dt.Rows[0]["column1"].ToString();
    //        }
    //    }
    //    catch
    //    {
    //        Response.Redirect("~/Error.aspx", false);
    //    }
    //}
    protected void Button1_Click(object sender, EventArgs e)
    {
        Bind();
    }


    protected void dglst_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            //string bid = e.CommandArgument.ToString();
            GridViewRow row = dglst.Rows[Convert.ToInt32(e.CommandArgument)];
            string bid = dglst.DataKeys[row.RowIndex].Value.ToString();
            TextBox txtrem = (TextBox)row.FindControl("txtremark");

            if (e.CommandName == "Add")
            {
                com = new SqlCommand("update ptran80 set Reason=@rem where banktranid in (@banktranid)", con);
                com.CommandType = CommandType.Text;
                com.Parameters.AddWithValue("@banktranid", bid);
                com.Parameters.AddWithValue("@rem", txtrem.Text);
                con.Open();
                com.ExecuteNonQuery();
                con.Close();

                Bind();
            }
        }
        catch
        {
        }
    }
}