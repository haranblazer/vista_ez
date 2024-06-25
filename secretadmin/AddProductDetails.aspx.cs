using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using iTextSharp.text.html.simpleparser;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;
using System.Drawing;
using System.Drawing.Drawing2D;
//using iTextSharp.text;
//using iTextSharp.text.pdf;
//using iTextSharp.text.html;
 

public partial class admin_AddProductDetails : System.Web.UI.Page
{
    SqlConnection con;
    SqlDataAdapter da;
    SqlCommand cmd;
    DataTable dt;
    string strPostedFile;
    string pid = null,a=null;
    utility objutil;
   static string c=null;

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminlogin();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!Page.IsPostBack)
        {
            ListItem se = new ListItem("Select Product Name", "Select Product Name");
            DropDownList1.Items.Insert(0, se);
           BindProduct();

            if (Request.QueryString["catid"] != null)
            {
                objutil = new utility();
                string cid = objutil.base64Decode(Request.QueryString["catid"].ToString().Trim());
                try
                {
                    
                    ddlcategory.ClearSelection();
                    ddlcategory.Items.FindByValue(cid.Trim()).Selected = true;

                }
                catch { }
                //Bindbycat(Convert.ToInt32(cid.Trim()));
            }
            else
            {
                Bind();
            }
            btnInsert.CommandName = "Insert";
        }
    }
    void BindProduct()
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("select srno,productname from ProductMst where isdeleted=0",con);
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlcategory.DataSource = dt;
            ddlcategory.DataTextField = "productname";
            ddlcategory.DataValueField = "srno";
            ddlcategory.DataBind();
            ListItem se = new ListItem("Select Product Category", "Select Product Category");
            ddlcategory.Items.Insert(0, se);
            
        }
    }


    public void saveImg(string file)
    {
        try
        {
            if (imgUpload.HasFile)
            {
                
                string targetPath = Server.MapPath("~/ProductImage/" + file);
                Stream strm = imgUpload.PostedFile.InputStream;
                var targetFile = targetPath;
                GenerateThumbnails(0.5, strm, targetFile);

            }
            else
            {
            }
        }
        catch
        {
        }
    }
    protected void btnInsert_Click(object sender, EventArgs e)
    {
        try
        {
            this.Rte1.Text = H1.Value;
            a = H1.Value;
            if (ddlcategory.SelectedIndex <= 0)
            {
                utility.MessageBox(this, "Please Select Product!");
                return;
            }

            if (DropDownList1.SelectedItem.Text.Equals("Select Product Name"))
            {
                utility.MessageBox(this, "Please Enter Product Name!");
                return;

            }
            con = new SqlConnection(method.str);
            cmd = new SqlCommand("InsertProductDetails", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", btnInsert.CommandName == "Edit" ? Convert.ToString(ViewState["pid"]) : null);
            cmd.Parameters.AddWithValue("@catid", Convert.ToInt32(ddlcategory.SelectedValue.ToString()));
            cmd.Parameters.AddWithValue("@PName", DropDownList1.SelectedItem.Text);

            if (imgUpload.HasFile)
            {
                string filename = Path.GetFileName(imgUpload.PostedFile.FileName);
                cmd.Parameters.AddWithValue("@imagename", filename);
            }

            // cmd.Parameters.AddWithValue("@IUrl", imgUpload.HasFile == false ? "0" : System.IO.Path.GetExtension(this.imgUpload.PostedFile.FileName).ToString());
            cmd.Parameters.AddWithValue("@Description", a);
            cmd.Parameters.Add("@iname", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            cmd.Parameters.AddWithValue("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            if (cmd.Parameters["@flag"].Value.ToString() == "11")
            {
                utility.MessageBox(this, "Product added successfully!");
               
                if (imgUpload.HasFile)
                {
                    saveImg(cmd.Parameters["@iname"].Value.ToString());
                }

            }
            else if (cmd.Parameters["@flag"].Value.ToString() == "10")
            {
                utility.MessageBox(this, "Product Updated successfully!");

                string path = Server.MapPath(@"~/ProductImage/" + c);
                FileInfo file = new FileInfo(path);
                if (file.Exists)//check file exsit or not
                {
                    file.Delete();

                }
              
                if (imgUpload.HasFile)
                {
                    saveImg(cmd.Parameters["@iname"].Value.ToString());
                }
            }
            con.Close();
        }
        catch
        {
            utility.MessageBox(this, "Try again.");
        }

        finally
        {
            Bind();
        }
        btnInsert.CommandName = "Insert";
    }
    //public void Bindbycat(int catid)
    //{



    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        da = new SqlDataAdapter("ListProductcatDetails", con);
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@catid", catid);
    //        da.SelectCommand.Parameters.AddWithValue("@isDeleted", ddSearch.SelectedValue.ToString());
    //        dt = new DataTable();
    //        da.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {
    //            GridView1.PageSize = ddPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddPageSize.SelectedValue.ToString());
    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();

    //        }
    //        else
    //        {
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //        }
    //        dt.Dispose();
    //    }


    //    catch
    //    {
    //    }
    //    finally
    //    {
    //        con.Dispose();

    //    }
    //}
    public void Bind()
    {

        

        try
        {
            con = new SqlConnection(method.str);
            da = new SqlDataAdapter("ListProductDetails", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            da.SelectCommand.Parameters.AddWithValue("@searchtext", string.IsNullOrEmpty(txtSearch.Text.Trim()) == true ? null : txtSearch.Text.Trim());
            da.SelectCommand.Parameters.AddWithValue("@isDeleted", ddSearch.SelectedValue.ToString());
            da.SelectCommand.Parameters.AddWithValue("@Category", ddlcategory.SelectedItem.Text);

            dt = new DataTable();
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
            dt.Dispose();
        }


        catch
        {
        }
        finally
        {
            con.Dispose();

        }
    }
    public void updateStatus(string id, int st)
    {

        da = new SqlDataAdapter();
        try
        {
            con = new SqlConnection(method.str);
            cmd = new SqlCommand("update produccatmst set status=@isDeleted where pid=@ProductId", con);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 99999;
            cmd.Parameters.AddWithValue("@isDeleted", st);
            cmd.Parameters.AddWithValue("@ProductId", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Bind();
        }
        catch
        {
        }
        finally
        {
           // con.Dispose();
            
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Bind();
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        txtSearch.Text = string.Empty;
        ddlcategory.SelectedIndex = 0;
        Bind();
    }
    protected void ddSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        Bind();
    }
    protected void ddPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddPageSize.SelectedItem.Text == "All")
        {
            GridView1.PageSize = GridView1.Rows.Count;
        }
        else
            GridView1.PageSize = Convert.ToInt32(ddPageSize.SelectedItem.Text);
        Bind();
    }
    protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void imgbtnPdf_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            System.Web.UI.WebControls.Image img = (System.Web.UI.WebControls.Image)e.Row.FindControl("imgStatus");
            LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkbtnStatus");

            if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Status")) == "1")
            {
                img.ImageUrl = "images/yes.jpeg";
                lnkbtn.Text = "De-Activate";
                lnkbtn.CommandName = "DeActivate";
            }
            else if (Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Status")) == "0")
            {
                img.ImageUrl = "images/no.jpeg";
                lnkbtn.Text = "Activate";
                lnkbtn.CommandName = "Activate";
            }
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    } 
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName != "Page")
        {
            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            //GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
            //int  ss = Convert.ToInt32(e.CommandArgument);
            int ss = int.Parse(GridView1.DataKeys[row.RowIndex].Values[0].ToString());
            c = GridView1.DataKeys[row.RowIndex].Values[1].ToString();
            Image1.ImageUrl = "~/ProductImage/" + c;

           
            ViewState["pid"] = pid = ss.ToString();
            if (e.CommandName == "DeActivate")
            {
                updateStatus(pid, 0);
                utility.MessageBox(this, "Product de activated successfully !");
            }
            else if (e.CommandName == "Activate")
            {
                updateStatus(pid, 1);
                utility.MessageBox(this, "Product activated successfully !");
            }
            if (e.CommandName.Equals("EditProduct"))
            {

                con = new SqlConnection(method.str);
                cmd = new SqlCommand("select catid,Imagedesc,pnane,pid from ProducCatMst where pid=@ss", con);
                cmd.Parameters.AddWithValue("@ss",ss);
                con.Open();
                SqlDataReader ra = cmd.ExecuteReader();
                if (ra.Read())
                {
                    ss--;
                    btnInsert.CommandName = "Edit";
                    try
                    {
                        ddlcategory.ClearSelection();
                        ddlcategory.Items.FindByValue(ra["catid"].ToString().Trim()).Selected = true;
                        
                    }
                    catch { }

                    //DropDownList1.Items.Clear();
                    //SqlDataAdapter sda = new SqlDataAdapter("select  productid,productname from productmst where active=1", con);
                    //sda.Fill(dt);
                    //DropDownList1.DataSource = dt;
                    //DropDownList1.DataValueField = "productid";
                    //DropDownList1.DataTextField = "productname";
                    //DropDownList1.DataBind();
                    //  DropDownList1.Items.Insert(0, row.Cells[3].Text);
                    //   DropDownList1.SelectedItem.Text =(string)(row.Cells[3].Text).ToString();
                    //DropDownList1.SelectedItem.Text = row.Cells[1].Text;

                    //DropDownList1.ClearSelection();
                    //DropDownList1.Items.FindByValue(ra["catid"].ToString().Trim()).Selected = true;
                    //txtProduct.Text = ra["pnane"].ToString();
                    subcat();
                   string ab = ra["pnane"].ToString();
                   DropDownList1.SelectedItem.Text = ab;
                    a = ra["Imagedesc"].ToString();
                    Rte1.Text = Server.HtmlDecode(a);
                    con.Close();
                }


            }
        }

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

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        Bind();
    }
    protected void ddlcategory_SelectedIndexChanged(object sender, EventArgs e)
    {

        subcat();
        Bind();
        Rte1.Text = string.Empty;
     
    
    }


    public void subcat()
    {

        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("select distinct itemid,productname from itemmst where productid='" + ddlcategory.SelectedValue.ToString() + "'", con);
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {

            DropDownList1.DataSource = dt;
            DropDownList1.DataTextField = "productname";
            DropDownList1.DataValueField = "itemid";
            DropDownList1.DataBind();
            ListItem se = new ListItem("Select Product Name", "Select Product Name");
            DropDownList1.Items.Insert(0, se);
        }

        else
        {
            DropDownList1.Items.Clear();
            DropDownList1.DataSource = null;
            DropDownList1.DataBind();
            ListItem se = new ListItem("Select Product Name", "Select Product Name");
            DropDownList1.Items.Insert(0, se);
        }
    
    }
}