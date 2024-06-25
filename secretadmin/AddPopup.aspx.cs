using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Drawing;

public partial class secretadmin_AddPopup : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
            {
                utility.CheckSuperAdminLogin();
            }
            else if (Convert.ToString(Session["admintype"]) == "a")
            {
                utility.CheckAdminLogin();
            }
            else
            {
                Response.Redirect("adminLog.aspx");
            }
            if (!Page.IsPostBack)
            {

                ddl_SelectType.Items.Insert(0, new ListItem(method.Associate, "A"));
                ddl_SelectType.Items.Insert(0, new ListItem("Welcome &" + " " + method.Associate , "W_A"));
                GetImageList();
            }
        }
        catch
        {

        }
       
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime Enddate = new DateTime();
            try
            {
                Enddate = Convert.ToDateTime(txtEndDate.Text.Trim(), dateInfo);

            }
            catch
            {
                utility.MessageBox(this, "Invalid Date Entry.");
                return;
            }

            if (FilePopupImg.HasFile && !string.IsNullOrEmpty(txtEndDate.Text.Trim()))
            {
                if (Regex.IsMatch(FilePopupImg.FileName, @"^.*\.((j|J)(p|P)(e|E)?(g|G)|(g|G)(i|I)(f|F)|(p|P)(n|N)(g|G))$"))
                {
                    Stream stream = FilePopupImg.PostedFile.InputStream;
                    Bitmap bitimg = new Bitmap(stream);
                    int height = bitimg.Height;
                    int width = bitimg.Width;
                    if (width == 720 && height == 580)
                    {
                        com = new SqlCommand("AddPopupImg", con);
                        com.CommandType = CommandType.StoredProcedure;
                        com.Parameters.AddWithValue("@ValidUpto", Enddate);
                        com.Parameters.AddWithValue("@ImageName", FilePopupImg.FileName);
                        com.Parameters.AddWithValue("@status", 1);
                        com.Parameters.AddWithValue("@Doe", DateTime.UtcNow.AddMinutes(330));
                        com.Parameters.AddWithValue("@SelectType", ddl_SelectType.SelectedValue);
                        com.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;
                        con.Open();
                        com.ExecuteNonQuery(); 
                        string msg = com.Parameters["@flag"].Value.ToString();

                        if (msg == "2")
                        {
                            string path = Server.MapPath("~/images/PopupImage/" + FilePopupImg.FileName);
                            FilePopupImg.SaveAs(path);
                            GetImageList();
                            utility.MessageBox(this, "Saved Successfully.");
                        }
                        else
                        {
                            utility.MessageBox(this, "Image Name Already Exists!");
                            return;
                        }
                    }
                    else
                    {
                        utility.MessageBox(this, "Image size must be width 720px and height 580px.");
                        FilePopupImg.Focus();
                        return;
                    }
                }
                else
                {
                    utility.MessageBox(this, "Only .jpg/.jpeg/.gif/.png file types are allowed.");
                    FilePopupImg.Focus();
                    return;
                }

            }
            else
            {
                utility.MessageBox(this, "All fields are Required.");
                return;
            }
        }
        catch
        {

        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }

    public void GetImageList()
    {
        try
        {
            com = new SqlCommand("GetAllImage", con);
            com.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(com);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                DataPopupImg.DataSource = dt;
                DataPopupImg.DataBind();

            }
            else
            {
                DataPopupImg.DataSource = null;
                DataPopupImg.DataBind();
            }
        }

        catch
        {

        }
    }
    protected void lnkDel_Click(object sender, EventArgs e)
    {
        try
        {
            DataListItem item = ((LinkButton)sender).NamingContainer as DataListItem;
            Label lblid = (Label)item.FindControl("lblID");
            string id = lblid.Text;
            com = new SqlCommand("DelImage", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@id", id);
            con.Open();
            int result = com.ExecuteNonQuery();
            if (result == 1)
            {
                System.Web.UI.WebControls.Image imgpopup = (System.Web.UI.WebControls.Image)item.FindControl("ImgPopup");
                string path = Server.MapPath(imgpopup.ImageUrl);
                FileInfo info = new FileInfo(path);
                if (info.Exists)
                {
                    info.Delete();
                }
                GetImageList();
                utility.MessageBox(this, "Image Deleted Successfully.");
            }
            else
            {
                utility.MessageBox(this, "Couldn't Deleted. try again !!!");
                GetImageList();
            }

        }
        catch
        {

        }
        finally
        {
            con.Close();
            con.Dispose();
        }
    }
}