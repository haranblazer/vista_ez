using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Drawing;
using System.Xml;


public partial class secretadmin_FundList : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand com=null;
    SqlDataReader sdr=null;
    SqlDataAdapter sda=null;
    DataTable dt = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            div1.Visible = false;
            BindUserID();
        }
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }


    public void BindGrid()
    {

      
            sda = new SqlDataAdapter("fundlist", con);
            sda.SelectCommand.CommandType = CommandType.StoredProcedure;
            sda.SelectCommand.Parameters.AddWithValue("@pno", ddlpayoutno.SelectedValue.ToString());
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
               
                GridView1.DataSource = dt;
                GridView1.DataBind();
             
            }
            else
            {

                
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
       
    }


    private void BindUserID()
    {
        con = new SqlConnection(method.str);      
        try
        {

            sda = new SqlDataAdapter("select payoutno,'Payout No:-' +convert(varchar(50),payoutno) as payout from repayoutdate", con);
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddlpayoutno.DataSource = dt;
              
                ddlpayoutno.DataTextField = "payout";
                ddlpayoutno.DataValueField = "payoutno";
                ddlpayoutno.DataBind();
                ddlpayoutno.Items.Insert(0, new ListItem("select", "0"));
               

            }
            else
            {


          
            }
                   
        }
        catch
        {
        }
        finally
        {
        }
    }
    protected void ddlpayoutno_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
        grp();
    }


    public void grp()
    {



            sda = new SqlDataAdapter("select gbv FROM redatamst WHERE APPMSTID=1 AND PAYOUTNO=@pno", con);
            sda.SelectCommand.Parameters.AddWithValue("@pno", ddlpayoutno.SelectedValue.ToString());
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                lblgrp.Text = dt.Rows[0][0].ToString();
                div1.Visible = true;
             
            }
            else
            {

                lblgrp.Text = "0";
               
            }
       
   
    }

}