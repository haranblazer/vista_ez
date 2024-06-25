using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class admin_SelectQualifyingGrowthId : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    int cn = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        try
        {
            Label3.Visible = false;
            Label4.Visible = false;
            Label5.Visible = false;
            SqlCommand com1 = new SqlCommand("select max(ClosingNo) from GrowthList where Closed=1", con);
            SqlDataReader dr;
            con.Open();
            dr = com1.ExecuteReader();
            dr.Read();
            int a = 0;
            if (dr[0].ToString() != "")
            {
                a = int.Parse(dr[0].ToString());

                con.Close();
                int b = a + 1;
                cn = b;

            }

            if (!Page.IsPostBack)
            {

                bind();
                if (a == 0)
                    Label2.Text = "No Closing Done";
                else
                    Label2.Text = a + " Closing Already Done";
            }

        }

        catch { }
    }
    public void bind()
    {
        try
        {
            con.Close();
            SqlCommand com = new SqlCommand("select AppMstRegNo,AppMstFName,closing,SponsorId,JoinFor from AppMst where closing='0' order by AppMstid", con);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count <= 0)
            {
                Label5.Visible = true;
                Label5.Text = "No data Exist";
                GridView1.Visible = false;
            }
            else
            {
                GridView1.Visible = true;
                GridView1.DataSource = ds;
                GridView1.DataBind();
                con.Close();
                Label1.Visible = true;
            }

        }
        catch (Exception ex)
        { }

    }

    protected void Button2_Click1(object sender, EventArgs e)
    {
        try
        {
            int hold = 0;
            string gvIDs = "";
            int s = int.Parse(TextBox1.Text);
            if ((s >= cn) && (s <= 12))
            {
                SqlConnection con = new SqlConnection(method.str);


                int i = 0;
                foreach (GridViewRow gv in GridView1.Rows)
                {


                    CheckBox ChkBxItem = (CheckBox)gv.FindControl("SelectChk");
                    if (ChkBxItem.Checked)
                    {

                        gvIDs = ((Label)gv.FindControl("EmpID")).Text.ToString();
                        SqlCommand com = new SqlCommand("G_InsertGrowthList", con);
                        com.CommandType = CommandType.StoredProcedure;
                        com.Parameters.AddWithValue("@id", gvIDs);
                        com.Parameters.AddWithValue("@ClosingNo", TextBox1.Text);
                        com.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                        con.Open();
                        com.ExecuteNonQuery();
                        hold = int.Parse(com.Parameters["@flag"].Value.ToString());

                        con.Close();
                        i = i + 1;
                    }


                }

                Label1.Visible = true;
                if (hold == 1)
                {

                    Label1.Text = "Selection Complete";

                }
                else if (hold == 2)
                {
                    Label1.Text = "Already Closed ";
                }
                else
                {
                    Label1.Text = "No User Selected";
                }
                ClosingCount();
                bind();
            }
            else
            {
                Label1.Visible = true;

                Label1.Text = "Closing no should be between than " + cn + " to 12";
            }

        }
        catch (SqlException err)
        {
            Response.Write(err.Message.ToString());
        }

    }
    public void ClosingCount()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("G_CalculateClosingCount", con);
            com.Parameters.AddWithValue("@ClosingNo", TextBox1.Text);
            com.Parameters.AddWithValue("@cno", SqlDbType.VarChar).Direction = ParameterDirection.Output;
            com.CommandType = CommandType.StoredProcedure;
            con.Open();
            com.ExecuteNonQuery();
            int cno = int.Parse(com.Parameters["@cno"].Value.ToString());
            Label4.Visible = true;
            Label4.Text = "Total users in closing " + TextBox1.Text + " =" + cno;
        }
        catch { }
    }


    protected void GridView1_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bind();
    }



    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            int s = int.Parse(TextBox1.Text);
            if ((s >= cn) && (s <= 12))
            {
                con.Close();
                SqlCommand com = new SqlCommand("G_InsertBlankId", con);
                com.Parameters.AddWithValue("@ClosingNo", TextBox1.Text);
                com.Parameters.AddWithValue("@id", SqlDbType.VarChar).Direction = ParameterDirection.Output;
                com.Parameters.AddWithValue("@cno", SqlDbType.VarChar).Direction = ParameterDirection.Output;
                com.CommandType = CommandType.StoredProcedure;
                con.Open();
                com.ExecuteNonQuery();
                string bId = com.Parameters["@id"].Value.ToString();
                int cno = int.Parse(com.Parameters["@cno"].Value.ToString());
                Label3.Visible = true;
                Label3.Text = "Blank Id :" + bId + " Created";
                Label4.Visible = true;
                Label4.Text = "Total users in closing " + TextBox1.Text + " =" + cno;
            }
            else
                Label1.Text = "Closing no should be between than " + cn + " to 12";
        }

        catch
        {
            Label1.Text = "Transaction Failed";
        }
    }


    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        PrintHelper.PrintWebControl(Panel1);
    }
}
