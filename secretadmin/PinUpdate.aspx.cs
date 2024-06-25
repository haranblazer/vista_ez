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
public partial class admin_PinUpdate : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    string strid;
    string strname;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            InsertFunction.CheckSuperAdminlogin();
            strid = Convert.ToString(Request.QueryString["n"]);
            if (strid != null)
            {
                fill(strid);

            }
            else
            {
                Response.Write("<script>alert('-SORRY :-CAN NOT EDIT THIS PIN!')</script>");

            }
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (txtpaid.Text == "0")
        {
            string dob = txtyear.Text + "/" + txtmonth.Text + "/" + txtdate.Text;
            string qstrupdate = "update pinmst set pintype='" + txtpintype.Text + "',Plantype='" + txtplantype.Text + "', amount=" + txtamount.Text + ",Allotmentdate='" + dob + "',allotedto='" + txtallotedto.Text + "' where pinsrno=" + txtpin.Text + "";
            con.Open();
            com = new SqlCommand(qstrupdate, con);
            com.ExecuteNonQuery();
            Response.Write("<script>alert('UPDATED SUCCESSFULLY!')</script>");
            con.Close();
        }
        else
            Response.Write("<script>alert('CAN NOT EDIT USED PIN!')</script>");

    }
    public void fill(string str)
    {
        string qstr = "select * from pinmst where pinsrno='" + str + "'";
        con.Open();
        com = new SqlCommand(qstr, con);
        sdr = com.ExecuteReader();
        if (sdr.Read())
        {
            txtpin.Text = sdr["pinsrno"].ToString();
            txtpaid.Text = sdr["paidappmstid"].ToString();
            txtregno.Text = sdr["regno"].ToString();
            txtpintype.Text = sdr["pintype"].ToString();
            txtamount.Text = sdr["Amount"].ToString();
            txtallotedto.Text = sdr["allotedto"].ToString();
            txtplantype.Text = sdr["plantype"].ToString();
            DateTime dt;
            dt = Convert.ToDateTime(sdr["allotmentdate"].ToString());
            string strdate = dt.Day.ToString();
            string strmonth = dt.Month.ToString();
            string stryear = dt.Year.ToString();
            txtdate.Text = strdate;
            txtmonth.Text = strmonth;
            txtyear.Text = stryear;
            con.Close();
        }
    }
}
