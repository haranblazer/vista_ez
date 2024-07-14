using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class user_Reward_New : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
        }

    }
    [System.Web.Services.WebMethod]

    public static Detail[] BindTable()

    {
        List<Detail> details = new List<Detail>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Reward", ""),
                new SqlParameter("@min", ""),
                new SqlParameter("@max", ""),
                 new SqlParameter("@regno", HttpContext.Current.Session["UserId"].ToString())
            };
            //DataTable dt= objDu.GetDataTableSP(param, "SearchReward");

            SqlDataReader dr = objDu.GetDataReaderSP(param, "RewardList");
            while (dr.Read())
            {
                Detail data = new Detail();
                data.srno = dr["srno"].ToString();
                data.User_ID = dr["AppmstRegno"].ToString();
                data.User_Name = dr["AppMstFName"].ToString();
                data.Reward = dr["reward"].ToString();
                data.Doe = dr["doe"].ToString();
                data.Remarks = dr["comment"].ToString();
                data.TStatus = dr["IsGiven"].ToString();

                details.Add(data);
            }

            //          select t.srno,(select appmstregno from appmst where appmstid = t.appmstid) as userid,
            //(select appmstfname from appmst where appmstid = t.appmstid) as name,
            //convert(varchar(50), doe, 103) as doe,
            //(select name from rewardMst where srno = t.awardrank)as reward, 
            //leftPoint,rightpoint,transactionid,Remarks, TStatus




        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class Detail

    {
        public string srno { get; set; }
        public string TStatus { get; set; }

        public string User_ID { get; set; }
        public string User_Name { get; set; }
        public string Reward { get; set; }
        public string Doe { get; set; }
        public string Remarks { get; set; }

    }

}