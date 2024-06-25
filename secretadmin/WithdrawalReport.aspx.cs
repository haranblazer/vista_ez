using System;
using System.Data; 
using System.Web.UI; 
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Collections.Generic;

public partial class admin_WithdrawalReport : Page
{
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

        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.AddDays(-7).ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            //bindgrid();
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string ReqType, string userid, string TranId)
    {

        List<UserDetails> details = new List<UserDetails>();
        try
        {
            SqlParameter[] param = new SqlParameter[]
          {
                 new SqlParameter("@fromdate", min),
                 new SqlParameter("@todate", max),
                 new SqlParameter("@reqtype", ReqType),
                 new SqlParameter("@regno", userid),
                 new SqlParameter("@TranId", TranId)
          };
            DataUtility objDu = new DataUtility();
            SqlDataReader dr = objDu.GetDataReaderSP(param, "WithdrawReportAfterApproval");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.withdrawid = dr["withdrawid"].ToString();
                data.userId = dr["userId"].ToString();
                data.fname = dr["fname"].ToString();
                data.WAmount = dr["WAmount"].ToString();
                data.Additions = dr["Additions"].ToString();
                data.Deductions = dr["Deductions"].ToString();
                data.Dispatch = dr["Dispatch"].ToString();
                data.withdrawdate = dr["withdrawdate"].ToString(); 
                data.RequestType = dr["RequestType"].ToString();
                data.Bankname = dr["Bankname"].ToString();
                data.Branch = dr["Branch"].ToString();
                data.AccountNo = dr["AccountNo"].ToString();
                data.IFSCode = dr["IFSCode"].ToString();
                data.panno = dr["panno"].ToString();
                data.PaymentDate = dr["PaymentDate"].ToString();
                data.PaymentDetail = dr["PaymentDetail"].ToString();
                data.Narration = dr["Narration"].ToString();
                data.Remarks = dr["Remarks"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string withdrawid { get; set; }
        public string userId { get; set; }
        public string fname { get; set; }
        public string WAmount { get; set; }
        public string Additions { get; set; }
        public string Deductions { get; set; }
        public string Dispatch { get; set; }
        public string withdrawdate { get; set; }
        public string RequestType { get; set; }
        public string Bankname { get; set; }
        public string Branch { get; set; }
        public string AccountNo { get; set; }
        public string IFSCode { get; set; }
        public string panno { get; set; }
        public string PaymentDate { get; set; }
        public string PaymentDetail { get; set; }
        public string Narration { get; set; }
        public string Remarks { get; set; }
    }

    #endregion





    //private void bindgrid()
    //{
    //    try
    //    {
    //        string fromDate = "", toDate = "";
    //        try
    //        {
    //            if (txtFromDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                fromDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //            if (txtToDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                toDate = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid date entry.");
    //            return;
    //        }

    //        SqlParameter[] param = new SqlParameter[]
    //       {
    //             new SqlParameter("@fromdate", fromDate),
    //             new SqlParameter("@todate", toDate),
    //             new SqlParameter("@reqtype", ddlReqType.SelectedValue),
    //             new SqlParameter("@regno", txt_userid.Text.Trim())
    //       };
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTableSP(param, "WithdrawReportAfterApproval");

    //        GrdWithdraw.Columns[4].FooterText = dt.Compute("sum(WAmount)", "true").ToString();
    //        GrdWithdraw.Columns[5].FooterText = dt.Compute("sum(Additions)", "true").ToString();
    //        GrdWithdraw.Columns[6].FooterText = dt.Compute("sum(Deductions)", "true").ToString();
    //        GrdWithdraw.Columns[7].FooterText = dt.Compute("sum(Dispatch)", "true").ToString();

    //        GrdWithdraw.DataSource = dt;
    //        GrdWithdraw.DataBind();
    //    }
    //    catch
    //    {
    //        return;
    //    }
    //}


    protected void btnbulkcopy_Click(object sender, EventArgs e)
    {
        try
        {
            if (FileUpload1.HasFile)
            {
                DataTable dt = new DataTable();
                dt = ReadCsvFile();

                if (dt.Rows.Count > 0)
                {
                    SqlConnection con = new SqlConnection(method.str);
                    SqlCommand cmd = new SqlCommand("UpdateWithDrawalFile", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter tvparam = cmd.Parameters.AddWithValue("@dt", dt);
                    cmd.Parameters.Add("@flag", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    tvparam.SqlDbType = SqlDbType.Structured;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    string status = cmd.Parameters["@flag"].Value.ToString();
                    con.Close();
                    if (status == "1")
                    {
                        btnbulkcopy.Enabled = false;
                        //bindgrid();

                        utility.MessageBox(this, "Your details save successfully.!!");
                        return;
                    }
                    else
                    {
                        utility.MessageBox(this, status);
                        return;
                    }

                }
            }
            else
            {
                utility.MessageBox(this, "Please Select CSV File !!!");
            }
        }
        catch (Exception EX)
        {
            utility.MessageBox(this, EX.Message.ToString());

        }
    }


    private DataTable ReadCsvFile()
    {

        DataTable dtCsv = new DataTable();
        string Fulltext;
        if (FileUpload1.HasFile)
        {
            string FileName = Path.GetFileName(Guid.NewGuid().ToString() + FileUpload1.PostedFile.FileName);

            string FileSaveWithPath = Server.MapPath("~/secretadmin/ProductDoc/" + FileName);
            FileUpload1.SaveAs(FileSaveWithPath);
            using (StreamReader sr = new StreamReader(FileSaveWithPath))
            {
                while (!sr.EndOfStream)
                {
                    Fulltext = sr.ReadToEnd().ToString(); //read full file text  
                    string[] rows = Fulltext.Split('\n'); //split full file text into rows  
                    for (int i = 0; i < rows.Count() - 1; i++)
                    {
                        string[] rowValues = rows[i].Split(','); //split each row with comma to get individual values  
                        {
                            if (i == 0)
                            {
                                for (int j = 0; j < rowValues.Count(); j++)
                                {
                                    dtCsv.Columns.Add(rowValues[j]); //add headers  
                                }
                            }
                            else
                            {
                                DataRow dr = dtCsv.NewRow();
                                for (int k = 0; k < rowValues.Count(); k++)
                                {
                                    if (k == 8)
                                    {
                                        try
                                        {
                                            String[] Date = rowValues[k].ToString().Split(new String[] { "-" }, StringSplitOptions.RemoveEmptyEntries);
                                            dr[k] = Date[1] + "/" + Date[0] + "/" + Date[2];
                                        }
                                        catch { }
                                    }
                                    else
                                    {
                                        dr[k] = rowValues[k].ToString();
                                    }
                                }
                                dtCsv.Rows.Add(dr); //add other rows  
                            }
                        }
                    }
                }
            }
        }
        return dtCsv;
    }


    //protected void dgrd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GrdWithdraw.PageIndex = e.NewPageIndex;
    //    bindgrid();
    //}

    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    bindgrid();
    //}

    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (GrdWithdraw.Rows.Count > 0)
    //    {
    //        GrdWithdraw.AllowPaging = false;
    //        bindgrid();
    //        GrdWithdraw.FooterRow.Visible = false;
    //        Response.Clear();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_WithdrawalReport.xls");
    //        Response.Charset = "";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        GrdWithdraw.RenderControl(htmlWrite);
    //        Response.Write(stringWrite.ToString());
    //        Response.End();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Can't export as no data found.");
    //    }
    //}
    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}

}