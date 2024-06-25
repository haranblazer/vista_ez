using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Collections.Generic;

using System.Reflection;

public partial class secretadmin_CostReport : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFromDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            BindState();
        }

    }
    public void BindState()
    {
        DataUtility objDUT = new DataUtility();
        DataTable dt = objDUT.GetDataTable("GetState");
        if (dt.Rows.Count > 0)
        {
            ddl_State.Items.Clear();
            ddl_State.DataSource = dt;
            ddl_State.DataTextField = "StateName";
            ddl_State.DataValueField = "Id";
            ddl_State.DataBind();
            ddl_State.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select State", ""));
           // ddl_District.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select District", ""));
        }

    }
    [System.Web.Services.WebMethod]

    public static Detail[] bindtable(string From, string To, string CustName, string Mobile, string State)
    {
        List<Detail> details = new List<Detail>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
            

            new SqlParameter("@FromDate", From),
            new SqlParameter("@ToDate", To),
            new SqlParameter("@CustName", CustName),
            new SqlParameter("@MobileNo", Mobile),
            new SqlParameter("@State", State),



           // new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString())
                };

            SqlDataReader dr = objDu.GetDataReaderSP(param, "CustomerList");
            utility objUtil = new utility();
            while (dr.Read())
            {
                Detail data = new Detail();
                data.User_Id = dr["UserId"].ToString();
                data.Name = dr["CustomerName"].ToString();
                data.Email = dr["email"].ToString();
                data.MobileNo = dr["MobileNo"].ToString();
                data.State = dr["State"].ToString();
                data.City = dr["City"].ToString();
                data.Address = dr["address1"].ToString();
                data.DOE = dr["doe"].ToString();
                data.District = dr["distt"].ToString();
                

                details.Add(data);
            };



        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class Detail

    {

        
        public string User_Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string MobileNo { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string Address { get; set; }
        public string DOE { get; set; }
        public string District { get; set; }
        

    }

}