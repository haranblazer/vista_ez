using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;

public partial class secretadmin_BankApprove : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    DataTable dt = new DataTable();
    SqlDataAdapter da;
    utility objutil = new utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindBankDetails();
        }
    }
    protected void lnkApprove_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;
            string id = GridView1.DataKeys[gvrow.RowIndex].Value.ToString();


            SqlCommand cmd = new SqlCommand("UpdateBankStatus", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            BindBankDetails();
            utility.MessageBox(this, "Bank Approved Successfully.");
        }
        catch
        {

        }



    }

    public void BindBankDetails()
    {
        try
        {
            cmd = new SqlCommand("GetBankDtails", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {


                GridView1.DataSource = dt;
                GridView1.DataBind();

            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void lnkReject_Click(object sender, EventArgs e)
    {
        string username, userid, mobileno, text = string.Empty;
        try
        {
            GridViewRow gvrow = (GridViewRow)((LinkButton)sender).NamingContainer;
            string id = GridView1.DataKeys[gvrow.RowIndex].Value.ToString();
            userid = gvrow.Cells[2].Text;
            username = gvrow.Cells[3].Text;
            Label lblmob = (Label)gvrow.FindControl("lblMobile");
            mobileno = lblmob.Text.Trim();
            text = "Dear " + userid + "," + " Name- " + username + " " + "your bank image has been rejected. Please upload fresh bank Image.";
            Image img = (Image)gvrow.FindControl("img");
            string path = Server.MapPath(img.ImageUrl);
            FileInfo info = new FileInfo(path);
            if (info.Exists)
            {
                info.Delete();
            }
            SqlCommand cmd = new SqlCommand("BankRejection", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            BindBankDetails();
            objutil.sendSMSByPage(mobileno.Trim(), text.Trim());
            utility.MessageBox(this, "Bank Image Rejected Successfully.");

        }
        catch
        {

        }

    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        BindBankDetails();
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindBankDetails();
    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        BindBankDetails();
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

        string accno, acctype, bname, brnch, ifc = string.Empty;
        try
        {

            int userid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
            GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];

            TextBox acno = (TextBox)row.Cells[4].Controls[0];
            DropDownList actype = (DropDownList)row.FindControl("ddlAcType");
            DropDownList ddlbankname = (DropDownList)row.FindControl("ddlBankname");
            TextBox branch = (TextBox)row.Cells[7].Controls[0];
            TextBox ifsc = (TextBox)row.Cells[8].Controls[0];
            accno = acno.Text.Trim();
            acctype = actype.SelectedItem.Text.Trim();
            bname = ddlbankname.SelectedItem.Text.ToString();
            brnch = branch.Text.Trim();
            ifc = ifsc.Text.Trim();
            cmd = new SqlCommand("UspBankDetails", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", userid);
            cmd.Parameters.AddWithValue("@acno", accno);
            cmd.Parameters.AddWithValue("@actype", acctype);
            cmd.Parameters.AddWithValue("@bname", bname);
            cmd.Parameters.AddWithValue("@branch", brnch);
            cmd.Parameters.AddWithValue("@ifsc", ifc);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            utility.MessageBox(this, "Edited Successfully.");
            GridView1.EditIndex = -1;
            BindBankDetails();


        }
        catch
        {

        }

    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                DropDownList ddlbank = (e.Row.FindControl("ddlBankname") as DropDownList);
                DropDownList ddltype = (e.Row.FindControl("ddlAcType") as DropDownList);
                cmd = new SqlCommand("GetBank", con);
                cmd.CommandType = CommandType.StoredProcedure;
                da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlbank.DataSource = dt;
                ddlbank.DataTextField = "BankName";
                ddlbank.DataValueField = "SrNo";
                ddlbank.DataBind();
                string bankname = (e.Row.FindControl("lblBankName") as Label).Text;
                ddlbank.SelectedIndex = ddlbank.Items.IndexOf(ddlbank.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, bankname, true) == 0).FirstOrDefault());
                string Actype = (e.Row.FindControl("lblAcType") as Label).Text;
                ddltype.SelectedIndex = ddltype.Items.IndexOf(ddltype.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, Actype, true) == 0).FirstOrDefault());
            }
        }
        catch
        {

        }
    }
}