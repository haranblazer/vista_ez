using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_FranComDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.Date.AddDays(-10).ToString("dd/MM/yyyy");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

                //show();
            }
        }
        catch
        {

        }

    }




    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@FromDate", min),
                new SqlParameter("@ToDate", max)
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetFranchiseCommissionDetails");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();

                data.Invoive_Number = dr["Invoive Number"].ToString();
                data.Date = dr["Date"].ToString();
                data.FPV = dr["FPV"].ToString();
                data.APV = dr["APV"].ToString();
                data.Commission_on_FPV = dr["Commission on FPV"].ToString();
                data.Commission_on_APV = dr["Commission on APV"].ToString();
                data.FranchiseType = dr["FranchiseType"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Invoive_Number { get; set; }
        public string Date { get; set; }
        public string FPV { get; set; }
        public string APV { get; set; }
        public string Commission_on_FPV { get; set; }
        public string Commission_on_APV { get; set; }
        public string FranchiseType { get; set; }

    }

    #endregion



    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    show();
    //}


    //public void show()
    //{
    //    System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //    dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //    DateTime fromDate = new DateTime();
    //    DateTime toDate = new DateTime();
    //    try
    //    {
    //        fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
    //        toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
    //    }
    //    catch
    //    {
    //        utility.MessageBox(this, "Invalid date entry.");
    //        return;
    //    }

    //    SqlParameter[] param = new SqlParameter[]
    //    {
    //        new SqlParameter("@FromDate", fromDate),
    //        new SqlParameter("@ToDate", toDate),
    //    };
    //    DataUtility obj_du = new DataUtility();
    //    DataTable dt = obj_du.GetDataTableSP(param, "GetFranchiseCommissionDetails");
    //    Session["dt"] = dt;
    //    if (dt.Rows.Count > 0)
    //    {
    //        GridView1.DataSource = dt;
    //        GridView1.DataBind();
    //    }
    //    else
    //    {
    //        GridView1.DataSource = null;
    //        GridView1.DataBind();
    //    }
    //}


    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    show();
    //}


    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        dt = (DataTable)Session["dt"];

    //        if (dt.Rows.Count > 0)
    //        {

    //            Response.ClearContent();
    //            Response.Buffer = true;
    //            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "FranComDetails.xls"));
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


}