using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Xml.Linq;
using System.Xml;
using System.Globalization;
using System.Threading;

public partial class admin_MakeNewPayment : System.Web.UI.Page
{

    SqlConnection con = null;
    SqlDataAdapter DaProduct;
    SqlCommand cmd = null;
    utility objUtil = null;
    string strajax = string.Empty;
    DataTable dt = null;
    SqlDataReader dr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlbindfrantype.Items.Insert(0, new ListItem("No Data", "0"));
            BindUserID();
        }
    }

    //public void bindfranchise()
    //{

    //    con = new SqlConnection(method.str);
    //    SqlDataAdapter sda = new SqlDataAdapter("purchaseorderuser", con);
    //    sda.SelectCommand.CommandType = CommandType.StoredProcedure;
    //    sda.SelectCommand.Parameters.AddWithValue("@regno", Session["franchiseid"].ToString());
    //    dt = new DataTable();
    //    sda.Fill(dt);
    //    ddlbindfrantype.DataTextField = "name";
    //    ddlbindfrantype.DataValueField = "id";
    //    ddlbindfrantype.DataSource = dt;
    //    ddlbindfrantype.DataBind();
    //    ddlbindfrantype.Items.Insert(0, new ListItem("Select", "0"));

    //}
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            if (validate())
            {

                if (ViewState["type"]!="0")
                {

                    DateTime date=DateTime.ParseExact(txtFromDate.Text.ToString(),"dd/MM/yyyy",CultureInfo.InvariantCulture);
                    con = new SqlConnection(method.str);
                    cmd = new SqlCommand("payorder", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@invoiceno", txtpono.Text);
                    cmd.Parameters.AddWithValue("@orderby", Session["franchiseid"].ToString());
                    cmd.Parameters.AddWithValue("@orderto", ddlbindfrantype.SelectedValue.ToString());
                    cmd.Parameters.AddWithValue("@mode", ddlmode.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@bank", ddlbank.SelectedValue.ToString());
                    cmd.Parameters.AddWithValue("@branch", txtbranch.Text);
                    cmd.Parameters.AddWithValue("@tranno", txtnumber.Text);
                    cmd.Parameters.AddWithValue("@amt", txtamount.Text);
                    cmd.Parameters.AddWithValue("@remarks", txtremarks.Text);
                    cmd.Parameters.AddWithValue("@doe", date);


                    con.Open();
                    cmd.ExecuteNonQuery();
                    utility.MessageBox(this, "data saved successfuly");
                    con.Close();
                    clear();
                }

            }


        }

        catch (Exception ex)
        {

        }
    }


    protected void ddlmode_SelectedIndexChanged(object sender, EventArgs e)
    {


        if (ddlmode.SelectedValue.ToString() == "1")
        {
            txtnumber.Text = "";
            txtbranch.Text = "";
            txtremarks.Text = "";
            txtnumber.Enabled = false;
            txtbranch.Enabled = false;

            ddlbank.Items.Insert(0, new ListItem("Select", "0"));
            ddlbank.Enabled = false;
           
           
        }



        if ((ddlmode.SelectedValue.ToString() == "2") || (ddlmode.SelectedValue.ToString() == "3") || (ddlmode.SelectedValue.ToString() == "4") || (ddlmode.SelectedValue.ToString() == "5"))
        {

            txtnumber.Text = "";
            txtbranch.Text = "";
            txtremarks.Text = "";
            txtnumber.Enabled = true;
            txtbranch.Enabled = true;
            txtremarks.Enabled = true;
            ddlbank.Enabled = true;
            dt = null;
            con = new SqlConnection(method.str);
            SqlDataAdapter sda = new SqlDataAdapter("showbank", con);
            sda.SelectCommand.CommandType = CommandType.StoredProcedure;
            sda.SelectCommand.Parameters.AddWithValue("@regno", ddlbindfrantype.SelectedValue.ToString());
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddlbank.DataTextField = "companybank";
                ddlbank.DataValueField = "srno";
                ddlbank.DataSource = dt;
                ddlbank.DataBind();
                ddlbank.Items.Insert(0, new ListItem("Select", "0"));
                txtnumber.Text = "";
                txtbranch.Text = "";
                txtremarks.Text = "";
            }

            else
            {
                utility.MessageBox(this, "Please Add atlest one bank");
                ddlbank.Items.Insert(0, new ListItem("Select", "0"));
                txtnumber.Text = "";
                txtbranch.Text = "";
                txtremarks.Text = "";



            }
           

        }

        //else
        //{
        //    ddlbank.Items.Clear();
        //    ddlbank.Items.Insert(0, new ListItem("Select", "0"));
        //}



    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        bindfranchise();

    }


    public void bindfranchise()
    {

        ddlbindfrantype.Items.Clear();
        con = new SqlConnection(method.str);
        SqlDataAdapter sda = new SqlDataAdapter("searchorder", con);
        sda.SelectCommand.CommandType = CommandType.StoredProcedure;
        sda.SelectCommand.Parameters.AddWithValue("@regno", Session["franchiseid"].ToString());
        sda.SelectCommand.Parameters.AddWithValue("@orderno", txtpono.Text);
        dt = new DataTable();
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {


            ddlbindfrantype.DataTextField = "name";
            ddlbindfrantype.DataValueField = "id";
            ddlbindfrantype.DataSource = dt;
            ddlbindfrantype.DataBind();
            txtamount.Text = dt.Rows[0][2].ToString();
            ddlmode.SelectedValue = "0";
            txtnumber.Text = "";
            txtbranch.Text = "";
            txtremarks.Text = "";

        }



        else
        {
            ddlbindfrantype.Items.Insert(0, new ListItem("No Data", "0"));
            txtamount.Text = "";
            ddlmode.SelectedValue = "0";
            txtnumber.Text = "";
            txtbranch.Text = "";
            txtremarks.Text = "";

        }


    }


    public void clear()
    {
        ddlbindfrantype.Items.Clear();
        txtpono.Text = "";
        txtremarks.Text = "";
        txtamount.Text = "";
        txtbranch.Text = "";
        txtpono.Text = "";
        ddlbank.Items.Clear();
        ddlmode.SelectedValue = "0";
        txtnumber.Text = "";
        txtFromDate.Text = "";


    }


    private void BindUserID()
    {
        con = new SqlConnection(method.str);
        SqlDataAdapter da = new SqlDataAdapter();
        //ViewState["Count"] = null;
        try
        {
            DataTable dtt = new DataTable();
            da = new SqlDataAdapter("bindorder ", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@regno", Session["franchiseid"].ToString());
            da.Fill(dtt);

            List<string> objProductList = new List<string>(); ;
            String strPrdPrice = string.Empty;
            divUserID.InnerText = string.Empty;
            foreach (DataRow drw in dtt.Rows)
            {
                divUserID.InnerText += drw["orderno"].ToString() + ",";
            }
        }
        catch
        {
        }
        finally
        {
        }
    }



    public bool validate()
    {


        if (ddlmode.SelectedValue.ToString() == "0")
        {
            utility.MessageBox(this, "Please Select Mode");
            ViewState["type"] = "0";
            return false;
        }

        if (((ddlmode.SelectedValue.ToString() == "0") || (ddlmode.SelectedValue.ToString() == "2") || (ddlmode.SelectedValue.ToString() == "3") || (ddlmode.SelectedValue.ToString() == "4") || (ddlmode.SelectedValue.ToString() == "5")) && (ddlbank.SelectedValue.ToString() == "0"))
        {
            utility.MessageBox(this, "please Select bank or Fill bank Details Before Submit PO Amount");
            ViewState["type"] = "0";
            return false;
        }


        //if (((ddlmode.SelectedValue.ToString() == "0") || (ddlmode.SelectedValue.ToString() == "2") || (ddlmode.SelectedValue.ToString() == "3") || (ddlmode.SelectedValue.ToString() == "4") || (ddlmode.SelectedValue.ToString() == "5")) && (ddlbank.SelectedValue.ToString() == "0") && (txtnumber.Text == "") && (txtbranch.Text == ""))
        //{
        //    utility.MessageBox(this, "Please Enter Bank Details ");
        //    ViewState["type"] = "0";
        //    return false;
        //}


        //if (((ddlmode.SelectedValue.ToString() == "0") || (ddlmode.SelectedValue.ToString() == "2") || (ddlmode.SelectedValue.ToString() == "3") || (ddlmode.SelectedValue.ToString() == "4") || (ddlmode.SelectedValue.ToString() == "5")) && (txtnumber.Text == "") && (txtbranch.Text == ""))
        //{
        //    utility.MessageBox(this, "Please Enter Bank Details ");
        //    ViewState["type"] = "0";
        //    return false;
        //}



        if (((ddlmode.SelectedValue.ToString() == "0") || (ddlmode.SelectedValue.ToString() == "2") || (ddlmode.SelectedValue.ToString() == "3") || (ddlmode.SelectedValue.ToString() == "4") || (ddlmode.SelectedValue.ToString() == "5")) && (ddlbank.SelectedValue.ToString() == "0") && ((txtnumber.Text == "") || (txtbranch.Text == "")))
        {
            utility.MessageBox(this, "Please Enter Bank Details ");
            ViewState["type"] = "0";
            return false;
        }

        if (((ddlmode.SelectedValue.ToString() == "0") || (ddlmode.SelectedValue.ToString() == "2") || (ddlmode.SelectedValue.ToString() == "3") || (ddlmode.SelectedValue.ToString() == "4") || (ddlmode.SelectedValue.ToString() == "5")) &&  ((txtnumber.Text == "") || (txtbranch.Text == "")))
        {
            utility.MessageBox(this, "Please Enter Bank Details ");
            ViewState["type"] = "0";
            return false;
        }

        return true; 


    }
}