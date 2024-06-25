using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class secretadmin_ProductBatch : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand cmd;

    SqlDataAdapter sda = null;
    utility objutil = new utility();
    DataTable dt = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["franchiseid"] == null)
            {
                Response.Redirect("../Default.aspx");
            }
            //if (Session["admin"] == null)
            //{
            //    Response.Redirect("adminLog.aspx", false);
            //}
            if (!IsPostBack)
            {
                Bind();
            }
        }
        catch
        {

        }
    }

    public void Bind()
    {

        try
        {
            dt = new DataTable();
            con = new SqlConnection(method.str);
            sda = new SqlDataAdapter("franchisebatchactivation", con);
            sda.SelectCommand.CommandType = CommandType.StoredProcedure;
            sda.SelectCommand.Parameters.AddWithValue("@action", "bindall");
            sda.SelectCommand.Parameters.AddWithValue("@soldby", Session["franchiseid"].ToString());
            sda.SelectCommand.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            sda.Fill(dt);
            gridapprove.DataSource = dt;
            gridapprove.DataBind();



        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {



        }
    }

    protected void gridapprove_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if ((e.CommandName.Equals("P")) || (e.CommandName.Equals("A")))
        {

            try
            {
                GridViewRow row = gridapprove.Rows[Convert.ToInt32(e.CommandArgument)];
                LinkButton lnk = (LinkButton)row.FindControl("lnkactive");
                string lnktxt = lnk.Text;
                string pid = gridapprove.DataKeys[row.RowIndex].Values[0].ToString();
                string batchid = gridapprove.DataKeys[row.RowIndex].Values[1].ToString();
                string status = gridapprove.DataKeys[row.RowIndex].Values[2].ToString();
                //update(userid, e.CommandName);
                con = new SqlConnection(method.str);
                SqlCommand cmd = new SqlCommand("franchisebatchactivation", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@pid", Convert.ToInt32(pid));
                cmd.Parameters.AddWithValue("@action", "active");
                cmd.Parameters.AddWithValue("@soldby", Session["franchiseid"].ToString());
                cmd.Parameters.AddWithValue("@batchid", Convert.ToInt32(batchid));
                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                string msg = cmd.Parameters["@flag"].Value.ToString();

                if (msg == "1")
                {

                    utility.MessageBox(this, "Product Activated Successfully.");
                }
                if (msg == "2")
                {
                    utility.MessageBox(this, "Product Deactivated Successfully.");
                }

                else
                {
                    utility.MessageBox(this, msg);
                }

            }

            catch (Exception ex)
            {
                utility.MessageBox(this, ex.StackTrace);
            }

            finally
            {
                con.Close();
                Bind();
            }
        }

    }

    protected void gridapprove_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gridapprove.PageIndex = e.NewPageIndex;
        Bind();
    }

}