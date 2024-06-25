using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Xml.Linq;

public partial class secretadmin_AddLeader : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
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
           if (!IsPostBack) {
                txtFromDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            }
            
        }
        catch
        {
        }
    }

    [System.Web.Services.WebMethod]
   
    public static Detail[] bindtable(string From, string To, string User_Id,string Amount,string Order_Id,string Order_No,string Status)
    {
        List<Detail> details = new List<Detail>();
        DataUtility objDu = new DataUtility();
        try
        {
             //string fromDate = "", toDate = "";
            try
            {
                if (From.Trim().Length > 0)
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

            
            new SqlParameter("@Min", From),
            new SqlParameter("@Max", To),
            new SqlParameter("@Userid", User_Id),
            new SqlParameter("@Amount",  Amount =="" ? "0" : Amount),
            new SqlParameter("@Orderid", Order_Id),
            new SqlParameter("@Orderno", Order_No),
            new SqlParameter("@PaymentStatus", Status),



           // new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString())
                };

            SqlDataReader dr = objDu.GetDataReaderSP(param, "Get_OfflinePayment");
            utility objUtil = new utility();
            while (dr.Read())
            {
                Detail data = new Detail();
               

                data.Date = dr["doe"].ToString();
                data.Order_Id = dr["OrderID"].ToString();
                data.Order_No = dr["OrderNo"].ToString();
                data.Payable_Amount = dr["Amount"].ToString();
                data.Payment_Mode = dr["PayMode"].ToString();
                data.Transaction_Amount = dr["OnlineAmount"].ToString();
                data.Payment_Status = dr["OnlineStatus"].ToString();
                data.Online_Response = dr["OnlineMsg"].ToString();
                data.Buyer_Id = dr["SoldTo"].ToString();
                data.Buyer_Name = dr["Appmstfname"].ToString();

                XElement objXml = XElement.Parse(dr["Detail"].ToString());
                string strDtl = "<table class='table table-striped table-hover display dataTable nowrap cell-border cell-border style='width:100%'>";
                strDtl += "<tr><th>Prod Name</th><th>Prod Code</th><th>QTY</th><th>GST</th><th>Gross Amt</th><th>Net Amt</th><th>Total Amt</th></tr>";
                foreach (XElement p in objXml.Elements("P"))
                {
                    strDtl += "<tr>";
                    strDtl += "<td>" + p.Elements("pname").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("cd").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("Qnt").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("TAXRS").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("DP").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("DPWithTax").FirstOrDefault().Value + "</td>";
                    strDtl += "<td>" + p.Elements("total").FirstOrDefault().Value + "</td>";
                   
                    strDtl += "</tr>";
                }
                strDtl += "</table>";
                data.tbl = strDtl;


                details.Add(data);
            };



        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class Detail

    {
       
        public string Date { get; set; }
        public string Order_Id { get; set; }
        public string Order_No { get; set; }
        public string Payable_Amount { get; set; }
        public string Payment_Mode { get; set; }
        public string Transaction_Amount { get; set; }
        public string Payment_Status { get; set; }
        public string Online_Response { get; set; }
        public string tbl { get; set; }

        public string Buyer_Id { get; set; }
        public string Buyer_Name { get; set; }
        

    }

}