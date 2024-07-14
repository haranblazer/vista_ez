using System; 
using System.Data.SqlClient;
using System.Data;

public partial class admin_IDCard : System.Web.UI.Page
{
    SqlConnection con = null;
    string regno = "";
    SqlCommand com = null;
    SqlDataAdapter da = null;
    utility obj = new utility();
    int inc = 3;
    static string imgLogo, flag="0";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Convert.ToString(Session["userId"])))
        {
            Response.Redirect("~/Default.aspx", false);
            return;
        }

        if (!IsPostBack)
        {
            regno = Session["userId"].ToString().Trim();
            BindData();

        }
    }

    public void NavigateRecords()
    {
        DataSet ds = obj.getCompnayDetails();
        DataRow dRow = ds.Tables[0].Rows[inc];
        imgLogo = dRow.ItemArray.GetValue(2).ToString();
        
    }
    public void BindData()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("GetUserByIdImg", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", regno);
        SqlDataAdapter da = new SqlDataAdapter(com);
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {

            Session["DT"] = null;
            Datalist1.DataSource = dt;
            Datalist1.DataBind();
        }
        else
        {
            Datalist1.DataSource = null;
            Datalist1.DataBind();
        }
    }
    
}