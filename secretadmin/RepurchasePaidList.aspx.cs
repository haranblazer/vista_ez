using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class secretadmin_RepurchasePaidList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lbl_Test.Text = "Table Print";
            lbl.Text = method.str;
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
            SqlDataReader dr = objDu.GetDataReader(@" Select t.ProductCode, t.ProductName, t.CatName, t.HSNCode, t.PurchaseRate, b.MRP, DPValue=Round(b.DPAmt,4), 
            GSTRate=b.Tax, AssociateRate=b.DPWithTax, RPV=b.pbvamt, TPV=b.BVAmt, b.FPV, b.APV From( 
            Select s.ProductCode, s.ProductName, c.CatName, s.HSNCode, PurchaseRate=s.Price, 
            Batchid=(Select Max(Batchid) from BatchMst where Productid=s.ProductId)  
            from ShopProductMst s inner join CategoryMst c on s.CatId=c.CatId  
            )t inner join BatchMst b on t.Batchid=b.Batchid order by t.ProductCode");
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
    }



    #endregion
}