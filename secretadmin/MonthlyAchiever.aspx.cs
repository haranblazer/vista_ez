using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Reflection;

public partial class secretadmin_MonthlyAchiever : System.Web.UI.Page
{

    SqlConnection con = null;
    SqlCommand com = null;
    SqlDataAdapter da = null;
    DataTable dt = null;
    utility objUtil = new utility();
    string tlper = null;
    SqlDataReader dr;

    public static string user_rank, Month_name, Month_value, year_name;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToString(Session["admintype"]) == "sa")
                utility.CheckSuperAdminLogin();
            else if (Convert.ToString(Session["admintype"]) == "a")
                utility.CheckAdminLogin();
            else
                Response.Redirect("logout.aspx");

            if (!IsPostBack)
            {
                tlper = Request.QueryString["rk"];

                if (tlper == null)
                {

                    binddate();
                    ddluserrank.Items.Insert(0, new ListItem("Select", "0"));

                    bindrank(Month_name, year_name);
                    GetFundWise(Month_name, year_name, Convert.ToDouble(user_rank));

                }
                 

                if (tlper != null)
                {

                    ddluserrank.Items.Clear();
                    ddluserrank.Items.Insert(0, new ListItem("Select", "0"));

                    txtuserid.Text = "";

                    bindrank(Month_name, year_name);
                    GetFundWise(Month_name, year_name, Convert.ToDouble(tlper));


                    binddate();
                    ddlmonth.SelectedValue = Month_value;
                }
            }
        }
        catch
        {

        }
         
    }

    private void GetFundWise(string month, string yearname, double tlper)
    {


        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("bindrankmonthwise", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@month", month);
            com.Parameters.AddWithValue("@year", Convert.ToInt32(yearname));
            com.Parameters.AddWithValue("@tlper", tlper);
            da = new SqlDataAdapter(com);
            dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                grd.DataSource = dt;
                grd.DataBind();
            }

            else
            {
                grd.DataSource = null;
                grd.DataBind();


            }
        }

        catch
        {

        }
        finally
        {

        }
    }

    protected void grd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grd.PageIndex = e.NewPageIndex;

    }
    public void bindrank(string monthname, string yearname)
    {
        try
        {
            con = new SqlConnection(method.str);
            da = new SqlDataAdapter("bindrank", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@month", monthname);
            da.SelectCommand.Parameters.AddWithValue("@year", Convert.ToInt32(yearname));
            dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {

                //ViewState["rank"] = dt.Rows[0]["tlper"].ToString();
                user_rank = dt.Rows[0]["tlper"].ToString();
                Repeater1.DataSource = dt;
                Repeater1.DataBind();
            }

            else
            {
                Repeater1.DataSource = null;
                Repeater1.DataBind();

            }
        }

        catch
        {

        }
        finally
        {

        }
    }
    protected void ddlmonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        PropertyInfo isreadonly = typeof(System.Collections.Specialized.NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
        // make collection editable
        isreadonly.SetValue(this.Request.QueryString, false, null);
        // remove
        this.Request.QueryString.Remove("rk");
        Month_value = ddlmonth.SelectedValue.ToString();
        string[] value = ddlmonth.SelectedItem.Text.Split('-');
       

        Month_name = value[0];
        year_name = value[1];
        bindrank(Month_name, year_name);
        GetFundWise(Month_name, year_name, Convert.ToDouble(user_rank));
    }

    public void binddate()
    {
        try
        {
            con = new SqlConnection(method.str);
            com = new SqlCommand("bindrankmonth", con);
            com.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(com);
            dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                ddlmonth.DataTextField = "months";
                ddlmonth.DataValueField = "rownumber";
                ddlmonth.DataSource = dt;
                ddlmonth.DataBind();

                //ddlmonthupdate.DataTextField = "months";
                //ddlmonthupdate.DataValueField = "rownumber";
                //ddlmonthupdate.DataSource = dt;
                //ddlmonthupdate.DataBind();
            }

            else
            {
                ddlmonth.DataSource = null;
                ddlmonth.DataBind();
                //ddlmonthupdate.DataSource = null;
                //ddlmonthupdate.DataBind();


            }
        }

        catch
        {

        }
        finally
        {
            if (ddlmonth.Items.Count != 0)
            {
                string[] value = ddlmonth.SelectedItem.Text.Split('-');

                Month_name = value[0];
                year_name = value[1];
            }
        }

    }

    protected void grd_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "PAID")
        {
            string ID = e.CommandArgument.ToString();

            lblcurrentrank.Text = "";
            ViewState["ID"] = ID;
            upgraderank(ID);
            panlID1.Visible = true;
           

           // txtuserid.Text = UserID;
           // Addrank(UserID);






        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        try
        {

            con = new SqlConnection(method.str);
            com = new SqlCommand("addrank", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@regno", txtuserid.Text);
             com.Parameters.AddWithValue("@rank", Convert.ToDouble(ddluserrank.SelectedValue.ToString()));
            com.Parameters.AddWithValue("@payoutno", Convert.ToInt32(ddlmonth.SelectedValue.ToString()));
            com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;

            con.Open();
            com.ExecuteNonQuery();

            string msg = com.Parameters["@flag"].Value.ToString();

            if (msg == "1")
            {
                utility.MessageBox(this, "Rank Already Exists For this Month");
            }


            if (msg == "2")
            {
                utility.MessageBox(this, "Rank  inserted Successfully");
            }

            if (msg == "3")
            {
                utility.MessageBox(this, "This User ID  achieved Country manager Already");
            }

        }

        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }

        finally
        {
            txtuserid.Text = string.Empty;


            con.Close();
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

        panlID1.Visible = false;
        ddlupgraderank.Items.Clear();
        ddlupgraderank.Items.Insert(0, new ListItem("select", "0"));

        Addrank(txtuserid.Text);

        
    }

    public void Addrank(string userid)
    {
        try
        {
            ddluserrank.Items.Clear();
            con = new SqlConnection(method.str);
            com = new SqlCommand("Showrank", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@userid",userid);
           
            da = new SqlDataAdapter(com);
            dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                lblcurrentrank.Text = dt.Rows[0]["usercurrentrank"].ToString();
                ddluserrank.DataTextField = "rank";
                ddluserrank.DataValueField = "tlper";


                ddluserrank.DataSource = dt;
                ddluserrank.DataBind();

                ddluserrank.Items.Insert(0, new ListItem("select", "0"));

            }

            else
            {
                lblcurrentrank.Text = "";
                ddluserrank.Items.Insert(0, new ListItem("select", "0"));
            }

        }

        catch (Exception ex)
        {

            utility.MessageBox(this, ex.ToString());
        }

        finally
        {

            con.Close();
        }
    }

    public void upgraderank(string id)
    {
        try
        {
            txtuserid.Text = "";
            ddluserrank.Items.Clear();
            ddluserrank.Items.Insert(0, new ListItem("select", "0"));
            con = new SqlConnection(method.str);
            com = new SqlCommand("upgraderank", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@id", Convert.ToInt32(id));

            da = new SqlDataAdapter(com);
            dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {


                lblusercurrentrank.Text = dt.Rows[0]["usercurrentrank"].ToString();

                lbl_Userid.Text = dt.Rows[0]["userid"].ToString();

                ddlupgraderank.DataTextField = "rank";
                ddlupgraderank.DataValueField = "tlper";


                ddlupgraderank.DataSource = dt;
                ddlupgraderank.DataBind();

                ddlupgraderank.Items.Insert(0, new ListItem("select", "0"));

            }

            else
            {
                lbl_Userid.Text = "";
                lblusercurrentrank.Text = "";
                ddlupgraderank.Items.Insert(0, new ListItem("select", "0"));
            }

        }

        catch (Exception ex)
        {

            utility.MessageBox(this, ex.ToString());
        }

        finally
        {

            con.Close();
        }
    }

    protected void RaiseDisputetxt_Click(object sender, EventArgs e)
    {
        try
        {

            con = new SqlConnection(method.str);
            com = new SqlCommand("updateuserrank", con);
            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@id", Convert.ToInt32(ViewState["ID"].ToString()));
            com.Parameters.AddWithValue("@rank", Convert.ToInt32(ddlupgraderank.SelectedValue.ToString()));
            com.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;

            con.Open();
            com.ExecuteNonQuery();

            string msg = com.Parameters["@flag"].Value.ToString();

            if (msg == "1")
            {
                utility.MessageBox(this, "Rank Updated Success");
            }


            

        }

        catch (Exception ex)
        {
            utility.MessageBox(this, ex.ToString());
        }

        finally
        {
            panlID1.Visible = false;
            ddlupgraderank.Items.Insert(0, new ListItem("select", "0"));

         

            con.Close();


        }

    }
}