using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;

public partial class admin_DocsApprove : System.Web.UI.Page
{
    SqlConnection con = null;
    utility objutil = new utility();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Bind();
        }

    }
    public void Bind()
    {

        try
        {

            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("docapprovedlist", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", "");
            cmd.Parameters.AddWithValue("@action", "");
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridDocsApprove.DataSource = dt;

            GridDocsApprove.DataBind();


        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            con.Close();
            con.Dispose();

        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }


    //protected void GridDocsApprove_RowEditing(object sender, GridViewEditEventArgs e)
    //{
    //    GridDocsApprove.EditIndex = e.NewEditIndex;
    //    Bind();
    //}
    //protected void GridDocsApprove_RowUpdating(object sender, GridViewUpdateEventArgs e)
    //{
    //    GridViewRow gv = (GridViewRow)GridDocsApprove.Rows[e.RowIndex];
    //   TextBox txtid = ((TextBox)GridDocsApprove.Rows[e.RowIndex].Cells[1].Controls[0]);
    //    TextBox txtbname = ((TextBox)GridDocsApprove.Rows[e.RowIndex].Cells[2].Controls[0]);

    //    TextBox txtacname = ((TextBox)GridDocsApprove.Rows[e.RowIndex].Cells[3].Controls[0]);

    //    TextBox txtacno = ((TextBox)GridDocsApprove.Rows[e.RowIndex].Cells[4].Controls[0]);

    //    TextBox txtbranch = ((TextBox)GridDocsApprove.Rows[e.RowIndex].Cells[5].Controls[0]);

    //    TextBox txtifsc = ((TextBox)GridDocsApprove.Rows[e.RowIndex].Cells[6].Controls[0]);

    //    TextBox txtpanno = ((TextBox)GridDocsApprove.Rows[e.RowIndex].Cells[8].Controls[0]);

    //    con = new SqlConnection(method.str);
    //    SqlCommand cmd = new SqlCommand("updatedocscan", con);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.AddWithValue("@id", txtid.Text);
    //    cmd.Parameters.AddWithValue("@actype", txtacname.Text);
    //    cmd.Parameters.AddWithValue("@acno", txtacno.Text);
    //    cmd.Parameters.AddWithValue("@branch",txtbranch.Text);
    //    cmd.Parameters.AddWithValue("@bname", txtbname.Text);
    //    cmd.Parameters.AddWithValue("@ifsc",txtifsc.Text);
    //    cmd.Parameters.AddWithValue("@panno",txtpanno.Text);
    //    con.Open();
    //    cmd.ExecuteNonQuery();
    //    con.Close();
    //    utility.MessageBox(this, "Data Updated Successfully");          

    //    GridDocsApprove.EditIndex = -1;
    //    Bind();
    //}
    //protected void GridDocsApprove_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    //{
    //    e.Cancel = true;
    //    GridDocsApprove.EditIndex = -1;
    //    Bind();
    //}
    protected void GridDocsApprove_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if ((e.CommandName.Equals("P")) || (e.CommandName.Equals("A")))
        {


            GridViewRow row = GridDocsApprove.Rows[Convert.ToInt32(e.CommandArgument)];
            string userid = GridDocsApprove.DataKeys[row.RowIndex].Values[0].ToString();
            //update(userid, e.CommandName);

            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("updatedoc", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@regno", userid);
            cmd.Parameters.AddWithValue("@action", e.CommandName);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            if (e.CommandName.Equals("P"))
            {
                utility.MessageBox(this, "Pan Approved Successfully");
            }

            if (e.CommandName.Equals("A"))
            {
                utility.MessageBox(this, "Address Approved Successfully");
            }

            Bind();
        }





    }
    protected void GridDocsApprove_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GridDocsApprove_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridDocsApprove.PageIndex = e.NewPageIndex;
        Bind();

    }
    protected void lnkPANReject_Click(object sender, EventArgs e)
    {
        string username, userid, mobileno, text = string.Empty;
        try
        {
            GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;

            Label lblid = (Label)gvrow.FindControl("lblId");
            string id = lblid.Text.Trim();

            userid = gvrow.Cells[1].Text;
            username = gvrow.Cells[3].Text;
            mobileno = gvrow.Cells[4].Text;
            text = "Dear " + userid + "," + " " + "Name- " + username + " " + "your pan image has been rejected. Please upload fresh PAN Image.";
            Image panimg = (Image)gvrow.FindControl("PANImage");
            string path = Server.MapPath(panimg.ImageUrl);
            FileInfo info = new FileInfo(path);
            if (info.Exists)
            {
                info.Delete();
            }
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("PANRejection", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Bind();
            objutil.sendSMSByPage(mobileno.Trim(), text.Trim());
            utility.MessageBox(this, "PAN Image Rejected Successfully.");
        }
        catch
        {

        }
    }
    protected void lnkAddressReject_Click(object sender, EventArgs e)
    {
        string username, userid, mobileno, text = string.Empty;
        try
        {
            GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;

            Label lblid = (Label)gvrow.FindControl("lblId");
            string id = lblid.Text.Trim();

            userid = gvrow.Cells[1].Text;
            username = gvrow.Cells[3].Text;
            mobileno = gvrow.Cells[4].Text;
            text = "Dear " + userid + "," + " " + "Name- " + username + " " + "your address image has been rejected. Please upload fresh address Image.";
            Image addressimg = (Image)gvrow.FindControl("AddressImage");
            string path = Server.MapPath(addressimg.ImageUrl);
            FileInfo info = new FileInfo(path);
            if (info.Exists)
            {
                info.Delete();
            }
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("AddressRejection", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Bind();
            objutil.sendSMSByPage(mobileno.Trim(), text.Trim());
            utility.MessageBox(this, "Address Image Rejected Successfully.");

        }
        catch
        {

        }
    }
}
