using System;
using System.Collections.Generic; 
using System.Data.SqlClient; 

public partial class secretadmin_TotalBalance : System.Web.UI.Page
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
             
        }
        catch { } 
    }




    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        { 
            SqlDataReader dr = objDu.GetDataReaderSP("Monitoring_Balanace");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails(); 
                data.Name = dr["Name"].ToString();
                data.Points = dr["Points"].ToString();
                data.IsLink = dr["IsLink"].ToString();
                data.LinkName = dr["LinkName"].ToString();
                
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Name { get; set; }
        public string Points { get; set; }
        public string IsLink { get; set; }
        public string LinkName { get; set; }
        
    }

     
    #endregion



    //public void Binddata()
    //{
    //    try
    //    {
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTableSP("Monitoring_Balanace");
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


    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //    try
    //    {
    //        if (e.CommandName.Equals("Details"))
    //        {
    //            String IsLink = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
    //            String LinkName = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
    //            if (IsLink == "1")
    //                Response.Redirect("~/secretadmin/WalletDetails.aspx?Id=" + LinkName);
    //            else
    //                utility.MessageBox(this, "Invalied Url. Please try another.");
    //        }


    //    }
    //    catch (Exception ex)
    //    {
    //        utility.MessageBox(this, ex.ToString());
    //    }

    //}



    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{

    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        if (ViewState["dt"] != null)
    //        {
    //            dt = (DataTable)ViewState["dt"];

    //            dt.Columns.Remove("IsLink");
    //            dt.Columns.Remove("LinkName");
    //        }


    //        if (dt.Rows.Count > 0)
    //        {
    //            Response.ClearContent();
    //            Response.Buffer = true;
    //            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "TotalBal.xls"));
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