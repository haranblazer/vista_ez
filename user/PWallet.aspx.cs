using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web;

public partial class user_PWallet : System.Web.UI.Page
{
    DataTable dt = new DataTable();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com;
    SqlDataAdapter da;
    utility u = new utility();
    SqlDataReader dr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.AddDays(-30).Date.ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
                // Bind();
                BindData();
            }

        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString()),
                new SqlParameter("@min", min),
                new SqlParameter("@max", max)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "Pwallet");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.doe = dr["doe"].ToString();
                data.Userid = dr["Userid"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.Credit = dr["Credit"].ToString();
                data.Debit = dr["Debit"].ToString();
                data.Balance = dr["Balance"].ToString();
                data.descrip = dr["descrip"].ToString();
                data.Transactiontype = dr["Transactiontype"].ToString();
                data.Reason = dr["Reason"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string doe { get; set; }
        public string Userid { get; set; }
        public string UserName { get; set; }
        public string Credit { get; set; }
        public string Debit { get; set; }
        public string Balance { get; set; }
        public string descrip { get; set; }
        public string Transactiontype { get; set; }
        public string Reason { get; set; }
    }

    #endregion



    //protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    dglst.PageIndex = e.NewPageIndex;
    //    Bind();
    //}

    //public void Bind()
    //{
    //    try
    //    {
    //        string strmin = "", strmax = "";
    //        try
    //        {
    //            if (txtFromDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtFromDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                strmin = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //            if (txtToDate.Text.Trim().Length > 0)
    //            {
    //                String[] Date = txtToDate.Text.Split(new String[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
    //                strmax = Date[1] + "/" + Date[0] + "/" + Date[2];
    //            }
    //        }
    //        catch
    //        {
    //            utility.MessageBox(this, "Invalid date entry.");
    //            return;
    //        }
    //        da = new SqlDataAdapter("Pwallet", con);
    //        con.Open();
    //        da.SelectCommand.CommandType = CommandType.StoredProcedure;
    //        da.SelectCommand.Parameters.AddWithValue("@regno", Session["userId"].ToString());
    //        da.SelectCommand.Parameters.AddWithValue("@min", strmin);
    //        da.SelectCommand.Parameters.AddWithValue("@max", strmax);
    //        da.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {
    //            dglst.DataSource = dt;
    //            dglst.DataBind();
    //        }
    //        else
    //        {
    //            dglst.DataSource = null;
    //            dglst.DataBind();
    //        }
    //        con.Close();
    //    }
    //    catch (Exception ex)
    //    {
    //    }

    //}


    public void BindData()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("PWalletInfo", con);
        com.CommandType = CommandType.StoredProcedure;
        com.Parameters.AddWithValue("@regno", Session["userId"].ToString());
        try
        {
            con.Open();
            SqlDataReader dr = com.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                lblewallet.Text = dr["balance"].ToString();
            }
            else
            {
                lblewallet.Text = "0";
            }
            con.Close();
            con.Dispose();
        }
        catch
        {
            con.Close();
            con.Dispose();
            Response.Redirect("~/Error.aspx", false);
        }
    }
    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    Bind();
    //}


}