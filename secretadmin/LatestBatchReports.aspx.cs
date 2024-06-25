using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class secretadmin_LatestBatchReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminLogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    { 
        List<UserDetails> details = new List<UserDetails>();
        try
        { 
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReader(@"Select t.ProductCode, t.ProductName, t.CatName, t.HSNCode, PurchaseRate=Cast(t.PurchaseRate as decimal(18,2)), MRP=Cast(b.MRP as decimal(18,2)), 
            DPValue=Cast(b.DPAmt as decimal(18,2)), GSTRate=Cast(b.Tax as decimal(18,2)), AssociateRate=Cast(b.DPWithTax as decimal(18,2)), 
            RPV=b.pbvamt, TPV=b.BVAmt, FPV=Cast(b.FPV as int), APV=Cast(b.APV as int), b.BatchNo, MFg=b.BatchDate, Exp=b.ExpiryDate From( 
            Select s.ProductCode, ProductName=s.ProductName +SPACE(1)+ s.PackSize +SPACE(1)+ Cast(ps.PackSize as nvarchar(50)), 
            c.CatName, s.HSNCode, PurchaseRate=s.Price, 
            Batchid=(Select Max(Batchid) from BatchMst where IsExpired=0 and Productid=s.ProductId)  
            from ShopProductMst s inner join CategoryMst c on s.CatId=c.CatId
            inner join PackSizemst ps on s.PackSizeUnitId=ps.srno and s.isDeleted = 0  
            )t inner join BatchMst b on t.Batchid=b.Batchid and b.IsExpired=0
            order by t.ProductCode"); 
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.ProductCode = dr["ProductCode"].ToString();
                data.ProductName = dr["ProductName"].ToString();
                data.CatName = dr["CatName"].ToString();
                data.HSNCode = dr["HSNCode"].ToString();
                data.PurchaseRate = dr["PurchaseRate"].ToString();
                data.MRP = dr["MRP"].ToString();
                data.DPValue = dr["DPValue"].ToString();
                data.GSTRate = dr["GSTRate"].ToString();
                data.AssociateRate = dr["AssociateRate"].ToString();
                data.RPV = dr["RPV"].ToString();
                data.TPV = dr["TPV"].ToString();
                data.FPV = dr["FPV"].ToString();
                data.APV = dr["APV"].ToString();

                data.BatchNo = dr["BatchNo"].ToString();
                data.MFg = dr["MFg"].ToString();
                data.Exp = dr["Exp"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public string CatName { get; set; }
        public string HSNCode { get; set; }
        public string PurchaseRate { get; set; }
        public string MRP { get; set; }
        public string DPValue { get; set; }
        public string GSTRate { get; set; } 
        public string AssociateRate { get; set; }
        public string RPV { get; set; }
        public string TPV { get; set; }
        public string FPV { get; set; }
        public string APV { get; set; }

        public string BatchNo { get; set; }
        public string MFg { get; set; }
        public string Exp { get; set; }

    }


  
    #endregion


}