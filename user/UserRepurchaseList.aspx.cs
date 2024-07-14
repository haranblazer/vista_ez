using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Collections.Generic;
using System.Web;

public partial class user_UserRepurchaseList : System.Web.UI.Page
{
    string fromdate, todate;
    string sstr;
    decimal total, tds, handeling, other, dispatch, HoldAmt;
    SqlDataAdapter da;
    SqlDataReader dr;
    SqlCommand com;
    SqlConnection con = new SqlConnection(method.str);
    string str;

    string p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11;

    utility objUtil = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        else
        {
            sstr = Convert.ToString(Session["userId"]);
            if (!IsPostBack)
            {
                if (Regex.Match(sstr, @"^[a-zA-Z0-9]*$").Success)
                {
                    go2();
                    // finddata();
                }
                else
                {
                    Label1.Text = "Invalid UserID";
                }
            }
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string iselegible)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@idno", HttpContext.Current.Session["userId"].ToString()),
                new SqlParameter("@iselegible", iselegible)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "ChkUser");
            
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                utility objutil = new utility();
                data.Decode_appmstid = objutil.base64Encode(dr["appmstid"].ToString());
                data.Decode_payoutno = objutil.base64Encode(dr["payoutno"].ToString());

                data.payoutno = dr["payoutno"].ToString();
                data.Paymenttodate = dr["Paymenttodate"].ToString();
                data.ReleaseAmt = dr["ReleaseAmt"].ToString();
                data.binaryamt = dr["binaryamt"].ToString(); 
                    data.RoyaltyAmt = dr["RoyaltyAmt"].ToString();
                data.totalearning = dr["totalearning"].ToString();
                data.tds = dr["tds"].ToString();
                data.handlingcharges = dr["handlingcharges"].ToString();
                data.dispachedamt = dr["dispachedamt"].ToString();
                data.paymenttrandraftno = dr["paymenttrandraftno"].ToString();
                data.remarks = dr["remarks"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Decode_appmstid { get; set; }
        public string Decode_payoutno { get; set; }
        public string payoutno { get; set; }
        public string Paymenttodate { get; set; }
        public string ReleaseAmt { get; set; }
        public string binaryamt { get; set; }
        public string RoyaltyAmt { get; set; }
        public string totalearning { get; set; }
        public string tds { get; set; }
        public string handlingcharges { get; set; }
        public string dispachedamt { get; set; }
        public string paymenttrandraftno { get; set; }
        public string remarks { get; set; }

    }

    #endregion


    public void go2()
    {

        com = new SqlCommand("sp_account", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@appmstid", HttpContext.Current.Session["userId"].ToString());
        da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        for (int j = 0; j < t.Rows.Count; j++)
        {
            total += Convert.ToDecimal(t.Rows[j]["totalearning"].ToString());
            tds += Convert.ToDecimal(t.Rows[j]["tds"].ToString());
            handeling += Convert.ToDecimal(t.Rows[j]["handlingcharges"].ToString());
            other += Convert.ToDecimal(t.Rows[j]["othercharges"].ToString());
            dispatch += Convert.ToDecimal(t.Rows[j]["dispachedamt"].ToString());
            HoldAmt += Convert.ToDecimal(t.Rows[j]["HoldAmt"].ToString());
        }
        lblTotalTotalEarned.Text = Math.Round(total, 2).ToString();
        lblTotalTdsAmount.Text = Math.Round(tds, 2).ToString(); 
        lblTotalhandlibgCharges.Text = Math.Round(handeling, 2).ToString(); 
        lblTotalDispatchedAmount.Text = Math.Round(dispatch, 2).ToString(); 
        lbl_HoldAmt.Text = Math.Round(HoldAmt, 2).ToString(); 

    }



    //private void finddata()
    //{
    //    str = Convert.ToString(Session["userId"]);
    //    com = new SqlCommand("ChkUser", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.Parameters.AddWithValue("@idno ", str);
    //    com.Parameters.AddWithValue("@iselegible ", ddl_Payout_Fillter.SelectedValue);
    //    da = new SqlDataAdapter(com);
    //    DataSet ds = new DataSet();
    //    da.Fill(ds);
    //    int r = ds.Tables[0].Rows.Count;
    //    if (ds.Tables[0].Rows.Count > 0)
    //    {
    //        GridView1.DataSource = ds.Tables[0];
    //        GridView1.DataBind();
    //    }
    //    else
    //    {
    //        GridView1.DataSource = null;
    //        GridView1.DataBind();
    //        lblTotalTotalEarned.Text = "0.00";
    //        lblTotalTdsAmount.Text = "0.00";
    //        lblTotalhandlibgCharges.Text = "0.00";
    //        lblTotalDispatchedAmount.Text = "0.00";
    //    }
    //}




    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{

    //    if (e.CommandName.Equals("Statement"))
    //    {
    //        utility obj = new utility();

    //        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //        string payoutno = GridView1.DataKeys[row.RowIndex].Values[2].ToString();
    //        string regno = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
    //        Response.Redirect("UserPaymentReport.aspx?n=" + objUtil.base64Encode(payoutno) + "&id=" + objUtil.base64Encode(regno));

    //    }


    //    //if (e.CommandName.Equals("p1"))
    //    //{

    //    //    utility obj = new utility();
    //    //    GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //    //    string appmstid = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
    //    //    string date = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
    //    //    string payoutno = GridView1.DataKeys[row.RowIndex].Values[2].ToString();

    //    //    p6 = "PI";
    //    //    Response.Redirect("typelist.aspx?n=" + obj.base64Encode(appmstid) + "&id=" + objUtil.base64Encode(date) + "&t=" + p6);

    //    //}


    //    }
    //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    { 
    //        string d1 = GridView1.DataKeys[e.Row.RowIndex].Values[3].ToString();
    //        string d2 = GridView1.DataKeys[e.Row.RowIndex].Values[4].ToString();
    //        if (d1 != "0" || d2 != "0")
    //        {
    //            e.Row.BackColor = Color.FromName("#f5e187");
    //        }

    //    }
    //}
    //protected void ddl_Payout_Fillter_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    finddata();
    //}

}

