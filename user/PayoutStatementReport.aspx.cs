using System; 
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Data; 
public partial class admin_PayoutStatementReport : System.Web.UI.Page
{

    static string strsession, payoutno, uid = "";

    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataReader sdr;
    SqlDataAdapter da;

    utility objUtil = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            Response.Cache.SetAllowResponseInBrowserHistory(true);
            strsession = Convert.ToString(objUtil.base64Decode(Request.QueryString["id"]));
            uid = Convert.ToString(objUtil.base64Decode(Request.QueryString["uid"]));
            payoutno = objUtil.base64Decode(Request.QueryString["n"]);


            if (Regex.Match(strsession + payoutno, @"^[A-Za-z0-9]*$").Success)
            {

                con.Open();
                com = new SqlCommand("result2", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@appmstid", strsession);
                com.Parameters.AddWithValue("@payoutno", payoutno);
                sdr = com.ExecuteReader();
                if (sdr.Read())
                {

                    lblPI.Text = sdr["FSI"].ToString();
                    lbl_SF.Text = sdr["StaterFund"].ToString();
                    lbl_BP.Text = sdr["DepthAmt"].ToString();
                    lbl_LB.Text = sdr["LB"].ToString();
                     

                    lbl_TF.Text = sdr["TF"].ToString();
                    lbl_LCF.Text = sdr["CF"].ToString();
                    lbl_HF.Text = sdr["HF"].ToString();

                    lbl_DF.Text = sdr["PR"].ToString();
                    lbl_DDF.Text = sdr["PB"].ToString();
                    lbl_BlueDF.Text = sdr["RB"].ToString();
                    lbl_BlkDF.Text = sdr["BF"].ToString();
                    lbl_CAF.Text = sdr["GrowthAmt"].ToString();
                    lbl_ARF.Text = sdr["AR"].ToString();

                    lbl_OfferInc1.Text = sdr["directamt"].ToString();
                    lbl_OfferInc2.Text = sdr["PF"].ToString();
                   

                    lbl_OfferInc3.Text = sdr["OI3"].ToString();
                    lbl_OfferInc4.Text = sdr["OI4"].ToString();

                    lbl_Prod_Wallet.Text = sdr["PW_Wallet"].ToString();
                    lbl_TotalBenefits.Text =(Convert.ToDecimal(sdr["totalearning"].ToString()) 
                        + Convert.ToDecimal(sdr["AR"].ToString()) 
                        + Convert.ToDecimal(sdr["PW_Wallet"].ToString())
                        ).ToString() ;
                     
                   // Total Benefits = Total Income + all 4 Annual Royalty +Product Wallet Value


                    lbltoalincentive.Text = sdr["totalearning"].ToString();
                    lblCurrentppv.Text = sdr["pbv"].ToString();
                    lblcurrentgpv.Text = sdr["gbv"].ToString();
                    lbltbv.Text = sdr["oldgbv"].ToString();
                    lblprofitlevel.Text = sdr["percentage"].ToString();
                    lblmonthyear.Text = sdr["monthyear"].ToString();
                    lblHandlingChrgs.Text = sdr["handlingCharges"].ToString();
                    lblTDS.Text = sdr["TDS"].ToString();
                    lblNetAmt.Text = sdr["dispachedamt"].ToString();

                   


                }

                sdr.Close();
                con.Close();
                string qstr1 = @"select website='website : '+ (select Userval from settingmst where caption='WEBSITE') + '  / email :'+
                (select Userval from settingmst where caption='COM_EMAIL') ,companyname=(select Userval from settingmst where caption='COMPANYNAME'), 
                address=(select Userval from settingmst where caption='COM_ADDRESS'),ap.panno,ap.AppMstTitle,ap.AppmstFname,ap.appmstdoj,ap.appmstregno,
                ap.appmstaddress1 +' '+ap.AppMstCity +' '+ap.appmststate+' '+ap.AppMstPinCode as appmstaddress1,ap.email,ap.appmstpincode,ap.AppMstMobile,ap.distt,ap.AppMstCity,
                ap.appmststate,ap.AppMstPinCode,py.PaymentFromDate,py.PaymentToDate,py.depthamt,  (select AppMstRegNo from appmst  where appmstid=ap.sponsorid) as sponsorid,(select appmstfname from appmst  where appmstid=ap.sponsorid) as sponsorname
                from appmst ap, repaymenttrandraft py where ap.appmstregno=py.appmstid and ap.appmstregno='" + strsession + "' and py.payoutno='" + payoutno + "'";

                con.Open();
                com = new SqlCommand(qstr1, con);
                sdr = com.ExecuteReader();
                if (sdr.Read())
                {

                    lblcompanyname.Text = sdr["companyname"].ToString();
                    lblname.Text = sdr["appmstfname"].ToString();
                    lblmobile.Text = sdr["appmstmobile"].ToString();
                    lblpanno.Text = sdr["panno"].ToString();
                    lbladdress.Text = sdr["appmstaddress1"].ToString();
                    lblid.Text = sdr["appmstregno"].ToString();
                    lblname.Text = sdr["appmstfname"].ToString();
                    lblcaddress.Text = sdr["address"].ToString();
                    lblfrmdate.Text = Convert.ToDateTime(sdr["PaymentFromDate"]).ToString("dd/MM/yyyy");
                    lbltodate.Text = Convert.ToDateTime(sdr["PaymentToDate"]).ToString("dd/MM/yyyy");
                }
                sdr.Close();
                con.Close();

                LBIncome();
            }

        }

    }

    public void LBIncome()
    {
        SqlDataAdapter da = new SqlDataAdapter("LBIncome", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.CommandTimeout = 999999;
        da.SelectCommand.Parameters.AddWithValue("@uid", uid);
        da.SelectCommand.Parameters.AddWithValue("@payoutno", payoutno);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            Repeater_LB.DataSource = dt;
            Repeater_LB.DataBind();
        }
        else
        {
            Repeater_LB.DataSource = null;
            Repeater_LB.DataBind();
        }
    }


    public void pincome()
    {
        SqlDataAdapter da = new SqlDataAdapter("piincome", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.CommandTimeout = 999999;
        da.SelectCommand.Parameters.AddWithValue("@uid", uid);
        da.SelectCommand.Parameters.AddWithValue("@payoutno", payoutno);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            Rpincome.DataSource = dt;
            Rpincome.DataBind();
        }
        else
        {
            Rpincome.DataSource = null;
            Rpincome.DataBind();
        }
    }


    public void lincome()
    {


        SqlDataAdapter da = new SqlDataAdapter("lbincome", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.CommandTimeout = 999999;
        da.SelectCommand.Parameters.AddWithValue("@uid", uid);
        da.SelectCommand.Parameters.AddWithValue("@payoutno", payoutno);
        DataTable dt = new DataTable();
        da.Fill(dt);

        if (dt.Rows.Count > 0)
        {

            liincome.DataSource = dt;
            liincome.DataBind();
        }
        else
        {
            liincome.DataSource = null;
            liincome.DataBind();
        }



    }
}