using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Web;

public partial class user_UserRepurchaseList : System.Web.UI.Page
{
    decimal total, tds, handeling, dispatch, HoldAmt;
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                go2();
            }
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@idno", HttpContext.Current.Session["userId"].ToString()),
                new SqlParameter("@iselegible", "-1")
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "CheckUserId3");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                data.payoutno_Encode = objutil.base64Encode(dr["payoutno"].ToString());
                data.Appmstid_Encode = objutil.base64Encode(dr["appmstid1"].ToString());
                data.Regno_Encode = objutil.base64Encode(dr["appmstid"].ToString());

                data.payoutno = dr["payoutno"].ToString();
                data.PayoutStatus = dr["PayoutStatus"].ToString();
                data.ReleaseAmt = dr["ReleaseAmt"].ToString();
                data.Paymenttodate = dr["Paymenttodate"].ToString();
                data.PPV = dr["PPV"].ToString();
                data.GPV = dr["GPV"].ToString();
                data.TPV = dr["TPV"].ToString();
                data.PGPV = dr["PGPV"].ToString();
                data.FSI = dr["FSI"].ToString();
                data.LB = dr["LB"].ToString();

                data.StaterFund = dr["StaterFund"].ToString();
                data.DepthAmt = dr["DepthAmt"].ToString();
                data.TF = dr["TF"].ToString();
                data.CF = dr["CF"].ToString();
                data.HF = dr["HF"].ToString();
                data.PR = dr["PR"].ToString();
                data.PB = dr["PB"].ToString();
                data.RB = dr["RB"].ToString();
                data.BF = dr["BF"].ToString();
                data.GrowthAmt = dr["GrowthAmt"].ToString();
                 data.zm = dr["zm"].ToString();
                data.directamt = dr["directamt"].ToString();
                data.PF = dr["PF"].ToString();
                data.OI3 = dr["OI3"].ToString();
                data.OI4 = dr["OI4"].ToString();
                data.MG1 = dr["MG1"].ToString();
                data.MG2 = dr["MG2"].ToString();
                data.MG3 = dr["MG3"].ToString();
                data.MG4 = dr["MG4"].ToString();
                data.Total_Income = dr["Total Income"].ToString();
                data.TDS = dr["TDS"].ToString();

                data.PC = dr["PC"].ToString();
                data.Dispatch_Amount = dr["Dispatch Amount"].ToString();
                data.Remark = dr["Remark"].ToString();
                data.bankstatus = dr["bankstatus"].ToString();
                data.Inc1 = dr["Inc1"].ToString();
                data.Inc2 = dr["Inc2"].ToString();
                data.Inc3 = dr["Inc3"].ToString();
                data.Inc4 = dr["Inc4"].ToString();
                data.Inc5 = dr["Inc5"].ToString();
                data.Inc6 = dr["Inc6"].ToString();
                data.Inc7 = dr["Inc7"].ToString();
                data.Matched = dr["tp"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string payoutno_Encode { get; set; }
        public string Appmstid_Encode { get; set; }
        public string Regno_Encode { get; set; }

        public string payoutno { get; set; }
        public string PayoutStatus { get; set; }
        public string ReleaseAmt { get; set; }
        public string Paymenttodate { get; set; }
        public string PPV { get; set; }
        public string GPV { get; set; }
        public string TPV { get; set; }
        public string PGPV { get; set; }
        public string FSI { get; set; }
        public string LB { get; set; }
        public string zm { get; set; }


        public string StaterFund { get; set; }
        public string DepthAmt { get; set; }
        public string TF { get; set; }
        public string CF { get; set; }
        public string HF { get; set; }
        public string PR { get; set; }
        public string PB { get; set; }
        public string RB { get; set; }
        public string BF { get; set; }
        public string GrowthAmt { get; set; }

        public string directamt { get; set; }
        public string PF { get; set; }
        public string OI3 { get; set; }
        public string OI4 { get; set; }
        public string MG1 { get; set; }
        public string MG2 { get; set; }
        public string MG3 { get; set; }
        public string MG4 { get; set; }
        public string Total_Income { get; set; }
        public string TDS { get; set; }

        public string PC { get; set; }
        public string Dispatch_Amount { get; set; }
        public string Remark { get; set; }
        public string bankstatus { get; set; }
        public string Inc1 { get; set; }
        public string Inc2 { get; set; }
        public string Inc3 { get; set; }
        public string Inc4 { get; set; }
        public string Inc5 { get; set; }
        public string Inc6 { get; set; }
        public string Inc7 { get; set; }
        public string Matched { get; set; }
    }

    #endregion

    public void go2()
    {
        SqlCommand com = new SqlCommand("sp_GetGenertionPayout", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@appmstid", HttpContext.Current.Session["userId"].ToString());
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataTable t = new DataTable();
        da.Fill(t);
        for (int j = 0; j < t.Rows.Count; j++)
        {
            total += Convert.ToDecimal(t.Rows[j]["totalearning"].ToString());
            tds += Convert.ToDecimal(t.Rows[j]["tds"].ToString());
            handeling += Convert.ToDecimal(t.Rows[j]["handlingcharges"].ToString());
            // other += Convert.ToDouble(t.Rows[j]["othercharges"].ToString());
            dispatch += Convert.ToDecimal(t.Rows[j]["dispachedamt"].ToString());
            HoldAmt += Convert.ToDecimal(t.Rows[j]["HoldAmt"].ToString());
        }
        lblTotalTotalEarned.Text = total.ToString();
        lblTotalTdsAmount.Text = tds.ToString();
        lblTotalhandlibgCharges.Text = handeling.ToString();
        lblTotalDispatchedAmount.Text = dispatch.ToString();
        lbl_HoldAmt.Text = HoldAmt.ToString();
    }

}
