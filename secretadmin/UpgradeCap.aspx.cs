using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Collections.Generic;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Collections.Generic;
using System.Linq;

public partial class secretadmin_UpgradeCap : System.Web.UI.Page
{
    SqlDataAdapter da;
    SqlConnection con = new SqlConnection(method.str);
    utility u = new utility();
    string paid = null;
    int joinTotal = 0;
    utility objUtil;
    SqlCommand cmd;
    int recordCount = 0;
    static int x = 1;

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




        if (!IsPostBack)
        {
            x = 1;
            txtFromDate.Text = DateTime.Now.Date.AddDays(-1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            //arlst.Clear();
            //BindProduct();
            binduserdetail(1);
            txtsearch1.Text = "";

            ViewState["no"] = 1;
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        txtSearch.Text = string.Empty;

        ViewState["no"] = 1;
        //go(); 
        binduserdetail(1);
    }
    //private void BindUserID()
    //{
    //    con = new SqlConnection(method.str);
    //    SqlDataAdapter da = new SqlDataAdapter();

    //    try
    //    {
    //        DataTable tbl = new DataTable();
    //        da = new SqlDataAdapter("select appmstregno,appmstfname from appmst", con);
    //        da.Fill(tbl);         
    //        divUserID.InnerText = string.Empty;
    //        foreach (DataRow row in tbl.Rows)
    //        {
    //            divUserID.InnerText += row["appmstregno"].ToString().Trim() + ",";
    //        }

    //    }
    //    catch
    //    {
    //    }
    //    finally
    //    {
    //    }
    //}
    private void binduserdetail(int pageIndex)
    {

        try
        {
            if (!IsPostBack)
            {
                x = 1;
            }

            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();



            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);

            if (fromDate > toDate)
            {

                string message = "alert('Please select valid date.')";
                ScriptManager.RegisterClientScriptBlock((this as Control), this.GetType(), "alert", message, true);
            }




            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {
                cmd = new SqlCommand("Getcappingdetails", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageIndex", pageIndex);
                cmd.Parameters.AddWithValue("@PageSize", 50);
                cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4);
                cmd.Parameters.AddWithValue("@AppMstDOJ", fromDate);
                cmd.Parameters.AddWithValue("@AppMstDOJ1", toDate);
                cmd.Parameters["@RecordCount"].Direction = ParameterDirection.Output;
                con.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dglst.DataSource = dt;
                dglst.DataBind();
                //idr.Close();
                con.Close();
                int recordCount = Convert.ToInt32(cmd.Parameters["@RecordCount"].Value);


                double dblPageCount = (double)((decimal)recordCount / 50);
                int pageCount = (int)Math.Ceiling(dblPageCount);

                Label1.Text = "Total Record" + " " + recordCount;
                lblControl.Text = "Total Page" + " " + pageCount;

                lbltotalrecord.Text = "Current Page" + " " + x;


                double dblPageCount1 = (double)((decimal)recordCount / 50);
                int pageCount1 = (int)Math.Ceiling(dblPageCount);


                if (pageCount == x)
                {
                    Button3.Enabled = false;

                }

                else
                {
                    Button3.Enabled = true;
                }
                if (x == 1)
                {
                    Button2.Enabled = false;
                }
                else
                {
                    Button2.Enabled = true;
                }

                if (Label1.Text == "Total Record 0")
                {
                    Button3.Visible = false;
                    Button2.Visible = false;
                    txtsearch1.Visible = false;
                    btnsearch2.Visible = false;
                    lbltotalrecord.Visible = false;
                    Label1.Visible = false;
                    lblControl.Visible = false;
                }
                else
                {
                    Button3.Visible = true;
                    Button2.Visible = true;
                    txtsearch1.Visible = true;
                    btnsearch2.Visible = true;
                    lbltotalrecord.Visible = true;
                    Label1.Visible = true;
                    lblControl.Visible = true;
                }

                //if (pageCount == x + 1)
                //{
                //    btnsearch2.Enabled = false;
                //}
                //else
                //{
                //    btnsearch2.Enabled = true;
                //}

            }
        }
        catch
        {
        }
    }


    //private void PopulatePager(int recordCount, int currentPage)
    //{
    //    double dblPageCount = (double)((decimal)recordCount /50);
    //    int pageCount = (int)Math.Ceiling(dblPageCount);
    //    List<System.Web.UI.WebControls.ListItem> pages = new List<System.Web.UI.WebControls.ListItem>();
    //    if (pageCount > 0)
    //    {
    //        pages.Add(new System.Web.UI.WebControls.ListItem("First", "1", currentPage > 1));
    //        for (int i = 1; i <= pageCount; i++)
    //        {
    //            pages.Add(new System.Web.UI.WebControls.ListItem(i.ToString(), i.ToString(), i != currentPage));
    //        }
    //        pages.Add(new System.Web.UI.WebControls.ListItem("Last", pageCount.ToString(), currentPage < pageCount));
    //    }

    //}

    protected void btnpre_Click(object sender, EventArgs e)
    {

        double dblPageCount = (double)((decimal)recordCount / 50);
        int pageCount = (int)Math.Ceiling(dblPageCount);

        x--;
        int i = 1;


        ViewState["no"] = i;

        Label2.Text = "Current Page" + " " + x;


        for (i = 1; i >= pageCount; i++)
        {

            if (x == i)
            {


                binduserdetail(x);


                break;
            }
        }


    }

    protected void btnnext_Click(object sender, EventArgs e)
    {

        double dblPageCount = (double)((decimal)recordCount / 50);
        int pageCount = (int)Math.Ceiling(dblPageCount);
        x++;
        int i = 1;
        ViewState["no"] = x;
        Label2.Text = "Current Page" + " " + x;

        for (i = 1; i >= pageCount; i++)
        {

            if (x == i)
            {
                binduserdetail(x);
                break;
            }
        }






    }


    protected void btnsearch2_Click(object sender, EventArgs e)
    {
        utility obj = new utility();
        if (!string.IsNullOrEmpty(txtsearch1.Text.Trim()) && !obj.IsValiduserid(txtsearch1.Text.Trim()))
        {
            utility.MessageBox(this, "Invalid page Number!");

            return;
        }

        if (txtsearch1.Text == "")
        {
            string message = "alert('Please Enter page Number .')";
            ScriptManager.RegisterClientScriptBlock((this as Control), this.GetType(), "alert", message, true);

        }
        else
        {

            int y = Convert.ToInt32(txtsearch1.Text);
            x = y;
            Label2.Text = "Current Page" + " " + x;

            ViewState["no"] = x;

            binduserdetail(y);
        }

    }

    //public void go()
    //{
    //    System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //    dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //    DateTime fromDate = new DateTime();
    //    DateTime toDate = new DateTime();

    //    try
    //    {
    //        fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
    //        toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
    //    }
    //    catch
    //    {
    //        lblMsg.Text = "Invalid date entry.";
    //        return;
    //    }
    //    if (ddlUser.SelectedValue.ToString() == "All")
    //    {
    //        if (fromDate <= toDate)
    //        {
    //           // da = new SqlDataAdapter("select UPPER(AppmstLname) AS AppmstLname,appmstmobile,appmstid,UPPER(distt) AS distt,UPPER(email) AS email,convert(varchar(20),appPaiddatetime ,103) as appmstpaiddate, UPPER(AppMstregno) AS AppMstregno,UPPER(SponsorID) AS SponsorID,parentid,UPPER(AppmstTitle) +space(1)+UPPER(AppmstFName) as name,UPPER(AppMstCity) AS AppMstCity,UPPER(AppMstState) AS AppMstState,AppMstDOJ=CONVERT(char(20),AppMstDOJ,103),Joinfor=JAmount,case when appmstPaid=1 or ypin=1 then 'PAID' when appmstPaid=0 or ypin=0 then 'UNPAID' end as appmstPaid from AppMst where CAST(FLOOR(CAST(AppMstDOJ as float)) as datetime) between @fromDate and @toDate and appmstpaid<>1 and ypin<>1 order by AppMstid", con);
    //            da = new SqlDataAdapter("select (select appmstfname from appmst where appmstregno=a.SponsorID) as sponsor,a.appmstpassword,a.appmstlogin as username,UPPER(a.panno) AS panno,a.gname,appmstpincode,UPPER(a.branch) branch,UPPER(a.bankname) AS bankname,UPPER(a.acountno) AS acountno,UPPER(a.nom_rela) AS nom_rela,UPPER(a.nom_name) AS nom_name,a.userdob,a.appmstprimaryphone,UPPER(a.appmstaddress1) AS appmstaddress1,UPPER(AppmstLname) AS AppmstLname,appmstmobile,appmstid,UPPER(distt) AS distt,UPPER(email) AS email,convert(varchar(20),appPaiddatetime ,103) as appmstpaiddate, UPPER(AppMstregno) AS AppMstregno,UPPER(SponsorID) AS SponsorID,parentid,UPPER(AppmstTitle) +space(1)+UPPER(AppmstFName) as name,UPPER(AppMstCity) AS AppMstCity,UPPER(AppMstState) AS AppMstState,AppMstDOJ=CONVERT(char(20),AppMstDOJ,103),Joinfor=JAmount,case when ypin=1 then 'ZEROID' when appmstPaid=0 then 'UNPAID'  end as appmstPaid,a.productid,a.ifscode from AppMst a where a.appmstpaid=0 and a.ypin=0 and CAST(FLOOR(CAST(AppMstDOJ as float)) as datetime)  between @fromDate and @toDate order by AppMstid", con);    
    //            da.SelectCommand.Parameters.AddWithValue("@fromDate", fromDate);
    //            da.SelectCommand.Parameters.AddWithValue("@toDate", toDate);

    //            DataTable dt = new DataTable(); 
    //            da.Fill(dt);
    //            if (dt.Rows.Count > 0)
    //            {
    //                ViewState["dt"] = dt;
    //                //lblMsg.Text = string.Empty;
    //                dglst.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
    //                dglst.DataSource = dt;
    //                dglst.DataBind();
    //                //lblcount.Text = "No of records :" + dt.Rows.Count;
    //            }
    //            else
    //            {
    //                //lblcount.Text = string.Empty;
    //                dglst.DataSource = null;
    //                dglst.DataBind();
    //            }
    //        }
    //        else
    //        {
    //            lblMsg.Text = "SORRY...! Wrong date!";
    //            dglst.Visible = false;
    //        }
    //    }

    //    else if (fromDate <= toDate)
    //        {
    //           // da = new SqlDataAdapter("select UPPER(a.appmstaddress1) AS appmstaddress1,UPPER(AppmstLname) AS AppmstLname,appmstmobile,appmstid,UPPER(distt) AS distt,UPPER(email) AS email,convert(varchar(20),appPaiddatetime ,103) as appmstpaiddate, UPPER(AppMstregno) AS AppMstregno,UPPER(SponsorID) AS SponsorID,parentid,UPPER(AppmstTitle) +space(1)+UPPER(AppmstFName) as name,UPPER(AppMstCity) AS AppMstCity,UPPER(AppMstState) AS AppMstState,AppMstDOJ=CONVERT(char(20),AppMstDOJ,103),Joinfor=JAmount,case when appmstPaid=1 or ypin=1 then 'PAID' when appmstPaid=0 or ypin=0 then 'UNPAID' end as appmstPaid from AppMst where CAST(FLOOR(CAST(AppMstDOJ as float)) as datetime) between @fromDate and @toDate and (appmstpaid=@paid or ypin=@paid )order by AppMstid", con);
    //            da = new SqlDataAdapter("select (select appmstfname from appmst where appmstregno=a.SponsorID) as sponsor,a.appmstlogin as username,UPPER(a.panno) AS panno,UPPER(a.branch) branch,UPPER(a.bankname) AS bankname,UPPER(a.acountno) AS acountno,a.appmstpincode,upper(a.micr) as micr,UPPER(a.ifc) AS ifc,UPPER(a.nom_rela) AS nom_rela,UPPER(a.nom_name) AS nom_name,a.userdob,a.appmstprimaryphone,UPPER(a.appmstaddress1) AS appmstaddress1,UPPER(AppmstLname) AS AppmstLname,appmstmobile,appmstid,UPPER(distt) AS distt,UPPER(email) AS email,convert(varchar(20),appPaiddatetime ,103) as appmstpaiddate, UPPER(AppMstregno) AS AppMstregno,UPPER(SponsorID) AS SponsorID,parentid,UPPER(AppmstTitle) +space(1)+UPPER(AppmstFName) as name,UPPER(AppMstCity) AS AppMstCity,UPPER(AppMstState) AS AppMstState,AppMstDOJ=CONVERT(char(20),AppMstDOJ,103),Joinfor=JAmount,case when ypin=1 then 'ZEROID' when appmstPaid=0 then 'UNPAID'  end as appmstPaid,productid,AppMst.ifscode from AppMst where a.appmstpaid=0 and a.ypin=0 and CAST(FLOOR(CAST(AppMstDOJ as float)) as datetime) between @fromDate and @toDate  )order by AppMstid", con);    
    //            da.SelectCommand.Parameters.AddWithValue("@fromDate", fromDate);
    //            da.SelectCommand.Parameters.AddWithValue("@toDate", toDate);
    //            //da.SelectCommand.Parameters.AddWithValue("@paid",ddlUser.SelectedValue.ToString());

    //            DataTable dt = new DataTable();
    //            da.Fill(dt);
    //            if (dt.Rows.Count > 0)
    //            {
    //                ViewState["dt"] = dt;
    //                //lblMsg.Text = string.Empty;
    //                dglst.PageSize = ddlPageSize.SelectedValue.ToString() == "All" ? dt.Rows.Count : Convert.ToInt32(ddlPageSize.SelectedValue.ToString());
    //                //lblJoinFor.Text = Convert.ToString(Math.Round(Convert.ToDouble(dt.Compute("sum(joinfor)", "1=1").ToString()), 2)); 
    //                dglst.DataSource = dt;
    //                dglst.DataBind();
    //                //lblcount.Text = "No of records: " + dt.Rows.Count;
    //            }
    //            else
    //            {
    //                //lblcount.Text = string.Empty;
    //                //lblMsg.Text = string.Empty;
    //                dglst.DataSource = null;
    //                dglst.DataBind();
    //            }
    //        }
    //        else
    //        {
    //            lblMsg.Text = "SORRY...! Wrong date!";
    //            dglst.Visible = false;
    //        }


    //    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            // search();
            //else
            binduserdetail(1);
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    //static ArrayList arlst = new ArrayList();
    //void AddColoumn(string header, string DataField)
    //{
    //    if (strOperation == "Add")
    //    {
    //        BoundField bfAddress = new BoundField();
    //        bfAddress.DataField = DataField;
    //        bfAddress.HeaderText = header;
    //        bfAddress.ItemStyle.HorizontalAlign = HorizontalAlign.Left;
    //        bfAddress.HeaderStyle.HorizontalAlign = HorizontalAlign.Left;
    //        dglst.Columns.Add(bfAddress);
    //    }
    //    if (strOperation == "Remove")
    //    {
    //        for (int i = 0; i < dglst.Columns.Count; i++)
    //        {
    //            if (dglst.Columns[i].HeaderText.Contains(header))
    //            {
    //                dglst.Columns.RemoveAt(i);
    //                binduserdetail(1); ;
    //            }
    //        }
    //    }
    //}
    //string strOperation = "Add";
    //void GetCheckBox()
    //{

    //    ControlCollection cont = (ControlCollection)this.pnlChkList.Controls;
    //    for (int i = 0; i < cont.Count; i++)
    //    {
    //        if (cont[i].GetType().ToString().Contains("CheckBox"))
    //        {
    //            CheckBox chk = (CheckBox)cont[i];
    //            if (chk.Checked == true && !arlst.Contains(chk.ID))
    //            {
    //                arlst.Add(chk.ID);
    //                BindColumn(chk.Text);
    //            }
    //            else if (chk.Checked == true && arlst.Contains(chk.ID) && strOperation == "Remove")
    //            {
    //                {
    //                    arlst.Remove(chk.ID);
    //                    BindColumn(chk.Text);
    //                }
    //            }
    //        }
    //    }
    //}    
    //void BindColumn(string txt)
    //{
    //    #region

    //    if (txt == "Address")
    //    {
    //        AddColoumn("ADDRESS", "appmstaddress1");
    //    }
    //    if (txt == "District")
    //    {
    //        AddColoumn("District", "distt");
    //    }
    //    if (txt == "E-Mail")
    //    {
    //        AddColoumn("E-MAIL", "email");
    //    }
    //    if (txt == "Pin Code")
    //    {
    //        AddColoumn("PinCode", "appmstpincode");
    //    }
    //    if (txt == "Paid Date")
    //    {
    //        AddColoumn("PAID DATE", "appmstpaiddate");
    //    }
    //    if (txt == "D.O.B")
    //    {
    //        AddColoumn("D.O.B", "userdob");
    //    }
    //    if (txt == "Branch")
    //    {
    //        AddColoumn("BRANCH", "BRANCH");
    //    }
    //    if (txt == "Bank")
    //    {
    //        AddColoumn("BANK", "bankname");
    //    }
    //    if (txt == "Account Number")
    //    {
    //        AddColoumn("ACCOUNT NO", "acountno");
    //    }
    //    if (txt == "Pan Number")
    //    {
    //        AddColoumn("PAN NO", "panno");
    //    }
    //    if (txt == "Nominee Name")
    //    {
    //        AddColoumn("Nominee Name", "nom_name");
    //    }
    //    if (txt == "Nominee Relation")
    //    {
    //        AddColoumn("Nominee Relation", "nom_rela");
    //    }
    //    if (txt == "IFC")
    //    {
    //        AddColoumn("IFC", "IFC");
    //    }
    //    if (txt == "MICR")
    //    {
    //        AddColoumn("MICR", "MICR");
    //    }
    //    if (txt == "Guardian Name")
    //    {
    //        AddColoumn("GUARDIAN NAME", "AppmstLName");
    //    }
    //    if (txt == "Primary Phnoe")
    //    {
    //        AddColoumn("PRIMARY PHONE", "appmstprimaryphone");
    //    }
    //    if (txt == "Password")
    //    {
    //        AddColoumn("Password", "appmstPassword");
    //    }
    //    #endregion
    //}   
    protected void Button4_Click(object sender, EventArgs e)
    {
        //strOperation = "Add";
        //GetCheckBox();
        //if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
        //{ search(); }
        //else
        //{ binduserdetail(1); ; }
        //resetChk();
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        //strOperation = "Remove";
        //GetCheckBox();
        //if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
        //{ search(); }
        //else
        //{ binduserdetail(1); }
        //resetChk();
    }
    protected void dglst_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        string regno = ((LinkButton)dglst.Rows[e.RowIndex].Cells[1].FindControl("lnkbtnId")).Text.Trim();
        Session["userId"] = regno.Trim();
        Response.Redirect("~/user/genology.aspx", false);
    }
    //public void resetChk()
    //{
    //    ControlCollection cont = (ControlCollection)this.pnlChkList.Controls;
    //    for (int i = 0; i < cont.Count; i++)
    //    {
    //        if (cont[i].GetType().ToString().Contains("CheckBox"))
    //        {
    //            CheckBox chk = (CheckBox)cont[i];
    //            if (chk.Checked == true)
    //            {
    //                chk.Checked = false;
    //            }               
    //        }
    //    }
    //}

    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                search();
            }
            else
            {
                GetDatafromDatabase1();
                //binduserdetail(1); 
            }
            dglst.ShowFooter = false;
            dglst.Columns[10].Visible = dglst.Columns[11].Visible = false;
            dglst.Columns[0].Visible = true;
            dglst.Columns[1].Visible = false;
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_MemberList.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dglst.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
            utility.MessageBox(this, "Can't Export,No Data Found!");

        //GetDatafromDatabase1();

        //Response.Clear();
        //Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_MemberList.xls");
        //Response.Charset = "";
        //Response.ContentType = "application/vnd.xls";
        //System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        //System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        //dglst.RenderControl(htmlWrite);
        //Response.Write(stringWrite.ToString());
        //Response.End();

    }
    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        binduserdetail(1);
    }
    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {


        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
            {
                search();
            }
            else
            {

                GetDatafromDatabase1();
                //  binduserdetail(1); 
            }

            //go2();
            dglst.AllowPaging = false;
            dglst.ShowFooter = false;
            dglst.Columns[10].Visible = dglst.Columns[11].Visible = false;
            dglst.Columns[0].Visible = true;
            dglst.Columns[1].Visible = false;
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_MemberList.doc");
            Response.ContentType = "application/vnd.ms-word";
            StringWriter stw = new StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);

            dglst.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();
        }
        else
        {
           utility.MessageBox(this,"Can't Export,No Data Found!");
        }
    }

    protected DataTable GetDatafromDatabase1()
    {
        DataTable dt = new DataTable();
        //using (SqlConnection con = new SqlConnection("Data Source=SureshDasari;Integrated Security=true;Initial Catalog=MySampleDB"))
        {

            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();



            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);

            if (fromDate > toDate)
            {

                string message = "alert('Please select valid date .')";
                ScriptManager.RegisterClientScriptBlock((this as Control), this.GetType(), "alert", message, true);
            }
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_xcelExport", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@fromdate", fromDate);
            cmd.Parameters.AddWithValue("@todate", toDate);
            da.Fill(dt);
            dglst.DataSource = dt;
            dglst.DataBind();
            con.Close();
        }
        return dt;
    }

    //protected void ibtnPDFExport_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dglst.Rows.Count > 0)
    //    {
    //        dglst.AllowPaging = false;
    //        if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
    //        { search(); }
    //        else
    //        { go(); }
    //        dglst.ShowFooter = false;
    //        dglst.Columns[9].Visible = false;         
    //        Response.ContentType = "application/pdf";
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_List.pdf");
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        StringWriter sw = new StringWriter();
    //        HtmlTextWriter hw = new HtmlTextWriter(sw);
    //        dglst.RenderControl(hw);
    //        StringReader sr = new StringReader(sw.ToString());
    //        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
    //        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
    //        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
    //        pdfDoc.Open();
    //        htmlparser.Parse(sr);
    //        pdfDoc.Close();
    //        Response.Write(pdfDoc);
    //        Response.End();
    //    }
    //    else
    //        lblMsg.Text = "can not export as no data found !";
    //}
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        binduserdetail(1);
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        search();


        Button2.Visible = false;
        Button3.Visible = false;
        lbltotalrecord.Visible = false;
        Label2.Visible = false;
        Label1.Visible = false;
        lblControl.Visible = false;
        txtsearch1.Visible = false;
        btnsearch2.Visible = false;

        x = 1;

    }
    public void search()
    {
        ViewState["Search"] = txtSearch.Text.Trim();
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy";
        DateTime fromDate = new DateTime();
        DateTime toDate = new DateTime();
        try
        {
            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
        }
        catch
        {
            lblMsg.Text = "Invalid date entry.";
            return;
        }
        if (fromDate <= toDate)
        {

            //da = new SqlDataAdapter("select UPPER(AppmstLname) AS AppmstLname,appmstmobile,appmstid,UPPER(distt) AS distt,UPPER(email) AS email,convert(varchar(20),appPaiddatetime ,103) as appmstpaiddate,UPPER(panno) AS panno, UPPER(AppMstregno) AS AppMstregno,UPPER(SponsorID) AS SponsorID,parentid,UPPER(AppmstTitle) +space(1)+UPPER(AppmstFName) as name, UPPER(AppMstCity) AS AppMstCity,UPPER(AppMstState) AS AppMstState,AppMstDOJ=CONVERT(char(20),AppMstDOJ,103),Joinfor=JAmount,case  when ypin=1 then 'ZEROID' when appmstPaid=0 then 'UNPAID' end as appmstPaid,productid,ifscode  from AppMst where (appmstregno=@searchText  or appmststate like '%' + @searchText +'%' or appmstcity like '%' + @searchText +'%') and appmstpaid=0   order by AppMstid", con);
            da = new SqlDataAdapter("sp_searchbyuserid", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            //da.SelectCommand.Parameters.AddWithValue("@searchText", txtSearch.Text.Trim());
            //da.SelectCommand.Parameters.AddWithValue("@fromDate", fromDate);
            //da.SelectCommand.Parameters.AddWithValue("@toDate", toDate);
            da.SelectCommand.Parameters.AddWithValue("@AppMstRegNo", txtSearch.Text);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ViewState["dt"] = dt;
                //lblMsg.Text = string.Empty;
                // lblJoinFor.Text = Convert.ToString(Math.Round(Convert.ToDouble(dt.Compute("sum(joinfor)", "1=1").ToString()), 2)); 
                dglst.DataSource = dt;
                dglst.DataBind();

                //lblcount.Text = "No of records :" + dt.Rows.Count;
                //utility.MessageBox(this, "User Id doesn't Exist or Paid");

            }
            else
            {
                dglst.DataSource = null;
                dglst.DataBind();
                //utility.MessageBox(this, "User Id doesn't Exist or Paid");
            }
        }
        else
        {
            lblMsg.Text = "SORRY...! WRONG DATE!";
            dglst.Visible = false;
        }
    }
    //protected void dglst_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName == "EditProfile")
    //    {
    //        GridViewRow row = dglst.Rows[Convert.ToInt32(e.CommandArgument)];
    //        LinkButton lnkbtnId = (LinkButton)row.FindControl("lnkbtnId");
    //        Response.Redirect("edit.aspx?n=" + u.base64Encode(lnkbtnId.Text.Trim()), false);
    //    }
    //    else if (e.CommandName == "PAID")
    //    {
    //        //if (ViewState["dt"] != null)
    //        //{
    //        //    //ddlPaidType.SelectedIndex = 0;
    //            //pnlChkList.Style.Add("display", "none");
    //            //panlID1.Visible = true;
    //            //ViewState["Regno"] = e.CommandArgument.ToString();
    //            //DataTable dtt = (DataTable)ViewState["dt"];

    //            //var tbl = from p in dtt.AsEnumerable()
    //            //          where p.Field<string>("AppMstregno") == e.CommandArgument.ToString()
    //            //          select new { Name = p.Field<string>("Name"), SponsorID = p.Field<string>("SponsorID"), Productid = p.Field<int>("Productid") };
    //            //var d = tbl.ToList();
    //            //lbl_Userid.Text = e.CommandArgument.ToString();
    //            //lbl_UName.Text = d[0].Name;
    //            //lbl_SpoId.Text = d[0].SponsorID;
    //            //ddlPaidType.SelectedValue = d[0].Productid.ToString();


    //        int rowindex = Convert.ToInt32(e.CommandArgument);
    //       // string regno = dglst.DataKeys[rowindex].Values[0].ToString();
    //        GridViewRow row = dglst.Rows[rowindex];
    //        TextBox txtamt = (TextBox)row.FindControl("txtcapping");
    //        utility.MessageBox(this, txtamt.Text);

    //        //double amt = Convert.ToDouble(txtamt.Text);
    //        //updateStatus(regno, amt);
    //        //}
    //    }
    //}

    protected void Button2_Click(object sender, EventArgs e)
    {
        panlID1.Visible = false;
    }
    protected void RaiseDisputetxt_Click(object sender, EventArgs e)
    {
        //if (ViewState["Regno"] != null || Session["admin"] !=null)
        //{

        //        SqlCommand cmd = new SqlCommand("RechargeUser", con);
        //        cmd.CommandType = CommandType.StoredProcedure;

        //        cmd.Parameters.AddWithValue("@RegNo", ViewState["Regno"].ToString());
        //        cmd.Parameters.AddWithValue("@ProductId", ddlPaidType.SelectedValue);


        //        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //        if (cmd.Parameters["@flag"].Value.ToString() == "1")
        //        {
        //            panlID1.Visible = false;
        //            utility.MessageBox(this, "CONGRATULATIONS USER ACTIVATED SUCCESSFULLY !");
        //            con.Close();
        //            binduserdetail(1);
        //        }
        //        else
        //        {
        //             utility.MessageBox(this,cmd.Parameters["@flag"].Value.ToString());
        //             con.Close();
        //        }


        //}
        //else
        //{
        //    utility.MessageBox(this, "Try again");
        //    return;
        //}
        //pnlChkList.Visible = true;
        //ddlPaidType.SelectedIndex = 0;
    }
    //private void BindProduct()
    //{

    //    con = new SqlConnection(method.str);
    //    SqlDataAdapter ad = new SqlDataAdapter("select productName +' (PV- '+convert(varchar(50),joinfor)+ ' Point ' +convert(varchar(50),Amount)+')' as PName,srno from productmst order by srno", con);
    //    DataTable dt = new DataTable();
    //    ad.Fill(dt);
    //    ddlPaidType.DataSource = dt;
    //    ddlPaidType.DataTextField = "PName";
    //    ddlPaidType.DataValueField = "srno";
    //    ddlPaidType.DataBind();
    //}
    //public void sendsms(string RegNo, string bal)
    //{
    //    try
    //    {
    //        objUtil = new utility();
    //        string mobileno = string.Empty;
    //        string fname = string.Empty;
    //        string completeName = string.Empty;
    //        string msgtxt = string.Empty;
    //        //RegNo = Convert.ToString(Session["userId"]);
    //        con = new SqlConnection(method.str);
    //       SqlCommand com = new SqlCommand("Select AppMstFName+',Id:'+appmstregno as fname,AppMstMobile from appmst where appmstRegNo=@regno;" +
    //            "Select AppMstFName+',Id:'+appmstregno as fname,AppMstMobile from appmst where appmstRegNo=@Cregno", con);
    //        com.Parameters.AddWithValue("@regno", RegNo);
    //        com.Parameters.AddWithValue("@Cregno", RegNo);
    //        con.Open();
    //        SqlDataReader reader = com.ExecuteReader();
    //        if (reader.HasRows)
    //        {
    //            reader.Read();
    //            mobileno = reader["AppMstMobile"].ToString();
    //            fname = reader["fname"].ToString();
    //            reader.NextResult();
    //            fname = msgtxt = mobileno = string.Empty;
    //            if (reader.HasRows)
    //            {
    //                reader.Read();
    //                mobileno = reader["AppMstMobile"].ToString();
    //                fname = reader["fname"].ToString();
    //                msgtxt = "Dear " + fname + " "+ddlPaidType.SelectedItem.ToString()+" has been updated";
    //                //msgtxt = "Dear " + fname + " points : " + bal + " has been updated from wallet of: " + RegNo;
    //                objUtil.sendSMSByPage(mobileno, msgtxt);
    //            }
    //        }
    //    }
    //    catch
    //    {
    //    }
    //}


    protected void dglst_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int rowindex = Convert.ToInt32(e.CommandArgument);
            string regno = dglst.DataKeys[rowindex].Values[0].ToString();
            GridViewRow row = dglst.Rows[rowindex];
            TextBox txtamt = (TextBox)row.FindControl("txtcapping");

            if (!string.IsNullOrEmpty(txtamt.Text.Trim()))
            {
                SqlCommand cmd = new SqlCommand("addcapping", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@regno", regno);
                cmd.Parameters.AddWithValue("@value", Convert.ToDouble(txtamt.Text));


                cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                string status = cmd.Parameters["@flag"].Value.ToString();

                if (status == "1")
                {
                    utility.MessageBox(this, "User Paid Successfully");
                    con.Close();
                }

                else
                {
                    utility.MessageBox(this,status.ToString());
                }

                //if (cmd.Parameters["@flag"].Value.ToString() == "1")
                //{
                   
                //    utility.MessageBox(this, "User Paid Successfully");
                //    con.Close();
                   
                //}
                //if (cmd.Parameters["@flag"].Value.ToString() == "2")
                //{
                //    utility.MessageBox(this, "Amount is exceed than 100000");
                //    con.Close();
                //}
               
                if (ViewState["Search"] != null)
                {
                    search();
                }
                else
                {
                    binduserdetail(1);
                }
            }
            else
            {
                utility.MessageBox(this, "Please enter Capping.");
                txtamt.Focus();
                return;
            }
        }
        catch(Exception ex)
        {
            utility.MessageBox(this,ex.StackTrace.ToString());
        }

    }
}