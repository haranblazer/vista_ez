using System;
using System.Data; 
using System.Web.UI;
using System.Web.UI.WebControls; 
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic; 
public partial class secureadmin_LockAdmin : System.Web.UI.Page
{

    DataTable dt = new DataTable();
    SqlConnection con = new SqlConnection(method.str);
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

            InsertFunction.CheckSuperAdminlogin();

            if (!IsPostBack)
            {
                BindRole();
                BindGrid();
            }

        }
        catch (Exception er)
        {

        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
    }

    private void BindGrid()
    {
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
            new SqlParameter("@username", txt_Username.Text.Trim()),
            new SqlParameter("@name", txt_Name.Text.Trim()),
            new SqlParameter("@mobileno", txt_Mobile.Text.Trim()),
            new SqlParameter("@RoleId", ddl_UserRole.SelectedValue)
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "fetchAdmin");
            if (dt.Rows.Count > 0)
            {
                utility objutil = new utility();
                DataColumn PWD = new DataColumn("PWD", typeof(string));
                dt.Columns.Add(PWD);

                foreach (DataRow row in dt.Rows)
                {
                    DataRow dr = row;
                    string Pwd = objutil.base64Decode(row["PASSWORD"].ToString());
                    row.SetField("PWD", Pwd.Substring(0, 3) + "***");
                    row.SetField("password", Pwd);
                } 
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
        catch (Exception ex) { }
    }


    public void BindRole()
    { 
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select UserVal, Item_Desc from item_collection where ItemId=6");
        if (dt.Rows.Count > 0)
        {
            ddl_UserRole.Items.Clear();
            ddl_UserRole.DataSource = dt;
            ddl_UserRole.DataTextField = "Item_Desc";
            ddl_UserRole.DataValueField = "UserVal";
            ddl_UserRole.DataBind();
            ddl_UserRole.Items.Insert(0, new ListItem("All", "0"));
        }
    }


    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            string username = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
            string name = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
            string password = GridView1.DataKeys[row.RowIndex].Values[2].ToString();
            string mobileno = GridView1.DataKeys[row.RowIndex].Values[3].ToString();

            if (e.CommandName.Equals("Send"))
            {
                utility objUtil = new utility();
                string Text_Msg = "";
                if (name.Length > 20)
                    name = name.Substring(0, 20).ToString();
                Text_Msg = "Dear " + name + " ID No " + username + " Your Password : " + password;

                objUtil.sendSMSByBilling(mobileno, Text_Msg, "FORGETPASSWORD");


                var Msg = "Dear {{" + name + "}} your ID no. is {{" + username + "}} and password is {{" + password + "}}. From www.toptimenet.com. *Jai Toptime*";
                WhatsApp.Send_WhatsApp_MSG(mobileno, Msg);

                utility.MessageBox(this, "Dear " + name + " SMS has been sent to your mobile number!");

            }

            if (e.CommandName.Equals("SHOWPRICE"))
            {
                SqlCommand cmd = new SqlCommand("update ControlMst set ShowProdPrice=(Case when isnull(ShowProdPrice,0)=0 then 1 else 0 end) where username=@username", con);
                cmd.CommandType = CommandType.Text;
                cmd.CommandTimeout = 99999;
                cmd.Parameters.AddWithValue("@username", username);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                BindGrid();
            }


        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();

    }
    protected void checkme(object sender, EventArgs e)
    {

        int j;

        for (j = 0; j < GridView1.Rows.Count; j++)
        {
            if (((CheckBox)(GridView1.HeaderRow.Cells[8].FindControl("chk1"))).Checked == true)
            {
                ((CheckBox)(GridView1.Rows[j].Cells[8].FindControl("chk2"))).Checked = true;


            }
            else
            {
                ((CheckBox)(GridView1.Rows[j].Cells[8].FindControl("chk2"))).Checked = false;

            }

        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {


        if (e.Row.RowType == DataControlRowType.DataRow)
        {


            string sts = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "lock"));


            Image img = (Image)e.Row.FindControl("imgLock");
            if (sts == "LOCKED")
            {
                img.ImageUrl = "images/Lock.png";
            }
            else if (sts == "UNLOCKED")
            {
                img.ImageUrl = "images/openLock.png";
            }
            else
            {
            }
        }
    }


    protected void btnLock_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow gr in GridView1.Rows)
        {
            CheckBox Rchkbox = (CheckBox)gr.FindControl("chk2");
            if (Rchkbox.Checked)
            {


                string adminId = gr.Cells[1].Text;



                string aLock = "1";
                SqlDataAdapter da = new SqlDataAdapter("updateAdminLock", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.SelectCommand.CommandTimeout = 99999;
                da.SelectCommand.Parameters.AddWithValue("@adminID", adminId);
                da.SelectCommand.Parameters.AddWithValue("@Lock", aLock);

                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView1.DataSource = dt;

                GridView1.DataBind();

                utility.MessageBox(this, "ADMIN LOCKED SUCCESSFULLY!");

            }
        }
        BindGrid();

    }
    protected void btnUnLock_Click(object sender, EventArgs e)
    {

        foreach (GridViewRow gr in GridView1.Rows)
        {
            CheckBox Rchkbox = (CheckBox)gr.FindControl("chk2");
            if (Rchkbox.Checked)
            {


                string adminId = gr.Cells[1].Text;



                string aLock = "0";
                SqlDataAdapter da = new SqlDataAdapter("updateAdminLock", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.SelectCommand.CommandTimeout = 99999;
                da.SelectCommand.Parameters.AddWithValue("@adminID", adminId);
                da.SelectCommand.Parameters.AddWithValue("@Lock", aLock);

                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView1.DataSource = dt;

                GridView1.DataBind();

                utility.MessageBox(this, "ADMIN UNLOCKED SUCCESSFULLY!");

            }

        }
        BindGrid();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_AdminList.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            GridView1.AllowPaging = false;
            BindGrid();
            
            GridView1.HeaderRow.BackColor = System.Drawing.Color.White;
            foreach (TableCell cell in GridView1.HeaderRow.Cells)
            {
                cell.BackColor = GridView1.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in GridView1.Rows)
            {
                row.BackColor = System.Drawing.Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = GridView1.RowStyle.BackColor;
                    }
                    cell.CssClass = "textmode";


                    List<Control> controls = new List<Control>();

                    //Add controls to be removed to Generic List
                    foreach (Control control in cell.Controls)
                    {
                        controls.Add(control);
                    }

                    //Loop through the controls to be removed and replace with Literal
                    foreach (Control control in controls)
                    {
                        switch (control.GetType().Name)
                        {
                            case "HyperLink":
                                cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
                                break;
                            case "TextBox":
                                cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
                                break;
                            case "Label":
                                cell.Controls.Add(new Literal { Text = (control as Label).Text });
                                break;
                            case "LinkButton":
                                cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
                                break;
                        }
                        cell.Controls.Remove(control);
                    }
                }
            }

            GridView1.RenderControl(hw);
            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
         
    }


}
