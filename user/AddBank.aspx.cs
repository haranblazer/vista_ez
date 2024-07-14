using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;


public partial class user_AddBank : System.Web.UI.Page
{
    SqlConnection con = null;
    DataTable dt = null;
    SqlCommand com;
    SqlDataAdapter da;
    InsertFunction insFunc = new InsertFunction();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] != null)
        {

            if (!IsPostBack)
            {
                BindBank();
                bankdetail();
                btnreject.Style.Add("display", "none");
                check_status();
               
            }
        }
        else
        {
            Response.Redirect("~/login.aspx");
        }


    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(method.str);
            string queryr = "select BankImage from scandocs inner join AppMst on Appmst.AppMstID=scandocs.Appmstid where Appmst.AppMstRegNo='" + Session["userId"] + "'";
            SqlCommand cmd1 = new SqlCommand(queryr, con);
            con.Open();
            cmd1.ExecuteScalar();
            using (SqlDataReader reader = cmd1.ExecuteReader(CommandBehavior.CloseConnection))
            {
                while (reader.Read())
                {
                    string bankImage = reader["BankImage"].ToString();
                    if (bankImage != "")
                    {
                        string imgPath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), bankImage);
                        System.IO.File.Delete(imgPath);
                        Response.Write("Image deleted");
                    }
                }
            }
            string upStatus = "Update scandocs set bankstatus=0,BankImage=null from scandocs inner join AppMst on scandocs.Appmstid=AppMst.AppMstID where  AppMst.AppMstRegNo ='" + Session["userId"] + "'";
            SqlCommand cmd = new SqlCommand(upStatus, con);
            con.Open();
            cmd.ExecuteNonQuery();
            //txtPANDetails.ReadOnly = false;
            fileCancelCq.Enabled = true;
            btnInsert.Visible = true;
            imgUpload1.Visible = false;
            btnreject.Visible = false;
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void check_status()
    {
        try
        {
            con = new SqlConnection(method.str);
            string query1 = "select  scandocs.bankstatus as bkstatus,BankImage from scandocs inner join AppMst on scandocs.Appmstid=Appmst.AppMstID where AppMst.AppMstRegNo='" + Session["userId"] + "'";
            SqlCommand cmd = new SqlCommand(query1, con);
            con.Open();
            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    string bankstatus = reader["bkstatus"].ToString();
                    string bankImg = reader["BankImage"].ToString();
                    if (reader["bkstatus"].ToString() == "2")
                    {
                        ddlBankName.Enabled = false;
                        ddlAcType.Enabled = false;
                        txtAccNo.Enabled = false;
                        txtbranch.Enabled = false;
                        txtifs.Enabled = false;
                        fileCancelCq.Enabled = false;
                        ddlAcType.Enabled = false;
                        //btnreject.Visible = false;
                        if (bankImg != "")
                        {
                            imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + bankImg;

                        }
                    }
                    else if (reader["bkstatus"].ToString() == "0")
                    {
                        bankdetail();
                        //ddlBankName.SelectedIndex = 0;
                        //ddlAcType.SelectedIndex = 0;
                        //txtAccNo.Text = "";
                        //txtbranch.Text = "";
                        //txtifs.Text = "";
                        imgUpload1.Style.Add("display", "none");
                        btnreject.Style.Add("display", "none");
                    }
                    else if (reader["bkstatus"].ToString() == "1")
                    {
                        bankdetail();
                        ddlBankName.Enabled = false;
                        ddlAcType.Enabled = false;
                        txtAccNo.Enabled = false;
                        txtbranch.Enabled = false;
                        txtifs.Enabled = false;
                        fileCancelCq.Enabled = false;
                        imgUpload1.Style.Add("display", "block");
                        imgUpload1.ImageUrl = "~/images/KYC/BankImage/" + bankImg;
                        //rotateImg.Style.Add("display", "block");
                        btnreject.Style.Add("display", "block");
                    }
                    else
                    {

                    }

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void btnInsert_Click(object sender, EventArgs e)
    {
        string Cropfilename;
        string fileName = Path.GetFileName(fileCancelCq.PostedFile.FileName);
        string fileExtension = Path.GetExtension(fileName).ToLower();
        string filePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), Guid.NewGuid().ToString() + fileName);
        if (System.IO.File.Exists(filePath))
        {
            System.IO.File.Delete(filePath);

        }
        fileCancelCq.PostedFile.SaveAs(filePath);
        string cropFilePath = "";
        if (!string.IsNullOrEmpty(filePath))
        {
            System.Drawing.Image orgImg = System.Drawing.Image.FromFile(filePath);
            Rectangle CropArea = new Rectangle(
                Convert.ToInt32(X.Value),
                Convert.ToInt32(Y.Value),
                Convert.ToInt32(W.Value),
                Convert.ToInt32(H.Value));
            try
            {
                Bitmap bitMap = new Bitmap(CropArea.Width, CropArea.Height);
                using (Graphics g = Graphics.FromImage(bitMap))
                {
                    g.DrawImage(orgImg, new Rectangle(0, 0, bitMap.Width, bitMap.Height), CropArea, GraphicsUnit.Pixel);
                }

                Cropfilename = "BK" + Guid.NewGuid().ToString() + fileName;
                cropFilePath = Path.Combine(Server.MapPath("~/images/KYC/BankImage/"), Cropfilename);
                bitMap.Save(cropFilePath);
                imgUpload1.ImageUrl = cropFilePath;
                string ddlBkName = ddlBankName.SelectedItem.Text.Trim();
                string ddlActype = ddlAcType.SelectedItem.Text.Trim();
                string txtAccno = txtAccNo.Text.Trim();
                string txtIfsc = txtifs.Text.Trim();
                string usrId = Session["userId"].ToString();
                string txtBranch = txtbranch.Text.Trim();
                insFunc.insertBankDetail(Cropfilename, ddlBkName, ddlActype, txtAccno, txtIfsc, txtBranch, usrId);
                string strHtml1 = string.Format("<div class='alert alert-success alert-dismissible' style='background-color: #a2c842;' role='alert'> <strong>Successfully!</strong>Your Bank details uploaded successfully</div>");
                confirm.InnerHtml = strHtml1;
                check_status();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }

    public void BindBank()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetBank", con);
            com.CommandType = CommandType.StoredProcedure;

            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlBankName.DataSource = dt;
            ddlBankName.DataTextField = "BankName";
            ddlBankName.DataValueField = "SrNo";
            ddlBankName.DataBind();
            ddlBankName.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch
        {

        }
    }


    public void bankdetail()
    {
        try
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("select bankname,acountno,branch,ifscode,type from appmst where appmstregno='" + Session["userId"].ToString() + "' ", con);
            SqlDataReader sdr;
            con.Open();
            sdr = cmd.ExecuteReader();
            while (sdr.Read())
            {

                txtAccNo.Text = sdr["acountno"].ToString();
                txtbranch.Text = sdr["branch"].ToString();
                txtifs.Text = sdr["ifscode"].ToString();
                ddlAcType.SelectedIndex = ddlAcType.Items.IndexOf(ddlAcType.Items.Cast<System.Web.UI.WebControls.ListItem>().Where(o => string.Compare(o.Value, sdr["type"].ToString(), true) == 0).FirstOrDefault());

                try
                {

                    ddlBankName.SelectedIndex = ddlBankName.Items.IndexOf(ddlBankName.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, sdr["bankname"].ToString(), true) == 0).FirstOrDefault());

                }
                catch
                {

                }
            }

            sdr.Close();
            con.Close();
        }
        catch
        {

        }
    }

}