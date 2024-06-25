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

public partial class admin_Activate_pin : System.Web.UI.Page
{
    string srpin;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        message.Visible = false;
        string str;
        str = Session["admin"].ToString();
        if (str == "")
            Response.Redirect("adminLog.aspx");

    }
    protected void btnActivate_Click(object sender, EventArgs e)
    {

        firstcheck();
    }
    protected void firstcheck()
    {
        if (txtpin1.Text != "")
        {
            srpin = txtpin1.Text;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("select * from pinmst where isactivate='1' and PinSrNo='" + txtpin1.Text + "'", con);
            con.Open();
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {

                lblpin1.Text = "Ur pin allready Activated!";
                lblpin1.Visible = true;
            }
            else
            {
                int c = againcheck(srpin);
                if (c == 1)
                {
                    lblpin1.Text = "invalid pin1!";
                    lblpin1.Visible = true;
                }
                else
                {
                    againcheck(srpin);
                    lblpin1.Text = "Pin1 Activated!";
                    lblpin1.Visible = true;
                }
            }
        }
        else
            txtpin1.Text = "";
        if (txtpin2.Text != "")
        {
            srpin = txtpin2.Text;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("select * from pinmst where isactivate='1' and PinSrNo='" + txtpin2.Text + "'", con);
            con.Open();
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {

                lblpin2.Text = "Ur pin allready Activated!";
                lblpin2.Visible = true;
            }
            else
            {
                int c = againcheck(srpin);
                if (c == 1)
                {
                    lblpin2.Text = "invalid pin2!";
                    lblpin2.Visible = true;
                }
                else
                {
                    againcheck(srpin);
                    lblpin2.Text = "Pin2 Activated!";
                    lblpin2.Visible = true;
                }
            }
        }
        if (txtpin3.Text != "")
        {
            srpin = txtpin3.Text;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("select * from pinmst where isactivate='1' and PinSrNo='" + txtpin3.Text + "'", con);
            con.Open();
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {

                lblpin3.Text = "Ur pin allready Activated!";
                lblpin3.Visible = true;
            }
            else
            {
                int c = againcheck(srpin);
                if (c == 1)
                {
                    lblpin3.Text = "invalid pin3!";
                    lblpin3.Visible = true;
                }
                else
                {
                    againcheck(srpin);
                    lblpin3.Text = "Pin3 Activated!";
                    lblpin3.Visible = true;
                }
            }
        }
        if (txtpin4.Text != "")
        {
            srpin = txtpin4.Text;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("select * from pinmst where isactivate='1' and PinSrNo='" + txtpin4.Text + "'", con);
            con.Open();
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {

                lblpin4.Text = "Ur pin allready Activated!";
                lblpin4.Visible = true;
            }
            else
            {
                int c = againcheck(srpin);
                if (c == 1)
                {
                    lblpin4.Text = "invalid pin4!";
                    lblpin4.Visible = true;
                }
                else
                {
                    againcheck(srpin);
                    lblpin4.Text = "Pin4 Activated!";
                    lblpin4.Visible = true;
                }
            }
        }
        if (txtpin5.Text != "")
        {
            srpin = txtpin5.Text;
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("select * from pinmst where isactivate='1' and PinSrNo='" + txtpin5.Text + "'", con);
            con.Open();
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {

                lblpin5.Text = "Ur pin allready Activated!";
                lblpin5.Visible = true;
            }
            else
            {
                int c = againcheck(srpin);
                if (c == 1)
                {
                    lblpin5.Text = "invalid pin5!";
                    lblpin5.Visible = true;
                }
                else
                {
                    againcheck(srpin);
                    lblpin5.Text = "Pin5 Activated!";
                    lblpin5.Visible = true;
                }
            }
        }


    }
    private int againcheck(string s)
    {

        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("CheckPinSrNo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@chkpinsrno", s);
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            update(s);
            return 0;
        }
        else
        {

            return 1;

        }
    }
    private void update(string s1)
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("update PINMst set isActivate='1' where PinSrNo='" + s1 + "'", con);
        con.Open();
        cmd.ExecuteNonQuery();

        con.Close();
    }
    protected void btn123_Click(object sender, EventArgs e)
    {
        string s = txtstart.Text;
        string s1 = txtend.Text;
        if (txtstart.Text != "")
        {
            int c = againcheck(s);
            if (c == 1)
            {
                lblfrom.Text = "Invalid Range";
                lblfrom.Visible = true;
            }
            else
            {
                SqlConnection con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("ActivatePinRange", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StartPin", txtstart.Text);
                cmd.Parameters.AddWithValue("@EndPin", txtend.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                message.Visible = true;
                con.Close();
            }
        }
        if (txtend.Text != "")
        {
            int c = againcheck(s);
            if (c == 1)
            {
                lblto.Text = "Invalid Range";
                lblto.Visible = true;
            }
            else
            {
                SqlConnection con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("ActivatePinRange", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StartPin", txtstart.Text);
                cmd.Parameters.AddWithValue("@EndPin", txtend.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                message.Visible = true;
                con.Close();
            }
        }
    }
}
