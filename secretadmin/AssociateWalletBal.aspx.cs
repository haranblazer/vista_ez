using System;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class secretadmin_AssociateWalletBal : System.Web.UI.Page
{

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

    }




    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlDataReader dr = objDu.GetDataReaderSP("Get_AssociateWalletBalances");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.UserId = dr["UserId"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.G_Wallet = dr["G_Wallet"].ToString();
                data.T_Wallet = dr["T_Wallet"].ToString();
                data.R_Wallet = dr["R_Wallet"].ToString();
                data.TF_Wallet = dr["TF_Wallet"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string UserId { get; set; }
        public string UserName { get; set; }
        public string G_Wallet { get; set; }
        public string T_Wallet { get; set; }
        public string R_Wallet { get; set; }
        public string TF_Wallet { get; set; }
    }
 
    #endregion



    //public void Binddata()
    //{
    //    try
    //    {
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTableSP("Get_AssociateWalletBalances");
    //        ViewState["dt"] = dt;
    //        if (dt.Rows.Count > 0)
    //        {
    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();
    //        }
    //        else
    //        {
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    { }
    //}


    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        if (ViewState["dt"] != null)
    //            dt = (DataTable)ViewState["dt"];


    //        if (dt.Rows.Count > 0)
    //        {
    //            Response.ClearContent();
    //            Response.Buffer = true;
    //            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Asso_WalletBal.xls"));
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