using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;

public partial class winneradmin_ADDProduct : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    DataTable dt = new DataTable();
    SqlCommand cmd;
    SqlDataAdapter adp;
    string pid = null;
    utility obj = new utility();

    string strPostedFile;
    string photo;
    static string c=null;
    protected void Page_Load(object sender, EventArgs e)
    {
        //utility.MessageBox(this,string.Empty;
        if (!Page.IsPostBack)
        {
            btnInsert.CommandName = "Insert";
            Bind();
        } 
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminLogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminlogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
    }

    private void addProduct()
    {

        try
        {

           
            SqlCommand cmd = new SqlCommand("InsertProduct", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", btnInsert.CommandName == "EditProduct" ? Convert.ToString(ViewState["pid"]) : null);
            cmd.Parameters.AddWithValue("@ProductName", txtProduct.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@Price", txtPrice.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@PV", txtPV.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@RewardPoint", txtRewardPoint.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@TourPoint", txttourPoint.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@Tax", txtTax.Text.Trim().ToString());
            cmd.Parameters.AddWithValue("@dincome",txtdirectincome.Text.ToString());
            cmd.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            if (FileUpload1.HasFile)
            {
                string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
                cmd.Parameters.AddWithValue("@imagename", ViewState["pid"].ToString()+filename);
            }


            else
            {
                cmd.Parameters.AddWithValue("@imagename", ViewState["imagename"] == null ? "":ViewState["imagename"].ToString());
            }

            //cmd.Parameters.AddWithValue("@imagename", FileUpload1.HasFile == false ? "0" : System.IO.Path.GetExtension(this.FileUpload1.PostedFile.FileName).ToString());

            cmd.Parameters.Add("@iname", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;


            con.Open();
            cmd.ExecuteNonQuery();

            if (cmd.Parameters["@flag"].Value.ToString() == "1")
            {
                utility.MessageBox(this, "Product added successfully!");

                if (FileUpload1.HasFile)
                {
                    strPostedFile = (string)cmd.Parameters["@iname"].Value;
                    string targetPath = Server.MapPath("~/ProductImage/" + strPostedFile);
                    Stream strm = FileUpload1.PostedFile.InputStream;
                    var targetFile = targetPath;
                    GenerateThumbnails(0.5, strm, targetFile);
                }

            }
            else if (cmd.Parameters["@flag"].Value.ToString() == "3")
            {
                utility.MessageBox(this, " Product edited successfully !");

                if (FileUpload1.HasFile)
                {

                    string path = Server.MapPath(@"~/ProductImage/" + c);
                    FileInfo file = new FileInfo(path);
                    if (file.Exists)//check file exsit or not
                    {
                        file.Delete();

                    }
                    //strPostedFile = (string)cmd.Parameters["@iname"].Value;
                    string targetPath = Server.MapPath("~/ProductImage/" + c);
                    Stream strm = FileUpload1.PostedFile.InputStream;
                    var targetFile = targetPath;
                    GenerateThumbnails(0.5, strm, targetFile);

                }
            }
            else if (cmd.Parameters["@flag"].Value.ToString() == "4")
            {
                utility.MessageBox(this, "Product already exists ");
            }
            btnInsert.CommandName = "Insert";
            con.Close();
        }
        catch
        {

        }
       txtPrice.Text=txttourPoint.Text= txtPV.Text = txtPrice.Text = txtProduct.Text = txtdirectincome.Text=string.Empty;
    }


    private void GenerateThumbnails(double scaleFactor, Stream sourcePath, string targetPath)
    {

        using (var image = System.Drawing.Image.FromStream(sourcePath))
        {
            // can give static width (e.g. 1024) of image as we want
            var newWidth = (int)(scaleFactor * image.Width);
            //You can give static height (e.g. 1024) of image as we want
            var newHeight = (int)(scaleFactor * image.Height);
            var thumbnailImg = new Bitmap(newWidth, newHeight);
            var thumbGraph = Graphics.FromImage(thumbnailImg);
            thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
            thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
            thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
            var imageRectangle = new System.Drawing.Rectangle(0, 0, newWidth, newHeight);
            thumbGraph.DrawImage(image, imageRectangle);
            thumbnailImg.Save(targetPath, image.RawFormat);


        }
    }





  

    public void Bind()
    {

        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            da = new SqlDataAdapter("getList", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@searchtext", string.IsNullOrEmpty(txtSearch.Text.Trim()) == true ? null : txtSearch.Text.Trim());
            da.SelectCommand.Parameters.AddWithValue("@isDeleted", ddSearch.SelectedValue.ToString());

            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
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


        catch
        {
        }
        finally
        {
            con.Dispose();

        }
    }

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtPV.Text.Trim()))
        {
            utility.MessageBox(this,"Enter PV value.");
            return;
        }
        else if (string.IsNullOrEmpty(txtPrice.Text.Trim()))
        {
            utility.MessageBox(this,"Enter price value.");
            return;
        }
        if (Convert.ToInt32(txtPV.Text.Trim()) > 0)
        {
            addProduct();

            Bind();
           // BindGrid();
        }
        else
        {
            utility.MessageBox(this,"joinfor can not be 0 or less!");
        }

        txtPrice.Text = txtProduct.Text = txtPV.Text = txtRewardPoint.Text = txtTax.Text = txttourPoint.Text = string.Empty;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Bind();
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        txtSearch.Text = string.Empty;
        Bind();
       // BindGrid();
    }

    public void updateStatus(string id, int st)
    {

        adp = new SqlDataAdapter();
        try
        {

            cmd = new SqlCommand("update productMst set isDeleted=@isDeleted where SrNo=@ProductId", con);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 99999;
            cmd.Parameters.AddWithValue("@isDeleted", st);
            cmd.Parameters.AddWithValue("@ProductId", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Bind();
            //BindGrid();
        }
        catch
        {
        }
        finally
        {
            con.Dispose();
            adp.Dispose();
        }
    }
    protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
       // BindGrid();
        Bind();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    
    } 

    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            Bind();
            GridView1.Columns[5].Visible = GridView1.Columns[6].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductList.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this,"can not export as no data found !");
    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            Bind();
            GridView1.Columns[5].Visible = GridView1.Columns[6].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductList.xls");
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this,"can not export as no data found !");
    }
    protected void imgbtnPdf_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {

            GridView1.AllowPaging = false;
            Bind();
            GridView1.Columns[5].Visible = GridView1.Columns[6].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_ProductList.pdf");
            Response.ContentType = "application/pdf";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            GridView1.RenderControl(hw);
            StringReader sr = new StringReader(Regex.Replace(sw.ToString(), "</?(a|A).*?>", ""));
            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();
            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();


        }
        else
            utility.MessageBox(this,"can not export as no data found !");
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            System.Web.UI.WebControls.Image img = (System.Web.UI.WebControls.Image)e.Row.FindControl("imgStatus");
            LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkbtnStatus");
            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isDeleted")) == "False")
            {
                img.ImageUrl = "images/yes.jpeg";
                lnkbtn.Text = "De-Activate";
                //utility.MessageBox(this, "Active successful ");
                lnkbtn.CommandName = "DeActivate";
                //utility.MessageBox(this, "disable successful ");
            }
            else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "isDeleted")) == "True")
            {
                img.ImageUrl = "images/no.jpeg";
                lnkbtn.Text = "Activate";
                //utility.MessageBox(this, "Active successful ");
                lnkbtn.CommandName = "Activate";
                //utility.MessageBox(this, "disable successful ");
            }
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        Bind();
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "Page")
        {
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            ViewState["pid"] =  pid = GridView1.DataKeys[row.RowIndex].Value.ToString();
            if (e.CommandName == "DeActivate")
            {
                updateStatus(pid, 1);
                utility.MessageBox(this, "Product de activated successfully !");
            }
            else if (e.CommandName == "Activate")
            {
                updateStatus(pid, 0);
                utility.MessageBox(this ,"Product activated successfully !");
            }
            if (e.CommandName.Equals("EditProduct"))
            {
                btnInsert.CommandName = "EditProduct";


                txtProduct.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
                txtPrice.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[2].Text;
                txtPV.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[3].Text;
                txtRewardPoint.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[4].Text;
                txttourPoint.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[5].Text;
                txtTax.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[6].Text;
                txtdirectincome.Text = GridView1.Rows[Convert.ToInt32(e.CommandArgument)].Cells[8].Text;
               ViewState["imagename"]= c = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
               Image1.ImageUrl = "~/ProductImage/" + c;
              
             
                
                
            }

            if (e.CommandName.Equals("AddItem"))
            {
                Response.Redirect("AddItem.aspx?id=" + obj.base64Encode(pid));
            }


          
        }
    }


    //protected void ddSearch_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //Bind();
    //}
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }
}
