using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_MonthlyRoyalty : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("loginagain.aspx", false);
        }
        if (!IsPostBack)
        { 
            Bind_Month();
        }
    }



    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string Months)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@Userid", HttpContext.Current.Session["userId"].ToString()),
                   new SqlParameter("@Months", Months),
                   new SqlParameter("@RoyaltyType", "")
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetMonthly_Purchase_Loyalty");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.Appmstregno = dr["Appmstregno"].ToString();
                data.Appmstfname = dr["Appmstfname"].ToString();
                data.InvoiceNo = dr["InvoiceNo"].ToString();
                data.Amount = dr["Amount"].ToString();
                data.Status = dr["Status"].ToString();
                data.Doe = dr["Doe"].ToString();
                data.RoyaltyStatus = dr["RoyaltyStatus"].ToString();
                 data.RStatus = dr["RStatus"].ToString(); 
                data.RoyaltyType = dr["RoyaltyType"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string Appmstregno { get; set; }
        public string Appmstfname { get; set; }
        public string InvoiceNo { get; set; }
        public string Amount { get; set; }
        public string Status { get; set; }
        public string Doe { get; set; }
        public string RStatus { get; set; }
        public string RoyaltyStatus { get; set; }
        public string RoyaltyType { get; set; }
    }

    #endregion



    //public void show()
    //{
    //    try
    //    {
    //        SqlParameter[] param = new SqlParameter[]
    //        {
    //          new SqlParameter("@Userid", Session["userId"].ToString()),
    //          new SqlParameter("@Months", ddl_Month.SelectedValue),
    //          new SqlParameter("@RoyaltyType", ""),
    //        };
    //        DataUtility objDu = new DataUtility();
    //        DataTable dt = objDu.GetDataTableSP(param, "GetMonthly_Purchase_Loyalty");

    //        if (dt.Rows.Count > 0)
    //        {
    //            dglst.DataSource = dt;
    //            dglst.DataBind();
    //        }
    //        else
    //        {
    //            dglst.DataSource = null;
    //            dglst.DataBind();
    //        }
    //    }
    //    catch (Exception er) { }
    //}


    private void Bind_Month()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable(@"Select Distinct [Month]=Cast(DateName(Month, Doe) as nvarchar(3)) + '-' + RIGHT(DateName(Year, Doe),2)  from Monthly_Purchase_Loyalty");
        if (dt.Rows.Count > 0)
        {
            ddl_Month.DataSource = dt;
            ddl_Month.DataTextField = "Month";
            ddl_Month.DataValueField = "Month";
            ddl_Month.DataBind();
            ddl_Month.Items.Insert(0, new ListItem("All", ""));
        }
        else
        {
            ddl_Month.Items.Clear();
            ddl_Month.Items.Insert(0, new ListItem("All", ""));
        }
    }



    //protected void dglst_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    dglst.PageIndex = e.NewPageIndex;
    //    show();
    //}

    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    show();
    //}
    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}

    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dglst.Rows.Count > 0)
    //    {
    //        dglst.AllowPaging = false;
    //        show();
    //        dglst.HeaderRow.BackColor = System.Drawing.Color.White;
    //        foreach (GridViewRow row in dglst.Rows)
    //        {
    //            row.BackColor = System.Drawing.Color.White;

    //        }

    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Monthly_Purchase_Loyalty.xls");
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        this.dglst.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}
    //protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dglst.Rows.Count > 0)
    //    {
    //        dglst.AllowPaging = false;
    //        show();
    //        dglst.HeaderRow.BackColor = System.Drawing.Color.White;
    //        foreach (GridViewRow row in dglst.Rows)
    //        {
    //            row.BackColor = System.Drawing.Color.White;

    //        }
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Monthly_Purchase_Loyalty.doc");
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        this.dglst.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}
}