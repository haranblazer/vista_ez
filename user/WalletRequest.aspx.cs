using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
using System.Data;
using System.IO;

public partial class user_WalletRequest : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    string regno;
    utility obj = new utility();
    SqlDataAdapter da;
    DataUtility objDUT = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

        try
        {
            if (Session["userId"] != null)

                if (string.IsNullOrEmpty(Convert.ToString(Session["userId"])))
                {
                    Response.Redirect("~/login.aspx", false);
                }
                else
                {
                    regno = Session["userId"].ToString().Trim();
                    if (regno == "")
                    {
                        Response.Redirect("~/Error.aspx", false);
                    }
                    if (!Regex.Match(regno, @"^[a-zA-Z0-9]*$").Success)
                    {
                        Response.Redirect("~/Default.aspx", false);
                    }
                }
            else
            {
                Response.Redirect("~/Default.aspx", false);
            }


        }
        catch
        {
            Response.Redirect("~/Default.aspx", false);
        }
        if (!Page.IsPostBack)
        {
            BindCompanydeatils();
            if (Request.QueryString["pid"] != null)
            {
                btnSubmit.CommandName = obj.base64Decode(Request.QueryString["pid"].Trim());
                BindDetail(btnSubmit.CommandName);
            }
        }
    }


    public void BindCompanydeatils()
    {
        ddlCompanybank.Items.Clear();
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("select srno,CompanyBank from companymst where Active=1", con);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlCompanybank.DataSource = dt;
            ddlCompanybank.DataTextField = dt.Columns["CompanyBank"].ToString();
            ddlCompanybank.DataValueField = dt.Columns["srno"].ToString();
            ddlCompanybank.DataBind();
            ddlCompanybank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-Select company Bank Name-", "0"));
        }
        else
        {
            ddlCompanybank.Items.Insert(0, "--Bank Name not found--");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (rdbtn1.SelectedIndex == -1)
        {
            utility.MessageBox(this, "Please Select Request Type..!!");
            return;
        }
        //if (rdbtn1.SelectedValue == "1")
        //{
        //    Serviceinsert();
        //}
        if (rdbtn1.SelectedValue == "0")
        {
            Walletinsert();
        }
    }

    //private void Serviceinsert()
    //{
    //    //txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
    //    con = new SqlConnection(method.str);
    //    System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //    dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //    DateTime paymentDate = new DateTime();
    //    paymentDate = Convert.ToDateTime(txtDate.Text.Trim(), dateInfo);
    //    try
    //    {
    //        com = new SqlCommand("fundload", con);
    //        com.CommandType = CommandType.StoredProcedure;
    //        com.Parameters.AddWithValue("@requestId", btnSubmit.CommandName);
    //        com.Parameters.AddWithValue("@PregNo", regno);
    //        com.Parameters.AddWithValue("@PaymentType", rbtnlstMode.SelectedValue.Trim());
    //        com.Parameters.AddWithValue("@Amt", float.Parse(txtAmount.Text.Trim()));
    //        com.Parameters.AddWithValue("@PaymentDate", (!string.IsNullOrEmpty(txtDate.Text.Trim()) ? paymentDate : DateTime.Now.Date));
    //        com.Parameters.AddWithValue("@CompanyAccNo", txt_CompanyAccNo.Text.Trim());
    //        com.Parameters.AddWithValue("@CompanyBank", ddlCompanybank.SelectedIndex == 0 ? string.Empty : ddlCompanybank.SelectedValue.Trim());
    //        com.Parameters.AddWithValue("@UserAccNo", (string.IsNullOrEmpty(txtUserAccNo.Text.Trim()) ? string.Empty : txtUserAccNo.Text.Trim()));
    //        com.Parameters.AddWithValue("@UserBank", ddlUserbank.SelectedIndex == 0 ? string.Empty : ddlUserbank.SelectedValue.Trim());
    //        com.Parameters.AddWithValue("@TransactionNo", (string.IsNullOrEmpty(txtTransactionNumber.Text.Trim()) ? string.Empty : txtTransactionNumber.Text.Trim()));
    //        com.Parameters.AddWithValue("@Remark", txt_Remark.Text);
    //        com.Parameters.Add(new SqlParameter("@flag", SqlDbType.VarChar, 100));
    //        com.Parameters["@flag"].Direction = ParameterDirection.Output;
    //        con.Open();
    //        com.ExecuteNonQuery();
    //        string msg = com.Parameters["@flag"].Value.ToString();
    //        if (msg == "1")
    //        {
    //            ResetControls();
    //            if (btnSubmit.CommandName.Trim().Length > 0)
    //            {
    //                utility.MessageBox(this, "Load request updated successfully.");
    //                rbtnlstMode.SelectedIndex = -1;
    //                txtAmount.Text = txtTransactionNumber.Text = txtUserAccNo.Text = string.Empty;
    //                txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
    //                ddlCompanybank.SelectedIndex = ddlUserbank.SelectedIndex = 0;

    //            }
    //            else
    //            {
    //                utility.MessageBox(this, "Load request sent to admin successfully.");
    //                rbtnlstMode.SelectedIndex = -1;
    //                txtAmount.Text = txtTransactionNumber.Text = txtUserAccNo.Text = string.Empty;
    //                txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
    //                ddlCompanybank.SelectedIndex = ddlUserbank.SelectedIndex = 0;

    //            }
    //        }
    //        else
    //        {
    //            utility.MessageBox(this, msg);
    //        }
    //        con.Close();

    //    }
    //    catch
    //    {
    //    }

    //}

    private void Walletinsert()
    {

        //txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
        con = new SqlConnection(method.str);
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        DateTime paymentDate = new DateTime();
        paymentDate = Convert.ToDateTime(txtDate.Text.Trim(), dateInfo);

        try
        {
            if (UploadWalletSlip.HasFile)
            {
                //Random random = new Random();
                //string RandNo = random.Next(10000000, 99999999).ToString();
                //string filename = Path.GetFileName(UploadWalletSlip.PostedFile.FileName);
                //var split = filename.Split('.');
                //var fname = split[0];
                //var extension = split[1];
                //if (fname.Length > 10)
                //{
                //    fname = fname.Substring(0, 10);
                //}

                string Random = Guid.NewGuid().ToString();
                string FileName = Random + Path.GetExtension(UploadWalletSlip.FileName);

                com = new SqlCommand("Applywalletrequest", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@requestId", btnSubmit.CommandName);
                com.Parameters.AddWithValue("@PregNo", regno);
                com.Parameters.AddWithValue("@PaymentType", rbtnlstMode.SelectedValue.Trim());
                com.Parameters.AddWithValue("@Amt", float.Parse(txtAmount.Text.Trim()));
                com.Parameters.AddWithValue("@PaymentDate", (!string.IsNullOrEmpty(txtDate.Text.Trim()) ? paymentDate : DateTime.Now.Date));
                com.Parameters.AddWithValue("@CompanyAccNo", txt_CompanyAccNo.Text.Trim());
                com.Parameters.AddWithValue("@CompanyBank", ddlCompanybank.SelectedIndex == 0 ? string.Empty : ddlCompanybank.SelectedValue.Trim());
                com.Parameters.AddWithValue("@UserAccNo", (string.IsNullOrEmpty(txtUserAccNo.Text.Trim()) ? string.Empty : txtUserAccNo.Text.Trim()));
                com.Parameters.AddWithValue("@UserBank", ddlUserbank.SelectedIndex == 0 ? string.Empty : ddlUserbank.SelectedValue.Trim());
                com.Parameters.AddWithValue("@TransactionNo", (string.IsNullOrEmpty(txtTransactionNumber.Text.Trim()) ? string.Empty : txtTransactionNumber.Text.Trim()));
                com.Parameters.AddWithValue("@Remark", txt_Remark.Text);
                com.Parameters.AddWithValue("@SlipImage", FileName);
                com.Parameters.Add(new SqlParameter("@flag", SqlDbType.VarChar, 100));
                com.Parameters["@flag"].Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string msg = com.Parameters["@flag"].Value.ToString();
                if (msg == "1")
                {

                    UploadWalletSlip.PostedFile.SaveAs(Server.MapPath("../User/PaymentSlip/" + FileName));
                    

                    //UploadWalletSlip.PostedFile.SaveAs(Server.MapPath(@"~/User/PaymentSlip/" + RandNo + fname + '.' + extension));
                    ResetControls();
                    if (btnSubmit.CommandName.Trim().Length > 0)
                    {
                        utility.MessageBox(this, "Wallet request updated successfully.");
                        rbtnlstMode.SelectedIndex = -1;
                        txtAmount.Text = txtTransactionNumber.Text = txtUserAccNo.Text = string.Empty;
                        txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                        ddlCompanybank.SelectedIndex = ddlUserbank.SelectedIndex = 0;

                    }
                    else
                    {
                        utility.MessageBox(this, "Wallet request sent to admin successfully.");
                        rbtnlstMode.SelectedIndex = -1;
                        txtAmount.Text = txtTransactionNumber.Text = txtUserAccNo.Text = string.Empty;
                        txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                        ddlCompanybank.SelectedIndex = ddlUserbank.SelectedIndex = 0;

                    }
                }
                else
                {
                    utility.MessageBox(this, msg);
                }
                con.Close();

            }
            else
            {
                utility.MessageBox(this, "Only .jpg/.jpeg/.gif/.png file types are allowed.");
                UploadWalletSlip.Focus();
                return;
            }
        }

        catch (Exception ex)
        {
        }

    }
    private void BindDetail(string srno)
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("select srno,AppmstRegNo,Amount,convert(varchar(50),DOT,103) as DOT,CompanyAccNo,CompanyBank,UserAccNo,UserBank,TransactionNo,PaymentType,status from loadrequestmst where srno=@srno and status=@status", con);
            com.Parameters.AddWithValue("@srno", srno);
            com.Parameters.AddWithValue("@status", 0);
            con.Open();
            SqlDataReader reader = com.ExecuteReader();
            if (reader.HasRows)
            {
                reader.Read();
                rbtnlstMode.SelectedValue = reader["PaymentType"].ToString();
                if (rbtnlstMode.SelectedValue == "CashOffice")
                {
                    rbtnlstMode.Focus();
                    txtAmount.Enabled = txtDate.Enabled = true;
                    txtUserAccNo.Enabled = ddlCompanybank.Enabled = ddlUserbank.Enabled = false;
                    txtTransactionNumber.Text = txtUserAccNo.Text = txtAmount.Text = txt_CompanyAccNo.Text = string.Empty;
                    ddlCompanybank.SelectedIndex = ddlUserbank.SelectedIndex = 0;

                }
                else if (rbtnlstMode.SelectedValue == "CashBank")
                {
                    rbtnlstMode.Focus();
                    txtAmount.Enabled = txtDate.Enabled = ddlCompanybank.Enabled = true;
                    txtUserAccNo.Enabled = ddlUserbank.Enabled = false;
                    txtTransactionNumber.Text = txtUserAccNo.Text = txtAmount.Text = string.Empty;
                    ddlCompanybank.SelectedIndex = ddlUserbank.SelectedIndex = 0;

                }
                else if (rbtnlstMode.SelectedValue == "Cheque" || rbtnlstMode.SelectedValue == "NEFT")
                {
                    rbtnlstMode.Focus();
                    txtAmount.Enabled = txtDate.Enabled = txtUserAccNo.Enabled = ddlCompanybank.Enabled = ddlUserbank.Enabled = true;
                    txtTransactionNumber.Text = txtUserAccNo.Text = txtAmount.Text = string.Empty;
                    ddlCompanybank.SelectedIndex = ddlUserbank.SelectedIndex = 0;

                }
                else
                {
                }

                txtAmount.Text = reader["Amount"].ToString();
                txtDate.Text = reader["DOT"].ToString();
                //ddlCompanyAccNo.SelectedIndex = ddlCompanyAccNo.Items.IndexOf(ddlCompanyAccNo.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, reader["CompanyAccNo"].ToString(), true) == 0).FirstOrDefault());
                ddlCompanybank.SelectedIndex = ddlCompanybank.Items.IndexOf(ddlCompanybank.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, reader["CompanyBank"].ToString(), true) == 0).FirstOrDefault());
                txtUserAccNo.Text = reader["UserAccNo"].ToString();
                ddlUserbank.SelectedIndex = ddlUserbank.Items.IndexOf(ddlUserbank.Items.Cast<ListItem>().Where(o => string.Compare(o.Text, reader["UserBank"].ToString(), true) == 0).FirstOrDefault());
                txtTransactionNumber.Text = reader["TransactionNo"].ToString();

            }
        }
        catch
        {
        }
    }

    private void ResetControls()
    {
        foreach (Control ctrl in ((ContentPlaceHolder)Master.FindControl("ContentPlaceHolder1")).Controls)
        {
            if (ctrl is TextBox)
                ((TextBox)ctrl).Text = string.Empty;
            if (ctrl is DropDownList)
                ((DropDownList)ctrl).SelectedIndex = 0;
            if (ctrl is RadioButtonList)
                ((RadioButtonList)ctrl).SelectedIndex = 0;
        }
    }

    protected void rbtnlstMode_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (rbtnlstMode.SelectedValue == "CashOffice")
        {
            rbtnlstMode.Focus();
            txtAmount.Enabled = txtDate.Enabled = true;
            txtUserAccNo.Enabled = ddlCompanybank.Enabled = ddlUserbank.Enabled = false;
            txtTransactionNumber.Text = txtUserAccNo.Text = txtAmount.Text = txt_CompanyAccNo.Text = string.Empty;
            ddlCompanybank.SelectedIndex = ddlUserbank.SelectedIndex = 0;
            vali.Visible = false;
            RequiredFieldValidator5.Enabled = false;
            RegularExpressionValidator2.Enabled = false;
        }
        else if (rbtnlstMode.SelectedValue == "CashBank")
        {
            rbtnlstMode.Focus();
            txtAmount.Enabled = txtDate.Enabled = ddlCompanybank.Enabled = true;
            txtUserAccNo.Enabled = ddlUserbank.Enabled = false;
            txtTransactionNumber.Text = txtUserAccNo.Text = txtAmount.Text = string.Empty;
            ddlCompanybank.SelectedIndex = ddlUserbank.SelectedIndex = 0;
            vali.Visible = true;
            RequiredFieldValidator5.Enabled = true;
            RegularExpressionValidator2.Enabled = true;
        }
        else if (rbtnlstMode.SelectedValue == "Cheque" || rbtnlstMode.SelectedValue == "NEFT")
        {
            rbtnlstMode.Focus();
            txtAmount.Enabled = txtDate.Enabled = txtUserAccNo.Enabled = ddlCompanybank.Enabled = ddlUserbank.Enabled = true;
            txtTransactionNumber.Text = txtUserAccNo.Text = txtAmount.Text = string.Empty;
            ddlCompanybank.SelectedIndex = ddlUserbank.SelectedIndex = 0;
            vali.Visible = true;
            RequiredFieldValidator5.Enabled = true;
            RegularExpressionValidator2.Enabled = true;
        }
        else
        {
        }
    }
    protected void ddlCompanybank_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCompanybank.SelectedIndex != 0)
        {
            string Result = objDUT.GetScalar("select CompanyAccNo from companymst where Active=1 and srno=" + ddlCompanybank.SelectedValue).ToString();
            txt_CompanyAccNo.Text = Result.ToString();
        }
        else
        {
            txt_CompanyAccNo.Text = "";
        }
    }
}

