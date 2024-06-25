using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Drawing;

public partial class secretadmin_Events : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetVideoTitle();
            GetVideoList();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddl_title.SelectedValue == "0")
            {
                utility.MessageBox(this, "Please select title.");
                return;
            }
             
            if (string.IsNullOrEmpty(txtVideoUpload.Text.Trim()))
            {
                utility.MessageBox(this, "Please enter video link.");
                return;
            }

            string Img = "video_black.jpg";
            if (fuUpload.HasFile)
            {
                if (fuUpload.PostedFile.ContentLength > 512000)
                {
                    utility.MessageBox(this, "Please select an image size should be less than 500 KB.");
                    return;
                }

                Img = Path.GetFileName(Guid.NewGuid().ToString() + fuUpload.PostedFile.FileName);
                string fileName = Guid.NewGuid().ToString() + "." + Path.GetExtension(fuUpload.FileName);

                Stream stream = fuUpload.FileContent;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 700 && height == 500)
                {

                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 700px and height 500px.");
                    return;
                }
            }



            com = new SqlCommand("InsertVideo", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@vname", txtVideoUpload.Text.Trim());
            com.Parameters.AddWithValue("@status", 1);
            com.Parameters.AddWithValue("@Tid", ddl_title.SelectedValue);
            com.Parameters.AddWithValue("@TitleHeader", txt_TitleHeader.Text.Trim());
            com.Parameters.AddWithValue("@Img", Img);
            com.Parameters.AddWithValue("@DataType", "Events");
            con.Open();
            int count = com.ExecuteNonQuery();
            con.Close();
            if (count > 0)
            {
                if (fuUpload.HasFile)
                {
                    fuUpload.PostedFile.SaveAs(Server.MapPath("~/images/Slip/" + Img));
                }
                lblMsg.Visible = true;
                lblMsg.Text = "Event Video Uploaded Successfully.";
                Response.AppendHeader("X-XSS-Protection", "0");
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
                txtVideoUpload.Text = string.Empty;
            }

            GetVideoList();
        }
        catch (Exception er)
        {

        }
        finally
        {
            con.Dispose();
        }

    }

    public void GetVideoList()
    {
        SqlParameter[] param = new SqlParameter[]
        {
                new SqlParameter("@DataType", "Events")
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetVideo");
        if (dt.Rows.Count > 0)
        {
            DataVideo.DataSource = dt;
            DataVideo.DataBind();
        }
        else
        {
            DataVideo.DataSource = null;
            DataVideo.DataBind();
        }

    }


    protected void lnkupdate_Click(object sender, EventArgs e)
    {
        try
        {
            var control = (Control)sender;
            var container = control.NamingContainer;
            // access your controls this way
            var hnd_id = container.FindControl("hnd_id") as HiddenField;
            var imgdlUpload = container.FindControl("imgdlUpload") as FileUpload;

            string Img = "video_black.jpg";
            if (imgdlUpload.HasFile)
            {
                if (imgdlUpload.PostedFile.ContentLength > 512000)
                {
                    utility.MessageBox(this, "Please select an image size should be less than 500 KB.");
                    return;
                }

                Img = Path.GetFileName(Guid.NewGuid().ToString() + imgdlUpload.PostedFile.FileName);
                string fileName = Guid.NewGuid().ToString() + "." + Path.GetExtension(imgdlUpload.FileName);

                Stream stream = imgdlUpload.FileContent;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width == 700 && height == 500)
                {
                    com = new SqlCommand("Update videomst set Img=@img where id=@id", con);
                    com.Parameters.AddWithValue("@img", Img);
                    com.Parameters.AddWithValue("@id", hnd_id.Value);
                    con.Open();
                    int i = com.ExecuteNonQuery();
                    con.Close();
                    if (i == 1)
                    {
                        if (imgdlUpload.HasFile)
                        {
                            imgdlUpload.PostedFile.SaveAs(Server.MapPath("~/images/Slip/" + Img));
                            GetVideoList();
                        }
                    }
                    else
                    {
                        utility.MessageBox(this, "Product Image Update Failed !!!");
                    }
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 700px and height 500px.");
                    return;
                }
            }
            else
            {
                utility.MessageBox(this, "Please select an image.");
                return;
            } 
        }
        catch (Exception er) { }
    }



    protected void lnkDel_Click(object sender, EventArgs e)
    {
        try
        {
            var control = (Control)sender;
            var container = control.NamingContainer;
            // access your controls this way
            var hnd_id = container.FindControl("hnd_id") as HiddenField;
            var hnd_Img = container.FindControl("hnd_Img") as HiddenField;

            var filePath = Server.MapPath("~/images/Slip/" + hnd_Img.Value);
            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }


            com = new SqlCommand("DelVideo", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@id", hnd_id.Value);
            con.Open();
            int result = com.ExecuteNonQuery();
            con.Close();
            if (result > 0)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Event Video Deleted Successfully.";
                Response.AppendHeader("X-XSS-Protection", "0");
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
            }
            GetVideoList();
        }
        catch (Exception er)
        {

        }

    }

    protected void btn_Title_Click(object sender, EventArgs e)
    {

        GetVideoTitle();

    }


    public void GetVideoTitle()
    {
        try
        {
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable("Select Tid, Title from TitleMst where TitleType='Events'");
            if (dt.Rows.Count > 0)
            {
                ddl_title.Items.Clear();
                ddl_title.DataSource = dt;
                ddl_title.DataTextField = "Title";
                ddl_title.DataValueField = "Tid";
                ddl_title.DataBind();
                ddl_title.Items.Insert(0, new ListItem("Select Title", "0"));
            }
        }
        catch { }
    }



    //SqlConnection con;
    //SqlCommand com;
    //SqlDataAdapter da;
    //utility objUtil = null;
    //protected void Page_Load(object sender, EventArgs e)
    //{
    //    if (Convert.ToString(Session["admintype"]) == "sa")
    //    {
    //        utility.CheckSuperAdminLogin();
    //    }
    //    else if (Convert.ToString(Session["admintype"]) == "a")
    //    {
    //        utility.CheckAdminLogin();
    //    }
    //    else
    //    {
    //        Response.Redirect("adminLog.aspx");
    //    }

    //    if (!IsPostBack)
    //    {
    //        DataBind();
    //        BindState();
    //        GetLeader();
    //    }
    //}

    //public void BindState()
    //{
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("GetState", con);
    //        com.CommandType = CommandType.StoredProcedure;

    //        da = new SqlDataAdapter(com);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        DdlState.DataSource = dt;
    //        DdlState.DataTextField = "StateName";
    //        DdlState.DataValueField = "SId";
    //        DdlState.DataBind();
    //        DdlState.Items.Insert(0, new ListItem("Select", "0"));
    //        //ddlDistrict.Items.Insert(0, new ListItem("Select", "0"));
    //    }
    //    catch
    //    {

    //    }
    //}

    //public void GetLeader()
    //{
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("GetLeaders", con);
    //        com.CommandType = CommandType.StoredProcedure;
    //        com.CommandTimeout = 99999999;
    //        //com.Parameters.AddWithValue("@regno", txtLeader.Text.Trim());
    //        da = new SqlDataAdapter(com);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        ddlLeader.DataSource = dt;
    //        ddlLeader.DataTextField = "appmstregno";
    //        ddlLeader.DataValueField = "appmstid";
    //        ddlLeader.DataBind();
    //        ddlLeader.Items.Insert(0, new ListItem("Select", "0"));
    //        //lblappmstname.Text = dt.Rows[0]["appmstfname"].ToString();
    //        //lblappmstid.Text = dt.Rows[0]["appmstid"].ToString();
    //        //lblappmstregno.Text = dt.Rows[0]["appmstregno"].ToString();
    //    }
    //    catch
    //    {

    //    }
    //}

    //protected void gridTrnReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    //gridTrnReq.PageIndex = e.NewPageIndex;
    //    //OnlineTranHistory();

    //}

    //protected void gridTrnReq_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //}

    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //        dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //        string msg = "";
    //        if (ddlLeader.SelectedItem.Text == "Select")
    //        {
    //            utility.MessageBox(this, "Please Select Leader!");
    //            return;
    //        }
    //        if (txtDate.Text == "")
    //        {
    //            utility.MessageBox(this, "Please Enter Event Date!");
    //            return;
    //        }
    //        if (DdlHR.SelectedItem.Text.Trim() == "Select")
    //        {
    //            utility.MessageBox(this, "Please Enter Hour!");
    //            return;
    //        }
    //        if (DdlMin.SelectedItem.Text.Trim() == "Select")
    //        {
    //            utility.MessageBox(this, "Please Enter Min!");
    //            return;
    //        }
    //        if (txtLocation.Text == "")
    //        {
    //            utility.MessageBox(this, "Please Enter Location!");
    //            return;
    //        }
    //        if (txtCity.Text == "")
    //        {
    //            utility.MessageBox(this, "Please Enter City!");
    //            return;
    //        }

    //        if (ddlType.SelectedValue == "0")
    //        {
    //            utility.MessageBox(this, "Please Select Type!");
    //            return;
    //        }
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("InsertEvents", con);
    //        com.CommandType = CommandType.StoredProcedure;
    //        com.CommandTimeout = 99999999;
    //        com.Parameters.AddWithValue("@appmstid", ddlLeader.SelectedValue.ToString().Trim());
    //        com.Parameters.AddWithValue("@eventdate", Convert.ToDateTime(txtDate.Text.Trim(), dateInfo));
    //        com.Parameters.AddWithValue("@eventtime", DdlHR.SelectedItem.Text.Trim() + ":" + DdlMin.SelectedItem.Text.Trim());
    //        com.Parameters.AddWithValue("@type", ddlType.SelectedValue.ToString().Trim());
    //        com.Parameters.AddWithValue("@state", DdlState.SelectedItem.ToString().Trim());
    //        com.Parameters.AddWithValue("@city", txtCity.Text.Trim());
    //        com.Parameters.AddWithValue("@location", txtLocation.Text.Trim());
    //        com.Parameters.AddWithValue("@contact", txtcontact.Text.Trim());
    //        com.Parameters.AddWithValue("@srno", lblsrno.Text.Trim());


    //        com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
    //        con.Open();
    //        com.ExecuteNonQuery();
    //        con.Close();
    //        msg = com.Parameters["@flag"].Value.ToString();
    //        utility.MessageBox(this, msg);
    //        DataBind();
    //        refresh();
    //    }
    //    catch
    //    {
    //        con.Close();
    //        Response.Redirect("error.aspx");
    //    }
    //    finally
    //    {
    //    }
    //}

    //private void refresh()
    //{
    //    txtCity.Text = "";
    //    ddlType.SelectedValue = "0";
    //    txtLocation.Text = "";
    //    txtDate.Text = "";
    //    //txtLeader.Text = "";
    //    DdlHR.SelectedValue = "0";
    //    DdlMin.SelectedValue = "0";
    //    lblsrno.Text = "0";
    //    // DdlState.SelectedValue = "0";
    //}

    //protected void txtLeader_TextChanged(object sender, EventArgs e)
    //{
    //    //GetLeader();
    //}

    //private void DataBind()
    //{
    //    con = new SqlConnection(method.str);
    //    com = new SqlCommand("GetEvents", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.CommandTimeout = 99999999;
    //    //com.Parameters.AddWithValue("@regno", regno);
    //    da = new SqlDataAdapter(com);
    //    DataTable dt = new DataTable();
    //    da.Fill(dt);
    //    gridTrnReq.DataSource = dt;
    //    gridTrnReq.DataBind();
    //}
    //protected void ddlLeader_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //GetLeader();
    //}

    //protected void btedit_Click(object sender, EventArgs e)
    //{
    //    try
    //    {



    //    }
    //    catch
    //    {
    //    }

    //}

    //protected void btdel_Click(object sender, EventArgs e)
    //{

    //}
    //protected void gridTrnReq_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    GridViewRow row = gridTrnReq.Rows[Convert.ToInt32(e.CommandArgument)];
    //    string srno = gridTrnReq.DataKeys[row.RowIndex].Values[0].ToString();
    //    if (e.CommandName == "e")
    //    {
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("select * from eventmst where srno=@srno", con);
    //        com.CommandType = CommandType.Text;
    //        com.CommandTimeout = 99999999;
    //        com.Parameters.AddWithValue("@srno", srno);
    //        da = new SqlDataAdapter(com);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);

    //        lblsrno.Text = srno;
    //        DdlState.SelectedItem.Text = dt.Rows[0]["state"].ToString();
    //        txtCity.Text = dt.Rows[0]["city"].ToString();
    //        txtLocation.Text = dt.Rows[0]["location"].ToString();
    //        txtcontact.Text = dt.Rows[0]["contact"].ToString();
    //        ddlType.SelectedValue = dt.Rows[0]["type"].ToString();
    //        txtDate.Text = dt.Rows[0]["eventdate"].ToString();
    //        ddlLeader.SelectedValue = dt.Rows[0]["appmstid"].ToString();
    //        DdlHR.SelectedItem.Text = dt.Rows[0]["eventtime"].ToString().Substring(0, 2);
    //        DdlMin.SelectedItem.Text = dt.Rows[0]["eventtime"].ToString().Substring(3, 2);
    //    }
    //    else
    //    {
    //        con = new SqlConnection(method.str);
    //        SqlCommand cmd = new SqlCommand("delete from eventmst where srno=@srno", con);

    //        cmd.CommandType = CommandType.Text;
    //        cmd.Parameters.AddWithValue("@srno", srno);
    //        //cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
    //        con.Open();
    //        cmd.ExecuteNonQuery();
    //        con.Close();

    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Row deleted Successfully.');", true);
    //        DataBind();
    //        refresh();

    //    }
    //}
}