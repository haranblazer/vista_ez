using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Xml.Linq;

public partial class secretadmin_Reward : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    DataTable dt;

    public static object Remarkstbox { get; private set; }

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



    //            com = new SqlCommand("SearchReward", con);
    //            com.CommandType = CommandType.StoredProcedure;
    //            com.Parameters.AddWithValue("@FromDate", fromDate);
    //            com.Parameters.AddWithValue("@ToDate", toDate);
    //            com.Parameters.AddWithValue("@Search", ddlRewardList.SelectedItem.Value.Trim());



    //            com = new SqlCommand("DatewiseReward", con);
    //            com.CommandType = CommandType.StoredProcedure;
    //            com.Parameters.AddWithValue("@FromDate", fromDate);
    //            com.Parameters.AddWithValue("@ToDate", toDate);






    //public void reward()
    //{
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("userreward", con);
    //        com.CommandType = CommandType.StoredProcedure;

    //        da = new SqlDataAdapter(com);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {

    //            gridlist.DataSource = dt;
    //            gridlist.DataBind();
    //            lblMessage.Text = "No of Record(s): " + dt.Rows.Count;


    //        }
    //        else
    //        {
    //            gridlist.DataSource = null;
    //            gridlist.DataBind();
    //            lblMessage.Text = string.Empty;
    //        }


    //    }
    //    catch
    //    {

    //    }

    //}

    //protected void gridlist_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    gridlist.PageIndex = e.NewPageIndex;
    //    if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()) && ddlRewardList.SelectedValue != "0")
    //    {
    //        BindSearchReward();
    //    }
    //    else
    //    {
    //        BindDataDatewise();
    //    }
    //}
    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}
    //public void BindDataDatewise()
    //{
    //    try
    //    {
    //        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //        dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //        DateTime fromDate = new DateTime();
    //        DateTime toDate = new DateTime();
    //        try
    //        {
    //            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
    //            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid Date!");
    //            return;
    //        }
    //        double datedays = (toDate - fromDate).TotalDays;
    //        if (datedays > 366)
    //        {
    //            utility.MessageBox(this, "Maximum 366 days allowed");
    //            gridlist.DataSource = null;
    //            gridlist.DataBind();
    //            lblMessage.Text = "";
    //            btnupdate.Visible = false;
    //            return;
    //        }
    //        if (fromDate <= toDate)
    //        {
    //            con = new SqlConnection(method.str);
    //            com = new SqlCommand("DatewiseReward", con);
    //            com.CommandType = CommandType.StoredProcedure;
    //            com.Parameters.AddWithValue("@FromDate", fromDate);
    //            com.Parameters.AddWithValue("@ToDate", toDate);
    //            da = new SqlDataAdapter(com);
    //            dt = new DataTable();
    //            da.Fill(dt);
    //            if (dt.Rows.Count > 0)
    //            {
    //                btnupdate.Visible = true;
    //                BindRewardList();
    //                gridlist.DataSource = dt;
    //                gridlist.DataBind();
    //                lblMessage.Text = "No of Record(s): " + dt.Rows.Count;
    //            }
    //            else
    //            {
    //                btnupdate.Visible = false;
    //                gridlist.DataSource = null;
    //                gridlist.DataBind();
    //                lblMessage.Text = string.Empty;

    //            }
    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "Sorry,from date should not greater than to date.");
    //            txtFromDate.Focus();
    //        }

    //    }
    //    catch
    //    {

    //    }

    //}


    //protected void btnSearchByDate_Click(object sender, EventArgs e)
    //{
    //    BindDataDatewise();
    //}

    public void BindRewardList()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetRewardList", con);
            com.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            ddlRewardList.Items.Clear();
            da.Fill(dt);
            ddlRewardList.DataSource = dt;
            ddlRewardList.DataTextField = "name";
            ddlRewardList.DataValueField = "srno";
            ddlRewardList.DataBind();
            ddlRewardList.Items.Insert(0, new ListItem("Select Reward", ""));
        }
        catch
        {

        }
    }
    //protected void ddlRewardList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (!string.IsNullOrEmpty(txtFromDate.Text.Trim()) && !string.IsNullOrEmpty(txtToDate.Text.Trim()))
    //    {
    //        //BindSearchReward();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Both From Date and To Date are Required!");
    //        return;
    //    }
    //}
    //public void BindSearchReward()
    //{
    //    System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //    dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //    DateTime fromDate = new DateTime();
    //    DateTime toDate = new DateTime();
    //    con = new SqlConnection(method.str);
    //    com = new SqlCommand("SearchReward", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.Parameters.AddWithValue("@FromDate", fromDate);
    //    com.Parameters.AddWithValue("@ToDate", toDate);
    //    com.Parameters.AddWithValue("@Search", ddlRewardList.SelectedItem.Value.Trim());
    //    da = new SqlDataAdapter(com);
    //    dt = new DataTable();
    //    da.Fill(dt);
    //}

    //public void BindSearchReward()
    //{
    //    try
    //    {
    //        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //        dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //        DateTime fromDate = new DateTime();
    //        DateTime toDate = new DateTime();
    //        try
    //        {
    //            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
    //            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid Date!");
    //            return;
    //        }
    //        double datedays = (toDate - fromDate).TotalDays;
    //        if (datedays > 366)
    //        {
    //            utility.MessageBox(this, "Maximum 366 days allowed");
    //            gridlist.DataSource = null;
    //            gridlist.DataBind();
    //            lblMessage.Text = "";
    //            btnupdate.Visible = false;
    //            return;
    //        }
    //        if (fromDate <= toDate)
    //        {
    //            con = new SqlConnection(method.str);
    //            com = new SqlCommand("SearchReward", con);
    //            com.CommandType = CommandType.StoredProcedure;
    //            com.Parameters.AddWithValue("@FromDate", fromDate);
    //            com.Parameters.AddWithValue("@ToDate", toDate);
    //            com.Parameters.AddWithValue("@Search", ddlRewardList.SelectedItem.Value.Trim());
    //            da = new SqlDataAdapter(com);
    //            dt = new DataTable();
    //            da.Fill(dt);
    //            if (dt.Rows.Count > 0)
    //            {
    //                btnupdate.Visible = true;
    //                gridlist.DataSource = dt;
    //                gridlist.DataBind();
    //                lblMessage.Text = "No of Record(s): " + dt.Rows.Count;
    //            }
    //            else
    //            {
    //                btnupdate.Visible = false;
    //                gridlist.DataSource = null;
    //                gridlist.DataBind();
    //                lblMessage.Text = string.Empty;

    //            }
    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "Sorry,from date should not greater than to date.");
    //            txtFromDate.Focus();
    //        }


    //    }
    //    catch
    //    {

    //    }

    //}
    //protected void gridlist_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {

    //        LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkbtnDelivere");
    //        Label lbl_Delivere = (Label)e.Row.FindControl("lbl_Delivere");

    //        string d1 = gridlist.DataKeys[e.Row.RowIndex].Values[1].ToString();
    //        string d0 = gridlist.DataKeys[e.Row.RowIndex].Values[0].ToString();
    //        string d2 = gridlist.DataKeys[e.Row.RowIndex].Values[2].ToString();
    //        string d3 = gridlist.DataKeys[e.Row.RowIndex].Values[3].ToString();
    //        if (d1 != "" || d2 != "")
    //        {
    //            e.Row.BackColor = Color.FromName("#f5e187");
    //        }
    //        if (d3 == "1")
    //        {
    //            lnkbtn.Visible = false;
    //            lbl_Delivere.Text = "Delivered";
    //        }
    //        else
    //        {
    //            lnkbtn.Visible = true;
    //            lbl_Delivere.Text = "";
    //        }
    //    }
    //}


    //protected void gridlist_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName == "Delivere")
    //    {
    //        GridViewRow row = gridlist.Rows[Convert.ToInt32(e.CommandArgument)];
    //        string srno = gridlist.DataKeys[row.RowIndex].Values[0].ToString();

    //        TextBox txtdraft = (TextBox)row.FindControl("txtdraftno");
    //        TextBox txtcomment = (TextBox)row.FindControl("txtcomment");
    //        if(string.IsNullOrEmpty(txtdraft.Text))
    //        {
    //            utility.MessageBox(this, "Enter Transaction No.");
    //            return;
    //        }
    //        if (string.IsNullOrEmpty(txtcomment.Text))
    //        {
    //            utility.MessageBox(this, "Enter Remarks");
    //            return;
    //        }
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("addrewardremark", con);
    //        com.CommandType = CommandType.StoredProcedure;
    //        com.Parameters.AddWithValue("@srno", srno);
    //        com.Parameters.AddWithValue("@remarks", txtcomment.Text);
    //        com.Parameters.AddWithValue("@tranid", txtdraft.Text);

    //        con.Open();
    //        com.ExecuteNonQuery();
    //        con.Close();

    //        utility.MessageBox(this, "Reward Delivered successfully.!!");
    //        BindDataDatewise();
    //    }
    //}


    //protected void btnupdate_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        foreach (GridViewRow gv in gridlist.Rows)
    //        {
    //            TextBox txtdraft = (TextBox)gv.FindControl("txtdraftno");
    //            TextBox txtcomment = (TextBox)gv.FindControl("txtcomment");
    //            string id = gridlist.DataKeys[gv.DataItemIndex].Values[0].ToString();

    //            //if (txtdraft.Text.Trim() != "" && txtcomment.Text.Trim() != "")
    //            //{
    //            con = new SqlConnection(method.str);
    //            com = new SqlCommand("addrewardremark", con);
    //            com.CommandType = CommandType.StoredProcedure;
    //            com.Parameters.AddWithValue("@srno", id);
    //            com.Parameters.AddWithValue("@remarks", txtcomment.Text);
    //            com.Parameters.AddWithValue("@tranid", txtdraft.Text);

    //            con.Open();
    //            com.ExecuteNonQuery();
    //            con.Close();

    //            //}

    //        }
    //        BindDataDatewise();
    //    }
    //    catch
    //    {
    //    }

    //}
    [System.Web.Services.WebMethod]
    public static string Submit(string srno, string Remarks, string Tran_No)
    {
        string result = "";
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("addrewardremark", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@srno", srno);
            com.Parameters.AddWithValue("@remarks", Remarks);
            com.Parameters.AddWithValue("@tranid", Tran_No);

            con.Open();
            result= com.ExecuteNonQuery().ToString();

        }
        catch (Exception er) { }
        return result;
    }

    [System.Web.Services.WebMethod]

    public static Detail[] bindtable(string fromDate, string toDate, string RewardList)
    {
        List<Detail> details = new List<Detail>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Search", RewardList),
                new SqlParameter("@FromDate", fromDate),
                new SqlParameter("@ToDate", toDate)
            };
            //DataTable dt= objDu.GetDataTableSP(param, "SearchReward");

            SqlDataReader dr = objDu.GetDataReaderSP(param, "SearchReward_V2");
            while (dr.Read())
            {
                Detail data = new Detail();
                data.srno = dr["srno"].ToString();
                data.TStatus = dr["TStatus"].ToString();
                data.User_ID = dr["userid"].ToString();
                data.User_Name = dr["name"].ToString();
                data.Reward = dr["reward"].ToString();
                data.Doe = dr["doe"].ToString();
                data.L_point = dr["leftpoint"].ToString();
                data.R_point = dr["rightpoint"].ToString();
                data.Tran_No = dr["transactionid"].ToString();
                data.Remarks = dr["remarks"].ToString();

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
        public string L_point { get; set; }
        public string R_point { get; set; }
        public string Tran_No { get; set; }
        public string Remarks { get; set; }

    }


    //protected void ddlRewardList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    BindSearchReward();
    //}
}