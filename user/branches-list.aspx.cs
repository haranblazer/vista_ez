using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class user_branches_list : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = new DataTable();
    SqlCommand cmd;
    SqlDataAdapter adp;
    string fid = null;
    utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindState();
            Bind_FranchiseTypeEdit();
            BindGrid();
        }
    }


    private void BindGrid()
    {
        adp = new SqlDataAdapter();
        try
        {
            adp = new SqlDataAdapter("GetFran_ForUser", con);
            adp.SelectCommand.CommandType = CommandType.StoredProcedure;
            adp.SelectCommand.Parameters.AddWithValue("@Name", string.IsNullOrEmpty(txtSearch.Text.Trim()) == true ? null : txtSearch.Text.Trim());
            adp.SelectCommand.Parameters.AddWithValue("@State", ddl_State.SelectedItem.ToString() == "Select State" ? "" : ddl_State.SelectedItem.ToString());
            adp.SelectCommand.Parameters.AddWithValue("@FranType", ddl_Type.SelectedValue);
            adp.Fill(dt);
            Session["dt"] = dt;

            if (dt.Rows.Count > 0)
            {
                lblCount.Text = "No of Records :" + dt.Rows.Count.ToString();
                GridView1.PageSize = ddPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddPageSize.SelectedValue.ToString());
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }


        catch (Exception er)
        {
        }
        finally
        {
            con.Close();

        }

    }
    protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {

        BindGrid();
    }
    protected void ddSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {

        try
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Session["dt"];
            dt.Columns.Remove("Status");
            dt.Columns.Remove("DPWithTax");
            if (dt.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "_FranchiseList.xls"));
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


        //if (GridView1.Rows.Count > 0)
        //    {
        //        GridView1.AllowPaging = false;
        //        BindGrid();
        //       // GridView1.Columns[6].Visible = GridView1.Columns[7].Visible = GridView1.Columns[8].Visible = GridView1.Columns[9].Visible = false;
        //        Response.ClearContent();
        //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_FranchiseList.xls");
        //        Response.ContentType = "application/vnd.xls";
        //        System.IO.StringWriter stw = new System.IO.StringWriter();
        //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
        //        GridView1.RenderControl(htextw);
        //        Response.Write(stw.ToString());
        //        Response.End();

        //    }
        //    else
        //        utility.MessageBox(this, "can not export as no data found !");
         
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {

        
            if (GridView1.Rows.Count > 0)
            {
                GridView1.AllowPaging = false;
                BindGrid();
                GridView1.Columns[6].Visible = GridView1.Columns[7].Visible = GridView1.Columns[8].Visible = GridView1.Columns[9].Visible = false;
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_FranchiseList.doc");
                Response.ContentType = "application/vnd.ms-word";
                System.IO.StringWriter stw = new System.IO.StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                GridView1.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();

            }
            else
                utility.MessageBox(this, "can not export as no data found !");
         
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    private void Bind_FranchiseTypeEdit()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select Frantype=UserVal, Item_Desc from Item_Collection where IsActive=1 and ItemId=4 and UserVal not in (1, 2, 6, 7, 8, 9, 10)");
        if (dt.Rows.Count > 0)
        {
            ddl_Type.DataSource = dt;
            ddl_Type.DataTextField = "Item_Desc";
            ddl_Type.DataValueField = "Frantype";
            ddl_Type.DataBind();
            ddl_Type.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Type", "-1"));
        }
        else
        {
            ddl_Type.Items.Clear();
            ddl_Type.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Type", "-1"));
        }
    }


    public void BindState()
    {
        DataUtility objDUT = new DataUtility();
        DataTable dt = new DataTable();
        SqlParameter[] sqlparam = new SqlParameter[] {
            };
        dt = objDUT.GetDataTable(sqlparam, "GetState");

        if (dt.Rows.Count > 0)
        {
            ddl_State.Items.Clear();
            ddl_State.DataSource = dt;
            ddl_State.DataTextField = "StateName";
            ddl_State.DataValueField = "Id";
            ddl_State.DataBind();
            ddl_State.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select State", ""));
        }

    }


}