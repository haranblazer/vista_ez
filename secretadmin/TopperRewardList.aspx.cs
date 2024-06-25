using System;
 
using System.Data;
using System.Data.SqlClient;
 
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class secretadmin_TopperRewardList : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    utility objutil;
    XmlDocument xmldoc = new XmlDocument();
    DataUtility objDUT = null;
    
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
            txtFromDate.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");
            BindRewardRank();
            BindGrid();
        }
    }
    
    private void BindGrid()
    {
        try
        {
            String fromDate = "", toDate = "";
            try
            {
                if (txtFromDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
                if (txtToDate.Text.Trim().Length > 0)
                {
                    String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
            }
            catch
            {
                utility.MessageBox(this, "Invalid date entry2.");
                return;
            }
             

            con = new SqlConnection(method.str);
            SqlDataAdapter ad = new SqlDataAdapter("GetTopperRewardList", con);
            ad.SelectCommand.CommandType = CommandType.StoredProcedure;
            ad.SelectCommand.Parameters.AddWithValue("@min", fromDate);
            ad.SelectCommand.Parameters.AddWithValue("@max", toDate);
            ad.SelectCommand.Parameters.AddWithValue("@Userid", ddl_Userid.Text.Trim());
            ad.SelectCommand.Parameters.AddWithValue("@IsGiven", ddl_IsGiven.SelectedValue);
            ad.SelectCommand.Parameters.AddWithValue("@IsElegible", ddl_Status.SelectedValue);
            ad.SelectCommand.Parameters.AddWithValue("@RankId", ddl_RewardRank.SelectedValue);
            
            dt = new DataTable();
            ad.Fill(dt);
             
            Session["dt"] = dt;
            GridView1.Columns[16].FooterText = "Total: " + dt.Rows.Count.ToString();
            GridView1.Columns[17].FooterText = (string.IsNullOrEmpty(dt.Compute("sum([Payout Generated])", "true").ToString()) ? "0.00" : dt.Compute("sum([Payout Generated])", "true").ToString());
            GridView1.Columns[18].FooterText = (string.IsNullOrEmpty(dt.Compute("sum(TDS)", "true").ToString()) ? "0.00" : dt.Compute("sum(TDS)", "true").ToString());
            GridView1.Columns[19].FooterText = (string.IsNullOrEmpty(dt.Compute("sum([PC Charges])", "true").ToString()) ? "0.00" : dt.Compute("sum([PC Charges])", "true").ToString());
            GridView1.Columns[20].FooterText = (string.IsNullOrEmpty(dt.Compute("sum([Net Payut])", "true").ToString()) ? "0.00" : dt.Compute("sum([Net Payut])", "true").ToString());
            GridView1.Columns[21].FooterText = (string.IsNullOrEmpty(dt.Compute("sum([Dispatch Amount])", "true").ToString()) ? "0.00" : dt.Compute("sum([Dispatch Amount])", "true").ToString()); 
            GridView1.DataSource = dt;
            GridView1.DataBind();

        }
        catch (Exception ex)
        {
            string Error = ex.Message;
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    public void BindRewardRank()
    {

        SqlParameter[] param1 = new SqlParameter[] { };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(param1, "Select LevelId, RankName from BinarySlab");
        if (dt.Rows.Count > 0)
        {
            ddl_RewardRank.Items.Clear();
            ddl_RewardRank.DataSource = dt;
            ddl_RewardRank.DataTextField = "RankName";
            ddl_RewardRank.DataValueField = "LevelId";
            ddl_RewardRank.DataBind();
            ddl_RewardRank.Items.Insert(0, new ListItem("All", "-1"));
        }
    }



    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
        try
        {
            
            if (e.CommandName == "update")
            {
               string invoiceno = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
                 
            }

        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }
        finally
        {
            BindGrid();
        }

    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    { }

    
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {

        try
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Session["dt"];
            dt.Columns.Remove("srno");

            if (dt.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "TopperReward.xls"));
                Response.ContentType = "application/ms-excel";
                string str = string.Empty;
                foreach (DataColumn dtcol in dt.Columns)
                {
                    Response.Write(str + dtcol.ColumnName);
                    str = "\t";
                }
                Response.Write("\n");
                foreach (DataRow dr in dt.Rows)
                {
                    str = "";
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Response.Write(str + Convert.ToString(dr[j]));
                        str = "\t";
                    }
                    Response.Write("\n");
                }
                Response.End();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found.');", true);
            }
        }
        catch (Exception er) { }
         
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                BindGrid();
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "TopperReward.doc");
                Response.ContentType = "application/vnd.ms-word";
                System.IO.StringWriter stw = new System.IO.StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                this.GridView1.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();

            }
            else
            {
                utility.MessageBox(this, "can not export as no data found !");
            }
        }
        catch
        {

        }
    }
}