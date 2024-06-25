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
public partial class admin_editPin : System.Web.UI.Page
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
            if (Convert.ToString(Session["admintype"]) == "sa")
            {
                utility.CheckSuperAdminlogin();
            }
            else if (Convert.ToString(Session["admintype"]) == "a")
            {
                utility.CheckAdminloginInside();
            }
            else
            {
                Response.Redirect("adminLog.aspx");
            }

            strid = Convert.ToString(Request.QueryString["n"]);
            if (strid != null)
            {
                fill(strid);

            }
            else
            {
                Label1.Text = "SORRY :-AN NOT EDIT THIS PIN";
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        editremark();
        if (txtpaid.Text == "0")
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            //DateTime validDate = Convert.ToDateTime(toDate, dateInfo); 
            DateTime allotmentDate = new DateTime();
            try
            {
                allotmentDate = Convert.ToDateTime(txtDOJ.Text.Trim(), dateInfo);
            }
            catch
            {
                Label1.Text = "Invalid date entry.";
                return;
            }



            string qstrupdate = "update pinmst set pintype=@ptype,Plantype=@plan, amount=@amt,Allotmentdate=@AllotDate,remark=@rem,allotedto="+
                "(select appmstid from appmst where appmstregno=@regno) where pinsrno=@pinsrno";
            con.Open();
            com = new SqlCommand(qstrupdate, con);
            com.Parameters.AddWithValue("@ptype", txtpintype.Text);
            com.Parameters.AddWithValue("@plan", txtplantype.Text);
            com.Parameters.AddWithValue("@amt", txtamount.Text);
            com.Parameters.AddWithValue("@AllotDate", allotmentDate);
            com.Parameters.AddWithValue("@rem", txtRemark.Text);
            com.Parameters.AddWithValue("@regno", txtallotedto.Text);
            com.Parameters.AddWithValue("@pinsrno", txtpin.Text);
            com.ExecuteNonQuery();
            Label1.Text = "Updated successfully!";

            con.Close();
        }
        else
        {
            Label1.Text = "Remark edited successfully!";

        }

    }
    public void editremark()
    {
        string qstreditremark = "update pinmst set remark=@rem where pinsrno=@pisrno";
        con.Open();
        com = new SqlCommand(qstreditremark, con);
        com.Parameters.AddWithValue("@rem", txtRemark.Text.Trim());
        com.Parameters.AddWithValue("@pisrno", txtpin.Text.Trim());
        com.ExecuteNonQuery();       
        con.Close();
    }
    public void fill(string str)
    {
        string qstr = "select (select appmstregno from appmst where appmstid=allotedto)as allotedto ,* from pinmst where pinsrno=@pinsrno";
        con.Open();
        com = new SqlCommand(qstr, con);
        com.Parameters.AddWithValue("@pinsrno", str);
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
            txtRemark.Text = sdr["remark"].ToString();
            DateTime dt;
            dt = Convert.ToDateTime(sdr["allotmentdate"].ToString());
            txtDOJ.Text = dt.ToString("dd/MM/yyyy");
            if (txtpaid.Text == "1")
            {
                txtpintype.Enabled = false;
                txtplantype.Enabled = false;
                txtamount.Enabled = false;
                txtallotedto.Enabled = false;
                txtDOJ.Enabled = false;
            }
            con.Close();
        }

    }

}
