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
    SqlCommand com;
    DataTable dt;
    SqlDataAdapter da;
    string productId, strFile;

    protected void Page_Load(object sender, EventArgs e)
    {
        productId = Convert.ToString(Request.QueryString["n"]);
        InsertFunction.CheckAdminlogin();
        if (!Page.IsPostBack)
        {
            getProductDocument();
        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (FileUploadDoc.HasFile)
        {
            CheckExist();
        }
    }

    public void CheckExist()
    {
        string fileNamePdf = Path.GetFileName(productId+FileUploadDoc.FileName);
        //string fileNameImg = Path.GetFileName(FileUploadImg.FileName);
        string uploadPdfPath = Server.MapPath(string.Format("~/secretadmin/ProductDoc/{0}", fileNamePdf));
        //string uploadImgPath = Server.MapPath(string.Format("~/images/downloads/{0}", fileNameImg));
        con = new SqlConnection(method.str);
        com = new SqlCommand("getProductDoc", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@Productid", productId);
        dt = new DataTable();
        da = new SqlDataAdapter(com);
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                //if (txtTitle.Text == dt.Rows[i]["ProductName"].ToString())
                //{
                //    utility.MessageBox(this, "Title already exist!");
                //    return;
                //}
                if (fileNamePdf == dt.Rows[i]["DocName"].ToString())
                {
                    utility.MessageBox(this, "file name already exists!");
                    getProductDocument();
                    return;
                }
            }
        }
        if (!File.Exists(uploadPdfPath))
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("InsertDoc", con);
            com.CommandType = CommandType.StoredProcedure;
            con.Open();
            com.Parameters.AddWithValue("@Productid", productId);
            if (FileUploadDoc.HasFile)
            {

                if (FileUploadDoc.PostedFile.ContentLength < 30971520)
                {
                    com.Parameters.AddWithValue("@FileName", fileNamePdf);
                    FileUploadDoc.SaveAs(uploadPdfPath);
                }
                else
                {
                    lblMessage.Visible = true;
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);
                }
            }

            //if (FileUploadImg.HasFile)
            //{

            //    if (FileUploadImg.PostedFile.ContentLength < 5971520)
            //    {
            //        com.Parameters.AddWithValue("@url2", FileUploadImg.FileName);
            //        FileUploadImg.SaveAs(uploadImgPath);

            //    }
            //    else
            //    {
            //        lblMessage.Visible = true;
            //        ClientScript.RegisterStartupScript(this.GetType(), "alert", "HideLabel();", true);

            //    }

            //}

            com.Parameters.Add("@flag", SqlDbType.VarChar, 100);
            com.Parameters["@flag"].Direction = ParameterDirection.Output;
            com.ExecuteNonQuery();
            con.Close();
            string message = com.Parameters["@flag"].Value.ToString();
            utility.MessageBox(this, message);
            txtTitle.Text = string.Empty;
            getProductDocument();
        }
    }


    public void getProductDocument()
    {
        try
        {
            StringBuilder sbprod = new StringBuilder();
            con = new SqlConnection(method.str);
            com = new SqlCommand("getProductDoc", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@ProductId", productId);
            con.Open();
            SqlDataReader sdr = com.ExecuteReader();
            if (sdr.Read())
            {
                strFile = sdr["DocName"].ToString();

                sbprod.Append("<div class='spec-row' id='summarySpecs'>");
                sbprod.Append("<center>");
                sbprod.Append("<iframe src='ProductDoc/" + strFile + "' width='1000px' height='700px' frameborder='0'>");
                sbprod.Append("</iframe>");
                sbprod.Append("</center>");
                sbprod.Append("</div>");

                prodoc.InnerHtml = sbprod.ToString();
               // imgProduct.ImageUrl = "~/ProductImage/" + strFile;
            }
            else
            {
                //con.Close();
               // imgProduct.ImageUrl = "~/ProductImage/noimage.png";
            }
            con.Close();
        }
        catch 
        { 
        }
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
                    ////BindGrid();
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
                //BindGrid();
            }
        }
    }
}




