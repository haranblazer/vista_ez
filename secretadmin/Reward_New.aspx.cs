using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_Reward_New : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddMonths(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            // BindDataDatewise();
            BindRewardList();
        }
    }

    public void BindRewardList()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("GetRewards", con);
            com.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            ddlRewardList.Items.Clear();
            da.Fill(dt);
            ddlRewardList.DataSource = dt;
            ddlRewardList.DataTextField = "Reward";
            ddlRewardList.DataValueField = "RankId";
            ddlRewardList.DataBind();
            ddlRewardList.Items.Insert(0, new ListItem("Select Reward", "0"));
        }
        catch
        {

        }
    }

    [System.Web.Services.WebMethod]
    public static string Submit(string srno, string Remarks)
    {
        string result = "";
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("addrewardremark", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@srno", srno);
            com.Parameters.AddWithValue("@remarks", Remarks);
            //com.Parameters.AddWithValue("@tranid", Tran_No);

            con.Open();
            result = com.ExecuteNonQuery().ToString();

        }
        catch (Exception er) { }
        return result;
    }

    [System.Web.Services.WebMethod]

    public static Detail[] BindTable(string fromDate, string toDate, string RewardList)
    
    {
        List<Detail> details = new List<Detail>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Reward", RewardList),
                new SqlParameter("@min", fromDate),
                new SqlParameter("@max", toDate)
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