using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Text;


public partial class download : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand cmd;
    DataTable dt;
    SqlDataAdapter da;
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


            lblMessage.Visible = false;
            if (!IsPostBack)
                BindGrid();
        }
        catch
        {

        }


    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (txtTitle.Text.Trim() != "")
        {
            if (FileUploadDoc.HasFile)
            {
                CheckExist();
            }
        }
    }

    public void CheckExist()
    {
        try
        {
            

            string fileNamePdf = Guid.NewGuid().ToString()  + Path.GetExtension(FileUploadDoc.FileName);
           // string fileNameImg = Guid.NewGuid().ToString()  + Path.GetExtension(FileUploadImg.FileName);

            //string fileNamePdf = Path.GetFileName(FileUploadDoc.FileName);
            //string fileNameImg = Path.GetFileName(FileUploadImg.FileName);


            string uploadPdfPath = Server.MapPath(string.Format("~/images/downloads/{0}", fileNamePdf));
           // string uploadImgPath = Server.MapPath(string.Format("~/images/downloads/{0}", fileNameImg));
            con = new SqlConnection(method.str);
            cmd = new SqlCommand("DownloadDetails", con);
            cmd.CommandType = CommandType.StoredProcedure;
            dt = new DataTable();
            da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (txtTitle.Text == dt.Rows[i]["Title"].ToString())
                    {
                        utility.MessageBox(this, "Title already exist!");
                        return;
                    }
                    else if (FileUploadDoc.FileName == dt.Rows[i]["filename"].ToString())
                    {
                        utility.MessageBox(this, "file name already exists!");
                        return;
                    }
                }
            }
            if (!File.Exists(uploadPdfPath))
            {

                //if (ddl_DisplayType.SelectedValue == "")
                //{
                //    utility.MessageBox(this, "Please Select Display Type.!!");
                //    return;
                //}
                con = new SqlConnection(method.str);
                cmd = new SqlCommand("InsertDownloadMst", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.Parameters.AddWithValue("@Title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@doctype", ddl_doctype.Value);
                cmd.Parameters.AddWithValue("@DisplayType", ddl_DisplayType.SelectedItem.Text);
                if (FileUploadDoc.HasFile)
                {
                    if (FileUploadDoc.PostedFile.ContentLength < 30971520)
                    {
                        cmd.Parameters.AddWithValue("@FileName", fileNamePdf);
                        cmd.Parameters.AddWithValue("@url1", fileNamePdf);
                        FileUploadDoc.SaveAs(uploadPdfPath);
                    }
                    else
                    {
                        lblMessage.Visible = true;
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
                        return;
                    }
                }
                else
                {
                    cmd.Parameters.AddWithValue("@FileName", "");
                    cmd.Parameters.AddWithValue("@url1", "");
                }
                //if (FileUploadImg.HasFile)
                //{
                //    if (FileUploadImg.PostedFile.ContentLength < 5971520)
                //    {
                //        cmd.Parameters.AddWithValue("@url2", fileNameImg);
                //        FileUploadImg.SaveAs(uploadImgPath);
                //    }
                //    else
                //    {
                //        lblMessage.Visible = true;
                //        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
                //        return;
                //    }
                //}
                //else
                //{
                //    cmd.Parameters.AddWithValue("@url2", "");
                //}

                cmd.Parameters.AddWithValue("@Status", 1);
                cmd.Parameters.AddWithValue("@doe", "");
                cmd.Parameters.AddWithValue("@url2", "");

                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100);
                cmd.Parameters["@flag"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                con.Close();
                string message = cmd.Parameters["@flag"].Value.ToString();
                utility.MessageBox(this, message);
                txtTitle.Text = string.Empty;
                BindGrid();
            }
        }
        catch (Exception er) { }
    }


    public void BindGrid()
    {
        SqlParameter[] param = new SqlParameter[] {
        new SqlParameter("@DisplayType", ddl_DisplayType.SelectedValue) };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetDownload");
        GridView1.DataSource = dt;
        GridView1.DataBind();
    }

    protected void ddl_DisplayType_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
        if (e.CommandName.Equals("Dwn"))
        {
            try
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row_new = GridView1.Rows[index];
                string fName = row_new.Cells[2].Text;
                string fileName = Server.MapPath("../admin/Downloads/") + fName;

                //Response.ContentType = "application/octet-stream";
                //Response.AppendHeader("Content-Disposition", "attachment; filename=" + fName);
                //Response.WriteFile(path);
                //Response.Flush();
                //Response.End();

                if (fileName != null || fileName != string.Empty)
                {
                    if ((System.IO.File.Exists(fileName)))
                    {
                        System.IO.File.Delete(fileName);
                    }
                }

                string ID = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
                con = new SqlConnection(method.str);
                SqlCommand com = new SqlCommand("update DownloadMst set Status=0 where ID=@ID", con);
                com.Parameters.AddWithValue("@ID", ID);
                con.Open();
                string Result = com.ExecuteNonQuery().ToString();
                if (Result == "1")
                {
                    BindGrid();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Source file deleted successfully.');", true);
                }
                else
                {
                    utility.MessageBox(this, "Server error.!!");
                }
            }
            catch (Exception ex)
            {
                utility.MessageBox(this, ex.ToString());
            }
            finally
            {
                con.Close();
                BindGrid();
            }
        }
    }
}




