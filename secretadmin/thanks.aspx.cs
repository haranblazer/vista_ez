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
using System.Net;
using System.IO;
using System.Linq;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.Text.RegularExpressions;
using System.Data.SqlClient;

public partial class user_newjoins : System.Web.UI.Page
{
    utility objUtil = null;
    string PSource;
    String html;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["n"] != null)
        {
            objUtil = new utility();
            lblname.Text = objUtil.base64Decode(Request.QueryString["n"].Trim());
            lblUserid.Text = objUtil.base64Decode(Request.QueryString["i"].Trim());
            lblMobileNo.Text = objUtil.base64Decode(Request.QueryString["mob"].Trim());
            lblSponsorId.Text = objUtil.base64Decode(Request.QueryString["sid"].Trim());
            // LblEMailId.Text = "saini.sunder158@gmail.com";
            LblEMailId.Text = objUtil.base64Decode(Request.QueryString["em"].Trim());

            string p = objUtil.base64Decode(Request.QueryString["pass"].Trim());
            PSource = p;
            try
            {

                p = p.Replace(p.Substring(0, 4), "****");
                p = p.Replace(p.Substring(p.Length - 2, 2), "**");
            }
            catch
            {
            }
            lblpassword.Text = p;
            // tran password 


            SendInvoice();
            // sendSMS();
            invoicereg.InnerHtml = html.ToString();
            //}
        }
    }



    private void SendInvoice()
    {
        try
        {
            objUtil = new utility();

            WebRequest request = WebRequest.Create("http://www.richnrise.in/mailer/registra.htm");
            WebResponse response = request.GetResponse();
            Stream data = response.GetResponseStream();
            using (StreamReader sr = new StreamReader(data))
            {
                html = sr.ReadToEnd();
            }

            html = html.Replace("uuuuuuuu", lblUserid.Text.Trim().ToUpper()).Replace("ffffffff", lblname.Text.ToUpper()).Replace("jjjjjjjj", DateTime.Now.ToString("dd/MM/yyyy")).Replace("mmmmmmm", lblMobileNo.Text).Replace("nnnnnnnn", lblname.Text.ToUpper()).Replace("eeeeeeee", LblEMailId.Text.ToUpper()).Replace("pppppppp", PSource).Replace("tpppppppt", PSource).Replace("cccnnnn", objUtil.companyname().AsEnumerable().FirstOrDefault().Field<string>("companyname")).Replace("llllllllll", objUtil.companyname().AsEnumerable().FirstOrDefault().Field<string>("noreply")).Replace("VisitSite", objUtil.companyname().AsEnumerable().FirstOrDefault().Field<string>("website"));

            //  html = html.Replace("uuuuuuuu", lblUserid.Text.Trim().ToUpper()).Replace("ffffffff", lblname.Text.ToUpper()).Replace("jjjjjjjj", DateTime.Now.ToString("dd/MM/yyyy")).Replace("mmmmmmm", lblMobileNo.Text).Replace("nnnnnnnn", lblname.Text.ToUpper()).Replace("eeeeeeee", LblEMailId.Text.ToUpper()).Replace("pppppppp", PSource).Replace("tpppppppt", PSource).Replace("cccnnnn", objUtil.companyname().AsEnumerable().FirstOrDefault().Field<string>("companyname")).Replace("llllllllll", objUtil.companyname().AsEnumerable().FirstOrDefault().Field<string>("noreplymail"));
            // string b = "<body><form>" + html.Split('$').GetValue(1).ToString().Replace("\"", " ").ToString().Replace("\r", "").ToString().Replace("\n", "").ToString().Split('$').GetValue(0).ToString() + "</body></form>";
            objUtil.sendInvoiceMail(LblEMailId.Text, "Welcome to GoodWillBusiness.", html);
        }
        catch
        {
        }
    }

    private void sendSMS()
    {
        objUtil = new utility();
        string text = "Dear " + lblname.Text.Trim() + " id:" + lblUserid.Text.Trim() + " Your password is " + objUtil.base64Decode(Request.QueryString["pass"].Trim());
        objUtil.sendSMSByPage(lblMobileNo.Text.Trim(), text);
    }


    protected void Button1_Click1(object sender, EventArgs e)
    {
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Invoice.pdf");
        Response.ContentType = "application/pdf";
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        invoicereg.RenderControl(hw);
        StringReader sr = new StringReader(Regex.Replace(sw.ToString(), "</?(a|A).*?>", ""));
        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        pdfDoc.Open();
        htmlparser.Parse(sr);
        pdfDoc.Close();
        Response.Write(pdfDoc);
        Response.End();
    }

}
