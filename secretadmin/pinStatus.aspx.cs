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
public partial class admin_pinStatus : System.Web.UI.Page
{
    public static int f = 0;
    int cnt = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminlogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!Page.IsPostBack)
        {
            trpinno.Visible = false;
            trstatus.Visible = false;
            tractive.Visible = false;
            trdeac.Visible = false;
            chkActiavte.Visible = false;
            chkDeactivate.Visible = false;
            BindPins();
            f = 0;
        }
    }
    private void BindPins()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            DataTable tbl = new DataTable();
            da = new SqlDataAdapter("select PinsrNo from pinmst", con);
            da.Fill(tbl);
            divPins.InnerText = string.Empty;
            foreach (DataRow row in tbl.Rows)
            {
                divPins.InnerText += row["PinsrNo"].ToString().Trim() + ",";
            }

        }
        catch
        {
        }
        finally
        {
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        chkActiavte.Checked = false;
        chkDeactivate.Checked = false;
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("CheckPinSrNo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@chkpinsrno", txtPinSrNo.Text);
        con.Open();
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            lblMsg1.Visible = false;
            show();           
        }
        else
        {
            utility.MessageBox(this,"Invalid pin !");
            
        }
        dr.Close();
        con.Close();
    }
   
    private void show()
    {

        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("select PinSrNo,isActivate,paidAppMstId,ActiveDate from pinmst where PinSrNo='" + txtPinSrNo.Text + "' and isActivate='1'and paidAppMstId='0'", con);
        con.Open();
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            cnt = 1;
            dr.Read();
            DateTime t = new DateTime();
            t = Convert.ToDateTime(dr[3]);
            lblPinNo.Text = txtPinSrNo.Text;
            lblStatus.Text = "Pin has activated but not used";
            trpinno.Visible = true;
            trstatus.Visible = true;
            trdeac.Visible = true;
            chkDeactivate.Visible = true;
        }
        else
        {
            if (cnt != 1)
            {
                show1();
            }
        }
        dr.Close();
        con.Close();
    }
    private void show1()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("select PinSrNo,isActivate,paidAppMstId,ActiveDate from pinmst where PinSrNo='" + txtPinSrNo.Text + "' and isActivate='1'and paidAppMstId='1'", con);
        con.Open();
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        if (dr.HasRows)
        {
            cnt = 1;
            dr.Read();
            DateTime t = new DateTime();
            t = Convert.ToDateTime(dr[3]);
            lblPinNo.Text = txtPinSrNo.Text;
            lblStatus.Text = "Pin has activated and used";
            trpinno.Visible = true;
            trstatus.Visible = true;

            utility.MessageBox(this,"This pin has been used");// + t.ToShortDateString() + " by User ID: " + dr["regno"];
            go();
            
            trdeac.Visible = false;
            tractive.Visible = false;
           
        }
        else
        {
            lblStatus.Text = "Pin not active";
            lblPinNo.Text = txtPinSrNo.Text;           
            trdeac.Visible = false;
            tractive.Visible = true;
            chkActiavte.Visible = true;
            trpinno.Visible = true;
            trstatus.Visible = true;
        }
    }
    private void activate()
    {

        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("update PINMst set isActivate='1',activedate='" + DateTime.Now + "' where PinSrNo='" + txtPinSrNo.Text + "'", con);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        lblStatus.Text = "Pin has activated now";
      
        tractive.Visible = false;        
    }
    private void deactivate()
    {
        SqlConnection con = new SqlConnection(method.str);
        SqlCommand cmd = new SqlCommand("update PINMst set isActivate='0',activedate='" + DateTime.Now + "' where PinSrNo='" + txtPinSrNo.Text + "'", con);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        lblStatus.Text = "Pin has deactivated now";
     
        trdeac.Visible = false;        
    }
    public void go()
{
    SqlConnection con = new SqlConnection(method.str);
    con.Open();  
    SqlDataAdapter adp = new SqlDataAdapter("select p.Pinsrno,(select appmstregno from appmst where appmstid=p.allotedto ) as allotedto,a.appmsttitle+space(1)+a.appmstfname as name,a.appmstmobile,convert(char(20),p.allotmentdate,103) as allotmentdate,(select appmstregno from appmst where appmstid=p.regno )as usedby,b.appmstfname as uname,b.appmstmobile,p.remark,a.appmstmobile,p.Amount,p.pintype,p.plantype  FROM AppMst AS a inner join  PINMst p ON a.AppMstid = p.allotedto LEFT OUTER JOIN  AppMst b ON p.RegNo = b.AppMstid where  p.allotedto>0 and p.Pinsrno='" + txtPinSrNo.Text + "' ", con);
    DataSet ds = new DataSet();
    adp.Fill(ds);
    dglst.DataSource = ds;
    dglst.DataBind();
    con.Close();
}
    protected void Button1_Click(object sender, EventArgs e)
    {
        tractive.Visible = false;
        trdeac.Visible = false;
        trpinno.Visible = false;
        trstatus.Visible = false;
        dglst.DataSource = null;
        dglst.DataBind();
        txtPinSrNo.Visible = true;
        chkActiavte.Checked = false;
        chkDeactivate.Checked = false;
        txtPinSrNo.Text = string.Empty;
        btnSubmit.Visible = true;

    }
    protected void btnDeActivate_Click(object sender, EventArgs e)
    {
        if (chkDeactivate.Checked == true)
        {
            deactivate();
        }
        else
            utility.MessageBox(this,"Please check activate option.");
    }
    protected void btnActivate_Click(object sender, EventArgs e)
    {
        if (chkActiavte.Checked == true)
        {
            activate();
        }
        else
            utility.MessageBox(this,"Please check de-activate option.");
    }
}
