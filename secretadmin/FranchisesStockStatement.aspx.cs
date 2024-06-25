using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_FranchisesStockStatement : System.Web.UI.Page
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

        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.AddMonths(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(0).ToString("dd-MM-yyyy").Replace("-", "/");

            Bind_FranchiseType();
            //BindGrid();
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string FranType, string FranchiseID)
    {
        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@FranType", FranType),
                new SqlParameter("@FranchiseID", FranchiseID)
            };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetFranStockStatement");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Franchise_ID = dr["Franchise ID"].ToString();
                data.Franchise_Name = dr["Franchise Name"].ToString();
                data.State = dr["State"].ToString();
                data.District = dr["District"].ToString();
                data.Mobile_No = dr["Mobile No"].ToString();

                data.Type = dr["Type"].ToString();
                data.DPValue = dr["DPValue"].ToString();
                data.GSTValue = dr["GSTValue"].ToString();
                data.AssociateValue = dr["AssociateValue"].ToString();
                data.RPV = dr["RPV"].ToString();
                data.TPV = dr["TPV"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Franchise_ID { get; set; }
        public string Franchise_Name { get; set; }
        public string State { get; set; }
        public string District { get; set; }
        public string Mobile_No { get; set; }
        public string Type { get; set; }
        public string DPValue { get; set; }
        public string GSTValue { get; set; }
        public string AssociateValue { get; set; }
        public string RPV { get; set; }
        public string TPV { get; set; }

    }





    private void Bind_FranchiseType()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4 and UserVal in (2,3,4,5,6)");
        if (dt.Rows.Count > 0)
        {
            ddltype.DataSource = dt;
            ddltype.DataTextField = "Item_Desc";
            ddltype.DataValueField = "Frantype";
            ddltype.DataBind();
            ddltype.Items.Insert(0, new ListItem("All", "-1"));
        }
        else
        {
            ddltype.Items.Clear();
            ddltype.Items.Insert(0, new ListItem("All", "-1"));
        }
    }
    #endregion


    //protected void btn_Search_Click(object sender, EventArgs e)
    //{
    //    BindGrid();
    //}
    //private void BindGrid()
    //{
    //    try
    //    {
    //        String fromDate = "", toDate = "";
    //        try
    //        {
    //            if (txtFromDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //            if (txtToDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid date entry2.");
    //            return;
    //        }

    //        DataUtility objDu = new DataUtility();
    //        SqlParameter[] param = new SqlParameter[]
    //        {new SqlParameter("@min", fromDate),
    //          new SqlParameter("@max", toDate),
    //          new SqlParameter("@FranType", ddltype.SelectedValue),
    //          new SqlParameter("@FranchiseID", txt_userid.Text.Trim())
    //        };
    //        DataTable dt = objDu.GetDataTableSP(param, "GetFranStockStatement");
    //        Session["dt"] = dt;
    //        if (dt.Rows.Count > 0)
    //        {
    //            GridView1.Columns[1].FooterText = "Total: " + dt.Rows.Count.ToString();
    //            GridView1.Columns[7].FooterText = dt.Compute("sum([DPValue])", "true").ToString();
    //            GridView1.Columns[8].FooterText = dt.Compute("sum([GSTValue])", "true").ToString();
    //            GridView1.Columns[9].FooterText = dt.Compute("sum([AssociateValue])", "true").ToString();
    //            GridView1.Columns[10].FooterText = dt.Compute("sum([RPV])", "true").ToString();
    //            GridView1.Columns[11].FooterText = dt.Compute("sum([TPV])", "true").ToString();

    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        string Error = ex.Message;
    //    }
    //}
    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindGrid();
    //}



    //protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    //{
    //    GridView1.EditIndex = -1;
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
    //            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "StockStatement.xls"));
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
    //protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        if (GridView1.Rows.Count > 0)
    //        {
    //            GridView1.AllowPaging = false;
    //            BindGrid();
    //            Response.ClearContent();
    //            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "StockStatement.doc");
    //            Response.ContentType = "application/vnd.ms-word";
    //            System.IO.StringWriter stw = new System.IO.StringWriter();
    //            HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //            this.GridView1.RenderControl(htextw);
    //            Response.Write(stw.ToString());
    //            Response.End();

    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "can not export as no data found !");
    //        }
    //    }
    //    catch
    //    {

    //    }
    //}


}