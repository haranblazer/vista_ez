using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

public partial class franchise_PO_Received : System.Web.UI.Page
{
    DataTable dt = null;
    SqlConnection con = null;
    SqlCommand com = null;
    string regno = string.Empty;
    XmlDocument xmldoc = new XmlDocument();
    DataUtility objDUT = null;
    string franchiseid = "";
    string invoiceno = "";
    int status = 0;
    string returnvalue;
    string strajax = "";
    string xmlfile = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
            Response.Redirect("Logout.aspx");
        else
        {
            if (!IsPostBack)
            {
                DateTime now = DateTime.Now;
                var startDate = new DateTime(now.Year, now.Month, 1);

                txtFromDate.Text = startDate.ToString("dd/MM/yyyy").Replace("-", "/");
                txtToDate.Text = DateTime.UtcNow.AddMinutes(330).ToString("dd/MM/yyyy").Replace("-", "/");
                //BindGrid();
            }
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string min, string max, string Status, string PO, string POType)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@POType", POType),
                new SqlParameter("@Status", Status),
                new SqlParameter("@PO", PO),
                new SqlParameter("@min", min),
                new SqlParameter("@max", max),
                new SqlParameter("@Userid", HttpContext.Current.Session["franchiseid"].ToString()),
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "PO_Received");
            //utility objutil = new utility();
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.srno = dr["srno"].ToString();

                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.Status = dr["Status"].ToString();
                data.IsOffer = dr["IsOffer"].ToString();
                data.regno = dr["regno"].ToString();
                data.fname = dr["fname"].ToString();
                data.doe = dr["doe"].ToString();
                data.NoOFProduct = dr["NoOFProduct"].ToString();
                data.amt = dr["amt"].ToString();
                data.grossAmt = dr["grossAmt"].ToString();
                data.tax = dr["tax"].ToString();
                data.netAmt = dr["netAmt"].ToString();
                data.SellerState = dr["SellerState"].ToString();
                data.PlaceOfSupply = dr["PlaceOfSupply"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string srno { get; set; }

        public string InvoiceNo { get; set; }
        public string IsOffer { get; set; }
        public string Status { get; set; }
        public string regno { get; set; }
        public string fname { get; set; }
        public string doe { get; set; }
        public string NoOFProduct { get; set; }
        public string amt { get; set; }
        public string grossAmt { get; set; }
        public string tax { get; set; }
        public string netAmt { get; set; }
        public string SellerState { get; set; }
        public string PlaceOfSupply { get; set; }
    }


    [System.Web.Services.WebMethod]
    public static string UpdateTransferTo(string Invoice, string TransferTo)
    {
        string result = "";
        DataUtility objDu = new DataUtility();
        try
        {
            if (String.IsNullOrEmpty(TransferTo))
            {
                return "Please Enter Transfer UserId.!!";
            }
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("TransferPO", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@invoiceno", Invoice);
            cmd.Parameters.AddWithValue("@TransferFrom", HttpContext.Current.Session["franchiseid"].ToString());
            cmd.Parameters.AddWithValue("@TransferTo", TransferTo);
            cmd.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            string status2 = cmd.Parameters["@flag"].Value.ToString();
            if (status2 == "1")
            {
                result = "1";
            }
            else
            {
                result = status2;
            }
        }
        catch (Exception er) { result = er.Message; }
        return result;
    }



    #endregion



}