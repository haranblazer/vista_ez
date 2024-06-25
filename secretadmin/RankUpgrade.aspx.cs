using System;
using System.Data;
using System.Data.SqlClient;

public partial class secretadmin_RankUpgrade : System.Web.UI.Page
{
    static string Rankid = "0";
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
        if (!IsPostBack)
        {
            BindRank("");
        }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
              new SqlParameter("@RankType", ddl_SearchType.SelectedValue),
              new SqlParameter("@Userid",  txt_userid.Text.Trim()),
              new SqlParameter("@RankId", ddl_Rank.SelectedValue)
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "Rank_Update");
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Error"].ToString() == "0")
                {
                    lbl_Username.Text = "Rank Successfully Updated.!!";
                    lbl_Username.ForeColor = System.Drawing.Color.Green;
                    txt_userid.Text = "";
                    BindRank("");
                }
                else
                {
                    lbl_Username.Text = dt.Rows[0]["Error"].ToString();
                    lbl_Username.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
        catch (Exception er)
        {
            lbl_Username.Text = er.Message;
        }
    }

    protected void ddl_SearchType_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetUser();
    }

    private void GetUser()
    {
        if (!string.IsNullOrEmpty(txt_userid.Text.Trim()))
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            { new SqlParameter("@userid", txt_userid.Text.Trim()) };

            DataTable dt = objDu.GetDataTable(param1, @"Select Appmstfname, CARank, TlPer, 
            TRank=(Select RankName from BinarySlab Where LevelId=a.CARank),
            GRank=(Select RankName from RePurchase_Slab where Rankid=a.TlPer) from AppMst a where AppmstRegno=@userid");
            if (dt.Rows.Count > 0)
            {
                lbl_Username.ForeColor = System.Drawing.Color.Green;
                if (ddl_SearchType.SelectedValue == "TOPPER")
                {
                    Rankid = dt.Rows[0]["CARank"].ToString();
                    lbl_Username.Text = dt.Rows[0]["Appmstfname"].ToString() + " ( " + dt.Rows[0]["TRank"].ToString() + ")";
                }
                if (ddl_SearchType.SelectedValue == "GENERATION")
                {
                    Rankid = dt.Rows[0]["TlPer"].ToString();
                    lbl_Username.Text = dt.Rows[0]["Appmstfname"].ToString() + " ( " + dt.Rows[0]["GRank"].ToString() + ")";
                }
                BindRank(Rankid);
            }
            else
            {
                lbl_Username.Text = "Userid not exists!!";
                lbl_Username.ForeColor = System.Drawing.Color.Red;
                BindRank("");
            }
        }
        else
        {
            lbl_Username.Text = "Userid not exists!!";
            lbl_Username.ForeColor = System.Drawing.Color.Red;
            BindRank("");
        }
    }

    public void BindRank(string Rankid)
    {
        string Qry = "";
        if (Rankid != "")
        {
            DataUtility objDu = new DataUtility();
            if (ddl_SearchType.SelectedValue == "TOPPER")
                Qry = "Select Rankid=LevelId, RankName from BinarySlab where LevelId>" + Rankid + " order by LevelId";
            if (ddl_SearchType.SelectedValue == "GENERATION")
                Qry = "Select Rankid, RankName from RePurchase_Slab where Rankid>" + Rankid + " order by Rankid";
            try
            {
                DataTable dt = objDu.GetDataTable(Qry);
                if (dt.Rows.Count > 0)
                {
                    ddl_Rank.Items.Clear();
                    ddl_Rank.DataSource = dt;
                    ddl_Rank.DataTextField = "RankName";
                    ddl_Rank.DataValueField = "Rankid";
                    ddl_Rank.DataBind();
                }
                else
                {
                    ddl_Rank.Items.Clear();
                    ddl_Rank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("No More Ranks to Upgrade", "0"));
                }
            }
            catch (Exception er) { }
        }
        else
        {
            ddl_Rank.Items.Clear();
            ddl_Rank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("No Rank", "0"));
        }
    }

}