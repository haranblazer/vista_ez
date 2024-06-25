using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class secretadmin_PromotionalAmountList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
            Response.Redirect("adminLog.aspx", false);

    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReader(@"Select p.MId, CurrentDate=convert(varchar(20), p.CurrentDate,106), p.AdminId, UserId=a.AppmstRegno, Amount=isnull(p.Amount,0), p.Remark, 
            Doe=Convert(varchar(20),p.Doe,106), UserName=a.Appmstfname,
            a.AppMstState, a.AppMstMobile, a.distt
            from PromotionalAmt p inner join Appmst a on p.Userid=a.AppmstRegno order by p.MId desc");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.MId = dr["MId"].ToString();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.AppMstState = dr["AppMstState"].ToString();
                data.AppMstMobile = dr["AppMstMobile"].ToString();
                data.distt = dr["distt"].ToString();
                data.Amount = dr["Amount"].ToString();
                data.Doe = dr["Doe"].ToString();
                data.Remark = dr["Remark"].ToString();
                data.CurrentDate = dr["CurrentDate"].ToString();
                data.AdminId = dr["AdminId"].ToString();
                details.Add(data);

            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string MId { get; set; }
        public string UserId { get; set; }
        public string AppMstState { get; set; }
        public string AppMstMobile { get; set; }
        public string distt { get; set; }
        public string Amount { get; set; }
        public string UserName { get; set; }
        public string Doe { get; set; }
        public string Remark { get; set; }
        public string CurrentDate { get; set; }
        public string AdminId { get; set; }

    }

    #endregion

}