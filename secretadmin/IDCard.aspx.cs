using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class admin_IDCard : System.Web.UI.Page
{
    SqlConnection con = null;
    DataTable dt = null;
    SqlCommand com = null;
    SqlDataAdapter da = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["DT"] != null)
            {
                Datalist1.DataSource = (DataTable)Session["DT"];
                lblprint.DataBind();
            }
            else
            {
                Response.Redirect("PrintIDCard.aspx", true);
            }
        }
    }
    public void BindData()
    {
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("select agentName,(agentAddress+''+City+''+agentstate+''+pincode)as agentAddress,PhoneNo,convert(varchar(25),DOJ,103)as DOJ,AgentCode,Sponsorid,(select Address +'<br/>'+State +': '+Pincode +'<br/> Phone :'+Mobileno  from Branchmst where Branchid=agentmst.Branchid)as CAddress from agentmst", con);
        DataTable dtt = new DataTable();
        da.Fill(dtt);
        if (dtt.Rows.Count > 0)
        {
            Datalist1.DataSource = dtt;
            lblprint.DataBind();
        }
        else
        {
            Session["DT"] = null;
        }
    }
    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //    DataTable dt = new DataTable();
    //    dt.Columns.Add("AgentCode", typeof(string));
    //    dt.Columns.Add("agentName", typeof(string));
    //    dt.Columns.Add("agentAddress", typeof(string));
    //    dt.Columns.Add("DOJ", typeof(string));
    //    dt.Columns.Add("Sponsorid", typeof(string));
    //    dt.Columns.Add("CAddress", typeof(string));
    //    dt.Columns.Add("PhoneNo", typeof(string));
    //    DataRow dr;
    //    foreach (GridViewRow row in GrdAgent.Rows)
    //    {
    //        if (row.RowType == DataControlRowType.DataRow)
    //        {
    //            CheckBox chkRow = (row.Cells[0].FindControl("ChkMem") as CheckBox);
    //            Label lblAgent = (row.Cells[0].FindControl("lblAgent") as Label);
    //            Label agentName = (row.Cells[0].FindControl("agentName") as Label);
    //            Label agentAddress = (row.Cells[0].FindControl("agentAddress") as Label);
    //            Label DOJ = (row.Cells[0].FindControl("DOJ") as Label);
    //            Label Sponsorid = (row.Cells[0].FindControl("Sponsorid") as Label);
    //            Label CAddress = (row.Cells[0].FindControl("CAddress") as Label);
    //            Label PhoneNo = (row.Cells[0].FindControl("PhoneNo") as Label);
    //            if (chkRow.Checked)
    //            {
    //                //DataTable dt = (DataTable)ViewState["DT"];
    //                //var tbl = from p in dt.AsEnumerable()
    //                //          where p.Field<string>("AgentCode") == lblAgent.Text.Trim()
    //                //          select new { AgentCode = p.Field<string>("AgentCode"), agentName = p.Field<string>("agentName"), agentAddress = p.Field<string>("agentAddress"), DOJ = p.Field<string>("DOJ"), Sponsorid = p.Field<string>("Sponsorid"), CAddress = p.Field<string>("CAddress"), PhoneNo = p.Field<string>("PhoneNo") };// 


    //                dr = dt.NewRow();

    //                dr["AgentCode"] = lblAgent.Text;
    //                dr["agentName"] = agentName.Text;
    //                dr["agentAddress"] = agentAddress.Text;
    //                dr["DOJ"] = DOJ.Text;
    //                dr["Sponsorid"] = Sponsorid.Text;
    //                dr["CAddress"] = CAddress.Text;
    //                dr["PhoneNo"] = PhoneNo.Text;
    //                dt.Rows.Add(dr);
    //            }
    //        }
    //    }
    //    if (dt.Rows.Count>0)
    //    {
    //        Datalist1.DataSource = dt.DefaultView;
    //        Datalist1.DataBind(); 
    //        lblprint.Attributes.Add("style", "display:inline");
    //        tblView.Attributes.Add("style", "display:none");
    //        btnSubmit.Attributes.Add("style", "display:none");
    //    }
    //}
}