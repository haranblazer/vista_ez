using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Text;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;

public partial class secretadmin_BelowPayout : System.Web.UI.Page
{
    int index;
    SqlConnection con = new SqlConnection(method.str);
    SqlDataAdapter da;
    utility objUtil = new utility();
    int joinTotal1 = 0;
    int joinTotal2 = 0; int joinTotal3 = 0; int joinTotal4 = 0; int joinTotal5 = 0;
    protected void Page_Load(object sender, EventArgs e)
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
        if (!IsPostBack)
        {
            go();
        }
    }

    public void go()
    {
        //  da = new SqlDataAdapter("select distinct paymentfromdate=convert(char(10),paymentfromdate,103),paymenttodate=convert(char(10),paymenttodate,103),payoutno from paymenttrandraft order by Payoutno desc", con);
        da = new SqlDataAdapter("pendingpayout", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@type", "1");
        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            ddlDateRange.Items.Clear();
            ddlDateRange.DataSource = dt;
            ddlDateRange.DataTextField = "pname";
            ddlDateRange.DataValueField = "payoutno";
            ddlDateRange.DataBind();
            //ddlDateRange.Items.Insert(0,new System.Web.UI.WebControls.ListItem("select","0"));
            getList();
            //for (int i = 0; i < dt.Rows.Count; i++)
            //{
            //    ddlDateRange.Items.Add(dt.Rows[i]["paymentfromdate"].ToString() + "-" + dt.Rows[i]["paymenttodate"].ToString() + "(" + dt.Rows[i]["payoutno"].ToString() + ")");
            //}

        }
        else
        {

        }
    }

    public void getList()
    {

        index = Convert.ToInt32(ddlDateRange.SelectedValue.ToString());

        da = new SqlDataAdapter("pendingpayout", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@payoutno", index);
        da.SelectCommand.Parameters.AddWithValue("@type", "2");

        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            dgList.DataSource = dt;
            dgList.DataBind();
            DwnWordExcel.Visible = true;
        }
        else
        {
            dgList.DataSource = null;
            dgList.DataBind();
            DwnWordExcel.Visible = false;
        }
    }



    protected void dgList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dgList.PageIndex = e.NewPageIndex;
        getList();
    }

    protected void ddlDateRange_SelectedIndexChanged(object sender, EventArgs e)
    {

        getList();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }


    protected void ibtnExcelExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (dgList.Rows.Count > 0)
            {

                dgList.AllowPaging = false;
                getList();
                Response.Clear();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_BelowPatout.xls");
                Response.Charset = "";
                Response.ContentType = "application/vnd.xls";
                System.IO.StringWriter stringWrite = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
                dgList.RenderControl(htmlWrite);
                Response.Write(stringWrite.ToString());
                Response.End();
            }
            else
            {
                utility.MessageBox(this, "Can't Export,No Data Found!");
                return;
            }
        }
        catch
        {

        }

    }


    protected void ibtnWordExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (dgList.Rows.Count > 0)
            {

                dgList.AllowPaging = false;
                getList();
                Response.ClearContent();
                Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_BelowPatout.doc");
                Response.ContentType = "application/vnd.ms-word";
                StringWriter stw = new StringWriter();
                HtmlTextWriter htextw = new HtmlTextWriter(stw);
                dgList.RenderControl(htextw);
                Response.Write(stw.ToString());
                Response.End();
            }
            else
            {
                utility.MessageBox(this, "Can't Export,No Data Found!");
                return;
            }
        }
        catch
        {

        }
    }
}