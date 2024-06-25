using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text.RegularExpressions;
using System.IO;
using System.Drawing;
using Image = System.Web.UI.WebControls.Image;

public partial class secretadmin_UploadTestimonial : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
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

            if (!IsPostBack)
            {
                BindTestimonial();
            }
        }
        catch
        {

        }

    }


    protected void btnUpload_Click(object sender, EventArgs e)
    {
        try
        {
            if (FileTestimonial.HasFile)
            {

                //string FileName = FileTestimonial.PostedFile.FileName;
                string Random = Guid.NewGuid().ToString();
                string FileName = Random + Path.GetExtension(FileTestimonial.FileName);
                Stream stream = FileTestimonial.PostedFile.InputStream;
                Bitmap bitimg = new Bitmap(stream);
                int heights = bitimg.Height;
                int widths = bitimg.Width;
                if (widths == 100 && heights == 100)
                {

                    if (Regex.Match(FileTestimonial.FileName, @"^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$").Success)
                    {
                        cmd = new SqlCommand("UploadTestimonial", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Url", FileName);
                        cmd.Parameters.AddWithValue("@Desc", txtDesc.Text.Trim());
                        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@UploadedDate", DateTime.UtcNow.AddMinutes(330));
                        cmd.Parameters.AddWithValue("@Status", 1);
                        cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        string msg = cmd.Parameters["@flag"].Value.ToString();
                        if (msg == "2")
                        {

                            //string path = Server.MapPath("~/Testimonial/" + FileName);
                            //FileTestimonial.SaveAs(path);

                            FileTestimonial.SaveAs(Server.MapPath("~/Testimonial/" + FileName));


                            utility.MessageBox(this, "Uploaded Successfully.");
                            txtName.Text = txtDesc.Text = string.Empty;
                        }
                        else
                        {
                            utility.MessageBox(this, "File Name Already Exists!");
                            return;
                        }
                    }
                    else
                    {
                        utility.MessageBox(this, "Only .jpg/.jpeg/.gif/.png file types are allowed.");
                        return;
                    }
                }
                else
                {
                    utility.MessageBox(this, "Image size must be width 100 and height 100.");
                    return;
                }
            }
            else
            {
                utility.MessageBox(this, "Please select a file.");
                return;
            }
            BindTestimonial();
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


    public void BindTestimonial()
    {
        try
        {
            da = new SqlDataAdapter("GetAllTestimonial", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                GRDTestimonial.DataSource = dt;
                GRDTestimonial.DataBind();

            }
            else
            {
                GRDTestimonial.DataSource = null;
                GRDTestimonial.DataBind();

            }
        }
        catch
        {
        }
    }

    protected void btnDel_Click(object sender, EventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            Label lblid = (Label)row.FindControl("lblId");
            string id = lblid.Text.Trim();
            Image imgtestimonial = (Image)row.FindControl("testimonialimg");
            string path = Server.MapPath(imgtestimonial.ImageUrl);
            FileInfo info = new FileInfo(path);
            if (info.Exists)
            {
                info.Delete();
                info.Refresh();
            }
            cmd = new SqlCommand("DelTestimonial", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", Convert.ToInt32(id));
            con.Open();
            int result = cmd.ExecuteNonQuery();
            con.Close();
            if (result > 0)
            {
                utility.MessageBox(this, "Testimonial Deleted Successfully.");
            }
            BindTestimonial();
        }


        catch
        {

        }
    }
}