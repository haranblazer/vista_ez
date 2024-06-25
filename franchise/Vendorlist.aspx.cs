using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class secretadmin_Vendor_list : System.Web.UI.Page
{
    //SqlConnection con = new SqlConnection(method.str);
    //SqlCommand cmd = null;
    //SqlDataAdapter da;
    //DataTable dt;
    ////utility objutil = new utility();
    //string vid = null;
    //utility obj = new utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["franchiseid"] == null)
        {
            Response.Redirect("Logout.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                BindVendor();
            }
        }
    }


    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string Search)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[] {
                 new SqlParameter("@MasterKey","GET-VENDOR-LIST-DETAILS"),
                 new SqlParameter("@Search", Search)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetVendorLsit");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                utility objutil = new utility();
                data.VID_Encode = objutil.base64Encode(dr["VID"].ToString());
                data.V_regNo = dr["V_regNo"].ToString();
                data.ComName = dr["ComName"].ToString();
                data.DisplayName = dr["DisplayName"].ToString();
                data.V_Email = dr["V_Email"].ToString();
                data.Phone = dr["Phone"].ToString();
                data.vendoraddress = dr["vendoraddress"].ToString();
                data.GSTNAME = dr["GSTNAME"].ToString();
                data.PAYABLES = dr["PAYABLES"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string VID_Encode { get; set; }
        public string V_regNo { get; set; }
        public string ComName { get; set; }
        public string DisplayName { get; set; }
        public string V_Email { get; set; }
        public string Phone { get; set; }
        public string vendoraddress { get; set; }
        public string GSTNAME { get; set; }
        public string PAYABLES { get; set; }
    }

    #endregion


    //public void BindVendorList()
    //{
    //    SqlParameter[] param = new SqlParameter[] {
    //     new SqlParameter("@MasterKey","GET-VENDOR-LIST-DETAILS"),
    //     new SqlParameter("@Search", txtSearch.Text.Trim())
    //    };
    //    DataUtility objDu = new DataUtility();
    //    DataTable dt = objDu.GetDataTableSP(param, "GetVendorLsit");
    //    if (dt.Rows.Count > 0)
    //    {
    //        GridView1.DataSource = dt;
    //        GridView1.DataBind();
    //    }
    //    else
    //    {
    //        GridView1.DataSource = null;
    //        GridView1.DataBind();
    //    }
    //}

    //protected void btnUserSearch_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        cmd = new SqlCommand("SearchByVendorNameOrID", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@VendorName", txtSearch.Text.Trim());
    //        da = new SqlDataAdapter(cmd);
    //        dt = new DataTable();
    //        da.Fill(dt);
    //        if (dt.Rows.Count > 0)
    //        {
    //            GridView1.DataSource = dt;
    //            GridView1.DataBind();
    //        }
    //        else
    //        {
    //            GridView1.DataSource = null;
    //            GridView1.DataBind();
    //        }
    //    }
    //    catch(Exception ex)
    //    {

    //    }
    //}


    //public override void VerifyRenderingInServerForm(Control control)
    //{

    //}

    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //       // GridView1.Columns[12].Visible = false;
    //        BindVendorList();
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Batchlist.xls");
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        GridView1.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}

    //protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName != "Page")
    //    {
    //        GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
    //        ViewState["vid"] = vid = GridView1.DataKeys[row.RowIndex].Value.ToString();
    //        if (e.CommandName.Equals("Edit"))
    //        {
    //            Response.Redirect("AddVendor.aspx?n=" + obj.base64Encode(vid));
    //        }

    //    }
    //}

    //protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView1.PageIndex = e.NewPageIndex;
    //    BindVendorList();
    //}

    //protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    //{

    //}

    //protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (GridView1.Rows.Count > 0)
    //    {
    //        GridView1.AllowPaging = false;
    //        BindVendorList();
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Batchlist.doc");
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        GridView1.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}

    public void BindVendor()
    {
        DataUtility objDu = new DataUtility();
        DataTable dt = objDu.GetDataTable("Select V_regno, DisplayName from VendorMst");
        foreach (DataRow dr in dt.Rows)
        {
            divProductcode.InnerText += dr["V_regno"].ToString() + "," + dr["DisplayName"].ToString() + ",";
        }
    }


}