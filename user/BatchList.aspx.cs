using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class secretadmin_BatchList : System.Web.UI.Page
{

    SqlConnection con = null;
    DataTable dt = null;
    SqlCommand cmd = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindproduct();
        }
    }

    #region Bind Table
    [System.Web.Services.WebMethod]
    public static UserDetails[] BindTable(string pid)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objDu = new DataUtility();
        try
        {
            SqlParameter[] param = new SqlParameter[]
            {
                   new SqlParameter("@pid", pid)
            };
            SqlDataReader dr = objDu.GetDataReaderSP(param, "GetProductListUser");
            while (dr.Read())
            {
                UserDetails data = new UserDetails();
                data.ImageName = dr["ImageName"].ToString();
                data.ProductCode = dr["ProductCode"].ToString();
                data.productname = dr["productname"].ToString();
                data.MRP = dr["MRP"].ToString();
                data.DPWithTax = dr["DPWithTax"].ToString();
                data.pbvamt = dr["pbvamt"].ToString();
                data.BVAmt = dr["BVAmt"].ToString();
                details.Add(data);
            }
        }
        catch (Exception er) { }
        return details.ToArray();
    }


    public class UserDetails
    {
        public string ImageName { get; set; }
        public string ProductCode { get; set; }
        public string productname { get; set; }
        public string MRP { get; set; }
        public string DPWithTax { get; set; }
        public string pbvamt { get; set; }
        public string BVAmt { get; set; }
    }

    #endregion


    //protected void ddlproductname_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    gridbind();
    //}

    //public void gridbind()
    //{
    //    string pid = ddlproductname.SelectedValue.ToString();
    //    con = new SqlConnection(method.str);
    //    cmd = new SqlCommand("GetProductListUser", con);
    //    cmd.Parameters.AddWithValue("@pid", pid);
    //    con.Open();
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    dglst.DataSource = cmd.ExecuteReader();
    //    dglst.DataBind();
    //    con.Close();
    //}


    public void bindproduct()
    {
        con = new SqlConnection(method.str);
        cmd = new SqlCommand("UpdateProductQty", con);
        cmd.Parameters.AddWithValue("@action", "bindproduct");
        cmd.Parameters.Add("@flag", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        ddlproductname.Items.Clear();
        ddlproductname.DataTextField = "productname";
        ddlproductname.DataValueField = "productid";
        ddlproductname.DataSource = cmd.ExecuteReader();
        ddlproductname.DataBind();

        ddlproductname.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All Product", "0"));
        con.Close();

    }


    //protected void imgbtnWord_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dglst.Rows.Count > 0)
    //    {
    //        dglst.AllowPaging = false;
    //        gridbind();
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Batchlist.doc");
    //        Response.ContentType = "application/vnd.ms-word";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        dglst.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}


    //protected void imgbtnExcel_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (dglst.Rows.Count > 0)
    //    {
    //        dglst.AllowPaging = false;
    //       // dglst.Columns[12].Visible = false;
    //        gridbind();
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_Batchlist.xls");
    //        Response.ContentType = "application/vnd.xls";
    //        System.IO.StringWriter stw = new System.IO.StringWriter();
    //        HtmlTextWriter htextw = new HtmlTextWriter(stw);
    //        dglst.RenderControl(htextw);
    //        Response.Write(stw.ToString());
    //        Response.End();

    //    }
    //    else
    //        utility.MessageBox(this, "can not export as no data found !");
    //}


}