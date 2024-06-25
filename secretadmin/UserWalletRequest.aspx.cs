using System;
using System.Data;
using System.Web;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.Services;

public partial class secretadmin_UserWalletRequest : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand com = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFromdate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            txtTodate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            // BindData();
            Session["CheckRefresh"] = System.DateTime.Now.ToString();

        }
    }


    //private void BindData()
    //{
    //    System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //    dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //    //DateTime validDate = Convert.ToDateTime(toDate, dateInfo); 

    //    DateTime from;
    //    DateTime to;
    //    if (!string.IsNullOrEmpty(txtFromdate.Text.Trim()) && !string.IsNullOrEmpty(txtTodate.Text.Trim()))
    //    {
    //        try
    //        {
    //            from = Convert.ToDateTime(txtFromdate.Text.Trim(), dateInfo);
    //            to = Convert.ToDateTime(txtTodate.Text.Trim(), dateInfo);
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid date entry.");
    //            return;
    //        }
    //    }
    //    else
    //    {
    //        from = DateTime.Now.Date;
    //        to = DateTime.Now.Date;
    //    }

    //    double datedays = (to - from).TotalDays;
    //    if (datedays > 366)
    //    {
    //        utility.MessageBox(this, "Maximum 366 days allowed");
    //        GridView1.DataSource = null;
    //        GridView1.DataBind();
    //        return;
    //    }


    //    con = new SqlConnection(method.str);
    //    com = new SqlCommand("userWalletRequest", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.CommandTimeout = 9999999;
    //    if (!string.IsNullOrEmpty(txtFromdate.Text.Trim()))
    //        com.Parameters.AddWithValue("@fromdate", from);
    //    if (!string.IsNullOrEmpty(txtTodate.Text.Trim()))
    //        com.Parameters.AddWithValue("@Todate", to);

    //    try
    //    {
    //        SqlDataAdapter adapter = new SqlDataAdapter();
    //        DataTable dt = new DataTable();
    //        adapter.SelectCommand = com;
    //        adapter.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {
    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();
    //            LblTotalRecord.Text = "Total Records:" + dt.Rows.Count.ToString();
    //            object objSum;
    //            objSum = dt.Compute("Sum(amt)", "1 = 1");
    //            LblAmount.Text = "Total Amount:" + (string.IsNullOrEmpty(objSum.ToString()) ? "0" : objSum.ToString());
    //        }
    //        else
    //        {
    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();
    //        }
    //    }
    //    catch
    //    {
    //    }

    //}
    //protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindData();
    //}


    /// <summary>
    /// This method is used for export the data
    /// </summary>
    /// <param name="control"></param>

    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}


    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    BindData();
    //}



    /// <summary>
    /// 
    /// </summary>
    [WebMethod]
    public static string App_Rej(string srno, string regno, string coment, string epwd, string status, string Amt)
    {
        string result = "";
        //if (HttpContext.Current.Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
        //{
        //    HttpContext.Current.Session["CheckRefresh"] = System.DateTime.Now.ToString();
        //SqlConnection con = new SqlConnection(method.str);
        //SqlCommand com = new SqlCommand("Select ePassword from controlmst where username=@admin ", con);
        //com.CommandType = CommandType.Text;
        //com.Parameters.AddWithValue("@admin", HttpContext.Current.Session["admin"].ToString());
         

        DataUtility objDu = new DataUtility();
        string Epass  = objDu.GetScalar("Select ePassword from controlmst where username='"+HttpContext.Current.Session["admin"].ToString()+"'").ToString();
        utility obj=new utility();
        if (obj.base64Decode(Epass) == epwd)
        {
            epwd = Epass;
        }
        else
        {
            return "Invalid Transaction Password";

        }
            try
            {
                utility objutil = new utility();
                //ApproveLoad(@Srno int,@regno varchar(50),@status int,@coment varchar(200),@Epwd varchar(50),@flag varchar(100) output)
                SqlConnection con = new SqlConnection(method.str);
                SqlCommand com = new SqlCommand("ApproveUserWallet", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@admin", HttpContext.Current.Session["admin"].ToString());
                com.Parameters.AddWithValue("@Srno", srno);
                com.Parameters.AddWithValue("@regno", regno);
                com.Parameters.AddWithValue("@status", status);
                com.Parameters.AddWithValue("@coment", coment);
                com.Parameters.AddWithValue("@Epwd", Epass);
                com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                result = com.Parameters["@flag"].Value.ToString();
                con.Close();
                con.Dispose();
                if (result == "1")
                {
                    //BindData();
                    // utility.MessageBox(this, status == 1 ? "Amount wallet approved successfully." : "Amount wallet rejected.");

                    if (status == "1")
                    {
                       // DataUtility objDu = new DataUtility();
                        SqlParameter[] param1 = new SqlParameter[]
                        { new SqlParameter("@userid", regno)};

                        DataTable dt = objDu.GetDataTable(param1, "Select Appmstfname, AppMstMobile, Doe=convert(nvarchar(10), getdate(), 103) from AppMst where Appmstregno=@userid");
                        if (dt.Rows.Count > 0)
                        {
                            utility objUtil = new utility();
                            string text = "Dear " + dt.Rows[0]["Appmstfname"].ToString() + " ID No : " + regno + " " + dt.Rows[0]["Doe"].ToString() + " Wallet " + Amt + " Received Successfully CJ STORE";
                            objUtil.sendSMSCjstore(dt.Rows[0]["AppMstMobile"].ToString().Trim(), text);
                        }
                    }
                }
                //else
                //{
                //    utility.MessageBox(this, msg);
                //}
            }

            catch (Exception e)
            {
                result = "TRY LATER!";
            }
        
        return result;
    }

    private void ApproveRequest(int srno, string regno, int status, string coment, string epassword)
    {
        if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();
            try
            {
                utility objutil = new utility();
                //ApproveLoad(@Srno int,@regno varchar(50),@status int,@coment varchar(200),@Epwd varchar(50),@flag varchar(100) output)
                con = new SqlConnection(method.str);
                com = new SqlCommand("ApproveUserWallet", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@admin", Session["admin"].ToString());
                com.Parameters.AddWithValue("@Srno", srno);
                com.Parameters.AddWithValue("@regno", regno);
                com.Parameters.AddWithValue("@status", status);
                com.Parameters.AddWithValue("@coment", coment);
                com.Parameters.AddWithValue("@Epwd", epassword);
                com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                com.ExecuteNonQuery();
                string msg = com.Parameters["@flag"].Value.ToString();
                con.Close();
                con.Dispose();
                if (msg == "1")
                {
                    //BindData();
                    utility.MessageBox(this, status == 1 ? "Amount wallet approved successfully." : "Amount wallet rejected.");

                    if (status == 1)
                    {
                        DataUtility objDu = new DataUtility();
                        SqlParameter[] param1 = new SqlParameter[]
                        { new SqlParameter("@userid", hnd_userid.Value)};

                        DataTable dt = objDu.GetDataTable(param1, "Select Appmstfname, AppMstMobile, Doe=convert(nvarchar(10), getdate(), 103) from AppMst where Appmstregno=@userid");
                        if (dt.Rows.Count > 0)
                        {
                            utility objUtil = new utility();
                            string text = "Dear " + dt.Rows[0]["Appmstfname"].ToString() + " ID No : " + hnd_userid.Value + " " + dt.Rows[0]["Doe"].ToString() + " Wallet " + hnd_amt.Value + " Received Successfully CJ STORE";
                            objUtil.sendSMSCjstore(dt.Rows[0]["AppMstMobile"].ToString().Trim(), text);
                        }
                    }
                }
                else
                {
                    utility.MessageBox(this, msg);
                }
            }
            catch (Exception e)
            {
                utility.WriteErrorLog(e.Message + " ApproveRequest srno:" + srno + ",regno:" + regno + ",status:" + status + ",comment:" + coment);
                utility.MessageBox(this, "TRY LATER!");
            }
        }
        else
        {

        }
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        if (GridView1.Rows.Count > 0)
    //        {
    //            GridView1.AllowPaging = false;
    //            GridView1.Columns[5].Visible = GridView1.Columns[8].Visible = GridView1.Columns[9].Visible = false;
    //            BindData();
    //            Response.ClearContent();
    //            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.xls");
    //            Response.ContentType = "application/vnd.xls";
    //            System.IO.StringWriter stw = new System.IO.StringWriter();
    //            HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //            GridView1.RenderControl(htextw);
    //            Response.Write(stw.ToString());
    //            Response.End();

    //        }
    //        else

    //            utility.MessageBox(this, "record not found,can not export.");
    //    }
    //    catch
    //    {

    //    }
    //}
    //protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        if (GridView1.Rows.Count > 0)
    //        {
    //            GridView1.AllowPaging = false;
    //            GridView1.Columns[5].Visible = GridView1.Columns[8].Visible = GridView1.Columns[9].Visible = false;
    //            BindData();
    //            Response.ClearContent();
    //            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.doc");
    //            Response.ContentType = "application/vnd.ms-word";
    //            System.IO.StringWriter stw = new System.IO.StringWriter();
    //            HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //            GridView1.RenderControl(htextw);
    //            Response.Write(stw.ToString());
    //            Response.End();

    //        }
    //        else

    //            utility.MessageBox(this, "record not found,can not export.");
    //    }
    //    catch
    //    {

    //    }
    //}
    //protected void imgbtnPdf_Click(object sender, ImageClickEventArgs e)
    //{
    //    try
    //    {
    //        if (GridView1.Rows.Count > 0)
    //        {
    //            GridView1.AllowPaging = false;
    //            BindData();
    //            GridView1.Columns[5].Visible = GridView1.Columns[8].Visible = GridView1.Columns[9].Visible = false;
    //            Response.ClearContent();
    //            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_LoadRequestList.pdf");
    //            Response.ContentType = "application/pdf";
    //            Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //            StringWriter sw = new StringWriter();
    //            HtmlTextWriter hw = new HtmlTextWriter(sw);
    //            GridView1.RenderControl(hw);
    //            StringReader sr = new StringReader(Regex.Replace(sw.ToString(), "</?(a|A).*?>", ""));
    //            Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
    //            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
    //            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
    //            pdfDoc.Open();
    //            htmlparser.Parse(sr);
    //            pdfDoc.Close();
    //            Response.Write(pdfDoc);
    //            Response.End();
    //        }
    //        else
    //            utility.MessageBox(this, "record not found,can not export.");
    //    }
    //    catch
    //    {

    //    }
    //}

    //protected void btnShowall_Click(object sender, EventArgs e)
    //{
    //    txtFromdate.Text = txtTodate.Text = string.Empty;
    //    BindData();
    //}

    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (string.Compare(e.CommandName, "Aprove", true) == 0 || string.Compare(e.CommandName, "Reject", true) == 0)
    //    {
    //        int index = Convert.ToInt32(e.CommandArgument);
    //        int srno = Convert.ToInt32(GridView1.DataKeys[index].Value);
    //        string regno = GridView1.Rows[index].Cells[1].Text.Trim();


    //        int status = string.Compare(e.CommandName, "Aprove", true) == 0 ? 1 : 2;
    //        string coment = "";
    //        string epassword = ((TextBox)GridView1.Rows[index].FindControl("txtPwd")).Text.Trim();

    //        if (epassword.Length < 2)
    //            utility.MessageBox(this, "Invalid transaction password.");
    //        else
    //            ApproveRequest(srno, regno, status, coment, epassword);
    //    }


    //}

    protected void Btn_Approve_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtPwd.Text.Length  < 2)
            {
                utility.MessageBox(this, "Invalid transaction password.");
                return;
            }
            int srno = Convert.ToInt32(hnd_Id.Value), status = 1;
            string regno = hnd_userid.Value, coment = "", epassword = txtPwd.Text.Trim();
            ApproveRequest(srno, regno, status, coment, epassword);
        }
        catch (Exception er)
        { }
    }

    protected void Btn_Reject_Click(object sender, EventArgs e)
    {
        try
        {
            int srno = Convert.ToInt32(hnd_Id.Value), status = 2;
            string regno = hnd_userid.Value, coment = "", epassword = txtPwd.Text.Trim();
            ApproveRequest(srno, regno, status, coment, epassword);

        }
        catch (Exception er)
        { }
    }


    [System.Web.Services.WebMethod]

    public static Detail[] bindtable(string From, string To, string Status, string Id)
    {
        List<Detail> details = new List<Detail>();
        DataUtility objDu = new DataUtility();
        try
        {
           // string fromDate = "", toDate = "";
            try
            {
                if (From.Length > 0)
                {
                    String[] Date = From.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    From = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
                if (To.Trim().Length > 0)
                {
                    String[] Date = To.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
                    To = Date[1] + "/" + Date[0] + "/" + Date[2];
                }
            }
            catch
            {
               // utility.MessageBox(this, "Invalid date entry.");
              //  return;
            }

            SqlParameter[] param = new SqlParameter[]
            {

            new SqlParameter("@fromdate", From),
            new SqlParameter("@Todate", To),
            new SqlParameter("@status", Status),
            new SqlParameter("@regno", Id),
            //new SqlParameter("@AppMstMobile", Mobile),
            //new SqlParameter("@panno", Pan_No)
            


           // new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString())
                };

            SqlDataReader dr = objDu.GetDataReaderSP(param, "userWalletRequest");
            utility objUtil = new utility();
            while (dr.Read())
            {
                Detail data = new Detail();
                //function openPopup(UserLink, WalletRequestId, /*userid*/, /*fname,*/ /*amt,*/ /*redate,*/ /*TransactionNo,*/ /*Remarks,*/ DepositorName, DepositorPhone, slip)

                data.User_ID = dr["userid"].ToString();
                data.Name = dr["fname"].ToString();
                data.Amount = dr["amt"].ToString();
                data.Request_Date = dr["redate"].ToString();
                data.Tran_No = dr["TransactionNo"].ToString();
                data.Remarks = dr["Remarks"].ToString();
                data.Depositor_Name = dr["DepositorName"].ToString();
                data.Depositor_Phone = dr["DepositorPhone"].ToString();
                data.Wallet_Req_Id = dr["srno"].ToString();
                data.slip = dr["slip"].ToString();
                data.Status = dr["Status"].ToString();
                data.Approved_Date = dr["apdate"].ToString();
                data.Mode_of_Payment = dr["PaymentType"].ToString();




                details.Add(data);
             };



        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class Detail

    {

        public string User_ID { get; set; }
        public string Name { get; set; }
        public string Amount { get; set; }
        public string Request_Date { get; set; }
        public string Tran_No { get; set; }
        public string Remarks { get; set; }
        public string Depositor_Name { get; set; }
        public string Depositor_Phone { get; set; }
        public string Wallet_Req_Id { get; set; }
        public string Status { get; set; }

        public string slip { get; set; }
        public string Approved_Date { get; set; }
        public string Mode_of_Payment { get; set; }

    }

}