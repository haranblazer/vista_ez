using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using System.Drawing;

public partial class secretadmin_RankQualifylist : System.Web.UI.Page
{
    SqlConnection con;
    SqlCommand com;
    SqlDataAdapter da;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindRewardList();
            Bindlist();
        }
    }


    public void BindRewardList()
    {
        try
        {
            DataTable dt = new DataTable();
            con = new SqlConnection(method.str);
            da = new SqlDataAdapter(" select Fid,	Club from fundSlab where isactive=1", con);
            DataTable dtweight = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddl_Qualified.DataSource = dt;
                ddl_Qualified.DataTextField = "Club";
                ddl_Qualified.DataValueField = "Fid";
                ddl_Qualified.DataBind();
                ddl_Qualified.Items.Insert(0, new ListItem("All", "0"));
            }
             
        }
        catch
        {

        }
    }

    
    public void Bindlist()
    {
        try
        {
            
                con = new SqlConnection(method.str);
                com = new SqlCommand("GetRankList", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@Userid", txtuserid.Text.ToString());
                com.Parameters.AddWithValue("@per", ddlpercentage.SelectedValue.ToString());
                com.Parameters.AddWithValue("@Qualify", ddl_Qualified.SelectedValue.ToString());
                da = new SqlDataAdapter(com);
                dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    gridlist.DataSource = dt;
                    gridlist.DataBind();
                    lblMessage.Text = "No of Record(s): " + dt.Rows.Count;
                }
                else
                {
                    gridlist.DataSource = null;
                    gridlist.DataBind();
                    lblMessage.Text = string.Empty;

                }
        }
        catch
        {

        }

    }


    protected void btnSearchByDate_Click(object sender, EventArgs e)
    {
        Bindlist();
    }

    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {

            if (gridlist.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Reward.doc");
                Response.ContentType = "application/vnd.ms-word";
                StringWriter stw = new StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                gridlist.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();
            }
            else
            {
                utility.MessageBox(this, "Can't Export,No Data Found!");
            }
        }
        catch
        {

        }
    }
    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {

            if (gridlist.Rows.Count > 0)
            {
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Reward.xls");
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter stringWrite = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
                gridlist.RenderControl(htmlWrite);
                Response.Write(stringWrite.ToString());
                Response.End();
            }
            else
            {
                utility.MessageBox(this, "Can't Export,No Data Found!");
            }


        }
        catch
        {

        }

    }


}