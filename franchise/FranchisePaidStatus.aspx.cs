﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Data.SqlClient;
using System.Data;

public partial class franchise_FranchisePaidStatus : System.Web.UI.Page
{
    utility obj = new utility();
    SqlConnection con = new SqlConnection(method.str);
    SqlCommand cmd;
    string a;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserName"] == null)
        {
            Response.Redirect("Default.aspx");
        }
        if (!IsPostBack)
        {

            BindGrid();
        }

    }


    public void BindGrid()
    {

        SqlDataAdapter ad = new SqlDataAdapter("select fp.aremarks,fp.fremarks,fm.FranchiseId,fp.id,fp.status,fp.username,fp.depositedamount,case when fp.status= 0 then 'pending' when fp.status= 1 then 'approved' end as fstatus,convert(varchar(50),fp.doe,103) as doe from franchisemst fm, franchisepayment fp where fm.username=fp.username and fm.username='"+Session["UserName"]+"'", con);

        DataTable dt = new DataTable();
        ad.Fill(dt);
        GridView1.DataSource = dt;
        GridView1.DataBind();

    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
       // BindGrid();
    }


    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        //GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
        //if (e.CommandName.Equals("remarks"))
        //{

        //    a = GridView1.DataKeys[row.RowIndex].Values[2].ToString();
        //    TextBox txtremarks = (TextBox)row.Cells[0].FindControl("txtRemarks");
        //    con = new SqlConnection(method.str);
        //    SqlCommand cmd = new SqlCommand("update  franchisepayment set fremarks='"+txtremarks.Text+"'  where id='" + a + "'", con);
        //    con.Open();
        //    cmd.ExecuteNonQuery();
        //    con.Close();
        //    BindGrid();

        //}
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkbtnEdit1");
            Label ll = (Label)e.Row.FindControl("Label1");
            if (int.Parse(ll.Text) == 1)
            {
               // lnkbtn.Enabled = true;
                lnkbtn.Enabled = false;
                lnkbtn.Text = "Approve";
                lnkbtn.ForeColor = Color.Green;
            }

            if (int.Parse(ll.Text) == 0)
            {
                lnkbtn.Enabled = false;
                lnkbtn.Text = "Not Approve";
                lnkbtn.ForeColor = Color.Red;
            }

        }
    }


    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {

    }
}