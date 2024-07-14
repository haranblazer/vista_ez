using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class user_associate_certificate : System.Web.UI.Page
{
    SqlConnection con = null;
    string regno = "";
    SqlCommand com = null;
    SqlDataAdapter da = null;
    utility obj = new utility();
    int inc = 3;
    public string username, userstate, userGRank,coName,coHead,headDegn,curDate,imgLogo;
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
            username = dt.Rows[0]["appmstfname"].ToString();
            userstate = dt.Rows[0]["Appmststate"].ToString();
            userGRank = dt.Rows[0]["RePurchase_rankName"].ToString();
            coName = dt.Rows[0]["companyname"].ToString();
            coHead = dt.Rows[0]["CoHead"].ToString();
            headDegn = dt.Rows[0]["HeadDesignation"].ToString();
            curDate = dt.Rows[0]["toDate"].ToString();
            imgLogo = dt.Rows[0]["CoLogo"].ToString();
        }
        else
        {
           
        }
    }
}