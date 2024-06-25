using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class secretadmin_UploadBrandImage : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindSliderImage();
        }
    }


    //protected void btnUpload_Click(object sender, EventArgs e)
    //{
    //    try
    //    {

    //        //if (!string.IsNullOrEmpty(txtImgH1.Text.Trim()))
    //        //{
    //        //    if (!string.IsNullOrEmpty(txtImgH2.Text.Trim()))
    //        //    {

    //        //if (FileSliderImage.HasFile && FileSliderImage.PostedFile.ContentLength <= 2000000)
    //        //{
    //        //DataListItem item = ((LinkButton)sender).NamingContainer as DataListItem;
    //        //DataListItem item = ((Button)sender).NamingContainer as DataListItem;
    //        //Label lblid = (Label)item.FindControl("lblID");
    //        string FileName =  "brand"+Path.GetFileName(Guid.NewGuid().ToString() + FileSliderImage.PostedFile.FileName);

    //        //string FileName = "brand"+FileSliderImage.PostedFile.FileName;
    //        //if (Regex.Match(FileSliderImage.FileName, @"^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$").Success)
    //        //{
    //        if (FileName != "")
    //        {
    //            Stream stream = FileSliderImage.PostedFile.InputStream;
    //            Bitmap bitimg = new Bitmap(stream);
    //            int height = bitimg.Height;
    //            int width = bitimg.Width;
    //            string name = txt_title.Text.Trim();
    //            if (width != 300 && height != 180)
    //            {
    //                utility.MessageBox(this, "Image size must be width 300px and height 180px.");
    //                FileSliderImage.Focus();
    //                return;
    //            }
    //        }

    //            //Image1.ImageUrl = "../ProductImage/" + dt.Rows[0]["gif1"].ToString();

    //            SqlCommand cmd = new SqlCommand("UploadBrandImg", con);
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@brand", FileName);
    //            cmd.Parameters.AddWithValue("@status", 1);
    //            cmd.Parameters.AddWithValue("@title", name);
    //            cmd.Parameters.AddWithValue("@PNo", txt_PNo.Text);
    //            cmd.Parameters.AddWithValue("@bid", hdn_Id.Value);

    //            cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
    //            con.Open();
    //            cmd.ExecuteNonQuery();
    //            con.Close();
    //            string msg = cmd.Parameters["@flag"].Value.ToString();
    //            if (msg == "1")
    //            {
    //                FileSliderImage.SaveAs(Server.MapPath("~/images/brand_logo/" + FileName));

    //                //string path = Server.MapPath("../images/SliderImage/" + FileSliderImage.PostedFile.FileName);
    //                //FileSliderImage.SaveAs(path);
    //                utility.MessageBox(this, "Brand Image Uploaded Successfully.");

    //            }
    //            else
    //            {
    //                utility.MessageBox(this, "File Name Already Exists!");
    //                FileSliderImage.Focus();
    //                return;
    //            }
    //                BindSliderImage();
    //                Response.Redirect(Request.RawUrl);

    //           // }
    //            //else
    //            //{
    //            //    utility.MessageBox(this, "Only .jpg/.jpeg/.gif/.png file types are allowed.");
    //            //    FileSliderImage.Focus();
    //            //    return;
    //            //}


    //        //}
    //        //else
    //        //{
    //        //    utility.MessageBox(this, "Please select an image and image size should be less than 2 MB.");
    //        //    FileSliderImage.Focus();
    //        //    return;
    //        //}
    //        //    }
    //        //    else
    //        //    {
    //        //        utility.MessageBox(this, "Please Enter Image Heading 2.");
    //        //        txtImgH2.Focus();
    //        //        return;
    //        //    }
    //        //}
    //        //else
    //        //{
    //        //    utility.MessageBox(this, "Please Enter Image Heading 1.");
    //        //    txtImgH1.Focus();
    //        //    return;
    //        //}
    //        txt_title.Text = "";
    //        txt_PNo.Text = "";
    //    }
    //    catch (Exception ex)
    //    {
    //        utility.MessageBox(this, ex.Message);
    //    }

    //}




    protected void btnUpload_Click(object sender, EventArgs e)
    {
        try
        {
            string name = txt_title.Text.Trim();
            int PNo;
            if (!int.TryParse(txt_PNo.Text, out PNo))
            {
                utility.MessageBox(this, "Priority number must be a number.");
                return;
            }
            if (PNo < 1)
            {
                utility.MessageBox(this, "Priority number must be greater than 0.");
                return;
            }
            string FileName = "";

            if (FileSliderImage.HasFile)
            {
                FileName = "brand" + Path.GetFileName(Guid.NewGuid().ToString() + FileSliderImage.PostedFile.FileName);

                Stream stream = FileSliderImage.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int height = bitimg.Height;
                int width = bitimg.Width;
                if (width != 300 && height != 180)
                {
                    utility.MessageBox(this, "Image size must be width 300px and height 180px.");
                    FileSliderImage.Focus();
                    return;
                }
            }


            SqlCommand cmd = new SqlCommand("UploadBrandImg", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@brand", FileName);
            cmd.Parameters.AddWithValue("@status", 1);
            cmd.Parameters.AddWithValue("@title", name);
            cmd.Parameters.AddWithValue("@PNo", PNo);
            cmd.Parameters.AddWithValue("@bid", hdn_Id.Value);

            cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            string msg = cmd.Parameters["@flag"].Value.ToString();
            if (msg == "1")
            {
                if (FileName != "")
                {
                    FileSliderImage.SaveAs(Server.MapPath("~/images/brand_logo/" + FileName));
                }
                utility.MessageBox(this, "Brand Image Uploaded Successfully.");
                BindSliderImage();
                Response.Redirect(Request.RawUrl);
            }
            else
            {
                utility.MessageBox(this, "File Name Already Exists!");
                FileSliderImage.Focus();
                return;
            }

            txt_title.Text = "";
            txt_PNo.Text = "";
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.Message);
        }
    }

    public void BindSliderImage()
    
    {
        try
        {
            
            SqlParameter[] param111 = new SqlParameter[]
            {
                 // new SqlParameter("@IsMain", ddl_type.SelectedValue)
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param111, "Select bid,Title,Img, IsActive,PriorityNo from tbl_Brand");
            if (dt.Rows.Count > 0)
            {
                // Set checkbox checked status based on IsActive value
               // chk_Status.Checked = Convert.ToInt32(row["IsActive"]) == 1;

                    // Use lblID or other data from the row as needed
                dlSliderImage.DataSource = dt;
                dlSliderImage.DataBind();
                foreach (DataListItem item in dlSliderImage.Items)
                {
                    DataRow row = dt.Rows[item.ItemIndex]; // Assuming each item in DataList corresponds to a row in the DataTable

                    CheckBox chk_Status = (CheckBox)item.FindControl("chk_Status");
                    Label lblID = (Label)item.FindControl("lblID");
                   /// Label lblPNo = (Label)item.FindControl("txt_P_No");
                   /// lblPNo.Text = row["PriorityNo"].ToString();

                    // Set checkbox checked status based on IsActive value
                    chk_Status.Checked = Convert.ToInt32(row["IsActive"]) == 1;

                    // Use lblID or other data from the row as needed
                }
            }
            else
            {
                dlSliderImage.DataSource = null;
                dlSliderImage.DataBind();
            }
        }
        catch
        {

        }
    }

    protected void chk_Status_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkStatus = (CheckBox)sender;
        DataListItem item = (DataListItem)chkStatus.NamingContainer;
        Label lblID = (Label)item.FindControl("lblID");
        int statusValue = chkStatus.Checked ? 1 : 0;

        try
        {
            SqlParameter[] param111 = new SqlParameter[]
            {
              new SqlParameter("@bid", lblID.Text),
               new SqlParameter("@Status", statusValue)
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param111,"Update tbl_Brand set IsActive=@Status where bid=@bid");

            dlSliderImage.DataSource = dt;
            dlSliderImage.DataBind();
            BindSliderImage();
        }
        catch (Exception ex)
        {
            // Handle the exception
        }

    }

    protected void lnkDel_Click(object sender, EventArgs e)
    {
        try
        {
            DataListItem item = ((LinkButton)sender).NamingContainer as DataListItem;
            Label lblid = (Label)item.FindControl("lblID");
            System.Web.UI.WebControls.Image imgslide = (System.Web.UI.WebControls.Image)item.FindControl("SliderImage");
            string path = Server.MapPath(imgslide.ImageUrl);
            FileInfo info = new FileInfo(path);
            if (info.Exists)
            {
                info.Delete();
            }
            string id = lblid.Text;
            SqlCommand cmd = new SqlCommand("Delete from tbl_Brand where bid=@id", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@id", id);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            utility.MessageBox(this, "Deleted Successfully.");
            BindSliderImage();
            Response.Redirect(Request.RawUrl);
        }
        catch (Exception ex)
        {

            utility.MessageBox(this, ex.Message);
        }
    }

    protected void txt_PNo_TextChanged(object sender, EventArgs e)
    {
        TextBox PNO = (TextBox)sender;
       
        DataListItem item = (DataListItem)PNO.NamingContainer;
        TextBox txt_PNo = (TextBox)item.FindControl("txt_PNo");
        Label lblID = (Label)item.FindControl("lblID");
        // int statusValue = chkStatus.Checked ? 1 : 0;

        try
        {
            SqlParameter[] param111 = new SqlParameter[]
            {
              new SqlParameter("@bid", lblID.Text),
               new SqlParameter("@PNo", txt_PNo.Text)
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTable(param111, "Update tbl_Brand set PriorityNo=@PNo where bid=@bid");

            dlSliderImage.DataSource = dt;
            dlSliderImage.DataBind();
            BindSliderImage();
        }
        catch (Exception ex)
        {
            // Handle the exception
        }
    }

    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        try
        {

            DataListItem item = ((LinkButton)sender).NamingContainer as DataListItem;
            Label lblid = (Label)item.FindControl("lblID");
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
               {
               new SqlParameter("@Id", lblid.Text)
               };
            SqlDataReader dr = objDu.GetDataReader(param, "Select bid, Title, Img, IsActive, PriorityNo from tbl_brand where bid=@Id");
            while (dr.Read())
            {
                ImgFileSliderImage.Height = Unit.Pixel(200);
                ImgFileSliderImage.Width = Unit.Pixel(300);

                ImgFileSliderImage.ImageUrl = "~/images/brand_logo/" + dr["Img"].ToString();
                txt_title.Text = dr["Title"].ToString();
                //string Rank = dr["Img"].ToString();
                hdn_Id.Value= dr["bid"].ToString();
                txt_PNo.Text = dr["PriorityNo"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
   // }
}