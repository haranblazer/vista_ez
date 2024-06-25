using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class terms_and_condition : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Logout.aspx", false);
        }
        else
        {
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }
    }
    private void BindData()
    {
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {  new SqlParameter("@franchiseid",  Session["franchiseid"].ToString()) };
            DataTable dt = objDu.GetDataTable(param1, @"select TC_Accept=isnull(TC_Accept,0), FranType, 
            TC_Doe=(Case when TC_Doe is null then '' when TC_Doe='' then '' else convert(varchar(20), TC_Doe, 106) +' '+ FORMAT(TC_Doe, 'hh:mm:ss tt')  end) from FranchiseMst where FranchiseId=@franchiseid");
            //FORMAT(getdate(), 'dd-MM-yyyy hh:mm:ss tt') as date convert(varchar(20), TC_Doe, 106)
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["FranType"].ToString() == "4") //top Circle
                {
                    div_topcircel.Visible = true;
                }
                else if (dt.Rows[0]["FranType"].ToString() == "5") //top Point
                {
                    div_toppoint.Visible = true;
                }
                if (dt.Rows[0]["TC_Accept"].ToString() == "1")
                {
                    hnd_TCType.Value = "1";
                    lbl_TcDate.Text = "Accepted Date: " + dt.Rows[0]["TC_Doe"].ToString();
                    chk_tc.Checked = true;
                    chk_tc.Enabled = false;
                    btn_Submit.Text = "Accepted";
                    btn_Submit.Enabled = false;
                    // btn_Submit.Attributes.Add("class", "btn btn-primary");
                }
                else
                {
                    hnd_TCType.Value = "0";
                    chk_tc.Enabled = true;
                    
                }
            }
        }
        catch (Exception ex) { }
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        try
        {
            if (chk_tc.Checked == false)
            {
                utility.MessageBox(this, "Please Select Terms & Conditions.!!");
                return;
            }
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@FranchiseID", Session["franchiseid"].ToString()) ,
                new SqlParameter("@TC_Accept_IP", HttpContext.Current.Request.ServerVariables["REMOTE_HOST"].ToString())
            };
            int Result = objDu.ExecuteSql(param, "update FranchiseMst set TC_Accept=1, TC_Accept_IP=@TC_Accept_IP, TC_Doe=Getdate() where FranchiseID=@FranchiseID");
            utility.MessageBox(this, "Successfully Accepted Terms & Conditions.!!");
            if (Result == 1)
            {
                Response.Redirect("Welcome.aspx");
            }
        }
        catch (Exception ex) { }
    }
}