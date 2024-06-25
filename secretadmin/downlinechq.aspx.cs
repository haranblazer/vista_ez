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
public partial class admin_downlinechq : System.Web.UI.Page
{
    string regno;
    string payoutno;
     int cheques;
    static int j;
    static int c;
    SqlConnection con = new SqlConnection(method.str);

    SqlDataAdapter da;
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        InsertFunction.CheckAdminlogin();
        regno = Session["regno"].ToString();
        payoutno = Request.QueryString["pno"].ToString();
        cheques = Convert.ToInt32(Request.QueryString["NoChq"]);
        Server.ScriptTimeout = 1440;
        if (!Page.IsPostBack)
        {
            j = Convert.ToInt32(Request.QueryString["startid"]);
            c =  cheques;
            fetch();
        }
    }
  
    public void fetch()
    {
        string myStProc = "downlinechque1";
        da = new SqlDataAdapter(myStProc, con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.CommandTimeout = 999999;
        da.SelectCommand.Parameters.AddWithValue("@from", j);
        da.SelectCommand.Parameters.AddWithValue("@to", c);
        da.SelectCommand.Parameters.AddWithValue("@payoutno", payoutno);
        da.SelectCommand.Parameters.AddWithValue("@regno", regno);  
        
        DataSet ds = new DataSet();
        da.Fill(ds, "downlinechque1");
        Repeater1.DataSource = ds;
        Repeater1.DataBind();
      //  c = c + cheques;
       // j = j + cheques;

        con.Close();

        con.Dispose();







    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("downlineresult.aspx");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        fetch();
    }

}
