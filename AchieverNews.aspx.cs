using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Data.SqlClient;

public partial class secretadmin_AchieverNews : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;

    protected void Page_Load(object sender, EventArgs e)
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
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime dt = System.DateTime.UtcNow.AddMinutes(330);

            if (!string.IsNullOrEmpty(txtName.Text.Trim()))
            {
                if (!string.IsNullOrEmpty(txtDesc.Text.Trim()))
                {
                    com = new SqlCommand("sp_news", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@NewsMstValidUpTo", dt);
                    com.Parameters.AddWithValue("@NewsMstTitle", txtName.Text.Trim());
                    com.Parameters.AddWithValue("@NewsMstDiscription", txtDesc.Text.Trim());
                    com.Parameters.AddWithValue("@CurrentRecord", 1);
                    com.Parameters.AddWithValue("@type", "H");

                    com.Parameters.AddWithValue("@iName", FileUpload.HasFile == false ? "0" : txtName.Text.Trim().Replace(" ", "").ToString() + System.IO.Path.GetExtension(this.FileUpload.PostedFile.FileName).ToString());

                    com.Parameters.Add("@ImageName", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
                    con.Open();
                    int p = com.ExecuteNonQuery();
                    if (p > 0)
                    {
                        if (!String.IsNullOrEmpty(com.Parameters["@ImageName"].Value.ToString()))
                        {
                            string strPostedFile = (string)com.Parameters["@ImageName"].Value;
                            string targetPath = Server.MapPath("~/NotificationImages/" + strPostedFile);
                            FileUpload.SaveAs(targetPath);

                        }
                        utility.MessageBox(this, "Achivers added successfully!");
                        txtName.Text = txtDesc.Text = string.Empty;
                        con.Close();

                    }
                    else
                    {
                        utility.MessageBox(this, "Unsuccessful!");
                    }
                }
                else
                    utility.MessageBox(this, "Please enter your name!");
            }
            else
                utility.MessageBox(this, "Please enter your Description!");
        }

        catch (Exception ex)
        {
        }

    }




}
