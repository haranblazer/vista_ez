using System; 
using System.Data;
using System.Data.SqlClient; 

public partial class secretadmin_Send_wallet_whatsapp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            BindProcess();
        } 
    }

    private void BindProcess()
    {
        DataUtility objDu = new DataUtility(); 
        DataTable dt = objDu.GetDataTable(@"Select SendToGenerationWallet=(Select isPaid from repayoutdate where Payoutno=(Select Max(Payoutno) from repayoutdate)),
        Sys_WithDraw_Generation=(Select count(*) from PTran80 where Reason='System Generat With-Draw' 
        and Cast(DateName(Month, BankTranDate) as nvarchar(3)) + '-' + RIGHT(DateName(Year, BankTranDate),2)
        =Cast(DateName(Month, Getdate()) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Getdate()),2)),
        Generation_Rank_Achievement=(Select Count(*) from WhatsApp_Log where Methord='Generation Rank Achievement'
        and Cast(DateName(Month, Doe) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Doe),2)
        =Cast(DateName(Month, Getdate()) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Getdate()),2)),
        Payout_Generation=(Select Count(*) from WhatsApp_Log where Methord='Payout Generation' 
        and Cast(DateName(Month, Doe) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Doe),2)
        =Cast(DateName(Month, Getdate()) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Getdate()),2)),
        Loyalty_Points_Achievement=(Select Count(*) from WhatsApp_Log where Methord='Loyalty Points 1500 Achievement' 
        and Cast(DateName(Month, Doe) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Doe),2)
        =Cast(DateName(Month, Getdate()) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Getdate()),2)),
        AWC_Loyalty_Achievement=(Select Count(*) from WhatsApp_Log where Methord='AWC Loyalty Achievement'
        and Cast(DateName(Month, Doe) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Doe),2)
        =Cast(DateName(Month, Getdate()) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Getdate()),2))");
        foreach (DataRow dr in dt.Rows)
        {
            if(dr["SendToGenerationWallet"].ToString() == "0")
            {
                btn_SendToGenerationWallet.Disabled= false;
                div_SendToGenerationWallet.InnerHtml = "<i class='fa fa-close' aria-hidden='true' style='font-size:24px;color:red'></i>";
            }
            else
            {
                btn_SendToGenerationWallet.Disabled = true;
                div_SendToGenerationWallet.InnerHtml = "<i class='fa fa-check' aria-hidden='true' style='font-size:24px;color:green'></i>";
            }

            if (dr["Sys_WithDraw_Generation"].ToString() == "0")
            {
                btn_Sys_WithDraw_Generation.Disabled = false;
                lbl_Sys_WithDraw_Generation.InnerHtml = "<i class='fa fa-close' aria-hidden='true' style='font-size:24px;color:red'></i>";
            }
            else
            {
                btn_Sys_WithDraw_Generation.Disabled = true;
                lbl_Sys_WithDraw_Generation.InnerHtml = "<i class='fa fa-check' aria-hidden='true' style='font-size:24px;color:green'></i>";
            }

            if (dr["Generation_Rank_Achievement"].ToString() == "0")
            {
                btn_Generation_Rank_Achievement.Disabled = false;
                div_Generation_Rank_Achievement.InnerHtml = "<i class='fa fa-close' aria-hidden='true' style='font-size:24px;color:red'></i>";
            }
            else
            {
                btn_Generation_Rank_Achievement.Disabled = true;
                div_Generation_Rank_Achievement.InnerHtml = "<i class='fa fa-check' aria-hidden='true' style='font-size:24px;color:green'></i>";
            }

            if (dr["Payout_Generation"].ToString() == "0")
            {
                btn_Payout_Generation.Disabled = false;
                div_Payout_Generation.InnerHtml = "<i class='fa fa-close' aria-hidden='true' style='font-size:24px;color:red'></i>";
            }
            else
            {
                btn_Payout_Generation.Disabled = true;
                div_Payout_Generation.InnerHtml = "<i class='fa fa-check' aria-hidden='true' style='font-size:24px;color:green'></i>";
            }

            if (dr["Loyalty_Points_Achievement"].ToString() == "0")
            {
                btn_Loyalty_Points_Achievement.Disabled = false;
                div_Loyalty_Points_Achievement.InnerHtml = "<i class='fa fa-close' aria-hidden='true' style='font-size:24px;color:red'></i>";
            }
            else
            {
                btn_Loyalty_Points_Achievement.Disabled = true;
                div_Loyalty_Points_Achievement.InnerHtml = "<i class='fa fa-check' aria-hidden='true' style='font-size:24px;color:green'></i>";
            }

            if (dr["AWC_Loyalty_Achievement"].ToString() == "0")
            {
                btn_AWC_Loyalty_Achievement.Disabled = false;
                div_AWC_Loyalty_Achievement.InnerHtml = "<i class='fa fa-close' aria-hidden='true' style='font-size:24px;color:red'></i>";
            }
            else
            {
                btn_AWC_Loyalty_Achievement.Disabled = true;
                div_AWC_Loyalty_Achievement.InnerHtml = "<i class='fa fa-check' aria-hidden='true' style='font-size:24px;color:green'></i>";
            }
        }
    }

    [System.Web.Services.WebMethod]
    public static string Send_wallet_whatsapp(string MstKey)
    {
        string str = ""; 
        try
        { 
            SqlParameter outparam = new SqlParameter("@strResult", SqlDbType.VarChar, 100);
            outparam.Direction = ParameterDirection.Output;

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@MstKey",MstKey), 
                outparam
            };
            DataUtility objDu = new DataUtility();
            str = objDu.ExecuteSqlSPS(param, "Send_Wallet_Whatsapp");
        }
        catch (Exception er) { str = ""; }
        return str;
    }


}