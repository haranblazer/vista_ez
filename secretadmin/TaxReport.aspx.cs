using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml;
using System.IO;

public partial class Admin_TaxReport : System.Web.UI.Page
{
    DataTable t1 = new DataTable();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    SqlDataAdapter da;
    utility u = new utility();
    string regno, name = "";
    XmlDocument xmldoc = new XmlDocument();
    string xmlfile = "";
    double tax;
    double taxamount,sum2=0,sum4=0,sum5=0,sum10=0,sum12=0;
    int invoiceno;
    double amount; 
    DateTime date;
   
    double tax2=0,tax4=0, tax5=0,tax10=0,tax12=0;    
    DataTable dt = new DataTable();   
    protected void Page_Load(object sender, EventArgs e)
    {
     
        if (!IsPostBack)
        {
            dt.Columns.Add("InvoiceNo", typeof(string));
            dt.Columns.Add("name", typeof(string));
            dt.Columns.Add("regno", typeof(string));
            dt.Columns.Add("TAX2", typeof(double));
            dt.Columns.Add("TAX4", typeof(double));
            dt.Columns.Add("TAX5", typeof(double));
            dt.Columns.Add("TAX10", typeof(double));
            dt.Columns.Add("TAX12", typeof(double));          
            dt.Columns.Add("Amount2", typeof(double));
            dt.Columns.Add("Amount4", typeof(double));
            dt.Columns.Add("Amount5", typeof(double));
            dt.Columns.Add("Amount10", typeof(double));
            dt.Columns.Add("Amount12", typeof(double));
            dt.Columns.Add("Date", typeof(string));
            txtFromDate.Text = DateTime.Now.Date.AddDays(-15).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");
            show();
        }
    }

    public void show()
    {

        cmd = new SqlCommand("select  a.appmstfname,a.appmstregno,s.Detail,s.invoiceno,s.amount,s.checkdate from stockmst s,appmst a where a.appmstid=s.appmstid", con);
        con.Open();
        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        while (dr.Read())
        {
           sum2 = sum4=sum5 =sum10= sum12 = tax2 =tax4= tax5 =tax10= tax12 = 0;

           xmlfile = dr["detail"].ToString();         
           name = dr["appmstfname"].ToString();
           regno = dr["appmstregno"].ToString();
           invoiceno = int.Parse(dr["invoiceno"].ToString());
           date = DateTime.Parse(dr["checkdate"].ToString());        
           xml();
      
        }
        dr.Close();
        con.Close();
        ViewState["ab"] = dt;
        DataView dv = new DataView(dt);
        dv.RowFilter = "DATE>='" + txtFromDate.Text + "' and DATE<='" + txtToDate.Text + "'";
        dglst.DataSource = dv;
        dglst.DataBind();
       
       
       

    }

    void xml()
    {
        xmldoc.LoadXml(xmlfile);       
        XmlNodeList xnList = xmldoc.SelectNodes("/Bill/P");
        foreach (XmlNode xn in xnList)
        {                  
           tax = double.Parse(xn["TAX"].InnerText);
           taxamount = double.Parse(xn["TAXRS"].InnerText);
           amount = double.Parse(xn["total"].InnerText);        
           if (tax == 2)
           {

               tax2 = tax2 + taxamount;
               sum2 = sum2 + amount;
           }
           if (tax == 4)
           {
               tax4 = tax4 + taxamount;
               sum4 = sum4 + amount;

           }
           if (tax == 5)
           {
               tax5 = tax5 + taxamount;
               sum5 = sum5 + amount;

           }

           if (tax == 10)
           {
               tax10 = tax10 + taxamount;
               sum10 = sum10 + amount;

           }
          
           if (tax == 12.5)
           {
               tax12 = tax12 + taxamount;
               sum12 = sum12 + amount;

           }
                 
        }

        dt.Rows.Add(invoiceno,name,regno,Math.Round(tax2, 2), Math.Round(tax4, 2), Math.Round(tax5, 2), Math.Round(tax10, 2), Math.Round(tax12, 2), Math.Round(sum2, 2), Math.Round(sum4, 2), Math.Round(sum5, 2), Math.Round(sum10, 2), Math.Round(sum12, 2), date.ToString("dd/MM/yyyy"));
            
    }
  


    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        dglst.PageIndex = e.NewPageIndex;
       
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        DataTable dtt = (DataTable)ViewState["ab"];
        DataView dv = new DataView(dtt);
        dv.RowFilter = "DATE>='" + txtFromDate.Text + "' and DATE<='" + txtToDate.Text + "'";
        dglst.DataSource = dv;
        dglst.DataBind();


    }
}