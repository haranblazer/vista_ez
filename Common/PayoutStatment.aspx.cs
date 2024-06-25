using System; 
using System.Data;
using System.Data.SqlClient; 

public partial class Common_PayoutStatment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["id"] != "")
                    {
                        string Fid = Request.QueryString["id"].ToString();

                        PayoutValue(Fid);
                        PayoutDetails(Fid);
                        //BindCompany();
                    }
                }
            }
            catch (Exception er) { }

        }
    }

    public void PayoutDetails(string Fid)
    {
        SqlParameter[] param = new SqlParameter[]
        {
            new SqlParameter("@Fid", Fid) 
        };
        DataUtility obj_du = new DataUtility();
        DataTable dt = obj_du.GetDataTableSP(param, "GetFran_Payout_Statment"); 
        if (dt.Rows.Count > 0)
        {
            GridView1.Columns[0].FooterText = "Total: "; 
            GridView1.Columns[4].FooterText = dt.Compute("sum([Commission on FPV])", "true").ToString();
            GridView1.Columns[5].FooterText = dt.Compute("sum([Commission on APV])", "true").ToString();
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }

    public void PayoutValue(string Fid)
    {
        SqlParameter[] param1 = new SqlParameter[] { new SqlParameter("@Fid", Fid) };
         
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param1, @"Select p.Totalearning, p.Dispachedamt, p.GST, p.MNT_Expense, p.OfferIncome, 
        f.FranchiseId, f.FName, f.Address from Fpaymenttrandraft p, FranchiseMst f 
        where p.FranchiseId=f.FranchiseId and Fid=@Fid");
        if (dt.Rows.Count > 0)
        {
            lbl_OfferInc.Text= dt.Rows[0]["OfferIncome"].ToString();
            lbl_Maintenance_Expe.Text = dt.Rows[0]["MNT_Expense"].ToString();
            lbl_Total_commi_payable.Text = dt.Rows[0]["Totalearning"].ToString();
            lbl_TDS.Text = dt.Rows[0]["GST"].ToString();
            lbl_Net_Commi_Payable.Text = dt.Rows[0]["Dispachedamt"].ToString();

            //lbl_Fran_Id.Text = dt.Rows[0]["FranchiseId"].ToString();
            //lbl_Fran_Name.Text = dt.Rows[0]["FName"].ToString();
            //lbl_Fran_Address.Text = dt.Rows[0]["Address"].ToString();

        }


    }

  //  private void BindCompany()
  //  {
  //      DataUtility objDu = new DataUtility();
  //      DataTable dt = objDu.GetDataTable(@"Select companyname=UserVal, 
		//logourl=(Select UserVal from Settingmst where Caption='LOGO_URL'),
		//oraddress=(Select UserVal from Settingmst where Caption='COM_ADDRESS'),
		//phone=(Select UserVal from Settingmst where Caption='COM_PHONE'),
		//emailid=(Select UserVal from Settingmst where Caption='COM_EMAIL'),
		//cinno=(Select UserVal from Settingmst where Caption='COM_CINNO'),
		//panno=(Select UserVal from Settingmst where Caption='COM_PANNO'),
		//city=(Select UserVal from Settingmst where Caption='COM_STATE'),
		//gst=(Select UserVal from Settingmst where Caption='COM_GST'),
		//companyhead=(Select UserVal from Settingmst where Caption='COM_HEAD'),
		//cstatecode=(Select stateno FROM stategstmst WHERE statename =(Select UserVal from Settingmst where Caption='COM_STATE')),
		//CompanyCIN=(Select UserVal from Settingmst where Caption='COM_CINNO') 
		//from Settingmst where Caption='COMPANYNAME'");
        
  //      if (dt.Rows.Count > 0)
  //      {
  //          lbl_Comp.Text = dt.Rows[0]["companyname"].ToString();

  //          lbl_ComAdd.Text = dt.Rows[0]["oraddress"].ToString();
  //          lbl_ComMobileno.Text = dt.Rows[0]["phone"].ToString();
  //          lbl_ComEmail.Text = dt.Rows[0]["emailid"].ToString();
  //          lbl_ComGSTIN.Text = dt.Rows[0]["gst"].ToString();
  //          lbl_ComPanNo.Text = dt.Rows[0]["panno"].ToString(); 
  //          lbl_ComCIN.Text = dt.Rows[0]["CompanyCIN"].ToString();
  //      }

  //  }



}