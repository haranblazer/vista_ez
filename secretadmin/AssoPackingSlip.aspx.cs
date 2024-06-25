using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.Data.SqlClient;
using System.Xml;
using System.Xml.Linq;
using System.Collections;

//using iTextSharp.text;
//using System.IO;
//using iTextSharp.text.html.simpleparser;
//using iTextSharp.text.pdf;
//using System.Web.UI;
 

public partial class franchise_AssoPackingSlip : System.Web.UI.Page
{
    static string Invoiceno = "", BilltypeValue = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
            Response.Redirect("Logout.aspx");

        if (!IsPostBack)
        {
            Session["CheckRefresh"] = System.DateTime.Now.ToString();
            try
            {
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["id"] != "")
                    {
                        utility obj = new utility();
                        Invoiceno = Request.QueryString["id"].ToString();
                        BindDetail(Invoiceno);
                    }
                }
            }
            catch (Exception er) { }
        }
    }

   

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {
                Session["CheckRefresh"] = System.DateTime.Now.ToString();

                XElement element = null;

                element = new XElement("Bill");
                foreach (GridViewRow row in GridView1.Rows)
                {
                    TextBox txt_BoxNo = (TextBox)row.FindControl("txt_BoxNo");
                    Label lbl_productname = (Label)row.FindControl("lbl_productname");
                    HiddenField hdn_Pid = (HiddenField)row.FindControl("hdn_Pid");
                    HiddenField hdn_Qty = (HiddenField)row.FindControl("hdn_Qty");

                    XElement prdXml = new XElement("P",
                            new XElement("Box", txt_BoxNo.Text),
                            new XElement("pname", lbl_productname.Text),
                            new XElement("cd", hdn_Pid.Value),
                            new XElement("Qnt", hdn_Qty.Value)
                      );
                    element.Add(prdXml);
                }


                var xmlObject = new XmlDocument();
                xmlObject.LoadXml(element.ToString());
                if (element != null)
                {
                    SqlConnection con = new SqlConnection(method.str);
                    SqlCommand com = new SqlCommand("AddPackingSlip", con);
                    com.CommandType = CommandType.StoredProcedure;
                    com.Parameters.AddWithValue("@Invoiceno", Invoiceno);
                    com.Parameters.Add("@Detail", SqlDbType.Xml).Value = xmlObject.OuterXml;
                    com.Parameters.AddWithValue("@Inv_Type", "BillMst");
                    com.Parameters.Add("@flag", SqlDbType.VarChar, 500).Direction = ParameterDirection.Output;
                    con.Open();
                    com.CommandTimeout = 1900;
                    com.ExecuteNonQuery();
                    string status = com.Parameters["@flag"].Value.ToString();
                    if (status == "1")
                    {
                        utility.MessageBox(this, "Your details save successfully.");
                        return;
                    }
                }
            }
            else
            {
                utility.MessageBox(this, "Don't refresh this page.!!");
                return;
            }
        }
        catch (Exception er)
        {
            utility.MessageBox(this, er.Message);
            return;
        }

    }


    private void BindDetail(String Invoiceno)
    {
        SqlParameter[] param = new SqlParameter[]
        {
        new SqlParameter("@Invoiceno", Invoiceno),
        new SqlParameter("@Inv_Type", "BillMst")
        };
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTableSP(param, "GetPackingSlip");
        if (dt.Rows.Count > 0)
        {
            GridView1.Columns[0].FooterText = "Total: ";
            GridView1.Columns[3].FooterText =dt.Compute("sum(quantity)", "true").ToString();
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        SqlParameter[] param1 = new SqlParameter[]
        {  new SqlParameter("@Invoiceno", Invoiceno.Trim()) };
        DataTable dtNew = objDu.GetDataTable(param1, "Select srno from billmst where InvoiceNo=@Invoiceno");
        if (dtNew.Rows.Count > 0)
        { 
            BindCompany(dtNew.Rows[0]["srno"].ToString());
            userdetail(dtNew.Rows[0]["srno"].ToString());
        }
    }

    private void BindCompany(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] {
                new SqlParameter("@invoice", srno)
        };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "companydetail");
        if (dt.Rows.Count > 0)
        { 
            lbl_ComAdd.Text = dt.Rows[0]["oraddress"].ToString();
            lbl_ComMobileno.Text = dt.Rows[0]["phone"].ToString();
            lbl_ComEmail.Text = dt.Rows[0]["emailid"].ToString();
            
            lbl_ComPanNo.Text = dt.Rows[0]["panno"].ToString();
            lbl_ComCIN.Text = dt.Rows[0]["cinno"].ToString();
            lbl_MainCompanyCIN.Text = dt.Rows[0]["CompanyCIN"].ToString();
        }

    }


    private void userdetail(string srno)
    {
        SqlParameter[] sqlparam = new SqlParameter[] { new SqlParameter("@invoice", srno) };
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTableSP(sqlparam, "printbill");
        if (dt.Rows.Count > 0)
        { 
            lbl_Sellerid.Text = dt.Rows[0]["salesrep"].ToString();
            lbl_SellerName.Text = dt.Rows[0]["SellerName"].ToString();

            lbl_UserINVNo.Text =  dt.Rows[0]["InvoiceNo"].ToString();
            lbl_UserINVDate.Text = lbl_InvoiceDate.Text = lbl_Date_PO_NO.Text = dt.Rows[0]["Doe"].ToString();


            lbl_User_PO_NO.Text = dt.Rows[0]["orderno"].ToString();
            lbl_PayMode.Text = dt.Rows[0]["PayMode"].ToString();

            lbl_Userid.Text = dt.Rows[0]["appmstregno"].ToString();
            lbl_UserName.Text = dt.Rows[0]["appmstfname"].ToString();
            lbl_UserAdd.Text = dt.Rows[0]["AppMstAddress1"].ToString();
            lbl_UserMobileNo.Text = dt.Rows[0]["appmstmobile"].ToString();
            lbl_UserEmail.Text = dt.Rows[0]["email"].ToString();
            lbl_UserGSTIN.Text = dt.Rows[0]["GST"].ToString();
            lbl_UserPAN.Text = dt.Rows[0]["panno"].ToString();
            lbl_UserInvType.Text = lbl_InvType.Text = dt.Rows[0]["BillType"].ToString();
            lbl_UserCIN.Text = "";
            lbl_EwayNo.Text = dt.Rows[0]["EwayNo"].ToString();
            lbl_ShipingAdd.Text = dt.Rows[0]["ToAddress"].ToString();
            if (dt.Rows[0]["status"].ToString() == "0")
            {
                imgbill.Visible = true;
            }
            else
            {
                imgbill.Visible = false;
            }
            BilltypeValue = dt.Rows[0]["BilltypeValue"].ToString();
            if (BilltypeValue == "1")
                BilltypeValue = "TPV";
            else
                BilltypeValue = "RPV";
            Session["BilltypeValue"] = BilltypeValue;
        }
    }


    //protected void btnExport_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        Response.ContentType = "application/pdf";
    //        Response.AddHeader("content-disposition", "attachment;filename=Packingslip.pdf");
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        StringWriter sw = new StringWriter();
    //        HtmlTextWriter hw = new HtmlTextWriter(sw);
    //        Div_PackageSlip.RenderControl(hw);
    //        StringReader sr = new StringReader(sw.ToString());
    //        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
    //        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
    //        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
    //        pdfDoc.Open();
    //        htmlparser.Parse(sr);
    //        pdfDoc.Close();
    //        Response.Write(pdfDoc);
    //        Response.End();
    //    }
    //    catch (Exception er) { }

    //}
    //public override void VerifyRenderingInServerForm(Control control) { }
}