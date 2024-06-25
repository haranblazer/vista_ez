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
public partial class admin_notActiveList : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    string strSelect;
    int StartIndex;
    int endIndex;
    int a = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
       // databind();

        
        //str = Session["admin"].ToString();
        //if (str == "")
        // Response.Redirect("adminLog.aspx");
        if (!IsPostBack)
        {
         
            countrecord();
            txtNoofRecords.Text = "50";
            SqlCommand cmd;
            SqlConnection con = new SqlConnection(method.str);
            cmd = new SqlCommand("select count(*) from pinmst where isActivate='0'", con);
            con.Open();
            //dgList.VirtualItemCount = (int)((int)cmd.ExecuteScalar() / (int)dgList.PageSize);
            con.Close();
            databind();
          //  Label2.Text = "Page:1";

        }
        countrecord();

    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        dgList.PageSize = Convert.ToInt32(txtNoofRecords.Text);
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(method.str);
        cmd = new SqlCommand("select count(*) from pinmst where isActivate='0'", con);
        con.Open();
        //dgList.VirtualItemCount = (int)((int)cmd.ExecuteScalar() / (int)dgList.PageSize);
        con.Close();
        databind();

    }
    private void databind()
    {
        SqlDataAdapter dadpt;
        DataSet ds;
        dgList.PageSize = Convert.ToInt32(txtNoofRecords.Text);
        //a = Convert.ToInt32(txtNoofRecords.Text);
        endIndex = StartIndex + dgList.PageSize;
        SqlConnection con = new SqlConnection(method.str);
        strSelect = "select  pinsrno as PinSerial_No from pinmst where isActivate='0'  order by pinsrno";
        //strSelect = "select  srno, pinsrno from pinmst where isActivate='0' and  SrNo > @startindex and SrNo <= @endindex order by srno";
        //strSelect = "select top " + a + " srno, pinsrno from pinmst where isActivate='0' and  SrNo > @startindex and SrNo <= @endindex order by srno";
        dadpt = new SqlDataAdapter(strSelect, con);

        dadpt.SelectCommand.Parameters.Add("@startindex", StartIndex);
        dadpt.SelectCommand.Parameters.Add("@endindex", endIndex);
        ds = new DataSet();
        dadpt.Fill(ds);
        dgList.DataSource = ds;
        dgList.DataBind();
        con.Close();

    }
    protected void dgList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        StartIndex = e.NewPageIndex * dgList.PageSize;
        dgList.PageIndex = e.NewPageIndex;
        databind();

    }
   
    private void countrecord()
    {
        SqlCommand cmd;

        SqlConnection con = new SqlConnection(method.str);
        cmd = new SqlCommand("select count(*) from pinmst where isActivate='0'", con);
        con.Open();
        lblmsg1.Text = "Total Record:" + cmd.ExecuteScalar();
        con.Close();
    }

}
