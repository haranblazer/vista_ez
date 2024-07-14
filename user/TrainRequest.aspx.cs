using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class User_TrainRequest : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    utility objUtil = null;
    string regno;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["userId"] != null)
            {
                regno = Session["userId"].ToString();
                if (!IsPostBack)
                {
                    ddlType.Items.Insert(1, new ListItem(method.Associate, "1"));

                    BindState();
                }
            }
            else
            {
                Response.Redirect("~/Login.aspx", false);
            } 
           // DataBind(); 
        }
        catch
        {
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable()
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        { 
            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@regno", HttpContext.Current.Session["userId"].ToString()) 
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetTrnReq");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.appmstregno = dr["appmstregno"].ToString();
                data.appmstfname = dr["appmstfname"].ToString();
                data.State = dr["State"].ToString();
                data.City = dr["City"].ToString();
                data.typeofrequest = dr["typeofrequest"].ToString();
                data.trainingtype = dr["trainingtype"].ToString();
                data.requestdate = dr["requestdate"].ToString(); 
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string appmstregno { get; set; }
        public string appmstfname { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string typeofrequest { get; set; }
        public string trainingtype { get; set; }
        public string requestdate { get; set; }
        
    }

    #endregion



    public void BindState()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("GetState", con);
            com.CommandType = CommandType.StoredProcedure;

            da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DdlState.DataSource = dt;
            DdlState.DataTextField = "StateName";
            DdlState.DataValueField = "SId";
            DdlState.DataBind();
            DdlState.Items.Insert(0, new ListItem("Select", "0"));
            //ddlDistrict.Items.Insert(0, new ListItem("Select", "0"));
        }
        catch
        {

        }
    }
   
    //protected void gridTrnReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    //gridTrnReq.PageIndex = e.NewPageIndex;
    //    //OnlineTranHistory();
    //}

    //protected void gridTrnReq_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //}

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string msg = "";

            if (txtCity.Text == "")
            {
                utility.MessageBox(this, "Please Enter City!");
                return;
            }
            if (ddlType.SelectedValue == "0")
            {
                utility.MessageBox(this, "Please Select Type!");
                return;
            }
            con = new SqlConnection(method.str);
            com = new SqlCommand("InsertTrnReq", con);
            com.CommandType = CommandType.StoredProcedure;
            com.CommandTimeout = 99999999;
            com.Parameters.AddWithValue("@regno", regno);
            com.Parameters.AddWithValue("@type", ddlType.SelectedValue.ToString().Trim());
            com.Parameters.AddWithValue("@state", DdlState.SelectedItem.ToString().Trim());
            com.Parameters.AddWithValue("@city", txtCity.Text.Trim());
            com.Parameters.AddWithValue("@trainingtype", ddlttype.SelectedValue.ToString().Trim());

            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            msg = com.Parameters["@flag"].Value.ToString();
            utility.MessageBox(this, msg);
            //DataBind();
             
        }
        catch
        {
            con.Close();
            Response.Redirect("error.aspx");
        }
        finally
        {
           
        }
    }

    //private void DataBind()
    //{
    //    con = new SqlConnection(method.str);
    //    com = new SqlCommand("GetTrnReq", con);
    //    com.CommandType = CommandType.StoredProcedure;
    //    com.CommandTimeout = 99999999;
    //    com.Parameters.AddWithValue("@regno", regno);
    //    da = new SqlDataAdapter(com);
    //    DataTable dt = new DataTable();
    //    da.Fill(dt);
    //    gridTrnReq.DataSource = dt;
    //    gridTrnReq.DataBind();
    //}

    //private void refresh()
    //{
    //    txtCity.Text = "";
    //    ddlType.SelectedValue = "0";
    //   // DdlState.SelectedValue = "0";
    //}
}