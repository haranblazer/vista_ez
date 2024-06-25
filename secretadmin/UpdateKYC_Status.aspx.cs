using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;

public partial class secretadmin_UpdateKYC_Status : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        DataUtility objDu = new DataUtility();
        if (ddlType.SelectedValue == "PAN")
        {
            DataTable dt = objDu.GetDataTable("Select Appmstid, PanImage, PStatus from Scandocs where PStatus=2");
            foreach (DataRow dr in dt.Rows)
            {
                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/PanImage/"), dr["PanImage"].ToString());
                if (System.IO.File.Exists(filePath))
                {
                    lbl_Msg.Text = "Userid " + dr["Appmstid"].ToString() + " file Exists.!!";
                }
                else
                { 
                    SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Appmstid", dr["Appmstid"].ToString()) };
                    lbl_Msg.Text = objDu.ExecuteSql(param, "Update scandocs set PStatus=0, PanImage=null Where Appmstid=@Appmstid").ToString();
                }
            }
        }


        if (ddlType.SelectedValue == "BANK")
        {
            DataTable dt = objDu.GetDataTable("Select Appmstid, bankstatus, BankImage from Scandocs where bankstatus=2");
            foreach (DataRow dr in dt.Rows)
            {
                string filePath = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/BankImage/"), dr["BankImage"].ToString());
                if (System.IO.File.Exists(filePath))
                {
                    lbl_Msg.Text = "Userid " + dr["Appmstid"].ToString() + " file Exists.!!";
                }
                else
                {
                    SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Appmstid", dr["Appmstid"].ToString()) };
                    lbl_Msg.Text = objDu.ExecuteSql(param, "Update scandocs set bankstatus=0, BankImage=null Where Appmstid=@Appmstid").ToString();
                }
            }
        }



        if (ddlType.SelectedValue == "AADHAR")
        {
            DataTable dt = objDu.GetDataTable("Select Appmstid, AadharFront, AadharBack, AaStatus from Scandocs where AaStatus=2");
            foreach (DataRow dr in dt.Rows)
            {
                string filePathAadharFront = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/AadharImage/Front/"), dr["AadharFront"].ToString());
                if (System.IO.File.Exists(filePathAadharFront))
                {
                    lbl_Msg.Text = "Userid " + dr["Appmstid"].ToString() + " file Exists.!!";
                }
                else
                {
                    SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Appmstid", dr["Appmstid"].ToString()) };
                    lbl_Msg.Text = objDu.ExecuteSql(param, "Update scandocs set AaStatus=0, AadharFront=null, AadharBack=null Where Appmstid=@Appmstid").ToString();
                }


                string filePathAadharBack = Path.Combine(HttpContext.Current.Server.MapPath("~/images/KYC/AadharImage/Back/"), dr["AadharBack"].ToString());
                if (System.IO.File.Exists(filePathAadharBack))
                {
                    lbl_Msg.Text = "Userid " + dr["Appmstid"].ToString() + " file Exists.!!";
                }
                else
                {
                    SqlParameter[] param = new SqlParameter[] { new SqlParameter("@Appmstid", dr["Appmstid"].ToString()) };
                    lbl_Msg.Text = objDu.ExecuteSql(param, "Update scandocs set  AaStatus=0, AadharFront=null, AadharBack=null Where Appmstid=@Appmstid").ToString();
                }
            }
        }



    }
}