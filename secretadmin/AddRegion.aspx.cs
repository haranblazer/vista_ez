using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;

public partial class secretadmin_AddRegion : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand com;
    SqlDataAdapter da;
    Validation val = new Validation();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
            Response.Redirect("adminLog.aspx", false);
        if (!Page.IsPostBack)
        {

            BindRegion();
        }
    }
    public void BindRegion()
    {
        try
        {
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable("Select RId, Region, Isactive from RegionMst");
            if (dt.Rows.Count > 0)
            {

                GridRegion.DataSource = dt;
                GridRegion.DataBind();
            }
            else
            {
                GridRegion.DataSource = null;
                GridRegion.DataBind();
            }
        }
        catch (Exception er)
        {

        }

    }

    protected void btnAddRegion_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(txtAddRegion.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter region.");
                txtAddRegion.Focus();
                return;
            }

            if (!string.IsNullOrEmpty(txtAddRegion.Text.Trim()))
            {
                string RId = "0";
                if (btnAddRegion.Text != "ADD")
                {
                    RId = Session["RId"].ToString();
                }

                con = new SqlConnection(method.str);
                com = new SqlCommand("AddRegion", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@RId", RId);
                com.Parameters.AddWithValue("@Region", txtAddRegion.Text.Trim());
                com.Parameters.Add("@msg", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string msg = com.Parameters["@msg"].Value.ToString();
                utility.MessageBox(this, msg);
                txtAddRegion.Text = string.Empty;

                BindRegion();
                con.Close();
            }
            else
            {
                utility.MessageBox(this, "Please enter state name.");
                txtAddRegion.Focus();
                return;
            }
        }
        catch
        {

        }
    }


    protected void lnkEdit_Click(object sender, EventArgs e)
    {
       
    }

    protected void GridRegion_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            GridViewRow row = GridRegion.Rows[Convert.ToInt32(e.CommandArgument)];
            String RId = GridRegion.DataKeys[row.RowIndex].Values[0].ToString();
            if (e.CommandName.Equals("Isactive"))
            {
                SqlParameter[] param1 = new SqlParameter[]
                {
                    new SqlParameter("@RId", RId)
                };
                DataUtility objDu = new DataUtility();
                int Result = objDu.ExecuteSql(param1, "Update RegionMst set Isactive=(Case isnull(Isactive,0) when 0 then 1 else 0 End) where RId=@RId");
                BindRegion();
            }
            if (e.CommandName.Equals("Edits"))
            {
                HiddenField hnd_Region = (HiddenField)row.FindControl("hnd_Region");
                Session["RId"] = RId.ToString();
                txtAddRegion.Text = hnd_Region.Value;
                btnAddRegion.Text = "UPDATE";
            }
 
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }

    }

    protected void GridView1_RowUpdating(object sender, GridViewEditEventArgs e)
    {
        // Write here code for edit Rows 
    }

    protected void GridRegion_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {

    }
}