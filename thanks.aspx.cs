using System;
using System.Data;
using System.Data.SqlClient;

public partial class user_newjoins : System.Web.UI.Page
{ 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["i"] != null)
        {
            utility obj = new utility();

            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {  new SqlParameter("@AppMstRegNo", obj.base64Decode(Request.QueryString["i"].Trim())) };
            DataTable dt = objDu.GetDataTable(param1, @"Select AppMstRegNo, AppMstFName, AppMstMobile, email,  AppMstPassword, AppMstDOJ=Convert(varchar(20), AppMstDOJ, 106),
            COMPANYNAME=(Select UserVal from SettingMst where Caption='COMPANYNAME'),
            COM_ADDRESS=(Select UserVal from SettingMst where Caption='COM_ADDRESS') from Appmst  where AppMstRegNo=@AppMstRegNo");
            if (dt.Rows.Count > 0)
            {
                utility objUt = new utility();
                lbl_UserId.InnerHtml = dt.Rows[0]["AppMstRegNo"].ToString();
                lbl_UsernameHeader.InnerHtml = dt.Rows[0]["AppMstFName"].ToString();
                lbl_PWD.InnerHtml = objUt.base64Decode(dt.Rows[0]["AppMstPassword"].ToString());
                lbl_UserName.InnerHtml = dt.Rows[0]["AppMstFName"].ToString();
                lbl_Mobile.InnerHtml = dt.Rows[0]["AppMstMobile"].ToString();
                lbl_Emailid.InnerHtml = dt.Rows[0]["email"].ToString();
                lbl_Date.InnerHtml = dt.Rows[0]["AppMstDOJ"].ToString();
                lbl_CompanyName.InnerHtml = dt.Rows[0]["COMPANYNAME"].ToString();
                lbl_CompanyAddress.InnerHtml = dt.Rows[0]["COM_ADDRESS"].ToString();
            }
        } 
    }
    
}
