using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.Net;
using System.Text;
using System.Linq;

public partial class user_downstatus : System.Web.UI.Page
{
    static string UrlLink = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["userId"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        if (!IsPostBack)
        {
            HttpContext.Current.Session["Refdt"] = null;
            txtFromDate.Text = DateTime.Now.Date.AddDays(-1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy");

            Session["DownlineUser"] = null;
            Session["DownlineUser"] = Session["userId"].ToString();

            GetRank();
            // go();
        }

    }


    //public void go()
    //{
    //    try
    //    {
    //        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
    //        dateInfo.ShortDatePattern = "dd/MM/yyyy";
    //        DateTime fromDate = new DateTime();
    //        DateTime toDate = new DateTime();

    //        fromDate = Convert.ToDateTime(txtFromDate.Text.Trim(), dateInfo);
    //        toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);

    //        if (Convert.ToDateTime(fromDate) <= Convert.ToDateTime(toDate))
    //        {

    //            SqlParameter[] param = new SqlParameter[]
    //                {
    //                    new SqlParameter("@regno", Session["DownlineUser"] == null ? Session["userId"].ToString() : Session["DownlineUser"].ToString()),
    //                    new SqlParameter("@rank", ddl_Rank.SelectedValue),
    //                    new SqlParameter("@paid", ddlMemberType.SelectedItem.Value)
    //                };
    //            DataUtility objDu = new DataUtility();
    //            DataTable dt = objDu.GetDataTableSP(param, "DownlineReport2");
    //            if (dt.Rows.Count > 0)
    //            {
    //                GridView1.DataSource = dt;
    //                GridView1.DataBind();
    //                Label2.Text = " No of Records: " + dt.Rows.Count.ToString();
    //            }
    //            else
    //            {
    //                GridView1.DataSource = null;
    //                GridView1.DataBind();
    //                Label2.Text = string.Empty;
    //            }

    //        }
    //        else
    //        {
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //            utility.MessageBox(this, "Invalid Date");
    //        }
    //    }
    //    catch (Exception er)
    //    {

    //    }
    //}




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

    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}

    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        go();
    //        Response.Clear();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Downstatus.xls");
    //        Response.Charset = "";
    //        Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
    //        GridView1.RenderControl(htmlWrite);
    //        Response.Write(stringWrite.ToString());
    //        Response.End();
    //    }
    //    else
    //    {
    //        utility.MessageBox(this, "Can't export as no data found.");
    //    }
    //}


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


    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    try
    //    {
    //        if (e.CommandName == "STATUS")
    //        {
    //            GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //            string Regno = GridView1.DataKeys[row.RowIndex].Values[0].ToString();
    //            Session["DownlineUser"] = Regno;

    //            go();
    //        }
    //    }
    //    catch (Exception er) { }
    //}


    //protected void Button3_Click(object sender, EventArgs e)
    //{
    //    if (txt_Userid.Text != "")
    //    {
    //        SqlParameter[] param = new SqlParameter[]
    //        {
    //          new SqlParameter("@Userid", Session["userId"].ToString()),
    //          new SqlParameter("@Downline", txt_Userid.Text.Trim())
    //        };
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTable(param, @"Select Srno from AppTran Where 
    //        Parentid=(Select Appmstid from Appmst Where AppmstRegno=@Userid) and 
    //        appmstid = (Select Appmstid from Appmst Where AppmstRegno = @Downline)");
    //        if (dt.Rows.Count > 0)
    //        {
    //            Session["DownlineUser"] = txt_Userid.Text.Trim();
    //            txt_Userid.Text = "";
    //            ddl_Rank.SelectedValue = "0";
    //        }
    //        else
    //        {
    //            utility.MessageBox(this, "This user not in your downline.!!");
    //            txt_Userid.Text = "";
    //        }
    //    }
    //    //go();
    //}

    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    Session["DownlineUser"] = Session["userId"].ToString();
    //    // go();
    //}
    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    go();
    //}


    #region Binary Downline
    [System.Web.Services.WebMethod]
    public static BinaryDownline[] BindBinary(string rank, string paid, string Userid)
    {
        List<BinaryDownline> details = new List<BinaryDownline>();
        DataUtility objDu = new DataUtility();
        try
        {
            string regno = "";
            if (HttpContext.Current.Session["DownlineUser"] == null)
                regno = HttpContext.Current.Session["userId"].ToString();
            else
                regno = HttpContext.Current.Session["DownlineUser"].ToString();

            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@regno", regno),
                   new SqlParameter("@rank", rank),
                   new SqlParameter("@paid", paid)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "DownlineReport2");
            while (dr.Read())
            {
                BinaryDownline data = new BinaryDownline();
                data.Img_Name = dr["Img_Name"].ToString();
                data.status = dr["status"].ToString();
                data.UserName = dr["UserName"].ToString();
                data.UserId = dr["UserId"].ToString();
                data.Position = dr["Position"].ToString();
                data.JoinFor = dr["JoinFor"].ToString();
                data.TotalLeft = dr["TotalLeft"].ToString();
                data.TotalRight = dr["TotalRight"].ToString();
                data.carryleft = dr["carryleft"].ToString();
                data.carryright = dr["carryright"].ToString();
                data.Pairrank = dr["Pairrank"].ToString();
                data.NewMatching = dr["NewMatching"].ToString();
                data.RankName = dr["RankName"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    [System.Web.Services.WebMethod]
    public static string SetUserid(string Userid, string Type)
    {
        string Msg = "";
        if (Type == "Status")
        {
            HttpContext.Current.Session["DownlineUser"] = Userid;
        }
        else if (Type == "GOUP")
        {
            HttpContext.Current.Session["DownlineUser"] = HttpContext.Current.Session["userId"].ToString();
        }
        else if(Type == "Downline")
        {
            if (Userid != "")
            {

                SqlParameter[] param = new SqlParameter[]
               {
                    new SqlParameter("@Userid", HttpContext.Current.Session["userId"].ToString()),
                    new SqlParameter("@Downline", Userid)
               };
                DataUtility objDu = new DataUtility();
                DataTable dt = objDu.GetDataTableSP(param, "IsChildExistsParent");
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["Msg"].ToString() == "1")
                    {
                        HttpContext.Current.Session["DownlineUser"] = Userid; 
                    }
                    else
                    {
                        Msg = "This user not in your downline.!!";
                    }
                } 
            } 
        }
        StoreUser(Userid);
        return Msg;
    }



    [System.Web.Services.WebMethod]
    public static StoreUserid[] StoreUser(string Userid)
    {
        List<StoreUserid> details = new List<StoreUserid>();
        try
        {
            if (HttpContext.Current.Session["Refdt"] == null)
                CreateStucture();

            DataTable Refdt = (DataTable)HttpContext.Current.Session["Refdt"];

            if (Userid != "")
            {
                int Sno = 1;
                if (Refdt.Select("Userid='" + Userid + "'").FirstOrDefault() == null)
                {
                    if (Refdt.Rows.Count > 0)
                        Sno = 1 + Convert.ToInt32(Refdt.AsEnumerable().Max(row => row["Sno"]));

                    DataRow dr = Refdt.NewRow();

                    dr["Sno"] = Sno;
                    dr["Userid"] = Userid;

                    Refdt.Rows.Add(dr);
                    HttpContext.Current.Session["Refdt"] = Refdt;
                }
                else
                {
                    DataRow findrow = Refdt.Select("Userid='" + Userid + "'").FirstOrDefault();
                    Sno = findrow == null ? 0 : findrow.Field<int>("Sno");

                    DataTable newTable = Refdt.Copy();

                    foreach (DataRow dr in newTable.Rows)
                    {
                        if (Convert.ToInt32(dr["Sno"].ToString()) > Sno)
                        {
                            DataRow findNewrow = Refdt.Select("Sno='" + dr["Sno"].ToString() + "'").FirstOrDefault();
                            findNewrow.Delete();
                        }
                    }
                    HttpContext.Current.Session["Refdt"] = Refdt;
                }
            }


            DataView view = Refdt.DefaultView;
            view.Sort = "Sno Asc";
            DataTable dt_Sorted = view.ToTable();

            foreach (DataRow dr in dt_Sorted.Rows)
            {
                if (!string.IsNullOrEmpty(dr["Userid"].ToString()))
                {
                    StoreUserid data = new StoreUserid();
                    data.Userid = dr["Userid"].ToString();
                    details.Add(data);
                }
            }
        }

        catch (Exception er) { }
        return details.ToArray();
    }

    public class StoreUserid
    {
        public string Userid { get; set; }
    }

    private static void CreateStucture()
    {
        DataTable dtStuc = new DataTable();
        dtStuc.Columns.Add(new DataColumn("Sno", typeof(int)));
        dtStuc.Columns.Add(new DataColumn("Userid", typeof(string)));
        HttpContext.Current.Session["Refdt"] = dtStuc;
    }


    public class BinaryDownline
    {
        public string Img_Name { get; set; }
        public string status { get; set; }
        public string UserName { get; set; }
        public string UserId { get; set; }
        public string Position { get; set; }
        public string JoinFor { get; set; }
        public string TotalLeft { get; set; }
        public string TotalRight { get; set; }
        public string carryleft { get; set; }
        public string carryright { get; set; }
        public string Pairrank { get; set; }
        public string NewMatching { get; set; }
        public string RankName { get; set; }
    }

    #endregion


}
