using System.Web.UI;
using System.Data.SqlClient;
using System.Data;
using System;
using System.Web;
using System.Text;
using System.Web.UI.WebControls;

public partial class secretadmin_Date_Wise_Product_Stock :Page
{
    SqlConnection con;
    SqlDataAdapter da;
    DataTable dt;
    SqlCommand cmd;
    utility objUtil;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["admintype"]) == "sa")
            utility.CheckSuperAdminLogin();
        else if (Convert.ToString(Session["admintype"]) == "a")
            utility.CheckAdminLogin();
        else
            Response.Redirect("adminLog.aspx");


        if (!Page.IsPostBack)
        {
           
            txtToDate.Text = DateTime.Now.Date.ToString("dd/MM/yyyy").Replace("-", "/");
            bindgrid();
        }
    }

    public void bindgrid()
    {
        System.Globalization.DateTimeFormatInfo dateInfo = new System.Globalization.DateTimeFormatInfo();
        dateInfo.ShortDatePattern = "dd/MM/yyyy"; 
        DateTime toDate = new DateTime();
        try
        { 
            toDate = Convert.ToDateTime(txtToDate.Text.Trim(), dateInfo);
        }
        catch
        {
            utility.MessageBox(this, "Invalid Date!");
            return;
        }
        con = new SqlConnection(method.str);
        da = new SqlDataAdapter("GetDateWiseProductStock", con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.AddWithValue("@regno", txt_userid.Text.Trim());
        da.SelectCommand.Parameters.AddWithValue("@max", toDate);
        da.SelectCommand.Parameters.AddWithValue("@FranType", ddl_FranchiseType.SelectedValue);
        da.SelectCommand.Parameters.AddWithValue("@Active", ddl_Active.SelectedValue);
        dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            dt.Columns.Add("Total", typeof(decimal));
            foreach (DataRow row in dt.Rows)
            {
                decimal rowSum = 0;
                foreach (DataColumn col in dt.Columns)
                {
                    if (col.ToString() != "RNo" &&  col.ToString() != "Product" && col.ToString() != "ProductCode" && col.ToString() != "Category")
                    {
                        if (!row.IsNull(col))
                        {
                            string stringValue = row[col].ToString();
                            decimal d;
                            if (decimal.TryParse(stringValue, out d))
                                rowSum += d;
                        }
                    }
                }
                row.SetField("Total", rowSum);
            }

              
            DataView dtNew = new DataView(dt);
            dtNew.RowFilter = "Total>0";


            GridView1.DataSource = dtNew.ToTable();
            GridView1.DataBind();
             
            //GridView1.DataSource = dt;
            //GridView1.DataBind(); 
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }
   
    protected void btnSearchByDate_Click(object sender, EventArgs e)
    {
        bindgrid();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void imgbtnExcel_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            //bindgrid(); 
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_DateWiseProductStock.xls");
            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/vnd.xls";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            GridView1.RenderControl(htmlWrite);
            Response.Write(stringWrite.ToString());
            Response.End();
        }
        else
        {
            utility.MessageBox(this, "Can't export as no data found.");
        }
    }
    protected void imgbtnWord_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            GridView1.AllowPaging = false;
            //bindgrid(); 
            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("dd/MM/yyyy") + "_DateWiseProductStock.doc");
            Response.ContentType = "application/vnd.ms-word";
            System.IO.StringWriter stw = new System.IO.StringWriter();
            HtmlTextWriter htextw = new HtmlTextWriter(stw);
            this.GridView1.RenderControl(htextw);
            Response.Write(stw.ToString());
            Response.End();

        }
        else
            utility.MessageBox(this, "can not export as no data found !");
    }




    protected void imgbtnCsv_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=Product_Stock.csv");
        Response.Charset = "";
        Response.ContentType = "text/csv";

        //To Export all pages.
        GridView1.AllowPaging = false;
        //this.bindgrid();

        StringBuilder sb = new StringBuilder();
        foreach (TableCell cell in GridView1.HeaderRow.Cells)
        {
            //Append data with separator.
            sb.Append(cell.Text + ',');
        }
        //Append new line character.
        sb.Append("\r\n");

        foreach (GridViewRow row in GridView1.Rows)
        {
            foreach (TableCell cell in row.Cells)
            {
                //Append data with separator.
                sb.Append(cell.Text + ',');
            }
            //Append new line character.
            sb.Append("\r\n");
        }

        Response.Output.Write(sb.ToString());
        Response.Flush();
        Response.End();
    }
 
}