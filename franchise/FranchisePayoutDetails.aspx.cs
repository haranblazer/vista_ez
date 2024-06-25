using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;

public partial class franchise_FranchisePayoutDetails : Page
{
    string strfrom, strto;
    DataUtility Dutil = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Logout.aspx");
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
                new SqlParameter("@FranchiseId", HttpContext.Current.Session["franchiseid"].ToString()),
                new SqlParameter("@maxpayoutno", "0"),
                new SqlParameter("@FranType", "0"),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetFtranDetails");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Fid = dr["Fid"].ToString();
                data.Franchise_ID = dr["Franchise ID"].ToString();
                data.Franchise_Name = dr["Franchise Name"].ToString();
                data.Franchise_Type = dr["Franchise Type"].ToString();
                data.PAN = dr["PAN"].ToString();
                data.Bank = dr["Bank"].ToString();
                data.Account_No = dr["Account No"].ToString();
                data.IFSC_Code = dr["IFSC Code"].ToString();
                data.FPV = dr["FPV"].ToString();
                data.APV = dr["APV"].ToString();
                data.Commission_on_FPV = dr["Commission on FPV"].ToString();
                data.Commission_on_APV = dr["Commission on APV"].ToString();
                data.Stock_Value_as_on_5th_Day = dr["Stock Value as on 5th Day"].ToString();

                data.Opening_Amount = dr["Opening Amount"].ToString();
                data.Maintainance_Expenses = dr["Maintainance Expenses"].ToString();
                data.Offer_Income = dr["Offer Income"].ToString();
                data.Total_Commission = dr["Total Commission"].ToString();
                data.TDS = dr["TDS"].ToString();
                data.Dispatch_Amount = dr["Dispatch Amount"].ToString();
                data.FromDate = dr["FromDate"].ToString();
                data.ToDate = dr["ToDate"].ToString();
                data.PayoutNo = dr["PayoutNo"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Fid { get; set; }
        public string Franchise_ID { get; set; }
        public string Franchise_Name { get; set; }
        public string Franchise_Type { get; set; }
        public string PAN { get; set; }
        public string Bank { get; set; }
        public string Account_No { get; set; }
        public string IFSC_Code { get; set; }
        public string FPV { get; set; }
        public string APV { get; set; }
        public string Commission_on_FPV { get; set; }
        public string Commission_on_APV { get; set; }
        public string Stock_Value_as_on_5th_Day { get; set; }
        public string Opening_Amount { get; set; }
        public string Maintainance_Expenses { get; set; }
        public string Offer_Income { get; set; }
        public string Total_Commission { get; set; }
        public string TDS { get; set; }
        public string Dispatch_Amount { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string PayoutNo { get; set; }
    }

    #endregion


    //public void go()
    //{
    //    try
    //    {
    //        SqlParameter[] param = new SqlParameter[]
    //        {
    //          new SqlParameter("@maxpayoutno", "0"),
    //          new SqlParameter("@FranchiseId", Session["franchiseid"].ToString()),
    //          new SqlParameter("@FranType", "0")
    //        };

    //        DataTable dt = Dutil.GetDataTableSP(param, "GetFtranDetails");
    //        Session["dt"] = dt;
    //        if (dt.Rows.Count > 0)
    //        { 
    //            GridFranPayoutDetails.DataSource = dt;
    //            GridFranPayoutDetails.DataBind();
    //        }
    //        else
    //        {
    //            GridFranPayoutDetails.DataSource = null;
    //            GridFranPayoutDetails.DataBind();
    //        }
    //    }
    //    catch (Exception er)
    //    {

    //    }
    //}

    //protected void ibtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        dt = (DataTable)Session["dt"];
    //        /*=====================Remove Columns=====================*/

    //        if (dt.Rows.Count > 0)
    //        {
    //            Response.ClearContent();
    //            Response.Buffer = true;
    //            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "FranchisePayoutList.xls"));
    //            Response.ContentType = "application/ms-excel";
    //            string str = string.Empty;
    //            foreach (DataColumn dtcol in dt.Columns)
    //            {
    //                Response.Write(str + dtcol.ColumnName);
    //                str = "\t";
    //            }
    //            Response.Write("\n");
    //            foreach (DataRow dr in dt.Rows)
    //            {
    //                str = "";
    //                for (int j = 0; j < dt.Columns.Count; j++)
    //                {
    //                    Response.Write(str + Convert.ToString(dr[j]));
    //                    str = "\t";
    //                }
    //                Response.Write("\n");
    //            }
    //            Response.End();
    //        }
    //        else
    //        {
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found.');", true);
    //        }
    //    }
    //    catch (Exception er) { }

    //}
    //protected void ibtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        GridFranPayoutDetails.AllowPaging = false;

    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "FranchisePayoutList.doc");
    //        Response.ContentType = "application/vnd.ms-word";
    //        StringWriter stw = new StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        GridFranPayoutDetails.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();
    //    }
    //    catch (Exception er) { }
    //}

}