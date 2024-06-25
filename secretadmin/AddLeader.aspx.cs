using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;

public partial class secretadmin_AddLeader : System.Web.UI.Page, ICallbackEventHandler
{
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    utility objUtil = null;
    string regno;
    string strajax = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
            {
                utility.CheckSuperAdminLogin();
            }
            else if (Convert.ToString(Session["admintype"]) == "a")
            {
                utility.CheckAdminLogin();
            }
            else
            {
                Response.Redirect("adminLog.aspx");
            }
            // refresh();
            DataBind();
            if (!IsPostBack)
            {
                //BindLeader();
                BindState();
                lblUser.Text = GetSponsorName(ddlLeader.Text.Trim());
            }
            string js = Page.ClientScript.GetCallbackEventReference(this, "arg", "ServerResult", "ctx", "ClientErrorCallback", true);
            StringBuilder newFunction = new StringBuilder("function ServerSendValue(arg,ctx){" + js + "}");
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Asyncrokey", Convert.ToString(newFunction), true);
            
        }
        catch
        {
        }
    }

  
    //public void BindLeader()
    //{
    //    try
    //    {
    //        con = new SqlConnection(method.str);
    //        com = new SqlCommand("select appmstid,appmstregno from appmst where appmstregno like '"+ddlLeader.Text+"%'", con);
    //        com.CommandType = CommandType.Text;

    //        da = new SqlDataAdapter(com);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        ddlLeader.DataSource = dt;
    //        ddlLeader.DataTextField = "appmstregno";
    //        ddlLeader.DataValueField = "appmstid";
    //        ddlLeader.DataBind();
    //        ddlLeader.Items.Insert(0, new ListItem("Select", "0"));
    //        //ddlDistrict.Items.Insert(0, new ListItem("Select", "0"));
    //    }
    //    catch
    //    {

    //    }
    //}

    private string GetSponsorName(string regno)
    {
        string name = string.Empty;
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("select appmstfname, Case When Cast([AppMstPaid]As Int)=0 then 'Inactive' When cast([AppMstPaid] AS Int)=1 Then 'Active' Else cast (0 as varchar(1)) End 'AppMstPaid' from AppMst where AppMstRegNo=@AppMstRegno", con);
            //com = new SqlCommand("select appmstfname from AppMst where AppMstRegNo=@regno", con);
            com.Parameters.AddWithValue("@regno", regno.Trim());
            con.Open();
            name = com.ExecuteScalar().ToString();
            con.Close();
        }
        catch
        {
        }
        return name;

    }


    #region (ICallbackEventHandlar Methods..)
    public string GetCallbackResult()
    {
        return strajax;
    }

    public void RaiseCallbackEvent(string eventArguments)
    {
        if (eventArguments != "")
        {
            con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand();
            SqlDataReader dr;
            cmd.CommandText = "select isnull(appmsttitle,'')+space(1)+appmstfname +SPACE(2) + '('+ Case When Cast([AppMstPaid]As Int)=0 then 'INACTIVE' When cast([AppMstPaid] AS Int)=1 Then 'ACTIVE' Else cast (0 as varchar(1)) End+')' 'Name' from appmst where appmstregno=@regno";
            cmd.Parameters.AddWithValue("@regno", eventArguments.Trim());
            cmd.Connection = con;
            con.Open();
            dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                strajax = Convert.ToString(dr["name"]);
                Session["sname"] = Convert.ToString(dr["name"]);
            }
            else
            {
                strajax = "User Does Not Exist!";
            }
            dr.Close();
            con.Close();
        }
        else
        {
            strajax = "Required field cannot be blank !";
        }
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

    protected void gridTrnReq_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gridTrnReq.PageIndex = e.NewPageIndex;
        //OnlineTranHistory();
    }

    protected void gridTrnReq_RowDataBound(object sender, GridViewRowEventArgs e)
    {
    }

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
            if (ddlLeader.Text == "")
            {
                utility.MessageBox(this, "Please Enter Userid!");
                return;
            }
            con = new SqlConnection(method.str);
            com = new SqlCommand("InsertTrnReq", con);
            com.CommandType = CommandType.StoredProcedure;
            com.CommandTimeout = 99999999;
            com.Parameters.AddWithValue("@regno", ddlLeader.Text.Trim());
            com.Parameters.AddWithValue("@type", "2");
            com.Parameters.AddWithValue("@state", DdlState.SelectedItem.ToString().Trim());
            com.Parameters.AddWithValue("@city", txtCity.Text.Trim());
            com.Parameters.AddWithValue("@trainingtype", ddlttype.SelectedValue.ToString().Trim());

            com.Parameters.Add("@flag", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
            con.Open();
            com.ExecuteNonQuery();
            con.Close();
            msg = com.Parameters["@flag"].Value.ToString();
            utility.MessageBox(this, msg);
            DataBind();
            refresh();
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

    private void DataBind()
    {
        con = new SqlConnection(method.str);
        com = new SqlCommand("GetTrnReq", con);
        com.CommandType = CommandType.StoredProcedure;
        com.CommandTimeout = 99999999;
        com.Parameters.AddWithValue("@regno", "leader");
        da = new SqlDataAdapter(com);
        DataTable dt = new DataTable();
        da.Fill(dt);
        gridTrnReq.DataSource = dt;
        gridTrnReq.DataBind();
    }

    private void refresh()
    {
        ddlLeader.Text = "";
        txtCity.Text = "";
        ddlttype.SelectedValue = "0";
        // DdlState.SelectedValue = "0";
    }
}