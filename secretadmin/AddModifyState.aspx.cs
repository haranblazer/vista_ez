using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;

public partial class secretadmin_AddModifyState : System.Web.UI.Page
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

            BindState();
        }
    }
    public void BindState()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetState", con);
            com.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count >= 1)
            {
                divState.InnerText = string.Empty;
                foreach (DataRow drw in dt.Rows)
                {
                    divState.InnerText += drw["statename"].ToString() + ",";
                }
                GridState.DataSource = dt;
                GridState.DataBind();
            }
            else
            {
                GridState.DataSource = null;
                GridState.DataBind();
            }
        }
        catch (Exception er)
        {

        }

    }

    protected void btnAddstate_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(txtStateNo.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter state no.");
                txtStateNo.Focus();
                return;
            }
            if (string.IsNullOrEmpty(txtStateCode.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter state code.");
                txtStateCode.Focus();
                return;
            }
            if (!string.IsNullOrEmpty(txtAddState.Text.Trim()))
            {
                if (val.IsAlphabets(txtAddState.Text.Trim()))
                {
                    if (btnAddstate.Text == "ADD")
                    {
                        con = new SqlConnection(method.str);
                        com = new SqlCommand("AddState", con);
                        com.CommandType = CommandType.StoredProcedure;
                        com.Parameters.AddWithValue("@statename", txtAddState.Text.Trim());
                        com.Parameters.AddWithValue("@stateno", txtStateNo.Text.Trim());
                        com.Parameters.AddWithValue("@statecode", txtStateCode.Text.Trim());
                        com.Parameters.Add("@msg", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                        con.Open();
                        com.ExecuteNonQuery();
                        string msg = com.Parameters["@msg"].Value.ToString();
                        utility.MessageBox(this, msg);
                        txtAddState.Text = string.Empty;
                        txtStateNo.Text = string.Empty;
                        txtStateCode.Text = string.Empty;
                        BindState();
                        con.Close();

                    }
                    else
                    {
                        con = new SqlConnection(method.str);
                        com = new SqlCommand("UpdateState", con);
                        com.CommandType = CommandType.StoredProcedure;
                        com.Parameters.AddWithValue("@srno", Session["srno"].ToString());
                        com.Parameters.AddWithValue("@statename", txtAddState.Text.Trim());
                        com.Parameters.AddWithValue("@stateno", txtStateNo.Text.Trim());
                        com.Parameters.AddWithValue("@statecode", txtStateCode.Text.Trim());
                        com.Parameters.Add("@msg", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;

                        con.Open();
                        com.ExecuteNonQuery();
                        string msg = com.Parameters["@msg"].Value.ToString();
                        //utility.MessageBox(this, "State Updated Successfully.");
                        utility.MessageBox(this, msg);

                        txtAddState.Text = string.Empty;
                        txtStateNo.Text = string.Empty;
                        txtStateCode.Text = string.Empty;
                        BindState();
                        btnAddstate.Text = "ADD";
                        con.Close();

                    }
                }
                else
                {
                    utility.MessageBox(this, "Only Alphabets are allowed in state name.");
                    txtAddState.Focus();
                    return;
                }
            }
            else
            {
                utility.MessageBox(this, "Please enter state name.");
                txtAddState.Focus();
                return;
            }
        }
        catch
        {

        }
    }

    protected void ddl_Region_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DropDownList ddlcouse = (DropDownList)sender;
        GridViewRow row = (GridViewRow)ddlcouse.NamingContainer;
        DropDownList ddl_Region = (DropDownList)row.FindControl("ddl_Region");

        HiddenField hnd_ID = (HiddenField)row.FindControl("hnd_ID");

        SqlParameter[] param1 = new SqlParameter[]
        {
            new SqlParameter("@ID", hnd_ID.Value)
        };
        DataUtility objDu = new DataUtility();
        int Result = objDu.ExecuteSql(param1, "Update Stategstmst set RId=" + ddl_Region.SelectedValue + " where ID=@ID");

        BindState();
        }
        catch (Exception er)
        {
        }
    }

    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;

        string srno = GridState.DataKeys[gvrow.RowIndex].Value.ToString();
        Session["srno"] = srno.ToString();
        txtAddState.Text = gvrow.Cells[2].Text;
        txtStateNo.Text = gvrow.Cells[3].Text;
        txtStateCode.Text = gvrow.Cells[4].Text;
        btnAddstate.Text = "UPDATE";


    }
    protected void GridState_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridState.PageIndex = e.NewPageIndex;
        BindState();
    }

    protected void GridState_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hnd_RId = (HiddenField)e.Row.FindControl("hnd_RId");

            DropDownList ddl_Region = (DropDownList)e.Row.FindControl("ddl_Region");
            try
            {
                DataUtility objDu = new DataUtility();
                DataTable dt = objDu.GetDataTable("Select RId, Region from RegionMst where Isactive=1");
                if (dt.Rows.Count > 0)
                {
                    ddl_Region.DataSource = dt;
                    ddl_Region.DataTextField = "Region";
                    ddl_Region.DataValueField = "RId";
                    ddl_Region.DataBind();
                    ddl_Region.Items.Insert(0, new ListItem("Select", "0"));
                    DataRowView dr = e.Row.DataItem as DataRowView;
                    ddl_Region.SelectedValue = hnd_RId.Value;

                }
            }
            catch (Exception er)
            {
            }

        }
    }
}
