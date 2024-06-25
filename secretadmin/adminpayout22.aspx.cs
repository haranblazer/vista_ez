using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Drawing;
using System.Text.RegularExpressions;

public partial class secretadmin_adminpayout22 : System.Web.UI.Page
{
    string appmstid;
    SqlConnection con = new SqlConnection(method.str);

    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    string str, from, str1;
    int payoutno;
    double tax, oc;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        if (Session["admin"] != null)
        {
            string strsession = Convert.ToString(Session["admin"]);
        }
        if (Request.QueryString["n"] != null)
        {
            str = Convert.ToString(Request.QueryString["n"]);
        }

        if (!IsPostBack)
        {

            bind();
        }
    }
    public void bind()
    {
        try
        {
            //string[] arr = str1.Split('/');
            //str = arr[1] + "/" + arr[0] + "/" + arr[2];
            //str=CONVERT(char(10),str,101);

            string qstr = "select PayFromDate=CONVERT(varchar(50),PayFromDate,103) from repayoutdate where  convert(varchar(50),paytodate,103)=@appmstdoj ";
            com = new SqlCommand(qstr, con);
            com.Parameters.AddWithValue("@appmstdoj", str);
            con.Open();
            sdr = com.ExecuteReader();
            if (sdr.HasRows)
            {
                sdr.Read();
                Label2.Text = "From::" + Convert.ToString(sdr["PayFromDate"]) + "---" + "ToDate::" + str;


            }
            con.Close();
            com = new SqlCommand("changeincome2", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@paymenttodate", str);
            DataTable t = new DataTable();
            da = new SqlDataAdapter(com);
            da.Fill(t);

            if (t.Rows.Count > 0)
            {
                GridView1.DataSource = t;
                GridView1.DataBind();
                msg.Visible = true;
                Label3.Text = t.Rows.Count.ToString();
                Button1.Visible = true;
            }
            else
            {
                Button1.Visible = false;
                msg.Visible = false;
                if (Label2.Text == string.Empty)
                {
                    Label1.Text = "No Data Found.";
                }

            }
        }
        catch
        {

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow gv in GridView1.Rows)
            {
                TextBox txtdraft = (TextBox)gv.FindControl("txtdraftno");
                TextBox txtcomment = (TextBox)gv.FindControl("txtcomment");
                string strid = GridView1.DataKeys[gv.DataItemIndex].Value.ToString();
                payoutno = Convert.ToInt32(gv.Cells[7].Text);
                if (txtcomment.Text.Trim() != "" && txtcomment.Text.Trim() != "")
                {
                    com = new SqlCommand("sp_finalamount2", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@appmstid", strid);
                    com.Parameters.AddWithValue("@remarks", txtcomment.Text);
                    com.Parameters.AddWithValue("@paymenttrandraftno", txtdraft.Text);
                    com.Parameters.AddWithValue("@payoutno", payoutno);
                    con.Open();
                    com.ExecuteNonQuery();
                    con.Close();

                }

            }
            bind();
        }
        catch
        {
        }

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow gv in GridView1.Rows)
            {
                payoutno = Convert.ToInt32(gv.Cells[7].Text);
                string strid = GridView1.DataKeys[gv.DataItemIndex].Value.ToString();
                string qstr = "update repaymenttrandraft set remarks=@remarks where appmstid=@appmstid and paymenttrandraftid=@Draftid";
                com = new SqlCommand(qstr, con);
                com.Parameters.AddWithValue("@appmstid", strid);
                com.Parameters.AddWithValue("@remarks", TextBox1.Text);
                com.Parameters.AddWithValue("@draftid", payoutno);
                con.Open();
                int i = com.ExecuteNonQuery();
                if (i > 0)
                {

                    Label1.Text = "Updated!";
                }
                else
                {

                    Label1.Text = "Not Updated,Try again!";

                }

                con.Close();
            }

        }
        catch
        {

        }
    }

    protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bind();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            string d1 = GridView1.DataKeys[e.Row.RowIndex].Values[1].ToString();
            string d3 = GridView1.DataKeys[e.Row.RowIndex].Values[0].ToString();
            string d2 = GridView1.DataKeys[e.Row.RowIndex].Values[2].ToString();
            if (d1 != "0" || d2 != "0")
            {
                e.Row.BackColor = Color.FromName("#f5e187");
            }

            //{
            //   
            //}




        }

    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "SH")
            {
                int rowindex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridView1.Rows[rowindex];
                LinkButton lnksts = e.CommandSource as LinkButton;
                string lnk = StripHTML(lnksts.Text.Trim());
                string uid = row.Cells[0].Text.Trim();
                string ptrandraftno = row.Cells[7].Text.Trim().ToString();
                Label lblpayoutno = (Label)row.FindControl("lblPayoutno");
                string payoutno = lblpayoutno.Text.Trim();
                if (lnk == "ON")
                {
                    com = new SqlCommand("SHPaymentTranDraft", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandTimeout = 999999;
                    com.Parameters.AddWithValue("@payoutno", payoutno);
                    com.Parameters.AddWithValue("@ptrandraftno", ptrandraftno);
                    com.Parameters.AddWithValue("@uid", uid);
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
                    com = new SqlCommand("SHPaymentTranDraft", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandTimeout = 999999;
                    com.Parameters.AddWithValue("@payoutno", payoutno);
                    com.Parameters.AddWithValue("@ptrandraftno", ptrandraftno);
                    com.Parameters.AddWithValue("@uid", uid);
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
            bind();
        }
        catch
        {

        }
    }

    public static string StripHTML(string input)
    {
        return Regex.Replace(input, "<.*?>", String.Empty);
    }
}