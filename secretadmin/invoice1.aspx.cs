using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class yesadmin_invoice1 : System.Web.UI.Page
{


    int pno = 0;
    int min = 0;
    int max = 0;
    static int appmstid;
    static int j;
    static int c;
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    System.Data.DataTable dt = new DataTable();
    utility objUtil = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
        {
            utility.CheckSuperAdminlogin();
        }
        else if (Convert.ToString(Session["admintype"]) == "a")
        {
            utility.CheckAdminloginInside();
        }
        else
        {
            Response.Redirect("adminLog.aspx");
        }
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["pno"] != null)
            {
                pno = Convert.ToInt32(objUtil.base64Decode(Request.QueryString["pno"].ToString()));
         appmstid= min = Convert.ToInt32(objUtil.base64Decode(Request.QueryString["min"].ToString()));
               max = Convert.ToInt32(objUtil.base64Decode(Request.QueryString["max"].ToString()));
            }
            fetch();
        }

    }
    public void fetch()
    {

        SqlDataAdapter da = new SqlDataAdapter("welcomeinvoiceprint", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.CommandTimeout = 999999;
        da.SelectCommand.Parameters.AddWithValue("@Payoutno", pno);
        da.SelectCommand.Parameters.AddWithValue("@MinVal", min);
        da.SelectCommand.Parameters.AddWithValue("@MaxVal", max);
        da.SelectCommand.Parameters.AddWithValue("@Types", "INVOICE");
        DataTable dt = new DataTable();
        da.Fill(dt);
       // dt.Columns.Add(new DataColumn("Amount", typeof(string)));
        if (dt.Rows.Count > 0)
        {
            //foreach (DataRow row in dt.Rows)
            //{
            //    row["Amount"] = utility.NumberToWords(Convert.ToInt32(row["Amount"].ToString())).ToUpper() + " ONLY";
            //}

            Repeater1.DataSource = dt;           
            Repeater1.DataBind();
        }
        else
        {
            Repeater1.DataSource = null;
            Repeater1.DataBind();
        }

    }
   
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {


        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {

          if(min<=max)

            {
              
                Repeater aa = (Repeater)e.Item.FindControl("Repeater2");

                Label aa1 = (Label)e.Item.FindControl("Label3");

                Label aa2 = (Label)e.Item.FindControl("Label4");

                Label aa3 = (Label)e.Item.FindControl("lblAmtWord");


                Label aa4 = (Label)e.Item.FindControl("lblAmount");

                Label aa5 = (Label)e.Item.FindControl("Label2");


              

                SqlDataAdapter da = new SqlDataAdapter("select i.productname,i.quantity,i.peritemcost,i.price,i.tax  ,i.taxamount,  i.totalprice  as netamount from itemmst i inner join appmst a on i.productid=a.productid where a.appmstid='" + appmstid  + "'", con);

                DataTable dt = new DataTable();
                da.Fill(dt);


                object objSum2 = dt.Compute("Sum(taxamount)", "1 = 1");
                aa1.Text= objSum2.ToString();

                object objSum3 = dt.Compute("Sum(netamount)", "1 = 1");
               aa4.Text= aa2.Text = objSum3.ToString();


               object objSum4 = dt.Compute("Sum(peritemcost)", "1 = 1");

               aa5.Text = objSum4.ToString();


                aa3.Text = utility.NumberToWords(Convert.ToInt32(aa2.Text)).ToUpper() + " ONLY";  



                if (dt.Rows.Count > 0)
                {

                    aa.DataSource = dt;
                    aa.DataBind();
                }
                else
                {
                    aa.DataSource = null;
                    aa.DataBind();
                }

               appmstid++;
           }

           
        
        }
    }
}
