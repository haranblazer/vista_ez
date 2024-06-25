using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;


public partial class user_downstatus : System.Web.UI.Page
{
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
                txtFromDate.Text = DateTime.Now.Date.AddDays(-1).ToString("dd/MM/yyyy");
                txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

                GetRank();
            }
        }
        catch
        {

        }

    }


    public void go()
    {
        try
        {
            System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
            dateInfo.ShortDatePattern = "dd/MM/yyyy";
            DateTime fromDate = new DateTime();
            DateTime toDate = new DateTime();

            fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);

            if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
            {

                SqlParameter[] param = new SqlParameter[]
                    {
                        new SqlParameter("@regno", Session["DownlineUser"].ToString()),
                        new SqlParameter("@rank", ddl_Rank.SelectedValue),
                        new SqlParameter("@paid", ddlMemberType.SelectedItem.Value),
                        new SqlParameter("@UpDown", ddl_UpDown.SelectedValue)
                    };
                DataUtility objDu = new DataUtility();
                DataTable dt = objDu.GetDataTableSP(param, "DownlineReport2");
                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    Label2.Text = " No of Records: " + dt.Rows.Count.ToString();

                    SqlParameter[] paramNew = new SqlParameter[]
                    {
                        new SqlParameter("@Userid", Session["DownlineUser"].ToString())
                    };

                    DataTable dtNew = objDu.GetDataTableSP(paramNew, "Get_Extereme_L_R");
                    if (dtNew.Rows.Count > 0)
                    {
                        lbl_Left.Text = "E L ID: " + dtNew.Rows[0]["LeftUser"].ToString();
                        lbl_Right.Text = "E R ID: " + dtNew.Rows[0]["RightUser"].ToString();
                    }
                }
                else
                {
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                    Label2.Text = string.Empty;
                }
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                utility.MessageBox(this, "Invalid Date");
            }
        }
        catch (Exception er)
        {

        }
    }


    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        go();
    }

    private void GetRank()
    {
        DataUtility objDu = new DataUtility();

        DataTable dt = objDu.GetDataTable("Select LevelId, RankName  from BinarySlab order by LevelId");
        ddl_Rank.Items.Clear();
        if (dt.Rows.Count > 0)
        {
            ddl_Rank.DataSource = dt;
            ddl_Rank.DataTextField = "RankName";
            ddl_Rank.DataValueField = "LevelId";
            ddl_Rank.DataBind();
            ddl_Rank.Items.Insert(0, new ListItem("Direct", "0"));
        }
        else
        {
            ddl_Rank.Items.Insert(0, new ListItem("Direct", "0"));
        }

    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            go();
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Downstatus.xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }


    //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        LinkButton btn_Status = ((LinkButton)e.Row.FindControl("btn_Status"));
    //        HiddenField hnf_Status = ((HiddenField)e.Row.FindControl("hnf_Status"));
    //        if (hnf_Status.Value == "1")
    //        {
    //            btn_Status.ForeColor = System.Drawing.Color.White;
    //            btn_Status.Enabled = true;
    //        }
    //        else
    //        {
    //            btn_Status.Text = "Own status";
    //            btn_Status.ForeColor = System.Drawing.Color.White;
    //            btn_Status.Enabled = false;
    //        }
    //    }
    //}


    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "STATUS")
            {
                GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
                string Regno = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
                Session["DownlineUser"] = Regno;
                txt_Userid.Text = Regno;
                go();
            }
        }
        catch (Exception er) { }
    }


    protected void Button3_Click(object sender, EventArgs e)
    {
        if (txt_Userid.Text != "")
        {
            Session["DownlineUser"] = txt_Userid.Text.Trim();
            go();
        }
        else
        {
            utility.MessageBox(this, "Please Enter UserId.!!");
            return;
        }
    }

}
