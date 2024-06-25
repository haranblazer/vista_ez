using System;
using System.Collections.Generic;
using System.Data.SqlClient; 

public partial class secretadmin_PanApiFetch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReader(@"Select  Count(*), t.Appmstid1, a.panno, a.AppMstRegNo, a.AppMstFName, a.AppMstState, a.distt from REPaymentTranDraft t inner join appmst a on t.appmstid1=a.Appmstid 
            and len(a.panno)=10 and t.payoutno=18 and t.TotalEarning>0 and a.IFSCode<>'' and a.IFSCode is not null
            where t.Appmstid1 not in(Select Appmstid from Scandocs Where OnlinePanVerify=1)  group by t.Appmstid1, a.panno, a.AppMstRegNo, a.AppMstFName, a.AppMstState, a.distt");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.AppMstid = dr["Appmstid1"].ToString();
                data.panno = dr["panno"].ToString();
                data.AppMstRegNo = dr["AppMstRegNo"].ToString();
                data.AppMstFName = dr["AppMstFName"].ToString();
                data.AppMstState = dr["AppMstState"].ToString();
                data.distt = dr["distt"].ToString();

                details.Add(data); 
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static void UpdatePanAPIStatus(string PanApiName, string AppMstid, string PanDetails)
    {
        SqlParameter[] param = new SqlParameter[] {
            new SqlParameter("@Appmstid", AppMstid),
            new SqlParameter("@PanApiName", PanApiName),
            new SqlParameter("@PanDetails", PanDetails),
        };
        DataUtility objDu = new DataUtility();
        objDu.ExecuteSql(param, "Update scandocs set OnlinePanVerify=1, PanApiName=@PanApiName, PanDetails=@PanDetails Where Appmstid=@Appmstid");
    }


    public class UserDetails
    {
        public string AppMstid { get; set; }
        public string panno { get; set; }
        public string AppMstRegNo { get; set; }
        public string AppMstFName { get; set; }
        public string AppMstState { get; set; }
        public string distt { get; set; }
    }
}
 