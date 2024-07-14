using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Collections.Generic;

public partial class User_WalletProduct : System.Web.UI.Page
{
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
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetProductWalletUserPassbook");
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

    public void BindData()
    {
        try
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand com = new SqlCommand("GetWalletProductBalance", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@AppMstRegNo", Session["userId"].ToString().Trim());
            com.Parameters.Add("@Bal", SqlDbType.Int, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            lblewallet.Text = com.Parameters["@Bal"].Value.ToString();
        }
        catch
        {
            Response.Redirect("~/Error.aspx", false);
        }
    }
    #endregion


}