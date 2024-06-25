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
using System.Linq;


public partial class admin_adminpayout2 : System.Web.UI.Page
{
    string appmstid;
    SqlConnection con = new SqlConnection(method.str);
    DataUtility dutil = new DataUtility();
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;
    string str, from, str1;
    int payoutno;
    double tax, oc;
    static string Payoutno = "0";
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
            //string qstr = "select PayFromDate=CONVERT(varchar(50),PayFromDate,103), PayoutNo from payoutdate where  convert(varchar(50),paytodate,103)=@appmstdoj ";
            //com = new SqlCommand(qstr, con);
            //com.Parameters.AddWithValue("@appmstdoj", str);
            //con.Open();
            //sdr = com.ExecuteReader();
            //if (sdr.HasRows)
            //{
            //    sdr.Read();
            //    Label2.Text = "From::" + Convert.ToString(sdr["PayFromDate"]) + "---" + "ToDate::" + str;
            //    Payoutno = sdr["PayoutNo"].ToString();
            //}

            SqlParameter[] param = new SqlParameter[]
            { 
                new SqlParameter("@appmstdoj",str) 
            };
            DataUtility obj_du = new DataUtility();
            DataTable dt = obj_du.GetDataTable(param, "select PayFromDate=CONVERT(varchar(50),PayFromDate,103), PayoutNo from payoutdate where  convert(varchar(50),paytodate,103)=@appmstdoj");
            if (dt.Rows.Count > 0)
            {
                Label2.Text = "From :" + Convert.ToString(dt.Rows[0]["PayFromDate"]) + "--" + "ToDate :" + str;
                Payoutno = dt.Rows[0]["PayoutNo"].ToString();
            }
            else
            {
                Label2.Text = "";
                Payoutno = "0";
            }


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

             
            SqlParameter[] param = new SqlParameter[]
            { 
                new SqlParameter("@Payoutno",Payoutno),
                new SqlParameter("@Userid",txtUerid.Text.Trim()),
                 new SqlParameter("@iselegible",ddl_Payout_Fillter.SelectedValue.ToString()),
            };
            DataUtility obj_du = new DataUtility();
            DataTable t = obj_du.GetDataTableSP(param, "changeincome1");


            //con.Close();
            //com = new SqlCommand("changeincome1", con);
            //com.CommandType = CommandType.StoredProcedure;
            //com.Parameters.AddWithValue("@Payoutno", Payoutno);
            //com.Parameters.AddWithValue("@Userid", txtUerid.Text.Trim());
            //com.Parameters.AddWithValue("@iselegible", ddl_Payout_Fillter.SelectedValue.ToString().Trim());
            //DataTable t = new DataTable();
            //da = new SqlDataAdapter(com);
            //da.Fill(t);

            if (t.Rows.Count > 0)
            {
                GridView1.DataSource = t;
                GridView1.DataBind();
                //foreach (GridViewRow gv in GridView1.Rows)
                //{
                //    Label IsPaid = (Label)gv.FindControl("lbl_IsPaid");
                //    HiddenField Iselegible = (HiddenField)gv.FindControl("hnd_Iselegible");
                //    if (Iselegible.Value == "0")
                //    {
                //        gv.BackColor = Color.FromName("#ffebea");
                //    }
                //    else if (Iselegible.Value == "2")
                //    {
                //        gv.BackColor = Color.FromName("#e2fbd7");
                //    }


                //    if (IsPaid.Text == "1")
                //    {
                //        TextBox txtdraft = (TextBox)gv.FindControl("txtdraftno");
                //        TextBox txtcomment = (TextBox)gv.FindControl("txtcomment");
                //        HyperLink lnkmodify = (HyperLink)gv.Cells[0].Controls[0];
                //        txtdraft.Enabled = false;
                //        txtcomment.Enabled = false;
                //        lnkmodify.Enabled = true;
                //        lnkmodify.ForeColor = System.Drawing.Color.Blue;
                //    }
                //}

                msg.Visible = true;
                object Totalearning= t.Compute("Sum(Totalearning)", "1=1");

                Label3.Text = "No of Records : " + t.Rows.Count.ToString() + "  &nbsp; Total Income : " + Totalearning.ToString();
                Button1.Visible = true;
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                Button1.Visible = false;
                msg.Visible = false;
                if (Label2.Text == string.Empty)
                {
                    Label1.Text = "No Data Found.";
                }
            }
        }
        catch (Exception er)
        {
            Label1.Text = er.Message;
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField IsPaid = (HiddenField)e.Row.FindControl("hnd_IsPaid");
            if (IsPaid.Value == "1")
            {
                TextBox txtdraft = (TextBox)e.Row.FindControl("txtdraftno");
                TextBox txtcomment = (TextBox)e.Row.FindControl("txtcomment");
                HyperLink lnkmodify = (HyperLink)e.Row.Cells[0].Controls[0];
                txtdraft.Enabled = false;
                txtcomment.Enabled = false;
                lnkmodify.Enabled = true;
                lnkmodify.ForeColor = System.Drawing.Color.Blue;
            }

            HiddenField H_Iselegible = (HiddenField)e.Row.FindControl("hnd_Iselegible");
            if (H_Iselegible.Value == "0")
                e.Row.BackColor = Color.FromName("#ffebea");
            else if (H_Iselegible.Value == "2")
                e.Row.BackColor = Color.FromName("#e2fbd7");
             
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
                Label paymenttrandraftid = (Label)gv.FindControl("lblpmid");
                string strid = GridView1.DataKeys[gv.RowIndex].Value.ToString();
                // payoutno = Convert.ToInt32(gv.Cells[7].Text);
                // HyperLink lnkmodify = (HyperLink)gv.Cells[0].Controls[0];

                if (txtdraft.Text.Trim() != "" && txtcomment.Text.Trim() != "")
                {
                    SqlParameter outparam = new SqlParameter("@strResult", SqlDbType.VarChar, 220);
                    outparam.Direction = ParameterDirection.Output;

                    SqlParameter[] param = new SqlParameter[]
                    {
                        new SqlParameter("@appmstid", strid),
                        new SqlParameter("@remarks", txtcomment.Text.Trim()),
                        new SqlParameter("@paymenttrandraftno", txtdraft.Text.Trim()),
                        new SqlParameter("@payoutno", paymenttrandraftid.Text),
                        outparam
                    };

                    string result = dutil.ExecuteSqlSPS(param, "sp_finalamount1");
                    if (result != "")
                    {
                        utility.MessageBox(this, result);
                    }
                }
            }
            bind();
        }
        catch (Exception er)
        {

        }

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow gv in GridView1.Rows)
            {
                payoutno = Convert.ToInt32(gv.Cells[1].Text);
                string strid = GridView1.DataKeys[gv.DataItemIndex].Value.ToString();
                string qstr = "update paymenttrandraft set remarks=@remarks where appmstid=@appmstid and paymenttrandraftid=@Draftid";
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


  //  protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
   // {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{

        //    string d1 = GridView1.DataKeys[e.Row.RowIndex].Values[1].ToString();
        //    string d3 = GridView1.DataKeys[e.Row.RowIndex].Values[0].ToString();
        //    string d2 = GridView1.DataKeys[e.Row.RowIndex].Values[2].ToString();
        //    if (d1 != "0" || d2 != "0")
        //    {
        //        e.Row.BackColor = Color.FromName("#f5e187");
        //    }

      //  }

  //  }

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
                //string ptrandraftno = row.Cells[0].Text.Trim().ToString();
                Label ptrandraftno = (Label)row.FindControl("lblpmid");

                Label lblpayoutno = (Label)row.FindControl("lblPayoutno");
                string payoutno = lblpayoutno.Text.Trim();
                if (lnk == "ON")
                {
                    com = new SqlCommand("SHPaymentTranDraft", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.CommandTimeout = 999999;
                    com.Parameters.AddWithValue("@payoutno", payoutno);
                    com.Parameters.AddWithValue("@ptrandraftno", ptrandraftno.Text.Trim());
                    com.Parameters.AddWithValue("@uid", uid);
                    com.Parameters.AddWithValue("@type", lnk);
                    com.Parameters.AddWithValue("@action", "1");
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
                    com.Parameters.AddWithValue("@ptrandraftno", ptrandraftno.Text.Trim());
                    com.Parameters.AddWithValue("@uid", uid);
                    com.Parameters.AddWithValue("@type", lnk);
                    com.Parameters.AddWithValue("@action", "1");
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
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bind();
    }
    protected void btn_Search_Click(object sender, EventArgs e)
    {
        bind();
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect("modyfypayment.aspx?n=ADD&n1="+Payoutno);
    }
}