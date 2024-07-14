using System;
using System.Data.SqlClient;
using System.IO;
using System.Data;
using System.Web.UI.WebControls;

public partial class User_AddNotification : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                    Response.Redirect("~/Login.aspx");
                else
                { 
                    DataUtility objDu = new DataUtility();
                    DataTable dt = objDu.GetDataTable(@"Select Tlper from AppMst where AppMstRegno='" + Session["userId"].ToString() + "'");
                    if (dt.Rows.Count > 0)
                    {
                        if (Convert.ToInt32(dt.Rows[0]["Tlper"].ToString()) <=4)
                        {
                            Response.Redirect("Logout.aspx");
                        }
                    }
                    BindRank(); 
                } 
            }
        }
        catch
        {
        }
    }


    protected void btn_Submit_Click(object sender, EventArgs e)
    {

        if (string.IsNullOrEmpty(txtDescription1.Text.Trim()))
        {
            utility.MessageBox(this, "Please Enter Message.!!");
            return;
        }

        String ImgName = "";
        if (fuUpload.HasFile)
        {
            string Random = Guid.NewGuid().ToString();
            ImgName = Path.GetFileName(Random + Path.GetExtension(fuUpload.FileName));
        }

        string GenRank = "";

        foreach (ListItem item in chk_Rank.Items)
        {
            if (item.Selected)
            {
                GenRank = GenRank + item.Value +",";
            } 
        }


        SqlConnection con = new SqlConnection(method.str);
        try
        {
            SqlCommand com = new SqlCommand("AddNotification", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@UserId", Session["userId"].ToString());
            com.Parameters.AddWithValue("@ImgName", ImgName);
            com.Parameters.AddWithValue("@Msg", txtDescription1.Text.Trim());
            com.Parameters.AddWithValue("@GenRank", GenRank);
            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.CommandTimeout = 999999;
            com.ExecuteNonQuery();
            if (com.Parameters["@flag"].Value.ToString() == "1")
            {
                if (fuUpload.HasFile)
                {
                    fuUpload.PostedFile.SaveAs(Server.MapPath("~/images/" + ImgName));
                }
                utility.MessageBox(this, "Your details save successfully.!!");
                Response.Redirect("NotificationList.aspx");

                txtDescription1.Text = "";
                foreach (ListItem item in chk_Rank.Items)
                {
                    item.Selected = false;

                }
                chk_Rank.SelectedIndex = -1;

                
            }
            else
            {
                utility.MessageBox(this, com.Parameters["@flag"].Value.ToString());
            }
        }
        catch (Exception ex)
        {
            utility.MessageBox(this, ex.Message);
        }
        finally
        {
            con.Close();
        }
    }


    private void BindRank()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(@"Select Rankid, RankName from RePurchase_Slab where Rankid>=4 and Rankid<(Select Tlper from AppMst where AppMstRegno='"+ Session["userId"].ToString() + "')");
        chk_Rank.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            chk_Rank.DataSource = dt;
            chk_Rank.DataTextField = "RankName";
            chk_Rank.DataValueField = "Rankid";
            chk_Rank.DataBind(); 
        } 
    }
}