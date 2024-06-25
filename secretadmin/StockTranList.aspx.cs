using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Xml;
using System.Drawing;
using System.Collections.Generic;
using System.IO;

public partial class admin_StockTranList : System.Web.UI.Page
{
    //DataTable dt = null;
    //SqlConnection con = null;
    //SqlCommand com = null;
    //string regno = string.Empty;
    //XmlDocument xmldoc = new XmlDocument();
    //DataUtility objDUT = null;
    //string franchiseid = "";
    //string invoiceno = "";
    //int status = 0;
    //string returnvalue;
    //string strajax = "";
    //string xmlfile = "";
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
            txtFromDate.Text = DateTime.Now.AddDays(-7).ToString("dd-MM-yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd-MM-yyyy").Replace("-", "/");

        }

    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string SalesRepId, string Buyerid, string InvoiceNo, string Status, string Del_Status)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@soldto", Buyerid),
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@SalesRepId", SalesRepId),
                new SqlParameter("@invoiceno", InvoiceNo),
                new SqlParameter("@status", Status),
                new SqlParameter("@Del_Status", Del_Status),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "stockbillsearch");
            utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.srno_Encode = objutil.base64Encode(dr["srno"].ToString());
                data.srno = dr["srno"].ToString();
                data.Date = dr["Date"].ToString();
                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.invoiceno_Encript = objutil.base64Encode(dr["InvoiceNo"].ToString());

                data.SellerUserId = dr["SellerUserId"].ToString();
                data.SellerName = dr["SellerName"].ToString();
                data.SellerState = dr["SellerState"].ToString();
                data.SellerDistrict = dr["SellerDistrict"].ToString();

                data.BuyerUserId = dr["BuyerUserId"].ToString();
                data.BuyerName = dr["BuyerName"].ToString();
                data.BuyerDistrict = dr["BuyerDistrict"].ToString();
                data.BuyerState = dr["BuyerState"].ToString();
                data.BuyerMobileNo = dr["BuyerMobileNo"].ToString();
                data.NoOFProduct = dr["NoOFProduct"].ToString();
                data.grossAmt = dr["grossAmt"].ToString();
                data.SGST = dr["SGST"].ToString();
                data.CGST = dr["CGST"].ToString();


                data.IGST = dr["IGST"].ToString();
                data.Cess = dr["Cess"].ToString();
                data.netAmt = dr["netAmt"].ToString();
                data.CourierCharges = dr["CourierCharges"].ToString();
                data.Discount = dr["Discount"].ToString();

                data.Amount = dr["Amount"].ToString();
                data.TotalFPV = dr["TotalFPV"].ToString();
                data.status = dr["status"].ToString();
                data.Del_Status = dr["Del_Status"].ToString();
                data.DeleveryText = dr["DeleveryText"].ToString();

                data.EwayNo = dr["EwayNo"].ToString();
                data.DispatchDate = dr["DispatchDate"].ToString();
                data.Tracking = dr["Tracking"].ToString();
                data.Transport = dr["Transport"].ToString();
                data.DeliveryDate = dr["DeliveryDate"].ToString();

                data.DurationDays = dr["DurationDays"].ToString();
                data.Del_Remarks = dr["Del_Remarks"].ToString();
                data.ConfirmWith = dr["ConfirmWith"].ToString();
                data.TransportMode = dr["TransportMode"].ToString();
                data.No_Boxes = dr["No_Boxes"].ToString();

                data.Weight_KG = dr["Weight_KG"].ToString();
                data.Slip = dr["DispatchFileName"].ToString();

                data.Img2 = dr["Img2"].ToString();
                data.SendMsg = dr["SendMsg"].ToString();
                data.SendWhatsApp = dr["SendWhatsApp"].ToString();
                data.IS_OPTIN = dr["IS_OPTIN"].ToString();

                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string srno_Encode { get; set; }
        public string invoiceno_Encript { get; set; }  
        public string srno { get; set; }
        public string Date { get; set; }
        public string InvoiceNo { get; set; }

        public string SellerUserId { get; set; }
        public string SellerName { get; set; }
        public string SellerState { get; set; }
        public string SellerDistrict { get; set; }


        public string BuyerUserId { get; set; }
        public string BuyerName { get; set; }
        public string BuyerDistrict { get; set; }
        public string BuyerState { get; set; }
        public string BuyerMobileNo { get; set; }
        public string NoOFProduct { get; set; }
        public string grossAmt { get; set; }
        public string SGST { get; set; }
        public string CGST { get; set; }

        public string IGST { get; set; }
        public string Cess { get; set; }
        public string netAmt { get; set; }
        public string CourierCharges { get; set; }
        public string Discount { get; set; }

        public string Amount { get; set; }
        public string TotalFPV { get; set; }
        public string status { get; set; }
        public string Del_Status { get; set; }
        public string DeleveryText { get; set; }

        public string EwayNo { get; set; }
        public string DispatchDate { get; set; }
        public string Tracking { get; set; }
        public string Transport { get; set; }
        public string DeliveryDate { get; set; }
        public string DurationDays { get; set; }
        public string Del_Remarks { get; set; }
        public string ConfirmWith { get; set; }
        public string TransportMode { get; set; }
        public string No_Boxes { get; set; }
        public string Weight_KG { get; set; }
        public string Slip { get; set; }
        public string Img2 { get; set; }
        public string SendMsg { get; set; }
        public string SendWhatsApp { get; set; }
        public string IS_OPTIN { get; set; }

    }


    [System.Web.Services.WebMethod]
    public static string Cancel_Invoice(string Invoice)
    {
        string Result = "";
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("StockCancel", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@invoiceno", Invoice);
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Result = cmd.Parameters["@flag"].Value.ToString();
        }
        catch (Exception er) { }
        return Result;
    }

    [System.Web.Services.WebMethod]
    public static string Dispatch_Inv(string Invoice, string srno, string Transport, string Tracking, string EWay, string Remarks, string Weight, string Boxes, string ImgName1, string ImgName2, string DispatchedDate)
    {
        string Result = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@srno", srno),
                new SqlParameter("@DispatchedDate", DispatchedDate),
                new SqlParameter("@Transport", Transport),
                new SqlParameter("@Tracking", Tracking),
                new SqlParameter("@EWay", EWay),
                new SqlParameter("@Remarks", Remarks),
                new SqlParameter("@Weight", Weight),
                new SqlParameter("@Boxes", Boxes),
                new SqlParameter("@ImgName1", ImgName1),
                new SqlParameter("@ImgName2", ImgName2), 
                new SqlParameter("@ApprovedBy", HttpContext.Current.Session["admin"].ToString()),
            };

            objDu.ExecuteSql(param, @"Update StockTranReport Set DeliveryStatus=7, Transport=@Transport,
            Tracking=@Tracking, EwayNo=@EWay, DeliveryRemark=@Remarks, WeightKG=@Weight, Boxes=@Boxes,
            DispatchDate=@DispatchedDate, DispatchFileName=(Case when @ImgName1='' then DispatchFileName else @ImgName1 End), 
            Img2=(Case when @ImgName2='' then Img2 else @ImgName2 End), ApprovedBy=@ApprovedBy Where Srno=@Srno");
            Result = "1";
        }
        catch (Exception er) { }
        return Result;
    }



    [System.Web.Services.WebMethod]
    public static string SendSms(string SMSTYPE, string srno, string UserId, string Name, string Inv, string Date, string Docket, string Transport, string Mobile, string Img_Lr1)
    {
        string Result = "";
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param = new SqlParameter[] { new SqlParameter("@srno", srno) };
            if (SMSTYPE == "SMS")
            {
                string Msg = "";
                if (Name.Length > 20)
                    Name = Name.Substring(0, 20).ToString();

                Msg = "Dear " + Name + " your " + UserId + " Invoice No. " + Inv + " Date " + Date + " has been Dispatched vide Docket No. " + Docket + " & " + Transport + " is successfully, To view Docket please click link {{6}} Jai Toptime";

                utility objUtil = new utility();
                objUtil.sendSMSByBilling(Mobile, Msg, "DISPATCHED");
                objDu.ExecuteSql(param, "update StockTranReport set SendMsg=isnull(SendMsg,0) +1 where srno=@srno");

                Result = "1";
            }
            if (SMSTYPE == "WHATSAPP")
            {
                var url = method.WEB_URL;
                if (Img_Lr1 != "")
                    url = url + "/images/Slip/" + Img_Lr1;

                var Msg = "Dear *" + Name + "* your *" + UserId + "* Invoice No. *" + Inv + "*  Date *" + Date + "* has been Dispatched vide Docket No. *" + Docket + " " + Transport + "* is successfully, To view Docket please click link " + url;
                WhatsApp.Send_WhatsApp_With_Header(Mobile, Msg, "Dispatced");


                objDu.ExecuteSql(param, "update StockTranReport set SendWhatsApp=isnull(SendWhatsApp,0) +1 where srno=@srno");

                Result = "1";
            }

        }
        catch (Exception er) { }
        return Result;
    }

    #endregion





    //#region Bind Table
    //[System.Web.Services.WebMethod]
    //public static UserDetails[] BindTable(string min, string max, string SalesRepId, string Buyerid,
    //    string InvoiceNo, string Status, string Del_Status)
    //{
    //    List<UserDetails> details = new List<UserDetails>();
    //    DataUtility objDu = new DataUtility();
    //    try
    //    {
    //        SqlParameter[] param = new SqlParameter[]
    //        { 
    //               new SqlParameter("@min", min),
    //               new SqlParameter("@max", max),
    //               new SqlParameter("@SalesRepId", SalesRepId),
    //               new SqlParameter("@soldto", Buyerid),
    //               new SqlParameter("@invoiceno", InvoiceNo),
    //               new SqlParameter("@status", Status),
    //               new SqlParameter("@Del_Status", Del_Status) 
    //        };
    //        SqlDataReader dr = objDu.GetDataReaderSP(param, "stockbillsearch");
    //        while (dr.Read())
    //        {
    //            UserDetails data = new UserDetails();
    //            utility objutil = new utility();
    //            data.srno = dr["srno"].ToString();
    //            data.srno_Encript = objutil.base64Encode(dr["srno"].ToString());
    //            data.Date = dr["Date"].ToString();
    //            data.Pack_Status = dr["Pack_Status"].ToString();

    //            data.InvoiceNo = dr["InvoiceNo"].ToString();
    //            data.SellerUserId = dr["SellerUserId"].ToString();
    //            data.SellerName = dr["SellerName"].ToString();
    //            data.SellerState = dr["SellerState"].ToString();
    //            data.SellerDistrict = dr["SellerDistrict"].ToString();
    //            data.BuyerUserId = dr["BuyerUserId"].ToString();
    //            data.BuyerName = dr["BuyerName"].ToString();
    //            data.BuyerState = dr["BuyerState"].ToString();
    //            data.BuyerDistrict = dr["BuyerDistrict"].ToString();
    //            data.BuyerMobileNo = dr["BuyerMobileNo"].ToString();

    //            data.NoOFProduct = dr["NoOFProduct"].ToString();
    //            data.Actual_Qty = dr["Actual_Qty"].ToString();
    //            data.grossAmt = dr["grossAmt"].ToString();
    //            data.SGST = dr["SGST"].ToString();
    //            data.CGST = dr["CGST"].ToString();
    //            data.IGST = dr["IGST"].ToString();
    //            data.Cess = dr["Cess"].ToString();
    //            data.Amt = dr["Amt"].ToString();
    //            data.Discount = dr["Discount"].ToString();
    //            data.CourierCharges = dr["CourierCharges"].ToString();
    //            data.NetAmt = dr["NetAmt"].ToString();
    //            data.TotalFPV = dr["TotalFPV"].ToString();

    //            data.Del_Status = dr["Del_Status"].ToString();
    //            data.status = dr["status"].ToString();
    //            data.PanNo = dr["PanNo"].ToString();
    //            data.EWayBill = dr["EWayBill"].ToString();
    //            data.PayMode = dr["PayMode"].ToString();

    //            data.DispatchDate = dr["DispatchDate"].ToString();
    //            data.Transport = dr["Transport"].ToString();
    //            data.Tracking = dr["Tracking"].ToString();

    //            data.Del_Remarks = dr["Del_Remarks"].ToString();
    //            data.Pack_Status = dr["Pack_Status"].ToString();

    //            details.Add(data);
    //        }
    //    }
    //    catch (Exception er) { }
    //    return details.ToArray();
    //}


   


    //[System.Web.Services.WebMethod]
    //public static string Dispatch_Inv(string Invoice, string Transport, string Tracking, string EWay, string Remarks)
    //{
    //    string Result = "";
    //    try
    //    {
    //        SqlConnection con = new SqlConnection(method.str);
    //        SqlCommand cmd = new SqlCommand("Update_Del_Invoice", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@invoiceno", Invoice);
    //        cmd.Parameters.AddWithValue("@Transport", Transport);
    //        cmd.Parameters.AddWithValue("@Tracking", Tracking);
    //        cmd.Parameters.AddWithValue("@EWayBill", EWay);
    //        cmd.Parameters.AddWithValue("@Del_Remarks", Remarks);
    //        cmd.Parameters.AddWithValue("@Del_by", "-111");
    //        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
    //        con.Open();
    //       // cmd.ExecuteNonQuery();
    //        Result = cmd.Parameters["@flag"].Value.ToString();

    //    }
    //    catch (Exception er) { }
    //    return Result;
    //}



    //public class UserDetails
    //{
    //    public string srno { get; set; }
    //    public string srno_Encript { get; set; }
    //    public string Date { get; set; }
    //    public string Pack_Status { get; set; }

    //    public string InvoiceNo { get; set; }
    //    public string SellerUserId { get; set; }
    //    public string SellerName { get; set; }
    //    public string SellerState { get; set; }
    //    public string SellerDistrict { get; set; }

    //    public string BuyerUserId { get; set; }
    //    public string BuyerName { get; set; }
    //    public string BuyerState { get; set; }
    //    public string BuyerDistrict { get; set; }
    //    public string BuyerMobileNo { get; set; }


    //    public string NoOFProduct { get; set; }
    //    public string Actual_Qty { get; set; }
    //    public string grossAmt { get; set; }
    //    public string SGST { get; set; }
    //    public string CGST { get; set; }
    //    public string IGST { get; set; }
    //    public string Cess { get; set; }
    //    public string Amt { get; set; }
    //    public string Discount { get; set; }
    //    public string CourierCharges { get; set; }
    //    public string NetAmt { get; set; }
    //    public string TotalFPV { get; set; }

    //    public string status { get; set; }
    //    public string Del_Status { get; set; }
    //    public string PanNo { get; set; }
    //    public string EWayBill { get; set; }
    //    public string PayMode { get; set; }




    //    public string DispatchDate { get; set; }
    //    public string Transport { get; set; }
    //    public string Tracking { get; set; }
    //    public string Del_Remarks { get; set; }

    //}

    //#endregion



    //private void BindGrid()
    //{
    //    try
    //    {
    //        String fromDate = "", toDate = "";
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

    //        con = new SqlConnection(method.str);
    //        SqlDataAdapter ad = new SqlDataAdapter("stockbillsearch", con);
    //        ad.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        ad.SelectCommand.Parameters.AddWithValue("@min", fromDate);
    //        ad.SelectCommand.Parameters.AddWithValue("@max", toDate);
    //        ad.SelectCommand.Parameters.AddWithValue("@SalesRepId", txt_SalesRepId.Text.Trim());
    //        ad.SelectCommand.Parameters.AddWithValue("@soldto", txt_Buyerid.Text.Trim());
    //        ad.SelectCommand.Parameters.AddWithValue("@invoiceno", Txt_InvoiceNo.Text == "" ? "" : Txt_InvoiceNo.Text.Trim());
    //        ad.SelectCommand.Parameters.AddWithValue("@status", ddl_Status.SelectedValue.ToString());
    //        ad.SelectCommand.Parameters.AddWithValue("@Del_Status", ddl_Del_Status.SelectedValue.ToString());
    //        dt = new DataTable();
    //        ad.Fill(dt);
    //        DataColumn dcDtl = new DataColumn("tbl", typeof(string));
    //        dt.Columns.Add(dcDtl);
    //        DataColumn srno_Encript = new DataColumn("srno_Encript", typeof(string));
    //        dt.Columns.Add(srno_Encript);
    //        DataColumn invoiceno_Encript = new DataColumn("invoiceno_Encript", typeof(string));
    //        dt.Columns.Add(invoiceno_Encript);
    //        foreach (DataRow row in dt.Rows)
    //        {
    //            utility objutil = new utility();

    //            row.SetField("srno_Encript", objutil.base64Encode(row["srno"].ToString()));
    //            row.SetField("invoiceno_Encript", objutil.base64Encode(row["invoiceno"].ToString()));

    //            XElement objXml = XElement.Parse(row["dtl"].ToString());
    //            string strDtl = "<table rules='all' border='1' style='width:100%;border-collapse:collapse;'>";
    //            strDtl += "<tr><th>Name</th><th>Quantity</th><th>MRP</th><th>Total</th></tr>";
    //            foreach (XElement p in objXml.Elements("P"))
    //            {
    //                strDtl += "<tr>";
    //                strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
    //                strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
    //                strDtl += "<td>" + p.Elements("MRP").FirstOrDefault().Value + "</td>";
    //                strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
    //                strDtl += "</tr>";
    //            }
    //            strDtl += "</table>";
    //            row["tbl"] = strDtl;
    //        }
    //        GridView1.Columns[13].FooterText = dt.Compute("sum(NoOFProduct)", "true").ToString();
    //        GridView1.Columns[14].FooterText = dt.Compute("sum(Actual_Qty)", "true").ToString();
    //        GridView1.Columns[15].FooterText = dt.Compute("sum(grossAmt)", "true").ToString();

    //        GridView1.Columns[16].FooterText = dt.Compute("sum(SGST)", "true").ToString();
    //        GridView1.Columns[17].FooterText = dt.Compute("sum(CGST)", "true").ToString();
    //        GridView1.Columns[18].FooterText = dt.Compute("sum(IGST)", "true").ToString();
    //        GridView1.Columns[19].FooterText = dt.Compute("sum(Cess)", "true").ToString();
    //        GridView1.Columns[20].FooterText = dt.Compute("sum(netAmt)", "true").ToString();

    //        GridView1.Columns[21].FooterText = dt.Compute("sum(CourierCharges)", "true").ToString();
    //        GridView1.Columns[22].FooterText = dt.Compute("sum(Discount)", "true").ToString();
    //        GridView1.Columns[23].FooterText = dt.Compute("sum(Amount)", "true").ToString();

    //        GridView1.Columns[24].FooterText = dt.Compute("sum(TotalFPV)", "true").ToString();


    //        GridView1.DataSource = dt;
    //        GridView1.DataBind();


    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}

    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindGrid();
    //}
    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    BindGrid();
    //}
    //protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    //{

    //}
    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    try
    //    {
    //        string Result = string.Empty;
    //        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //        invoiceno = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
    //        if (e.CommandName.Equals("cancel"))
    //        {
    //            con = new SqlConnection(method.str);
    //            SqlCommand cmd = new SqlCommand("StockCancel", con);
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@invoiceno", invoiceno);
    //            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
    //            con.Open();
    //            cmd.ExecuteNonQuery();
    //            Result = cmd.Parameters["@flag"].Value.ToString();
    //            con.Close();
    //            if (Result == "1")
    //                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Stock cancel Successfully.');window.location='stocktranlist.aspx';", true);
    //            else
    //                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('" + Result + "');window.location='stocktranlist.aspx';", true);


    //        }
    //        //if (e.CommandName.Equals("update"))
    //        //{
    //        //    TextBox txtTransport = (TextBox)row.FindControl("txtTransport");
    //        //    TextBox txtTracking = (TextBox)row.FindControl("txtTracking");
    //        //    TextBox txt_EWayBill = (TextBox)row.FindControl("txt_EWayBill");
    //        //    TextBox txtcmt = (TextBox)row.FindControl("txtcom");
    //        //    con = new SqlConnection(method.str);
    //        //    SqlCommand cmd = new SqlCommand("Update_StockDelivery", con);
    //        //    cmd.CommandType = CommandType.StoredProcedure;

    //        //    cmd.Parameters.AddWithValue("@invoiceno", invoiceno);
    //        //    cmd.Parameters.AddWithValue("@Transport", txtTransport.Text);
    //        //    cmd.Parameters.AddWithValue("@Tracking", txtTracking.Text);
    //        //    cmd.Parameters.AddWithValue("@EwayNo", txt_EWayBill.Text);
    //        //    cmd.Parameters.AddWithValue("@Del_Remarks", txtcmt.Text);
    //        //    cmd.Parameters.AddWithValue("@Del_by", Session["admin"].ToString());
    //        //    cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
    //        //    con.Open();
    //        //    cmd.ExecuteNonQuery();
    //        //    Result = cmd.Parameters["@flag"].Value.ToString();
    //        //    if (Result == "1")
    //        //    {
    //        //        utility.MessageBox(this, "Deliver Updated Successfully");
    //        //    }
    //        //    else
    //        //    {
    //        //        utility.MessageBox(this, Result);
    //        //    }
    //        //}
    //        BindGrid();
    //    }
    //    catch (Exception ex)
    //    {
    //        utility.MessageBox(this, ex.ToString());
    //    }
    //    finally
    //    {

    //    }
    //}
    //protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    //{ }

    //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        LinkButton lnkbtnCancel = (LinkButton)e.Row.FindControl("lnkbtnCancel");
    //        HiddenField hnd_Status = (HiddenField)e.Row.FindControl("hnd_status");
    //        HiddenField hnd_Del_Status = (HiddenField)e.Row.FindControl("hnd_Del_Status");
    //        Label lbl_status = (Label)e.Row.FindControl("lbl_cancelled");
    //        Label lbl_DelStatus = (Label)e.Row.FindControl("lbl_DelStatus");

    //        //TextBox txtTransport = (TextBox)e.Row.FindControl("txtTransport");
    //        //TextBox txtTracking = (TextBox)e.Row.FindControl("txtTracking");
    //        //TextBox txt_EWayBill = (TextBox)e.Row.FindControl("txt_EWayBill");
    //        //TextBox txtcmt = (TextBox)e.Row.FindControl("txtcom");
    //        //Button btnSubmit = (Button)e.Row.FindControl("btnSubmit");

    //        if (hnd_Status.Value.ToString() == "0")
    //        {
    //            lbl_status.Text = "Submit";
    //            lbl_status.ForeColor = Color.Green;
    //        }
    //        if (hnd_Status.Value.ToString() == "1")
    //        {
    //            lbl_status.ForeColor = Color.Green;
    //            lbl_status.Text = "Submit";
    //        }
    //        if (hnd_Status.Value.ToString() == "2")
    //        {
    //            lbl_status.ForeColor = Color.Red;
    //            lnkbtnCancel.Visible = false;
    //            lbl_status.Text = "Cancelled";
    //            e.Row.ForeColor = System.Drawing.Color.Red;
    //            e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#ffdadc");
    //            //txtTransport.Enabled = false;
    //            //txtTracking.Enabled = false;
    //            //txt_EWayBill.Enabled = false;
    //            //txtcmt.Enabled = false;
    //            //btnSubmit.Enabled = false;
    //        }

    //        if (hnd_Del_Status.Value == "1")
    //        {
    //            //txtTransport.Enabled = false;
    //            //txtTracking.Enabled = false;
    //            //txt_EWayBill.Enabled = false;
    //            //txtcmt.Enabled = false;
    //            //btnSubmit.Enabled = false;

    //            lbl_DelStatus.Text = "Delivered";
    //            lbl_DelStatus.ForeColor = Color.Green;
    //        }
    //        else
    //        {
    //            lbl_DelStatus.Text = "Pending";
    //            lbl_DelStatus.ForeColor = Color.Red;
    //        }

    //    }
    //}


    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}
    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    Response.Clear();
    //    Response.Buffer = true;
    //    Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_StockInvList.xls");
    //    Response.Charset = "";
    //    Response.ContentType = "application/vnd.ms-excel";
    //    using (StringWriter sw = new StringWriter())
    //    {
    //        HtmlTextWriter hw = new HtmlTextWriter(sw);

    //        GridView1.AllowPaging = false;
    //        BindGrid();
    //        GridView1.Columns[32].Visible = false;
    //        GridView1.HeaderRow.BackColor = System.Drawing.Color.White;
    //        foreach (TableCell cell in GridView1.HeaderRow.Cells)
    //        {
    //            cell.BackColor = GridView1.HeaderStyle.BackColor;
    //        }
    //        foreach (GridViewRow row in GridView1.Rows)
    //        {
    //            row.BackColor = System.Drawing.Color.White;
    //            foreach (TableCell cell in row.Cells)
    //            {
    //                if (row.RowIndex % 2 == 0)
    //                {
    //                    cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
    //                }
    //                else
    //                {
    //                    cell.BackColor = GridView1.RowStyle.BackColor;
    //                }
    //                cell.CssClass = "textmode";


    //                List<Control> controls = new List<Control>();

    //                //Add controls to be removed to Generic List
    //                foreach (Control control in cell.Controls)
    //                {
    //                    controls.Add(control);
    //                }

    //                //Loop through the controls to be removed and replace with Literal
    //                foreach (Control control in controls)
    //                {
    //                    switch (control.GetType().Name)
    //                    {
    //                        case "HyperLink":
    //                            cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
    //                            break;
    //                        case "TextBox":
    //                            cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
    //                            break;
    //                        case "LinkButton":
    //                            cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
    //                            break;
    //                    }
    //                    cell.Controls.Remove(control);
    //                }
    //            }
    //        }

    //        GridView1.RenderControl(hw);
    //        //style to format numbers to string
    //        string style = @"<style> .textmode { } </style>";
    //        Response.Write(style);
    //        Response.Output.Write(sw.ToString());
    //        Response.Flush();
    //        Response.End();
    //    }


    //    //if (GridView1.Rows.Count > 0)
    //    //{
    //    //    GridView1.AllowPaging = false;
    //    //    BindGrid();
    //    //     GridView1.Columns[30].Visible = false;
    //    //    Response.Clear();
    //    //    Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stocktranlist.xls");
    //    //    Response.Charset = "";
    //    //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //    //    Response.ContentType = "application/vnd.xls";
    //    //    System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //    //    System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //    //    this.GridView1.RenderControl(htmlWrite);
    //    //    Response.Write(stringWrite.ToString());
    //    //    Response.End();
    //    //}
    //    //else
    //    //{
    //    //    utility.MessageBox(this, "Can't export as no data found.");
    //    //}
    //}
    //protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        BindGrid();
    //        GridView1.Columns[30].Visible = false;
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_stockinhand.doc");
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        this.GridView1.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}

}
