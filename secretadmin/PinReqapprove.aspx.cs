using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class admin_PinReqapprove : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand cmd = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            disputebind();
    }
    public void disputebind()
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlDataAdapter da = new SqlDataAdapter("select pin.srno,pin.appmstregno,p.ProductName as pname,p.Amount,noofpin,convert(varchar(15),pin.rdate,103) as rdate,pin.remarks from pinrequestmst pin inner join productmst p on pin.productId=p.srno where status=0 order by srno desc", con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                GridView1.DataSource = ds.Tables[0];
                GridView1.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "ap")
            {
                lbl_message.Visible = false;
                ViewState["srnoap"] = e.CommandArgument;
                cmd = new SqlCommand();
                con = new SqlConnection(method.str);
                cmd.CommandText = "select Appmstregno,noofpin from RechargeMst where srno=@srno order by srno desc";
                cmd.Parameters.AddWithValue("@srno", Convert.ToInt32(e.CommandArgument));
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtuserid.Text = dr["Appmstregno"].ToString();
                    txtapamt.Text = dr["noofpin"].ToString();
                    panapid.Visible = true;
                    panlID1.Visible = false;
                }
                else
                    con.Close();
                con.Dispose();
            }
            if (e.CommandName == "re")
            {
                try
                {
                    panlID1.Visible = true;
                    panapid.Visible = false;
                    lbl_message.Visible = false;
                    ViewState["srno"] = e.CommandArgument;
                }
                catch (Exception ex)
                {
                }
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        panlID1.Visible = false;
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void RaiseDisputetxt_Click(object sender, EventArgs e)
    {
        try
        {
            cmd = new SqlCommand();
            con = new SqlConnection(method.str);
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update pinrequestmst set dstatus=2 where srno=@srno";
            cmd.Parameters.AddWithValue("@srno", Convert.ToInt32(ViewState["srno"].ToString()));
            cmd.Connection = con;
            con.Open();
            int r = cmd.ExecuteNonQuery();
            if (r > 0)
            {
                lbl_message.Text = "Dispute Rejected";
                panlID1.Visible = false;
                lbl_message.Visible = true;
                panlID1.Visible = false;
                txtcomment.Text = "";
                disputebind();
            }
            con.Close();
        }
        catch
        {
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            cmd = new SqlCommand();
            con = new SqlConnection(method.str);
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update pinrequestmst set dstatus=1 where srno=@srno";
            cmd.Parameters.AddWithValue("@srno", Convert.ToInt32(ViewState["srno"].ToString()));
            cmd.Connection = con;
            con.Open();
            int r = cmd.ExecuteNonQuery();
            if (r > 0)
            {
                lbl_message.Text = "Pin Request Approve Successfully";
                panlID1.Visible = true;
                lbl_message.Visible = true;
                panlID1.Visible = false;
                txtcomment.Text = "";
                disputebind();
            }
            con.Close();
        }
        catch
        {
        }
    }
    protected void btnskip_Click(object sender, EventArgs e)
    {
        panapid.Visible = false;
    }

}