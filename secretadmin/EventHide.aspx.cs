using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_EventHide : System.Web.UI.Page
{

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
            BindUserList();
        }
    }

    public void BindUserList()
    {
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Userid", txtUserid.Text.Trim()),
                new SqlParameter("@IsHideDiamond", -1),
                new SqlParameter("@IsHideTour", -1),
                new SqlParameter("@IsHideOffer", -1),
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "GetAddNewEvent");
            if (dt.Rows.Count > 0)
            {
                dglst.DataSource = dt;
                dglst.DataBind();
            }
            else
            {
                dglst.DataSource = null;
                dglst.DataBind();
            }
        }
        catch (Exception er)
        {
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindUserList();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@Userid", txtUserid.Text.Trim()),
                new SqlParameter("@IsHideDiamond", -1),
                new SqlParameter("@IsHideTour", -1),
                new SqlParameter("@IsHideOffer", -1),
            };
            DataUtility objDu = new DataUtility();
            DataTable dt = objDu.GetDataTableSP(param, "sp_AddNewEvent");
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Error"].ToString() == "1")
                {
                    BindUserList();
                }
                else
                {
                    utility.MessageBox(this, dt.Rows[0]["Error"].ToString());
                }
            }
        }
        catch (Exception er) { }
    }
    protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        dglst.PageIndex = e.NewPageIndex;
        BindUserList();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    private static Random random = new Random();

    protected void dglst_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = dglst.Rows[Convert.ToInt32(e.CommandArgument)];
        if (e.CommandName.Equals("Diamond"))
        { 
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("update tbl_UserHideEvent set IsHideDiamond=(Case when isnull(IsHideDiamond,0)=0 then 1 else 0 end) where Appmstid=@Appmstid", con);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 99999;
            cmd.Parameters.AddWithValue("@Appmstid", dglst.DataKeys[row.RowIndex].Values[0].ToString());
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            BindUserList();
        }
        if (e.CommandName.Equals("Tour"))
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("update tbl_UserHideEvent set IsHideTour=(Case when isnull(IsHideTour,0)=0 then 1 else 0 end) where Appmstid=@Appmstid", con);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 99999;
            cmd.Parameters.AddWithValue("@Appmstid", dglst.DataKeys[row.RowIndex].Values[0].ToString());
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            BindUserList();
        }
        if (e.CommandName.Equals("Offer"))
        {
            SqlConnection con = new SqlConnection(method.str);
            SqlCommand cmd = new SqlCommand("update tbl_UserHideEvent set IsHideOffer=(Case when isnull(IsHideOffer,0)=0 then 1 else 0 end) where Appmstid=@Appmstid", con);
            cmd.CommandType = CommandType.Text;
            cmd.CommandTimeout = 99999;
            cmd.Parameters.AddWithValue("@Appmstid", dglst.DataKeys[row.RowIndex].Values[0].ToString());
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            BindUserList();
        }

    }


    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (dglst.Rows.Count > 0)
        {
            dglst.AllowPaging = false;
            BindUserList();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_paidlist.xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            dglst.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }

}