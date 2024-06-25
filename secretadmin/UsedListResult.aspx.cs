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
public partial class admin_UsedListResult : System.Web.UI.Page
{
    SqlConnection con;
    int StartIndex;
    int EndIndex;

    protected void Page_Load(object sender, EventArgs e)
    {
        con = new SqlConnection(method.str);
        InsertFunction.CheckAdminlogin();
        if (!IsPostBack)
        {

            con.Open();
            SqlCommand cmd = new SqlCommand("select count(*) from pinmst where isactivate=1 and paidappmstid=1", con);
            dgrd.VirtualItemCount = (int)((int)(cmd.ExecuteScalar()) / (int)(dgrd.PageSize));
            con.Close();
            databind();
        }
    }
    private void databind()
    {
        EndIndex = StartIndex + dgrd.PageSize;
        con = new SqlConnection(method.str);
        con.Open();
        SqlDataAdapter adp = new SqlDataAdapter("select srno,pinsrno from pinmst where isactivate=1 and paidappmstid=1 and srno >@startindex and srno<=@endindex order by srno", con);
        adp.SelectCommand.Parameters.Add("@startindex", StartIndex);
        adp.SelectCommand.Parameters.Add("@endindex", EndIndex);
        DataSet ds = new DataSet();
        adp.Fill(ds);

        dgrd.DataSource = ds;
        dgrd.DataBind();
        con.Close();
    }
   
    protected void dgrd_PageIndexChanged(object source, DataGridPageChangedEventArgs e)
    {
        StartIndex = (e.NewPageIndex * dgrd.PageSize);
        dgrd.CurrentPageIndex = e.NewPageIndex;
        databind();
    }
}
