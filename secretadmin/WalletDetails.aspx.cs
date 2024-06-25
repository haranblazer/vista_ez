using System; 
using System.Data;
using System.Data.SqlClient; 
using System.Web.UI; 

public partial class secretadmin_WalletDetails : System.Web.UI.Page
{
    static string MstKey = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["admin"] == null)
                Response.Redirect("Logout.aspx");
            else
            {
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["Id"] != null)
                    {
                        MstKey = Request.QueryString["Id"].ToString();
                        Binddata(MstKey);
                    }
                }
                lbl_Header.Text = "";
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Request.QueryString.Count > 0)
        {
            if (Request.QueryString["Id"] != null)
            {
                MstKey = Request.QueryString["Id"].ToString();
                Binddata(MstKey);
            }
        }
        lbl_Header.Text = "";
    }

    public void Binddata(string MstKey)
    {
        try
        {
            DataUtility objDu = new DataUtility();
            SqlParameter[] param1 = new SqlParameter[]
            {
                new SqlParameter("@MstKey", MstKey),
                new SqlParameter("@UserId", txt_Userid.Text.Trim()) 
            };
            DataTable dt = objDu.GetDataTableSP(param1, "Get_WalletBalDetail");
            ViewState["dt"] = dt;
            if (dt.Rows.Count > 0)
            {
                GridView1.Columns[2].FooterText = "Total: ";
                GridView1.Columns[4].FooterText = dt.Compute("sum(Balance)", "true").ToString();

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        catch (Exception ex)
        { }
    }


    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            DataTable dt = new DataTable();
            if (ViewState["dt"] != null)
                dt = (DataTable)ViewState["dt"];
 

            if (dt.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Details.xls"));
                Response.ContentType = "application/ms-excel";
                string str = string.Empty;
                foreach (DataColumn dtcol in dt.Columns)
                {
                    Response.Write(str + dtcol.ColumnName);
                    str = "\t";
                }
                Response.Write("\n");
                foreach (DataRow dr in dt.Rows)
                {
                    str = "";
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Response.Write(str + Convert.ToString(dr[j]));
                        str = "\t";
                    }
                    Response.Write("\n");
                }
                Response.End();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No data found.');", true);
            }
        }
        catch (Exception er) { }

    }
}